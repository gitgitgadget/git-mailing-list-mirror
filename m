Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071821D3C0
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362528; cv=none; b=i/O13wGFri1RjhN+eI8weysqnBsxTOLJK0H9QedpfIHJ0xBz29qnnePt28ZVQjMzsblNuJRfefshG2j/WQhDXA2l0Qfynpb8Cj7ttz/9UCF09jOs0s4XJzmPqQ+5KB317uZZFdiKbUxKBf7CP8Qafsoz6x0+cYjAGRoK52ZAl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362528; c=relaxed/simple;
	bh=GFWZYukIn0pMpi5KDSjOlqRzKB0TLFU4e+8Y5Ft/XSU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lp1tUgE/cCQqnsG9PMPh3DpZdyc/gZtKNkdiVPouE/Y+vwr+dSL+xvvmovSs746IDq7PfGUBYo5Rg0+kxP9Yvcmr0FIIQ7+NHvauYDSN9U2VpZlPF9aop3g4UsgPivCfhF6yikU1V41Vms0jm/lgfq/jdx6lruqINCfqtw59WZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfXVcd48; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfXVcd48"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so1773203a12.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362525; x=1741967325; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voKFxUz5P+yaeVEDGiKP2GDyoLaxJ3SYb2i0Obutydc=;
        b=jfXVcd48oj2kwcJMW6Xx0OMguWziaXDByIm0/tlpoq4fc+5PMbq74YFKTt2qNqPu84
         a0WBfC4pEd6NEdBOKXtvBnhstl4yTRolrdaaHAxsKvt8lGSUsRi71dHNwTBPMi4N3nfd
         3xb4cBOoiZcXP3mOzRn2bwyKkTmrOynLD84TrGJhxLYiit8zqzD9jefm/mFkskBKF9zO
         veq8PWcyLb5ubwe3xa3DvwzCWGsdtUzOLLZrm4sbX9RKYORk8ZoBN5ScvfUTi9122lE+
         qK7Wx+PQwvu1Uao0CoK2Ek+NghxqcZ87bF/XYvj7ZzsxFnT/0tw+g1dc3+RYu9kSbqgI
         VDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362525; x=1741967325;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voKFxUz5P+yaeVEDGiKP2GDyoLaxJ3SYb2i0Obutydc=;
        b=I0GKQavxfJitjMA7f6tQO4uATo8tKNqEUXQozWwr4hcLluN5jHCtX2n4fpQAHVbGrI
         /G3yZnFmfXXGHdK/fLNA1EG04IKbI8P7rmvCOe5rLwYifEqZPcu1z/Qiwp5r9FqyPfFD
         Jimxq8S3tfoibVAVDaue+Yx6cTYtbee5eAwhosKKn+A/QmLlbZFKWVsORu/rgds8bKY/
         7RyVtJq5wApAc6dOhKY3/DAsOMx8C/57rz7hUxilZQ6aCP5XsyihxkK6EjSKNr26Vr7G
         U8bBMHimNkekSyqyI4EQ2ciu0WoSajv1cddyMGKJCahkakOjUS912glO8N8mOWzJt4Wz
         3CdQ==
X-Gm-Message-State: AOJu0Yzp+xnq8dfKU6tCSjRKwlJzzq2yQTyMO8+GoYbHal24PQjDl7j/
	jdu04nGHk7i1kuEovoteTDH5sDe+dQvNbvJseQlkN6seM2osL89iO/yzVg==
X-Gm-Gg: ASbGncuHJcldfJWNbTGEsw+Mz6g3QmGy/5eQ+/TwpwgHgGrqkGlJzneElKyBYRyyr76
	Xzm7TlUmyfsVfFNXiCY5FMggyO0C926zrDKJOZemsQkEa50V/hc2IGmvVPZjSsvFkS53SjqKCKr
	tCcCsDip/bVtQcUsHsgY6o3HlbRUTqjEo0QFOX1uZCmDhM6a/Z4/Tdd5dOjwZqThMtZgtcTPKHE
	Ua4/PEUEkUTY619dxCvbqaoy9SpvZf8SV+RyB0UVC7ueVrFXMkYv9Djw+I6CZSx4EJOUZtR2kD6
	ZC6Mqoz1+C25yPycs7RVF9/KjHkuBD2KcKiU1PizXsE5YA==
X-Google-Smtp-Source: AGHT+IEUewbHw7wRbd0aIhDDB4uNm9WFziZlRCt2H7ZilubrS3GLK0dAZMLgC7QDuoguzcY2CisM/A==
X-Received: by 2002:a17:906:dc8b:b0:ab7:6fa9:b0a9 with SMTP id a640c23a62f3a-ac2525e0417mr431979766b.11.1741362524684;
        Fri, 07 Mar 2025 07:48:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23948432dsm290080166b.44.2025.03.07.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:48:44 -0800 (PST)
Message-Id: <4292b22723f759c3e0f84ac1000992187a9c7f7c.1741362522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Mar 2025 15:48:41 +0000
Subject: [PATCH 2/3] merge-ort: allow rename detection to be disabled
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When merge-ort was written, I did not at first allow rename detection to
be disabled, because I suspected that most folks disabling rename
detection were doing so solely for performance reasons.  Since I put a
lot of working into providing dramatic speedups for rename detection
performance as used by the merge machinery, I wanted to know if there
were still real world repositories where rename detection was
problematic from a performance perspective.  We have had years now to
collect such information, and while we never received one, waiting
longer with the option disabled seems unlikely to help surface such
issues at this point.  Also, there has been at least one request to
allow rename detection to be disabled for behavioral rather than
performance reasons, so let's start heeding the config and command line
settings.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.adoc | 12 ++++++------
 merge-ort.c                         |  5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
index 93822ebc4e8..59f5ae36ccb 100644
--- a/Documentation/merge-strategies.adoc
+++ b/Documentation/merge-strategies.adoc
@@ -82,6 +82,11 @@ find-renames[=<n>];;
 rename-threshold=<n>;;
 	Deprecated synonym for `find-renames=<n>`.
 
+no-renames;;
+	Turn off rename detection. This overrides the `merge.renames`
+	configuration variable.
+	See also linkgit:git-diff[1] `--no-renames`.
+
 subtree[=<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
@@ -107,7 +112,7 @@ For a path that is a submodule, the same caution as 'ort' applies to this
 strategy.
 +
 The 'recursive' strategy takes the same options as 'ort'.  However,
-there are three additional options that 'ort' ignores (not documented
+there are two additional options that 'ort' ignores (not documented
 above) that are potentially useful with the 'recursive' strategy:
 
 patience;;
@@ -121,11 +126,6 @@ diff-algorithm=[patience|minimal|histogram|myers];;
 	specifically uses `diff-algorithm=histogram`, while `recursive`
 	defaults to the `diff.algorithm` config setting.
 
-no-renames;;
-	Turn off rename detection. This overrides the `merge.renames`
-	configuration variable.
-	See also linkgit:git-diff[1] `--no-renames`.
-
 resolve::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using a 3-way merge
diff --git a/merge-ort.c b/merge-ort.c
index b4ff24403a1..a6960b6a1b4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3448,6 +3448,11 @@ static int detect_and_process_renames(struct merge_options *opt)
 
 	if (!possible_renames(renames))
 		goto cleanup;
+	if (opt->detect_renames == 0) {
+		renames->redo_after_renames = 0;
+		renames->cached_pairs_valid_side = 0;
+		goto cleanup;
+	}
 
 	trace2_region_enter("merge", "regular renames", opt->repo);
 	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
-- 
gitgitgadget

