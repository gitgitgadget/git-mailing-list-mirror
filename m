Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898A02095B
	for <e@80x24.org>; Sat, 18 Mar 2017 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdCRWmy (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 18:42:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36534 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdCRWmx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 18:42:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id l37so13583315wrc.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/J4uRhbqYH0hOodscTfHGVYBF+qg47P5+zA4ouexrc=;
        b=BPHccp5aDtxKaFLDP/aX8CsU5uMnbcYDARx3IXSsKeicup3ojQloiRdyBF0TPg3dCz
         LEQfxHZkf4idYhi0tYQ8JHlUt1WJ0CRRZtrG9RMDK6OYIcV8kb7d55Ou8/RCcbGhiB3t
         g/KkLSaWRf378o17N8xVO1vOhgze1qhRMerngdF5rVppm+Fc4szIeq/wUDlckYmIvPgZ
         +ehrqhjpl3NvHeukmfxQxP7Jx6YTDnEqB0/CqnmWjS6xg5hVELFBnXtg3/it6YVeEbXn
         oruz8zt4akENOYqcBOzansWcM+QQwA/UpkgAjUKxhET8eXHoAVeIqH3He8WG3u+PFjvl
         fDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/J4uRhbqYH0hOodscTfHGVYBF+qg47P5+zA4ouexrc=;
        b=Zl7drecDje9meUREaV4oqakuBJmeL8dTrcuaJWG7uLlcrH5D/xEkmFrS3MtVMhsWuk
         g+iP7/Coo07OcMMsaQTVljuKjfMeuoGMlgErSfV+Boj2l6+zLYpjpXbiILcRj0ElePdZ
         bBc3I75PwEFvyZlJ/ERyjsneYG2F3xE6qR73qwqmR94V9Wgr7LcEHxPdcJd02dYid3MH
         KmuNjbcrnr8inYITvN+9mZsaa6JzWIcmk9nw7lKb/qfYKXwH/5qeMIQDPqI8GQi35npR
         dDOolFV8OTcNEPpyK+PGsLYyq1uBvRlMIJW/v0o2F77nV9U6JRDoqzP9FnWLNWUUCfWP
         4HOg==
X-Gm-Message-State: AFeK/H3VdlPH8cxNv8EdMUAoysJnAc2PE52HXQqez3FImsE/Ia4br95rMc/Vl7AEgZJ1Ig==
X-Received: by 10.223.129.4 with SMTP id 4mr16137525wrm.4.1489876459797;
        Sat, 18 Mar 2017 15:34:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j80sm7699212wmd.14.2017.03.18.15.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 15:34:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>} case-insensitively
Date:   Sat, 18 Mar 2017 22:34:09 +0000
Message-Id: <20170318223409.13441-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the revision parsing logic to match @{upstream}, @{u}, @{push},
^{commit}, ^{tree} etc. case-insensitively. All of these cases
currently emit "unknown revision or path not in the working tree"
errors.

This change makes them equivalent to their lower-case versions, and
consistent with other revision format specifications, e.g. 'master@{6
hours ago}', which is equivalent to 'master@{6 HoUrS aGo}'.

The use-case for this is being able to hold the shift key down while
typing @{u} on certain keyboard layouts, which makes the sequence
easier to type, and reduces cases where git throws an error at the
user where it could do what he means instead.

This change was independently authored to scratch a longtime itch, but
when I was about to submit it I discovered that a similar patch had
been submitted unsuccessfully before by Conrad Irwin in August 2011 as
"rev-parse: Allow @{U} as a synonym for @{u}"[1].

The objection from Junio at the time[2] was that by lower-casing
{...}:

    [The door would be closed on] allow[ing] @{/regexp} to find a
    reflog entry that matches the given pattern, and in such a use
    case we would certainly want to take the pattern in a case
    sensitive way.

This appears to be an objection related to the code structure at the
time, but the current code does not conflate the parsing of
@{upstream}, @{push}, ^{tree} etc. with any other @{STRING} or ^{TYPE}
we might add in the future and want to keep case-sensitive.

The new starts_with_case() function is a copy of the existing adjacent
starts_with(), just with a tolower() in the "else if".

The tests for this patch are more exhaustive than in the 2011
submission. The starting point for them was to first change the code
to only support upper-case versions of the existing words, seeing what
broke, and amending the breaking tests to check upper case & mixed
case as appropriate, and where not redundant to other similar tests.

