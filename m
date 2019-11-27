Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC823C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9CE20674
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8QURS2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK0PN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:13:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37377 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:13:26 -0500
Received: by mail-pj1-f68.google.com with SMTP id bb19so6584922pjb.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 07:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3NbvkGd68BiZe+Xxeui+TCJlaGqPHp38QZEQli5VFA=;
        b=R8QURS2vI4T+CFprSzsWfWF+m2TdNhY6SIKjgUq0HoNBBsb9HCyvxd00Ytu20ecQ5V
         OmakYsM5RnFIOP4okWfJ0+kNt+LtcaM2V9wSlNywNfC6giw7WumBkQon+Fi5dO40xn3L
         BGAFeXQ0VlP/XXGvElaoWjZAI4pI26h8EzW5OcAA078WZaG9Nqmc7WgyEuE9hOQuLDGC
         OqfR+LMwLoMckP4sGtoj601QPDu8gQP+h02OKgbVsb76cS6MgbO3RU3/TWchkNO76rrc
         S2857b4omqK5pE3J9N4FU3rH0WBOSoQBt3YTd5FwP1ywdKBBAK6T556cH2c2GmhB4Qy4
         7gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3NbvkGd68BiZe+Xxeui+TCJlaGqPHp38QZEQli5VFA=;
        b=EKkeq5QPq+HZqV5QNAblcEweTvOw+jHDvXTqPaehSrtMxB5s+bNHtZ9nzxWi0IJ1TF
         kC0J99TeYIPgBhBtVw5E3H7NCawV+9/YwSLH216pLW+qJEHWdxLySNSnhJ2QNtZVdszT
         SX+3vWi69NAYTdXRViXL9tPt6u/i6PCMPhXx3wLDp3n8XLeb6Ulh9FDK52tmdKbZurio
         wkd4ycM6BqraJCvUszk3Lc7LoAixP4FcGeDcjpEmszcj8cUSrzc9Y7F+TXKDkrW6wfHJ
         dirXKsjKSUttS7CKxhQudi9ycfWJ02JyjalkJ4VqO1Xxz9lqu/N8LjO+pcy+Host6sX9
         Cs9Q==
X-Gm-Message-State: APjAAAXZFanORCuoTGWCOA6AffN3KU1Gp8pemKjv9J5ulxGO1qxtg42j
        Ew+ooG/PO86yi5qFFap6DmSwyzIF
X-Google-Smtp-Source: APXvYqyCEar9hHGfVoVUcM3rKSbsuHQPjekAhKy+4FeqdvEf856FoN+ZFtBlthawVFTmv9Yuygzpyg==
X-Received: by 2002:a17:90a:ff04:: with SMTP id ce4mr6721605pjb.118.1574867605386;
        Wed, 27 Nov 2019 07:13:25 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id g192sm16883674pgc.3.2019.11.27.07.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 07:13:24 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 0/5] drop non-reentrant time usage
Date:   Wed, 27 Nov 2019 22:13:16 +0700
Message-Id: <cover.1574867409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.158.gd77a74f4dd.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gmtime/localtime is considered unsafe in multithread environment.

git was started as single-thread application, but we have some
multi-thread code, right now.

replace all usage of gmtime/localtime by their respective reentrant ones.

On Linux (with both glibc and musl), we won't notice any differences in
performance, since they implemented gmtime and gmtime_r mostly the same.

On Windows, we may be taxed, since gmtime_r and localtime_r is our compat
functions, because we memcpy from returned data of gmtime/localtime.

To address that, I made patch #5 and included it together with this series.
I'm not sure how much portable it is.
It seems to run fine with my Windows 7 x86 and Windows 10 x64 VM, (inside
git-sdk for Windows, if it matters).
I'm Cc-ing j6t and Dscho on that patch to get their opinions.


Doan Tran Cong Danh (5):
  date.c::datestamp: switch to reentrant localtime_r
  date.c::time_to_tm_local: use reentrant localtime_r(3)
  date.c::time_to_tm: use reentrant gmtime_r(3)
  archive-zip: use reentrant localtime_r(3)
  mingw: use {gm,local}time_s as backend for {gm,local}time_r

 archive-zip.c  | 10 +++++-----
 compat/mingw.c | 13 +++++++------
 date.c         | 18 ++++++++++--------
 3 files changed, 22 insertions(+), 19 deletions(-)

-- 
2.24.0.158.gd77a74f4dd.dirty

