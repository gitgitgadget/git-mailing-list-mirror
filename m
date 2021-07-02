Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2350AC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AF66141C
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGBKUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhGBKUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:20:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B5C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:17:58 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s17so10831701oij.0
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3pt0GTZ/2Glx5dHa+865iseRkjvjOdLatud/GeSxD8c=;
        b=X2868uHEbViBcOMBLSr9/3yPfKaZlfsXRk8yaXwAPMG7CvR8FmnoaKw7aIJfWL8+ph
         Oo/GAeDaCrUrHWy3RNe+9QtgRyAzqr4WqPIGvLVGNbkN2swJGqWSVOt7yqdBI2eKeM+V
         QPmBbEJIk0zq8DCHZfU0E1GF6h4nbnpWTCCDQoJ2WZQ+a+E86FUyLw8lDkuAXckNZHDZ
         QNGjXaEd3SsOwKVIemfAiuXm1KYDUvUDYp1NGTNHkWnIGA5Dd3letHKfQGbiRlpvyFep
         bmj/PWkTv3f7mi/5bWV3e6AiG49/qjQdvk2lvczOjOiVoK7iy7mtZbcFXpoFDF0a/suZ
         aV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3pt0GTZ/2Glx5dHa+865iseRkjvjOdLatud/GeSxD8c=;
        b=NQoCT0pGouQMLQ5kvu2AGjLFPNgN0fgQwFAsoIOK/fPBpEZWZvCuL9BiIbq05fo9RY
         WhRkAXdHgyKD3YWPt5OcIedMcZff7FW96lVWT88GQVbM9uw0BWFDilI5fixU2TTyfQz4
         dWgXYrhWWUeqWI+RZ8VLDsk90Mt5NQjfcoswOwe5HZWO7od0TotiBcvmwLjNKcKa7RxY
         1Vn/B60TTtoMlY7jW7E9IZ/KcOKsFhJnGJQozAsaxdc1AWofhyz9HhjMNVp26Xzh3d3l
         XLtDYitSWXgwPR124zGWrDtTrAZ6eie2QIhuyH5RrIbDG9r38maIo9lXHhpUniVtxcii
         SQyQ==
X-Gm-Message-State: AOAM533FlEvPVreAfWlE07UUUMbQb4CwLhsY2tfThU5f2cSjQYp5GmPT
        dvtzcnoLO8fT6OHoKsKkIB0=
X-Google-Smtp-Source: ABdhPJxODMb8dSwAjBk7gJ7gBLgXAJTN9twdS+n64pka3NfxwqP9iMRcDAH6WGCG6WrBghCgno3Sag==
X-Received: by 2002:aca:d805:: with SMTP id p5mr3303375oig.60.1625221078386;
        Fri, 02 Jul 2021 03:17:58 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l2sm543860otl.27.2021.07.02.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:17:58 -0700 (PDT)
Date:   Fri, 02 Jul 2021 05:17:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60dee7d4e27bf_2964b20817@natae.notmuch>
In-Reply-To: <871r8hauvi.fsf@igel.home>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab wrote:
> On Jul 02 2021, Felipe Contreras wrote:
> 
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> > index 340c5fbb48..32b1fdba45 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -17,6 +17,10 @@ SYNOPSIS
> >  	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
> >  	   [--] [<pathspec>...]
> >  
> > +ALIAS
> > +~~~~~
> > +'git co'
> 
> That's `checkout' in hg, bzr, svn and cvs.

I know, and commit is ci in many of them.

The reason why I decided to make checkout co, is that we have already an
alternative for checkout: switch. So unlike all those other VCS, in git
we can have:

  co = commit
  sw = switch

Of course we would need to make switch actually usable, but that's a
seprate task.

-- 
Felipe Contreras
