Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B7C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71961613C9
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhE0RhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhE0RhM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:37:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53BC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:35:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z3so1535129oib.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=1wG8tjCnniCswDnsZnz7nD0/gF0jX+n+F5qQHsCSaOU=;
        b=BgnbS8hrcS66oONpeNy+mAa8X/lgcF9fcHwHDYYqXf934fy1Z9n/nO3PmSBkZvwReZ
         PVTvIFmB+JET2T6zSDLSNLZXxDPVnXB0mC+weoWaBI7ixeaFsbVky24Hxy8Kha8hLfgW
         DcBHMtNm9vYBWBsuWX9AAcMrhfCuSXelUzw2ycN3MMapNUZZv15T36hfmgpby/PhMWhd
         jQdHcoZt/gEPa8vzoPaoH67OactnDqpkbBEzVBx4q8+ONFiqlzk96NdGQOJOB+054tGa
         d68WWfGhtlOFHT+RmY4DuDSvWiHxtgD8d8oNqYDt7Q3HWCiwR7VoA3Zj/t0eC2x+xDVr
         zF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=1wG8tjCnniCswDnsZnz7nD0/gF0jX+n+F5qQHsCSaOU=;
        b=CrUtu3qsGupHWzxJJfPUYoXAOKecVNU46Tclm97Ig3jipeQzys3h3FcWSS1AXTTEhm
         Jddm9P0Eg54+jJa8nTIBDLxqwIuN+0TXTlbc1fG1h6Db/7i4BI6W7j91yaesTt8a+PYY
         Jna5liF+Lwo0vrkJv9LuEfsltBZytLLMjqMFLD7AcOadJtp3kF11px4V6bCDq6Jr1gTm
         Ak6clQYxr4efoqhbxollLeH2KDyKCk66/Zi7+ubQ53uQywh0ytHGzg3PWh4nBQjB8w/r
         PzjURRWDBU8qD6gdU9X/VzR4OO+cgqC+kMoABKie2p2JzjJmTNjmkuUt40Q5iu6bpqi1
         6kxw==
X-Gm-Message-State: AOAM532Dyegyyxj1h2NKKUJtdEsyrkL5kmuNQrNJ+RPamemHsQ3QB/ct
        jMADATDorX5ySSNWNPcurqO3PgGCo6RIwQ==
X-Google-Smtp-Source: ABdhPJytGhrwIVJZmgCyip7O2XjJuRwHI7tISS/Fu2WOGX7GOgc1TBNd3ZPqnmXK6UeR4VK5aeZdpg==
X-Received: by 2002:aca:2b17:: with SMTP id i23mr3157987oik.87.1622136938264;
        Thu, 27 May 2021 10:35:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e6sm603829otr.53.2021.05.27.10.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 10:35:37 -0700 (PDT)
Date:   Thu, 27 May 2021 12:35:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60afd868b68ae_2653020870@natae.notmuch>
In-Reply-To: <YK/SZGTWd/tfSWeP@coredump.intra.peff.net>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <xmqq7djoj9z9.fsf@gitster.g>
 <YK+texFSW6UurDui@coredump.intra.peff.net>
 <60afcfec2d93c_26530208ae@natae.notmuch>
 <YK/SZGTWd/tfSWeP@coredump.intra.peff.net>
Subject: Re: [PATCH v3 0/5] doc: asciidoc cleanups
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> > > The "comments-by" sub-thread looked unproductive to me, so I mostly
> > > skipped it. ;) But as the person whose name was in the trailer, I will
> > > say that I do not care either way if it is included. It did not seem to
> > > add anything to me. Some trailers are good for pointing later readers to
> > > folks who may be able to help understand or debug an old commit. Some
> > > are good for just giving credit to people who helped. "Comments-by"
> > > didn't really seem to do either to me (and I don't feel like I
> > > contributed much worthy of credit anyway).
> > 
> > But you did provide comments, and those comments resulted in changes, so
> > the comments-by line is accurate. And for what it's worth that commit
> > trailer line has been used 3 times already, which places it in the 3rd
> > top decile.
> 
> I didn't say it was inaccurate. I just think it is not useful.

I understood. I'm not saying the tag must be there because it's useful
(I agree it's usefulness is marginal at best), I'm saying including it
does not hurt.

-- 
Felipe Contreras
