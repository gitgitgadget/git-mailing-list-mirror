Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806ACC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349293AbiC3RaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiC3RaR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:30:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42906A028
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:28:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bi12so43017433ejb.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KfkPyVSnO96DRyjNN0V/0rn+z99YM9fQxZHJ2HGY8A4=;
        b=JFjzMnAW9P48ptELhYLJH4+JWpvtDOt5ONHhpNPaJxyvl/WnLoi2G0hnAHHn44ajPJ
         8rUy0ruBbjKPfnKlYV0L1tJvmTOK3PwdXHBvprpImZ/5W9zSelc9MpfiTDPOT+/5XPq/
         Sg4hFwU/8NGZVRoiFAdTAo4ImyEGsVeX2CaXBpVdieKpEfu8WUtogJUMAPOV8lDT0cUO
         B2P0ek2U7Amvmpwi621HzTvt4eIIsqqBKPCPfUOx0sbMYE7rw0PlFXkitWTVU5QxmZuF
         4IHarMON3KFLzPh27awwHuCHwFkKn5o9YzwoO5e/ouoEpuCMbCRhgw0O0rUesVmCO4FK
         OCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KfkPyVSnO96DRyjNN0V/0rn+z99YM9fQxZHJ2HGY8A4=;
        b=ZkXpu8Ft6v2dgkiKlzq4cfIykndVw1p+plk8dSoAlS+oSLmROKV0OXIDUnlciXWWSc
         E7sg0HnAQkiY/Sr4RN3G6SbHC3HjnET4XHeY3iajKI+XhxsmTI7PL2GM5Oi1EGPhlBLb
         IaNTUzRwuZOkzRkgjPsk9I0vC0wPR2CjJcoD8tD4ztKgAT1Yg4B1TSUaQCMZEWwPcU2f
         tWgX9rIrVLlelBxYer1x4eSpPsasX1VRETJBs8g2KRqF+KvkovskRF0VLV1LdM0Fg8X3
         tTsoEg+PyCnM1+JJTukN+rAH1dO/3BKBba2dKNwF4CaNX9B/xrfPaKlVnJKfZAaqCXnO
         FM8A==
X-Gm-Message-State: AOAM533D4HYw5Bbz4ku052VdrfT8hBVGmCYvYSBQj10sijlDgeiV6D6f
        3Lqn5wmqQIHHPWOTM0rw1ySKfVhf/5Y=
X-Google-Smtp-Source: ABdhPJzRwFm+AQFxgU5klw4ODslZF/grmOsYxnkaJoWM2A/s/y4owoOTzypSGh5nxtAV766m01AXsA==
X-Received: by 2002:a17:906:3101:b0:6d6:5b64:906f with SMTP id 1-20020a170906310100b006d65b64906fmr636175ejx.513.1648661309185;
        Wed, 30 Mar 2022 10:28:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb24-20020a1709077e9800b006e029bd4c24sm8438478ejc.193.2022.03.30.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:28:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZc7Q-004NbP-9P;
        Wed, 30 Mar 2022 19:28:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cli: add -v and -h shorthands
Date:   Wed, 30 Mar 2022 19:17:53 +0200
References: <20220330170059.5075-1-garrit@slashdev.space>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220330170059.5075-1-garrit@slashdev.space>
Message-ID: <220330.86r16jnydf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Garrit Franke wrote:

> If "-v" or "-h" is passed as a flag, they will be interpreted as
> a "version" or "help" command respectively.

They won't, try e.g. "./git -h" before/after this change. On a second
reading I see that there's an implied "change the behavior to ..."
there.

But it would really help if the commit message discussed what we did
before, what we do now, and why the change is safe/OK.

I *think* we just emit the message about an unknown option before, and
this makes it synonymous with --verbose/verbose and --help/(but not
"help"), but saying so would be useful :)

> Since this is my first patch for this project, I'm very happy to take
> your feedback!

Welcome to git development!

>  Documentation/git.txt |  4 +++-
>  git.c                 | 15 ++++++++++++---
>  po/bg.po              |  4 ++--
>  po/ca.po              |  4 ++--
>  po/de.po              |  4 ++--
>  po/el.po              |  4 ++--
>  po/es.po              |  4 ++--
>  po/fr.po              |  4 ++--
>  po/git.pot            |  2 +-
>  po/id.po              |  4 ++--
>  po/it.po              |  4 ++--
>  po/ko.po              |  4 ++--
>  po/pl.po              |  4 ++--
>  po/pt_PT.po           |  2 +-
>  po/ru.po              |  4 ++--
>  po/sv.po              |  4 ++--
>  po/tr.po              |  4 ++--
>  po/vi.po              |  4 ++--
>  po/zh_CN.po           |  4 ++--
>  po/zh_TW.po           |  4 ++--

This *.po stuff is a well-meaning change, but please leave this out of
the patch.

The translation files are updated by a process that the translation
teams(s) use, see po/README.md. I think changing this from under them is
probably more disruptive than not.

> -		if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
> +		if (!strcmp(cmd, "-h") ||
> +			!strcmp(cmd, "--help") ||
> +			!strcmp(cmd, "-v") ||
> +			!strcmp(cmd, "--version"))

nit: minimize the diff here perhaps by keeping the existing line, and
doing -h or -v on a new line? Your indentation here is also off.

> @@ -893,7 +896,13 @@ int cmd_main(int argc, const char **argv)
>  	handle_options(&argv, &argc, NULL);
>  	if (argc > 0) {
>  		/* translate --help and --version into commands */
> -		skip_prefix(argv[0], "--", &argv[0]);
> +		if (!strcmp("-v", argv[0])) {
> +			argv[0] = "version";
> +		} else if (!strcmp("-h", argv[0])) {
> +			argv[0] = "help";
> +		} else {
> +			skip_prefix(argv[0], "--", &argv[0]);
> +		}

Don't use {} braces here, see CodingGudielines.

FWIW I have an existing branch (unsubmitted) at
https://github.com/avar/git/tree/avar/parse-options-h-3 where I added
some tests for "git cmd -h" behavior, which seems to pass with this
change (not unexpected, as this is for the top-level command).
