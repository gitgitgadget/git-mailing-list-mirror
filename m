Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B65ECAA24
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbiHYQX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiHYQX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 12:23:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC7B5146
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:23:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y141so20271683pfb.7
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc;
        bh=JZ5POR2XMzGH5mxQhI9wOmQJRKxqql5EIcNcATVkCDU=;
        b=FnB4LlMNtWUNaC7RRs29kR36/2GVxrvCKxfFUjB4IauFfpNw7gWODahtV+oifABrJA
         LuyAlKkDl+Qb9/HQeavEiJDWVjwGLbAN1fkcT4N8HaGXMG4d5Z9u+QfuU9Ryg7PtHUih
         8OCoHq0gKygAJnSXEOQXr0aB5Yr9i6AOL2L7VW2b07QCx99PxOpJK3jpjBRmXlhu3YwG
         QPZE6l6pIx9tKxXKLSVnzbJvvs85huT3wGywLv7UulCOsnyAktrqL0eA4YvqMnVIj7fZ
         XDgmUNAS+8BDsFaEg7C5Gf5gIUltLrTyJE+sYWM9oQGS5n6yzWXK78QHrHic6FipX9gJ
         34og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc;
        bh=JZ5POR2XMzGH5mxQhI9wOmQJRKxqql5EIcNcATVkCDU=;
        b=vIiBM0Tj2959RgxLG/75lxuLVduizx62QIVsO2UiQEALVK6bsZbF5yg9mFM9Gr5sZ8
         1YEPBC0dfmGycHp85rEV0Qz4gyrquKg7JOF9SBHzVNbkbgYLP64CnHATPBpybAHaQOqP
         aJoUFVaOziVCZ0Vwm4rffPR+gJys8YE4VjXlkzqz1PKPPMEw5eCq7uNUoG7Ha3qZoIwy
         9NWcsvG2/1eBeLmPJGp2gJZ5+tu6Ytswa2G7EqQQyDh4h5fPY1GkIFdz1CR3ko7I2nUQ
         OT9HG3qu51ITZNt9inxwfApjGhNtImltTI4tQ4BzhlL+rQVXFWMUUGjtT46wNimzZdvM
         yplg==
X-Gm-Message-State: ACgBeo0vEEZnUGaHacVcr4nRZnO6cuRuCuBQcePhmHc2CF4m2zA6pFI0
        k3NmRy2qGo/HQHPPQr1dQ/4=
X-Google-Smtp-Source: AA6agR5HxqP3oN0p/2YieDpwMzyF3K+J9mN8uVr48s2jiQcnu19BK88x6zugw//R3nFeP37MAhqh4g==
X-Received: by 2002:a63:4b4a:0:b0:427:bbb0:110e with SMTP id k10-20020a634b4a000000b00427bbb0110emr3900385pgl.397.1661444635559;
        Thu, 25 Aug 2022 09:23:55 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902ea0400b00172c7a2c662sm12419544plg.48.2022.08.25.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:23:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Rub=C3=A9?= =?utf-8?Q?n?= Justo via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
        <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr>
        <xmqqk07iu3c3.fsf@gitster.g>
        <5194s6qn-570s-6053-2104-9s22qo1874sn@tzk.qr>
        <55n449n3-71r9-28n9-094q-6r61545r7505@tzk.qr>
        <4d8eb431-dc25-5ea9-14b8-3f84ae0c1561@gmail.com>
Date:   Thu, 25 Aug 2022 09:23:54 -0700
In-Reply-To: <4d8eb431-dc25-5ea9-14b8-3f84ae0c1561@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Thu, 25 Aug 2022 09:57:27 +0200")
Message-ID: <xmqqo7w82sx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> struct rev_info *revs, struct s
>                 revarg_opt |= REVARG_CANNOT_BE_FILENAME;
>         for (left = i = 1; i < argc; i++) {
>                 const char *arg = argv[i];
> -               if (!seen_end_of_options && *arg == '-') {
> +               if (!seen_end_of_options && *arg == '-' &&
> !strchr(".^~:@", arg[1])) {

Yuck.  I really didn't want to see that strchr() or any other logic
that _knows_ what letter is allowed after a "rev".  It will be
impossible to keep it in sync with the real code paths that needs to
know and parses these syntactical constructs, and folks new to the
codebase will never be able to tell at a first glance if the above
is sufficient (or what the strchr() is doing).

