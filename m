Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D8471274
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197148; cv=none; b=RAt7vr1SWQ+7NKmnk8MIVAf8O2dK3njKdz4IeIU4JNfMti9wisgrdJAyOGlJownHCUT4NafNzAtyPb19i9KR+k9dRIpyCym8XqV4wiK3/dBCoKJlLZxYrQOFZhfIYyhRoyF52no14BUt7WCnOzk8Q/PXfL+vBJ7xTD7iP5jBgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197148; c=relaxed/simple;
	bh=2G5WncU4EFYSz93WkkqXLD6iBGdVrXrfOreuWtT/8DU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BUsSMxq863+J0hr4yws1TIwBhcOA6tm66a+hShY/Fim9gryTXHkqkc9ZBwIgF5YRvR0eP2P94o3q3J7iAKVFpIoA7/GkAeo30wH2uHFMNkhTt0k173Wk2/GLDHqRUUpVhLtayNpbZ07f08PABdIVYYZ6F5EIQi05JmXIhMAq4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okZXPWUo; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okZXPWUo"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90e8095621eso18037296d6.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197145; x=1788801945; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=prxZcGdNpmvxn5rXRHkaWFQGPch3Y6lNfyWfPVzcCcA=;
        b=okZXPWUoBtnv0OlmEkWLr6XAnJuXJwxYLBDzAZ8FMlJ+aIH6XmNt2w5AVefzEbcnw8
         di0LIJIDlz28BJxLEJaqzdq7DPOXjm9rD9lvCGSwBejhGF8dYbIZcGqRK00FrTZQJ3iN
         6cAR66RzPl2laRekxLcSGnAZIhm0LpItxurptNtiZmfREHsBoX4wkydy0iDX6cx1sLfc
         fMDgYaIXbUwsbUid9rJDFDlDODz/qnBgf6BO8MJCmc2YOaN6vdqunjo999t7yl8g+M29
         voLgDcJEy5Oly9OcSY4MMA65GorghgzWxdhyd7pWj9ZG2rw9dHJQgIfI/3rvBFLWqR0i
         aVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197145; x=1788801945;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prxZcGdNpmvxn5rXRHkaWFQGPch3Y6lNfyWfPVzcCcA=;
        b=SVQzkMP2QV9FmWCDMzFCbNnKNglPd7nmcMKmgtVcSIk1xweUWLxRrrrxbraQtwakze
         Zqly6ehC0PwXOp+ETkZUmVXoMPSc+TuOEX3Q5fLfneq2WD0x/lfipF32+3Wau2ppt59A
         QtoBdTqM3lvxV27haY5zkBPtBoyTZuENN54+UDYOPYqbXIArGqYTV8My1bRzAn7S4gb3
         ykhrMKk3AtmAaBHTHELrYm7DEt7HmMkjFEAs0wAn98eMiCHd1NFsMSHaZbBbUOSabPGg
         PXEPHmlfINkuz3ceRuZCi8UzN9DXQt3SpJWqwlyJteXahNdnLuujx8382ER0IIlUO6oK
         P/GA==
X-Gm-Message-State: AFuF++kjQG+rSFGFR1gDo8YyKjLUbPSC126gmigtruNNlzPhaJuFKb2J
	GMMqtjAZiqxWNvKVUvdBXe5xrE3rqpvWJhUKRV03n04wMuJpMbtkbZwHZh68mcc5
X-Gm-Gg: AR+sD10LTWcAwwZRzPk4VTVNpRqBcb86hpGhyGViaq6lEdDAobakDjs78FpBhLhCXH8
	ZLuH5tMh4dFUArjbtr39AjTnLKo9yLeKO83rJe4/m29/EUa+OuugvdsMqiwylBf8jpre9Tuceq4
	vFsscaFhhPHUwGoXjMhO+pfEnC/PZ3FG9ZNAPJwYi3d+8946MKQTK5Tx2+hBSl1MJPeGMUHlPC5
	Z6AcN4vlQAseRsxCcmeN44HXbhOEamre1QEFY7DAYRcgkwhmTBS+ZH3tQIE+FGT6Z1hmSeiTauO
	lSmgEUIH8JIVDTEn8CnJ9Pd21sKFX7/lRsg5vYgNcUoceUiood3oGu5s8SwHAg8ZO785RxbdLoE
	VD3+j5sNclz6jkFOkZqzULvURhi3zF67/HgQnKbN9BKX3H5g3RcxRhflbYznGzJA2Ocu9J82Ipw
	UYSAEZTnCVCR1MzeptHOMPe5rAY7bfdqSm6BRCxGuiZqbE0RkILuBnztvjbmF6p9drYstjlenK/
	Ic=
