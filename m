Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB5AC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 23:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E28A2051A
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 23:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZYyFaCgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgCOX7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 19:59:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61362 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgCOX7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 19:59:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FA62C71AE;
        Sun, 15 Mar 2020 19:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4vS6HGYNn8kWjoF0rDT4IrLpe8k=; b=ZYyFaC
        gn+ZT3qkDhPkR2OObyBXEPxZJc2dp5/qSALrq01xZN6kXLFvwA6736Aemh8iXnm8
        UTQZcbw/+ZNGHcOvZvD/qNuIxvw2mrAxuT7jt5xiF2/GNACfUtfeKmTapqzoOzAL
        V7U4dbD92Od6BmfI0XWV6HDwyJDpBXbYRfGIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TDoRUVdWmFn5z+LvFLAYSMbOjgnl1JP9
        7RQl3PddgoXMboVyZ1unMbBCm3KsMNr+RBR3zz/Xfp5FVC/D38oetAse5isb13cm
        JJRTcKdFn9BVu2/xSkwfeQgVieDvYIdd7k5XkKQdUlLrqzTjx9F3d2wgS0Zo2FsY
        kugbMBID+xU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56DEBC71AD;
        Sun, 15 Mar 2020 19:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3161C71AC;
        Sun, 15 Mar 2020 19:59:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Universal progress option (was Re: [PATCH] clone: use --quiet when stderr is not a terminal)
References: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
        <xmqqh7yqc16w.fsf@gitster.c.googlers.com>
        <a044478f-ca04-3475-90de-0332e80f552d@gmail.com>
        <310a176a-1b30-a479-638e-33a51fb2c896@gmail.com>
        <xmqqk13l9zmf.fsf@gitster.c.googlers.com>
Date:   Sun, 15 Mar 2020 16:59:48 -0700
In-Reply-To: <xmqqk13l9zmf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 15 Mar 2020 12:39:20 -0700")
Message-ID: <xmqq5zf59nkb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E1CF000-6719-11EA-B4D9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If the parser that kicks in before the commands do their own parsing
> needs to know that much to correctly understand "--progress" anyway,
> wouldn't the same amount of effort would allow us to teach these
> individual commands to understand "--progress" and pass it correctly
> down to the underlying helpers?
>
> So, "git clone --no-progress" that lets checkout progress may be a
> bug worth fixing, but I do not think a global switch is a good way
> forward.

You can sort-of work it around by introducing "--[no-]progress" that
is taken as an option to the "git" command, just like "--[no-]pager"
is, to work around the issue above.  But I have a feeling that you
did not like the resulting UI, which is totally backward incompatible
and break users' existing scripts and habits.

The resulting UI built around "git --[no-]progress subcmd" may feel
much nicer, and I suspect that it would be something we would have
picked, if we had today's experience back when we started adding
progress display to individual subcommands.

As long as a clear transition path can be drawn, I do not
necessarily object to such a direction that (1) introduces the
global level "git --[no-]progress $subcmd" option, and (2)
deprecates and eventually removes the "--progress" option at the
subcommand level.
