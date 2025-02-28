Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC581C28E
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702574; cv=none; b=VyIVIBj2xQ7F3qJsg85SEG2Zowq0TLoXlvDqgbdpMVeywmvCkbqFj+DFzzONzOTXBNoIjt/9p1RJhF7bXFH7mzbmV0Cek/3qivioGgWhItPMAkK5s3oJqQWqa3D8SevRTCerMtv5HfQ2ecUZTO7Cq5tSer/nQ6KV9OBbxG0VXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702574; c=relaxed/simple;
	bh=KEZV1icyrmHYj4EV1oi0M7cx1QcoY59oT7aPcmcCbuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osK5Wk8FM5i7gPVqvl6EhvnOA05kqOPTJ0cX2BCMAI4IMg0qMVfNmfSJg4FoMW3TXhKrWWcnggIXqGutkJNrJfkjfIpu50d39mrnu9Jv9Pf9UhSAvJnnsQ9U7tU/pT8d+YSzx5IK65kNBA2dc5AGPqyMGbG2aqoFyxNVFmrqxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDVsTnSE; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDVsTnSE"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f40ad1574fso1110728b6e.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740702570; x=1741307370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lto5EhTwM8PkUAcfRGno8jETCVoQ4AsaBwSJVDV5jKE=;
        b=KDVsTnSEruniyN/Rp12NfXyEuqlKoglnTtI0L7cuMzZglwyaIlujifolf5DbSa7tJR
         qq9tu6s8Ya6YhMN46DIghcpwE6Bxe+RXuAwDB4RMkJzRuNzCFHTVjMI+GaI57yWOZIgP
         khDKCymi1pEOYAF+wU8n84C3qos2+ZSspzHRDp8U1n3Iya0XcEQjgcVwYa2cGm5WD7XZ
         wUkepdaYqlbePNZ3RswOmO1m/Nz57ewWlNFRUl4k8olFXizP6xjSROaQxW1K+qZqRopd
         OhYIummbFUzv2wP/EpFEg8mVjt8WIO5QLBDXyaXAKwYuJb3nJ1lRjvak9P4jShgJL/82
         qVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702570; x=1741307370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lto5EhTwM8PkUAcfRGno8jETCVoQ4AsaBwSJVDV5jKE=;
        b=OiTBCN5eIrItSMBTBGSlrvm6Wa8WofrfIzQXN+bupwIGY+UgfWB22orIJynrgBFmlO
         AkOHL3bzK8L2llloKLvX7p7h0B9Lb0B3ZPss16vVFZThkxaTAary/IK1ob9ONC0Xl9dp
         dHnjPb32oTIpXYCj1mERbcsmfda1DGKxGMWgAVijG4RmbmVdkwP3K1H+NtVcd8H3SX9N
         Uezu5SbdM5NWj2fLzDXMCsEjeIf7ussgHXEurjfPZg5Kpm2qUcoHWThSRHpzncOpnAy1
         g+glrMcSMGcJgd//XjERlMRG43sV3FXjVutbjsa2OjFOnO//UE+19egyuc9IQzGnwfkL
         oBWw==
X-Gm-Message-State: AOJu0Yy+T+MvqjhMDDtnb3mWFRuiikVZi/KZt1Wk2SnYQyO/JzRsmDTg
	9w3p1CTG8gxWuU0gQUh3ny+WPyWJoyX1koeIrx/g68NQ/mEi4F5SUou6+X7t
X-Gm-Gg: ASbGnctzkHRTl6yaSJWx+4flRGQpJUljo2aJX55s/EKIHpssZoufpLIhl3QG04j9dCz
	7UiWWkp/wIEpUNhTQ0u8ofNLd5nhM4ghGgSTki4O3N1N84Y0lXRM4VtF+DN1OuX8mRL0g/Vr1vg
	Kmxd1hYlC2/Q2mcF/rPX2S85q6KmWZGugyGHBOEKWepHlT1RicgcxlUl7jgAA7HNj3+D3LvbZ9t
	p9rYIR4ktIEWBk2xnZM1YAWFmUDts4CexGH22DU6wBQJqNRLLgn0RaBQHxtir/d03ijZKVvRgr1
	IrxPXEF5A88d+lWOp3e1lqwMqmMOMNb2RA==
