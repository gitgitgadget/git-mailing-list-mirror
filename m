Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856CA1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 18:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbcLEShn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 13:37:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55370 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751427AbcLEShm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 13:37:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 743E753578;
        Mon,  5 Dec 2016 13:37:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gAvET6fFOojdV+kQwsl672IbshA=; b=IbSzWE
        C6+iuiRTL4uiKP+Oy9bYwGlQWu2YA1lDqxx4NKamyizxBWJ7d0AY1QVlwyHoFmCG
        iK6s9aEooIy9g5Oi2YmEytvKal1m2X2wnFwLwjhFNTTaHFKhOSwbCYEFQ74EayUy
        TZ0Km9VXAaoF3aFrombDI+KmMUX4s2TAqRntU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eNBmUP2uEi7qtuFh2V1BxGVqeHUyaogN
        OeHvHA5bLj3aNnvFQU3c6Fi9t1mSjlrCe1hNlu+Q4zWeqNAxw84elCv2IP47Sjoz
        NTp756JVYPM49z8zpysMbEUt5Q3lcJwrugeGMMxS3rIpNsf1pK9ks/HoDPfP/8IB
        DoYecO2UQK4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B7B253577;
        Mon,  5 Dec 2016 13:37:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5CC653576;
        Mon,  5 Dec 2016 13:37:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611242211450.117539@virtualbox>
        <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251201580.117539@virtualbox>
        <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251841030.117539@virtualbox>
        <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261320050.117539@virtualbox>
        <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261400300.117539@virtualbox>
        <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
        <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611281830040.117539@virtualbox>
        <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611292128340.117539@virtualbox>
        <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611301325210.117539@virtualbox>
        <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612051126320.117539@virtualbox>
Date:   Mon, 05 Dec 2016 10:37:39 -0800
In-Reply-To: <alpine.DEB.2.20.1612051126320.117539@virtualbox> (Johannes
        Schindelin's message of "Mon, 5 Dec 2016 11:36:19 +0100 (CET)")
Message-ID: <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E73436D2-BB19-11E6-AFED-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Seriously, do you really think it is a good idea to have
> git_config_get_value() *ignore* any value in .git/config?

When we do not know ".git/" directory we see is the repository we
were told to work on, then we should ignore ".git/config" file.  So
allowing git_config_get_value() to _ignore_ ".git/config" before the
program calls setup_git_directory() does have its uses.

But I agree that "difftool.useBuiltin" that flips between two
implementations is a different use case than the above.  Both
implementations eventually want to work on ".git/" and would
want to read from ".git/config".

> We need to fix this.

I have a feeling that "environment modifications that cannot be
undone" we used as the rationale in 73c2779f42 ("builtin-am:
implement skeletal builtin am", 2015-08-04) might be overly
pessimistic and in order to implement undo_setup_git_directory(),
all we need to do may just be matter of doing a chdir(2) back to
prefix and unsetting GIT_PREFIX environment, but I haven't looked
into details of the setup sequence recently.

