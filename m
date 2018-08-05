Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52941F597
	for <e@80x24.org>; Sun,  5 Aug 2018 10:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeHEMnc (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 08:43:32 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46539 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHEMnc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 08:43:32 -0400
Received: by mail-yb0-f196.google.com with SMTP id f10-v6so693598ybk.13
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 03:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ji/A81ulXvCTTMqoq2lrj0xQDwILKiq2Yi1/v6TJyio=;
        b=RQiem2aMoRgWjaVig0r4BcIKFX0+3sp7Z3IFQzP7SN0VE+KT8UnxtFOPB+5794gcZU
         erPu35Uiiul3lb1g3Dza3olYcDAjjyDfrKIe8kVTXSqbpdO35Is2ul+Y3P34jJ+REozw
         kHlV/c0pfnAQ/YfbI+MMhu2oYe8Up35xQtw/MLyVLc6mRg8D2B0kyG84ajybNAV0enGt
         NTFhUs/F5E1KA2049FemAlqbWv2wWx/QJ9+wn+Tfj9tNYVRbRE3t4XGlJwP6lUHNqUfL
         25qh3b/WtSr2BkxIlLhP4M1Zent8MlXC+TcOavNiR7gTPwnCBy3Hg6WyRNYSCQVUjxic
         9l4Q==
X-Gm-Message-State: AOUpUlEWy57DuXIuZAwjjLZ4ec7WAjXl1tDDWbLVTGGMdJytI87S/V4L
        YY4450re7wrNcShKrZ2qlKPV3GGJOJgeba9nq3g=
X-Google-Smtp-Source: AAOMgpfa9BZOPFagu+GmPtLTYoyjUZcOtV+kok67BbTcrrVRgjaHAzxYiEgwvbVeTATuhDGZBT/XTZFN8J4IhoCY8e8=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr5482122ybl.12.1533465564454;
 Sun, 05 Aug 2018 03:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.15.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.15.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Aug 2018 06:39:13 -0400
Message-ID: <CAPig+cS-b973NzRvvcKyx6t5ChO_VDf=Bs8zoE-B_iPa3HWv5g@mail.gmail.com>
Subject: Re: [PATCH 0/4] line-log: be more careful when adjusting multiple
 line ranges
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 6:18 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Now, I am fairly certain that the changes are correct, but given my track
> record with off-by-one bugs (and once even an off-by-two bug), I would
> really appreciate some thorough review of this code, in particular the
> second one that is the actual bug fix. I am specifically interested in
> reviews from people who know line-log.c pretty well and can tell me whether
> the src[i].end > target[j].end is correct, or whether it should actually
> have been a >= (I tried to wrap my head around this, but I would feel more
> comfortable if a domain expert would analyze this, whistling, and looking
> Eric's way).

Although I fixed a number of bugs in basic range-set manipulation code
(5 years ago), I have no experience with or knowledge of the code
actually dealing with range-set manipulation in relation to diffs, so
I'm not a domain expert by any means, and I'm _still_ trying to wrap
my head around that code.

That said, I left some comments on the individual patches suggesting a
simpler and more correct fix for the crash. (Despite that suggestion
for fixing the crash, I still can't say whether the actual
computations performed by the existing code are correct, since I still
don't understand that aspect of it.)
