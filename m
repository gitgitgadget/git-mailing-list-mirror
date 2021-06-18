Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C45C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 04:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2F161263
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 04:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhFREae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 00:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFREaa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 00:30:30 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E269DC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 21:28:20 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id b24-20020a4a34180000b029024b199e7d4dso1815124ooa.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 21:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JEcaDRbCH7swZtiDbpd8DHxFguho+oBlnnDRuIHzsi8=;
        b=TF/MElXrz2Qu4SzlKqAavq2bZVtWmiJU0jW+YoUrJbKPcjCAliUxWJW9Gf4G/lVf3L
         CNS0gzdQOSz+CK92n0U8KWfV6ddttOVbi9URJ3qt3BjyogmgyfFWPnBp/MqTvWT1ja2v
         7J5BL/vlKieSIXPt8xeFMeyARpbpIlADRGgl8qjnYNVtnZ5ZOrwPRdHds5zo2T3kaslr
         h0KCFLRFFBCtKJyEipwz3emj20wWI29tkOtpC9UkmjGK7df8EqzRFf65EEbh7DKrukWl
         4fmlwcCNVhgTd/hnORDxWsabWBvWr561g+29OPu7SITMCcC440vCC5Kjg4sDHV/5hLHv
         fzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JEcaDRbCH7swZtiDbpd8DHxFguho+oBlnnDRuIHzsi8=;
        b=FsY+/QURm12DeMhm97x+kfbIZLX5lYtLHM9qcBZ4O9z5+xVEN6q9CJM0olW+E0TZ7u
         XH4ix8OQ2Tu/LWCZPEIyNo5yor/mIVkVGHA2a2ymyLdUA6PgCb71ERb56CyHPAcnw1fN
         +4fWxvTRW7xooARBPS0/lGQ/cee8XBDH1mPgdweRHdBRf3gte2IHFGz8yKBt9GMeCG5P
         EMjSXkAppN+OjbomjwQUVaHYOg9ztKj0LlsTItMOKOlu/uemEKo77X8x7MR4YPAuJWZG
         sI0S3p6MmEn2U+E+dsy0cXS6Cs9wYXWbD6DQhWuiEszuSikcxqrOKzo52gt+8KXb2zv9
         5uLA==
X-Gm-Message-State: AOAM532hfLrK1vnEcd7vU127vEOSq+7ZzA/znj/tRs1zeG5x3QqwoliL
        H2p86dqCsfzSkT4h/BxeTj+XhO3luj0AzQ==
X-Google-Smtp-Source: ABdhPJwDXNxnvxjwicvKoFzC51LkAJXIzuyT9QTA/60zMH4yT2cZH1P+SEdfKYmLjiYg5ymp3Qnu8g==
X-Received: by 2002:a4a:acc8:: with SMTP id c8mr555967oon.72.1623990499657;
        Thu, 17 Jun 2021 21:28:19 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id m18sm1784923otr.61.2021.06.17.21.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 21:28:19 -0700 (PDT)
Date:   Thu, 17 Jun 2021 23:28:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60cc20e2361fa_5d7b8208fe@natae.notmuch>
In-Reply-To: <YMvofq5aSryQzpZQ@coredump.intra.peff.net>
References: <xmqqr1h1mc81.fsf@gitster.g>
 <YMvhoXVBoO08ziI1@camp.crustytoothpaste.net>
 <YMvofq5aSryQzpZQ@coredump.intra.peff.net>
Subject: Re: What's cooking in git.git (Jun 2021, #06; Thu, 17)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Jun 17, 2021 at 11:58:25PM +0000, brian m. carlson wrote:
> 
> > On 2021-06-17 at 02:55:26, Junio C Hamano wrote:
> > > * bc/doc-asciidoctor-to-man-wo-xmlto (2021-05-14) 2 commits
> > >  - doc: remove GNU_ROFF option
> > >  - doc: add an option to have Asciidoctor build man pages directly
> > > 
> > >  An option to render the manual pages via AsciiDoctor bypassing
> > >  xmlto has been introduced.
> > > 
> > >  What is the status of this one?
> > 
> > Probably best to drop it.  I think Felipe didn't want his sign-off on
> > it, and I don't think there's a good way to produce an equivalent patch
> > without incorporating his changes.  We don't seem to see eye to eye on
> > an appropriate solution to the problem, and I don't feel like arguing
> > about it further.
> 
> Hmm. I'm not sure if that's a good resolution here. I do think many
> people were positive in moving in that direction.

I don't know what you mean by "that direction", but I was the one that
included your patches on top of his series [1], not brian.

So, if your patches have anything to do with "that directioon", you are
on my side.

Cheers.

[1] https://lore.kernel.org/git/20210521224452.530852-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
