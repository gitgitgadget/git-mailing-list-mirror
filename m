Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012233DEFF3
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013440; cv=none; b=tQgng7CPzfCyku0qYfDCYA1Z0fHxqNO7kxUZ4kIcV7h0fSqbfOy5/M60aJmBbmJus9w+zFKXuCkm572WJPeRRVjC1Gowf7J9Fg5G1hhUiaq1pzOpPMROqXym5N24iN/LYqf5wLXy4u7b06aOMZnmyGrVCkZJwFCqauTV6mB+QSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013440; c=relaxed/simple;
	bh=lq58gOSiBNZ6RBj+QVSE8ZG4/ffMfAudM8yRCHeHuFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o72rUoO4w72+ene+hCDCodHGdHS+fzkUN11k4XhTzGcsDXvB6iUGfQf7rEvs44ih1GAnsFgYyd/qJiDX58ik3n5UKP6Ur06tqEKJfKfjOkw720ESj7WCZzDucrJglghGHWdKBabJSsh1FkmAnSpA78EPvazKfHjAsQDuI+n5Yag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6hSWalD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6hSWalD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so602062a91.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784013438; x=1784618238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3pISDEew1EQhBb7L9Ud1J6yQ6j23VMjHYkme6H5rqo=;
        b=Y6hSWalDXvlWx/RyCmlt7IHZRJgVUG6D8koIJbg593UvfBNEzuxFzXzp3v9b6BR605
         Ma44Pt0Da20RC9gLH/QHX2RS7Ih97ydK9EMAccpUztBbbRRp8XZAGO1vUKWG6id4mby4
         E/tVSxyl9sjgCZqWRNY3fzx2Z05mWF/d4EdnbCDrtA5XFj+5e4x86XBD/jIKah3+8dPq
         j0uaJXXTn6G1bztGWpWL195ivvbkf8Shr3QIEXBaG6t/znBjDyBRno+a0bIHBvH9G3hY
         03BeZQgNpG7o48vYw2ROaEQtUPyaWpJfDtzGXg4HRYTYVNOtQPOnMd9PfuD2iwLKdusZ
         Q4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013438; x=1784618238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3pISDEew1EQhBb7L9Ud1J6yQ6j23VMjHYkme6H5rqo=;
        b=k9zyUDCOYGpiNYRllpuOinwkNxCQfw83ZlDoE0oa0+ll+RRPEdKpQhhnB5dLn1snzf
         TMuvVQvoWSqyIbGkhkqDZtjp9Knt5I9UzwV5rIbW2w8BiFkyZrJ4vNOYZBUMin+4Ty4e
         6NnW0NHs039zmXQ7NUO8Nw81KrJmeZdxzquqVpIYYb4FwqmtSzXh3leb2/c6dAGOUfPc
         PiFmjO9h4cjq/+nSn4ct7bW6ZFKq/OwG+KBMrdXQYexkAblcxAnxRinx7S1ypPUzQrr6
         8vY79zWaQ+y+dsgU/DrFfv4/uDAIzqEvlcZmvFdDrD63Z2MUGXRUAZ5XYXTQ5oKlgN+S
         snVg==
X-Gm-Message-State: AOJu0YxGy8ibBgKyiTvfducdS2SA6RxVqhJGJtzKA3LvKeoyxsKVhWE0
	ifbM9fkrujf9+CWvEao3CUGQlEihR7XOjfZ8ErOEedqNs4k6sTMHXBv9yjGQqEZ3
X-Gm-Gg: AfdE7ck2Qrhh8/Pqp9L9ODRz2hwHiR93pTmikVSYJwyp5dFnrzNkgt6ERzowyYWEr0m
	kt3z9PXcIERun3evHQgBQAIEPiU5oLxgipTug1LqlTTFy4+nAFzE9N3rz/Rb5e2EdQqugH6fGtk
	ZqA1SemYx7vPUH9x4IJ8/+29DzKK5LvWUfY+oXn4ZjEAecYvod0H63SJl7YDuJsyfzG73w6KbHX
	dyIeZ3EFWdwBj60KNKSJLeQWEYlOiKV+i/iPoKctwfyejN6lkJnLWTk5sKTl6XNIF3HwuQbxXQc
	QFJDBgJrML+MG5/DN8Z0IDu49GRLRo0TCsOmQJ8AX3/M78DJfkhwnwyF5khZN54Q9UU9dx+382p
	MaWnVKWuFahkQKwZdPYgUq7wXc/vYnPsn6K8kgg0TSeqafIfQSZoAkZCCk93Bl9AUErUtvwZkvq
	4sxj3xfX0IQqmzBFpIQYp087zKrcdsApuhzbteXg==
X-Received: by 2002:a17:90b:35d1:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-38e05c64fafmr5000271a91.11.1784013438408;
        Tue, 14 Jul 2026 00:17:18 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm83465759eec.19.2026.07.14.00.17.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 00:17:18 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v2 1/2] t1100: modernize test style
Date: Tue, 14 Jul 2026 12:46:32 +0530
Message-ID: <20260714071633.35446-2-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714071633.35446-1-diy2903@gmail.com>
References: <20260713140142.27898-1-diy2903@gmail.com>
 <20260714071633.35446-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests in this script use the old style in which the test title and
body are passed as separate backslash-continued arguments, with bodies
indented using spaces:

    test_expect_success \
        'title' \
        'body'

Convert them to the modern style in which the body is a single-quoted
block on its own lines, indented with a tab:

    test_expect_success 'title' '
        body
    '

This is a style-only change; no test logic is modified.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
 t/t1100-commit-tree-options.sh | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index ae66ba5bab..fabe5a97cb 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -22,28 +22,28 @@ committer Committer Name <committer@email> 1117150200 +0000
 comment text
 EOF
 
-test_expect_success \
-    'test preparation: write empty tree' \
-    'git write-tree >treeid'
-
-test_expect_success \
-    'construct commit' \
-    'echo comment text |
-     GIT_AUTHOR_NAME="Author Name" \
-     GIT_AUTHOR_EMAIL="author@email" \
-     GIT_AUTHOR_DATE="2005-05-26 23:00" \
-     GIT_COMMITTER_NAME="Committer Name" \
-     GIT_COMMITTER_EMAIL="committer@email" \
-     GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null'
-
-test_expect_success \
-    'read commit' \
-    'git cat-file commit $(cat commitid) >commit'
-
-test_expect_success \
-    'compare commit' \
-    'test_cmp expected commit'
+test_expect_success 'test preparation: write empty tree' '
+	git write-tree >treeid
+'
+
+test_expect_success 'construct commit' '
+	echo comment text |
+	GIT_AUTHOR_NAME="Author Name" \
+	GIT_AUTHOR_EMAIL="author@email" \
+	GIT_AUTHOR_DATE="2005-05-26 23:00" \
+	GIT_COMMITTER_NAME="Committer Name" \
+	GIT_COMMITTER_EMAIL="committer@email" \
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null
+'
+
+test_expect_success 'read commit' '
+	git cat-file commit $(cat commitid) >commit
+'
+
+test_expect_success 'compare commit' '
+	test_cmp expected commit
+'
 
 
 test_expect_success 'flags and then non flags' '
-- 
2.52.0

