Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C96C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 23:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiLPXwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLPXwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 18:52:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E416027B1D
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:52:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so3931534pjd.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFmcTjTx3UU2e8ESlebDh6yfobRwLLtGVDxIfrBbQt0=;
        b=CNFCXhSVqJweswjVkLxa5oZSqOBBlS5e3BNnu5+IGqdV/hugrR5glFSQ16o94GaOw7
         RFNaJ3sLdHKaEnkndcAkslYNLDXHxURADsyAxPAWrWX/6NC/cAQQPwaSvPuXmJeIRumL
         xI+rbn4x77rJztPAazRPwbtUHcQ4W9RJy8M72Icsf3LJGHJSSUd4WrLI4wQVxMOwbbHN
         47ifdfQG95UbbO2POY8rth3DlmNc7nLJzhMMS+AFTg+/BV5uDFdurtMve5ToAYjSU5SJ
         aU8ro7vivE4LP4yID6sobnLyU4+0zotUKzZMSvPWa1gmKsOdAAudvKEqZA0QlNYAlcSg
         h9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xFmcTjTx3UU2e8ESlebDh6yfobRwLLtGVDxIfrBbQt0=;
        b=cPWTXB71f7FeTHuCOHnCORQ23OTAwNDRrGZLbLwP0hH9yBHLSH4EJ0OCeiWUAbpoLh
         TCVVJNr1lRbc9LnOsLOTliBMbkLlHMEgQFvTIJMcigKlOuzYSv5l+Vcny86AshIj5u+A
         3VOB7W+/nnRfY1wK2UnFZbUtgM6EBkmiKsK3jXs7Cs8wJksSiP9GWJtlScZJNeJuPw8N
         b0mJn4/xXlgGlRLpBr6226X2BguUgI6SOvSOsT9wbaBDu+gfgoYJFOINqHMdGEBYeK7w
         su9jQuxTCDmPm0SixG8ShHr1zb+V9dlJLYcw1bglg8eOvLFDLL5a5+EMmIKtmN4eJ7WL
         qoXg==
X-Gm-Message-State: AFqh2kqpLMZVhA+YbaJr/OClpJMq5wZL4BNCPGLjYg2CnTEGd8ZckZ2K
        DYop9hK6x7tyc3xs5arwRzacPf+qqz8GCw==
X-Google-Smtp-Source: AMrXdXvjDsZlSckmmkkj3iJXTA17IZ7qNzKas8CKsfYK3ETGmv4BDSLIewQY/tixMVzsZEso6xkbng==
X-Received: by 2002:a17:90a:df17:b0:219:b015:58d4 with SMTP id gp23-20020a17090adf1700b00219b01558d4mr233571pjb.28.1671234767372;
        Fri, 16 Dec 2022 15:52:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j8-20020a655588000000b004786c63c21esm2009364pgs.42.2022.12.16.15.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:52:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v3] git: edit variable types to match what is assigned
 to them
References: <pull.1399.v2.git.git.1671211155128.gitgitgadget@gmail.com>
        <pull.1399.v3.git.git.1671228557381.gitgitgadget@gmail.com>
Date:   Sat, 17 Dec 2022 08:52:46 +0900
In-Reply-To: <pull.1399.v3.git.git.1671228557381.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Fri, 16 Dec 2022 22:09:16 +0000")
Message-ID: <xmqqmt7mkisx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> There are many places where "int len = strlen(foo);" is written,
> just for len to be passed as a parameter of size_t.

True.

> This causes truncation and then expansion
> back from int to size_t.
>
> Not to mention, this is poor logic,
> and needless truncations can add
> extra unneeded instructions.

I'd omit the last paragraph if I were writing it, as these two
paragraphs saying exactly the same thing.
