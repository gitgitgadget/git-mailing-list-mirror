Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DEB2EA15B
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607858; cv=none; b=emYQ9awshscdoyRPurSrR6HMHM8qwUeWloHH3DVqD6PWu9yR3EVi04goTBQM9XdqTgMg+idz86N8I1PKK0regemBdImPdvG++juhhurpPpfbo9pW4PdwDLn82y8CooHd05kfBpaECr0AMTfEBcQVabepAF3XsVpym79PBdvDKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607858; c=relaxed/simple;
	bh=QRjQDxSJoRwUcP7NwIibrR7oeKzYDjvzIOq0nT0My/g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XtSJUbX65h0Ov3CV5I6wfsBJDJ5XSqlFa5Kqfji34sNMTgcAK5GsmUErdatKwF22+X7XyIPpchknwWFDX9Y+YFRRYG1Y95ytdZiA40rUs1bHUyVcjTn2e+6aVwrPAVIJMwCZEATeDxxPqxV57E7YyGQ3uumU5mFiCL+OT/WHSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU8Mgy1N; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU8Mgy1N"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aace33b75bso4302121b3a.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 08:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764607855; x=1765212655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pB1heDHZreGerIMaxMHWf95Plbp8EWjvn+vGZ3CYc1Q=;
        b=FU8Mgy1NIrZt4WtX3+0V7bEmHrC5NbvU8CrffJiugtKdQjtxWGie8k7ROb4Q76BLfP
         LLV9jYAD9whD6tc9nr7dppDN+COtaUYuUyfeio0axCdjWtON8upPFwlmALpGpHarE2v4
         FsRogugS4rEZxmeNN/FoEK1CIg3IuG8SK+r1sGKskkca9G6KN0GGtCW3yRt59xYqNKVN
         5Sk9JvwgTdWq27F9BK8KW8y2PE0cIsfiSawgyFVdZGNA9ndBByl0SXcz0wCJtwnABeV8
         sLMq++lvtxDH6gprCKBMsi85C7KdgtwD2RDjV/pn2YbbsNCU4A9KK9OqvLmJLeduiCFi
         JBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607855; x=1765212655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pB1heDHZreGerIMaxMHWf95Plbp8EWjvn+vGZ3CYc1Q=;
        b=h1DlVJ1OhjkYAGih9iVTcSeY0Q7aVi9PSo9dkuP9LCr24XH2+3S6wy1SBSyfg/zrSO
         SZKFausbeO7uY/rjLoavif9d+tT4HHuHN06yziWVKM/dUQY18r0knYgmgITymHpW/70E
         meFTBd7+Zcj8DsImkarFdlwAU3SSVLConPH/ZOTBFtV4Ih1O3DpZu6DDHGDP4IjDrYml
         rX+XW/hDWG+zvE3xRudsansq4jp7KyQaQiZO3WEXT3SygXkoABiqO2FSSOp82nrFrGmI
         d1/jJvcZvhF/ddTAySElg3qhi4SDUCZ5OgAS9B8eBBbKyAfWHZ5ArOPPDbmJWHQHZ/Tt
         FI6A==
X-Gm-Message-State: AOJu0YzaxttGptdf+3XdIUwlI+cJYdJJAWUXFdOyv5d8L2HdJujjG+rH
	oC5LV6YYc2UpaFYGegeGFiV2c+flw1kJKyuMZm9JPG5c8dtEmo93Ocy/PBBR3j3x
X-Gm-Gg: ASbGncsyBrJzS9E5ZXYl1ljl0lPZcESJUcL03EZanh+jqGNQDgvdl5Rai82qmf6bSJe
	hrbWId4szxwbIMTh5NKlejV7DVd1EJWE1hyPtD4+n3X6EmvjYP/bi25FBhJ8Ch4N0fBGHLcperR
	SowzfDZYdgUbEmUsnXlDHYiRGm6mfc6EmQsgpzfsyK+J75nGTPQ4l02tQbWBUgHZF/09hSJ1uqP
	pUhuux2IoCHfyTFYZI41mKN4HPLkra2XnL7vMiKDeWdvgv20x//f6LEEZQM50d7ZtCrLzj/e9Or
	5HITmjagIS82cG9pbVjAf+SzFAe1o2K854GudWH6haTXmZRxjU6tmXF0k6eMA5CAS2/FAUZdUiy
	mwPamu6kN/cPQtt6sfZGpKoBK1dPrLXI85y52fHP41eAyrsMs7JwxHk3Ol3pqdiHTjTz469LXkg
	seUYEMI+YWNCd82A==
