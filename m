Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A081F419
	for <e@80x24.org>; Tue, 12 Dec 2017 23:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbdLLXkg (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 18:40:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54729 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752723AbdLLXkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 18:40:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A67EEC4775;
        Tue, 12 Dec 2017 18:40:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zeGy9iwhtiG9E2Efl/fq87VZVBo=; b=u/CFFg
        R1T/l2mUVPYNlEOlFgyTnQxjA48EZZUoOCdO7c1FnbK5VZR18umft+mDbPFB4Izh
        dAo1va+dQODGM3AYZ8/UptHzuhsFYwibjFJ2EPXLn3lf7Bn4IxoN73KkO7t6JQng
        uBBekBuxOmZ6cISQtwjXf89exsIxN9O0M42Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t/wk4/P/pKmMIzeKYsLt8aj2khd4JqRh
        2Bwu20PD0iODxPZvYycivan9Z5C8MV3fh2hZgmfgQke1NzfP8y6WQRm3t4lyqUkQ
        DQDtV3mOxvf0uJOm2egm4jJeYLdN0VadyURWDShPr3x1k5tiGbw8RApgUKEd71he
        2gaUaTzMLFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F3EBC4774;
        Tue, 12 Dec 2017 18:40:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22C79C4773;
        Tue, 12 Dec 2017 18:40:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
References: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com>
        <xmqqindc4zhp.fsf@gitster.mtv.corp.google.com>
        <006301d372df$e82cf410$b886dc30$@nexbridge.com>
        <xmqqtvwvy1rh.fsf@gitster.mtv.corp.google.com>
        <004b01d373a0$3ec759d0$bc560d70$@nexbridge.com>
Date:   Tue, 12 Dec 2017 15:40:29 -0800
In-Reply-To: <004b01d373a0$3ec759d0$bc560d70$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 12 Dec 2017 18:23:35 -0500")
Message-ID: <xmqqpo7jy0pe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D698E678-DF95-11E7-84B5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Yes, needed. The lines wrapped om Documentation/Makefile - each
> change in quick-install-man/html should be exactly one line:
>
> quick-install-man: require-manrepo
> -	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandir)
> +	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandir) $(GIT_MAN_REF)
>  
> And here
>
>  quick-install-html: require-htmlrepo
> -	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir)
> +	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir) $(GIT_MAN_REF)

I somehow have a feeling that you are not even looking at the right
rendition.

To everybody else who did not complain that what I sent was
line-wrapped, the message should be showing like this:

    https://public-inbox.org/git/xmqqtvwvy1rh.fsf@gitster.mtv.corp.google.com/

Perhaps the mail program on your receiving end is mangling what you
got from the mailing list, giving you a line-wrapped version.

It also unfortunately makes me suspect that you didn't actually have
a chance to apply the patch mechanically and make sure it works for
you due to mail mangling at your end X-<.

> And otherwise please consider it signed off.

Will do, thanks.
