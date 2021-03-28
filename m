Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F7BC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768B06193F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhC1P0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhC1P0i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 11:26:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DA8C061756
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:26:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b9so10327212wrt.8
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rp832ALkVL8HwKvuF2fZ0VxRom3ULNI8oPQLxi/c66U=;
        b=cSE9B6muPuUXe8qBAjrI4yeR4d/xtBa1povY7/tkuz3aDkVsrc62B8dWbgrdGN1/i/
         W8gy6Gj+kbV9EBj2lgyukinyqqkaCU6jxTr9YmfQG440nKnrexP+fjWhAkqprU9HLWSb
         Q86txpKcPUePjSWspSH8Ezd6vIcEt+jzWUqveSItWBlZ7YwKde16ti0kQoxhuRwo8MTi
         T2BXk9nQKUwyg7w8rDm5/oLTg6mtx3GnP0/NXbEyIVJXA3qkyScgGch9Uzf1QixI8DYh
         CyM1Ba2lkN+dq15nOQcdHxO9KNE/lMMdSwi8L1Ywdxwl+oKQsA7GyqhpiKOBi1JKeVxO
         Sk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rp832ALkVL8HwKvuF2fZ0VxRom3ULNI8oPQLxi/c66U=;
        b=Ps2CMGhIr60ihzBm2eK224uzSxjq2TCaxpu6nA2vh5cPKi/A9BRu9pJT2mu0gKOKPK
         PM2yjhVH89KaSNBV2hKXQ831WsgLclFJstfTVHQ2XfdortabUSZZs8GruLmwqRZi3JX7
         6nkSduk0n7jlYb0uviTRmzjMtYP3Ia/3WNJgbAiGYXsGF6dlwyfJskOu7Tlf43Zcj3NH
         pEMyfOwEHWra7cRFSxSDZYTfNV8MmIGPkTQqalBVByU37yIP9mXGWiQJGlAtl5WnRUsv
         dgaVwTYoo5qavYtad5EcYbDrJ4WxXvQk4yVOJCEiGbPJtWq4KJWVMH7jHUKzXzct0Tol
         jh7g==
X-Gm-Message-State: AOAM530Vp84w5kD2a+SUqO0jJL7PprQylpRQ2vSVAeLb1YZapRGUJclu
        Si69PpAQb0mJ+GXtCmvEIos144BkQs4/7MgpX9Q=
X-Google-Smtp-Source: ABdhPJxEAS11ySNzQzx839wR8SilqvRpIXFX4JXpTXlN+mFzCx+feHO3OMn9Nvx6RcdNApjTWlRVhA==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr24118175wrq.60.1616945195954;
        Sun, 28 Mar 2021 08:26:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a302:a800:1d6d:c581:cf0b:2ca7])
        by smtp.googlemail.com with ESMTPSA id s8sm24814538wrn.97.2021.03.28.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 08:26:35 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com, stdedos+git@gmail.com,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [RFC PATCH v1 3/3] squash! fixup! pathspec: warn: long and short forms are incompatible
Date:   Sun, 28 Mar 2021 18:26:29 +0300
Message-Id: <20210328152629.16486-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326024005.26962-3-stdedos+git@gmail.com>
References: <20210326024005.26962-3-stdedos+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Attempt to force parsing long magic values to detect if
there is actually long magic present or not.

Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
---
 pathspec.c                  | 35 +++++++++++++++++++----------------
 pathspec.h                  |  2 +-
 t/t6132-pathspec-exclude.sh |  4 ++--
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 857519fda4..447d765112 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -389,9 +389,11 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
 	else if (elem[1] == '(')
 		/* longhand */
 		return parse_long_magic(magic, prefix_len, item, elem);
-	else
+	else {
 		/* shorthand */
+		check_mixed_short_and_long_magic(elem);
 		return parse_short_magic(magic, elem);
+	}
 }
 
 /*
@@ -589,8 +591,6 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		entry = argv[i];
 
-		check_mishandled_exclude(entry);
-
 		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
 
 		if (item[i].magic & PATHSPEC_EXCLUDE)
@@ -745,21 +745,24 @@ int match_pathspec_attrs(const struct index_state *istate,
 	return 1;
 }
 
-void check_mishandled_exclude(const char *entry) {
-	char *flags, *path;
-	size_t entry_len = strlen(entry);
+void check_mixed_short_and_long_magic(const char *entry) {
+	const char *parsed_magic;
 
-	flags = xstrdup(entry);
-	memset(flags, '\0', entry_len);
-	path = xstrdup(entry);
-	memset(path, '\0', entry_len);
+	/* skip past stuff we know must be there */
+	if (!skip_prefix(entry, ":", &entry)) {
+		return;
+	}
+
+	/* Throwaway allocations */
+	unsigned magic = 0;
+	int prefix_len = -1;
+	struct pathspec_item *item;
+	item = xmallocz(sizeof(&item));
 
-	if (sscanf(entry, ":!(%4096[^)])%4096s", flags, path) == 2) {
-		if (count_slashes(flags) == 0) {
-			warning(_("Pathspec provided matches `:!(...)`\n\tDid you mean `:(exclude,...)`?"));
-		}
+	parsed_magic = parse_long_magic(&magic, &prefix_len, item, entry);
+	if (entry != parsed_magic) {
+		warning(_("Pathspec provided matches both short and long forms.\nShort forms take presedence over long forms!"));
 	}
 
-	FREE_AND_NULL(flags);
-	FREE_AND_NULL(path);
+	FREE_AND_NULL(item);
 }
diff --git a/pathspec.h b/pathspec.h
index 879d4e82c6..af6c458a06 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -157,6 +157,6 @@ char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
-void check_mishandled_exclude(const char* pathspec_entry);
+void check_mixed_short_and_long_magic(const char* pathspec_entry);
 
 #endif /* PATHSPEC_H */
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index b32ddb2a56..a1580a89ae 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -245,7 +245,7 @@ test_expect_success 'grep --untracked PATTERN :(exclude)*FILE' '
 '
 
 cat > expected_warn <<"EOF"
-Pathspec provided matches `:!(...)`
+Pathspec provided matches both short and long forms.
 EOF
 test_expect_success 'warn pathspec :!(...) skips the parenthesized magics' '
 	git log --oneline --format=%s -- '"'"':!(glob)**/file'"'"' >actual 2>warn &&
@@ -263,7 +263,7 @@ EOF
 	grep -Ff expected_warn warn
 '
 
-test_expect_success 'do not warn that pathspec :!(...) skips the parenthesized magics (if parenthesis would not be part of the magic)' '
+test_expect_success 'do not warn that pathspec :!(...) skips the parenthesized magics (if parenthesized text would not be magic)' '
 	git log --oneline --format=%s -- '"'"':!(gl/ob)/file'"'"' >actual 2>warn &&
 	cat <<EOF >expect &&
 sub2/file
-- 
2.31.0

