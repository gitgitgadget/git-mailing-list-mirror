Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ECBFA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 00:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKAA5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKAA5r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 20:57:47 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965FE007
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 17:57:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 63so11183689iov.8
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 17:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnNA2sPQDku3x1dTf7qlSL1RffeJ4hF/SZpW/BFooJo=;
        b=UNVkBdR+qcQ9RjPPc/1HfUUcUHnm/PhBtRPgB9gIXCDKXzGRWZVlWkvv8+u74b12F0
         6Ns8mEgPIS36lDWOPRDo1OsF/tMpKicoI/EhgT7wtSmlGAMiftmYZoI02wJ5jaOlGxp8
         YRV0b3hiqDCFVbf2Ebqz/GKDLg80L2jLM1yfCU1AmKY/HKYEprwcJsjiPO9FhnjQcjAK
         rJHO2kyaLipVAkd06PfOV16nlgfpSuigHTy4cFxzj2barvii55Pti5sPmQwdViFChiv5
         CGLhvS4mdRDZt2cIWcOveUejqi7+QdR0TSXRXDpupwcfNmQOScbPxasY/KDT/3xl75ao
         kKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnNA2sPQDku3x1dTf7qlSL1RffeJ4hF/SZpW/BFooJo=;
        b=ryReu4pla7KZRxGa6as3C8ATlaaAGKu5LMBtz6So3+MiwAxqrSB+n++fTgr98BVfZH
         /bNYF1PkcWigqzFISZM5SUa95nL2jjD1ErHztBe9ACdIZ65k800A7XOO3rOhfOCu/7ZQ
         lzA8YJY0e3mILoDsVXBxsA0eLEe7ABJ7P1HLuu+fKu1adiL7M6veblYDpdJJOEyW6GOu
         wylHqnyyGPjwbSwMXUmERDQfB2FW09diZlJqqDwrtIDLOSWDp7+zgHxKr17WAdUtY94g
         kSIGePVdkk3QXnv7mzkJ0W7zjWTxLttb4moQqDtRCSVL9ydl5BntZRnlGpYMMU/brqwe
         Ctgw==
X-Gm-Message-State: ACrzQf2rFwfv+7slAdMjMUaSm44nD41vOStWu5XhQY5wWs0Wvc/w0nWo
        zvvo3LumvT5RcGfHs6G2wgv6OTtH9NHgimuB
X-Google-Smtp-Source: AMsMyM63aJIRkJqnL5sDeM9OcIuJJu5U4t0lvcSR1i4XZHTW08B8NvVzxtKq6loW+MxOA2BkCoAOYA==
X-Received: by 2002:a02:2b02:0:b0:375:29b5:b896 with SMTP id h2-20020a022b02000000b0037529b5b896mr9693685jaa.258.1667264266119;
        Mon, 31 Oct 2022 17:57:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o5-20020a02cc25000000b0035a9856f380sm3430213jap.43.2022.10.31.17.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:57:45 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:57:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Message-ID: <Y2BvCMlWNKnKR6OE@nand.local>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <98fa5270cb720f2f038c4bb9571c7d306ff5d759.1667245639.git.gitgitgadget@gmail.com>
 <Y2BYyB3H9n2LDo/E@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2BYyB3H9n2LDo/E@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:22:48PM -0400, Jeff King wrote:
> > diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> > index 8dd4610a8c2..980c594940b 100755
> > --- a/t/t5516-fetch-push.sh
> > +++ b/t/t5516-fetch-push.sh
> > @@ -1860,15 +1860,15 @@ test_expect_success LIBCURL 'fetch warns or fails when using username:password'
> >
> >  	test_must_fail git -c transfer.credentialsInUrl=warn fetch https://username:password@224.0.0.1 2>err &&
> >  	grep "warning: $message" err >warnings &&
> > -	test_line_count = 3 warnings &&
> > +	test_line_count -ge 1 warnings &&
>
> I think this test_line_count (and all the others) is now superfluous;
> the exit code of grep will tell us if we found anything.
>
> I don't mind it too much, though, if we're planning to fix the duplicate
> messages, at which point it becomes s/-ge/=/.

Yeah, agreed. Let's leave it alone, unless somebody else feels strongly.

Thanks,
Taylor
