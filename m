Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E4C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiEIP1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiEIP1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:27:39 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C32AED89
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:23:45 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id js14so10662616qvb.12
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pI0wLC+vINEf4VQWknqLaKxfOxXk2N7LG9OsvAf1kks=;
        b=0N+r454e8KsfbdTWwyQ+ZaaTCNlH5lfDMARMTVpbdIU5uVox7wVIs+L58qQ1gheVAF
         dynUrdUhmNR0+GI8ms3qKcpOlDwCo87UX0mIsy8BGQamyEc3vcHBvx8ibAQpx7aMF2nC
         eIYJyh9C9xH08i7yQwJon+YkJyCObU6uHdAHc12GYxKiFVNauiZXg38PkAtmADyhKxZw
         1cTUwiYrsfJC6cOmoo/sKQpIxKFyJXczE2WlHC2PtOcEhIDg3p3XyqmzIug7dBrhyY++
         ULPcK7EMcKPgWSAFpH1oLfV4/IHW9Dm6oTnpkBf51wRLKyi9QwhSBFGTBrxjehYMAsgW
         HGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pI0wLC+vINEf4VQWknqLaKxfOxXk2N7LG9OsvAf1kks=;
        b=1Fj8foNtQ7UqUJr8RJ4TXixhoddefR5hrPHuUCQ5+lFbvh/y88sC9EzNv+qdtPNv6R
         54040aBqYTcxJgHAt3xMBuWKw6nq5f/8sHAggOWYKgEHWHt1K90hNHRHZg59cOSSJ3aA
         SJtl5VSa47c0dG23YfvrQClOIgZ4pneeSjITTP/zutXg3/PIDIZt/0806+quJjt/Td48
         9plYArs+aKQmq1vSe8AlwV8SfMtYH6mQcfg5yReUf08GBIL0fH6/4b3cCDyzic+NLYEV
         QqEQU3L8kYzncg/vDw+Ma2DqCh5xj6HkFlZ4xKhNyAKMzxJ4BEvSIb247Jd0bg3Cxa8l
         C+DQ==
X-Gm-Message-State: AOAM530SzCjnWlfMDYxV/HFxd98Rgu3BMviaVxPUNgGnzMQdEIv4kgAP
        35/9v1EiGmgperSzHhpGXtzvSw==
X-Google-Smtp-Source: ABdhPJwwI59SbVOFjQKFOOUC4TDAFPTg647e8lHTBOIfZ8oi2fPYEXG+qDrHr4QuVSQ/ceNmwgrrUg==
X-Received: by 2002:ad4:596e:0:b0:45a:ac4d:2395 with SMTP id eq14-20020ad4596e000000b0045aac4d2395mr13524616qvb.81.1652109824455;
        Mon, 09 May 2022 08:23:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 18-20020a05620a06d200b0069fc13ce213sm6959903qky.68.2022.05.09.08.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:23:43 -0700 (PDT)
Date:   Mon, 9 May 2022 11:23:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Crashes in t/t4058-diff-duplicates.sh
Message-ID: <Ynkx/nI67uOUDhL9@nand.local>
References: <YnOQmVFVRuqnanMi@pflmari>
 <YnSWgDdxgm+XWiLt@nand.local>
 <YnT19KB2XkBrJOLQ@pflmari>
 <xmqqv8uioc7p.fsf@gitster.g>
 <CABPp-BEb8saqS0awK77y+-3oB1LAOPwOw-2dZU=67wJOKLBS1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEb8saqS0awK77y+-3oB1LAOPwOw-2dZU=67wJOKLBS1Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 09:14:07PM -0700, Elijah Newren wrote:
> > That commit talks about "trees with duplicate entries".  Does it
> > mean a bad history where a tree object has two or more entries under
> > the same name?
>
> Yes.
>
> > We should of course be catching these things at fsck
> > time and rejecting at network transfer time, but I agree it is not a
> > good excuse for us to segfault.  We should diagnose it as a broken
> > tree object and actively refuse to proceed by calling die().

Elijah would be able to comment more authoritatively than I could about
whether or not these are easily detect-able. If they are, then I think
it'd be worth doing so and calling die(). But they may be tricker, I
don't know.

Thanks,
Taylor
