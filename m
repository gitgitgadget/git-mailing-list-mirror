Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C772DC4707F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D704613B8
	for <git@archiver.kernel.org>; Fri, 28 May 2021 01:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhE1BLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 21:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhE1BLk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 21:11:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1AC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:10:04 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id a7so1120964qvf.11
        for <git@vger.kernel.org>; Thu, 27 May 2021 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MJtcFMkj+qyP0e19pO+5PuFTy1m66q/hZxsM3nn1cOQ=;
        b=wU/2eqpPEqjyx1FY8+FMWVgkhngXtfCHcOr4pq7/amtN2SUqWKk9HGQov2UAZWq1B1
         hesEPkqDnBXndZxnCcOAXO4VV/DgLeHoImgF2hIKofY1reT7+ozXIUenCW/3GNpK1xH0
         uEPw781LLPpsBVo3d3om58BvrEM+8oHtIVq/AOyOrU1O7QC4LzKVdWCmwjcaw+138qGn
         NeIEZ1jq/yOPE2Mr5ovWPoGtvG+C5GBEuSl2SKDtG8OPRS7/BMM7Lbimq2cNQVAKmyZH
         /BT1xkVx6HpEW9obVK6R7Iu7wLmeajlnpHIrRgIsPSYjh3yTHEMi+tRCqwuVSt57xXAI
         NsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MJtcFMkj+qyP0e19pO+5PuFTy1m66q/hZxsM3nn1cOQ=;
        b=Df2qDQ5v3fgZtq4wv/jvDMwL5WtTDVVWiFgzGSMLxHWk2IAtK4UuPC0IIu+OAZCers
         3jo/zrcGsa1hNXphweFZRRoV3KjJTMv+N6nO0bUrckFkKkjys8jB0GujbdoH6cSGHrXD
         2IM0xpH172rAtilDlfZvoFSBk3oeFzT13uqu8VuxojoqokP2LoSBzICMStqb3//x5z2l
         yUk1iYE2lzdyHssY6alIyhvtoLwymDCxPz0hytyNGc1dTXC/BGJtRLj1ugTLGQwk8TeC
         EnM6JORHQ0j9ij81ySiCbANI9GTwx3cixcMSe2SX09UFtw1tu5Qc75ftRGEI341v1hYI
         lU5w==
X-Gm-Message-State: AOAM531P35j3H5KPTQWzIq7E47JoGwZcpIoDho4L6vsuYXa7kUWG+JYv
        4ClkJQsqtlf+lSfuVOxF4JtB7Q==
X-Google-Smtp-Source: ABdhPJxrxnqqbdg+HdlZEgd1eKO3LiCrBeeYHDl/DUmFQXRG84qat7eaoLjRxrNNzHy9d3vtE9171A==
X-Received: by 2002:ad4:5ba1:: with SMTP id 1mr1468343qvq.43.1622164203747;
        Thu, 27 May 2021 18:10:03 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e878:3e85:58af:261f])
        by smtp.gmail.com with ESMTPSA id z3sm2590905qkj.40.2021.05.27.18.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 18:10:03 -0700 (PDT)
Date:   Thu, 27 May 2021 21:09:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 22/37] read-cache: convert post-index-change hook to
 use config
Message-ID: <YLBC5eNBDHwb4TvG@nand.local>
References: <20210527000856.695702-1-emilyshaffer@google.com>
 <20210527000856.695702-23-emilyshaffer@google.com>
 <87fsy7lqve.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsy7lqve.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 01:04:40AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Obviously a trivial mistake, but it's a good idea to use git rebase -i
> -x 'make test' or equivalent for such a large series, perhaps there are
> other inter-patch issues lurking here...

This is tangential to this series, but I would add that `git rebase -x
'make DEVELOPER=1 git' @{u}` can be useful to run often while developing
the series and reorganizing patches to make sure that everything
compiles.

The benefit of `make git` is that it ensures everything still compiles
while avoiding having to link everything together. This ends up being
quick enough that I find myself running it often while developing a
series.

I do `s/git/test` before submitting, though.

Thanks,
Taylor