1. <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com>
2. <7vhb5fd4zy.fsf@alter.siamese.dyndns.org>

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/revisions.txt   | 11 ++++++++++-
 git-compat-util.h             |  1 +
 sha1_name.c                   | 12 ++++++------
 strbuf.c                      |  9 +++++++++
 t/t1450-fsck.sh               |  7 +++++++
 t/t1507-rev-parse-upstream.sh | 15 +++++++++++----
 t/t1511-rev-parse-caret.sh    | 13 +++++++++++++
 t/t1514-rev-parse-push.sh     |  8 ++++++--
 8 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index ba11b9c95e..55bde6ea65 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -96,7 +96,8 @@ some output processing may assume ref names in UTF-8.
   refers to the branch that the branch specified by branchname is set to build on
   top of (configured with `branch.<name>.remote` and
   `branch.<name>.merge`).  A missing branchname defaults to the
-  current one.
+  current one. Both '@\{upstream\}', '@\{u\}' are case-insensitive, so e.g.
+  '@\{UPSTREAM\}', '@\{U\}' or '@\{Upstream\}' also work.
 
 '<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
@@ -122,6 +123,9 @@ refs/remotes/myfork/mybranch
 Note in the example that we set up a triangular workflow, where we pull
 from one location and push to another. In a non-triangular workflow,
 '@\{push}' is the same as '@\{upstream}', and there is no need for it.
++
+'@\{push}' is matched case-insensitively, so e.g. '@\{PUSH}' or
+'@\{Push}' also works.
 
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
@@ -158,6 +162,11 @@ it does not have to be dereferenced even once to get to an object.
 +
 'rev{caret}\{tag\}' can be used to ensure that 'rev' identifies an
 existing tag object.
++
+The {caret}{<type>} part is matched case-insensitively. So
+e.g. '{caret}\{commit\}' can be equivalently specified as
+'{caret}\{COMMIT\}', '{caret}\{Commit\}' etc., '{caret}\{tree\}' as
+'{caret}\{TREE\}' and so forth.
 
 '<rev>{caret}{}', e.g. 'v0.99.8{caret}{}'::
   A suffix '{caret}' followed by an empty brace pair
diff --git a/git-compat-util.h b/git-compat-util.h
index e626851fe9..2b3b581a7c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -448,6 +448,7 @@ extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
 extern int starts_with(const char *str, const char *prefix);
+extern int starts_with_case(const char *str, const char *prefix);
 
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
diff --git a/sha1_name.c b/sha1_name.c
index cda9e49b12..8ff215932d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -549,7 +549,7 @@ static inline int at_mark(const char *string, int len,
 	for (i = 0; i < nr; i++) {
 		int suffix_len = strlen(suffix[i]);
 		if (suffix_len <= len
-		    && !memcmp(string, suffix[i], suffix_len))
+		    && !strncasecmp(string, suffix[i], suffix_len))
 			return suffix_len;
 	}
 	return 0;
@@ -821,15 +821,15 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 		return -1;
 
 	sp++; /* beginning of type name, or closing brace for empty */
-	if (starts_with(sp, "commit}"))
+	if (starts_with_case(sp, "commit}"))
 		expected_type = OBJ_COMMIT;
-	else if (starts_with(sp, "tag}"))
+	else if (starts_with_case(sp, "tag}"))
 		expected_type = OBJ_TAG;
-	else if (starts_with(sp, "tree}"))
+	else if (starts_with_case(sp, "tree}"))
 		expected_type = OBJ_TREE;
-	else if (starts_with(sp, "blob}"))
+	else if (starts_with_case(sp, "blob}"))
 		expected_type = OBJ_BLOB;
-	else if (starts_with(sp, "object}"))
+	else if (starts_with_case(sp, "object}"))
 		expected_type = OBJ_ANY;
 	else if (sp[0] == '}')
 		expected_type = OBJ_NONE;
diff --git a/strbuf.c b/strbuf.c
index ace58e7367..d6483381c4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,6 +11,15 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int starts_with_case(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 1;
+		else if (tolower(*str) != tolower(*prefix))
+			return 0;
+}
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 33a51c9a67..b6c1989671 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -505,6 +505,13 @@ test_expect_success 'fsck notices missing tagged object' '
 	test_must_fail git -C missing fsck
 '
 
+test_expect_success 'fsck notices missing tagged object with case insensitive {blob}' '
+	create_repo_missing tag^{BLOB} &&
+	test_must_fail git -C missing fsck &&
+	create_repo_missing tag^{BloB} &&
+	test_must_fail git -C missing fsck
+'
+
 test_expect_success 'fsck notices ref pointing to missing commit' '
 	create_repo_missing HEAD &&
 	test_must_fail git -C missing fsck
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 46ef1f22dc..b23c4e3fab 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -46,11 +46,14 @@ error_message () {
 }
 
 test_expect_success '@{upstream} resolves to correct full name' '
