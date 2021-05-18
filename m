Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B7CC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B5561263
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhERCNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 22:13:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50207 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbhERCN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 22:13:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 141481208A0;
        Mon, 17 May 2021 22:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7CnE+Kcthxewphk+uv4/IGkymjEhiXe+VV7XaQ
        GwNYI=; b=PIP16ft6FVifOxekuye82fSU485DZ32AFHBCAu75C7Jr3wBQGWoVk/
        dFwRwvGaTF+OeNTYGLWQBI6TeUsjKSSc+qpN98wISYWyUR0p1ldjaKodRNNXCZYh
        KdoLmLnPZffXezgfwWXlgL8/pRTdMnj6ONXLwcdyhVNXWYMV7wzCs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D68612089B;
        Mon, 17 May 2021 22:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 589AE120897;
        Mon, 17 May 2021 22:12:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: Man pages have colors? A deep dive into groff
References: <60a046bd83001_f4b0f20861@natae.notmuch>
        <87tun1qp91.fsf@evledraar.gmail.com>
        <YKMYUUVVVJMWH7xi@camp.crustytoothpaste.net>
Date:   Tue, 18 May 2021 11:12:07 +0900
In-Reply-To: <YKMYUUVVVJMWH7xi@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 18 May 2021 01:28:49 +0000")
Message-ID: <xmqqeee44wp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7356F612-B77E-11EB-9B01-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> As I mentioned on the patch itself, I'd prefer if Git didn't do this.  I
> have my own colors configured and don't want Git to render its man
> output differently from what I have.  Even if I didn't, I wouldn't want
> Git to change the output of man(1) to be different from what's on the
> system.
>
> I should point out that I have my shell configuration set up to use
> different colors depending on the capability of the terminal, such as
> using a 256-color palette when that's supported and a 16-color palette
> when it's not, so there is literally no configuration that Git can
> provide here that matches my existing settings.

git -c color.man=false help -m" would let you consume the output in
any way you want, I would presume?

> Additionally, colors tend to pose accessibility problems for a lot of
> people.  I have normal color vision, but because I use a transparent
> background which renders as grey, the standard terminal red is nearly
> illegible for me.  I also know people with colorblindness who have
> problems with various colors or any colors at all.

Yes, accessibility issues are real.  But a bit of configuration to
disable colors would rescue our users.  I work on white-background
with black pixels, and colored diff output that shows lost lines on
the same background with red pixels is hard to read for me, but
thanks to color.diff.<slot> settings, I can customize it to draw in
reverse colors.
