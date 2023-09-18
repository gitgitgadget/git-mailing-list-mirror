Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40668CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjIRQk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjIRQj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:39:57 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0DC86AD
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:36:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23BD023CE4;
        Mon, 18 Sep 2023 12:36:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TUPWnk+mVCxNLbYowsOu07A06KjvN5ybJs84ds
        0eHUg=; b=xSu6N6lpDxNOOZ7GQGSapW9HJ2sOOpIESqKW9uWIBG7WvZOaxIbZh9
        3IaxLjfn+2B4+3hXX4tf5SGidznUVxtmaBJ87RcUbFMMtB0oWB92rhN4ILc+6e//
        p/AonY8x1r6U9ArAV6gCLo2WwrbFtNVqEqs6jUPZT33rqtVqYIjtw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C30423CE3;
        Mon, 18 Sep 2023 12:36:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 881F523CDF;
        Mon, 18 Sep 2023 12:36:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v3] diff-lib: Fix check_removed when fsmonitor is on
In-Reply-To: <CAJiyOiidpD5eNvxVV8rZP7Xej4_8bBfgTOG75T8PVsmvwya3hg@mail.gmail.com>
        (Josip Sokcevic's message of "Thu, 14 Sep 2023 15:39:13 -0700")
References: <20230906060241.944886-2-sokcevic@google.com>
        <20230911170901.49050-2-sokcevic@google.com>
        <xmqqsf7ks4nn.fsf@gitster.g>
        <CAJiyOijMvqK184wFgoXFyX5kmURkX3k2OmuiBpArikj26iHpMA@mail.gmail.com>
        <xmqqfs3jpbg2.fsf@gitster.g>
        <CAJiyOiidpD5eNvxVV8rZP7Xej4_8bBfgTOG75T8PVsmvwya3hg@mail.gmail.com>
Date:   Mon, 18 Sep 2023 09:35:58 -0700
Message-ID: <xmqqy1h3l9qp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7380DDCE-5641-11EE-B025-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:

> I see you created a new set of patches in a separate thread, so I'll
> start those tests and report back there.

Thanks.
