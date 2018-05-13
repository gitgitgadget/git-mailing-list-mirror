Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647DF1F406
	for <e@80x24.org>; Sun, 13 May 2018 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEMRzB (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 13:55:01 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37779 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeEMRy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 13:54:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id r2-v6so14694761lff.4
        for <git@vger.kernel.org>; Sun, 13 May 2018 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QjzkE5ZRbXiKdBW42h1HC89Lq7UBNfs0kR5s5YfBaXI=;
        b=nx8RIAxtp9uwVe7V8o9BIfADwFOAdkCtocQj4CJmkpOwHMubPRPN5MAocY44zU9EU3
         zwFD0f3yFT9OroZReR3J73Uyd2C6nss19vuGXieN21hSQOoJDoH92CwfNlsB53TTr060
         bqGfZ5sxb6eQtKA4uX9NliyjzSan3CS5MvvufNArzzkgT+FDQCsTr5eNW7I/v1tupI2T
         baH34xuoV3qYdwuwGGBrLnmfUMMrirqgT6bBg+qaC9Jq06POnj+T5TtDNwsJ+tezl3xX
         Z7lR1CKsaM4ISRSe7rJ3KHMvNQr7QIFfonYzZfO+j4LgUjkEzWMh8ynrDLJ7G7WaIxHK
         kMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjzkE5ZRbXiKdBW42h1HC89Lq7UBNfs0kR5s5YfBaXI=;
        b=XmoJglHWZ8Wy553KjvpQCIhNtp3JW5MASeVcb0rxizwplP6SW3iGetzYpIVSaRSYmz
         2GXHn5bqQ7t3jsj8acjRaJ+U6qxH7+saGL8FwAzQU5l9ZZyb/lo2shQ9NK8TDUBPhHml
         L/ZTGlphOjxElNWJjaf/OoLN4tfI3fK4/uVjPkV9ClHHwlcoAuGnt0FtwKkY2iVYst9h
         Ml6lz0wO71Eset/MuLfjrlFteTc3tzlSmoH0MgkArEHRB+qFVbq8mAaEPkYzdScn9HO9
         9yU+abwanHR323t9nG5pZhpkV/36mVOyIE1AqV8j5W79QBeuXPl/rkc1u+xQ08orY8uW
         frrA==
X-Gm-Message-State: ALKqPwfJ39aB6aHXC3UXrDoRl0UpkG8mOYPES3jhXICG5wtBLe420OAP
        eGCTqcKroWo6WDZl+lEUkf9pNw==
X-Google-Smtp-Source: AB8JxZr9N6nMgThsYW5fR5i9bbANy865jZndwkvvbenzHQwAtcPWeWAzpcGYJUyX+0k/caZey4U1Ag==
X-Received: by 2002:a2e:4dd6:: with SMTP id c83-v6mr2786783ljd.126.1526234097231;
        Sun, 13 May 2018 10:54:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b79-v6sm1887970lfe.28.2018.05.13.10.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 10:54:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] apply: add --intent-to-add
Date:   Sun, 13 May 2018 19:54:38 +0200
Message-Id: <20180513175438.32152-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513175438.32152-1-pclouds@gmail.com>
References: <20180513175438.32152-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to 'git reset -N', this option makes 'git apply' automatically
mark new files as intent-to-add so they are visible in the following
'git diff' command and could also be committed with 'git commit -a'.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-apply.txt |  9 ++++++++-
 apply.c                     | 38 +++++++++++++++++++++++++++++++------
 apply.h                     |  1 +
 t/t2203-add-intent.sh       | 12 ++++++++++++
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4ebc3d3271..2374f64b51 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,7 @@ git-apply - Apply a patch to files and/or to the index
 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
+'git apply' [--stat] [--numstat] [--summary] [--check] [--index | --intent-to-add] [--3way]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
@@ -74,6 +74,13 @@ OPTIONS
 	cached data, apply the patch, and store the result in the index
 	without using the working tree. This implies `--index`.
 
+--intent-to-add::
+	When applying the patch only to the working tree, mark new
+	files to be added to the index later (see `--intent-to-add`
+	option in linkgit:git-add[1]). This option is ignored if
+	`--index` is present or the command is not run in a Git
+	repository.
+
 -3::
 --3way::
 	When the patch does not apply cleanly, fall back on 3-way merge if
