Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40201D14FF
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778652; cv=none; b=omERAV560+8N7fkpbwhboFz9twpVgv+gascHYqonQo34/YnbcLHQbI3D+S5WVzi06a/OiCrzIxIo5Er89FeQInMPeWpCEvjM1gS4GupJlrUW3DEB6v/vHrQZFRiY3seO+75x5B86ksaJTb3fMM0hSdVrhyJktuteE3Fu2U5xJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778652; c=relaxed/simple;
	bh=CxSqSnTuRV+NRqb67Ff7ZtPRfzZcGCou79EaOQeCgFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0b1qr3nAW5RPn0kInucl+3YNrLktpesHKsvjoe2PAJhNwfk3vwfF0fSOwqgOgWdOKq3LoI+B7kRDULcTNIL9sGzS9hgowZQ7rQPPAjObZVbNPJ+kB6npbJxbq9vwQ6v9svgdOc7RLD/Uo9JmNGccqBp6gsdAZhic4IlqQEIxLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJqFSLIl; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJqFSLIl"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72720572addso1755277a34.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740778650; x=1741383450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9Z9eagWQLRK5m8mqmChH09cUODz8AToYNzmWMBTQvM=;
        b=TJqFSLIlI2z/O1wdQ1ROUsFyNV7t7u0JxYiA4N9hU1KzqdLZPATDsru6qTTbaurtYg
         D2Ya9kQNd3dHn15O13wHRBJc2FK8795+HDMRI00dgdy9XtAK0PuJTyosmKg+UiRJ8ZCJ
         TNycJjO8BXtFlSHuEZV1D0EL6PeJDRAyVmr8goETaQncR7dtTUGP6qvF1TM+ZKHHe1oP
         pBxMZA2YS4AwUduSk61FEi8C9jLXuwoULTJi/ck9n4JECS8sLibv0EskzJ/4WxbMpQXK
         9mR6f1mkcp1J/+JHreFZiQHaHP50axRDgMkEau2My8qIsMpiXS0VYxgJQfeS1lPsNYmh
         Hbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740778650; x=1741383450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9Z9eagWQLRK5m8mqmChH09cUODz8AToYNzmWMBTQvM=;
        b=l1ZDHXrV+dVkd3XNGl2M5/HlsRChZyuQtddocDZheCX1SCEw+a0z04ETYsz+B3U3g0
         SRsw3AAyV1v3tNGauxEiwCQFs5GymuyGJPdazpqaox76r7kg9/Sgkx41q4clww1LtAVf
         DXWJHvvZU9IEcMj4t//G0uN/ymMsO7EcXVIBt3PfgcgD/cXvlilZ38ZsAumCbr0N1C5W
         ISHkFkPPjV6Fs9WnTmWv2PKG7T0USRwUxAUcv1F7ZLmMHK+C0ISmANq9kQu2572HSw+C
         H7uPePAhShx3gpuUM6cDdb/4kzfNMURZz/IfXWDkksf0C9grNxuVMF8b+deGGj5OfKe4
         Ro+w==
X-Gm-Message-State: AOJu0Yw+MB2FxFOIEOnVFj4/6lWeA8PlSmqvM/OsnFAwtDKZivjTQ0kz
	KUrMDwI4cRTtaSGP4lTCQ36bIBZXu9/9bGw4ak/lP0ld37/4WG534EIv8kBh
X-Gm-Gg: ASbGncsfA3BQaO+f5fb4oeQ1xDp5LBuIJeSl079T1/3wW4Bx8uPPZmlh6DJVGGQwuxA
	cwtM2+AI9IENr3GSzIAjiX1ff5Fj0XlI3fbL3T8JnIjZ1YtGy/rCQhLGzYf6ouC5HrBisuA5XJn
	AWoVJEKDL/mUuXRdnsFSXrO6x2QREx9nDbvq4hH9HTBS7TxOR89wXzsSU0fDXmhsd580kA0zVzI
	YuS1PNuOeudiBzgItyDsUCKEQdEDqz6FPMB+j+UbwH+YVv9i6fqmF3VlUMbM+JgU+kX/N8+MoNg
	XjryQmkY4+ZAGI/FXbSXW1oyddTxK92fzKIe8ty91UALyB027ZmQ
X-Google-Smtp-Source: AGHT+IGYZwEQFVckBAOEhMqeJ34F6mwbiikyNUfQ8XAEjvGDwl8IrHc9dd7YZKBqpQunoseD3/zaWA==
X-Received: by 2002:a05:6830:710f:b0:71e:4fc:6ef6 with SMTP id 46e09a7af769-728b828625amr3260655a34.12.1740778649658;
        Fri, 28 Feb 2025 13:37:29 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaad46205sm783589eaf.36.2025.02.28.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:37:29 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 4/4] builtin/diff-pairs: allow explicit diff queue flush
Date: Fri, 28 Feb 2025 15:33:46 -0600
Message-ID: <20250228213346.1335224-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228213346.1335224-1-jltobler@gmail.com>
References: <20250228002604.3859939-1-jltobler@gmail.com>
 <20250228213346.1335224-1-jltobler@gmail.com>
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
index 6be17c1abd..71c045331a 100644
--- a/builtin/diff-pairs.c
+++ b/builtin/diff-pairs.c
@@ -57,6 +57,7 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 	show_usage_with_options_if_asked(argc, argv, builtin_diff_pairs_usage, parseopts);
 
 	repo_config(repo, git_diff_basic_config, NULL);
+	revs.diffopt.no_free = 1;
 	revs.disable_stdin = 1;
 	revs.abbrev = 0;
 	revs.diff = 1;
@@ -106,6 +107,18 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
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
@@ -179,6 +192,7 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 		}
 	}
 
+	revs.diffopt.no_free = 0;
 	diffcore_std(&revs.diffopt);
 	diff_flush(&revs.diffopt);
 	ret = diff_result_code(&revs);
diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
index 0878ad0ad1..70deafb860 100755
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
2.49.0.rc0

