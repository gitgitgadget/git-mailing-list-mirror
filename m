Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E9C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE44611BD
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE3QnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhE3QnR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 12:43:17 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4970C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:41:38 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso8734047otl.13
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/+T/lxCtfzk5Yqd7dSQi7x19VEgIt+xXXxNkvdVKk7s=;
        b=sTaRmPr8ZpwAVkZ2aVgsHftG3xklhL5/r+haHC1nOSbe47iiEE+YwUPZ/G2tmM/6qQ
         ONs1pfcn+c+dX6DMbOa5XJovxPdKYE7ZtdH017Bbg/9T9o0rjFRVNHxZydrT/IWaDu7A
         YXOw74sRWHoi29NCwjDbWpPlKWjGEV6xn09NkiJOkKRofAcC8UVinPHM7MRsVxbWWN/Q
         Lv0te0x1BK0b1jsRgvnFafColSbHOspzElnzbG0O84fsiwqVNyAE/ybmejTM5OGOiybB
         +5n8NXQlO0YRD2P04Rwl1Z2AXMm/xuFIXMzCm3Nk30eSwT6t6ig2BnSLPTcziPl6mphE
         HFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/+T/lxCtfzk5Yqd7dSQi7x19VEgIt+xXXxNkvdVKk7s=;
        b=PTsnvFwaGb6njXpGyEklrxQg0UZJPe+uZ9hhfXcnq0CBTqohq5HHFyCHmW9+tPXKpr
         aRUy1uU8jImjGkSfwKQeqscK6LIBKBaV/UBDCLtAaAXfLDKrx9/5ce0z8DZrdky01Nqz
         16xwQISMgRBgz2okivc8h14fn6Fy2gCZJl5uTuu8jGVnRL4KmmEtViULs6rd010cBNoG
         xo7b3XVE4dohVXgrBNTr3DEbf9LHxMA3CD/vVjV3xFE3eumVHOYG5bYoYvApZNxA24n6
         CntzJUpen8O/4ctkt1MDht1Se4nu18kUkMzzhkfmSruFEgCYoSq2gSuXXcBzI7IhSmk/
         i+3Q==
X-Gm-Message-State: AOAM530hdWBAUlpEe6SPOwaRNAkle4KYsaI5Gc/QeCuBYUy96s3fDCyI
        lgGf/0xKgTxasHhuPVZCYp8=
X-Google-Smtp-Source: ABdhPJx4REKL1EiABu3ey/CxWL36FC2eI6HwPckMplzFPy0t8p866FhCvssDXws79mv3LBbuuaBMvg==
X-Received: by 2002:a9d:4584:: with SMTP id x4mr13784643ote.85.1622392898149;
        Sun, 30 May 2021 09:41:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 67sm2506288otp.68.2021.05.30.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 09:41:37 -0700 (PDT)
Date:   Sun, 30 May 2021 11:41:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Message-ID: <60b3c04032b61_b9372081e@natae.notmuch>
In-Reply-To: <f1fca31b-17b8-9dbb-4d46-dda8c44645c1@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
 <f1fca31b-17b8-9dbb-4d46-dda8c44645c1@gmail.com>
Subject: Re: [GSoC] My Git Dev Blog
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> Since I use (r)vim instead of emacs as my editor, what are similar
> configs for vim?

I'm not sure if you are suggesting he includes those in his post, or
asking in general, but:

https://lore.kernel.org/git/20201209065537.48802-2-felipe.contreras@gmail.com/

-- 
Felipe Contreras
