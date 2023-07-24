Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1C0C0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 18:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGXSbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGXSa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 14:30:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B010E5
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 11:30:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 007941A636E;
        Mon, 24 Jul 2023 14:30:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DC4boHFgt6vlWf/u0irCve01mi80G+pjExINjg
        mIvgI=; b=qn3zGSroJzO9uXiaK46IFtPJCngUGp/NO1TQXOtpxQlLtCdSt1DB4N
        dvFUOtkWxiCe/YNP1j9HdlIi9AXxEtcqfNTqOYjMojPvHGe7oQI+znmbwe/eDPps
        UAIMYVLfr4ErRdmtlK3DwH/I5QcrQsJ2zgP1W03Yu1x3VIce7IsmE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC1141A636D;
        Mon, 24 Jul 2023 14:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6311D1A636B;
        Mon, 24 Jul 2023 14:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/1] sequencer: finish parsing the todo list despite
 an invalid first line
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
        <20230722212830.132135-1-alexhenrie24@gmail.com>
        <20230722212830.132135-2-alexhenrie24@gmail.com>
        <xmqqjzupqn3q.fsf@gitster.g>
Date:   Mon, 24 Jul 2023 11:30:52 -0700
In-Reply-To: <xmqqjzupqn3q.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        24 Jul 2023 09:40:41 -0700")
Message-ID: <xmqqedkxp3fn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38D432EC-2A50-11EE-A7A8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The structure of this new test piece, including the use of "log -1
> --format", seems to follow existing tests, and very readable.  Why
> do we have one extra level of subshell, though?  There is no "cd"
> that may affect the later test pieces, and set_something_editor that
> touches environment that may affect the later test pieces is called
> in its own subshell already.
>
> Other than that, looking good (there may be a valid reason why the
> test piece needs the subshell around it, but it was just not apparent
> to me).

Ah, now I notice that Phillip also noticed the same thing.

I just removed the outer subshell while queuing.  Thanks for working
on this, and thanks Phillip for excellent reviews.

