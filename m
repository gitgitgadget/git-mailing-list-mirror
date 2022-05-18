Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F23C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 14:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiERONl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbiERONk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 10:13:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF431C194A
        for <git@vger.kernel.org>; Wed, 18 May 2022 07:13:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i19so4054583eja.11
        for <git@vger.kernel.org>; Wed, 18 May 2022 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v0sgVRHUrM+SCYf9c9VXGVA4IfTEc6qUBfhBd/MECkI=;
        b=RmR+akf7aiEeeHJrATYU2pzDPK/N1/AGcA9llBIFVXoo8KG3XpksP/YjDqB62nsuF2
         xMBkiLznPvnAh2sOCxvjlzU41FmKI1bg7mehlR/64FdDMgSf2IYEI3fq7idT4Tl6tN7Z
         Cp2XfMneX10iYrW9QSqRSV4agNXIk4Jfo7OkZ2XB/9tecBztf4GB7IwodPtP0KIuD4ul
         /EEoCb05TxZr8X15wINdWWvqY+Ixde/DG7BJ7YU1J3WjgLsynOyJNgwlk65zNGHHbpbJ
         6kfX9NC8NUMk2dhcqHC6HHU3emhV0N+XCoq59+AF+boDPP460QjfBZiflhZDNpI4vNtQ
         yFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v0sgVRHUrM+SCYf9c9VXGVA4IfTEc6qUBfhBd/MECkI=;
        b=Q31TxveEyYOkTlT9Fq6K8PpWmrXFEEYGd0KZuNmKS/mrwlsqVYUPNRVnPsfThEpYba
         M18/Gx8beMApsLlVDT88dNfSWgu8ibsC+RutGVQmnU3Qyj45K1IFpEgyjszDFz5B/bbm
         +lgrRZp1K76F0fp4N8ghjBNDV4TTwxZjDSjEBV1hTo55vhN9N+9SdLg+u7dM9qzrANZZ
         6mV2vuRpjiZvh8XV2gH4GUoSHKE7MnyWtKK4l/1ZS2VGoyccmCISqy37mN8qZCoqEJlA
         jCV7ZwNqCSeRgpUehs6x+KOi8VQZYjGpruB47zCkuYLPIHnZswcbNdHE4Ska1P/8OAEi
         MR+w==
X-Gm-Message-State: AOAM5306ZziTMODziCEtYtKo3XovtFUao/EFn56eG2ViEcDP+2C+rKvA
        49pm8HS+Nej2aHVJ7jPPUNk=
X-Google-Smtp-Source: ABdhPJwykSOLnKAxq7yaRLxjlQvdo9zOpghpxJo7VEbIObA2OyIvKnEa6m5OxcNPqKzjGbdmY+ZVMg==
X-Received: by 2002:a17:906:19c6:b0:6ce:98a4:5ee6 with SMTP id h6-20020a17090619c600b006ce98a45ee6mr24467355ejd.567.1652883212174;
        Wed, 18 May 2022 07:13:32 -0700 (PDT)
Received: from localhost ([2a02:2149:8aa1:7500:dc1c:e29b:83a4:b580])
        by smtp.gmail.com with ESMTPSA id e1-20020a170906844100b006f3ef214da1sm1012866ejy.7.2022.05.18.07.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 07:13:31 -0700 (PDT)
Date:   Wed, 18 May 2022 17:13:21 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 04/15] test-dir-iterator: consistently return
 EXIT_FAILURE or EXIT_SUCCESS
Message-ID: <20220518141321.uynaxzaoivlthi7b@compass>
References: <20220509175159.2948802-1-kioplato@gmail.com>
 <20220509175159.2948802-5-kioplato@gmail.com>
 <xmqq35hictaa.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq35hictaa.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/09 02:03PM, Junio C Hamano wrote:
> Plato Kiorpelidis <kioplato@gmail.com> writes:
> 
> > Throughout test-dir-iterator.c we were returning/exiting with either
> > integers or EXIT_FAILURE. Improve readability and reduce mental load
> > by being consistent with what test-dir-iterator returns through the
> > test-tool. Returning mixed constants and integers could indicate that
> > it matters for some reason e.g. architecture of test-tool and cmd__*
> > functions.
> >
> > EXIT_SUCCESS and EXIT_FAILURE are specified by the C standard.
> > That makes the code more portable and standardized.
> 
> And less portable for the invoking process of "git".  The invoking
> process used to be able to depend ou getting WEXITSTATUS() from our
> exit status to obtain "1" when we exited with 1; if we start exiting
> with EXIT_FAILURE, there is no guarantee what non-zero value is used.
> 
> So, I am not sure if this is a good direction to go in.

From what I understand, this is a point about why EXIT_FAILURE and EXIT_SUCCESS
are a bad idea in Git's case in general; not specifically in test-tool's case.
The test-tool doesn't use child processes, therefore it doesn't use the macro
WEXITSTATUS. As a result, supposedly, we could use EXIT_FAILURE and EXIT_SUCCESS
constants in this case. However, we don't want to use them in order to stay
consistent throughtout Git's implementation. Is my understanding correct?

> > Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> > ---
> >  t/helper/test-dir-iterator.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Especially given that this is a helper for testing, we may want to
> return/exit with different non-zero value at different places to
> make it easier for the test script to tell where in the program we
> decided to exit a failure.  IOW, if we return not EXIT_FAILURE but 2
> (or whatever value that is not used elsewhere) in the first hunk,
> and let the second hunk continue to return 1, then the calling test
> script can tell which one decided to fail.
> 
> As to EXIT_SUCCESS, I do not have a strong opinion against it, but
> because EXIT_FAILURE is a bad idea, we probably should avoid it for
> consistency.

This improves upon my attempt to be consistent in what we return, by also giving
the option to tell where in the program we exited a failure. I'll adopt this in
the next iteration of these series, v3.

> Thanks.

Thanks,
Plato
