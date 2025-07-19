Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D92820A3
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928122; cv=none; b=o88MCveDDtoi8DSUsHkJebAE4SpvSsqg7256mro4yb866EIwmPkJsFgRnWlXuIwxDnhDlmo6HuwI/+p885+R6G3KBe1Ap+T1GvFSAcEfijl9aVemCz1XPsCEEMKGS7YK8nrXTe7sabxo2cU0+ON4iwmz3HvA6fZzFucVQpVbm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928122; c=relaxed/simple;
	bh=45ofwvnwk50907+wETcfc/2hp1z+eGxo+PTfas79YCE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IeKG4nzpOdOEejf0rHnlLCaAxJzPTOzwY+aRuNa9dPVD2JiLxvyEopMPIDyuCA4kWLrITLcun2CkVp9brdv7okRQmn4zRRwxbbnxsMlCHFCvoJns3ngpRm2k2vd94h3Cy7CWMKq2fQR72RfsyGHB+hQF2MxlmtarSP8R9YVZJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE6A9Qy4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE6A9Qy4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45611a6a706so15179665e9.1
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928119; x=1753532919; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8qZUliQvrnRYGAbhBuwZFPVoqKM0b635OK05jn3sYM=;
        b=XE6A9Qy4d2hBSHlXhNHapdRr6ONOXZLaNa6IuJEwpsjm4azza9ekOEwheiDBRAmP2F
         ta5FMpCmY9G+itUXEv5FGGmnBkdAGyqM/Mf+oqbBstSUd+qpFbjMwJ9rbEe0Fg5sNucy
         O3RNB90m3VVeewvsI6HsmE4F0/OTZ8s6Wd9BZbHg5RQuY2FqOveB7f0yuKBYINXsE/4L
         mke7svI1gN6N7Dt3LkZGgAny5jVcxdyDtHowhtkR80saZOUy8nLB3rEKUaN17G30MIMo
         FjO6BaL4ucV5z0nydQlepWDWXZCjtAmTM4SolVwAmpjMKaG2H1jVcN3m1k9NWZzm04NY
         eY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928119; x=1753532919;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8qZUliQvrnRYGAbhBuwZFPVoqKM0b635OK05jn3sYM=;
        b=NfQQWQOdIlviArFHCseKgXaBUvkJA9X6ONqVTW2Lm6D1UNWl7lojS7z2eRZEEyZigG
         HRbsUqxbUwEAXrElQLhKyyf/4Gms/qHo4Ov6UBs+bg7PpHrXdRA13RviWwqzYggh2hya
         bE0YPVPRyn4FB1HyTJdf+OJ3fyQywwyASj1Q9Vky8I/mNHr03k6phnT4UVLJ3FQN25HD
         gOgDIbJNujsSmOSFOt2ePD38C3bRkZ2yHPxvpAghGKYVO+K2Qwa9CYsJjt90V6cwPxA2
         Mu3gO/Y/KfheNayM5d7ScyZvqi5b2hak4gQdlo0ptjqZ9b5ycr0mH7ptSgjdJDbIrxYe
         yN5g==
X-Gm-Message-State: AOJu0YwcWJVp40pZkoaEhKAniNEqHlOWjD2mp64Tpoxw6RRKhNtm/fKs
	nlDNVdAjGX7uqv43hEehHf+tJ800OzU+6djIdoYlHlhB5VZLKZnNaBdLMjatvw==
X-Gm-Gg: ASbGncuqN8APMrns5ml8qW6YeGVzeq+DgqTIfnV/U0b0t9tUP2AW1iW6XO0kJBkacg+
	/np2gxTgyo1ugmTODBwMYxEZU6w5RpTuyr32uY0vWN85pgHZUrsuTlOg1p5m19flrHsKQxlAf5b
	PZzw5Z7f8w33CiPVbraSoyRzHjDZ07+xeUs3vQczMyeURLxuJ6bcgoGTjdDhsP+lXja4du1TUVD
	ut/8AyzbTFI1U38bZPqtJ2yXaOTVtTFh8/hZbw42eK/Qkss0UMo+iOtAp3cpmHFNiKYRrctK+QK
	hayxGFLGHfYK0U9p5cxvxd6MXfxgyYDFZRMDE8IjjN38d9oFvtd9z6LSir5HDcst9JdaSI3q6R0
	/4uxTfhu2RTo3g3QiJHQq4AU=
