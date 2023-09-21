Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAAAE7D0B4
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 23:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjIUXgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 19:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIUXgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 19:36:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8C8F
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 16:36:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF2CD20773;
        Thu, 21 Sep 2023 19:36:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=zlepGORH4JgGSDJsxPXjF4HXIgKIAl9/c7XV3u
        oUeoA=; b=kEKF5SKLXyr1TQkmKdiKB20sTpR/MCCumLmQkbVp2x0Kmuq1diBX/q
        FHA1Z7eVXd/SYBeHbfFTKUeNqrBJO+yo7H+chHyzCxiNGUioJj21qq7TzaTAsN6J
        NpOln3P/IeRjD07D/A3+DyHSaZ0t9fxg0Be86Wka0b+hFdnKxGTVc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7FD520772;
        Thu, 21 Sep 2023 19:36:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7ACC120771;
        Thu, 21 Sep 2023 19:36:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        calvinwan@google.com, glencbz@gmail.com
Subject: Re: [PATCH v2 2/4] config: report config parse errors using cb
In-Reply-To: <ZQyxmq7HB12/+YYv@google.com> (Josh Steadmon's message of "Thu,
        21 Sep 2023 14:11:54 -0700")
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
        <cover.1692827403.git.steadmon@google.com>
        <cb92a1f2e3098bede386d04da32fcc4f27fca51f.1692827403.git.steadmon@google.com>
        <xmqqttspck4a.fsf@gitster.g> <ZQyxmq7HB12/+YYv@google.com>
Date:   Thu, 21 Sep 2023 16:36:36 -0700
Message-ID: <xmqqh6nn3xq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B52225A6-58D7-11EE-A48C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> As Jonathan Tan mentioned in [1], on calling do_event() we set the start
> offset of the new event, and execute the callback for the previous event
> whose end offset we now know.
>
> I refactored this into "start_event()" and "flush_event()" functions as
> suggested, and added a new "do_event_and_flush()" function for the case
> where we want to immediately execute a callback for an event.

Very nicely done.  Thanks, both.