X-Received: by 2002:ad4:5f0d:0:b0:8f0:3b2c:a9c8 with SMTP id 6a1803df08f44-90e9292ddebmr36833206d6.12.1788197145141;
        Mon, 31 Aug 2026 10:25:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce44f5157sm88896426d6.24.2026.08.31.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:25:44 -0700 (PDT)
Message-Id: <c483a4bf764c47ee2c7f715ff8143196cac73b9b.1788197143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 17:25:37 +0000
Subject: [PATCH v3 1/7] banned-die: create header for banning of functions
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
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
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
 trace2.c                |  2 ++
 trace2/tr2_cfg.c        |  2 ++
 trace2/tr2_cmd_name.c   |  2 ++
 trace2/tr2_ctr.c        |  2 ++
 trace2/tr2_dst.c        |  2 ++
 trace2/tr2_sid.c        |  2 ++
 trace2/tr2_sysenv.c     |  2 ++
 trace2/tr2_tbuf.c       |  2 ++
 trace2/tr2_tgt_event.c  |  2 ++
 trace2/tr2_tgt_normal.c |  2 ++
 trace2/tr2_tgt_perf.c   |  2 ++
 trace2/tr2_tls.c        |  2 ++
 trace2/tr2_tmr.c        |  2 ++
 14 files changed, 40 insertions(+)
 create mode 100644 banned-die.h

diff --git a/banned-die.h b/banned-die.h
new file mode 100644
index 0000000000..1cde4035c1
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
+#define die BANNED(die)
+
+#endif /* BANNED_DIE_H */
diff --git a/trace2.c b/trace2.c
index c23c0a227b..8c974dee87 100644
--- a/trace2.c
+++ b/trace2.c
@@ -17,6 +17,8 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 static int trace2_enabled;
 static int trace2_redact = 1;
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index bbcfeda60a..757dfeae8d 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -7,6 +7,8 @@
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_sysenv.h"
 #include "wildmatch.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 static struct string_list tr2_cfg_patterns = STRING_LIST_INIT_DUP;
 static int tr2_cfg_loaded;
diff --git a/trace2/tr2_cmd_name.c b/trace2/tr2_cmd_name.c
index b7b5a869b7..f378bef4cf 100644
--- a/trace2/tr2_cmd_name.c
+++ b/trace2/tr2_cmd_name.c
@@ -1,6 +1,8 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "trace2/tr2_cmd_name.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 #define TR2_ENVVAR_PARENT_NAME "GIT_TRACE2_PARENT_NAME"
 
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index ee17bfa86b..20618a65b2 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -2,6 +2,8 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_ctr.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 /*
  * A global counter block to aggregate values from the partial sums
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 5be892cd5c..555ac7cb9e 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -5,6 +5,8 @@
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
 #include "trace2/tr2_sysenv.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 /*
  * How many attempts we will make at creating an automatically-named trace file.
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 131b4f5a62..1d4f018f66 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -3,6 +3,8 @@
 #include "strbuf.h"
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 #define TR2_ENVVAR_PARENT_SID "GIT_TRACE2_PARENT_SID"
 
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 4abc218514..7fa58eba91 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -4,6 +4,8 @@
 #include "config.h"
 #include "dir.h"
 #include "tr2_sysenv.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 /*
  * Each entry represents a trace2 setting.
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index c3b3822ed7..d623e55a81 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -1,5 +1,7 @@
 #include "git-compat-util.h"
 #include "tr2_tbuf.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 void tr2_tbuf_local_time(struct tr2_tbuf *tb)
 {
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 5a0381791f..36a746cc10 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -13,6 +13,8 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 static struct tr2_dst tr2dst_event = {
 	.sysenv_var = TR2_SYSENV_EVENT,
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 924736ab36..82995e510f 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -11,6 +11,8 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 static struct tr2_dst tr2dst_normal = {
 	.sysenv_var = TR2_SYSENV_NORMAL,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 4eb9289f95..96a5bc7f10 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -14,6 +14,8 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 static struct tr2_dst tr2dst_perf = {
 	.sysenv_var = TR2_SYSENV_PERF,
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 7b023c1bfc..49bd505d62 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -3,6 +3,8 @@
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2/tr2_tls.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 /*
  * Initialize size of the thread stack for nested regions.
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
index 038181ad9b..275091c693 100644
--- a/trace2/tr2_tmr.c
+++ b/trace2/tr2_tmr.c
@@ -3,6 +3,8 @@
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
 #include "trace.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 #define MY_MAX(a, b) ((a) > (b) ? (a) : (b))
 #define MY_MIN(a, b) ((a) < (b) ? (a) : (b))
-- 
gitgitgadget

