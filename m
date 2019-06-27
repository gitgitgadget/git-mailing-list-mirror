Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B889E1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 08:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfF0IMv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 04:12:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43433 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0IMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 04:12:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so6165717edr.10
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pUwoSJZhxR01RebU8ARqxvTAO5Q+kzaMr+igqldF/c4=;
        b=Y/zY6YdC3IIoEasOmuxsuhr5drROameQnx/zA6OMN8Wu4t3RBw59GYuzD4WpGnWjWj
         Gsgbb0z+M1TfUe2Q8jla46Svulka5kguUYSIOOparkhdpGqFQVTwEPpeRwYfL76gQ/sI
         dW/CvyCwAEkAd2u3jvg5NtMGJlDSEgY6iH+OattxHzVYrnWdrHTOSwonGgzoyoHM1X4F
         JZQwnP7aHD+trM/cO51ENMP6Qv+ZSmfjnfl0fEDrNLc+NskWIRM2kvwzcEcAJTG34trs
         MTxhLEVs+4YzZb2UvfDIC4s7EJw1PEXbg5RBXO1iewFEhMRRz574NEUSdfWzKskwcrgm
         6rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pUwoSJZhxR01RebU8ARqxvTAO5Q+kzaMr+igqldF/c4=;
        b=EEMevP/25l/a5K50h7jG0RQJkqFKXhQaO+vM+CuXuzDogB6ggGv5bGcaJ+8sp9exwW
         EXniC8aMMIzoqQQl3PBdPdcVLYjqJdACUolTvgSM5Ai083u3C/liijr5X/mVCtv8Op3K
         YCHeQcOC/JxITYY895QulMmsENB6qhfD1CXnz157kvHvhKb2iWW2zkbAyQvKUx3nLQ0n
         uFXP1SUzgV7bI47yUD1bNkL5KffoAU3546mI+p8CY/uJJLb6aF3a8gBBokJyhF4b18Yh
         BZ2/Hh+r08XFOtGFlsKUEYxx4kE5hy1TFFF9N+9lJTvMahTJ0/y6OqJ48/6fsnswoJ0U
         CREA==
X-Gm-Message-State: APjAAAWYyDZO6m5S5t3YVP8KHe5qMePAW6yaWE0iYln1pZkQh1Ul02n4
        Mjjud/EXcc+QiV0sdW81dNT159co
X-Google-Smtp-Source: APXvYqxjqKdupfZ1c6imK2WNycjWgpBiBk9Y78EsrPKPBOFVWRtilO8e5h5EeDtTWdGW8+gYvI57ow==
X-Received: by 2002:a50:d0d6:: with SMTP id g22mr2522401edf.250.1561623169287;
        Thu, 27 Jun 2019 01:12:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm492594eda.95.2019.06.27.01.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 01:12:48 -0700 (PDT)
Date:   Thu, 27 Jun 2019 01:12:48 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 08:12:46 GMT
Message-Id: <pull.253.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Make rebase.reschedulefailedexec less overzealous
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vas Sudanagunta <vas@commonkarma.org>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This config setting is pretty useful, but it unfortunately stops all
non-interactive rebases with a bogus error message. This patch fixes that.

Reported via a commit comment on GitHub
[https://github.com/git/git/commit/969de3ff0e0#commitcomment-33257187].

Johannes Schindelin (1):
  Let rebase.reschedulefailedexec only affect interactive rebases

 builtin/rebase.c           | 7 +++++--
 t/t3418-rebase-continue.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)


base-commit: e11ff8975bedc0aae82632c3cb72578c3d7fc0b2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-253%2Fdscho%2Freschedule-failed-exec-gently-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-253/dscho/reschedule-failed-exec-gently-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/253
-- 
gitgitgadget