diff --git a/apply.c b/apply.c
index 7e5792c996..31d3e50401 100644
--- a/apply.c
+++ b/apply.c
@@ -136,6 +136,8 @@ int check_apply_state(struct apply_state *state, int force_apply)
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
 		return error(_("--index outside a repository"));
+	if (state->set_ita && is_not_gitdir)
+		state->set_ita = 0;
 	if (state->cached) {
 		if (is_not_gitdir)
 			return error(_("--cached outside a repository"));
@@ -4265,9 +4267,6 @@ static int add_index_file(struct apply_state *state,
 	int namelen = strlen(path);
 	unsigned ce_size = cache_entry_size(namelen);
 
-	if (!state->update_index)
-		return 0;
-
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
@@ -4305,6 +4304,27 @@ static int add_index_file(struct apply_state *state,
 	return 0;
 }
 
+static int add_ita_file(struct apply_state *state,
+			const char *path, unsigned mode)
+{
+	struct cache_entry *ce;
+	int namelen = strlen(path);
+	unsigned ce_size = cache_entry_size(namelen);
+
+	ce = xcalloc(1, ce_size);
+	memcpy(ce->name, path, namelen);
+	ce->ce_mode = create_ce_mode(mode);
+	ce->ce_flags = create_ce_flags(0) | CE_INTENT_TO_ADD;
+	ce->ce_namelen = namelen;
+	set_object_name_for_intent_to_add_entry(ce);
+	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+		free(ce);
+		return error(_("unable to add cache entry for %s"), path);
+	}
+
+	return 0;
+}
+
 /*
  * Returns:
  *  -1 if an unrecoverable error happened
@@ -4465,8 +4485,11 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-	else
+	else if (state->update_index)
 		return add_index_file(state, path, mode, buf, size);
+	else if (state->set_ita)
+		return add_ita_file(state, path, mode);
+	return 0;
 }
 
 /* phase zero is to remove, phase one is to create */
@@ -4687,7 +4710,8 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && !is_lock_file_locked(&state->lock_file)) {
+	if ((state->update_index || state->set_ita) &&
+	    !is_lock_file_locked(&state->lock_file)) {
 		if (state->index_file)
 			hold_lock_file_for_update(&state->lock_file,
 						  state->index_file,
@@ -4888,7 +4912,7 @@ int apply_all_patches(struct apply_state *state,
 				state->whitespace_error);
 	}
 
-	if (state->update_index) {
+	if (state->update_index || state->set_ita) {
 		res = write_locked_index(&the_index, &state->lock_file, COMMIT_LOCK);
 		if (res) {
 			error(_("Unable to write new index file"));
@@ -4941,6 +4965,8 @@ int apply_parse_options(int argc, const char **argv,
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &state->check_index,
 			N_("make sure the patch is applicable to the current index")),
+		OPT_BOOL('N', "intent-to-add", &state->set_ita,
+			N_("mark new files with `git add --intent-to-add`")),
 		OPT_BOOL(0, "cached", &state->cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOL_F(0, "unsafe-paths", &state->unsafe_paths,
diff --git a/apply.h b/apply.h
index dc4a019057..94b38533a2 100644
--- a/apply.h
+++ b/apply.h
@@ -45,6 +45,7 @@ struct apply_state {
 	int check; /* preimage must match working tree, don't actually apply */
 	int check_index; /* preimage must match the indexed version */
 	int update_index; /* check_index && apply */
+	int set_ita;	  /* add intent-to-add entries to the index */
 
 	/* These control cosmetic aspect of the output */
 	int diffstat; /* just show a diffstat, and don't actually apply */
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 31bf50082f..1d640a33f0 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -246,4 +246,16 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 	test_cmp expected2 actual2
 '
 
+test_expect_success 'apply --intent-to-add' '
+	git reset --hard &&
+	echo new >new-ita &&
+	git add -N new-ita &&
+	git diff >expected &&
+	grep "new file" expected &&
+	git reset --hard &&
+	git apply --intent-to-add expected &&
+	git diff >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.17.0.705.g3525833791

