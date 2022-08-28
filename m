Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A14ECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 06:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiH1GyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 02:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiH1Gx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 02:53:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACAE52FF9
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 23:53:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l3so5177568plb.10
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=a2gDV3ASq5izY6jAiy4PdA9SBiRwWmUL3o3eN/Il0BE=;
        b=o/rQ+VD85Urg03Lq7cR53pl+CPGPwjO/Wdq3L5PHvXE2tch72uEou0Twe4D5Llvszq
         8o8eIe9uKyQYFZBREBkiBsc5X4s33iFvOAZeMJgfVzE68tGnnFB1D27MSNI+8XugoCv4
         oUHN1GuLsBWSceqYczXlF66muNuO3rSx2ZEjlRCo/tcpPhA/EuzwNiEObqdBz1g8HbFC
         ZoPUI1ewdiV1PCj6cHPvFXeBQpz+2ifGSoIOvVkdQ3bR3Ru/wdOKMkv6LtJK6jZGYDBu
         QOBrdVbGUF69oBcR+k8W2pitvcTMzojV1YwNpf4FYh9v7dHEFcdGL7wj87+OcwUfqYJb
         OGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=a2gDV3ASq5izY6jAiy4PdA9SBiRwWmUL3o3eN/Il0BE=;
        b=OBw0nZyeAaU+UC8EEJzt3hIU6yf+4XuZecVJnYjtb2P1+9IDtIG/lblaH4b2dzZoeY
         DFN8Cg2b9UlrbrfYHpZKvu7Ta0qTmRjDwwX/cYAc698GKrRNDsCnzVnPIqlPPUO9Bn3G
         Due7++ckrSgfit9ScL7+91DkuYdwJKWHUYR6Ni4C8B/VxHjM/jJaXo3ZJmDnCUWtHzsc
         iASzncB/eyA9O+2hjQm+iHvKPZ3psxYphirPI27rQ6sjfgM0PSoxC8DsqBDyHtqTfSRu
         PIr6ab6SJKJEYO2lEGf9ip0z5lovnlwP5amm45x8mriBAQnXUurWMisiTwVu21kqNmCZ
         1W/Q==
X-Gm-Message-State: ACgBeo3jdumMcEun8sl0yMEMgxeHEIpU822lClLxuAcf+j1CG2KZiokN
        xIwYOkBxVRyMUXVjYMET304=
X-Google-Smtp-Source: AA6agR6nGWq97QjxzzH2EMqek+23AkctgauxcchAFi4biEDOJT5Ecfob0P0GoSVj0GTNRgPEKnQUpg==
X-Received: by 2002:a17:902:f64d:b0:172:d004:8b2d with SMTP id m13-20020a170902f64d00b00172d0048b2dmr11266748plg.14.1661669634755;
        Sat, 27 Aug 2022 23:53:54 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y16-20020aa79430000000b0052e7debb8desm4684512pfo.121.2022.08.27.23.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:53:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 05/16] bisect--helper: make `terms` an explicit
 singleton
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661604264.git.gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 23:53:54 -0700
Message-ID: <xmqqk06svoxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -struct bisect_terms {
> +static struct bisect_terms {
>  	char *term_good;
>  	char *term_bad;
> -};
> +} terms;

On the surface, more global state may feel sad, but I do not think
we want to run multiple bisection in one session anyway.  Overall
this may result in a simplicity win, hopefully.

The patch is noisy, but mostly from rewriting "terms->member" to
"terms.member".  I am not sure if that was worth the effort, though.
You had a code that plumbed a parameter through the call graph, and
instead of destroying that arrangement, you could have just replaced
the reference at the beginning of the call chain to use the global
state instead of an on-stack variable that the caller used to have.

I have no strong preference, but I do not think that it particularly
contributes to "clarifying that we are using global state" to make
direct accesses to the variable everywhere.  I dunno.

