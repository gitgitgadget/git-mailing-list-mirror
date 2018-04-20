Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFB41F424
	for <e@80x24.org>; Fri, 20 Apr 2018 09:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeDTJ7c (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 05:59:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34545 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754287AbeDTJ7b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 05:59:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id p18-v6so2221836wrm.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=J0G8/nl892yylZ/Tmc3S5Ha33RgVUrwamtkXjrt1UiA=;
        b=ShElkYFV7jdQSasD8pT2etaeYqa7PAqdt4ieHwQoa675VGUaA2tfCwX0vexdR6ce2F
         OXax9iKhDnwQ0QiZqhI6PdoiwXW5QYEC43XDpbaDoqGBHj2Lv6c8mX+r1G723tvk7QEe
         /Lh3X4d5xz+IUQXC+jbZ71QpJWLz0+kaFw7g8TSTxyEVtxr2UJiSPozwr0ZcRdnjwTqa
         +taQbc0skg5KNz1MLpUbNqYT8QJxFtxkTZjopbbQehCFdjBC8NbAeJJvKbjG8lD4synJ
         HhvyeAwUuYJYVx5dvUYpgk8DTD92sCf1lLjmqbVpyq3LBj5ZhmX6Ub7b18eCESZRgsmc
         NCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=J0G8/nl892yylZ/Tmc3S5Ha33RgVUrwamtkXjrt1UiA=;
        b=sQuUPDIjAU59wMvOPB9ffJD2zSP40pM5APlj1ITACS+aAUrFAV4oXzTU/g7hXSnR6w
         3SRFurFS5PYEZnLobmAFA30iMW5fvou+p2F/RfDNPkRpQKm7CovNogSsSoeXJG/iHDEs
         Rpe3c9/C7T+TsITFp5pscPIYhgQUlaOYhIU6aJ6f5KGlFbTIa0xHTDGICgZPku2sSiuA
         x3dj+5C0F1+i1EyMjeluapZrVPK1yimxhcJJPhbFCuVrK8hTYyX/F98a1eu+mB960hcI
         e3DIqOE8Ht59b1iqRkLKWs4N13XevdJSTyTQVb7u7ZCKyrhY4ecZ+JPilzxs6mkYjktz
         s4pg==
X-Gm-Message-State: ALQs6tCtQiIlN8nTpaTQWX36tmaGOlHqEqYifcCYeUstJqJXnHkj9/RT
        ZY5QvYW3rmooALWkkMZ8BI0=
X-Google-Smtp-Source: AIpwx4+IuL2cfRRMKGftg2hoWMEqBt5YZ8PiXQXDCixHm58xO2hXAwlRL0bqtU6+zeDqaj+mwZtIuA==
X-Received: by 2002:adf:d1cc:: with SMTP id m12-v6mr7001369wri.214.1524218369865;
        Fri, 20 Apr 2018 02:59:29 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 2sm962306wml.2.2018.04.20.02.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 02:59:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>
Subject: Re: [PATCH 1/3] gettext: avoid initialization if the locale dir is not present
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <6be8678b7d6b4d9116ea4666a0b28ff4dd938690.1524211375.git.johannes.schindelin@gmx.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <6be8678b7d6b4d9116ea4666a0b28ff4dd938690.1524211375.git.johannes.schindelin@gmx.de>
Date:   Fri, 20 Apr 2018 11:59:28 +0200
Message-ID: <87o9iedwqn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 20 2018, Johannes Schindelin wrote:

> The runtime of a simple `git.exe version` call on Windows is currently
> dominated by the gettext setup, adding a whopping ~150ms to the ~210ms
> total.
>
> Given that this cost is added to each and every git.exe invocation goes
> through common-main's invocation of git_setup_gettext(), and given that
> scripts have to call git.exe dozens, if not hundreds, of times, this is
> a substantial performance penalty.
>
> This is particularly pointless when considering that Git for Windows
> ships without localization (to keep the installer's size to a bearable
> ~34MB): all that time setting up gettext is for naught.
>
> So let's be smart about it and skip setting up gettext if the locale
> directory is not even present.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  gettext.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/gettext.c b/gettext.c
> index baba28343c3..701355d66e7 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -163,6 +163,9 @@ void git_setup_gettext(void)
>  	if (!podir)
>  		podir = system_path(GIT_LOCALE_PATH);
>
> +	if (!is_directory(podir))
> +		return;
> +
>  	bindtextdomain("git", podir);
>  	setlocale(LC_MESSAGES, "");
>  	setlocale(LC_TIME, "");

I wish we could fix the root cause and just make gettext faster (or ship
with a small shimmy of our own), but leaving that aside, I don't see how
this patch makes sense.

If you don't ship git for windows with gettext or a podir, then compile
with NO_GETTEXT, then we won't even compile this function you're
patching here. See line 30 and beyond of gettext.h.

Are you instead compiling git for windows with gettext support with an
optional add-on package for i18n, so then this podir conditional would
pass?

In any case, if this is actually the desired behavior I think it's worth
clearly explaining the interaction with NO_GETTEXT in the commit
message, and if you *actually* don't want NO_GETTEXT I think it's useful
to guard this with something like MAYBE_GETTEXT on top, so this code
doesn't unintentionally hide installation errors on other
platforms. I.e. something like:

	int have_podir = is_directory(podir);
	if (!have_podir)
#ifdef MAYBE_GETTEXT
		return;
#else
		BUG("Broken installation, can't find '%s'!", podir);
#endif
