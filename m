Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D79B20802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbdFVVi0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:38:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33339 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753655AbdFVViZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:38:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id x23so7820153wrb.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqiVI7qU4qrAV6o/18XzO0vZt9zJrlMV9mUTRlK9cbY=;
        b=lw8x6vyakARyKdHkgO2YoQYC3AwRe5eZPh8TLrCweSaap74UzqxHzcvnTfXyMxnXQV
         NI+bmgo39euEamJwZhATuY4m3jBqnJSN9svBWWXE5c87ibUyXcPCpQAWuKk6RBz9qGPH
         1fiDeO3JLIQPzspcTpBSTzbHa8hioGKg+gZzD318UWJgXBwuLH1e8xIxvn2YeClRmHcF
         y5Q08TNgzUUQrytC0KPmmbNOB3kWs9czG+1x/ovbhjgcR9wtMKC/Vcf1CnbiZf4Yombk
         34GYNfhVrG+1CuyZBPYE4tAx8T6uMaQUcEdLinQNR4TWCqrCzixbML9HliT/zGn2Npnn
         vNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqiVI7qU4qrAV6o/18XzO0vZt9zJrlMV9mUTRlK9cbY=;
        b=o2E+ipKC8xJyjmaMZZ/IBtaVv1ekbZ9CQqr5hNu8aYx9AHIHbRIoqvnumGKPcsXUab
         BJoiGjA3P2ZVwT6lUatMI/bhtNNvt67EbQX8BKpQNFaF0iBIqezJ6KOrmboiqCZrWOZ5
         vg9JJLpXkbA44YoCwE0gBzTQv2UA5zozgbflAGun3hhoAFCl6rPXTdbwW0zBoH5cQAUs
         CHQVuej5vcLfUMVyVmj5Lk10njAFPCM2e+HGkQg0c/6k+m4XBxGK1GB4MLMn4ekXrUhy
         po3x9S1KTTZvB7T4cIgP3V4b9BC/tRx2bAwF7vgys5OwuqRUqcCgmq4RnX/dWRN6Jtho
         j0xA==
X-Gm-Message-State: AKS2vOzDXK84JzRqja3Q/jnvx5ZmxE4t2bBxDfwruh4cJ4CQNj7j2bxM
        /KXhkSF0tsygq/JpihY=
X-Received: by 10.80.136.110 with SMTP id c43mr3853445edc.171.1498167503186;
        Thu, 22 Jun 2017 14:38:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w26sm1404966edw.28.2017.06.22.14.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 14:38:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] wildmatch: remove unused wildopts parameter
Date:   Thu, 22 Jun 2017 21:38:08 +0000
Message-Id: <20170622213810.14785-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170622213810.14785-1-avarab@gmail.com>
References: <20170622213810.14785-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the unused wildopts placeholder struct from being passed to all
wildmatch() invocations, or rather remove all the boilerplate NULL
parameters.

This parameter was added back in commit 9b3497cab9 ("wildmatch: rename
constants and update prototype", 2013-01-01) as a placeholder for
future use. Over 4 years later nothing has made use of it, let's just
remove it. It can be added in the future if we find some reason to
start using such a parameter.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c                   | 2 +-
 builtin/describe.c        | 4 ++--
 builtin/ls-remote.c       | 2 +-
 builtin/name-rev.c        | 2 +-
 builtin/reflog.c          | 2 +-
 builtin/replace.c         | 2 +-
 builtin/show-branch.c     | 2 +-
 config.c                  | 2 +-
 diffcore-order.c          | 2 +-
 dir.c                     | 8 +++-----
 ref-filter.c              | 4 ++--
 refs.c                    | 2 +-
 revision.c                | 2 +-
 t/helper/test-wildmatch.c | 6 +++---
 wildmatch.c               | 3 +--
 wildmatch.h               | 6 +-----
 16 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/apply.c b/apply.c
index 854faa6779..cc3278978a 100644
--- a/apply.c
+++ b/apply.c
@@ -2088,7 +2088,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	/* See if it matches any of exclude/include rule */
 	for (i = 0; i < state->limit_by_name.nr; i++) {
 		struct string_list_item *it = &state->limit_by_name.items[i];
-		if (!wildmatch(it->string, pathname, 0, NULL))
+		if (!wildmatch(it->string, pathname, 0))
 			return (it->util != NULL);
 	}
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 893c8789f4..2fe05f5324 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -142,7 +142,7 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 			return 0;
 
 		for_each_string_list_item(item, &exclude_patterns) {
-			if (!wildmatch(item->string, path + 10, 0, NULL))
+			if (!wildmatch(item->string, path + 10, 0))
 				return 0;
 		}
 	}
