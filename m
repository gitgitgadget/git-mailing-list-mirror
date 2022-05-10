Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3226C4332F
	for <git@archiver.kernel.org>; Tue, 10 May 2022 18:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbiEJSdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbiEJSd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 14:33:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C236250065
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:33:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dk23so34678013ejb.8
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZ4hUhXbh1MqDjxLhH/rVOI6lUr7UJvewf/np6M/fPo=;
        b=XJaCd0fmTZR+DrH9fbKMlAS3+gcJCNMmFj3BDFTkb51eAibs95CZPqzAfmItM8kaUU
         rxMRe8QF7b42l6PXUUOOcTwg/8cSe3O7twobx6wvKbc4ub7geSavtA+dqkGROgytcqFF
         Y/74rzo7p9FY/OtxKOYydCFHm3rkq8fUo6fAYPHb8NVpVmofNvx/rlCmB4gQr/rQfnz7
         rzPZe55h++HKEoKf8iuhFzUH3l/8LFeStarCbwaII1qeOVWXT3PJ8kDRsJ7twDFvTtMe
         okyElRCeiwCp5URbiuSEb1heqoAmfPzm2BbTRj1asBHcisu4+1e3dCcTdo/WZuySe11G
         XeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZ4hUhXbh1MqDjxLhH/rVOI6lUr7UJvewf/np6M/fPo=;
        b=PilCPdiB9aCj++BQx128getASvsvGlX+mZfaqkr7kLZCNDAwP/6Uh8FPjXTOCsV7sU
         +gZ8UH58RkYpCk3pNzPOW9HKGPxC462k3vOOhSK7jjszFvPw/fBQtVoisie6QBl+8siV
         0JzHE6LgM4h1NtVuUCMfkInQZyHw3pP8AHzsIpkQpSZAPp1iWXKGmv6Z0ai2xLRFyC/Y
         b+Q30R1AiG+0LmiT4lS+f4Pa+jo/3Wurw6uLcWG/LPqIbTMxeHmAR12/fQzPgP3OzwvL
         oUjpacNdNv0ixI9DczzAb61YqzfdSCvgZd853TduOdKE2IxriKESH+DdI8vMmUq2OrhE
         Jymg==
X-Gm-Message-State: AOAM533iRUxpNUGxvVWjQl6mGTiDacwm7TEIfx9b453gae0x07JN3IzF
        chSFvWs5eNF7dhMwWWHiqox+mXBBFWs=
X-Google-Smtp-Source: ABdhPJynUtz51e5zsLO/UVAqQZz4Xct6HUli5VywCB4hTgKBK0p+dutoLSAGa7fhtzTQG+HuAy7PuQ==
X-Received: by 2002:a17:906:753:b0:6fa:7525:45f7 with SMTP id z19-20020a170906075300b006fa752545f7mr10866673ejb.598.1652207602323;
        Tue, 10 May 2022 11:33:22 -0700 (PDT)
Received: from localhost (92-249-246-75.pool.digikabel.hu. [92.249.246.75])
        by smtp.gmail.com with ESMTPSA id j23-20020a1709064b5700b006f3ef214e6esm14346ejv.212.2022.05.10.11.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:33:21 -0700 (PDT)
Date:   Tue, 10 May 2022 20:33:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is
 ignored
Message-ID: <20220510183321.GA4408@szeder.dev>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-3-szeder.dev@gmail.com>
 <xmqqr15il0uo.fsf@gitster.g>
 <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
 <xmqq8rrndb6h.fsf@gitster.g>
 <20220429190625.GA1626@szeder.dev>
 <b6deba3f-9019-fb6f-7bb3-cc2f647dcff6@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6deba3f-9019-fb6f-7bb3-cc2f647dcff6@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2022 at 03:19:01PM -0400, Derrick Stolee wrote:
> > And we do need a subshell to set the
> > config, because without unsetting GIT_TEST_ASSUME_DIFFERENT_OWNER 'git
> > config' would refuse to touch the config file.
> 
> Ah yes, of course.
>  
> > I think something like
> > 
> >   test_when_finished "(
> >         unset GIT_TEST_ASSUME_DIFFERENT_USER &&
> >         git config --unset safe.directory
> >         )"
> > 
> > would work, though.
> 
> Would it be simpler to use this?
> 
> 	GIT_TEST_ASSUME_DIFFERENT_USER=0 git config --unset safe.directory

Oh, wow.  This is so obvious, no wonder it didn't occur to me :)

