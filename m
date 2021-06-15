Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51288C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8D36142E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhFOJmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFOJmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:42:36 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E3C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:40:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q10so13356402oij.5
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wOTS98Z0jOWnQSgp0JECRiV1sjoqZR+PTLbYAjfNNRM=;
        b=T2vog7ydAOTVjOgjWU/Dq3erD7v+34uaTuLfj+4BkPL2ZXGcraTpkduk60lNUbjU9o
         n6BLzz7TBHoPYDMMraaLwTy9bhyfIb3CQ8bM8Tk+BFYzH3oqPdkr7SNvz6fCX7pZDNQ5
         YG3xSbc0/Eqa5Op6oHiILQApffDjKODXdSH8gxyzQXl32N5dokxOfeJCIglHpEhyFEVB
         CE6mk+25mBc3YjQkDgX81uiQ+q3jCqFs7vfVmxmIdYCH6Uzaj24A2pJFCkU1miKkc4Un
         YwDzIjRGLenaxBmCluB5gLC0F4JIjkMunATlriikecqXShfFxknKX2KPGYJfcrdNBckN
         8B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wOTS98Z0jOWnQSgp0JECRiV1sjoqZR+PTLbYAjfNNRM=;
        b=tPtKvNitiQtoK4FtlMw3wA4GfITs0cBeEPWpmGzu7UHwUbp6lA+8PrrpMCga7lyO74
         SonCRi93GfJoBkeZK8natUuZ0zsfQTIIkCzFIHXoS+QOdTW05STxQTZj67baGoKrdAjY
         Iin4k9DXXq0X21zaOcL67HJFsuvb4KYQCy0B8zaS8r3SXSxe2ktAgv9Klhf6yfmsCipm
         OvixGAL+mCaQo4YFl10zApupOD9oYQwzWDdsTbKQlpsj3BiSsqAWow6JujuR5YuxFJWR
         vI0SntW7gBKEZDV6XkTZZoPRd72NKdrd5Q5aPRLHDES6PKqkZUiCHyl4DSEPfe1ZTt9A
         BPLg==
X-Gm-Message-State: AOAM533YHIOf/hyrXPj3iTeDk9clAsKvvOawRmFPDZ1Qhv/VFZEmS+x3
        ydRWFs8Ig8LcQIEoC27R75Q=
X-Google-Smtp-Source: ABdhPJwvrfFMmJqXU2Bjp6hiuGRcSXcgZ1LvoGo70KyzClXWrUbWitZMbeKs8MxOdY2oxl8EWlqZZA==
X-Received: by 2002:a05:6808:140c:: with SMTP id w12mr13581670oiv.112.1623750031126;
        Tue, 15 Jun 2021 02:40:31 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t21sm3884861otd.35.2021.06.15.02.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:40:30 -0700 (PDT)
Date:   Tue, 15 Jun 2021 04:40:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Message-ID: <60c8758c80e13_e633208f7@natae.notmuch>
In-Reply-To: <b7561a67c192d4bdede47fee5b7b1cb30c44b785.1623734171.git.gitgitgadget@gmail.com>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <b7561a67c192d4bdede47fee5b7b1cb30c44b785.1623734171.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 1/2] xdiff: implement a zealous diff3, or "zdiff3"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> "zdiff3" is identical to ordinary diff3 except that it allows compaction
> of common lines on the two sides of history at the beginning or end of
> the conflict hunk.

That was not the main reason behind zdiff3.

The whole point of zdiff3 was to have something closer to the "merge"
style, even if not technically correct.

Your proposal is better than diff3 in that respect, but worse than Uwe's
zdiff3.

If you have this:

  l  b  r
  =  =  =
  A  A  A

  B     b
  C     C
  D     D
  E     E
  F     F
  I     i

merge will output this:

  A

  <<<<<<< l
  B
  =======
  b
  >>>>>>> r
  C
  D
  E
  F
  <<<<<<< l
  I
  =======
  i
  >>>>>>> r

This is simple, and useful.

diff3 will output this:

  A
  <<<<<<< l

  B
  C
  D
  E
  F
  I
  ||||||| b
  =======

  b
  C
  D
  E
  F
  i
  >>>>>>> r

Not very friendly.

Your zdiff3:

  A

  <<<<<<< l
  B
  C
  D
  E
  F
  I
  ||||||| b
  =======
  b
  C
  D
  E
  F
  i
  >>>>>>> r

Just marginally better.

Uwe's zdiff3:

  A

  <<<<<<< l
  B
  ||||||| b
  =======
  b
  >>>>>>> r
  C
  D
  E
  F
  <<<<<<< l
  I
  ||||||| b
  =======
  i
  >>>>>>> r

In my view of all the *diff3's, Uwe's version is the most useful.

-- 
Felipe Contreras
