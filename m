Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA691854
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016474; cv=none; b=eg9j1hSjmfetHj+hrY2STm2ecBtgUwCmUr1nZiuNgQcUPfG5Gmi8nDvOUj8xsf0GYRN/HC5cP+pPBBHCa0Tdt1mrvRylFELrN6ElDRNVuSK0t4N76VOhkyooYwQw7wBlbz7Wfr/ue5WgtVLOqGW3QOotvKAOpjetcpxyyk9gZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016474; c=relaxed/simple;
	bh=lizgcMyO91SF6F3o1ED2dJ/VJWnXKuuI4XV9fHOYEec=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gM5PphAp0oBd5bDvnfLWjlljGMTsvI9bBdg+smSiizpz3fyzjcbyvg2hUXzeihpU0QzoBxdtpBkfFJPYUBEfeGwTHSH/WdTH5z7T+ERqTiDdNOsZMCuhdyOBucTyPt1WGZ6vrf/aVVoziHowIG+zPSPPjmElrZl8oYTex+mFmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8Gu/kuO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8Gu/kuO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42574064b16so35115375e9.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720016471; x=1720621271; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YosOVadv8SNaDP/bRGwBlCciF15U8cDf/FAAhe/nOhE=;
        b=D8Gu/kuOUtULoomV41j02TQTesk/I2Uu1XU+6vsRvmD6UZuz7IfwJEhONYjD1R+K7X
         iECNWRBISQmj2/Lt1TgIf2mDdkSAR1NLMVjsijtFAo8eMOuupEDSDJ6RyLO0l2cPh4iF
         scQ9SNKicJ3XdwMupkag9snAR6gc3MCBy2Moyz7+TsI6OFqvoeAdCl91QC1dHc9DyqZP
         L2bZVOkORgZGlMMp8Rp3SC0YJmDnP14PHHMPmtBeIvtonzsHBbAgwzEHoXQR3CjNw4gf
         O4oPSqXL2fkdO5ixKTiPXIiWioNvzLGhkro5W7qdF2Ldc+24cjDVR7OWfC9SyYr1MBrb
         RtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720016471; x=1720621271;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YosOVadv8SNaDP/bRGwBlCciF15U8cDf/FAAhe/nOhE=;
        b=qzzqlVTvpHtArJ5wAlRtbvRZ+8NzJGbGOaFEj72qEcxet/b0etms9tGLam7i0auEQb
         R3PpTwlMB+HiFUUvpYDLZI6pLYpLxhJ0fN3i0wFu2dkIEBKHBETz0AYHv+XgsrQXCJed
         dN2xVyje1YXrHPkVDUbOTQaMPqre5oDFAOKdQbQUugRfRLRqL+K7FsIHViz2or27I/0h
         N4Mb/w1Wyr6of6Y2x0uaQHLejsDfhS37xmYviXPT2EsYiHtYKomiP0yiMSvL0oJOOIRY
         l1CCvrxklf+EwS/rSci/NMvhZ3vKs6H8c6+lRHwn3+DFsoYnN0C4T9ow8rlTXkxNHYHK
         fEaQ==
X-Gm-Message-State: AOJu0YzVn0YXi6WJLwW7d18bB4QV/kSECd36m4L683K7GYloSLXjhvqM
	eZx0FnzNmmLjlDDLqZ75F+4ptEtw5r32fFhtfCu3b21SGDmzepYSbwlfAQ==
X-Google-Smtp-Source: AGHT+IEVKB3KaMBOF2tdmv74Fy/GzPtcXdW3c037G2esC0omdKhncKo37igy2yVbPyvZnqJbmkcg+w==
X-Received: by 2002:a7b:c84d:0:b0:424:a2be:c161 with SMTP id 5b1f17b1804b1-42588d5c98amr43135665e9.20.1720016470492;
        Wed, 03 Jul 2024 07:21:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cff9sm238685855e9.3.2024.07.03.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:21:10 -0700 (PDT)
Message-Id: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jul 2024 14:21:09 +0000
Subject: [PATCH] merge-file: warn for implicit 'myers' algorithm
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The current default diff algorithm for the merge-file command is
'myers', despite the default for the 'ort' strategy being 'histogram'.
Since 2.44.0 it is possible to specify a different diff algorithm via
the --diff-algorithm option. As a preparation for changing the default
to 'histogram', we warn the user about the different behaviour this
may cause.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    merge-file: warn for implicit 'myers' algorithm

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1741%2Fwetneb%2Fexplicit_diff_algorithm-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1741/wetneb/explicit_diff_algorithm-v1
Pull-Request: https://github.com/git/git/pull/1741

 builtin/merge-file.c  | 8 ++++++++
 t/t6403-merge-file.sh | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 1f987334a31..dce2676415e 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -29,6 +29,8 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int explicit_diff_algorithm = 0;
+
 static int set_diff_algorithm(xpparam_t *xpp,
 			      const char *alg)
 {
@@ -50,6 +52,8 @@ static int diff_algorithm_cb(const struct option *opt,
 		return error(_("option diff-algorithm accepts \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\""));
 
+	explicit_diff_algorithm = 1;
+
 	return 0;
 }
 
@@ -103,6 +107,10 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			return error_errno("failed to redirect stderr to /dev/null");
 	}
 
+	if (!explicit_diff_algorithm) {
+		warning(_("--diff-algorithm not provided, defaulting to \"myers\". This default will change to \"histogram\" in a future version."));
+	}
+
 	if (object_id)
 		setup_git_directory();
 
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index fb872c5a113..9d0045be955 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -540,8 +540,9 @@ test_expect_success 'merging C files with "myers" diff algorithm creates some sp
 	}
 	EOF
 
-	test_must_fail git merge-file -p --diff3 --diff-algorithm myers ours.c base.c theirs.c >myers_output.c &&
-	test_cmp expect.c myers_output.c
+	test_must_fail git merge-file -p --diff3 ours.c base.c theirs.c >myers_output.c 2> err &&
+	test_cmp expect.c myers_output.c &&
+	grep "diff-algorithm not provided" err
 '
 
 test_expect_success 'merging C files with "histogram" diff algorithm avoids some spurious conflicts' '

base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
-- 
gitgitgadget
