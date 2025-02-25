Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4823A998
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526977; cv=none; b=pfGs8HyjpnNp0v9s+MKrguGKBX2Y/1z6JuvClpM90PsDEF9F3XxH2Gfnf/DwIn0BXq22jWtaIn4lhm3GcOjTms71smKnoBsFGgXEXKuU+gK7oY8Exb3aIajt55joMROAZPrBcx1SZ23VG1PqX1XYKYaFUU7EqmZGjJWIXNh789k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526977; c=relaxed/simple;
	bh=Fe8UlSWWkoonBqR+S/zRRS8hJukSOWHkcwr34p7o3as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvVpLwkXVXc1425Sep61I1NqDVGEd3F0tsK9SCUhDT7r9maeEYCmlDXEKxZb6QO9Snc+RyJjGhXs1w929iqpOZ8ZfYvWppd1INaSzNcvMhowNnEF+ualcpolLqRZHDoeU2kIQ5iFB3cZ24uuk0hD86td6FkkivA2yF1LUndx/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M98PxF1u; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M98PxF1u"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b1a9cbfc8dso1250477fac.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 15:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740526974; x=1741131774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n/Sn2nmoW9FpfuveghA+kkkeOeEao55dwiuqFRSGTs=;
        b=M98PxF1uAaFmPBNAnoqJpRs58nuYjLKIlDBAZVdmlYBebpacle6w+zUKYd0LV08nHH
         Em91Nlu0mtwIIe5253IKtt08rv7AvS/Saj4Dzs/NTtE4bTnQosB5V4yYGXOfWfn+CV3X
         3iZrpiR2hWg/tQksrGMFXMf+ItQXHgJV3tOBGnAa9lWHuNyEybJY9tbLs9wQ72/TSUQO
         ehUNN2tRptLK5UEXp4jZJo9LYxftDlznR+EzbusjCWxIVC5rbQGKD+yXtAQSaYVCmnYp
         NcF2RJMoe0dsZOsxAfiXIwZgeuyYhxggSj1I8+pvugvWhZXBVwiBLEBJRp/K3WTvXb+5
         9fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740526974; x=1741131774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7n/Sn2nmoW9FpfuveghA+kkkeOeEao55dwiuqFRSGTs=;
        b=tagsZyhpaGvGgsgIvH7WXT1Yp2todCiA5u45M0nXqgVdWVp0i/P1sZj7aXoZ+PU07A
         JokrtRIHRCqqF6e5yIhfwW6eyLQw3j02DCllqLsHgul5J5Rnhaf4mem50ESJSsrejhBK
         kqlV0G+1NbqRvZThwwybEqxkP/dXxXzIhH8lzEG6mRtPGfKcCqTgr8CBdFdfQXnL0e/F
         Ou7rFJfTh8uX4fsFtAbsdtwT2NYEfIa5IKfneIB+Uj2wfgT/L2ygaElMj/RRoHu1+zvJ
         VCr1365eCPPxc0czm1cHt4nVHq1u9imnHhaX1pRmryZ2B5J7R+Z9mSvt8UtGhfOXUpDf
         7LvQ==
X-Gm-Message-State: AOJu0YxiOsEe+3MWhFtT+pElHyjzp2i/YaX1lvGBgL2nuTPjMt03PFkg
	HQEYv7ui7FA3sP/8tBvnPyHsjvNRiwDwSNOxNglvCEjhL4KHhHMxUv8bQt7r
X-Gm-Gg: ASbGncsUxGh1QMpyzKB92MPKVwauqMtRBauclNVi541kRre3+IHkkOJNMtQv6dLN4LD
	q3HeGomc96sZEI9PPO+JER+8q8s39qOYQc6f+QqJ3Jk1EzCucn0bArgo2WdIZd7cERo3tvExTNi
	IyBxc1c4bRJPWqmqPJjgDk9hHcp1wFtrJ0tOwjJjjZIRw38EkcQ0LadJxO5MXMP3JNyToojl9se
	XioORdKSvPnM/0NpZngiO3jF4LnUAr1ct593MGZoVYAjFGdD18UR1RB339QirhLIUdynlkm+EdK
	vI5Fz9+LwFp000YQSGmkGMFpBhlP2mwuWA==
X-Google-Smtp-Source: AGHT+IFEEeciHy6IBEw00WkQP4d08pG/mKsxuW/mn0X+ULbTwLOPmcudPtgyUZrh2PHuzKttKjNeNQ==
X-Received: by 2002:a05:6870:3929:b0:296:df26:8a6e with SMTP id 586e51a60fabf-2bd5187a062mr15087798fac.35.1740526974360;
        Tue, 25 Feb 2025 15:42:54 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f5bc5sm609308fac.21.2025.02.25.15.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:42:53 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/3] builtin/diff-pairs: allow explicit diff queue flush
Date: Tue, 25 Feb 2025 17:39:25 -0600
Message-ID: <20250225233925.1345086-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225233925.1345086-1-jltobler@gmail.com>
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
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
 builtin/diff-pairs.c              | 13 +++++++++++++
 t/t4070-diff-pairs.sh             |  9 +++++++++
 3 files changed, 26 insertions(+)

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
index 9472b10461..7130569332 100644
--- a/builtin/diff-pairs.c
+++ b/builtin/diff-pairs.c
@@ -63,6 +63,7 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 
 	repo_init_revisions(repo, &revs, prefix);
 	repo_config(repo, git_diff_basic_config, NULL);
+	revs.diffopt.no_free = 1;
 	revs.disable_stdin = 1;
 	revs.abbrev = 0;
 	revs.diff = 1;
@@ -106,6 +107,17 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 			break;
 
 		p = meta.buf;
+		if (!*p) {
+			flush_diff_queue(&revs.diffopt);
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
@@ -180,6 +192,7 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 		}
 	}
 
+	revs.diffopt.no_free = 0;
 	flush_diff_queue(&revs.diffopt);
 	ret = diff_result_code(&revs);
 
diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
index 2f511cc9c9..3352bfe0b9 100755
--- a/t/t4070-diff-pairs.sh
+++ b/t/t4070-diff-pairs.sh
@@ -71,4 +71,13 @@ test_expect_success 'diff-pairs does not support pathspec arguments' '
 	grep "error: pathspec arguments not supported" err
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

