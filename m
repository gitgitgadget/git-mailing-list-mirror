Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A341DF98B
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436725; cv=none; b=DpvlKQRMerQQHEGsFoi7d3T10PXv2cZlRIHoXGXl05+W42vucuxM04QbX9PAA6juiViKBGDKmXtSr7DaKi2rt+3e4o/fsFrhLIoCbAazaR6nVFmFQFtuxWgxflp5LXHproNCny9nbVF1wGZMCWBpowB4MeaiKRoq/1FE0JZr+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436725; c=relaxed/simple;
	bh=9kxHjDJoQnXh3DEQ0Jw9CxNxoi684LVb/WNe1M0vEZw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MUkGdvdwHwZR1BEjh8BSHggSrjbd6Y3fBrydS2cmmntsfFosl0iDXK+UpX0kk5rZMBYwsi6p65wiizYVwMHFTafsuEjfdN0xhS06lb2tMUNEJjcm/GiSXWSk+o30ULcNTdYlj9s0y3GLXu8072JiCbH9GuT0OD6WMzKgOU/hczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+Tcg9bD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+Tcg9bD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441c99459e9so6124865e9.3
        for <git@vger.kernel.org>; Mon, 05 May 2025 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436721; x=1747041521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq50IjPMLG5Y5kUWCI8AXIfQn/BVkOB92YeXeJuAVqo=;
        b=a+Tcg9bDwTbzyFr9lpoIgfGrRt7FKkCqqzD8KQDubjsfSoX/wb/wgAZRa1slQD5VSq
         IPl28nBSiXms+bPhxjnPQkR7oOkxA/V921xPmBzSJ9MpZlKYZ8+D5dTWcMkrBxHOlZNx
         YCMUwFAGxNYlbueVI54WSv7zXv6wfU936KQzDIM2/zPR+9olKcO/a3QNcFruexn+ljDL
         Ys4gRCl6vQM0w3D8tVnzfxvatAbxQd5P4OqE1xVFMeN0NAZFyG2VMIRwjZtTMeoB1rLE
         aIDn1aEflo6nMdsCYyp62BojBaKeDxUNxNZiQcw09x/ozFRFZ/AGeMtsaed46sR5x7rE
         q92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436721; x=1747041521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq50IjPMLG5Y5kUWCI8AXIfQn/BVkOB92YeXeJuAVqo=;
        b=NUo/o0vGR+SIHowM07qGPH8MoB9+msEd5oZ5U/u1IksdkkaWcntFhw8Kr1ilVG4TmL
         p/AU/HzqbhwnU0cKX2WverFkOSutEipogjPndnZfz2c7j0PljQ8b6pd6k7aGu2vLkC0Z
         aYotQNwvXAresMFOwN8hSJYqLrQyLZfQrfl4w+ECo+JHd8BTSXyIKV4VIovjw0y2bWtf
         s0gw+ap5xkNteN/A49A5Nns1l//BvuiekBCgNYga4W0BhD2SNyrm+v7R9uPznfWCcu9Q
         3DWBy9ckVNoXYq3DWXqwFE0+JJ+xx62gQRthPD5X59d+/nsnwgTdxuJpxiCfj+ji+pd3
         BbRw==
X-Gm-Message-State: AOJu0YxE6AznaKwAZ5Be5B4CSa6kle1rnpRjic5wnELB0fqDRpLO6U7E
	A/gW7wYO8JqlLxHOta2NQfGnVUXQYj0+dURAMIM+ucJmtbJdc52jSe4+Lw==
X-Gm-Gg: ASbGncv2RI4uMc+qqkK7X+Om1BLLqIaUVrDWoCru20+f9+5AFGv0X6EXSGEef6e3fVJ
	Bq4DEEHGkm+d1OYmAyI2zvLVoAsnobVg3G0zN5wLQ2VEr7/A1WJXdJRv/v4VfYg3kiSC9caY0bX
	dDdWEDoLW9yLp6rrX6Wukouj2GbYF8+S6g8vPa5J2niACFcTaSkzyWxR+OlYZ2H6aQROa0jz88S
	c4uEDQ1Wz/RTpvzksGoZ3eYY/6HyFDHV6N0nSr688BGJXoLeLFeyOPKgQ0IzvDyvt+RB0WKr1dT
	m7Xl2Ve6HaO6KHlEXTEaGuYI/dFiRWey8lgfpxZJ6g==
X-Google-Smtp-Source: AGHT+IEydGAlS4o3nvVpmQQVxRDswiPs4bjaCRa4xIhvHe2kfXnUs1dTIIGGjWr5XGXLLIq1+x8Hbg==
X-Received: by 2002:a05:600c:19c6:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-441bbec2a80mr98642485e9.13.1746436721273;
        Mon, 05 May 2025 02:18:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad7688sm173928025e9.3.2025.05.05.02.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:18:40 -0700 (PDT)
