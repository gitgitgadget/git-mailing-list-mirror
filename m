Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7302DC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A442075E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktWOwHB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgDHSwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:52:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43312 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgDHSwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 14:52:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id bd14so10002838edb.10
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ertSAP8luYr3RW6Srt+GXHdDuVZFQsPeTKjcCHfKAWk=;
        b=ktWOwHB3U4SWGjjMeTDaHtg1wWdTvkT3ACTYP9OJQ0FKl6NiWAWN7rp1J88iHo1vsa
         xhbSAdvuR4rydHt0NgmRtUODYfdUOyhMTnvEPTQBuaf0q1Mir0SxUgDAtIftLWJmSg9S
         i9uM9bFnYtNHR50mYOr3D/eCBUss4Wt7wBPqEmeSjRBOBcDmvQ35/Wbbswy4CJFKI7KW
         RJt3bJw216J8f9z/ba72ZU5D9xTDMVwsM53/1Ht749Q5PQfCLQygRLx4yjXPFfXTwVDo
         aRBSF62UB5lp8WbxHbrngFRtKiaw8VN7kQ4Zscu8E0jRkXC3WbRXFTdTJ0zaw19FMDYA
         2H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ertSAP8luYr3RW6Srt+GXHdDuVZFQsPeTKjcCHfKAWk=;
        b=bknPgTLyBxCB5dc486ih3Xv8YpeWZ51Qx38sO7hVOj5Mvq3Pi3PGw3EM5Lbtqcs/BB
         cxpDW1fBx6MUroPSyCZESEwb+Eh+9hnnI8fVT++b/vnAf6/tQ0yhxzhyWb5b2zV2WyPY
         s3mosGsdWOv2/jM7L7DKFYlj2JT1oiQJ95D1/8mrPhxCDv6RAYE8f9iayz0otav6UBGg
         Bbgz62clfwk2a4xbfBcvRwkIALcwrGZkclRuj0c/2VFuPsOyrmDX4QLc0eXzM13QF7RE
         nFOams7lA+H6do8MWqUZCAxxodCie4LGzdF/KgsOnl8HkiQx5iGLxWMjQlZtmrrYggwQ
         5xxw==
X-Gm-Message-State: AGi0PuaBahpbuyIBcX+W1LtNhJTR9uB/niwC5FadQbNleiRfZMmSRsbM
        eirbUQKEGtLxVMeGIUSbs118oDVV
X-Google-Smtp-Source: APiQypLfI/P3Ax8ihk12KcnWrvcnPeVYzufa2TB4cIa2RxJJE6fKeaCxpSqhHVqTKHbNle08S5zZqA==
X-Received: by 2002:aa7:d683:: with SMTP id d3mr7391068edr.268.1586371955457;
        Wed, 08 Apr 2020 11:52:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm2663752eju.70.2020.04.08.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:52:35 -0700 (PDT)
Message-Id: <pull.602.git.1586371954.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 18:52:32 +0000
Subject: [PATCH 0/2] Fix a git stash -p corner-case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This corner case came up a couple of times in my personal usage of git stash
-p: I wanted to stash only part of a split hunk, and it didn't work.

I originally intended to do a full fix (for details, see the commit message
of the second patch), but in the year since I wrote this patch pair, I found
the current work-around plenty satisfactory.

Johannes Schindelin (2):
  t3904: fix incorrect demonstration of a bug
  stash -p: (partially) fix bug concerning split hunks

 builtin/stash.c        | 2 +-
 t/t3904-stash-patch.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-602%2Fdscho%2Fstash-p-corner-case-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-602/dscho/stash-p-corner-case-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/602
-- 
gitgitgadget
