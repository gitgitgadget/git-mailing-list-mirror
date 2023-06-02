Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85FDC7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 16:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjFBQq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjFBQqz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 12:46:55 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA90196
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 09:46:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-255ced12531so2022306a91.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685724413; x=1688316413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRw+m44Nmlsx0pAmQmTY174K5iOGtsa7cBJ3cJWQPCM=;
        b=Hx83LoqJSyCTmf7Xo4LotBIWrx7f94LF+XIs96v54DDEgrsIMnW/hHUMOZI38SzGbe
         rl4aZLGdQ2VlnGlWK6XZ8KD641ZDmog2m+3bAF2bJDJvhEBrc/HJjDOyYRh4C4EQbsfO
         ahymfBZbOkLNrPrBQ0nXh2vIE2gopDiif3WObHOrPTHHyhaxGgXL59UVnXbkcu16FuW6
         sblmrorHvCOnhywR2+Oym18srs+uPeP8izmY2AWxGAR9oCNeQvJmnkMYDqQlTC9hED0+
         bNkEywaGNROyEovu6uQHoaa76z8IHyqEgDEDPITuzGTCqHZxTpQvp9GOkHsPnkmOzadf
         RXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724413; x=1688316413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRw+m44Nmlsx0pAmQmTY174K5iOGtsa7cBJ3cJWQPCM=;
        b=JRFV4oLwyi8GF9/oDfHKt2YEtVxKnXXkbRQrkUZ/LZOCppjQJblRyBtYYkNJ5U7bcV
         zfIJQ6atS3SUbV3CvYGDqYzkCc8jSyT+e3BeVHGCfV1lu/4BGXCE97RBsMcC0eeVTiRy
         CZpoM2ltJYLBya4SENz0ovbSMn954iSM+/QMrunFAaedlJ+qJ2vH8VU1GjXA7RUiNKOD
         oBNdipC3qB+qTJGGPYN/q61/AOx0LLf5pmUXONq52xHTNY8sUEsOBmQZ53uMVJZMybhM
         eUsAlLBgnXWe6ICJYl61Gbvr/aNsNOn7UhNVMu/lQaZy3dZ8xUZXMNxsSS0PER4dwaLT
         vrng==
X-Gm-Message-State: AC+VfDymI/a6KysfHk9bLxzr+xHNDuswMPqXubYGFd8NQBi9HZWRqe6k
        M4+9X8sP/5hNDDq5w/Qo/w8a4ZyYfUmi5g==
X-Google-Smtp-Source: ACHHUZ6QBaI9zSoDrV2+LylrJ/LGnx8S9WuJVmrk9iCQkoxg12ITBKOOhPrCMTsx8Nx2VS5anOT11FqslIhtFQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90b:8d7:b0:256:335f:d59a with SMTP id
 ds23-20020a17090b08d700b00256335fd59amr118261pjb.3.1685724413664; Fri, 02 Jun
 2023 09:46:53 -0700 (PDT)
Date:   Fri, 02 Jun 2023 09:46:52 -0700
In-Reply-To: <4de362b4-dcce-3b5a-0011-73dc7dec79c3@gmail.com>
Mime-Version: 1.0
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
 <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com> <6834e37066e7877646fc7c37aa79704d14381251.1685472133.git.gitgitgadget@gmail.com>
 <6faf1b17-a1ca-0c22-2e43-aee121c4e36a@gmail.com> <kl6l4jnr17am.fsf@chooglen-macbookpro.roam.corp.google.com>
 <4de362b4-dcce-3b5a-0011-73dc7dec79c3@gmail.com>
Message-ID: <kl6lv8g5zu9v.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 03/14] (RFC-only) config: add kvi arg to config_fn_t
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Some of my colleagues also suggested this off-list. I think it is
>> impractical for this series because I don't think anyone could
>> reasonably review with all of the added churn. At least its current
>> form, the churn is mostly concentrated in the signatures, but performing
>> ^this change would make the bodies quite churny too.
>
> I agree that keeping the churn to the function signatures makes it 
> bearable. I wonder though if we could make the change by doing
>
> -git_default_config(const char *key, const char *value, void *data)
> +git_default_config(const struct key_value_info *kvi, void *data)
>   {
> +	const char *key = kvi_key(kvi);
> +	const char *value = kvi_value(kvi);

Ah, yes that seems reasonable to review (and most importantly for me, it
is also doable with coccinelle once I figure out how :P). I also agree
that it's better to do it all in one change than two.

> As an aside, I think we'd also want a couple of helpers for matching 
> keys so we can just write kvi_match_key(kvi, "user.name") or 
> kvi_skip_key_prefix(kvi, "core.", &p) rather than having to extract the 
> key name first.

Yes, and that would also abstract over implementation details like
matching keys using strcasecmp() and not strcmp(). For reasons like
this, I think your proposal paves the way for a harder-to-misuse API.

I still have some nagging, probably irrational fear that consolidating
all of the config_fn_t args is trickier to manage than adding a single
key_value_info arg. It definitely *sounds* trickier, but I can't really
think of a real downside.

Maybe I just have to try it and send the result for others to consider.
