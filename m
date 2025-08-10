Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6561A314B
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754869585; cv=none; b=M+hI9UEL47jlwoMFLjWiZWalr/BhpVBpx0GT5dGxTU6ahHsuPV8tQxNavBeJvq1MjUXMsgVwPdYOlEcW8EKIwh+4LeaA4edlg88u2ZGinnvoYYGH4vedZigrTqyEDrBlHqx4UYm/nwj5h435ziy3NfEQuaYyIqG/rmlf8Rr8AFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754869585; c=relaxed/simple;
	bh=ScI+mKc0SJafG50VJKPW7jDZSKJLkH5fvSSI3019M7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJoAP7l36qg5QKDZhRRDCsVYIkiNjkyXo4ciyUrdOqbGJMCst45LNEsCs40u4d1J/LgBavBFX78109ig0L5x+KMleenU692tee93cEFjuoq/NFDyaEG+8uGoiaPo4MfpRKQ4sIAmmOPQnzEqcR1HKsaQfKPu0blgV9/NJmZ5fs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYT2i6cI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYT2i6cI"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-321265ae417so4306692a91.2
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754869583; x=1755474383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zmTgpVTBo82qROTtT3XcYrUfNseMiYDlhdSKKhqYD4=;
        b=PYT2i6cIksDUmsyijZwjTTRsReMPcPCVRlpwpv2VBMXMK7F3ytoo95lrfaLnqGz8az
         q6NjxHkVsQMZHm+MHRDa2R+B6/Z851B3KhAhzeKBJYzXRLuNEgiFHp06vS+GDOF+uhFB
         SiFlCaUm/kpUQz+zncyX1xWIK13x+i2O1n3HC+vetvlpjsXSstGwXsP77pBHP3iWgemf
         a5GgSQRzshYoKftFH5X5r1b04awZePsdYGY2nEJghjs4XIghTxDNwxmwYhD73u1NbxHJ
         F9WBmEuu7FFURrj+wUq65/X4f6LEw/MP0HE4xC3IOFC3Cdm3YGHdvnpJm9RvNIiHTRzp
         xpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754869583; x=1755474383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zmTgpVTBo82qROTtT3XcYrUfNseMiYDlhdSKKhqYD4=;
        b=DsD+OAQvUuHfFCCuD5EfptmZ8xbimuS1U2rlHFJPGr2+8nEu/hxXCV3+QW2uulWSEj
         wze2zTv3qTeTVAT2w1d8kiKqT56HU3zbnIpT8m7FwyDpXSncKubglJJ0ch2QZgPRN4xF
         52wm6GvSzdCgQxk60SjRMXyhu2YXO6JNt4UR0NffBxvuA1JC4b4OxcWCSW3Xp4AfFcph
         b9RqS5aEzXKVTSPoWP2a7NTBU0ZwCrpmZLXg/OVklveEaePJbHFqfzaw5ye1C9KDiFNh
         5Lsmtj0UNn4Y2yHkkPoXW22nocT4boXaun0aYed38Hq36IK9D7zLPk6631uWd93hCs9Z
         xPDA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Tq50Y0qy0q33RWz3hMrsfkgOzxQZHLQsESleHg/c6g2QZ7kZiR9KX3jnigDSSDzlC1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbHiCz3DbAOfKRaRtQIlCy2Th91Hoe4jagaLZI4ajSw9Mj3tt
	zLp+GmFSg4N99r63YugXfcHkXiHxz/hipCN2dSyh+NKhqp0TANbJQYLoqqWiNSzA
X-Gm-Gg: ASbGncs+q8QrNERuluqkrQWUxEhQ/FSTjTtaIHVEn6yk7SDignRu68EJNUsM2pRdoyX
	3saJGaSiJKLCERf/6jXt7IhtLpu19kJsThwbWDWz1mm+Y5k6BliPBtwKZRyrynLPUbNedI4VkHx
	5pSasF0bc5EqP+pcVk7Cf3tftOBsi+mj2PpSbzr+4grrcQGkkZxbDi2NAnvzgJ39rzny6g7hFoz
	RnwBdphPBvCLNkmEBjzMizgXgT1OxuZHggMd9yiFHIDmButDQ4pUVW13JwWv6EcM8GLeq6cD4HO
	zkZuFpgb1RulRFpJeorma6KzPhxUMRaSOJjiPmMdjP1dLoqMC/W90Y2bfnyauLfhXZmMunnR501
	5YUh3Pr1JruYJUwtzJ/yPAzFE8WSlVBUeNtyI/4CsFPXpbtQRRtSxNmQ=
X-Google-Smtp-Source: AGHT+IFnHbpPAjek7xXl5pnY65R/eS/LeOEb1uP5dJ8Nde4ghw+E23REKgRFqSMS/+2kOKhVX0NfNA==
X-Received: by 2002:a17:90b:48d1:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-321839fde25mr17662595a91.15.1754869583430;
        Sun, 10 Aug 2025 16:46:23 -0700 (PDT)
Received: from thinku.tailbd49c4.ts.net ([103.37.200.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102b9022fsm12349173a91.4.2025.08.10.16.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 16:46:23 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: [GSOC PATCH v2 2/2] builtin/fmt-merge-msg: stop depending on 'the_repository'
Date: Mon, 11 Aug 2025 05:15:46 +0530
Message-ID: <8e55516cdae9e8dc0ea85e2cd7b72ddc93790997.1754868681.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754868681.git.ayu.chandekar@gmail.com>
References: <cover.1754868681.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor builtin/fmt-merge-msg.c to remove the dependancy on the global
'the_repository'. Remove the 'UNUSED' macro from the 'struct repository'
parameter and replace 'git_config()' with 'repo_config()' so that
configuration is read from the passed repository. Also, add a test to
make sure that "git fmt-merge-msg -h" can be called outside a
repository.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/fmt-merge-msg.c | 5 ++---
 t/t1517-outside-repo.sh | 7 +++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4b24de32fb..cf4273a52c 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fmt-merge-msg.h"
@@ -13,7 +12,7 @@ static const char * const fmt_merge_msg_usage[] = {
 int cmd_fmt_merge_msg(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      struct repository *repo)
 {
 	char *inpath = NULL;
 	const char *message = NULL;
@@ -54,7 +53,7 @@ int cmd_fmt_merge_msg(int argc,
 	int ret;
 	struct fmt_merge_msg_opts opts;
 
-	git_config(fmt_merge_msg_config, &merge_log_config);
+	repo_config(repo, fmt_merge_msg_config, &merge_log_config);
 	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
 			     0);
 	if (argc > 0)
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 8f59b867f2..4b4e645860 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -121,4 +121,11 @@ test_expect_success 'prune does not crash with -h' '
 	test_grep "[Uu]sage: git prune " usage
 '
 
+test_expect_success 'fmt-merge-msg does not crash with -h' '
+	test_expect_code 129 git fmt-merge-msg -h >usage &&
+	test_grep "[Uu]sage: git fmt-merge-msg " usage &&
+	test_expect_code 129 nongit git fmt-merge-msg -h >usage &&
+	test_grep "[Uu]sage: git fmt-merge-msg " usage
+'
+
 test_done
-- 
2.49.0

