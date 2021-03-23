Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB1C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 09:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0312261990
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 09:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCWJRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCWJRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 05:17:03 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB23AC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 02:17:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m13so16281827oiw.13
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHzwqmfsvGXAQgCmwch663S2Qyqzn2l04BTNoMyqzo0=;
        b=i5WHGDhYXq+SSRNPmPvhOokl4szH2DOgvpoQzpMtk3iNu0XBdfGW4Blo9AKABuFlwE
         dqSq0ef2gqmQu/lJJ0e3kIVulKJEpfcTE7iWWFegdqVtE+U6DbiwDlp0djw8M3LlgHTl
         nq/cn/GeHsHdnH/LQgC/150dwoJaFVRg0oMB6J0m4sqiCJxPf0JAa2X0pQZ9mLmIjjuV
         BOSE+kNWNpF+W4bBc6keqkqG8Is9rjJypMrbmBwa12c8pV4ui//pV1dDWErGOExfLsa7
         cfhXfgkP6gDXARm7ub4O95WyWOnaAX3gJWLmgIk0KpT4oF2FOZtfSamgw5SkCa0O3ZRV
         SFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHzwqmfsvGXAQgCmwch663S2Qyqzn2l04BTNoMyqzo0=;
        b=Kv1kbgOH0vStNk7u4jGM9Xyee7mCDSkdaxvq1nwowDeMLX3YyZ4E+6K6mKTOMIpvSa
         xb7LZVqSRXRkh3ZbaKjQXbA1XwVBk9aNyjBZDl2N5a4BxvoflxCuVbDy9dUrrzPx3L9i
         o+AMnxMuRbWroRfko6nmXFShEthfCLKW/LaZ3XxTf9Wt9IRitm1WffAU3N9b6YQL+s+t
         Vc3e4K+5Zap8eTieuaJMHyKDAp+gKcGhXTVIKTAU5MZfbVOP0Rm6J/ZVfTKblyd4U7cN
         NJB87485edCHptKITUvUcn9Z9GsWX79xHOEDHkzx+ME0owGv/upp02rP1LwmVQyIxTaK
         hvlg==
X-Gm-Message-State: AOAM531L2ADezYuG0dZYVvfVpP2ixw08GI92ZtTKyjFSJxUj5ZcUelEG
        8Gx3j+qPlw58UawcEm5afiCagIKQf0964MPAzsQ=
X-Google-Smtp-Source: ABdhPJwbItqaWfTrThxZLdrS61XpQgC0pJBRzBYbiLLazzazBr7Z6BrUKsGOrcqZLQ+ejai0ImaubyuqEcuIbu0DTgw=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr2684603oig.179.1616491023279;
 Tue, 23 Mar 2021 02:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
 <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com> <CAPig+cQ5jBc-fz69ygpWUP7uCVNAT8GT_01y6GnxDEa6XDNZ=g@mail.gmail.com>
 <CAOLTT8QrqDFj+ZGFRqDWDixj6hvdsF8OqYsac5J9WP2Yc+zXRQ@mail.gmail.com>
In-Reply-To: <CAOLTT8QrqDFj+ZGFRqDWDixj6hvdsF8OqYsac5J9WP2Yc+zXRQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 23 Mar 2021 17:16:47 +0800
Message-ID: <CAOLTT8T+SbCOm-LV-V=rO2uiYFhX9zHsEnT7twFppcMNzf4EsQ@mail.gmail.com>
Subject: Re: [PATCH v9] format-patch: allow a non-integral version numbers
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Note that the `grep -v` is casting a wider net than it seems at first
> > glance. The `.` matches any character, not just a period ".". To
> > tighten the matching and make `.` match just a ".", you can use `grep
> > -vF`.
> >
>
> Yes, `grep -vF` is very important for the correctness of the test.
>
Correct it, I still have to use `grep -v`, but I need to change the
'.' to `\.` .
