Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD55C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbjEKXQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjEKXQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:16:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F0319B0
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:16:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9e2b65f2eeso16623609276.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683846970; x=1686438970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdMeUO5x31l+k9Nujb+NRE61Xq/FvXiCYiRC/zgLBCQ=;
        b=DraZ78XdB+zUriPkbAR04TwrlSMyeeY1DSF1gARi3DWDIrC1nD+31fKAhYjeLl5MkP
         ikbbD3dBJbVEZuJnt1in5w00EyeTmM+5Bz4tskQKsJyBEHlBiMxqzYpuIjj0sBdhEODA
         iqUPXXCdy2lfmOyK6r7XnJX8ftF98UTTGsXs5sORzzQLUTI1lcquCqQtfce4o92Izly+
         X2HxPZlmv20ZeXTGaACxVuIAPgWQ9raSFlHGaXS2his0G2wmAvmQP1lUiDZoodZAr7v0
         J1Tv9/WCBd5dtVyjqfgo3wk58WbhfKHDfOBLHBGrnQ6FPq2j4bqb/7lYhZmglbwt8JBH
         qCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846970; x=1686438970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdMeUO5x31l+k9Nujb+NRE61Xq/FvXiCYiRC/zgLBCQ=;
        b=krbR2FfmvoiYkxbPt0aVck751m8mLdFuopS9iccmIw799GMo5CXuk87L2qykbd41rk
         A9sMg1jchSIubZIuFwaP+m18AAV9n6ApBpOTprp+JDkE7gg3kBA2wq1AjLug57F/yh7V
         +UywR8GWogzF2GSQt8FhRUfUSMkYkiOEBGo6L9Ue3O2BZF26WP+rdz9HibOoEM+y6VxQ
         rQvjalwb3nRhDQj4XAAjuoAZ6ZjbaLr6TCYlLsZ+pAbmEaPJSjQMKzDttCT6mf1CjXMF
         9kT2hgJK3w2T4q4N0hyNLqaNoLHZWUCy1Di0WTGH+zA8Y2Jt9uK1r14uFWpU5FK77gDl
         gDIA==
X-Gm-Message-State: AC+VfDwSi/WYuzrAelTJIo0/BYcyIWfx10w97OGSDPj0expEY1XBuZLO
        Sd4CY5w6C1QD+7ll49GNpzvGOVfn0aaXUQ==
X-Google-Smtp-Source: ACHHUZ7e6YF3qA8j3O1SXF7x2ipjao3kDuDFy2aFmDC96qyOGRnTctavDFPt8PKv8TRv5N9j2UiNaa2FocZFTg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:d2ca:0:b0:ba1:af47:ff01 with SMTP id
 j193-20020a25d2ca000000b00ba1af47ff01mr10100895ybg.13.1683846970088; Thu, 11
 May 2023 16:16:10 -0700 (PDT)
Date:   Thu, 11 May 2023 16:16:08 -0700
In-Reply-To: <c902a166-98ce-afba-93f2-ea6027557176@gmail.com>
Mime-Version: 1.0
References: <20230427175007.902278-1-calvinwan@google.com> <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com> <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
 <c902a166-98ce-afba-93f2-ea6027557176@gmail.com>
Message-ID: <kl6lpm76zcg7.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> It would be possible, but I'd want to see some macros for checking
> invariants that print the source location as well as their
> arguments. I'd be interested to hear what you think of the alternative
> approach in the patch below.

I personally (not representing the Google folks as a whole) find the
option of implementing our own C TAP suite quite appealing. As your
patch shows, we can get pretty far even with a rudimentary initial
version, and I don't see why we couldn't refine it as we go along.

I'm concerned about the overhead of relying on a third party library
that implements something moderately complex and isn't widely used,
It's much easier to patch and read code that we maintain ourselves, e.g.
if we need to fix bugs/add features/understand its behavior. These risks
are quite real, especially when it's not clear what kind of support we
can rely on from C TAP Harness's side.
