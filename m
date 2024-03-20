Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00885951
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968938; cv=none; b=rUYHk1aP7d6oe3sZNPzjP0XoZOUMniZ6QaxisSu/5/EA2jv5alVR984D1TFDfbvw0r2K1bPO2tDlxD3OFAcN4FP/Nj17zWQeHFdqJHvzz3fclcoDx5Vrp47ynQ1TsN12TWLnIdVHSMTtFifwF6F2/iAAIa+5iNBG9X18j36m3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968938; c=relaxed/simple;
	bh=6yS4gHRTRJZo82fQSZ+NBYhW/q1CCFop/qCYOFB/qLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlTe2Y45tk3Ujwu4t5ic8W757v3i7Rlpl9yY8lxr4WB4iZDlXOdAKhP3RZFwUahnYs8/7bcFBSTXWCvZ5UPhGjQTs8wj4nXbLQ/SBsM9S6Pp6e22gTOeJAVzvbH8H3LUUbIMMczxNUNUlMJaenTkFk2nRan5pDbS9KTYFPhfuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=l9H7Zapv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="l9H7Zapv"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710968932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FY3dKOHZ3HYNbNExnCLrBFqzW6OY9W/fId9jhOM3uKk=;
	b=l9H7ZapvTxwpOfM+hHxh9E96RdIDZce4jpAq7Gv2qhDZoksaSHOTQuzyvhIaaSECOkwIJM
	8M4u2dghjq8528fFAVJzLqonKY1J8lsFlBkcS3g8orowb1Nn+LyAnsFYD2UXJT640CrB6/
	YsA7o05kZRD+yyheVa+xOc5udRRG2pm0B+Q2qP9gH/6jnCPCjoWeE4iRmA0aF+UOuzPSSv
	Dy/r2ecwppUmKROgbDUSl0ghdP1/xQ6WEGT/5Q2S0dQdGzs+Ju3tXPJf/vyD6aCB1VK9uW
	D2/vXMm9IApU793ebRIf/FMrFBdOU7yPdF+PM6TkXsunhVWsdAIksMft1HGr+Q==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com
Subject: [PATCH 1/3] grep: perform some minor code and comment cleanups
Date: Wed, 20 Mar 2024 22:08:44 +0100
Message-Id: <6cf18d2cd76a9caf2ca2a782030cafb3e9432e84.1710968761.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710968761.git.dsimic@manjaro.org>
References: <cover.1710968761.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move some variable definitions around, and reflow one comment block, to
make the code a bit neater after spotting those slightly unpolished areas.
There are no functional changes to the source code.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This patch is salvaged from my earlier series, [1] for which it has been
    concluded to be not acceptable for merging, because of possible issues
    with various git scripts. [2]
    
    Compared to the previous version, there are no changes in this version.
    As expected and as already discussed, patches like this one inevitably
    raise a few eyebrows. [3][4][5]
    
    [1] https://lore.kernel.org/git/cover.1710781235.git.dsimic@manjaro.org/T/#u
    [2] https://lore.kernel.org/git/d8475579f014a90b27efaf6207bc6fb0@manjaro.org/
    [3] https://lore.kernel.org/git/CAPig+cQ6Y2oOaPkKFsD41beXLHjhD++nmf59xrcswpb6_Q-sdA@mail.gmail.com/
    [4] https://lore.kernel.org/git/xmqqjzlzt61d.fsf@gitster.g/#t
    [5] https://lore.kernel.org/git/24093dca675c49cfde39f6d6efca2342@manjaro.org/

 builtin/grep.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 982bcfc4b1df..af89c8b5cb19 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -623,13 +623,13 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
 		     int check_attr)
 {
-	struct repository *repo = opt->repo;
-	int hit = 0;
+	int hit = 0, name_base_len = 0;
+	int old_baselen = base->len;
 	enum interesting match = entry_not_interesting;
+	struct repository *repo = opt->repo;
 	struct name_entry entry;
-	int old_baselen = base->len;
 	struct strbuf name = STRBUF_INIT;
-	int name_base_len = 0;
+
 	if (repo->submodule_prefix) {
 		strbuf_addstr(&name, repo->submodule_prefix);
 		name_base_len = name.len;
@@ -890,19 +890,15 @@ static int pattern_callback(const struct option *opt, const char *arg,
 
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
-	int hit = 0;
+	int hit = 0, seen_dashdash = 0, use_index = 1;
 	int cached = 0, untracked = 0, opt_exclude = -1;
-	int seen_dashdash = 0;
 	int external_grep_allowed__ignored;
+	int i, dummy, allow_revs;
 	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
 	struct object_array list = OBJECT_ARRAY_INIT;
 	struct pathspec pathspec;
 	struct string_list path_list = STRING_LIST_INIT_DUP;
-	int i;
-	int dummy;
-	int use_index = 1;
-	int allow_revs;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -1059,9 +1055,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		recurse_submodules = 0;
 
 	/*
-	 * skip a -- separator; we know it cannot be
-	 * separating revisions from pathnames if
-	 * we haven't even had any patterns yet
+	 * skip a -- separator; we know it cannot be separating revisions
+	 * from pathnames if we haven't even had any patterns yet
 	 */
 	if (argc > 0 && !opt.pattern_list && !strcmp(argv[0], "--")) {
 		argv++;
