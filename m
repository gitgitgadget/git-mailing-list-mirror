Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A9C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 06:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6044661175
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 06:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKSHCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhKSHCu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 02:02:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EB0C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 22:59:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so38342203edd.13
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 22:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VUQSgDdO2A2nRK+rr68M47oQ27buv84d89o2CSgAukk=;
        b=bRnQqg9Qd/1wCk8NWUBC3YHgA9cu4xK99EsYpsdftnzcxk+7r83p+iNtg2ui5IXUIa
         C/rEy8irulrTb1gzcpClH4x2XdWVS/Ez66gKcafM86FmwZMaIu9Zfnq39bbX+1zVeULu
         DTiMMhgAMorsS0q8L7HP+x6kUpqRQcDoLhnxSVJEGkOmlWw4t+2y2D2sMYSplS0bUPo7
         12RKETiyH1ucdY1E6f7laEaVIAYJvyMjP9H6p6ObGboGjQb9B2NfclXjDrnr3Bvz2r7D
         OXePVgjKLck3cD9DfsegIps/nhXLcTOyNr4dawdkKC+7KCvDHIC9DuxSa/I6vpQAJbs0
         kCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VUQSgDdO2A2nRK+rr68M47oQ27buv84d89o2CSgAukk=;
        b=pCTDehNexAsTNe5oPepFqrwCU7YxuIIzG6/NiWSOkBD3euKljGj2pTc0WERJL9IiAi
         /7GseAi0B/pAN9IHO/pJYAboGpQaVNE7dcgc2rztuYgrh9UMor+nkCixPxMcV/kwzHRm
         9FjLrV4Odg5QGyTh9yeQiPIozkECMwel12fiMxXQOHWmUc0UOOxW7F2gvBgoCMYAEnFB
         S08kPTIOkex8rPxEMtKvXfyoXvifyVpKsz7GrD3lBXHIbkW0kvYiblWqjiIyznFn5QJb
         m91UzPHwuTJE2tDAbLiPiPnViM+OY/HfKjjhgn8Tl3oRxwn18tKd3DsAMDBTY+cATDIg
         vJhQ==
X-Gm-Message-State: AOAM530Vm9fNxnnQLJozctAOk69JYTt+ohJL/Ki9CLHey6X9oZMg0nAK
        Ch0Rf+SmQTzYXi8CloPS2Y8=
X-Google-Smtp-Source: ABdhPJyIxkWXyjNhkVhcEaoM9KXU8psve8WiBopGlT54CFlrjMI0TcEss8h4yCEZ11boAWQk7esblg==
X-Received: by 2002:a50:c212:: with SMTP id n18mr19914912edf.211.1637305187278;
        Thu, 18 Nov 2021 22:59:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k16sm966940edq.77.2021.11.18.22.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 22:59:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnxsA-000ZxP-88;
        Fri, 19 Nov 2021 07:59:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] grep: avoid setting UTF mode when dangerous with PCRE
Date:   Fri, 19 Nov 2021 07:58:57 +0100
References: <20211116110035.22140-1-carenas@gmail.com>
 <20211117102329.95456-1-carenas@gmail.com> <xmqqpmqxyla3.fsf@gitster.g>
 <CAPUEsphbA0Qrnt-MdxyYT2OMrnXnbi0tN5_YNqLypCqDqZyeWg@mail.gmail.com>
 <HAQR2R.KZGF0ERBQ2Z72@effective-light.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <HAQR2R.KZGF0ERBQ2Z72@effective-light.com>
Message-ID: <211119.86r1bc4om5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Hamza Mahfooz wrote:

> If none of the patches that are trying to fix our usage of PCRE2 are
> ACKed.
> It would be preferable (from my perspective) to revert only ae39ba431a
> (grep/pcre2: fix an edge case concerning ascii patterns and UTF-8 data,
> 2021-10-15) and disable the feature (for the time being) if PCRE2 is
> selected, like so:
>
> diff --git a/pretty.c b/pretty.c
> index 1af5b093ae..a53d008d1e 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -452,7 +452,7 @@ static void append_line_with_color(struct strbuf
> *sb, struct grep_opt *opt,
>  buf = line;
>  eol = buf + linelen;
>
> - if (!opt || !want_color(color) || opt->invert)
> + if (!opt || !want_color(color) || opt->invert || opt->pcre2)
>   goto end;

I see that depending on LC_ALL the behavior of grep.patternType=extended
can exhibit some of the same issues with character splitting, so perhaps
what we'd do with the C library serves as a useful guide?
