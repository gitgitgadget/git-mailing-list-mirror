Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B91DC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 00:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKEA0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 20:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKEA0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 20:26:10 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE28326EE
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 17:26:09 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o13so3383452ilq.6
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 17:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfr/wOO0Uh4Isw8uWWGIJucGGWT1Ri0XcUfhMSl5BaE=;
        b=TXLhPoWzt9QRsEpcZSN7w6T2GSFSC8biIuqVmMOj3oFeU+crmX5bgRvHvCiCbMQsVe
         6i2z+aIY7FpyozhgZLxXucmgCpUeHf8yEtwCt80DOUmQ54rizkWWwjzJvaDqGXNVgLWf
         unIndsH3PlsSExprE0mYcGH9EBYV+3wnWcfAidApnQNLOfQkHj1TQ08QhCUqvTL+ZRUi
         Gz8CHjHITrt6L2Q9mF1gQGHwG1sfNRDHpV4GxfRkQEYBbLVu/BqcIZVNB+NFk7S2xWvT
         dKf0cARTMBUBGSKTLwTKuz4b7LJgItPQoPmdb6PkNlfnEkeILCXcfGEjUD98funIdaWi
         z2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfr/wOO0Uh4Isw8uWWGIJucGGWT1Ri0XcUfhMSl5BaE=;
        b=UwoOhoOvYf2R7jYKVJ2ivVy0imWuvFewnfG3b2jrr4m37z/IY24cw6Nj7pI/RROEfa
         hzoPXiMgiktmXy4Pqh9XtySTGylIf+ejeiMF/KbktkD2tiL56+yz/ziUSv1+mkCnJov9
         jX+/YiLiw1dJq/EkeF6kleQm4Q987RGuf1SUzpemMYvvw6E2c/SPz4jYtBgYPnMJL+7n
         dpd9SCTDupL1CKLloXSziDniW30qSCzpC3McXxo9U0Sg3jCOcHj6+TuPaM481YOjS6B/
         30JyiA/Iss+XEhFISsbc9UpBabU/AiEG0O9VykLNMEUY0u79RCtlmBaZgJ/Hf82mIDnm
         7lnA==
X-Gm-Message-State: ACrzQf39KOLDWUKZB+AaL1+AOsShH4DZHENOW6ZC4vLnoXq3Jit8pNnV
        NKlLhNVFGA5Hrmy7ICoviZiYRuIqQ8zH3hpf
X-Google-Smtp-Source: AMsMyM6IcDSj8EjgMDLUdlFvX9gmR7PIzeIcBsxfPWDLKt5NA3l5qashdmCu/cl6BI9kDcSuglebTg==
X-Received: by 2002:a05:6e02:812:b0:300:d199:65ef with SMTP id u18-20020a056e02081200b00300d19965efmr8688704ilm.136.1667607969140;
        Fri, 04 Nov 2022 17:26:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a3-20020a92c703000000b002e85e8b8d1dsm342356ilp.5.2022.11.04.17.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:26:08 -0700 (PDT)
Date:   Fri, 4 Nov 2022 20:26:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #01; Thu, 3)
Message-ID: <Y2Wtn0wKhbQrScGU@nand.local>
References: <Y2RldUHTwNzmez73@nand.local>
 <e1c10d50-779d-2a22-b0c6-83bc0769ea37@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1c10d50-779d-2a22-b0c6-83bc0769ea37@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2022 at 12:21:23AM +0000, Philip Oakley wrote:
> On 04/11/2022 01:05, Taylor Blau wrote:
> > --------------------------------------------------
> > [Cooking]
> > * po/pretty-hard-trunc (2022-11-02) 1 commit
> >  - pretty-formats: add hard truncation, without ellipsis, options
> >
> >  Add a new pretty format which truncates without ellipsis.
> >
> >  Missing test coverage.
> Is that out of date? V3 did include tests in t4205 and t6006.
>
> >  source: <20221102120853.2013-1-philipoakley@iee.email>
> This source is the V3.

Yes, thanks for catching. Indeed, the version that I have at:

    git@github.com:ttaylorr/git.git

on po/pretty-hard-trunc has the new tests. I think we are still waiting
for review on that topic, though...

Thanks,
Taylor
