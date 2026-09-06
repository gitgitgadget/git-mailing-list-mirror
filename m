Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD17380FEE
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679508; cv=none; b=nKdFsU9g7fbs7G46SqJgwNzqXmX6I9R0dsmN76bGn2z6JN+ZsNrNGnXSxCnF+UT0SPvt9O0iOGERclQ46Lwnya2tQ9UQ/xQFEr11OZiK49Adwe6PcgLisoAgG1SW5bJxlILZgO2YGGqVLucDiKBefgOuEHORtH0qRrYSfXSvOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679508; c=relaxed/simple;
	bh=XX3gWpEmRWLNUqq67kfJd6Sc3ArB4ZHkidZJxqoVyYg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lj5+GsgbkzTT1OzRLjSlJ3B+hTxOASPYPl1SaWNx1QTBfcgmeUY1muIAr8wYtcO1fEm7f+Wjhz/n39wlHpMuOhmdDxN+9rQn0zWljBM5SPU0VwWAUG2qq12CPQb+0YH6v9c0PD7jWaZnwvQxdRV2Y9r788JnqAFZK1dEjabAkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVZB1iWJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVZB1iWJ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso1762948a91.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788679505; x=1789284305; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UJswaK2vh5W6rHtvSPNdqL8cbX1cuhVgDJt+y5Xc9VY=;
        b=CVZB1iWJnxpEbCke6alXW0z960wksbJLx7piHyfqkymzadwsf/mVajXGoHTodBVm1E
         C+P72ze4TePMbzKTVnKVldkV1YSgIX/vt0gMiLsSyE+DOwtS3zB8Ms0lzkHxn0mXL0nj
         aYMLX3bIoV1mJYZ6wh8ae0acXW4rDuh5p9vHZxhgtB66u3saY6pf0yQDkKrkcnuDl6d1
         +5Xv3BiQLHnn7n2/Cet9/zVQdpXsof0sCoPnnLaDaLOr62ecTaObRG+blh+aJr/FDyyY
         3PgQo2KvefXzX43u/0YYA21RGNmkEwan3UT6ln361N/ySr0n7TWAoOs0a9ScZ4/cSEJl
         b49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788679505; x=1789284305;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJswaK2vh5W6rHtvSPNdqL8cbX1cuhVgDJt+y5Xc9VY=;
        b=dzt4YrXHkyuU4T9aBDDXvbzk1DFCXjMzsdvhiQ6Q4zrdI7EqoritbgNNPLLd+OzACl
         oZXqWwforQcivLGoJpZOc5Z4WNpYsMDpW2NBZ9mlNHAff0PMrq6+7O7LlVVXT9UVYSY2
         NhpG4Jz/J3a2IaTS+Vm5DJQv6+Lg3aCOgE0GV2Zr8a+ZjiDvrAJUNzOnnYx5raSUhU+1
         JE8GvoZVef0LQLpGm0zSogdwtJ4JeDv5Or/Fm0hiRb5KsHtJEwUzjxxwKaS44CgkjIkN
         WO81IGD7EcxW8aAwZBS6R+5VFdn8a/cfM4FjG8nzFk5phpOBInC8ICaj/RUXOEOGEP/i
         e8aA==
X-Gm-Message-State: AFuF++kzDdLU/91iI0srsIB8s+0g8h+aMKVXmLU0m7b4bpU8RJHchE19
	Rh2XszEVBfHilZwu8JriBP3LQUOBXGWA7+OuDYnndghdGjaAvgqh9bqpqMtT9Cx3
X-Gm-Gg: AYBFou1TeWZ2ZVR1v4snGyfoMun3ASDFvjum9nGmwshwNsSmEXoX0n6ejT4O06UFY4r
	teInBCOdy6VaUJCLRCAfeXQIgjtCyJ9nKBajMdFF0b7O/jq0nDDucNHTOdGRZfKuISyWuX2Rizq
	oOD/LtIwb5LPh90Dv3o7EGlTJE7KujHP2e9BGroO6ieCDbhnAFcZ3ANAtq7oSZZ31wiaZueAWoj
	ime8D6P18EMr6dDOVltTt7IzZLu57h3i/uSajl1HQDkEIRslnxgesJ8lP9zJN7e7Benq3GHqvlN
	297peZzZUE4MCon+DD+iVFFGSp8BQHUedkf748CGmzAl7ITrgtEubRPv+lr4lst7OnXc8poBFwb
	sQ/vK/J1NnUajpCTjEGy7y46WNDqdhlHU5JxFGPIgswc5pCaWIm0xw0CpO2fMFwYjBHD1jR0XEz
	Ijkb4HLjUVtmGG2sk0htAmjIKH8JzwqMn30zLULvFIME8MFY20fWELRVi/YRMXQA/L
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39b262aaf32mr25813742a91.19.1788679505118;
        Sun, 06 Sep 2026 00:25:05 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.15.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243767e1sm15672705c88.6.2026.09.06.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:25:04 -0700 (PDT)
Message-Id: <74a52a632e81e12a0b3fceebb50756c4fa434bb5.1788679500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
	<pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Sep 2026 07:24:56 +0000
Subject: [PATCH v3 2/6] receive-pack: avoid repeating connectivity errors
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
    Elijah Newren <newren@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

receive-pack first checks all proposed ref tips together. If that bulk
connectivity check fails, it checks each tip separately to identify
which ref updates need "missing necessary objects".

The bulk check already reports rev-list's diagnostic. The per-ref checks
repeat it merely as a side effect of attributing the failure,
potentially once for every broken ref. Silence their stderr while
retaining their exit status and the per-ref rejection.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/receive-pack.c  | 7 +++++++
 t/t5410-receive-pack.sh | 6 ++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e6e54ba55f..8079901bb6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1785,6 +1785,13 @@ static void set_connectivity_errors(struct command *commands,
 			/* to be checked in update_shallow_ref() */
 			continue;
 
+		/*
+		 * The bulk check already reported rev-list's diagnostics;
+		 * this per-ref pass only attributes the failure, so keep it
+		 * quiet rather than repeat those errors for every ref.
+		 */
+		opt.quiet = 1;
+
 		odb_transaction_env(transaction, &env);
 		opt.env = env.v;
 
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index 09d6bfd2a1..20d221044f 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -68,9 +68,11 @@ test_expect_success TEE_DOES_NOT_HANG \
 	# Replay captured git-send-pack(1) output on new empty repository.
 	git init --bare remote.git &&
 	git receive-pack remote.git <out >actual 2>err &&
+	depacketize <actual >actual.raw &&
 
-	test_grep "missing necessary objects" actual &&
-	test_grep "fatal: Failed to traverse parents" err &&
+	test_grep "missing necessary objects" actual.raw &&
+	test_grep "fatal: Failed to traverse parents" actual.raw &&
+	test_must_be_empty err &&
 	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
 '
 
-- 
gitgitgadget

