Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B98212D75
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830601; cv=none; b=k/eG52SoqK5y4s11vcOKITnustyQYG92D1nvH8tPnFLF5QrfblwngaaulTgxE2qybVbxeO8icrVJIUGwsCEPveSYj0yVPlDdCBQxvfdGKyjY5AnU02ECeJOvz2FLD7r+RcuZnnGzWLq2faHScyXwyJGTNeuP86u4FxVHlJeG4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830601; c=relaxed/simple;
	bh=7d0v/fW2aB00bJFmfvVyS4Q+inPguWQFl7wcOxNzL8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdiVlV3JLXJwg3bxhJAJbkeAw6tkGCbYrnIsqho7JLHJqUKUQCJ6aqqzP6T3sK9AzUWzXdJUHJ8WT9gGs1p8kulwtfOBduI3Ycp2BKuyQW0PypittIeg7x4B/e2VEQBbgAOfik6XzgoGJVTn7aRZbg9p96W1dEH+DcQLcEiFu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTOXVTo6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTOXVTo6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728ea1573c0so33775b3a.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830599; x=1734435399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m0Jv3x4S5mP1SNWqB3cmjfYtz3xeIJv4zIjzXdeCK4=;
        b=bTOXVTo679629gxMuGjeXmJtAy3AjitOs5+ahfARiwHZg6jpSRxYgzw+0Ynkd52Ho4
         PbeorV2IuGwSo4TUkEHEgdTIWilqoCnqyR9oMLU6XPPavFulKRbyHviwSMq9nHRXUTLi
         TQtJ5iYg/SWr+iTtZHa4be7oqh+WkMMeyp4iOkohI138reu4USoLNnIFgwxe4lt4L4dC
         BK7OVH2/WADL/72u9pGSDU95iKL9MEFDoU3pmfYovUZtP4yaJf6p3ZSDbEash5DEzMJq
         rQUCa8iN3bDDKtgzVxgDQStoHV7OApbC8HmVqlbUHGBzFsoMlP6M5kEOQLAvxxHPom2v
         E/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830599; x=1734435399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8m0Jv3x4S5mP1SNWqB3cmjfYtz3xeIJv4zIjzXdeCK4=;
        b=BhoujCsTYXjCQZ4m0sgqqJejn/7eQaaEv2JLTfiuqkdDdq+DCDtl3mXhbxD7pwxwkS
         tGWaHMyKnomB+ztni2kW/Iy9yDrCe7ONVcdpDOAHKeDzpnG2LnWoH3AxgfchL006cXU8
         n9pJf4YUrcXRifw9lILgQxjNe0YZ8GIsogwSeGKWe03RI0ZAotzHev1lng9geZ3mYMwF
         RVxkdJJecES4WH5r5z7c5P6jMoJJ/jDvwCq/OmV+MqgxGpvmJHFf1Gm1AC2BsP7j/hTG
         VdZIBYajrIWb6CDI7WGy8rCeKD4FmqoeUR5RM8BpnHDriEI+VeNWTV7+48q+V1hh4wcE
         uaXA==
X-Gm-Message-State: AOJu0YwRQwM19aLD89Aspin5lDkc6rDzNyngz1SI2E07h9d9A8GozcLC
	Xqwg18MK0nlEFDyonDC/Kq3AGVO5l2ufS8yrD/4m3yjSqChb9tbAKJcaSw==
X-Gm-Gg: ASbGncvadHnOiMP+lTy400MO3oUgobPbhCinHxRiKelw8KoEJMJjeOGJ5iROhvRzDHj
	L+S/kOm6S4tLhvHBQeml5Ijz9oIZRiXvean5FxEWzlyb/lycaKUd7cKsf5vV1tmoTWsHe31QotZ
	/NIkMNcVJfkwPLym9O06l58ywy1dSHKslW7Pe1RZTe3a0gRnh5KmUX6B6Wtv9Q7je5tx3IOS0Oo
	X9UDhNxY5nF17Gpt4QfshKhJKUimF0piX8v7ircUMfcRMjpvfyT0OiRB6gBSnkhFkfjLqKTGNrw
	TdjxrrJ93Ckvl7zKnT8LluNZKjoqFhkNvw9x50uNR6kKzw==
X-Google-Smtp-Source: AGHT+IHUB5KXRfVAokENtxzUceSSdLuQE1Pot7OY2yn3A/9+pnOAGpB3uUaJFL90kO0alyjXIaKdpw==
X-Received: by 2002:a05:6a00:3c8b:b0:725:e057:c3de with SMTP id d2e1a72fcca58-725e057cd56mr14175635b3a.23.1733830598639;
        Tue, 10 Dec 2024 03:36:38 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:38 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 5/8] t5548: add porcelain push test cases for dry-run mode
Date: Tue, 10 Dec 2024 19:36:25 +0800
Message-Id: <93123988ae00d865d0251ca0667c4f4584772021.1733830410.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com> <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

New dry-run test cases:

 - git push --porcelain --dry-run
 - git push --porcelain --dry-run --force
 - git push --porcelain --dry-run --atomic
 - git push --porcelain --dry-run --atomic --force

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5548-push-porcelain.sh | 153 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 799f6066a3..ba68808459 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -310,10 +310,159 @@ run_git_push_porcelain_output_test() {
 	'
 }
 
+run_git_push_dry_run_porcelain_output_test() {
+	case $1 in
+	http)
+		PROTOCOL="HTTP protocol"
+		URL_PREFIX="http://.*"
+		;;
+	file)
+		PROTOCOL="builtin protocol"
+		URL_PREFIX="/.*"
+		;;
+	esac
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain --dry-run ($PROTOCOL)" '
+		test_must_fail git -C workbench push --porcelain --dry-run origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# push             : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain --dry-run --force ($PROTOCOL)" '
+		git -C workbench push --porcelain --dry-run --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain --dry-run --atomic ($PROTOCOL)" '
+		test_must_fail git -C workbench push --porcelain --dry-run --atomic origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		> !	<COMMIT-B>:refs/heads/bar	[rejected] (atomic push failed)
+		> !	(delete):refs/heads/foo	[rejected] (atomic push failed)
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> !	refs/heads/next:refs/heads/next	[rejected] (atomic push failed)
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# push             : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain --dry-run --atomic --force ($PROTOCOL)" '
+		git -C workbench push --porcelain --dry-run --atomic --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+}
+
 setup_upstream_and_workbench upstream.git
 
 run_git_push_porcelain_output_test file
 
+setup_upstream_and_workbench upstream.git
+
+run_git_push_dry_run_porcelain_output_test file
+
 ROOT_PATH="$PWD"
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
@@ -325,4 +474,8 @@ setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
 
 run_git_push_porcelain_output_test http
 
+setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
+
+run_git_push_dry_run_porcelain_output_test http
+
 test_done
-- 
2.47.0.rc1.21.g81e7bd6151

