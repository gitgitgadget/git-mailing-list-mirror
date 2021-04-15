Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB68C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0233611CD
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhDOIuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhDOIuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 04:50:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B929C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 01:49:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso1072860pjb.0
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F15q5PCB0okHskN3t2C6i5DUI9rdwvXJgYsyuo4asSg=;
        b=kS93S3mgSkcdkUn83rx7aT299fVZlI0Nqpri6FtdviREfGsTLdGL2OPnVJwrWC/zt2
         K+ZBc670CdtSmPfZZ6AISpzMEkaRxlEpeTAViW9a0g9oICB9Se6+d9aHyjUnDaj9K+rC
         msNqqfYf1KJwcOFg2hDMrsSE+xtqcbDmDk7ADr4ZlThnbJRRZL11s9EJIz5ilqzwW+zJ
         0nWzGS7mGB4z4o5ue9RP791wwPWpDrRHxNRXzkpRtBXHXh374NTephGKRkE6ey494i1j
         ugI3Gxo4zcDvhWucu8K43VRSqUcQMN8lhVHvev4dc/bKC18fdeCMG8yfoIHO8ijT3cm0
         GppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F15q5PCB0okHskN3t2C6i5DUI9rdwvXJgYsyuo4asSg=;
        b=jVKeHpptxBilxnOWK+6PrIx3/FMIWCnlUsr2jOK2PrEvrsTLSvI8PGWCRMw4M1GNdL
         Dt7bo1zdaeQ7WQaHshqIpc2+xYYf09FItJ3k+vlOZwpXzqqIG8n0V+FEDuWL3plLakDR
         HzVR6qpQee9TmQcBUR1KMGmij57ZDyeaqTFMshJkIXg7My5bXKNSFWMoW4YSArazCi1V
         maO6eTTFMfY9dHKwGuxm1eQ15uBVMOygCdTaMvJbqoDsrcrYenve4syMulejmpQXR/67
         eVpvEdJAvtnJ94Y1aVL7jYIBxcdRzVpRkZtLXnaRRm5OHWhbkta4kLo9aw9zLyChr9/1
         0Z5Q==
X-Gm-Message-State: AOAM5317+j2R6teqZOdda3VCCOhyGyV81YeJW3WQex5s0x7eEeKPe/YS
        8y/Du9H1VOmWp/Ul6BEoSoUynCcBgxY=
X-Google-Smtp-Source: ABdhPJzFHbqqn3O22BGhtjpBwVJ4QQiDCm3dRBPboeZ+g0h5n0NRsH0uHVkHKWlPdS7Z1wwDaCuYBA==
X-Received: by 2002:a17:90a:bb85:: with SMTP id v5mr2736225pjr.106.1618476592032;
        Thu, 15 Apr 2021 01:49:52 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id g80sm1545595pfb.181.2021.04.15.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:49:51 -0700 (PDT)
Date:   Thu, 15 Apr 2021 01:49:49 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Pain points in Git's patch flow
Message-ID: <YHf+Laph42liGPzw@generichostname>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <b562e614-add7-575f-3013-1dbc667bc5bf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b562e614-add7-575f-3013-1dbc667bc5bf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Wed, Apr 14, 2021 at 02:22:51PM +0700, Bagas Sanjaya wrote:
> 
> On 14/04/21 13.13, Jonathan Nieder wrote:
> > Those four are important in my everyday life.  Questions:
> > 
> >   1. What pain points in the patch flow for git.git are important to
> >      you?
> 
> There is no lists of "beginner-friendly" issues that can be worked on by
> new contributors. They had to search this ML archive for bug report
> issues and determine themselves which are beginner-friendly.

An unofficial and semi-curated list of issues exists at [0]. I've seen
many people new to git development pick up some beginner-friendly issues
from there.

-Denton

[0]: https://github.com/gitgitgadget/git/issues
