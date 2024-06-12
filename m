Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7A16D4DE
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182461; cv=none; b=GosEH9Rdbem8j4623wedj7vwmrKXzCzptFTbZ5e/Ycv5OQte8E0HWykA1dSzbPtEw7H1AyB8w3zi+ljtJaDOa9auULPUoKQD7rfaUKDrpzYHmuHiLpc5/OMTQTD/orFxke1uibJvyGoOSOYmeTjEjI/19ydKAAWJ48wp5od1BMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182461; c=relaxed/simple;
	bh=FCEIirvyWI9fSrdamnTUFyP+fki2xypFIo94MXQtpjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CctSDnMrv0e2PNeS78ozBKumPYgT7i1SSNGAJMS73yH7CCUlM0eU1GvHwItfyI9FTjFKMSFV4faFHMkdhEuhMqh0J96zH7FNINc6qz3qSmMcPjwkONeB/Ltu6YkBnXqUn4G8DMZK71qUhhGawoJweeCDWXqcWDuTbDOwT5wYZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccinCpRj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccinCpRj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f70c457823so22858505ad.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182459; x=1718787259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi/YS2+xeYSf/7U/MQSUxtW0c0qSIfyJZyjsPey06l8=;
        b=ccinCpRjLVWOg+L16d/B2Nh2ZW1V5Z9Xckyy5wBz0Ldu80AJgYFz+TJmKmh6zAzIdX
         KG4j6/DRIW+DR8kBBhAE/jIZXEjANjRKBu30j/4sueJMJUdQ251BQoNZ886CwiU0VKPr
         2ZEq1KimWpWA1me5BW4ue9fHJ2O4xA8bFUm5FgtJj6jua2l+yOXvW4qbZiVLhn3h2SKv
         DbdwDF9iKjVqmeVBfejTjrHReO0dVUJ42VdVkbcgOUhAGuICdj1mUWfnLu9ioOK4GjLP
         fF7FIEGioZPH8bPiA6VnS7yZ5baf3HHBPY4SoG3HPHQj+SbQ0T+raIX52NgSKPbCKDn6
         LXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182459; x=1718787259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi/YS2+xeYSf/7U/MQSUxtW0c0qSIfyJZyjsPey06l8=;
        b=UM25ROVvtBOv4itOp5j6V5AUokZ3oiPhnrvPFVePoYuXjLvo4tYJeE90GEYbek6mfO
         /TBjOZrxk4tRPE2csdKEWNBK1SjH0PLdnBl8F3bKOEFW8RDXXGSLXKCCANBySXRBBLP0
         t4N7bHbOLHGUEGC2WaeVkGvDygjQCNUmGn1MvisqMy0JDB8vqi1n/niyHjLhaq7jfGWZ
         1GCOQQQ6A5ljrCNwwLcWaa0T9lv1WRzMgof96b7bUywbhv3VtGG4NCMyUiLZ62v+8ZB3
         elmBExSgdzvJi/rd4oZVubX2T78wRR87jG2kMFTJKNcCggg8XkVbfMVHNaVg76pVQ/Bl
         drBw==
X-Gm-Message-State: AOJu0YxYy7+3boyuDFqkU1yO55F+bDuIZ892zaqD47OQVD2cz8rlm/E5
	14mHfaT64vsaDfHNTk0Do48SqGrLIZ1B9Zuxp3K1cR07WLxKxcl9j3YOB+Up
X-Google-Smtp-Source: AGHT+IGZoz3cfpvSwQptcxQ8lLddHkQ0OprZaNdlyl+3fEtG6Td2Km+IaOVZIIrEu+eG+KA2Sv0JOQ==
X-Received: by 2002:a17:902:e808:b0:1f4:5ad1:b65e with SMTP id d9443c01a7336-1f83b660574mr13934665ad.34.1718182459406;
        Wed, 12 Jun 2024 01:54:19 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6eccc0bd0sm84066855ad.105.2024.06.12.01.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:54:18 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH v2 4/7] builtin/fsck: add `git-refs verify` child process
Date: Wed, 12 Jun 2024 16:53:46 +0800
Message-ID: <20240612085349.710785-5-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..10d73f534f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -896,6 +896,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(void)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -1065,6 +1080,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	fsck_refs();
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-- 
2.45.2

