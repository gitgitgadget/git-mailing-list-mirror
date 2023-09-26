Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDFE7D27F
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 19:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjIZTvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjIZTvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 15:51:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A4A9D
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 12:51:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50437c618b4so13137756e87.2
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695757897; x=1696362697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftVgVKPqgmhrRJTzXHnn/0dTcH/QgOQtP7qtPU5gqbU=;
        b=mqqDJIYxM/f91d510VpI2jv50CPYcwWaRJRoHtApDE51euKq5qJtoERu9IlFgJyfqn
         2+TQB72OTR6FYnCsPI91XDBL62cux8AcZeiFdQCMBq5eBBmElBBbg35HrAgUv4/9pq1e
         Z/tdnY4u0K2jW0dgAEi5dlEdrpuU9JnCAsVmCRpSg9/VyTXVhTSjvgMdoBpxX/82jfzC
         kBHl5UKjU83Ob63+ivsfCCnaR6lFNh554thYRtE0LYYUPERleRL2cemdGZlSE21Aaj4b
         eHNFA30ZdGXJatqxbxlie8qGiq6c1kWEg7RTwcaxMD9VYk2Vm1xXK5lZVK5HhpWvzxlp
         dy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757897; x=1696362697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftVgVKPqgmhrRJTzXHnn/0dTcH/QgOQtP7qtPU5gqbU=;
        b=QlkZ92G/Hk8L3u6Kh160aV4INzuMrNrJ+c6eUBwV1GdhW3MUJNziyNzeLFhFRIaoIQ
         ObwrxmzqDKoCea6gAiONAHqInrZvEY/B7sbg5+AdlFmGSWsZPkTk6Pkr+KIbvRVvhh+U
         9F2ScpPR7P07RCDHVLBXydtg9VVmpnPqbDdrA+TsBTaYZ72an1sFZwSgcKC7eWy38k/w
         e8bs9XEM4V06qfsE6c2cR2D9ykQMlcNPGOvNzRJKqk98+hWpdOr/8lQPHNcrjvgPtFrx
         1AbiY/9Z2a61n/8okKdixX2h5Bc3DK+fY1tDBKwVgx0mt1Evu1jZtUhWMuRSmFPR/otc
         tCiQ==
X-Gm-Message-State: AOJu0YzOCIPB1aNOlACX8B6WvCkLsdFBGcwff4RgSuUWMnShOGj5oiam
        HB0Z2/p2iCMeT94QJTguAcFu+qlMipC9pYSPfEj2lo0u
X-Google-Smtp-Source: AGHT+IENUjVLrr98K04YzfpL87oeylKP1DbVfzlz6KG9lNs6OZrBteeIWUvlOrDDUxpeCVVdYuJ353yoQGip/iPXV4o=
X-Received: by 2002:a05:6512:3ca5:b0:503:2561:adbc with SMTP id
 h37-20020a0565123ca500b005032561adbcmr10859109lfv.64.1695757896619; Tue, 26
 Sep 2023 12:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
 <xmqqsf75zxbv.fsf@gitster.g> <CACZqfqCVsv-ZaSRWt_ejMn5f_U_1E2h7wsCgUg_50A+KHzOgkA@mail.gmail.com>
 <owlypm24sr6n.fsf@fine.c.googlers.com>
In-Reply-To: <owlypm24sr6n.fsf@fine.c.googlers.com>
From:   Josh Soref <jsoref@gmail.com>
Date:   Tue, 26 Sep 2023 15:51:25 -0400
Message-ID: <CACZqfqC3HWOuveQdbpVEEO5KOwmnugvUmm6M0WpVu2MtUopm-w@mail.gmail.com>
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
To:     Linus Arver <linusa@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver wrote:
> FWIW we already have some guidelines about what is acceptable for doc
> patches in SubmittingPatches:
>
>     We currently have a liberal mixture of US and UK English norms for
>     spelling and grammar, which is somewhat unfortunate.  A huge patch that
>     touches the files all over the place only to correct the inconsistency
>     is not welcome, though.  Potential clashes with other changes that can
>     result from such a patch are not worth it.  We prefer to gradually
>     reconcile the inconsistencies in favor of US English, with small and
>     easily digestible patches, as a side effect of doing some other real
>     work in the vicinity (e.g. rewriting a paragraph for clarity, while
>     turning en_UK spelling to en_US).  Obvious typographical fixes are much
>     more welcomed ("teh -> "the"), preferably submitted as independent
>     patches separate from other documentation changes.
>
> and both the 2-space vs 1-space and comma changes seem to fall into the
> "not welcome" category.

Ok, then, I think at this point I'll abandon this PR.

I could probably find the time to justify rewriting one paragraph in
this single file to try to abide by the requirements, but it doesn't
seem worth it. I'm sorry I wasted everyone's time.