X-Google-Smtp-Source: AGHT+IH9bnXG/ad6+tZ1akIwVb9EXpl2vsRRlBF23BiJkQGRRpLnBOmtzU2icNggnyBqRcBv3qfeGQ==
X-Received: by 2002:a05:6808:640f:b0:3f3:dd2f:6a9b with SMTP id 5614622812f47-3f5585f4d02mr775122b6e.30.1740702570382;
        Thu, 27 Feb 2025 16:29:30 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaab9c8f9sm456509eaf.19.2025.02.27.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:29:29 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 4/4] builtin/diff-pairs: allow explicit diff queue flush
Date: Thu, 27 Feb 2025 18:26:04 -0600
Message-ID: <20250228002604.3859939-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228002604.3859939-1-jltobler@gmail.com>
References: <20250225233925.1345086-1-jltobler@gmail.com>
 <20250228002604.3859939-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The diffs queued from git-diff-pairs(1) are flushed when stdin is
closed. To enable greater flexibility, allow control over when the diff
queue is flushed by writing a single NUL byte on stdin between input
file pairs. Diff output between flushes is separated by a single NUL
byte.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-diff-pairs.adoc |  4 ++++
 builtin/diff-pairs.c              | 14 ++++++++++++++
 t/t4070-diff-pairs.sh             |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/git-diff-pairs.adoc b/Documentation/git-diff-pairs.adoc
index e31f2e2fbb..f99fcd1ead 100644
--- a/Documentation/git-diff-pairs.adoc
+++ b/Documentation/git-diff-pairs.adoc
@@ -17,6 +17,10 @@ in the NUL-terminated raw output format as generated by commands such as `git
 diff-tree -z -r --raw`. By default, the outputted diffs are computed and shown
 in the patch format when stdin closes.
 
+A single NUL byte may be written to stdin between raw input lines to compute
+file pair diffs up to that point instead of waiting for stdin to close. A NUL
+byte is also written to the output to delimit between these batches of diffs.
+
 Usage of this command enables the traditional diff pipeline to be broken up
 into separate stages where `diff-pairs` acts as the output phase. Other
 commands, such as `diff-tree`, may serve as a frontend to compute the raw
diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
index 5a993b7c9d..2939d4af1d 100644
--- a/builtin/diff-pairs.c
+++ b/builtin/diff-pairs.c
@@ -57,6 +57,7 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 	show_usage_with_options_if_asked(argc, argv, usagestr, parseopts);
 
 	repo_config(repo, git_diff_basic_config, NULL);
+	revs.diffopt.no_free = 1;
 	revs.disable_stdin = 1;
 	revs.abbrev = 0;
 	revs.diff = 1;
@@ -108,6 +109,18 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 			break;
 
 		p = meta.buf;
+		if (!*p) {
+			diffcore_std(&revs.diffopt);
+			diff_flush(&revs.diffopt);
+			/*
+			 * When the diff queue is explicitly flushed, append a
+			 * NUL byte to separate batches of diffs.
+			 */
+			fputc('\0', revs.diffopt.file);
+			fflush(revs.diffopt.file);
+			continue;
+		}
+
 		if (*p != ':')
 			die(_("invalid raw diff input"));
 		p++;
@@ -181,6 +194,7 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 		}
 	}
 
+	revs.diffopt.no_free = 0;
 	diffcore_std(&revs.diffopt);
 	diff_flush(&revs.diffopt);
 	ret = diff_result_code(&revs);
diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
index 8f17e55c7d..c5e9972b2d 100755
--- a/t/t4070-diff-pairs.sh
+++ b/t/t4070-diff-pairs.sh
@@ -78,4 +78,13 @@ test_expect_success 'diff-pairs does not support pathspec arguments' '
 	test_cmp expect err
 '
 
+test_expect_success 'diff-pairs explicit queue flush' '
+	git diff-tree -r -M -C -C -z base new >expect &&
+	printf "\0" >>expect &&
+	git diff-tree -r -M -C -C -z base new >>expect &&
+
+	git diff-pairs --raw -z <expect >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.48.1

