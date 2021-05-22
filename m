Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64075C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3894A61090
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhEVV3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 17:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhEVV3W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 17:29:22 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2BC061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:27:57 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso5426454oop.9
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jv5HqRL7KVDs5sBUHGF6pPU3E5ZKNzoXQJV27AsPWo8=;
        b=lFY0UdDtCSQDpcERog67VjsmBQ3TIJNGYBlVxBJh7PpIfVjGlXeom1QAsKtCX3qFyB
         zbNlk5UHUZC01F0wNapjb8cdTovpDnyUzPaXLi3fUicKm1txm6D8gOGYIijlp/KclhnZ
         nfcCrHDdS7SZDzAcarzll7GsC7n55hRtFf+OxtsA/L3eTlZitrOdlgBu9QdB7FN6qYaL
         QLiWuKttVlK+sGxnRE7TxJfO20BDR5cWTSXYDF7xxkzvPZoKRIjCeayZHWfIi/fssWn1
         ZVswpGZDLz5iO27/gf6lbQobP65jDOYgQRybvOr3IBN9PuH+Ysm2X/hnjrJa/wKzRYKJ
         TL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jv5HqRL7KVDs5sBUHGF6pPU3E5ZKNzoXQJV27AsPWo8=;
        b=Pmfvd6BE+QcxOJOMSyHXuxEf/FllCE0S1scmt2SBn3BcNdBSjkr3N4XmsmkOg3rkUQ
         u1lNslRtm/4AxDoIJGlkm5pXBlFzAgVyVEZHdCx9tOblg87qgv3Yxp1hj/w8K0wC/CEv
         gZ7/nWDVqXOKA3ORO3MgWwFmBea4Rg7XHuqf0iOVaSh/oeLtLm8t0MgxcT/cWidXmg0H
         vqLeDhRCJRGNNtz8YmxL08+Aq7YxQgl56rtwAOHk3glW7Mu73OnaObgQ5rf23L0wU2Ei
         i8Q0alnob18jhtcdhXZqow47goiOW2gCMWHMYtmXl4bMx+iedcaR5XiiuqmMiNgKPL0u
         piqA==
X-Gm-Message-State: AOAM530CWFIC1uIWj9kbfHIXUxHDI43eadICYjsHPs4q0WjwtUd1Fzn2
        jbqcNw9pfYbLI2dyc/pO1xYR5mfpLobX+w==
X-Google-Smtp-Source: ABdhPJzEX2n46T7qgL+duxS6G6WSphbeQuFbcYiP0qnSFVUMNyJhKeljfHSzVErzmuorhfI+frZS6w==
X-Received: by 2002:a4a:b085:: with SMTP id k5mr13248012oon.20.1621718876023;
        Sat, 22 May 2021 14:27:56 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id d19sm2129096oti.57.2021.05.22.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 14:27:55 -0700 (PDT)
Date:   Sat, 22 May 2021 16:27:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60a9775a494b5_857e9208ca@natae.notmuch>
In-Reply-To: <0c4ca3b5-7be4-1cdc-fbf1-b7a1541fe4b2@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
 <20210521224452.530852-2-felipe.contreras@gmail.com>
 <0c4ca3b5-7be4-1cdc-fbf1-b7a1541fe4b2@gmail.com>
Subject: Re: [PATCH v2 01/11] doc: doc-diff: set docdate manually
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 22/05/21 05.44, Felipe Contreras wrote:
> > In order to minimize the differences in the footer.
> > 
> > Asciidoc automatically generates a date with format '%Y-%m-%d', while
> > asciidoctor '%F'.
> > 
> 
> %F is short yyyy-mm-dd date. AFAIK, it is the same effect as `%Y-%m-%d`.

Right, I noticed I was wrong when trying to use -adocdate in
asciidoctor. It's actually ignored.

The date format probably comes from docbook. The commit message needs to
be updated.

> > I personally prefer the latter, so only modify it for diff purposes.
> > 
> > Fixes tons of these:
> > 
> > -Git omitted                       01/01/1970                        GIT-ADD(1)
> > +Git omitted                       1970-01-01                        GIT-ADD(1)
> >
>   
> So, the asciidoctor generated date was the bottom one, while the asciidoc
> counterpart was the above one, right?

Yeap.

> The above one, however, was actually %m/%d/%Y.

Indeed, the commit message is inaccurate.

-- 
Felipe Contreras