X-Google-Smtp-Source: AGHT+IHbBiCFst+7wzMH11eVOGAY4I7OlGm8Oo7sU2S5AvL1ClscqC9cUC4oCdWmyzwt+wJxowT2Qg==
X-Received: by 2002:a05:7022:b83:b0:11b:9386:8269 with SMTP id a92af1059eb24-11c9d87008bmr29076644c88.46.1764607855270;
        Mon, 01 Dec 2025 08:50:55 -0800 (PST)
Received: from [127.0.0.1] ([20.168.106.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm75425992c88.9.2025.12.01.08.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:50:54 -0800 (PST)
Message-Id: <edc0254770597de89c64951e4d8932ed70ab41f2.1764607847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Dec 2025 16:50:46 +0000
Subject: [PATCH v2 4/5] scalar: alphabetize and simplify config
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
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The config values set by Scalar went through an audit in the previous
changes, so now reorganize the settings and simplify their purpose.

First, alphabetize the config options, except put the platform-specific
options at the end. This groups two Windows-specific settings and only
one non-Windows setting.

Also, this removes the 'overwrite_on_reconfigure' setting for many of
these options. That setting made nearly all of these options "required"
for scalar enlistments, restricting use for users. Instead, now nearly
all options have removed this setting.

However, there is one setting that still has this, which is
index.skipHash, which was previously being set to _false_ when we
actually prefer the value of true. Keep the overwrite here to help
Scalar users upgrade to the new version. We may remove that overwrite in
the future once we belive that most of the users who have the false
value have upgraded to a version that overwrites that to 'true'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 60 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/scalar.c b/scalar.c
index 5fef9a4104..1fbd02e03a 100644
--- a/scalar.c
+++ b/scalar.c
@@ -133,10 +133,33 @@ static int have_fsmonitor_support(void)
 static int set_recommended_config(int reconfigure)
 {
 	struct scalar_config config[] = {
-		/* Required */
-		{ "am.keepCR", "true", 1 },
+		{ "am.keepCR", "true" },
+		{ "commitGraph.changedPaths", "true" },
+		{ "commitGraph.generationVersion", "1" },
+		{ "core.autoCRLF", "false" },
+		{ "core.logAllRefUpdates", "true" },
+		{ "core.safeCRLF", "false" },
+		{ "credential.https://dev.azure.com.useHttpPath", "true" },
+		{ "feature.experimental", "false" },
+		{ "feature.manyFiles", "false" },
+		{ "fetch.showForcedUpdates", "false" },
+		{ "fetch.unpackLimit", "1" },
+		{ "fetch.writeCommitGraph", "false" },
+		{ "gc.auto", "0" },
+		{ "gui.GCWarning", "false" },
+		{ "index.skipHash", "true", 1 /* Fix previous setting. */ },
+		{ "index.threads", "true"},
+		{ "index.version", "4" },
+		{ "merge.renames", "true" },
+		{ "merge.stat", "false" },
+		{ "pack.useBitmaps", "false" },
+		{ "pack.usePathWalk", "true" },
+		{ "receive.autoGC", "false" },
+		{ "status.aheadBehind", "false" },
+
+		/* platform-specific */
 #ifndef WIN32
-		{ "core.untrackedCache", "true", 1 },
+		{ "core.untrackedCache", "true" },
 #else
 		/*
 		 * Unfortunately, Scalar's Functional Tests demonstrated
@@ -150,34 +173,11 @@ static int set_recommended_config(int reconfigure)
 		 * Therefore, with a sad heart, we disable this very useful
 		 * feature on Windows.
 		 */
-		{ "core.untrackedCache", "false", 1 },
-#endif
-		{ "core.logAllRefUpdates", "true", 1 },
-		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
-		{ "gc.auto", "0", 1 },
-		{ "gui.GCWarning", "false", 1 },
-		{ "index.skipHash", "true", 1 },
-		{ "index.threads", "true", 1 },
-		{ "index.version", "4", 1 },
-		{ "merge.stat", "false", 1 },
-		{ "merge.renames", "true", 1 },
-		{ "pack.useBitmaps", "false", 1 },
-		{ "receive.autoGC", "false", 1 },
-		{ "feature.manyFiles", "false", 1 },
-		{ "feature.experimental", "false", 1 },
-		{ "fetch.unpackLimit", "1", 1 },
-		{ "fetch.writeCommitGraph", "false", 1 },
-#ifdef WIN32
-		{ "http.sslBackend", "schannel", 1 },
+		{ "core.untrackedCache", "false" },
+
+		/* Other Windows-specific required settings: */
+		{ "http.sslBackend", "schannel" },
 #endif
-		/* Optional */
-		{ "status.aheadBehind", "false" },
-		{ "commitGraph.changedPaths", "true" },
-		{ "commitGraph.generationVersion", "1" },
-		{ "core.autoCRLF", "false" },
-		{ "core.safeCRLF", "false" },
-		{ "fetch.showForcedUpdates", "false" },
-		{ "pack.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget

