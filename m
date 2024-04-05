Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F464175578
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353693; cv=none; b=MjGz2DwwfwQN8z+qW05KLSx4cgirLul+nA+O9X0AtOZYMF9aBbITuth4qQ0+OfzOTmy2w26eB++fj8Skk0PU8MlTWF5j3AwHGOdUkOrQsof61PuMvTB58ElVgl6XmDsTTuvuXH3RZ+SXIiz2lk6XP1EtS5F2XnRSERnPBlIT2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353693; c=relaxed/simple;
	bh=SNcU+10mTQGjbYeivndwRNQ5w2IOoaGEWr1ouy3t5NY=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=bJiv6f5Yi7+5PM0aXjQnfA4oKHQ16U7gEmPC3o758BdGQBEPv66S9HntGy57kIQo6dzg+rQ2DCHE1+Z0rDSo/ivPpmuB9RKSdd4JUC7ehpNmNScqR0UlMNxLtzPBZFd424CVI9CsUXCJe4NB6nPfk+xsMQybWbw0RHPWrrSZ8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrRkosPn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrRkosPn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41631d7b172so7409545e9.0
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712353689; x=1712958489; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vnLU/ZARM/e1jDqJfUc3by/zjiv3Q7BjGsKAk8VW3G8=;
        b=jrRkosPneGgGc9zt9Kx5xGbs+U9/fC8j4S/MMlUaapkzrjIypwMhB4RGvhwEvSPF4y
         ouyAJ9Z3+M+zRyuK5KHk/yx8Ec/wMQCNW74jSKNJ4d9SrDY0ium/AQPQWBYWLIWpdsdZ
         U6igN8vkj6LLs5z/h0mvlBJKR+hpvCQFq2QYry5wM8qElnkesx3RQQNdVYzTydPBOYI2
         1nRIHg2l6uLMx8TFZw51BF5NyklcAjv6lOLnVXR+JSS+HvLegRowDC99EbiMg1YYUR7P
         DR5PxRZf5aI6oV2BTCmmCjYiIrp5Chu3Io+MogXbu/gseqJROgFGIgFahVwh+mgvpAMh
         VegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353689; x=1712958489;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnLU/ZARM/e1jDqJfUc3by/zjiv3Q7BjGsKAk8VW3G8=;
        b=k5ja3yNJBzoOEIBsSNqpixJsqIYVOhROONLBmzEHJaNtyhyOQAquboP2FzeKtDK3sx
         NCWa0McpQi3GbX9WwV/4Nco6clIIcMAD1TNoAVL8gvA1ZlMLEQ676c1vsvwaO0+sTIeu
         bns8TkEYqKcVpMiSLbwfmc8MgHXWkGDkEVjTZPFRkkZGiVmD3SLV1dhSmi8qEUWrmEA/
         lnUbH/E3OmICEXxsxaKyIa65p58Mxaq4VGHbMQT/PUTu+DN9aP81UtRxJ80Rj0Y5J+we
         BzXWM2eQi1VJB2r9XiES+fYiwO/JTonrLIx5Av08z4F2rnnNcj6kfL0z2N+oOX7NMZTP
         VtIw==
X-Gm-Message-State: AOJu0YxR4jJ8p2MbdEwi3JjRs7Kigb4B6JOPsxcteedinIJ8Gz592oT5
	B/ByaFCbveDr4fZT4fmAw4JCkGSq7xMtjgL76DEY415wQ4FYE9h5GBT3mKh8
X-Google-Smtp-Source: AGHT+IHgkNUSf8f69fwD7AQNidoDtxrbZBHKphIwQc87rYofuNFP2OMuCBjktZLXIUO5P7yUnnnwnA==
X-Received: by 2002:a05:600c:1e27:b0:416:33f5:57f2 with SMTP id ay39-20020a05600c1e2700b0041633f557f2mr296442wmb.0.1712353688602;
        Fri, 05 Apr 2024 14:48:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b004156afd6843sm7752445wmq.18.2024.04.05.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:48:08 -0700 (PDT)
