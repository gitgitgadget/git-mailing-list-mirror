Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6CE33260C
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069353; cv=none; b=YDgwiCc3rfTCTTUU0EGItZvZQveoXsajqOX4+b/jrrd8M6h3HBGeXmaRcLMLraJ9ILc6eE/RzodUMeTl/yMnzYcxy086nZWI/hsu9OIa0HTXwWR/0kkqoeGp322NdKy1ZgLgv57Viv70PZbzys5lSGpqw0FMJp27QAqHuHCQ/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069353; c=relaxed/simple;
	bh=c5CGyTg10bI35hg2oQE1HDuI87935rVEMv6Xgxl/bEM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H3LwG1Uz7DoVeQSvbwGs4ouGeoMergSeVKJUyc3n1TFwoL5DLLPgnfbZOGTe8Pu2pXd9W392kLathamdszfM8Ecg88SXxojP9ldnvo+qaQ8DBfOggiqgZbMVSHoyGVqSJrB6G7/jSfJ+mynAgzEN5kCueiLZpNVH3IVCK4/H/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhO3joyp; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhO3joyp"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb42a2f5feso1975941a34.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069350; x=1784674150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g7Jy7MAbqvlHYEaanvBXADASWw58ecTwefp+2DZCMBA=;
        b=MhO3joypP5uScEynB2m+jpXotmyysA4yTknrFr4B0M793bPfXEPKFHTwyzyiA1faX+
         8zZ5SDvRE5aVtLv0KgR0k53gnrXWiWrI+1JajmvQINHHsQ5OVkG6gVdrRU6rvJ3I5Qri
         XPYxlovT+TmLF3/QPaTvefqbvnOwcP+vLv5Lxiwo04yxOHEWECF+PIEeRYTKeB17oulr
         LIC39Qi2tiPGsk+glhZ8tGcC7Vn1os9oQDHk+YbZ6xC3Kw/B5j1ot9m7cIB/L55IPmbB
         7eki8le53LZR5Lt8VZeUSwjrmZ1n+eu90yulBhqTN/FbhAj9X6AXP2Uj+r6ci8W29g40
         r4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069350; x=1784674150;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7Jy7MAbqvlHYEaanvBXADASWw58ecTwefp+2DZCMBA=;
        b=a/RGkC97PYJICu6OOWAdrT/f4dkbKDkxBRtzHnjJdTbB0+wT4MoXvU1M594AvEPZ5N
         LpTPYH3ZDjzYCz5Bs1jw8fbOkGlnPHFE/NDMZJdiML9jwwGldA6wj77mV0ZmjDsjTp3B
         7KqFAsmfVrlxjFOaiaocuPB4Bta6+33Mk6M8skM2ltboVOtFvi4cjQpKfgg7vT09m8/d
         UScSr344FZs7iwk8TdS9WtuJG/dxN78tTdrqjxqDDuw60MYqYK89zB72Jx8CWG/ZmB77
         Rffhwx7dPivSCgp+4MI3joIXxpDtVNcMaccw2K4uVD5Qo+3rs9eOTnNqKjYHm8GWm6eW
         xo2Q==
X-Gm-Message-State: AOJu0YwRT2REUea6tsWQHZFUZpz69P9zMu9hxUd7apl+q6TUtvKsrA98
	3yVxT0NX0jLEKi5syQQ4v6ljRtKfIxF4HkNV6f/6XGRHfj15xnBuA8w3qellZQ==
X-Gm-Gg: AfdE7ck3Qy2DXH5ad4Ufnle618H6jdKjE2nPpmQc+YWtfLK7mMvhtIhkIW1jl6AYnNO
	G+CIN23lXc+hlFXj5uAffvcs+7Mdiuqpp4NDnO6bdqdjsgTpEfC3LmsSCEaUW96ABSMv5hDG2kP
	BkIHxyNrkkIbhMnmW6w+m07YQj5f8kL3mfj4+tbs0WAJpDKfBzgeVbI8n9W5mmoQ0acEtfT1iXX
	Vxmu2uCjbGEYTwvvt9r0fM3KqNrm0N/yHrNsQofLR4HhBVVMknFjb2BAQg8H/+ZHJH1noap7MN7
	Slv+fNn8mkw1Tn0ZZeDMI+Cz2VTdJibq9fG0TC3gz9lQRKCOQFZ//2bQUbKjBz4+pxuSKY/u/CN
	f6mAeWAbkbsTBAvhpIxvIPoxVgg5OoQmQ2oh6ggAuR+uN7Dn8j9D7Svub4O9jX+8uVJnSH9m2oT
	MN0wtBt24ZtS0G2njA
X-Received: by 2002:a05:6830:6aae:b0:7e9:ef39:1caf with SMTP id 46e09a7af769-7ec4a8a2c7bmr2558758a34.16.1784069349711;
        Tue, 14 Jul 2026 15:49:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcafda2ffsm16057244a34.12.2026.07.14.15.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:49:07 -0700 (PDT)
Message-Id: <c0827a79476d02f2b09ded919b44860e3743fbe0.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:43 +0000
Subject: [PATCH 10/11] bisect: check get_terms return at all call sites
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Six callers of get_terms() silently discard its return value. When
get_terms fails (missing or truncated BISECT_TERMS file), the term
strings remain NULL or empty, causing confusing downstream
behavior: commands like "bisect next" or "bisect run" proceed with
empty term strings, producing nonsensical ref names (refs/bisect/
with no suffix) and misleading error messages.

Add checks at each call site so that a failed get_terms produces a
clear "no terms defined" error, matching the pattern already used
in bisect_terms() at line 512. The check tests the term pointers
rather than the return value because some callers (bisect skip,
legacy bad/good) call set_terms before get_terms, and the
set_terms values should survive a get_terms failure.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index fe66d84382..15a2a30f89 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1057,6 +1057,8 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 	*word_end = '\0'; /* NUL-terminate the word */
 
 	get_terms(terms);
+	if (!terms->term_bad || !terms->term_good)
+		return error(_("no terms defined"));
 	if (check_and_set_terms(terms, p))
 		return -1;
 
@@ -1383,6 +1385,8 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 		return error(_("'%s' requires 0 arguments"),
 			     "git bisect next");
 	get_terms(&terms);
+	if (!terms.term_bad || !terms.term_good)
+		return error(_("no terms defined"));
 	res = bisect_next(&terms, prefix);
 	free_terms(&terms);
 	return res;
@@ -1417,6 +1421,8 @@ static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUS
 
 	set_terms(&terms, "bad", "good");
 	get_terms(&terms);
+	if (!terms.term_bad || !terms.term_good)
+		return error(_("no terms defined"));
 	res = bisect_skip(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1429,6 +1435,8 @@ static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix
 	struct bisect_terms terms = { 0 };
 
 	get_terms(&terms);
+	if (!terms.term_bad || !terms.term_good)
+		return error(_("no terms defined"));
 	res = bisect_visualize(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1443,6 +1451,8 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 	if (!argc)
 		return error(_("'%s' failed: no command provided."), "git bisect run");
 	get_terms(&terms);
+	if (!terms.term_bad || !terms.term_good)
+		return error(_("no terms defined"));
 	res = bisect_run(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1482,6 +1492,8 @@ int cmd_bisect(int argc,
 
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
+		if (!terms.term_bad || !terms.term_good)
+			return error(_("no terms defined"));
 		if (check_and_set_terms(&terms, argv[0]) ||
 		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
-- 
gitgitgadget

