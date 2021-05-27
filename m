Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F799C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0572F613AF
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhE0QpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbhE0QpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 12:45:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E7CC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 09:43:47 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z3so1377423oib.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XbbxsQgAVub7hyVQLD8kSydv0Cn6OuH3DVvhcFY0vfs=;
        b=SzwT7fTeY7BSyQ+fYz2lpPg3xhDb/wgIA+VoHhRiFsvuwA5KGJQ/sy3sk+GAUYjfjZ
         nkBtfzhrFoGqmAzwyeKkbXeETxjKGAik5HBaFBUyGoH8fvmVwjV8HAU+hXH9ZgctQEZm
         HGqzwMuFwRdrlJ2UU7RrF+oQbGm6R/YdvCvDEGFRmhSHiFuGMOAJ1CezFBomAk+wZ8Wd
         skQUBmlNNCpHRdRkzNM/fU1uhFCsDP3EzS3oMGqoqr5AnMhmMTMi7Bu6WfoM1x0f45yk
         paivVbsxgBveDEsi5pWs5BZfhZauf2nTcm5ifr2eZe7dpVSZA+esOIOcG1m7ccKofuFU
         JJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XbbxsQgAVub7hyVQLD8kSydv0Cn6OuH3DVvhcFY0vfs=;
        b=tnAECJLFCQVF2PQ+qUX0BF7OVtTpkpPYVUCUgWPlwmNH/bN+cy/CUcxA8hfbfsDR4/
         o7Jd85TR1c9XXUZ/Jmzz1VjA6Rjk/YJ/gfwLfMc5U0RoT109KRUEVEntS7S24A+h5Llq
         OQvQ8crM0hOSwjBpEaop6NmcN3hj5izgY/5ZpTXYMDyQS+BDZvLOYUGH9c6i9ObvgjrJ
         7Nhqv9ZZYMlynsibrL0i4eYqHlPlUsiimEVBl9AYoDii4KDWCB0ZgEpPK4d5OCbJ57UY
         /SFELHIoBeFmS6P5pJO/f1qwDQiuaOuOde2bR4Fna4B6ecY0zoHvR99Wst39SyMMb2mP
         gKBg==
X-Gm-Message-State: AOAM5308TiNeumzGiPM5iTNjGcY42DOMIxZHS52Fh6rM2vkIl7EMhOsT
        WFTk47nBjG3aI6U7HJZcr+M=
X-Google-Smtp-Source: ABdhPJxOep41Jn/09/8ht2JhqS7zVmcR0bwUqGvYEey9kGddlran0wrlwTMImN6wB1sDSM+1lmKOyg==
X-Received: by 2002:a05:6808:1394:: with SMTP id c20mr2886684oiw.90.1622133827311;
        Thu, 27 May 2021 09:43:47 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a14sm571117otl.52.2021.05.27.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:43:46 -0700 (PDT)
Date:   Thu, 27 May 2021 11:43:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>, git@vger.kernel.org
Message-ID: <60afcc4169433_2653020844@natae.notmuch>
In-Reply-To: <20210527143541.GH8544@kitsune.suse.cz>
References: <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
 <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
 <20210527114629.GD8544@kitsune.suse.cz>
 <60afa7d9d4ca_2056d208d9@natae.notmuch>
 <20210527143541.GH8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Thu, May 27, 2021 at 09:08:25AM -0500, Felipe Contreras wrote:
> > Do you have *ANY* evidence that shows a problem with "effect"?
> =

> I find problem with the proposition that 'impact' should be replaced
> with 'effect'...

Do not avoid the question.

Answer the question being asked.

-- =

Felipe Contreras=