-	test refs/remotes/origin/master = "$(full_name @{upstream})"
+	test refs/remotes/origin/master = "$(full_name @{upstream})" &&
+	test refs/remotes/origin/master = "$(full_name @{UPSTREAM})" &&
+	test refs/remotes/origin/master = "$(full_name @{UpSTReam})"
 '
 
 test_expect_success '@{u} resolves to correct full name' '
-	test refs/remotes/origin/master = "$(full_name @{u})"
+	test refs/remotes/origin/master = "$(full_name @{u})" &&
+	test refs/remotes/origin/master = "$(full_name @{U})"
 '
 
 test_expect_success 'my-side@{upstream} resolves to correct full name' '
@@ -60,6 +63,8 @@ test_expect_success 'my-side@{upstream} resolves to correct full name' '
 test_expect_success 'upstream of branch with @ in middle' '
 	full_name fun@ny@{u} >actual &&
 	echo refs/remotes/origin/side >expect &&
+	test_cmp expect actual &&
+	full_name fun@ny@{U} >actual &&
 	test_cmp expect actual
 '
 
@@ -96,12 +101,14 @@ test_expect_success 'not-tracking@{u} fails' '
 test_expect_success '<branch>@{u}@{1} resolves correctly' '
 	test_commit 6 &&
 	(cd clone && git fetch) &&
-	test 5 = $(commit_subject my-side@{u}@{1})
+	test 5 = $(commit_subject my-side@{u}@{1}) &&
+	test 5 = $(commit_subject my-side@{U}@{1})
 '
 
 test_expect_success '@{u} without specifying branch fails on a detached HEAD' '
 	git checkout HEAD^0 &&
-	test_must_fail git rev-parse @{u}
+	test_must_fail git rev-parse @{u} &&
+	test_must_fail git rev-parse @{U}
 '
 
 test_expect_success 'checkout -b new my-side@{u} forks from the same' '
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e0a49a651f..56750f99c6 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -48,6 +48,10 @@ test_expect_success 'ref^{commit}' '
 	git rev-parse ref >expected &&
 	git rev-parse ref^{commit} >actual &&
 	test_cmp expected actual &&
+	git rev-parse ref^{COMMIT} >actual &&
+	test_cmp expected actual &&
+	git rev-parse ref^{CoMMiT} >actual &&
+	test_cmp expected actual &&
 	git rev-parse commit-tag^{commit} >actual &&
 	test_cmp expected actual &&
 	test_must_fail git rev-parse tree-tag^{commit} &&
@@ -58,6 +62,10 @@ test_expect_success 'ref^{tree}' '
 	echo $TREE_SHA1 >expected &&
 	git rev-parse ref^{tree} >actual &&
 	test_cmp expected actual &&
+	git rev-parse ref^{TREE} >actual &&
+	test_cmp expected actual &&
+	git rev-parse ref^{TrEe} >actual &&
+	test_cmp expected actual &&
 	git rev-parse commit-tag^{tree} >actual &&
 	test_cmp expected actual &&
 	git rev-parse tree-tag^{tree} >actual &&
@@ -67,8 +75,13 @@ test_expect_success 'ref^{tree}' '
 
 test_expect_success 'ref^{tag}' '
 	test_must_fail git rev-parse HEAD^{tag} &&
+	test_must_fail git rev-parse HEAD^{TAG} &&
 	git rev-parse commit-tag >expected &&
 	git rev-parse commit-tag^{tag} >actual &&
+	test_cmp expected actual &&
+	git rev-parse commit-tag^{TAG} >actual &&
+	test_cmp expected actual &&
+	git rev-parse commit-tag^{Tag} >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index 623a32aa6e..788cc91e45 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -24,12 +24,16 @@ test_expect_success 'setup' '
 
 test_expect_success '@{push} with default=nothing' '
 	test_config push.default nothing &&
-	test_must_fail git rev-parse master@{push}
+	test_must_fail git rev-parse master@{push} &&
+	test_must_fail git rev-parse master@{PUSH} &&
+	test_must_fail git rev-parse master@{PuSH}
 '
 
 test_expect_success '@{push} with default=simple' '
 	test_config push.default simple &&
-	resolve master@{push} refs/remotes/origin/master
+	resolve master@{push} refs/remotes/origin/master &&
+	resolve master@{PUSH} refs/remotes/origin/master &&
+	resolve master@{pUSh} refs/remotes/origin/master
 '
 
 test_expect_success 'triangular @{push} fails with default=simple' '
-- 
2.11.0

