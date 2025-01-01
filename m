Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7797929415
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735699995; cv=none; b=EZikRl26kryfXnaNpqPk2CBk64lXyh4RDg5o14R6A9Jc8XILbavJp6IhoG0Un+OI9FZG5pQ4Y1hikVJd/KoEjQiLk83n8kl0I3ixkVfJxkBTPyix2TuUathjD2C+Pnrx7KjdNIhSTuOHFS7jdcTuHtmiKuwKqLtFGPqsR0ZljBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735699995; c=relaxed/simple;
	bh=+KI3wAUF+WAzaRYrQFxZzH9epnu76xhqYHI7uIAeJN4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dxFRwxEYe+alnpVydVPIe8PD4tCuMKu1I3CtGYE9NJzLJ1d8Sc+bI4VEVjB0V84eFpDEfcJ2o+kNz5Z2pokpz5tLXGhrxyUMiI3XYhb+lb1mYokNY/gPLM4F4zHXpjizdJ8a6AF7nsJcprpTvTpzqFQyLhjDWt6HCbkl+7Yfh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRoeNHJF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRoeNHJF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436345cc17bso76084185e9.0
        for <git@vger.kernel.org>; Tue, 31 Dec 2024 18:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735699991; x=1736304791; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qaE0By1+hRW3bOnDyerbKUkEUQz2aRzZRJDLkldLjRE=;
        b=IRoeNHJF8KAqcI1eB6EbsPwX/JHRgHOA/izVaaQ6untS7BxjbBGaWfHnEvp4Os/rl0
         jzosd9Vquz3KTzj3dxpxaaJYVxy/3Qihhv2Tc6Y2/+xeLxozDvTgCf/iatccIeA0tHYy
         quPzfmJu3ucKSOyr2pyAyKHJufWKmrz42DCuh2er85jBjCVKSebZ6Z0GTI4XHLYhX9EL
         ZHpnUIlctkVeY4z8HetfDaU4e8qj6qmfNoRv2ltqKU8gGn/mrNZ25qPsoVxhW6R5qGAv
         z6rLWSOCReuEeXsmmFMBKY9Bq38qp7Quk1eESVyV335w2I56zpwx8CCkSovKrQYT6spq
         LAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735699991; x=1736304791;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaE0By1+hRW3bOnDyerbKUkEUQz2aRzZRJDLkldLjRE=;
        b=LPaq3P3stYZgNv0OE3ATv7PrmYvv09fkjF84cCTCgwNXG/e1WzgjHVQD4r7YjP0VIn
         GsLTCBEQBhTHmyXWIBaWBanwpGFobAhODYoI58BkaIqf/ndoq29ae0ZadjHC7lsl0n1F
         5whi4BngOxPViOYKYDMwskQ3QcKhB/vBrbKtkuP5bkEnYU+VYu3ZhxLpWj2s/XdxFr99
         Pqba98VJKC94VxW60yZpLq9GYYB35vMm5+PvPRzr4jSi1KEXs9Zl0OGx9yeuME8aXh5p
         xkxeT1wlX0BOVa6cRoFib/effJNTWzpnJOdNHUZFzhERWAChPP2NSsReAQGMVCWXZmEz
         SZiQ==
X-Gm-Message-State: AOJu0YwYaZbOxxPaDAHa/HuQc75s+6FhwSaY/HQo0Lmz61QMecjWA+hq
	M7E8TqkA96FJg48S/+o+eALxgtWScSYAIhOVSWGaYPh98KsWzlIPUrDYWA==
X-Gm-Gg: ASbGncs0YvoQT7bc6t9mhQVIYvGHYHsFSpJc2/1ANO+I3FRkpGn/zH8+H3vRCBoJAVo
	LehqUeOhKSTySqWa12gIXwlqdhGRZ6k9Gq1BKx6enDzM6axcXclSH3krx8Ae8uRiJmnSNUFe1E4
	LQJcfV1mHeCHbLKodrRv5iIL9q2vrXpin0p70ByfR806X44vkGdZ30E+x2k2uOraUbyXVoLRGLB
	gG0rx9hO6ExI2cmiKff5nbRJrIs4gJUH/BC0URuznK5Q8Ht+z37XqvKlQ==
X-Google-Smtp-Source: AGHT+IF0hUUL6mTReZ+5k48kJQPJ+uc5kaOq6vi1k2BhPmTbnjQSMUJ2f0OHi7c2rsyysfAP0U/Uzg==
X-Received: by 2002:a5d:6c6d:0:b0:385:fc70:832 with SMTP id ffacd0b85a97d-38a221f9e10mr32955053f8f.16.1735699990779;
        Tue, 31 Dec 2024 18:53:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661289d3dsm410624185e9.41.2024.12.31.18.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 18:53:10 -0800 (PST)
Message-Id: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jan 2025 02:53:09 +0000
Subject: [PATCH] object-name: fix resolution of object names containing curly
 braces
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

Given a branch name of 'foo{bar', commands like

    git cat-file -p foo{bar:README.md

should succeed (assuming that branch had a README.md file, of course).
However, the change in cce91a2caef9 (Change 'master@noon' syntax to
'master@{noon}'., 2006-05-19) presumed that curly braces would always
come after an '@' and be paired, causing 'foo{bar:README.md' to
entirely miss the ':' and assume there's no object being referenced.
In short, git would report:

    fatal: Not a valid object name foo{bar:README.md

Change the parsing to only make the assumption of paired curly braces
immediately after a '@' character appears.

Add tests for both this and 'foo@@{...}' cases, which an initial version
of this patch broke.

Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
Helped-by: Michael Haggerty <mhagger@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    object-name: fix resolution of object names containing curly braces
    
    Maintainer note: this bug dates back to 2006; it is not a regression in
    this cycle.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1844%2Fnewren%2Fobject-name-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1844/newren/object-name-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1844

 object-name.c       |  8 +++++---
 t/t1006-cat-file.sh | 17 +++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index c892fbe80aa..e92f26b3256 100644
--- a/object-name.c
+++ b/object-name.c
@@ -2087,12 +2087,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
-		if (*cp == '{')
+		if (*cp == '@' && *(cp+1) == '{') {
+			cp++;
 			bracket_depth++;
-		else if (bracket_depth && *cp == '}')
+		} else if (bracket_depth && *cp == '}') {
 			bracket_depth--;
-		else if (!bracket_depth && *cp == ':')
+		} else if (!bracket_depth && *cp == ':') {
 			break;
+		}
 	}
 	if (*cp == ':') {
 		struct object_id tree_oid;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d36cd7c0863..252485dac78 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -603,6 +603,23 @@ test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
 	test_cmp expect actual
 '
 
+test_expect_success FUNNYNAMES 'setup with curly braches in input' '
+	git branch "foo{bar" &&
+	git branch "foo@"
+'
+
+test_expect_success FUNNYNAMES 'object reference with curly brace' '
+	git cat-file -p "foo{bar:hello" >actual &&
+	git cat-file -p HEAD:hello >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES 'object reference with at-sign' '
+	git cat-file -p "foo@@{0}:hello" >actual &&
+	git cat-file -p HEAD:hello >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup blobs which are likely to delta' '
 	test-tool genrandom foo 10240 >foo &&
 	{ cat foo && echo plus; } >foo-plus &&

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
-- 
gitgitgadget
