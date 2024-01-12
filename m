Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828871AAAA
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFSPcJk5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28bcc273833so5822628a91.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705082518; x=1705687318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCWqS+hKR7K6fGL8KtonYyrCC8tIv+2vzutYerK9oz8=;
        b=iFSPcJk5xH2035wEPxnMmYnxqPoascMIXlhu1vumxVfxNLzmEUTKwlJErUALxqtDOG
         QTNJDuCaclcz6OXk4T5oJBbt+quqrJu3R3NLBf3JlSyh8pGm12pnZ/Q4VkOLw/WVAmSZ
         zdVNMtVO8cS0XlDLLkjv8ckTA1kTwwUFqVwHvemkHL+0j5qqRx9WONjG3H8+h8dK08dZ
         gG02WuYy0kmSlMGbRr2H0wZlVPGaMB/P5w69Q/dUni0NJ0cIbmqgX2lw4Aic0pdoo28T
         jqDfIuI886/no+fEb74r4nOKgYAHaUsKBd58ujk+K7OcFTeu3IWFuqwqcW9ES0x70KZn
         /Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082518; x=1705687318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCWqS+hKR7K6fGL8KtonYyrCC8tIv+2vzutYerK9oz8=;
        b=qItleOgVrB5TLABLRgFDUKrCAph+SGV/GYW+izQu0l0jrANjpjU70OU/JD+natDPZD
         LE6IMtyghlJj41K7fmur/3Sdl05j23cK+Pswmd9NDwRkCiA7OK3RGMVvkjE07P+k5AuV
         3YcwrEGDAhq88G5g14oXlJfCCj4l0dD4bTR7OARPXoMhvSg8PT4b6q0jfcn4D7SS0sxU
         GIFRHCrtcGrtCbFGqHO00KbGvGSm1FUXQMS/thYttOMwK+wuDHXuHSDcFpo5Jt5+kof/
         bOxCWc9vO2DbCkojtptPaKhnWp5yvU3xOLSzAnFKP7ULbe3NOyL4qU7OGKSCY5piMsJm
         8fGQ==
X-Gm-Message-State: AOJu0YxqDCCS8mZRV6bu2rC1xCCLd8YXk+65C4VZ5jmiXG+RL3k/79Zc
	bcJsNOTJqZoUs0u2LxKi3iqHSi7a2QgFG8au3mo=
X-Google-Smtp-Source: AGHT+IEL6ZLXbBqsTcg5v/tH6iuihE0719xMgCC0YjTQ8UX5nT+HlLOw4LGsSXi5XVhCx9qYIvgNkA==
X-Received: by 2002:a17:90b:3791:b0:28c:8ca3:d668 with SMTP id mz17-20020a17090b379100b0028c8ca3d668mr1617080pjb.86.1705082518367;
        Fri, 12 Jan 2024 10:01:58 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id ph8-20020a17090b3bc800b0028db69af4a4sm4450352pjb.4.2024.01.12.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:01:58 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 1/2] t7501: add tests for --include and --only
Date: Fri, 12 Jan 2024 23:30:16 +0530
Message-ID: <20240112180109.59350-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112180109.59350-1-shyamthakkar001@gmail.com>
References: <20240110163622.51182-2-shyamthakkar001@gmail.com>
 <20240112180109.59350-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for --only (-o) and --include (-i). This include testing
with or without staged changes for both -i and -o. Also to test
for committing untracked files with -i, -o and without -i/-o.

Some tests already exist in t7501 for testing --only, however,
it is tested in combination with --amend and --allow-empty and on
to-be-born branch. The addition of these tests check, when the
pathspec is provided, that only the files matching the pathspec
get committed. This behavior is same when we provide --only
(as --only is the default mode of operation when pathspec is
provided.)

As for --include, there is no prior test for checking if --include
also commits staged changes.

Therefore, these tests belong in t7501 with other similar existing
tests, as described in the case of --only.

And also add test for checking incompatibilty when using -o and -i
together.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 79 ++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 3d8500a52e..e4633b4af5 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, -i and -o, test reflog,
+# FIXME: Test the various index usages, test reflog,
 # signoff
 
 test_description='git commit'
@@ -92,6 +92,19 @@ test_expect_success '--long fails with nothing to commit' '
 	test_must_fail git commit -m initial --long
 '
 
+test_expect_success 'fail to commit untracked file' '
+	echo content >baz &&
+	test_must_fail git commit -m "baz" baz
+'
+
+test_expect_success '--only also fail to commit untracked file' '
+	test_must_fail git commit --only -m "baz" baz
+'
+
+test_expect_success '--include also fail to commit untracked file' '
+	test_must_fail git commit --include -m "baz" baz
+'
+
 test_expect_success 'setup: non-initial commit' '
 	echo bongo bongo bongo >file &&
 	git commit -m next -a
@@ -117,6 +130,70 @@ test_expect_success '--long with stuff to commit returns ok' '
 	git commit -m next -a --long
 '
 
+test_expect_success 'only commit given path (also excluding additional staged changes)' '
+	echo content >file &&
+	echo content >baz &&
+	git add baz &&
+	git commit -m "file" file &&
+
+	git diff --name-only >actual &&
+	test_must_be_empty actual &&
+
+	git diff --name-only --staged >actual &&
+	test_cmp - actual <<-EOF &&
+	baz
+	EOF
+
+	git diff --name-only HEAD^ HEAD >actual &&
+	test_cmp - actual <<-EOF
+	file
+	EOF
+'
+
+test_expect_success 'same as above with -o/--only' '
+	echo change >file &&
+	echo change >baz &&
+	git add baz &&
+	git commit --only -m "file" file &&
+
+	git diff --name-only >actual &&
+	test_must_be_empty actual &&
+
+	git diff --name-only --staged >actual &&
+	test_cmp - actual <<-EOF &&
+	baz
+	EOF
+
+	git diff --name-only HEAD^ HEAD >actual &&
+	test_cmp - actual <<-EOF
+	file
+	EOF
+'
+
+test_expect_success '-i/--include includes staged changes' '
+	echo newcontent >file &&
+	echo newcontent >baz &&
+	git add file &&
+	git commit --include -m "file baz" baz  &&
+
+	git diff --name-only HEAD >remaining &&
+	test_must_be_empty remaining &&
+
+	git diff --name-only HEAD^ HEAD >changes &&
+	test_cmp - changes <<-EOF
+	baz
+	file
+	EOF
+'
+
+test_expect_success '--include and --only do not mix' '
+	test_when_finished "git reset --hard" &&
+	echo new >file &&
+	echo new >baz &&
+	test_must_fail git commit --include --only -m "file baz" file baz 2>actual &&
+	test_grep -e "fatal: options .-i/--include. and .-o/--only. cannot be used together" actual
+'
+
 test_expect_success 'commit message from non-existing file' '
 	echo more bongo: bongo bongo bongo bongo >file &&
 	test_must_fail git commit -F gah -a
-- 
2.43.0

