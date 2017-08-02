Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB09620899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbdHBTtl (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:41 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36871 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdHBTtd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:33 -0400
Received: by mail-pg0-f45.google.com with SMTP id y129so25100175pgy.4
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edGAalGfJ/wpoQUfbu0LozD9vNOZdk/s1PbRPiuvSbo=;
        b=NUOhYkc4W8+LfCjAVnFqlnacdgCRkzZ4uZHJoXuBfWzD+DdvkcDBxK7mIbX4nBZhW+
         F02jX/h8ftp1IIJFYCXRhvZ9DDQUL5/xL83oL3dOFfv7WyrvzaE3xHq6ThrCfoeT/xZZ
         YrAbKwCPewqo+rjl0QXQTutVqSHvAR19YhAifNRZSvsbTRdn9OO1m0gidYCjpmKc1NgV
         rNqQi/aAlluUmgcKt8qiePp2M8rapE2/JhXiyIeM1UKmUqNtepQPxm1dsfeduKpnPIqB
         K5utwnIkS0toFsgZhy3v8IkD/VxBCWvK746QIMdAgDcRz5dZzU+SX8wrwfeFeFeq9kCH
         PijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edGAalGfJ/wpoQUfbu0LozD9vNOZdk/s1PbRPiuvSbo=;
        b=FNszcjzHAwbMnsoLSupx98JNL1MqHO8h/PDXaFbtZpdPjGORcohK/MbwUT83yiFugE
         qQOn7fktDTMvA8bA7row2Shz3u3I7jHflSR6gPMrXuNLmwAyQ44kqlhhfQevgi0A//q3
         +YrY58vW55Uf/ZnCDe3oqdQtnTWQo+gXkJUkCfPpmENLnwBM0lP8nKN41wkoguvAawSn
         5s0Hr5/z+Y3CxcSP780gxdtLZZbVqocPqkt45844NOfO4MWHtf7U8Sgu7fFNHtguOXsy
         L7U2owc8UoKxA945/yYSBaJHoUj4AqwG7kqs92EzuYJooaULukEPZLI5/Ucd3EUd6JUb
         3YMA==
X-Gm-Message-State: AIVw111Ep+Czm/91WoScq2ZZP1W/jyhvNC7Wdn4yeSbGBx1jwgLAPvYx
        1B9+IU560DX43lEiSwITEw==
X-Received: by 10.84.254.7 with SMTP id b7mr26004236plm.132.1501703372381;
        Wed, 02 Aug 2017 12:49:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:31 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 03/10] cache.h: add GITMODULES_FILE macro
Date:   Wed,  2 Aug 2017 12:49:16 -0700
Message-Id: <20170802194923.88239-4-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170802194923.88239-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
 <20170802194923.88239-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a macro to be used when specifying the '.gitmodules' file and
convert any existing hard coded '.gitmodules' file strings to use the
new macro.

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h        |  1 +
 submodule.c    | 20 ++++++++++----------
 unpack-trees.c |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 71fe09264..d59f767e2 100644
--- a/cache.h
+++ b/cache.h
@@ -433,6 +433,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
+#define GITMODULES_FILE ".gitmodules"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
diff --git a/submodule.c b/submodule.c
index 6531c5d60..64ad5c12d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -63,7 +63,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	struct strbuf entry = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
+	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
 	if (gitmodules_is_unmerged)
@@ -77,7 +77,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	if (git_config_set_in_file_gently(".gitmodules", entry.buf, newpath) < 0) {
+	if (git_config_set_in_file_gently(GITMODULES_FILE, entry.buf, newpath) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), entry.buf);
 		strbuf_release(&entry);
@@ -97,7 +97,7 @@ int remove_path_from_gitmodules(const char *path)
 	struct strbuf sect = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
+	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
 	if (gitmodules_is_unmerged)
@@ -110,7 +110,7 @@ int remove_path_from_gitmodules(const char *path)
 	}
 	strbuf_addstr(&sect, "submodule.");
 	strbuf_addstr(&sect, submodule->name);
-	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
+	if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
 		strbuf_release(&sect);
@@ -122,7 +122,7 @@ int remove_path_from_gitmodules(const char *path)
 
 void stage_updated_gitmodules(void)
 {
-	if (add_file_to_cache(".gitmodules", 0))
+	if (add_file_to_cache(GITMODULES_FILE, 0))
 		die(_("staging updated .gitmodules failed"));
 }
 
@@ -230,21 +230,21 @@ void gitmodules_config(void)
 		struct strbuf gitmodules_path = STRBUF_INIT;
 		int pos;
 		strbuf_addstr(&gitmodules_path, work_tree);
-		strbuf_addstr(&gitmodules_path, "/.gitmodules");
+		strbuf_addstr(&gitmodules_path, "/" GITMODULES_FILE);
 		if (read_cache() < 0)
 			die("index file corrupt");
-		pos = cache_name_pos(".gitmodules", 11);
+		pos = cache_name_pos(GITMODULES_FILE, 11);
 		if (pos < 0) { /* .gitmodules not found or isn't merged */
 			pos = -1 - pos;
 			if (active_nr > pos) {  /* there is a .gitmodules */
 				const struct cache_entry *ce = active_cache[pos];
 				if (ce_namelen(ce) == 11 &&
-				    !memcmp(ce->name, ".gitmodules", 11))
+				    !memcmp(ce->name, GITMODULES_FILE, 11))
 					gitmodules_is_unmerged = 1;
 			}
 		} else if (pos < active_nr) {
 			struct stat st;
-			if (lstat(".gitmodules", &st) == 0 &&
+			if (lstat(GITMODULES_FILE, &st) == 0 &&
 			    ce_match_stat(active_cache[pos], &st, 0) & DATA_CHANGED)
 				gitmodules_is_modified = 1;
 		}
@@ -264,7 +264,7 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 
 void repo_read_gitmodules(struct repository *repo)
 {
-	char *gitmodules_path = repo_worktree_path(repo, ".gitmodules");
+	char *gitmodules_path = repo_worktree_path(repo, GITMODULES_FILE);
 
 	git_config_from_file(gitmodules_cb, gitmodules_path, repo);
 	free(gitmodules_path);
diff --git a/unpack-trees.c b/unpack-trees.c
index dd535bc84..05335fe5b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -286,7 +286,7 @@ static void reload_gitmodules_file(struct index_state *index,
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 		if (ce->ce_flags & CE_UPDATE) {
-			int r = strcmp(ce->name, ".gitmodules");
+			int r = strcmp(ce->name, GITMODULES_FILE);
 			if (r < 0)
 				continue;
 			else if (r == 0) {
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

