Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9391FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 23:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759418AbcLAXdc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:33:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50317 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754357AbcLAXdb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:33:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA167547D5;
        Thu,  1 Dec 2016 18:33:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bf7vuXbv18BhPoKokHsvckW5y5c=; b=X2CaHo
        yoBJUgMEsxi+qP5o7MVlYO/PQYhQkmDIpNyaqWnTpVegwe8AajSPNXD9vtC7FpNt
        xjr9niaR8rmR8GRK2jgCHPTJYuNCa2tvN2mLy1bWVao5S4DWntnZBPW+UMfsjaMg
        yYbjH6mYlEU4nbUTnlFRBywZK9mkLqo3kwnE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MvbNHHUlGEkoTSYTAH52/+mV6h9pMciS
        kTIbI3hkSZwYZJ/gpuklZKTctOwrI7g76nfwCQMGniy9KGxOZZi4gqtHesFdZ73z
        wHuwEEVawYUBP+ahdlsxd7Jh/4nFWzlwphJZer9mXlaVgMfHXvyoOa81z75Iohxq
        SFjuqW9t1lQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2FB5547D4;
        Thu,  1 Dec 2016 18:33:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35233547D3;
        Thu,  1 Dec 2016 18:33:29 -0500 (EST)
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
Date:   Thu, 01 Dec 2016 15:33:28 -0800
In-Reply-To: <alpine.DEB.2.20.1611301325210.117539@virtualbox> (Johannes
        Schindelin's message of "Wed, 30 Nov 2016 13:30:04 +0100 (CET)")
Message-ID: <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 906C969E-B81E-11E6-9986-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The config kinda works now. But for what price. It stole 4 hours I did not
> have. When the libexec/git-core/use-builtin-difftool solution took me a
> grand total of half an hour to devise, implement and test.
>
> And you know what? I still do not really see what is so bad about it.

I was wondering if I should explain myself again, even though I do
not see what good it would do, as clearly my point did not come
across in the other emails.  And then you would just complain that I
am making work for you.  Clearly you do not seem to see why placing
random files in $GIT_EXEC_PATH, which is a place for git subcommand
implementations, is wrong, so I won't repeat it to you again.

But you need to remember that you are not working on a Windows-only
project.  In non-Windows environment, many users would not have
write access to /usr/libexec/git-core directory, but it is not just
easy for them to write into ~/.gitconfig, but that is the way they
are accustomed to, in order to affect the behaviour of Git for them.

As to "I have to spawn config", I think it is sensible to start the
cmd_difftool() wrapper without adding RUN_SETUP to the command
table, then call git_config_get_bool() to check the configuration
only from system and per-user files, and then finally either call
into builtin_difftool() where setup_git_directory() is called, or
spawn the scripted difftool, as Peff already said.  Your "users
opt-in while installing" is not about setting per-repository option.

Calling git_config*(), setup_git_directory() and then git_config*()
in this order should be safe, as setup_git_directory() would clear
potentially cached configuration values read by any previous
git_config*() calls, so any configuration enquiry made by
builtin_difftool() would read from all three sources, not just
system and per-user.

So there is no chicken-and-egg issue, either.
