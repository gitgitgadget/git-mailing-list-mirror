Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1668BC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 22:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC2A61358
	for <git@archiver.kernel.org>; Fri, 28 May 2021 22:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhE1WXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 18:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhE1WXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 18:23:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191EAC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 15:22:00 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id x15so5706768oic.13
        for <git@vger.kernel.org>; Fri, 28 May 2021 15:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ROYWrrBHIGm32SI6QVwBDSrXoybREOdyqXkplQ9s0r4=;
        b=DEYkArzRwBxx+oJP57opu9/RgjWKK1X7PfKeBzq4ZyCRzLLBKpIYPHdkQepxVpS6rM
         6QQTpRJpFVDvkgfM0v0nwihvpUa5YB7Z92aD/KRxrGw4jneV0p75GAIQK57K1gjS9CHP
         +wJ6f/Bf+DMMN7A2IBwUI8hbDOTkx29GefdZac+3Hh+YefffJrIVkh1C+S2Ba2rmW0En
         wkOtbMpVZh4NV7w2rfldj4lZmjHGYBMqS2OHuled6bBYQKKcO+vOScu1yiZFHKZ/NBgB
         YJCE18+6jKveVNfPHFEsUzKw5mBFNQp8tkQuBUZ/zCdsgLQFoFC19+XtNnSKaLs/oSXh
         St3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ROYWrrBHIGm32SI6QVwBDSrXoybREOdyqXkplQ9s0r4=;
        b=lPRzoQ6EhYcnGDIb6JJRlGaxirUnKnX/iQOnH5oapmvZcIcshe/H2AZBLYy1TDfSNl
         i4aTFvq5KqQSJQ422MjV8gp5nEo/JgdNf+pcr7dpxzGN0UrvLlyuxwejR1q7T/ZObYjr
         r2IBe/awLMD9+LvLWRt093bQCtNVxCtu3OszKT7VXkTPNkmdtXBleyqlrLmP/SakijLl
         gBcVFn+oWlv6nWkRVkoPG7OdBx4UNRig948w89krJEr7/RF7+lxQTo01apw07kquT8Wa
         47sJynvKBZlBIg5rcVfc9lY0LjwkTXoteN02zJYMG+jf2QSlrcBRS+Cs46h4WbCH5j7I
         BJ8Q==
X-Gm-Message-State: AOAM530pFnqFax0UMiwv2t2tnNT6hgY+jpr0wWRuUb38Lo9xnkzjLH3u
        xjHgagChc3fCrOpijahJzizCyk+GuIKeQA==
X-Google-Smtp-Source: ABdhPJyBuwyEvxSJb+v67N9utXeyi1nMeH6WA0QST0fsGJK42x5ht/CrtnzTzdN6/XKbSv2XA/LavQ==
X-Received: by 2002:aca:6501:: with SMTP id m1mr10757088oim.0.1622240519533;
        Fri, 28 May 2021 15:21:59 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id n17sm1395472oij.57.2021.05.28.15.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 15:21:59 -0700 (PDT)
Date:   Fri, 28 May 2021 17:21:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b16d05d87e7_2a3a9a2088@natae.notmuch>
In-Reply-To: <CABPp-BGEtJqorUeQ4evWdmCvb=zsnkAdOn-ToG48=AYp3aUwNg@mail.gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
 <CABPp-BGEtJqorUeQ4evWdmCvb=zsnkAdOn-ToG48=AYp3aUwNg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Unconvolutize push.default=simple
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> 
> Is "Unconvolutize" a convoluted synonym of simplify, untwist, or
> perhaps deconvolute?  ;-)

Indeed. Does it give you an urge to remedy that?

> > Tired of jumping through hoops trying to understand what the "simple"
> > mode does, I decided to reorganize it up for good so it's crystal
> > clear.
> >
> > There are no functional changes.
> 
> A couple tweaks to some commit messages would make it easier to verify
> that you have introduced no functional changes (at least for reviewers
> like me who aren't that familiar with this code area).

I'll wait a bit for futher comments and resend with those changes.

Cheers.

-- 
Felipe Contreras
