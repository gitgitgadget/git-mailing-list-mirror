Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B9130E30
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255376; cv=none; b=U9TgiRW1fYvrju9GVQGNBBEaMnKt8dcHsyWCzErih1Wt4Ljkcu3C1Jd+UEhJ+Yp7MxKIk0SxEtDLgpmRC5dD/QxezuOaZaoXJt1O3fLtOWMuZJiZuQ6wRVBUjFVly1yd+lakm766SRuEqOmJczHa8L4Z5zY2im2sm0brcWvvI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255376; c=relaxed/simple;
	bh=XlF8UTd4PZpcoolOPS1+NnwXn0eu3NN2nbOCySTq6yU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fJPLT0e4Kxcf4gqt8PJQB++TnzKXFXOvd8xV+jiQOtJdaN+yIy/kJNfu9RopXJY/uVlhf+l8v4KG0ZG4qd++2w3o8IJH4vaSXcdVZvSUBZQXUWaUEjtrgOVumQ/e3xsiX+nSuTbNWl96WDPisDoAEY/WShUoxcSqoYLYpVLdePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdI2cLOp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdI2cLOp"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34388753650so618222f8f.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255372; x=1712860172; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wELA0xpHxohhRdXRAyqLhSgDFfxFxa1EhpuYj2LhL54=;
        b=VdI2cLOpb7yiBbJLL/6gI48go+ETSBcSWePs2aVycn5TP7dnXfszS124tvxwfbeGJl
         73xw2f2ilqoIAQYeUCmVEg4sOfyyXlVT7BEchRI4beX9JrMOuoRzPNDBG5dxxwU+3e3v
         oqjrdCEhnlAAr2bFSfqln8C41/RwtpX+GJ7PTDMvjcapFsBYXUlQdD1dev8dNqbB+RnN
         MipHiz1b+d/FO615zGsHOznbDGBruOPptChE7a3QxEknkMAXLXmw4S9/J5x500kB7iXd
         jORh5jNI52ew3AE/Tlz5UP+kMeGGZpRdIvKErTrF/qjdB5VFRiKTqnbC87mmNjQaYPds
         9vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255372; x=1712860172;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wELA0xpHxohhRdXRAyqLhSgDFfxFxa1EhpuYj2LhL54=;
        b=w6+s5WgO4YwhBKjLg/k5wcZPLdlPZNtvZu833NgMXkz2cmd/bPnKTHyV9tXTaTTwLw
         QpKsTr/Wiy1Zb9ei5wTJXz3EyHMv7NZR8hBT11feULJR6fhwjgaHf3LA3xhGlOSo9hFu
         PAOENjMd2lgiGAz3DQlsNLB+A1RyK5qyPpuPsICPZ6zYejCfmFmN98blyytmICBociyB
         1+/FGWZZUYypbxdYmmiwVmDlQ9l0H2S7Gp0NP3oMNJgt5rF/mcsdVIl8cBMUpGuOZ2f9
         8LgV9irU2PINvXVSiSZUz8Zrnjee/WKgDSl1GTNxNi3QJACxDgfkyAm4agx7eijf1oFW
         amsA==
X-Gm-Message-State: AOJu0Yxfj/bpf3HmCHab0ZZcEMOe86GFpWe0nao1ZeVjrZyer9C3DuU6
	cFisiDojxEFpUbpgF8tAOlKMCUpKHlJ09wZtt1qoun0gMen5bLlybdONvgcS
X-Google-Smtp-Source: AGHT+IHiwKWquuDB/o9qxUqGgBTUU7IHy7bvoJnMrW/HO4fnoN77dJwp9aVLGIkQASLFbHFFeYRNNw==
X-Received: by 2002:adf:9b9a:0:b0:33e:34aa:d78a with SMTP id d26-20020adf9b9a000000b0033e34aad78amr297498wrc.8.1712255372027;
        Thu, 04 Apr 2024 11:29:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000108400b00343bccbe0c7sm24920wrw.26.2024.04.04.11.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:29:31 -0700 (PDT)
Message-Id: <a7011dbc6aa5cb256957bda5456ca989ce75e4a5.1712255369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
References: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
	<pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Apr 2024 18:29:27 +0000
Subject: [PATCH v5 1/3] reftable/stack: allow disabling of auto-compaction
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Han-Wen Nienhuys <hanwenn@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

Move the `disable_auto_compact` option into `reftable_write_options` to
allow a stack to be configured with auto-compaction disabled. In a
subsequent commit, this is used to disable auto-compaction when a
specific environment variable is set.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 reftable/reftable-writer.h |  3 +++
 reftable/stack.c           |  2 +-
 reftable/stack.h           |  1 -
 reftable/stack_test.c      | 11 ++++++-----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 7c7cae5f99b..155bf0bbe2a 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -46,6 +46,9 @@ struct reftable_write_options {
 	 *   is a single line, and add '\n' if missing.
 	 */
 	unsigned exact_log_message : 1;
+
+	/* boolean: Prevent auto-compaction of tables. */
+	unsigned disable_auto_compact : 1;
 };
 
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index dde50b61d69..1a7cdad12c9 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -680,7 +680,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 	if (err)
 		goto done;
 
-	if (!add->stack->disable_auto_compact) {
+	if (!add->stack->config.disable_auto_compact) {
 		/*
 		 * Auto-compact the stack to keep the number of tables in
 		 * control. It is possible that a concurrent writer is already
diff --git a/reftable/stack.h b/reftable/stack.h
index d919455669e..c862053025f 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -19,7 +19,6 @@ struct reftable_stack {
 	int list_fd;
 
 	char *reftable_dir;
-	int disable_auto_compact;
 
 	struct reftable_write_options config;
 
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 351e35bd86d..4fec823f14f 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -325,7 +325,7 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->disable_auto_compact = i != n;
+		st->config.disable_auto_compact = i != n;
 
 		err = reftable_stack_new_addition(&add, st);
 		EXPECT_ERR(err);
@@ -497,6 +497,7 @@ static void test_reftable_stack_add(void)
 	struct reftable_write_options cfg = {
 		.exact_log_message = 1,
 		.default_permissions = 0660,
+		.disable_auto_compact = 1,
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
@@ -508,7 +509,6 @@ static void test_reftable_stack_add(void)
 
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
-	st->disable_auto_compact = 1;
 
 	for (i = 0; i < N; i++) {
 		char buf[256];
@@ -935,7 +935,9 @@ static void test_empty_add(void)
 
 static void test_reftable_stack_auto_compaction(void)
 {
-	struct reftable_write_options cfg = { 0 };
+	struct reftable_write_options cfg = {
+		.disable_auto_compact = 1,
+	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 
@@ -945,7 +947,6 @@ static void test_reftable_stack_auto_compaction(void)
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 
-	st->disable_auto_compact = 1; /* call manually below for coverage. */
 	for (i = 0; i < N; i++) {
 		char name[100];
 		struct reftable_ref_record ref = {
@@ -994,7 +995,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->disable_auto_compact = i != n;
+		st->config.disable_auto_compact = i != n;
 
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "branch-%04d", i);
-- 
gitgitgadget

