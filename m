Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5515216A
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428988; cv=none; b=LiAaXHCDBtFbF/Ure1nPlDXM3wQ+abY/KpHI49qGW5SSUdspwaPLComm6MWscxpvsNVy75Erbsgvs6uKi2oDIA9Vv5jMXRR9Y1yTlliit5hqAZOSkpWVqcWgEo/gG9xSnv2CudRkfnVbeHYGjrzm3Qc+4x5wu8CQBs1jaufEZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428988; c=relaxed/simple;
	bh=wo2poDRytb3OM13OBBE/aJUdizbYOsJ0crY1pIH3XTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqQZw1gdBZIy+CkTtgHQNy+vKmQaC1kCvY8D3pOfOgs1wvw4M4KklvGfp/ccun9YSEIpKhnQ3DXOg/7tX00XMJzFWoqoFpCEw4Jh5PaNWF7hMuzCq7dVFEoR/QcM8Lcz41dBfpLdsq0eo0CEczB6p2bY6qdBk01Vpu/JH/+HHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORCVqGfb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORCVqGfb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70685423a06so357172b3a.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719428985; x=1720033785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mq0KG8rGRo6ENZezogz3Z83edtiKMQOy/mHSJtOWfQ=;
        b=ORCVqGfbddLsYlRsYu0QLIT5233r9Z6SNWTpNTqPIFG9ymj9dzwNgqwM1u0d1VIFiT
         OQfAwckKh0ZdqO83x1E3npXex70Die8uK5LzYDxH3jvp1QXDMXrY1uBT22BSrR6h2irl
         +xVweLXhRwHclY73TljQqyjcTmFOPqiCGxEx9ORyxJXdKOMs6nIAsS8AVZGjbwruxiM7
         tl7XqYQL3e3GFx/FV+3CUBo5VoThT+KR/tX9jQq32cL1sXtGNRXk43F3ZAwdNI9GIHJB
         l1e+1SQ/RJM9r2+ZbfqVsO2KFSjQjjMveB4z9vrUkJwitvgZK0ENJNUZnd2Zz1vB4urK
         27DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719428985; x=1720033785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mq0KG8rGRo6ENZezogz3Z83edtiKMQOy/mHSJtOWfQ=;
        b=ROQd/AcRTz0/lZurEqnWSERmYaJsjck+0rvRgEZFtN9Py0ORf1vnU7s1nFQtOYxwEz
         8XDlaJcYQBejKGm38wKZaksN0coLiDJJzqJ7DvBvJ2tT+JRA6PNb5QKodIvIcYVxADNm
         iOgRWHRNPGRq3pBhjX56oVIv6q+eIzudWPvqEUOhEz1QbuejQnjmHF9f95u0IAk/xRBK
         pyPzgTL4kZk6hmpA34QeZpkZrc9y5wfZOlrLqw5YibsrXlL3sqqaT94InSbhvmiXNa+2
         VgFhm+H3HELhzyR/O2d4D0ceyf5b22Rey8L3Grz6LCgIt7wqz3ASDrqJRz7kJRCrFCX1
         GLUA==
X-Gm-Message-State: AOJu0Yw7ag6R6lDFcOfra+FDDh/1zEzooc6IAJDAmQbw/GpNokxScdWj
	tXGImw+XgMHn3dfXdMFex7nl+bJEdKp6/i2U3Rg7N5f+4kvRDzeBi9NELuCl0J0=
X-Google-Smtp-Source: AGHT+IHbttqZlhozKUCUX5FSqGdsEZeocm5sCCTH7kvB5Sqr3A2D9WUtU5LhxF4jpqUiot//rcKbwQ==
X-Received: by 2002:a05:6a00:81c1:b0:706:aadc:b0a7 with SMTP id d2e1a72fcca58-706aadcbc2amr2172490b3a.1.1719428985472;
        Wed, 26 Jun 2024 12:09:45 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([2409:40c2:205a:5198:c04f:bc01:50f8:f177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-71cb3a3654asm5957558a12.58.2024.06.26.12.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:09:45 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Paul Millar <paul.millar@desy.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v7] describe: refresh the index when 'broken' flag is used
Date: Thu, 27 Jun 2024 00:38:00 +0530
Message-ID: <20240626190801.68472-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.606.g9005149a4a.dirty
In-Reply-To: <xmqqpls3zhc2.fsf@gitster.g>
References: <xmqqpls3zhc2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When describe is run with 'dirty' flag, we refresh the index
to make sure it is in sync with the filesystem before
determining if the working tree is dirty.  However, this is
not done for the codepath where the 'broken' flag is used.

This causes `git describe --broken --dirty` to false
positively report the worktree being dirty if a file has
different stat info than what is recorded in the index.
Running `git update-index -q --refresh` to refresh the index
before running diff-index fixes the problem.

Also add tests to deliberately update stat info of a
file before running describe to verify it behaves correctly.

Reported-by: Paul Millar <paul.millar@desy.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/describe.c  | 12 ++++++++++++
 t/t6120-describe.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2..cf8edc4222 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "HEAD", "--", NULL
 };
 
+static const char *update_index_args[] = {
+	"update-index", "--unmerged", "-q", "--refresh", NULL
+};
+
 struct commit_name {
 	struct hashmap_entry entry;
 	struct object_id peeled;
@@ -645,6 +649,14 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
+
+			strvec_pushv(&cp.args, update_index_args);
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.no_stdout = 1;
+			run_command(&cp);
+
+			child_process_init(&cp);
 			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e78315d23d..79e0f19deb 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -671,4 +671,40 @@ test_expect_success 'setup misleading taggerdates' '
 
 check_describe newer-tag-older-commit~1 --contains unique-file~2
 
+test_expect_success 'describe --dirty with a file with changed stat' '
+	test_when_finished "rm -fr stat-dirty" &&
+	git init stat-dirty &&
+	(
+		cd stat-dirty &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		git tag A -a -m A &&
+		echo "A" >expect &&
+
+		test-tool chmtime -10 file &&
+		git describe --dirty >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'describe --broken --dirty with a file with changed stat' '
+	test_when_finished "rm -fr stat-dirty" &&
+	git init stat-dirty &&
+	(
+		cd stat-dirty &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		git tag A -a -m A &&
+		echo "A" >expect &&
+
+		test-tool chmtime -10 file &&
+		git describe --dirty --broken >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.45.2.606.g9005149a4a.dirty

