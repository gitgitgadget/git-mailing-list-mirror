Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99D3D891E
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954685; cv=none; b=YZsvTIlGxDzDzIHddIXI1AFFxJx0Wk8SrUusN05D4ZOZiYM7kD+OtOXcxdWeUfQKdCzutAuOYfA0wFgT0RknTLjPZkF2D1FcGD58NNdY+NH1cQruppoTXjxsJg21fDvaTJWAhn9BwwlqTB2m+W4oLNJTQcuGGyzbtUTxLxe4XJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954685; c=relaxed/simple;
	bh=SCgiYEcguM9cScfCecDfRlgMMOnXVktqrWK85NZFYZw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Kt/cr0KvgcgaFy/Y2Y+nquRvDJA7Uu/UCRMP2yR94V1/PKIZqbmC8OLmZG+82g8tdgX+k8zJIULwiNkFZCF6QyUxidojIxZ5MWAlYxjp6uys6yswqiL2/+JmPFyRXqtm3w7t+5s5DpbLoVIIP9LHrzmkU3bbljl/zdGy2edXyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGUE/L71; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGUE/L71"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a2dcede83so1920398b3a.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954683; x=1786559483; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=THLt5K4lUMElG0T0jTwOfnfhyE1YhQGSYV/qqc0yVxw=;
        b=kGUE/L71mwkoICHiCiC8RDlDTb5Mgs8AzBImoCNNiQDqeaw71BwclnMjjS7DU+FwSY
         tr6ltIM0hqKm2shMb4fpe1+66BhNrt9e/HINOWq9WVYxjr2eT+3uyuGxl4WkqL57Wach
         GIxey01G5UMsWtfDE3lOkIalbN1ynoE8tIE8hvJoIFwI1NAPy0UgsKFp9XbvhvidQXPB
         LuLv3jCGCVEyrV2GB2QJbpNp5xEJhqzNKPpZXZg9PV0esQmH2vVp1k4A8keMExJMZ5Mv
         ThsHEyt81gCCFH0pgoZmgK/7F9/e5jUswzyxBraMXdu3mipc2V5I+QtjOiqq02Y6twwU
         5NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954683; x=1786559483;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THLt5K4lUMElG0T0jTwOfnfhyE1YhQGSYV/qqc0yVxw=;
        b=NnBTNLRkyn5G3kIFlmbXOXlgxD3QVDoHR7iNP6x5ITiOggIjUHp3cYBWcyin3bepRG
         YUZ5TPFVWkblVwYKJN0W4tRw9vVTvfYAEuic2aCIoskF9U1hG7uw/BHjb8pm3VDVb4vW
         IE3EaGqTdmQ4cM0h6SLJnWojcmcWqA+6cWFY1ddJb0VaCyzVY7WF2MDZzCTox9HFHwgZ
         iQkSv9kYPIf8JRq57IKLQXeGoRwNOQbPaHIk6oZmRH7Z92NQFZppBCklHuuFfVnMcU+A
         AxPbFBIsSJLJO3z1HyCzmRw54PwQh3Y09Lg1B836PK/Wf+5gMtC+jujnlDltszTLVuaq
         j6Sg==
X-Gm-Message-State: AOJu0Ywuqb18rLPtOndwRO/Fp/d/oOJSwCtSfwraZphpjpAuepn3hbIv
	YKRRHv4fbqtSW9iPBK9krLznOQ39gLeIlHUhRl4g9ISuvsMDKTNMP6fMxP8HFQ==
X-Gm-Gg: AR+sD11SaqQTyrsMd7xJfqUDZFQ+UgkF1LFkJCkhG0o1RQM7oKHPUSx3d1/TCt+Wxr0
	9Ycefp+avU1yzIl+mjegRzIUkVIB+InL6mWJLDWLRqP7TnSlUUwpY60JzNQ0n95XnDOHmG4BgXn
	TmxvnaMZc/jTRJsYP/P2zN/7M2gv3P0gXK3qmlbmWpdMayLIAtf2AqNf2DEhqtudFwV1nrmbFvk
	GZaEsBYl4Qqg9bAL6fR8JCWMtNxAAUPCf0EEaT58aIX6ZLG70qqZeI0p0P8iymzpBdrmuoRB2fy
	wFnm6aFss7Iw4WE/Q7P93tp9ul8gTz99nmkH/QHGP/9HrNP8RmIeZku5qu51VkSPRNhBAKUdXKO
	jwCtMO62sdbLiu+jFrw3AmIXXaDez9pQPLynFDp0Fc+UNoLykYABWVZWj40FctgqlzxXzks/7ox
	9CNosYS5GR5qISC+ysc+SsfgmrIoqOUvh8ijQpkv4WsTLgw7IDvHKjSmdZNrhjC6c+Rg==
