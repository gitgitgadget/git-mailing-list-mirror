Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D1C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 13:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BEC613C1
	for <git@archiver.kernel.org>; Sat, 15 May 2021 13:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhEON1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 09:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhEON1M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 09:27:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4175FC061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 06:25:59 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id f184so2209545oig.3
        for <git@vger.kernel.org>; Sat, 15 May 2021 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=T+N24sDBmvlWItuYArKtgiAw+//2Z6rEV+0bc6MG4rY=;
        b=Sn3kayHiESXubWBItD4NFYgzWorzEIy2WprXYYhSezq/sOWGjo1NF9ASUm656quj6w
         O0Gp+dBZ9tJ4PprwMLvIRMFmRgomY0tu/IWETg18J9PXfEsxTlpUbW2KTouY3mQfywIx
         YMmRjxxTRjjJ9EAcjsS925NCsiShRlGK26NMGdExlFK1hTJOK8Uwj82vutlJyFK4SWOK
         AtX5H5rNMevIx7Wq7Lw6wpXfFyjWAL6Xk3GLoCkC5HOyzOL6BhfqxBBKwUHiEsHoYs20
         oo4c46qdLBYmOGG8H7nGqlIm5ggzrYf+KcbFZxxB5c4nV2EayxV0qOKWxCwZ3DzTz3db
         X1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=T+N24sDBmvlWItuYArKtgiAw+//2Z6rEV+0bc6MG4rY=;
        b=T2AhpV5lXUd6oSFeup14TwXYdWhocGRexPcbnjAzBZr76heKQo20xRFNFXrAfpgnFE
         SRHf4YPNX4ujr5auF/C3XG2J9sXyRqcE4IWqB6bmukVQZn3ekI0iNFO5rCUEsWn7CtTm
         SUmw0RcDg8tJg3HvCRG4qyXPJDlCifUHnQ4MZKbA1JFikzgGPPfRy7NBFVgFBV3+8FrQ
         IYr58u7vy4cuohTz2bL2Q4mRQc+bfvSC1GPLvU+Smzk3HP2ieO5ak+zKgumIGsxsTNTd
         VSV6141An7BClxItIjFfl3ljnL4T5iZTYNRxxYbGaTykIBrheiQs72D134bx9QV9pOUh
         HM/Q==
X-Gm-Message-State: AOAM531ZYgafxOnJ6Klr+FdH3QN2aCyKXznpOJgiRrWwESqxM/CpQuhf
        SDDyj/1gNWhc34+JUVxoryg=
X-Google-Smtp-Source: ABdhPJwGLgNOk3gpy44zgkiV1GUzL5+tDK/TuMy8iIcc5AzX+6pWF9liaXO3strnVXj1gnxN/3thqA==
X-Received: by 2002:aca:5c87:: with SMTP id q129mr9413684oib.163.1621085158685;
        Sat, 15 May 2021 06:25:58 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l11sm1889777ooq.44.2021.05.15.06.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 06:25:58 -0700 (PDT)
Date:   Sat, 15 May 2021 08:25:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Message-ID: <609fcbe4e00f8_c10bc208b2@natae.notmuch>
In-Reply-To: <YJ21Qfnk0tpPgPqu@camp.crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <6d56412a-cc67-22fc-717f-9fa218264b40@gmail.com>
 <YJ21Qfnk0tpPgPqu@camp.crustytoothpaste.net>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-12 at 02:48:59, Bagas Sanjaya wrote:
> > On 12/05/21 09.11, brian m. carlson wrote:
> > > We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> > > contain proper handling of the apostrophe, which is controlled normally
> > > by the GNU_ROFF option.  This option for the DocBook toolchain, as well
> > > as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> > > instead of a Unicode apostrophe in text, so as to make copy and pasting
> > > commands easier.  These newer versions of Asciidoctor detect groff and
> > > do the right thing in all cases, so the GNU_ROFF option is obsolete in
> > > this case.
> > 
> > At what version of Asciidoctor the apostrophe handling is corrected?
> 
> The first released version is 1.5.3.

I just went ahead to check that, and from the very first commit [1]
asciidoctor generated quotes compatible with groff:

  git filter\-branch \-\-tree\-filter \(aqrm filename\(aq HEAD

So it has *always* worked.

You can see it from the code:

  gsub('\'', '\\(aq').      # apostrophe-quote

In fact, they never changed that, so it should fail in Solaris, or
anything that doesn't use groff.

I've sent them a fix [2].

What are these "newever versions" that do the right thing in all cases?

[1] https://github.com/asciidoctor/asciidoctor/commit/7bddc416c92ff9d16c721b03bda7ed80c1e4c45f
[2] https://github.com/asciidoctor/asciidoctor/pull/4060

-- 
Felipe Contreras
