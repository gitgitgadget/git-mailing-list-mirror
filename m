Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1351F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392225AbfITRhw (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:37:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45787 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfITRhv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:37:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so7554157wrm.12
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NzF61dLznpHFb2AxVNwCNGcJDDdqFOlg8vGvQHHyv+I=;
        b=qddNfv6tpX3JNdKtB2+JV5avmmXBeNrY94uonFF1+p3RYe5KtxbX0heng6s6JR+Z8U
         DAZ9BJBG/3hGkelW/owV9GEbH0bEXJFpFCyCY9rDZf+dQuE18IvpAQ45s6DvP6ILqabu
         D/c6iOg2v7+YevYyQjU6CvMloHHQJ5hGeCxTQyh15M9nW17fXp6T0Zh6eKV/2nU+FlER
         V/iNmY8rM6ZkkgqIkHn3Ber764pM1kdvu/U+yuK3WwEo0cldCl4kZF2lKXXdXAYNE7zz
         yU3hO3rAjN/xGAwFyRRPFdiQb121iYaf3X21nBD9kND66yuFzYR+eFiy/EbgBI33qERQ
         T4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NzF61dLznpHFb2AxVNwCNGcJDDdqFOlg8vGvQHHyv+I=;
        b=Z4MSKzCpky7+NZk2UY7KBb97sbPcZ799Ysj+eGsOmJ3vhjSb10FmHE0J6jZTvzra62
         7YHoRDTeSKYsiV+lbWnp99wk/p6WloTKe+tfjRoMdBTRgow0oCdGIu5jXZKu2JAVkEu4
         y24sSz2AJVHJfDEVZvv6GyiFfGBof7rmiyWxESq372nb9Hxfzu1f2TaRJhxMnFWHNegw
         YSS7m7sTU3zNM2TneM8Vxj8Wg8vERBWMUSeiascSWhOhOOycP855q4+sOkY5MN9QMZFZ
         AtKGk5E2nH6BYZMDf8Kh5fb7XDQjZBw63Jp6Im9hFfgKWgFqVLA5KG0CCHTdEpNXV1No
         5H9g==
X-Gm-Message-State: APjAAAUutLyGv8hwbwQo9QvYPWJTkFJHmA92TqaCNaqhIOv8a6aCyAQ+
        pIyzQbTJCgN03xrcOt5BIMo=
X-Google-Smtp-Source: APXvYqyJjChxrCeqbGIiACSl0Pav3mCeNCdAt6RqM1CMZXDRJkZWiDtdAjHGLgRzsthLoMmPAd0s+w==
X-Received: by 2002:adf:dc41:: with SMTP id m1mr11898454wrj.46.1569001069448;
        Fri, 20 Sep 2019 10:37:49 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id h9sm3014978wrv.30.2019.09.20.10.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 10:37:48 -0700 (PDT)
Date:   Fri, 20 Sep 2019 19:37:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/15] name-rev: eliminate recursion
Message-ID: <20190920173744.GA2988@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <62669882-bb48-6711-6f9a-b45db2e64da5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62669882-bb48-6711-6f9a-b45db2e64da5@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 11:37:12AM -0400, Derrick Stolee wrote:
> On 9/19/2019 5:46 PM, SZEDER Gábor wrote:
> > 'git name-rev' is implemented using a recursive algorithm, and,
> > consequently, it can segfault in deep histories (e.g. WebKit), and
> > thanks to a test case demonstrating this limitation every test run
> > results in a dmesg entry logging the segfaulting git process.
> > 
> > This patch series eliminates the recursion.
> 
> A noble goal! Recursion into commit history is much easier to get
> stack overflows than when we recurse into the directory hierarchy.
> 
> > Patches 1-5 and 14-15 are while-at-it cleanups I noticed on the way,
> > and patch 6 improves test coverage.
> 
> These cleanups are nice, and I think I followed them pretty closely.
>  
> > Patches 7-11 are preparatory refactorings that are supposed to make
> > this series easier to follow, and make patch 12, the one finally
> > eliminating the recursion, somewhat shorter, and even much shorter
> > when viewed with '--ignore-all-space'.  Patch 13 cleans up after those
> > preparatory steps.
> 
> I responded to several of these, mostly with questions and not actual
> recommendations. I do want to apply your patches locally so I can try
> this --ignore-all-space trick to really be sure patch 12 is doing the
> right thing.

  git fetch https://github.com/szeder/git name-rev-no-recursion

(But this is sort of a v1.1, as it already includes René's suggestion
for patch 3.)