X-Received: by 2002:a05:6a00:2ea0:b0:848:4424:2b8e with SMTP id d2e1a72fcca58-84f2dfb4414mr9848431b3a.3.1785954682686;
        Wed, 05 Aug 2026 11:31:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708beae5sm2057668a12.18.2026.08.05.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:21 -0700 (PDT)
Message-Id: <9a9103096a2bd877f84502cffefd019d0a6e229d.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:59 +0000
Subject: [PATCH v2 10/11] bisect: check get_terms return at all call sites
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Six callers of get_terms() silently discard its return value. When
get_terms fails (missing or truncated BISECT_TERMS file), the term
strings remain NULL or empty, causing confusing downstream
behavior: commands like "bisect next" or "bisect run" proceed with
empty term strings, producing nonsensical ref names (refs/bisect/
with no suffix) and misleading error messages.

Let's not discard the return value, but handle an error with the same
message `bisect_terms()` already uses when reading the terms failed.

Pointed out by Coverity.

There is one slight complication here: One caller _needs_ the return
value to indicate an error when the `BISECT_TERMS` file is absent, all
the other call sites are totally okay with a "missing" `BISECT_TERMS`
file. To address that, extend the function signature of `get_terms()` to
indicate which behavior the caller wants.

Assisted-by: Claude Opus 4.6
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 69ab7ea248..ceb60b0626 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -485,7 +485,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	return decide_next(terms, current_term, !state.nr_good, !state.nr_bad);
 }
 
-static int get_terms(struct bisect_terms *terms)
+static int get_terms(struct bisect_terms *terms, int file_missing_is_ok)
 {
 	struct strbuf str = STRBUF_INIT;
 	FILE *fp = NULL;
@@ -493,7 +493,7 @@ static int get_terms(struct bisect_terms *terms)
 
 	fp = fopen(git_path_bisect_terms(), "r");
 	if (!fp) {
-		res = -1;
+		res = file_missing_is_ok ? 0 : -1;
 		goto finish;
 	}
 
@@ -519,7 +519,7 @@ finish:
 
 static int bisect_terms(struct bisect_terms *terms, const char *option)
 {
-	if (get_terms(terms))
+	if (get_terms(terms, 0))
 		return error(_("no terms defined"));
 
 	if (!option) {
@@ -1057,7 +1057,8 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 	rev = word_end + strspn(word_end, " \t");
 	*word_end = '\0'; /* NUL-terminate the word */
 
-	get_terms(terms);
+	if (get_terms(terms, 1))
+		return error(_("no terms defined"));
 	if (check_and_set_terms(terms, p))
 		return -1;
 
@@ -1383,7 +1384,8 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	if (argc)
 		return error(_("'%s' requires 0 arguments"),
 			     "git bisect next");
-	get_terms(&terms);
+	if (get_terms(&terms, 1))
+		return error(_("no terms defined"));
 	res = bisect_next(&terms, prefix);
 	free_terms(&terms);
 	return res;
@@ -1417,7 +1419,8 @@ static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUS
 	struct bisect_terms terms = { 0 };
 
 	set_terms(&terms, "bad", "good");
-	get_terms(&terms);
+	if (get_terms(&terms, 1))
+		return error(_("no terms defined"));
 	res = bisect_skip(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1429,7 +1432,8 @@ static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix
 	int res;
 	struct bisect_terms terms = { 0 };
 
-	get_terms(&terms);
+	if (get_terms(&terms, 1))
+		return error(_("no terms defined"));
 	res = bisect_visualize(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1443,7 +1447,8 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 
 	if (!argc)
 		return error(_("'%s' failed: no command provided."), "git bisect run");
-	get_terms(&terms);
+	if (get_terms(&terms, 1))
+		return error(_("no terms defined"));
 	res = bisect_run(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
@@ -1482,7 +1487,8 @@ int cmd_bisect(int argc,
 			usage_with_options(git_bisect_usage, options);
 
 		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
+		if (get_terms(&terms, 1))
+			return error(_("no terms defined"));
 		if (check_and_set_terms(&terms, argv[0]) ||
 		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
-- 
gitgitgadget

