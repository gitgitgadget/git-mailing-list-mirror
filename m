Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C53B637C
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684192; cv=none; b=Ixzd6YvMd/v3NF0E+vtoDz+0Ex9kd8N1uuoynY71GDxP1WbsmW3C2VmwP2ZzAn9llidx8CUMtYu6LqUCSPqHPlXzixAzytOizYcxu7o0MNJY1+Sk86PUVvasoRZW2sf3hfc4lvsag9gHzu8QiM8dCBXiAXNxVpwOzhCyMrzSltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684192; c=relaxed/simple;
	bh=S8c0Id+8BzCxA2bfoFC8QShcCv/e7yKNoTiioSmfhP4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NWo/g26N6TSVslKGLtNujVvdhJz7RSzekpMFGMXX7weGFGHPWO7XyjNnuZL7f1Pa1QucqLUiKAne2tN2YHU3lHNez53aeYwZoiKMYne3axSdsjAjz7Rcxn9E0uPh/XQMC54xgJI2V37l3JXcy4ox8SvVp6Zj9L3nQUNGQ59Rlns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzFoRNnW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzFoRNnW"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so110403a12.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684185; x=1788288985; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dQhDp6e2w4cTdyXRw8OqoH9VLxR0+QAvrjQWpu8Z488=;
        b=SzFoRNnW+Rs5AGGEELnkXlrjyd+/svcHaqEzkWz9ov0YaAoDHThDG8NJMsAuSr7v0W
         Hip4LC0wqvd4QBn2zwKz43A1L/IGS4YVJkDhl78GAVRyVk1bOpglOeQgWFB2jSDZTJyc
         7VDP+f0oirE3zMZ+5OCGmMyP+WxwcAhIGvoj3GVCHyMoXynxvAhxEm+jBYsiwzbPTy7R
         /tdpTSTd+4phXY+LeUaspWmmHkcpNrcOaFI1jL06JACv69N/DSIn0IzzGMYUaIbGqSLB
         00OjWNdq5j48BYZJ3aMDw6KbxNRXzNW4AXfry5QlF9SSQ4ez0DTjtikr+9CPpVLW0O3i
         vgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684185; x=1788288985;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQhDp6e2w4cTdyXRw8OqoH9VLxR0+QAvrjQWpu8Z488=;
        b=rDMthGT0M8YoTtiMSxSqqmlNldGUzUSSmI355VVl74/bDf+6+NQnug5sOQaX+vmDYf
         Y134ufWL8JOqUslZDfX2AoyV2nYSiXamJkUf5UmS71P/YUFntVX5eK2tNfH06zFeaoU6
         Isqexg91IRvJYGXuLbCmvnNcipGDbgspwNpN1+Bq+CBrfYchGDGb5VfOEe3ND5o+lws4
         p3vSFat1AgCAEAFADL8d7NnyDbYDbtmVwkITIjK39mN1hXudgqbfxwtcPmpprLLypU9+
         UKltj8mFIw6qoUJDG3kGXTiYdeTHE4nSuhxH0N+rPBilnFwwkJA8kd9NZPiTXkzPchad
         AeZA==
X-Gm-Message-State: AFuF++lDAZrlOzhvQNftVLbGvVMrhGSiRFt7Hrz7yPPvW7He3TdOllyD
	66YqSgRv2brpcoVbZt+QQ0zNK0pp9kRw2g+wwtHQxpoACzUR8vNPopr8MEowpg==
X-Gm-Gg: AR+sD13onBJJcZRuuA+SEaVWSiN6zm9mUI6RsfrtOuRPV4DJeO/wj8lss8MFMorIJsX
	a1NM8xOzf++c/eI2f1RfZQS69ztS8sprVsltWluIrvbR0bHWyRGGUygOEhPRHyODYk5nr72TZ2E
	+d4L3EQGlAR1S9WRMIiCyoXE948lBsn0XLVmzAo8Ok1wU3xoYRCIJqgiaWPcV9Nrsh/wfTo4ceC
	jbjBr+COSqB8yn8XLGOHbfwf7+teQofePmT1qxAs1Cr0CrmNCRb4x1w3xcp9arOHYoTuoF3lE4D
	jdraLikMtSnCwNI5lrD0JJXSrfDB+ljagouNIIpWTHJ7nzU+YLeLozTGFwGErgY3fOlo2J0JNSU
	QUJVNN+gXWEX2Up1NKqP/TzGBpLgdGWqC6rOxTlLhYLJ+r702n0JDZG7PQ/eI0ZN3l5p9zC4BMj
	Of+jKgYVDsMfLyd+8IThkEiwvmeUY6FA4KjPkJtxnxg3HO1wBm6a7rZcTV1/yqKciD
X-Received: by 2002:a17:90b:3848:b0:396:40e6:f631 with SMTP id 98e67ed59e1d1-3966d178358mr2313978a91.3.1787684184824;
        Tue, 25 Aug 2026 11:56:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm1239838c88.0.2026.08.25.11.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:56:24 -0700 (PDT)
Message-Id: <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 18:56:15 +0000
Subject: [PATCH v2 1/7] banned-die: create header for banning of functions
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

We have universally-banned functions listed in banned.h since
c8af66ab8ad (automatically ban strcpy(), 2018-07-26), but some layers of
the code should be more strict than others.

