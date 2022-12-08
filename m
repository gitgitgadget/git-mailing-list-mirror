Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52323C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 23:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLHXGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHXGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 18:06:46 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB228F734
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 15:06:46 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u15-20020a170902e5cf00b001899d29276eso2609895plf.10
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 15:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjH+4vFoVALS5IELiaEJCfAEb6bUnFL4JJZsCJfVoD4=;
        b=dwAI0CHHLM/TH4689JVnhhVec5UoqnWXuisBfK/aZ7NSsPRBICS457zOEHoK2fNwfP
         WwG5HAUp/hYv7lVDXwpzLlkTlg9ARlV4p/j9Fl5nGjYGYM426AghShc6Dwuy6q6h7Tid
         Yu8CzmLP+6gqZIHGAWWgh8XGEe7Eih7oM55DAiTDnSYO+bQ8bzxJFxWt+b/IaihwKs7r
         cw4gMu17dSUt9BrjNBbAkSpfkw3B+uBdPnlqwlpmoUEfcO8nQ3EDNGYRQvsY1VQ8YGxX
         M7jxEAgSi8k2h1cUfQK0kdxOILA+2gA4oQVpebMPkkIoy8ND4grw7Pw7fGlRkATqe0AT
         tTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjH+4vFoVALS5IELiaEJCfAEb6bUnFL4JJZsCJfVoD4=;
        b=aRILCilO8Ri9GEQ0pV6MqgCjgGX0BWndrxHRm26u8p3h9AzJRDtPguUq5aChZcnV3E
         Dy9ln9KyvBYT2HPPoHApSnWHiTU6/L1zkomA7VNd8ytJreRR3ZONu6/bZgYklgFqfrHl
         VRL0adTUx+i1vYiAXqlYtM1jAkGax/XmIooMnaWNigQpJdLSnhcL/nfgEi0S7Fn3Y1k6
         s+PIV6AUPTbXPoLwVZ/n8iEevnImJ/JWUlT8W/ZvXxOklsM/iZFyvlBJRFEf0LTRr/sj
         W+sWUnJwjqePcNal7Uj5V3bBk+12lvgfTDzbVVRmE8QmDtp0NBJPlQivzKh3eArfEGI/
         gPnA==
X-Gm-Message-State: ANoB5plYGBMkEvapYkZPTiqn7xeEkUmKpGDZaj2uzy6JtBK7omThrI1Z
        VMMJIV/PSwk7laKfCUCKJzWzlxae+T8NDw==
X-Google-Smtp-Source: AA0mqf46f/69bUMePcj2qu0Q70bVZ1JBTqS0BJNRZ4AwFOzaLfBMXSPNz2Tt6Mmi//m38Hn5GrHxFd0N1nxiQg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1bc6:b0:218:4d16:cecf with SMTP
 id oa6-20020a17090b1bc600b002184d16cecfmr101512139pjb.96.1670540805926; Thu,
 08 Dec 2022 15:06:45 -0800 (PST)
Date:   Thu, 08 Dec 2022 15:06:44 -0800
In-Reply-To: <87tu26arzy.fsf@osv.gnss.ru>
Mime-Version: 1.0
References: <20221127093721.31012-1-sorganov@gmail.com> <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
 <87tu26arzy.fsf@osv.gnss.ru>
Message-ID: <kl6la63xebqz.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/5] diff-merges: more features
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Where do you prefer these references to be put, in the cover letter, in
> the commit message, or in both places?

Wherever it might be relevant as motivation behind the change, so
probably both, but especially the cover letter :)

>
> -- Sergey Organov