X-Google-Smtp-Source: AGHT+IGMmwPtFtQ4YuKpW9Gya83gqazC5GpfY3PvbeIhAB4qHuZDNNYg01UUHXxb41cr3iGO6064+g==
X-Received: by 2002:a05:600c:a316:b0:456:2066:5747 with SMTP id 5b1f17b1804b1-4562e3411b3mr133409245e9.10.1752928118238;
        Sat, 19 Jul 2025 05:28:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b740e55sm45670965e9.17.2025.07.19.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:28:37 -0700 (PDT)
Message-Id: <994029d66029e0eb1b93a6675e4df9c5c6fb76f9.1752928113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Jul 2025 12:28:32 +0000
Subject: [PATCH v4 3/4] add-patch: respect diff.context configuration
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

Various builtins that use add-patch infrastructure do not respect
the user's diff.context and diff.interHunkContext file configurations.

The user may be used to seeing their diffs with customized context size,
but not in the patches "git add -p" shows them to pick from.

Teach add-patch infrastructure to read these configuration variables and
pass their values when spawning the underlying plumbing commands as
their command line option.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 add-interactive.c          |  9 +++++++++
 add-interactive.h          |  1 +
 add-patch.c                |  9 ++++++---
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 97ff35b6f12a..eb3d0d3ada84 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -41,6 +41,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	const char *value;
 
 	s->r = r;
+	s->context = -1;
+	s->interhunkcontext = -1;
 
 	if (repo_config_get_value(r, "color.interactive", &value))
 		s->use_color = -1;
@@ -78,6 +80,13 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	repo_config_get_string(r, "diff.algorithm",
 			       &s->interactive_diff_algorithm);
 
+	if (!repo_config_get_int(r, "diff.context", &s->context))
+		if (s->context < 0)
+			die(_("%s cannot be negative"), "diff.context");
+	if (!repo_config_get_int(r, "diff.interHunkContext", &s->interhunkcontext))
+		if (s->interhunkcontext < 0)
+			die(_("%s cannot be negative"), "diff.interHunkContext");
+
 	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
 	if (s->use_single_key)
 		setbuf(stdin, NULL);
diff --git a/add-interactive.h b/add-interactive.h
index 693f125e8e4b..c63f35b14be8 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -18,6 +18,7 @@ struct add_i_state {
 
 	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
+	int context, interhunkcontext;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r);
diff --git a/add-patch.c b/add-patch.c
index 95c67d8c80c4..b0125b51ba45 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -414,7 +414,6 @@ static int normalize_marker(const char *p)
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct strvec args = STRVEC_INIT;
-	const char *diff_algorithm = s->s.interactive_diff_algorithm;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
@@ -424,8 +423,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	strvec_pushv(&args, s->mode->diff_cmd);
-	if (diff_algorithm)
-		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
+	if (s->s.context != -1)
+		strvec_pushf(&args, "--unified=%i", s->s.context);
+	if (s->s.interhunkcontext != -1)
+		strvec_pushf(&args, "--inter-hunk-context=%i", s->s.interhunkcontext);
+	if (s->s.interactive_diff_algorithm)
+		strvec_pushf(&args, "--diff-algorithm=%s", s->s.interactive_diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		strvec_push(&args,
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b088ee141ff4..18dc329ea1f6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1230,4 +1230,26 @@ test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -p respects diff.context' '
+	test_write_lines a b c d e f g h i j k l m >file &&
+	git add file &&
+	test_write_lines a b c d e f G h i j k l m >file &&
+	echo y | git -c diff.context=5 add -p >actual &&
+	test_grep "@@ -2,11 +2,11 @@" actual
+'
+
+test_expect_success 'add -p respects diff.interHunkContext' '
+	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
+	git add file &&
+	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
+	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
+	test_grep "@@ -2,16 +2,16 @@" actual
+'
+
+test_expect_success 'add -p rejects negative diff.context' '
+	test_config diff.context -1 &&
+	test_must_fail git add -p 2>output &&
+	test_grep "diff.context cannot be negative" output
+'
+
 test_done
-- 
gitgitgadget