One such example is the trace2 API which runs during atexit() and can
prove to cause die()-handler recursion problems if it calls die().

Create a new banned-die.h header file that will ban some Git methods
that call die(). Include that in all trace2 API implementation files.
This currently only bans die() itself, and that was already not used.

It would be reasonable to name this file trace2/tr2_banned.h to be
specific to the trace2 API, but it seems like such a restriction would
be valuable to put in some other areas of the code, so adding it at the
root of the tree seems like a good long-term approach.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h            | 14 ++++++++++++++
 trace2.c                |  1 +
 trace2/tr2_cfg.c        |  1 +
 trace2/tr2_cmd_name.c   |  1 +
 trace2/tr2_ctr.c        |  1 +
 trace2/tr2_dst.c        |  1 +
 trace2/tr2_sid.c        |  1 +
 trace2/tr2_sysenv.c     |  1 +
 trace2/tr2_tbuf.c       |  1 +
 trace2/tr2_tgt_event.c  |  1 +
 trace2/tr2_tgt_normal.c |  1 +
 trace2/tr2_tgt_perf.c   |  1 +
 trace2/tr2_tls.c        |  1 +
 trace2/tr2_tmr.c        |  1 +
 14 files changed, 27 insertions(+)
 create mode 100644 banned-die.h

diff --git a/banned-die.h b/banned-die.h
new file mode 100644
index 0000000000..5eff361e55
--- /dev/null
+++ b/banned-die.h
@@ -0,0 +1,14 @@
+#ifndef BANNED_DIE_H
+#define BANNED_DIE_H
+
+#include "banned.h"
+
+/*
+ * This header lists functions that must not be used by low-level APIs
+ * because they can cause Git to terminate.
+ */
+
+#undef die
+#define die banned(die)
+
+#endif /* BANNED_DIE_H */
diff --git a/trace2.c b/trace2.c
index c23c0a227b..1d0ed2db2b 100644
--- a/trace2.c
+++ b/trace2.c
@@ -17,6 +17,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+#include "banned-die.h"
 
 static int trace2_enabled;
 static int trace2_redact = 1;
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index bbcfeda60a..06912a3ceb 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -7,6 +7,7 @@
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_sysenv.h"
 #include "wildmatch.h"
+#include "banned-die.h"
 
 static struct string_list tr2_cfg_patterns = STRING_LIST_INIT_DUP;
 static int tr2_cfg_loaded;
diff --git a/trace2/tr2_cmd_name.c b/trace2/tr2_cmd_name.c
index b7b5a869b7..88f24e8781 100644
--- a/trace2/tr2_cmd_name.c
+++ b/trace2/tr2_cmd_name.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "trace2/tr2_cmd_name.h"
+#include "banned-die.h"
 
 #define TR2_ENVVAR_PARENT_NAME "GIT_TRACE2_PARENT_NAME"
 
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index ee17bfa86b..3067df4d18 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -2,6 +2,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_ctr.h"
+#include "banned-die.h"
 
 /*
  * A global counter block to aggregate values from the partial sums
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 5be892cd5c..686a3e42fc 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -5,6 +5,7 @@
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
 #include "trace2/tr2_sysenv.h"
+#include "banned-die.h"
 
 /*
  * How many attempts we will make at creating an automatically-named trace file.
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 1c1d27b0ee..358f61b301 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
+#include "banned-die.h"
 
 #define TR2_ENVVAR_PARENT_SID "GIT_TRACE2_PARENT_SID"
 
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 4abc218514..deb3fabff4 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "dir.h"
 #include "tr2_sysenv.h"
+#include "banned-die.h"
 
 /*
  * Each entry represents a trace2 setting.
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index c3b3822ed7..86725426f6 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "tr2_tbuf.h"
+#include "banned-die.h"
 
 void tr2_tbuf_local_time(struct tr2_tbuf *tb)
 {
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 5a0381791f..a055e19bac 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -13,6 +13,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+#include "banned-die.h"
 
 static struct tr2_dst tr2dst_event = {
 	.sysenv_var = TR2_SYSENV_EVENT,
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 924736ab36..97d4c5d202 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -11,6 +11,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+#include "banned-die.h"
 
 static struct tr2_dst tr2dst_normal = {
 	.sysenv_var = TR2_SYSENV_NORMAL,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 4eb9289f95..1f49d9f922 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -14,6 +14,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+#include "banned-die.h"
 
 static struct tr2_dst tr2dst_perf = {
 	.sysenv_var = TR2_SYSENV_PERF,
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 7b023c1bfc..ae2d39d2f5 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -3,6 +3,7 @@
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2/tr2_tls.h"
+#include "banned-die.h"
 
 /*
  * Initialize size of the thread stack for nested regions.
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
index 038181ad9b..a329c466b9 100644
--- a/trace2/tr2_tmr.c
+++ b/trace2/tr2_tmr.c
@@ -3,6 +3,7 @@
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
 #include "trace.h"
+#include "banned-die.h"
 
 #define MY_MAX(a, b) ((a) > (b) ? (a) : (b))
 #define MY_MIN(a, b) ((a) < (b) ? (a) : (b))
-- 
gitgitgadget

