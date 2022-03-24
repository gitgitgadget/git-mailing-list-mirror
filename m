Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C19C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352719AbiCXSgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiCXSge (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:36:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D449CB9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:35:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r13so7835517wrr.9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fYB5vyERi8zZOpXtiepMoAB3dcNtCM76JVfvs1VuUzI=;
        b=XK9Zqq6VRS1wtonB21F+znHetHbbKY0qCCPlnfPTrfBjCSF0fOHPomwFYYFbi1vRBH
         CDSKntu7Ia8/7ulRYlzdtHsu1rTsewHVjKhjX8+13bRYgOdjMmVSu3hpKD/miy4pZ+FO
         v4Clwb66k8Nz/rEIkwT9R4TJ6z/c1Z1lO5wiakX2foPoOJ84/87mPSn9QBwIVY7Po18x
         k7euVQLD91ECfS2I0PPdRNTuFo8O5Qmrumd0wpyAi/jATl+KiD1zQ4quoDI7AkjZjgej
         JvTdHUTrBu05zhweaxF269OGC41BOYzRONDxvzvJHR7Mln1p3y3+wlIG1VQIZ3aR7uve
         NEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fYB5vyERi8zZOpXtiepMoAB3dcNtCM76JVfvs1VuUzI=;
        b=gXM5BhbB7EHf0ILifZHiYCxT2inr1TlKbLqq9WUNzdZVVj6tJlVlTmsl5aOkHZv6Af
         kBIgQKJZpnHTJFWpvNcH9CdIG41eoIc/HdOnO2h0mQRcGPp6ihKIvCNyTqUX1WM3d3LJ
         z9x+GFUocksDgxv9WUtlyoF46V3CoH+32hTTVrRPJnPWviWmnx+4rWBHeXLCG0lGTnUi
         XchpUR+yr80XwDjFjyEbcZ/8ZGQds3ADydZhyARgx1ifbuadWfc5GUki+NAMqy1mpMqq
         /zV1ePoBLoc0xFXYscbOCkwOURc0LA79nwa6d2TSX3eXS/dmdhgtPAAEyk8V08JNcvAL
         TOyw==
X-Gm-Message-State: AOAM530TpzyELYw8baRLjMn03MQsnS0bhboCtvtnasle2hhAFqyh8jXH
        LSBcfpxcNJPpigLJ8nfUmopfRyRgQws=
X-Google-Smtp-Source: ABdhPJzLD5fyuSK1JY9nVoqQn9r6hoZO3L8t+Ac6fRTN2Mk7RWDD1RKWFGO7LCwpa9a/bNJezxM3Yw==
X-Received: by 2002:adf:9dc6:0:b0:203:fb2d:75d6 with SMTP id q6-20020adf9dc6000000b00203fb2d75d6mr6009815wre.571.1648146899167;
        Thu, 24 Mar 2022 11:34:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6d52000000b00203da94cf01sm3228202wri.14.2022.03.24.11.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:34:58 -0700 (PDT)
Message-Id: <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 18:34:55 +0000
Subject: [PATCH v2 0/2] test-lib-functions: fix test_subcommand_inexact
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio discovered in [1] that test_subcommand_inexact is more flexible than
initially intended.

[1] https://lore.kernel.org/git/xmqq4k41vdwe.fsf@gitster.g/

The intention was that we do not need to specify the remaining arguments for
a subcommand, but instead the current behavior is to allow the given
arguments to appear as any subsequence within the command (except that the
first "git" instance must be the first argument).

This changes the helper to be more rigid.


Changes in v2
=============

 * After noticing that t7700 fails with the helper change, Taylor wrote a
   modification of the test to check the post-conditions directly and avoid
   the helper. This is included as Patch 1 with some modifications to be
   easier to read.

 * Patch 2 is the v1 patch with some change to the commit message about why
   the tests pass after patch 1.

Thanks, -Stolee

Derrick Stolee (2):
  t7700: check post-condition in kept-pack test
  test-lib-functions: fix test_subcommand_inexact

 t/t7700-repack.sh       | 52 ++++++++++++++++++++++++++++++++++++++---
 t/test-lib-functions.sh |  4 ++--
 2 files changed, 51 insertions(+), 5 deletions(-)


base-commit: a68dfadae5e95c7f255cf38c9efdcbc2e36d1931
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1185%2Fderrickstolee%2Ftest-subcommand-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1185/derrickstolee/test-subcommand-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1185

Range-diff vs v1:

 -:  ----------- > 1:  f2f8d12929b t7700: check post-condition in kept-pack test
 1:  50176722bbf ! 2:  ed67b748971 test-lib-functions: fix test_subcommand_inexact
     @@ Commit message
          the printf statement, then adding ".*" after stripping out the trailing
          comma.
      
     -    All existing tests continue to pass with this change, since none of them
     -    were taking advantage of this unintended flexibility.
     +    All existing tests continue to pass with this change. There was one
     +    instance from t7700-repack.sh that was taking advantage of this
     +    flexibility, but it was removed in the previous change.
      
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## t/test-lib-functions.sh ##

-- 
gitgitgadget
