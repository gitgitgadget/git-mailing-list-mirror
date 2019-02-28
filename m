Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68F520248
	for <e@80x24.org>; Thu, 28 Feb 2019 15:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbfB1P1s (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 10:27:48 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45683 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbfB1P1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 10:27:47 -0500
Received: by mail-ed1-f46.google.com with SMTP id f19so7930527eds.12
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 07:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=c74m5HW1PSJ8yk7fq8caGx90a6RJWjzD7CaeVDdYeco=;
        b=ippTgxCdOjWweZLddtxQli++UqHW9zbt81acBjmixJG5NmZWAzeUQcC2AzZMF0DGO0
         Q8P7HplhZZlRQ5hHl9QPcyojIaeHD+IzJvD8CsSBV/wu2wRZNoA3L1QmSyjuSMpqT1PL
         lAXNAe2/qiolxbmEVhW/dG4GQFWWO+aibS/m22HfSrHMn+YqGH3SLPpFwaIm/EEDRpcg
         eHX7/CgyeHP9SF2nrLSxZ6JjCR6RxvSqjbyrapL34uvjlANsY0ffaXbre8l2SewUk4ec
         FN4l/jW3ZXlwz0OG0bnRUbZfFD3Hu02fkzbk9GZVY52TK8Uju76gjZpDG384WBMGKbT7
         bILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c74m5HW1PSJ8yk7fq8caGx90a6RJWjzD7CaeVDdYeco=;
        b=qgxKRgNoybzzxX88UnIM4WYZA07+Qzdu+kNmsk3tDLOXd/hue8XBaIX0aEpmI2tdTC
         fXx2hchCsC1tCSnYI5AjlG6EYFGu1WTmMUvvNQ3SceIOEqha8Vp20ssclVRO6DerTlNp
         IQM9E9DneA+shaOfHmaHqyhUs0EHXRuiRIHMbS8eU+cEmcZ3ByiTQq1jLv4kEHP0I5LM
         GrImZl+Zjt7DLozkY+3T0++59CXqdGntj8CCMAJyKIvcctmw5jFT3L/nNrSfJoPlRMHT
         6tph0g2RGLgywpyV32ensrrJUpRW4XbSjbYkq7plPkqPFYq4cACBf5fL7v2TEU8XJcPt
         VIPA==
X-Gm-Message-State: APjAAAWN/cVFWKFTeSb2uzYJTPsF9EHMNp8Hu1/LTzK8txdo7fS0HnC+
        OMLzx14RuEgpN0xpgo87ae9lD9V+
X-Google-Smtp-Source: APXvYqzXUJwyWmG1fcYrPTGAwcZ9KbcKg6GqmKrOeC+96ijGq1TnNeeoEwEMee3J3J7X/PNsL7C8uQ==
X-Received: by 2002:a50:a4d5:: with SMTP id x21mr101492edb.189.1551367665294;
        Thu, 28 Feb 2019 07:27:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id me7sm3269339ejb.46.2019.02.28.07.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:27:44 -0800 (PST)
Date:   Thu, 28 Feb 2019 07:27:44 -0800 (PST)
X-Google-Original-Date: Thu, 28 Feb 2019 15:27:40 GMT
Message-Id: <pull.153.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] Fix ORIG_HEAD behavior of the built-in rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported by Nazri Ramliy that ORIG_HEAD was set incorrectly again,
this time caused by the shortcut to call git am directly, without detouring
to a Unix shell script.

Patch 2/4 might look like something completely unrelated, but without it,
the update to HEAD might use an incorrect reflog message.

Patch 1/4 is more a "while at it" patch; while looking which code paths
might need to update ORIG_HEAD, I noticed that this reset_head() call did
unnecessary work.

Johannes Schindelin (4):
  built-in rebase: no need to check out `onto` twice
  built-in rebase: use the correct reflog when switching branches
  built-in rebase: demonstrate that ORIG_HEAD is not set correctly
  built-in rebase: set ORIG_HEAD just once, before the rebase

 builtin/rebase.c  | 37 +++++++++++++++++++++----------------
 t/t3400-rebase.sh |  8 ++++++++
 2 files changed, 29 insertions(+), 16 deletions(-)


base-commit: 21853626eac565dd42572d90724b29863f61eb3b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-153%2Fdscho%2Frebase-am-and-orig-head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-153/dscho/rebase-am-and-orig-head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/153
-- 
gitgitgadget
