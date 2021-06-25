Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1178C49EA7
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0DE6145E
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYTmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFYTmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 15:42:09 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F0C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:39:47 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h9so12537862oih.4
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=d+p+dd9X6Nk2Q5uXNbD+MogWGA63Vnk4TI9wvCy21KY=;
        b=LKoSxFy8WBEOjbwB19Y9uJN3Aa+XlidI6CsB61WnV2Bs+hTd/PbD4hDFVcGPLMVEFT
         /YLCilbEstznqnwTaMFTEAlmq1zgQk7vP0+YmBEcfqFn0BAZJtXPWrBhO0DhUQMm0Wy4
         AX6IufBvjRGW5yArXaRdeux5N07e4uoKkraROyLvAuKhEAYzJdraGwHfB46l4at4xgRO
         syoJF6Ynfvz28emZcXL65y7kin1UnxtUroTQhQcS5/cH8PmiRis77Fhzi5yziPE4GiVN
         weutIjHdie9tFmoQDCLp9vqZmBA5/0h0HSMhPJD3ZthDYMpLzi85eSatjClP823AB8K5
         lZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=d+p+dd9X6Nk2Q5uXNbD+MogWGA63Vnk4TI9wvCy21KY=;
        b=e5Pq4Yy9mhJnbAXHwTnAJ1rTmVi2TSmnGnkjnoB8nzqHYFvj57rMCHK4RM1tlI0Fa0
         ZESwl8w+/MRT8KPMIiesOLB/OcgjnEA/t8OCZeJ7pSM0Je4oDIheQMybhtPIg+NVsUlZ
         I/fgoss432AVAUf5BbdtkfdB/j9DAHsi6Nwy9T0yfQr1NaZVhLI4ogUVPQMyL20lMHcz
         aishEH8fht88Tqq2+7pEDu4vKX0PbCAKC1xc980cJ94uwSy6mRYI1h90zMuv5Q0d+ydu
         DyPmruoIhSD4+6C+nWGM0b/mn38SumM5aMTeSPgEFFAzlIk9IlpL0vU8svTgdxgAim6B
         lVCw==
X-Gm-Message-State: AOAM5325LbLW+H2q6sdUk+hqDLPrYs6kq5IoQZg4dIQci8Zbr7I6fTu9
        cYRAjp2RtbVmhL+JLfxLTu0=
X-Google-Smtp-Source: ABdhPJxjuSn157ttAc51guMV4sOMHwzPysz0KVun4l/yID9zDLpkzL9KhB50l2auEU8gxaG1lGxI8Q==
X-Received: by 2002:a05:6808:6d1:: with SMTP id m17mr12275440oih.34.1624649987051;
        Fri, 25 Jun 2021 12:39:47 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id q1sm1418642oos.32.2021.06.25.12.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:39:46 -0700 (PDT)
Date:   Fri, 25 Jun 2021 14:39:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>, git@vger.kernel.org
Message-ID: <60d6310134678_cc8d208c4@natae.notmuch>
In-Reply-To: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
Subject: RE: Definition of "the Git repository"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Buckley wrote:
> In the way I think of it
> 
> git init
> 
> initialises a Git repository, however, the only thing that changes
> as a result is that a .git directory has been created, ergo, the
> .git directory is the repository.

That's not necessarily true. Another way to look at it is that the Git
repository lives inside the .git directory, but not everything inside
that directory is necessarily part of the repository.

I do have plenty of stuff that isn't part of the repository inside the
.git directory.

The easiest way to disprove that hypothesis is finding something inside
.git that isn't part of the repository, and that's easily done:

  .git/index

-- 
Felipe Contreras
