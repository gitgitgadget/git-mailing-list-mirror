Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FBC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiC3FIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbiC3FIj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:08:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A87307E
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:06:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j18so27546043wrd.6
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ng/KIsMVJCJpELr2yz4HVU5SnQMLhVTgsGYyaKz6r2w=;
        b=ancfxSUnmFBeMrKQ2Q1g6ey/reDJdvMj6JySqtuPzw2JpPBb78gQB5AaUqyQednY40
         mdYn7obl8PlovG92ZZBBJ3Ip17Oe0b89FxCWgQTAn0x9q2XXydc9M+1MtnOyh7Qlim+P
         5DUZjfUnyQKYNFk2gQwJSCLXWiNgkTE3OUQqidHW1R/q6UVWsRLECaPK3z1LXOtio8cH
         5lg+fmWvihh3Ln52gxyzeIOwnkCKxvqMlE2VzmGPhSvfNU40hD+wDyYCVz5SHWR7YOjF
         hwMN3mDsLYb45r2YcqKWie9zJ+BVkeae/OPBURVtAMXyLBS2564OumZfognV6ATkJAfW
         A3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ng/KIsMVJCJpELr2yz4HVU5SnQMLhVTgsGYyaKz6r2w=;
        b=kr9+e5jhv+btq7sA6r94cnXbygRSbrTzKktPdNoSL2wEk1aSXKzWB6yZwXxUvK3l+K
         nmdRNN4YIxtQs3CTcIMGWbmlSkp8w4zchoMFQJjTG6Ft8ivl4R6RlFQdx6jX7fyp+B8H
         zy7/WVH/c8F86A+0GfFle4jy52j1k2qAd9pNd4leKj6Bwd1xDRzSSNWM57xlUpzY/DWq
         PKtARHwd4NeDKtKZ63JYoAyUjAVm3zyLTf1ZGHUUo2IWs1jYQ0Baf0YUUxkVB+225oha
         h4XyPyeZrbqx8o8mSaBdLhr2YS92RMINonhpzP+uXtMjqEFOie7pSrwIWuasr4oNNI/w
         +HnQ==
X-Gm-Message-State: AOAM532wFCjVHaT5n94fcRKI6jmUsUyGb9iNE/HCeI5ATipOiQ397Rdm
        c0mmUpeSyC9VyvnqvA12aIIWQTQONjY=
X-Google-Smtp-Source: ABdhPJxbZVa4ywyaOZhg/Mo/z1I2UCxthOBIPXkGL3Ecn7lzNb83f+jMpoqKEjirKPKVXDuDXYJR0A==
X-Received: by 2002:a5d:6150:0:b0:205:a831:961a with SMTP id y16-20020a5d6150000000b00205a831961amr27528567wrt.615.1648616801569;
        Tue, 29 Mar 2022 22:06:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b00389cc36a3bfsm3883650wmp.6.2022.03.29.22.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:06:41 -0700 (PDT)
Message-Id: <pull.1192.git.1648616800529.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:06:40 +0000
Subject: [PATCH] trace2: add stats for fsync operations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add some global trace2 statistics for the number of fsyncs performed
during the lifetime of a Git process.

These stats are printed as part of trace2_cmd_exit_fl, which is
presumably where we might want to print any other cross-cutting
statistics.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
    trace2: add stats for fsync operations
    
    Add some global trace2 statistics for the number of fsyncs performed
    during the lifetime of a Git process.
    
    These stats are printed as part of trace2_cmd_exit_fl, which is
    presumably where we might want to print any other cross-cutting
    statistics.
    
    Signed-off-by: Neeraj Singh neerajsi@microsoft.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1192%2Fneerajsi-msft%2Fns%2Ftrace2-fsync-stats-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1192/neerajsi-msft/ns/trace2-fsync-stats-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1192

 git-compat-util.h       |  5 +++++
 t/t0211/scrub_perf.perl |  4 ++++
 trace2.c                |  1 +
 wrapper.c               | 12 ++++++++++++
 4 files changed, 22 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 0892e209a2f..4d444dca274 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1281,6 +1281,11 @@ enum fsync_action {
  */
 int git_fsync(int fd, enum fsync_action action);
 
+/*
+ * Writes out trace statistics for fsync using the trace2 API.
+ */
+void trace_git_fsync_stats(void);
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that does
diff --git a/t/t0211/scrub_perf.perl b/t/t0211/scrub_perf.perl
index d164b750ff7..299999f0f89 100644
--- a/t/t0211/scrub_perf.perl
+++ b/t/t0211/scrub_perf.perl
@@ -59,6 +59,10 @@ while (<>) {
 	    # and highly variable.  Just omit them.
 	    goto SKIP_LINE;
 	}
+	if ($tokens[$col_category] =~ m/fsync/) {
+	    # fsync events aren't interesting for the test
+	    goto SKIP_LINE;
+	}
     }
 
     # t_abs and t_rel are either blank or a float.  Replace the float
diff --git a/trace2.c b/trace2.c
index 179caa72cfe..e01cf77f1a8 100644
--- a/trace2.c
+++ b/trace2.c
@@ -214,6 +214,7 @@ int trace2_cmd_exit_fl(const char *file, int line, int code)
 	if (!trace2_enabled)
 		return code;
 
+	trace_git_fsync_stats();
 	trace2_collect_process_info(TRACE2_PROCESS_INFO_EXIT);
 
 	tr2main_exit_code = code;
diff --git a/wrapper.c b/wrapper.c
index 354d784c034..f512994690b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -4,6 +4,9 @@
 #include "cache.h"
 #include "config.h"
 
+static intmax_t count_fsync_writeout_only;
+static intmax_t count_fsync_hardware_flush;
+
 #ifdef HAVE_RTLGENRANDOM
 /* This is required to get access to RtlGenRandom. */
 #define SystemFunction036 NTAPI SystemFunction036
@@ -564,6 +567,7 @@ int git_fsync(int fd, enum fsync_action action)
 {
 	switch (action) {
 	case FSYNC_WRITEOUT_ONLY:
+		count_fsync_writeout_only += 1;
 
 #ifdef __APPLE__
 		/*
@@ -595,6 +599,8 @@ int git_fsync(int fd, enum fsync_action action)
 		return -1;
 
 	case FSYNC_HARDWARE_FLUSH:
+		count_fsync_hardware_flush += 1;
+
 		/*
 		 * On macOS, a special fcntl is required to really flush the
 		 * caches within the storage controller. As of this writing,
@@ -610,6 +616,12 @@ int git_fsync(int fd, enum fsync_action action)
 	}
 }
 
+void trace_git_fsync_stats(void)
+{
+	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
+	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
+}
+
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;

base-commit: c54b8eb302ffb72f31e73a26044c8a864e2cb307
-- 
gitgitgadget