@@ -158,7 +158,7 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 			return 0;
 
 		for_each_string_list_item(item, &patterns) {
-			if (!wildmatch(item->string, path + 10, 0, NULL))
+			if (!wildmatch(item->string, path + 10, 0))
 				break;
 
 			/* If we get here, no pattern matched. */
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index b2d7d5ce68..c4be98ab9e 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -24,7 +24,7 @@ static int tail_match(const char **pattern, const char *path)
 
 	pathbuf = xstrfmt("/%s", path);
 	while ((p = *(pattern++)) != NULL) {
-		if (!wildmatch(p, pathbuf, 0, NULL)) {
+		if (!wildmatch(p, pathbuf, 0)) {
 			free(pathbuf);
 			return 1;
 		}
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7fc7e66e85..d21a5002a7 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -129,7 +129,7 @@ static int subpath_matches(const char *path, const char *filter)
 	const char *subpath = path;
 
 	while (subpath) {
-		if (!wildmatch(filter, subpath, 0, NULL))
+		if (!wildmatch(filter, subpath, 0))
 			return subpath - path;
 		subpath = strchr(subpath, '/');
 		if (subpath)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 920c16dac0..96c82b4f5e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -485,7 +485,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 		return; /* both given explicitly -- nothing to tweak */
 
 	for (ent = reflog_expire_cfg; ent; ent = ent->next) {
-		if (!wildmatch(ent->pattern, ref, 0, NULL)) {
+		if (!wildmatch(ent->pattern, ref, 0)) {
 			if (!(slot & EXPIRE_TOTAL))
 				cb->expire_total = ent->expire_total;
 			if (!(slot & EXPIRE_UNREACH))
diff --git a/builtin/replace.c b/builtin/replace.c
index c921bc976f..89262df5a1 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -40,7 +40,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 {
 	struct show_data *data = cb_data;
 
-	if (!wildmatch(data->pattern, refname, 0, NULL)) {
+	if (!wildmatch(data->pattern, refname, 0)) {
 		if (data->format == REPLACE_FORMAT_SHORT)
 			printf("%s\n", refname);
 		else if (data->format == REPLACE_FORMAT_MEDIUM)
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4a6cc6f490..bfce303cf9 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -444,7 +444,7 @@ static int append_matching_ref(const char *refname, const struct object_id *oid,
 			slash--;
 	if (!*tail)
 		return 0;
-	if (wildmatch(match_ref_pattern, tail, 0, NULL))
+	if (wildmatch(match_ref_pattern, tail, 0))
 		return 0;
 	if (starts_with(refname, "refs/heads/"))
 		return append_head_ref(refname, oid, flag, cb_data);
diff --git a/config.c b/config.c
index 34a139c40b..260caf27b8 100644
--- a/config.c
+++ b/config.c
@@ -245,7 +245,7 @@ static int include_by_gitdir(const struct config_options *opts,
 	}
 
 	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
-			 icase ? WM_CASEFOLD : 0, NULL);
+			 icase ? WM_CASEFOLD : 0);
 
 	if (!ret && !already_tried_absolute) {
 		/*
diff --git a/diffcore-order.c b/diffcore-order.c
index 1957f822a5..19e73311f9 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -67,7 +67,7 @@ static int match_order(const char *path)
 		strbuf_addstr(&p, path);
 		while (p.buf[0]) {
 			char *cp;
-			if (!wildmatch(order[i], p.buf, 0, NULL))
+			if (!wildmatch(order[i], p.buf, 0))
 				return i;
 			cp = strrchr(p.buf, '/');
 			if (!cp)
diff --git a/dir.c b/dir.c
index 1759063817..544056b37a 100644
--- a/dir.c
+++ b/dir.c
@@ -82,13 +82,11 @@ int git_fnmatch(const struct pathspec_item *item,
 	if (item->magic & PATHSPEC_GLOB)
 		return wildmatch(pattern, string,
 				 WM_PATHNAME |
-				 (item->magic & PATHSPEC_ICASE ? WM_CASEFOLD : 0),
-				 NULL);
+				 (item->magic & PATHSPEC_ICASE ? WM_CASEFOLD : 0));
 	else
 		/* wildmatch has not learned no FNM_PATHNAME mode yet */
 		return wildmatch(pattern, string,
-				 item->magic & PATHSPEC_ICASE ? WM_CASEFOLD : 0,
-				 NULL);
+				 item->magic & PATHSPEC_ICASE ? WM_CASEFOLD : 0);
 }
 
 static int fnmatch_icase_mem(const char *pattern, int patternlen,
@@ -112,7 +110,7 @@ static int fnmatch_icase_mem(const char *pattern, int patternlen,
 
 	if (ignore_case)
 		flags |= WM_CASEFOLD;
-	match_status = wildmatch(use_pat, use_str, flags, NULL);
+	match_status = wildmatch(use_pat, use_str, flags);
 
 	strbuf_release(&pat_buf);
 	strbuf_release(&str_buf);
diff --git a/ref-filter.c b/ref-filter.c
index ab32bc9c31..718def443a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1624,7 +1624,7 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
 	       skip_prefix(refname, "refs/", &refname));
 
 	for (; *patterns; patterns++) {
-		if (!wildmatch(*patterns, refname, flags, NULL))
+		if (!wildmatch(*patterns, refname, flags))
 			return 1;
 	}
 	return 0;
@@ -1655,7 +1655,7 @@ static int match_name_as_path(const struct ref_filter *filter, const char *refna
 		     refname[plen] == '/' ||
 		     p[plen-1] == '/'))
 			return 1;
-		if (!wildmatch(p, refname, WM_PATHNAME, NULL))
+		if (!wildmatch(p, refname, WM_PATHNAME))
 			return 1;
 	}
 	return 0;
diff --git a/refs.c b/refs.c
index f0685c9251..32626a4cd1 100644
--- a/refs.c
+++ b/refs.c
@@ -229,7 +229,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 
-	if (wildmatch(filter->pattern, refname, 0, NULL))
+	if (wildmatch(filter->pattern, refname, 0))
 		return 0;
 	return filter->fn(refname, oid, flags, filter->cb_data);
 }
diff --git a/revision.c b/revision.c
index 12eb332350..dc075f0e48 100644
--- a/revision.c
+++ b/revision.c
@@ -1142,7 +1142,7 @@ int ref_excluded(struct string_list *ref_excludes, const char *path)
 	if (!ref_excludes)
 		return 0;
 	for_each_string_list_item(item, ref_excludes) {
-		if (!wildmatch(item->string, path, 0, NULL))
+		if (!wildmatch(item->string, path, 0))
 			return 1;
 	}
 	return 0;
diff --git a/t/helper/test-wildmatch.c b/t/helper/test-wildmatch.c
index 52be876fed..921d7b3e7e 100644
--- a/t/helper/test-wildmatch.c
+++ b/t/helper/test-wildmatch.c
@@ -11,11 +11,11 @@ int cmd_main(int argc, const char **argv)
 			argv[i] += 3;
 	}
 	if (!strcmp(argv[1], "wildmatch"))
-		return !!wildmatch(argv[3], argv[2], WM_PATHNAME, NULL);
+		return !!wildmatch(argv[3], argv[2], WM_PATHNAME);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return !!wildmatch(argv[3], argv[2], WM_PATHNAME | WM_CASEFOLD, NULL);
+		return !!wildmatch(argv[3], argv[2], WM_PATHNAME | WM_CASEFOLD);
 	else if (!strcmp(argv[1], "pathmatch"))
-		return !!wildmatch(argv[3], argv[2], 0, NULL);
+		return !!wildmatch(argv[3], argv[2], 0);
 	else
 		return 1;
 }
diff --git a/wildmatch.c b/wildmatch.c
index 57c8765805..d074c1be10 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -272,8 +272,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 }
 
 /* Match the "pattern" against the "text" string. */
-int wildmatch(const char *pattern, const char *text,
-	      unsigned int flags, struct wildopts *wo)
+int wildmatch(const char *pattern, const char *text, unsigned int flags)
 {
 	return dowild((const uchar*)pattern, (const uchar*)text, flags);
 }
diff --git a/wildmatch.h b/wildmatch.h
index 4090c8f4bb..b8c826aa68 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -10,9 +10,5 @@
 #define WM_ABORT_ALL -1
 #define WM_ABORT_TO_STARSTAR -2
 
-struct wildopts;
-
-int wildmatch(const char *pattern, const char *text,
-	      unsigned int flags,
-	      struct wildopts *wo);
+int wildmatch(const char *pattern, const char *text, unsigned int flags);
 #endif
-- 
2.13.1.611.g7e3b11ae1