Message-Id: <pull.1710.git.1712353687464.gitgitgadget@gmail.com>
From: "Max Coplan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Apr 2024 21:48:07 +0000
Subject: [PATCH] feat(log): add option to search for header or body to `git
 log`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Max Coplan <mchcopl@gmail.com>,
    =?UTF-8?q?Max=20=F0=9F=91=A8=F0=9F=8F=BD=E2=80=8D=F0=9F=92=BB=20Copl?=
 =?UTF-8?q?an?= <mchcopl@gmail.com>

From: =?UTF-8?q?Max=20=F0=9F=91=A8=F0=9F=8F=BD=E2=80=8D=F0=9F=92=BB=20Copl?=
 =?UTF-8?q?an?= <mchcopl@gmail.com>

Note to reviewer: I hate the name `--header-or`!  Please help me come up
with a better name.

Summary:
This change adds a new option to `git log` that allows users to search
for commits that match either the author or the commit message. This is
useful for finding commits that were either authored or co-authored by a
specific person.

Currently, the best way to find a commit either authored or co-authored
by a specific person is to use

```sh
echo \
    $(git log --author=Torvalds --pretty="%cd,%H\n" --date=iso-strict) \
    $(git log --grep="Co-authored-by: .*Torvalds" --pretty="%cd,%H\n" --date=iso-strict) \
| sort -n --reverse \
| awk -F, '{print $2}' \
| tr '\n' '\t' \
| xargs git show --stat --stdin
```

This is a bit of a pain, so this change adds a new option to `git log`.
Now finding either authors or co-authors is as simple as

```sh
git log --author=Torvalds --grep=Torvalds --header-or
```

Test plan:
1. create commit authored by A and co-authored-by B
2. create commit authored by B
3. run `git log --author=B --grep="Co-authored-by: B" --header-or`
4. expect to see both commits

Signed-off-by: Max 👨🏽‍💻 Coplan <mchcopl@gmail.com>
---
    feat(log): add option to search for header or body to git log

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1710%2Fvegerot%2Fheader-or-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1710/vegerot/header-or-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1710

 grep.c          |  2 +-
 grep.h          |  1 +
 revision.c      |  3 +++
 t/t7810-grep.sh | 11 +++++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index ac34bfeafb3..79ba4810b83 100644
--- a/grep.c
+++ b/grep.c
@@ -797,7 +797,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 	if (opt->no_body_match && opt->pattern_expression)
 		opt->pattern_expression = grep_not_expr(opt->pattern_expression);
 
-	if (!header_expr)
+	if (!header_expr || opt->header_or)
 		return;
 
 	if (!opt->pattern_expression)
diff --git a/grep.h b/grep.h
index 926c0875c42..8cbc4a46194 100644
--- a/grep.h
+++ b/grep.h
@@ -147,6 +147,7 @@ struct grep_opt {
 	int count;
 	int word_regexp;
 	int all_match;
+	int header_or;
 	int no_body_match;
 	int body_hit;
 #define GREP_BINARY_DEFAULT	0
diff --git a/revision.c b/revision.c
index 7e45f765d9f..0858050ece3 100644
--- a/revision.c
+++ b/revision.c
@@ -2646,6 +2646,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
+	// @@@ must-fix: find a better name
+	} else if (!strcmp(arg, "--header-or")) {
+		revs->grep_filter.header_or = 1;
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 875dcfd98f3..d539b5e88f5 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -961,6 +961,17 @@ test_expect_success 'log --grep --author uses intersection' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --grep --author --header-or uses union' '
+	# grep matches only third and fourth
+	# author matches only initial and third
+	git log --author="A U Thor" --grep=r --header-or --format=%s >actual &&
+	{
+	    echo fourth && echo third
+	} >expect &&
+	test_cmp expect actual
+'
+
+
 test_expect_success 'log --grep --grep --author takes union of greps and intersects with author' '
 	# grep matches initial and second but not third
 	# author matches only initial and third

base-commit: 7774cfed6261ce2900c84e55906da708c711d601
-- 
gitgitgadget
