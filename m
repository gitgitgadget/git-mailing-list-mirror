Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F5AC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628B320692
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmfANWwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUPwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:52:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37938 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUPwA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 10:52:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so5036536wro.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 07:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tkSCcWjStmJGZZtZBG1ULEkMOd7KokjSuD8rVogsiSE=;
        b=XmfANWwWpUQaMfOjWsJODP1pd1nL7ENbTaIKb0++nyHFoBJao8nuSfZ7N+hWwbckUc
         TAScKUO7G0CuF8e7bJDKe4NxuSTlK44c7ldLl41OR5mLMjQTmE9/xLNeD0FymyBdQgza
         FXx9k6uNSJIaTD1DshbNb9BXrWqIBXMKMtZgXdrHySH5zXqzgcrFmpeTiC2MYz4vmiY8
         kEc78UwJG1A0CXuYoVQnrEnaKab85mmiASOgA7GW/iBAHWycVK3byrjuBOtRXPbjciIw
         ffRKZknk47NGShaDZhsAeCY3K4lSQMN8/hHhhPswCjbQG0QvJmakSHoWJBluAOR2OdUD
         RhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tkSCcWjStmJGZZtZBG1ULEkMOd7KokjSuD8rVogsiSE=;
        b=IwfKkJvASIaiYUc3hQhGdZoWanwMMkZnwHWqM/4Af/NgSPOZ14YVcUUNnBL3GIdqph
         bu1r3WU7utEkIyyXGGSWaeYfmQIibY8fiIxtspmvlxhaeDthz+5yr1vrcjVAucXak+Fk
         sAv1227exV4sHC9wZUHk4/OIB6rP9ATHz/tgoA2hEJvtqf6q+mGJ3N7w5smylf4okXtd
         4Y7XB5AHtfw43L2835mUlQ1wCrSV+P05nULZ94F0g16QxiFCn/wbvjbFULZT9DsNUbgQ
         rJbmPy0HN6pZXxR42zGXMp2R6kkno+4OnBzjTluLMi1C1CLb8mSOkbeHKW1EtYZmq6gy
         +NXQ==
X-Gm-Message-State: APjAAAV8HlPbBNrkDdaIUfpW4lh0B3mKhNbPxDvRO7+ovjjNxZAB1LE8
        rsgPJsx5Soo6wFd5xqdP4dWwnu/w
X-Google-Smtp-Source: APXvYqysLMeT8JkjSU0tLfbj1ogco6VijTzvuRF9ya1Du2TlOJs7Oz3Jpkg6SHx0wEZzgRYPOjCVBQ==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr11393445wrv.187.1574351517636;
        Thu, 21 Nov 2019 07:51:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm65639wmb.10.2019.11.21.07.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:51:57 -0800 (PST)
Message-Id: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
References: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 15:51:54 +0000
Subject: [PATCH v4 0/2] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ryenus@gmail.com, stolee@gmail.com, peff@peff.net,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Ryenus, for reporting this problem.

Update in V3:

Based on our discussion, I've added the suggested GIT_PROGRESS_DELAY
environment variable. This allowed the existing tests to stick around with
one exception in the GC tests. The test remains, but we can no longer look
at the commit-graph output.

Update in V4:

The GIT_PROGRESS_DELAY check is extracted to a helper method so it can be
used with start_delayed_sparse_progress().

Derrick Stolee (2):
  progress: create GIT_PROGRESS_DELAY
  commit-graph: use start_delayed_progress()

 Documentation/git.txt   |  4 ++++
 commit-graph.c          |  2 +-
 progress.c              | 15 +++++++++++++--
 t/t5318-commit-graph.sh |  4 ++--
 t/t6500-gc.sh           |  6 ++----
 5 files changed, 22 insertions(+), 9 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-450%2Fderrickstolee%2Fcommit-graph-progress-fix-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-450/derrickstolee/commit-graph-progress-fix-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/450

Range-diff vs v3:

 1:  656dba5afb ! 1:  a7acdf9c8f progress: create GIT_PROGRESS_DELAY
     @@ -44,19 +44,35 @@
       #define TP_IDX_MAX      8
       
      @@
     + 	return progress;
     + }
       
     - struct progress *start_delayed_progress(const char *title, uint64_t total)
     - {
     --	return start_progress_delay(title, total, 2, 0);
     ++static int get_default_delay(void)
     ++{
      +	static int delay_in_secs = -1;
      +
      +	if (delay_in_secs < 0)
      +		delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
      +
     -+	return start_progress_delay(title, total, delay_in_secs, 0);
     ++	return delay_in_secs;
     ++}
     ++
     + struct progress *start_delayed_progress(const char *title, uint64_t total)
     + {
     +-	return start_progress_delay(title, total, 2, 0);
     ++	return start_progress_delay(title, total, get_default_delay(), 0);
       }
       
       struct progress *start_progress(const char *title, uint64_t total)
     +@@
     + struct progress *start_delayed_sparse_progress(const char *title,
     + 					       uint64_t total)
     + {
     +-	return start_progress_delay(title, total, 2, 1);
     ++	return start_progress_delay(title, total, get_default_delay(), 1);
     + }
     + 
     + static void finish_if_sparse(struct progress *progress)
      
       diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
       --- a/t/t5318-commit-graph.sh
 2:  3c0c9675e1 = 2:  e62dcc1ce5 commit-graph: use start_delayed_progress()

-- 
gitgitgadget
