Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E6C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B15206E0
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqES3WwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfLITnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:43:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44643 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLITnF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:43:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so17520115wrm.11
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7prUlj6aalrcAGQdtr2blNGkHXxLgB30XPpWOI/8/90=;
        b=FqES3WwUL0ktTiRoZGqHJ14dEntysfIPY/aP0fWjdGiO6Ch4hxSAYjxODz3zjC96ly
         470shQLUXm5zKN9FeGA9c5zDVIDdmPzQvydlqj/2Z6xr3RrTYW5AOZgnuKmskK/1Cz+s
         EG6r7qictIIbqDV25iHPmZnlUdDPgNYxiKfYql5lGsBRhGpYD4STwGBPJC9dGGhSfoSV
         lhQuiBa+vkN27Z8v0ho/+ojXNvM5sp5w2+4ARdhyw5wMnE27s9aX8TnSXLT7p/B1vE5Q
         bT85DlykoDu+Rtb3AWcElTipCiwy6Dm7rMGv3RQSkIV0J0TeYecvx9BySP7m0h5oeFZO
         Dw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7prUlj6aalrcAGQdtr2blNGkHXxLgB30XPpWOI/8/90=;
        b=brne+G5Frw5zVjPMr2qCFhQa1HqwK+xJ5H/QHzATSEJ/XCEsClwTraLZcM0nniWjYb
         +oS0b42ErWVyodynzBQw8QT70AMR7D7dR3mrG6ZAQJ10IrDQGcHG3odL/+d638N85iTN
         NtqTCeYzdvnKyyH+MoKahJk/+fEuycqCp3vw0BE1altz0EYUnd86Fp2LPl6TY8cE/BzE
         bXws1UsT/Yom5WSgQKDhkj0efu1sFqD0qLP+zzla0fut1J8DWvGX75fXxeRZkPQyyCjc
         qbS8qOCCeHc/UwEZyhRY02iJrUmNlZ9DY8c4RcuocqzQiJLJlxmp36KGOcjtvfpy7FHd
         pqsQ==
X-Gm-Message-State: APjAAAWd30ls0hyl62tqbON2CyRXGPWoWDsDDPfKg2gLsJLdql3gmPGx
        r/786hCReTQFGSiyMhQzDqr2M0bT
X-Google-Smtp-Source: APXvYqzJx3ur6Xtbzf+NWPA/UMerMJb0nxvZt/KFjU26oPrN9gxg11B/qha5scdCu0tQPjjkHe0kmQ==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr3867845wru.353.1575920581947;
        Mon, 09 Dec 2019 11:43:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm543192wrx.20.2019.12.09.11.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 11:43:01 -0800 (PST)
Message-Id: <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.488.git.1575920580.gitgitgadget@gmail.com>
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 19:43:00 +0000
Subject: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a user uses the sparse-checkout feature in cone mode, they
add patterns using "git sparse-checkout set <dir1> <dir2> ..."
or by using "--stdin" to provide the directories line-by-line over
stdin. This behaviour naturally looks a lot like the way a user
would type "git add <dir1> <dir2> ..."

If core.ignoreCase is enabled, then "git add" will match the input
using a case-insensitive match. Do the same for the sparse-checkout
feature.

The sanitize_cone_input() method is named to imply that other checks
may be added. In fact, such checks are planned including looking for
wildcards that make the paths invalid cone patterns or must be
escaped.

Specifically, if the path has a match in the index, then use that
path instead. If there is no match, still add that path to the
patterns, as the user may expect the directory to appear after a
checkout to another ref. However, we have no matching path to
correct for a case conflict, and must assume that the user provided
the correct case.

Another option would be to do case-insensitive checks while
updating the skip-worktree bits during unpack_trees(). Outside of
the potential performance loss on a more expensive code path, that
also breaks compatibility with older versions of Git as using the
same sparse-checkout file would change the paths that are included.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  4 ++++
 builtin/sparse-checkout.c             | 19 +++++++++++++++++--
 cache.h                               |  1 +
 name-hash.c                           | 10 ++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 13 +++++++++++++
 5 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b975285673..849efa0f0b 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -150,6 +150,10 @@ expecting patterns of these types. Git will warn if the patterns do not match.
 If the patterns do match the expected format, then Git will use faster hash-
 based algorithms to compute inclusion in the sparse-checkout.
 
+If `core.ignoreCase=true`, then the 'git sparse-checkout set' command will
+correct for incorrect case when assigning patterns to the sparse-checkout
+file.
+
 SEE ALSO
 --------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a542d617a5..0de426384e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -336,6 +336,22 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 	}
 }
 
+static void sanitize_cone_input(struct strbuf *line)
+{
+	if (ignore_case) {
+		struct index_state *istate = the_repository->index;
+		const char *name = index_dir_matching_name(istate, line->buf, line->len);
+
+		if (name) {
+			strbuf_setlen(line, 0);
+			strbuf_addstr(line, name);
+		}
+	}
+
+	if (line->buf[0] != '/')
+		strbuf_insert(line, 0, "/", 1);
+}
+
 static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 {
 	strbuf_trim(line);
@@ -345,8 +361,7 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 	if (!line->len)
 		return;
 
-	if (line->buf[0] != '/')
-		strbuf_insert(line, 0, "/", 1);
+	sanitize_cone_input(line);
 
 	insert_recursive_pattern(pl, line);
 }
diff --git a/cache.h b/cache.h
index d3c89e7a53..a2d9d437f0 100644
--- a/cache.h
+++ b/cache.h
@@ -728,6 +728,7 @@ int repo_index_has_changes(struct repository *repo,
 int verify_path(const char *path, unsigned mode);
 int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
 int index_dir_exists(struct index_state *istate, const char *name, int namelen);
+const char *index_dir_matching_name(struct index_state *istate, const char *name, int namelen);
 void adjust_dirname_case(struct index_state *istate, char *name);
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 
diff --git a/name-hash.c b/name-hash.c
index ceb1d7bd6f..46898b6571 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -681,6 +681,16 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
 	return dir && dir->nr;
 }
 
+const char *index_dir_matching_name(struct index_state *istate, const char *name, int namelen)
+{
+	struct dir_entry *dir;
+
+	lazy_init_name_hash(istate);
+	dir = find_dir_entry(istate, name, namelen);
+
+	return dir ? dir->name : NULL;
+}
+
 void adjust_dirname_case(struct index_state *istate, char *name)
 {
 	const char *startPtr = name;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index d5e2892526..d0ce48869f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -304,4 +304,17 @@ test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status'
 	git -C dirty sparse-checkout disable
 '
 
+test_expect_success 'cone mode: set with core.ignoreCase=true' '
+	test_when_finished git -C repo config --unset core.ignoreCase &&
+	git -C repo sparse-checkout init --cone &&
+	git -C repo config core.ignoreCase true &&
+	git -C repo sparse-checkout set Folder1 &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/folder1/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout
+'
+
 test_done
-- 
gitgitgadget
