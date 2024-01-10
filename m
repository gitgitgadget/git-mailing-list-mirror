Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2424D102
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYT14Or0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so3004765a12.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704904648; x=1705509448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKB3bDr79O9EkSZOXP3Hhj+oHIO0tmEXaG4n3Lw9Y4k=;
        b=GYT14Or0aRnzPUYmJ9YV7Sqv/mo7E2hfOOkmzvW+edx6mgCfehAmAry8moUWaCo39I
         olkRlGU3Yordyb4/p+9Pde+0agxiv5opKu1c/edlOYSVGmVQnJdswwcn3dbks/bUt4co
         onTT+brqU1HfDzpaUFQ4TC4VPcEpB0nLmsoEBDRxhW2kEg7P7DONVT8wbzVIvfXclv7Y
         ilwPXeprOp1W3KbtYJYgN73AOEp4NBOoTrMcKO2wwhPqUGB7AwgPhL54GiOgn8GKsE7x
         UkfcK3Hwg3Bw+UOES/Sr7/RqD7zW6flShRi5tjK6mXqto4CZ7o8ViWuioszyDBJd7NGV
         we1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904648; x=1705509448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKB3bDr79O9EkSZOXP3Hhj+oHIO0tmEXaG4n3Lw9Y4k=;
        b=JHLDlmgxDT41pmt8YGZk1WABCrkOb9f+7Hv0LO3m7x5+epw2L6XSUuUC7wWReYgRAP
         dOvdIBsGZ29vb6n521Nh1yHUmCJxWqpEwG4ryOGdKGkFVFI09tXarK6C+fPLESQZf02b
         SSEVlyAW5A98juE5zllVd9kuYqY5CoaKbt20GuAAY+JIOlapYKQfBIL7vVVspIq6nS4s
         Q0r6EnHK/K5PfV+MBHrkVoTNTkFaVWy8Q63e4tLx8Ztvu/hO+snHvYf0e2MYX/qzo6k8
         rbcpWA3Q+5fefnVRoFQWmAjUln5NcmMm4q8KLQ3JdCsqbhSpJQ9ZPEmXJQJLZgiaMW5c
         l/xQ==
X-Gm-Message-State: AOJu0Yx+CDGNtwnVwyP+ahohiOXfoNVUKFDJEjIaIF6o8I+0Im2i4h16
	Fn5zF48hEXLmHLeEZy5aH6xZr7LEH+a1W5u98jQ=
X-Google-Smtp-Source: AGHT+IFoUge4Y3iD14HL3ZHd1MvR2wrSgWXMHcFlEewIY+Cd5mtryHTk/FqHiR7BIQB+jOXS+edjfQ==
X-Received: by 2002:a05:6a21:3d89:b0:199:fffd:a3e3 with SMTP id bj9-20020a056a213d8900b00199fffda3e3mr463253pzc.52.1704904648415;
        Wed, 10 Jan 2024 08:37:28 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id fb11-20020a056a002d8b00b006daca8ecb85sm3692310pfb.139.2024.01.10.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:37:28 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 1/2] t7501: add tests for --include and --only
Date: Wed, 10 Jan 2024 22:05:18 +0530
Message-ID: <20240110163622.51182-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109165304.8027-2-shyamthakkar001@gmail.com>
References: <20240109165304.8027-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for --include (-i) and --only (-o) of commit. This includes
testing --include with and without staged changes, testing --only with
and without staged changes and testing --only and --include together.

Some tests already exist in t7501 for testing --only, however, it is
only tested in combination with --amend, --allow-empty and to-be-born
branch, and not for testing --only separately.

Similarly there are no separate tests for --include.

These tests are an addition to other similar tests in t7501,
as described above in the case of --only, therefore, they belong
in t7501-commit-basic-functionality.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 43 ++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 3d8500a52e..e005175d0b 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, -i and -o, test reflog,
+# fixme: test the various index usages, test reflog,
 # signoff
 
 test_description='git commit'
@@ -150,6 +150,47 @@ test_expect_success 'setup: commit message from file' '
 	git commit -F msg -a
 '
 
+test_expect_success '--include fails with untracked files' '
+	echo content >baz &&
+	test_must_fail git commit --include -m "initial" baz
+'
+
+test_expect_success '--include with staged changes' '
+	echo newcontent >baz &&
+	echo newcontent >file &&
+	git add file &&
+	git commit --include -m "file baz" baz  &&
+
+	git diff --name-only >remaining &&
+	test_must_be_empty remaining &&
+	git diff --name-only --staged >remaining &&
+	test_must_be_empty remaining
+'
+
+test_expect_success '--only fails with untracked files' '
+	echo content >newfile &&
+	test_must_fail git commit --only -m "newfile" newfile
+'
+
+test_expect_success '--only excludes staged changes' '
+	echo content >file &&
+	echo content >baz &&
+	git add baz &&
+	git commit --only -m "file" file &&
+
+	git diff --name-only >actual &&
+	test_must_be_empty actual &&
+	git diff --name-only --staged >actual &&
+	test_grep "baz" actual
+'
+
+test_expect_success '--include and --only do not mix' '
+	test_when_finished "git reset --hard" &&
+	echo new >file &&
+	echo new >baz &&
+	test_must_fail git commit --include --only -m "bar" bar baz
+'
+
 test_expect_success 'amend commit' '
 	cat >editor <<-\EOF &&
 	#!/bin/sh
-- 
2.43.0