Message-Id: <8b91eef8120b8f92db953ec983fddce8a442abcc.1746436719.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 09:18:37 +0000
Subject: [PATCH 1/3] add-patch: respect diff.context configuration
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
Cc: Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

This aims to teach relevant builtins (that take in `--patch`) to respect
the user's diff.context and diff.interHunkContext file configurations.

Since these are both UI options and `--patch` is designed for the end user,
I believe this was previously just an inconsistency, which this patch hopes
to address.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 add-interactive.c       | 16 ++++++++++----
 add-patch.c             |  6 ++++++
 t/t4055-diff-context.sh | 48 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 97ff35b6f12a..ad12dc416598 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -41,6 +41,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	const char *value;
 
 	s->r = r;
+	s->context = -1;
+	s->interhunkcontext = -1;
 
 	if (repo_config_get_value(r, "color.interactive", &value))
 		s->use_color = -1;
@@ -78,6 +80,9 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	repo_config_get_string(r, "diff.algorithm",
 			       &s->interactive_diff_algorithm);
 
+	repo_config_get_int(r, "diff.context", &s->context);
+	repo_config_get_int(r, "diff.interHunkContext", &s->interhunkcontext);
+
 	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
 	if (s->use_single_key)
 		setbuf(stdin, NULL);
@@ -1014,10 +1019,13 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 	if (count > 0) {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
-		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
-			     oid_to_hex(!is_initial ? &oid :
-					s->r->hash_algo->empty_tree),
-			     "--", NULL);
+		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached", NULL);
+		if (s->context != -1)
+			strvec_pushf(&cmd.args, "--unified=%i", s->context);
+		if (s->interhunkcontext != -1)
+			strvec_pushf(&cmd.args, "--inter-hunk-context=%i", s->interhunkcontext);
+		strvec_pushl(&cmd.args, oid_to_hex(!is_initial ? &oid :
+			     s->r->hash_algo->empty_tree), "--", NULL);
 		for (i = 0; i < files->items.nr; i++)
 			if (files->selected[i])
 				strvec_push(&cmd.args,
diff --git a/add-patch.c b/add-patch.c
index 95c67d8c80c4..b43ca1600738 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -415,6 +415,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct strvec args = STRVEC_INIT;
 	const char *diff_algorithm = s->s.interactive_diff_algorithm;
+	int diff_context = s->s.context;
+	int diff_interhunkcontext = s->s.interhunkcontext;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
@@ -424,6 +426,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	strvec_pushv(&args, s->mode->diff_cmd);
+	if (diff_context != -1)
+		strvec_pushf(&args, "--unified=%i", diff_context);
+	if (diff_interhunkcontext != -1)
+		strvec_pushf(&args, "--inter-hunk-context=%i", diff_interhunkcontext);
 	if (diff_algorithm)
 		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
 	if (s->revision) {
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index ec2804eea67c..9c024200ade7 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -49,7 +49,53 @@ test_expect_success 'diff.context honored by "log"' '
 	! grep firstline output &&
 	git config diff.context 8 &&
 	git log -1 -p >output &&
-	grep "^ firstline" output
+	grep "^ firstline" output &&
+	git config --unset diff.context
+'
+
+test_expect_success 'diff.context honored by "add"' '
+	git add -p >output &&
+	! grep firstline output &&
+	git config diff.context 8 &&
+	git add -p >output &&
+	grep "^ firstline" output &&
+	git config --unset diff.context
+'
+
+test_expect_success 'diff.context honored by "commit"' '
+	! git commit -p >output &&
+	! grep firstline output &&
+	git config diff.context 8 &&
+	! git commit -p >output &&
+	grep "^ firstline" output &&
+	git config --unset diff.context
+'
+
+test_expect_success 'diff.context honored by "checkout"' '
+	git checkout -p >output &&
+	! grep firstline output &&
+	git config diff.context 8 &&
+	git checkout -p >output &&
+	grep "^ firstline" output &&
+	git config --unset diff.context
+'
+
+test_expect_success 'diff.context honored by "stash"' '
+	! git stash -p >output &&
+	! grep firstline output &&
+	git config diff.context 8 &&
+	! git stash -p >output &&
+	grep "^ firstline" output &&
+	git config --unset diff.context
+'
+
+test_expect_success 'diff.context honored by "restore"' '
+	git restore -p >output &&
+	! grep firstline output &&
+	git config diff.context 8 &&
+	git restore -p >output &&
+	grep "^ firstline" output &&
+	git config --unset diff.context
 '
 
 test_expect_success 'The -U option overrides diff.context' '
-- 
gitgitgadget

