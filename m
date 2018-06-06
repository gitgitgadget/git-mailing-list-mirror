Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7493C1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 16:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbeFFQuf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 12:50:35 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34997 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933488AbeFFQue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 12:50:34 -0400
Received: by mail-lf0-f51.google.com with SMTP id y72-v6so10163919lfd.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUQle/3SPmgSEqGSL8iZpbXw3n/BqL1+omgZH6OfnMA=;
        b=ZFzwvCczc5xcm4DWnKdbuuglCWIPXrDBizAWau3TuliIwXXiY/kl7Arb7a9Hta+a7p
         iMMYXvO4XcbEA5HNP2Ds/XTcdaSyOTxHQuU4KQ7mpbPChlsPVKUwfT9vfs3ijrKXUF5q
         iDCaR0+8rGangh4zOYyVxXso5Ay8PzQqXDZEkMyxWz6TDCpq6TqEH92MZa3qEMwZPdHz
         bJNT8SGaBPiQHRxU5Pb20APqlsUIird6yadkA2WMhjPCjDoSK7wqbCzaBjB5foVlFHXJ
         4+EkPhEosOpOmqs5pK2u147By3tkC2upHPsQK+vFUge1zH3np7IrbKXVJtjpb+AVs777
         Fvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUQle/3SPmgSEqGSL8iZpbXw3n/BqL1+omgZH6OfnMA=;
        b=F8kXqffxniDy2jitwn2VJphBWj2MGcbuHyd8oVDXaBvfwex04RyR+mlSpxAMk5kheg
         Jcf0gFAhJVrpOT4gjxIVmf3li41GIZ2oXRKuH5KxCKHDHaoNHWgKRqXTFZY9CW8Di26C
         d8jZZPyp6quChVPGOTgdraMvM0dH27TrUjkcTZW6W5Ww9ebAAdSQIxVcTACHZJWlT0Av
         njWmAr+VoCaDs6giaUX1UIte/NQYmKFXXJ1OwnghoQqtVdOfT8bH8sEUWYWP5X3OBwbG
         VsI1mJhTdZmmx5avKvsFiXTH95NUYWfKRfXyTD9tcopXq22jTu5remv/31G1awSdd5Qv
         laXA==
X-Gm-Message-State: APt69E04rNpLGWmOfjTlcWtMwxaAeVScvDKosc6/GRt5Qj8j0C+A2+La
        iZZfoy8HW3obs960fFlzkJTkpA==
X-Google-Smtp-Source: ADUXVKKfTsvoHsjw4syJ0EUZDWOBE84NTIBHzLCd96XTCHr6DCMzWK9TnU1QkXZ4CyCHiTuDH3FVdg==
X-Received: by 2002:a2e:9744:: with SMTP id f4-v6mr2614592ljj.5.1528303832404;
        Wed, 06 Jun 2018 09:50:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y6-v6sm909489ljc.67.2018.06.06.09.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 09:50:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 00/23] Fix incorrect use of the_index
Date:   Wed,  6 Jun 2018 18:49:53 +0200
Message-Id: <20180606165016.3285-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 fixes some commit messages and killed a couple more the_index
references after I tried to merge this with 'pu'

diff --git a/apply.c b/apply.c
index 811ff2ad5e..82f681972f 100644
--- a/apply.c
+++ b/apply.c
@@ -4090,9 +4090,9 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			return error(_("sha1 information is lacking or useless "
 				       "(%s)."), name);
 
-		ce = make_cache_entry(&the_index, patch->old_mode, oid.hash, name, 0, 0);
+		ce = make_index_entry(&result, patch->old_mode, oid.hash, name, 0, 0);
 		if (!ce)
-			return error(_("make_cache_entry failed for path '%s'"),
+			return error(_("make_index_entry failed for path '%s'"),
 				     name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
 			free(ce);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3c8218304e..4dbcab3727 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -230,9 +230,9 @@ static int checkout_merged(int pos, const struct checkout *state)
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce = make_cache_entry(&the_index, mode, oid.hash, path, 2, 0);
+	ce = make_index_entry(state->istate, mode, oid.hash, path, 2, 0);
 	if (!ce)
-		die(_("make_cache_entry failed for path '%s'"), path);
+		die(_("make_index_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
 	free(ce);
 	return status;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index e34e75a42d..c7d6296762 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -321,7 +321,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(&the_index, mode, oid->hash, path, 0, 0);
+	ce = make_index_entry(state->istate, mode, oid->hash, path, 0, 0);
 	ret = checkout_entry(ce, state, NULL);
 
 	free(ce);
@@ -488,7 +488,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				 * index.
 				 */
 				struct cache_entry *ce2 =
-					make_cache_entry(&the_index, rmode, roid.hash,
+					make_index_entry(&wtindex, rmode, roid.hash,
 							 dst_path, 0, 0);
 
 				add_index_entry(&wtindex, ce2,
diff --git a/builtin/reset.c b/builtin/reset.c
index 0ea0a19d5e..067f535031 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -134,10 +134,10 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 			continue;
 		}
 
-		ce = make_cache_entry(&the_index, one->mode, one->oid.hash, one->path,
+		ce = make_index_entry(&the_index, one->mode, one->oid.hash, one->path,
 				      0, 0);
 		if (!ce)
-			die(_("make_cache_entry failed for path '%s'"),
+			die(_("make_index_entry failed for path '%s'"),
 			    one->path);
 		if (is_missing) {
 			ce->ce_flags |= CE_INTENT_TO_ADD;
diff --git a/cache.h b/cache.h
index 242aaa5498..eb8c79b8a1 100644
--- a/cache.h
+++ b/cache.h
@@ -699,7 +699,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
 
-extern struct cache_entry *make_cache_entry(struct index_state *istate,unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
+extern struct cache_entry *make_index_entry(struct index_state *istate, unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
 extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
diff --git a/merge-recursive.c b/merge-recursive.c
index 9280deb6a1..4f054d6dbb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -315,7 +315,7 @@ static int add_cacheinfo(struct merge_options *o,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(&the_index, mode, oid ? oid->hash : null_sha1, path, stage, 0);
+	ce = make_index_entry(&the_index, mode, oid ? oid->hash : null_sha1, path, stage, 0);
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
diff --git a/read-cache.c b/read-cache.c
index c083318aa7..4352aac521 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -745,7 +745,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
 	return add_to_index(istate, path, &st, flags);
 }
 
-struct cache_entry *make_cache_entry(struct index_state *istate,
+struct cache_entry *make_index_entry(struct index_state *istate,
 				     unsigned int mode,
 				     const unsigned char *sha1,
 				     const char *path, int stage,
diff --git a/resolve-undo.c b/resolve-undo.c
index a4918546c3..2377995d6d 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -147,7 +147,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
-		nce = make_cache_entry(istate, ru->mode[i], ru->oid[i].hash,
+		nce = make_index_entry(istate, ru->mode[i], ru->oid[i].hash,
 				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |= CE_MATCHED;

Nguyễn Thái Ngọc Duy (23):
  unpack-trees: remove 'extern' on function declaration
  unpack-trees: add a note about path invalidation
  unpack-trees: don't shadow global var the_index
  unpack-tress: convert clear_ce_flags* to avoid the_index
  unpack-trees: avoid the_index in verify_absent()
  attr.h: drop extern from function declaration
  attr: remove an implicit dependency on the_index
  convert.h: drop 'extern' from function declaration
  convert.c: remove an implicit dependency on the_index
  dir.c: remove an implicit dependency on the_index in pathspec code
  ls-files: correct index argument to get_convert_attr_ascii()
  pathspec.c: use the right index instead of the_index
  submodule.c: use the right index instead of the_index
  entry.c: use the right index instead of the_index
  attr: remove index from git_attr_set_direction()
  preload-index.c: use the right index instead of the_index
  read-cache.c: remove an implicit dependency on the_index
  apply.c: use the right index instead of the_index
  difftool: use the right index instead of the_index
  checkout: avoid the_index when possible
  resolve-undo.c: use the right index instead of the_index
  grep: use the right index instead of the_index
  cache.h: make the_index part of "compatibility macros"

 apply.c                     |  6 ++--
 archive.c                   |  8 ++---
 attr.c                      | 52 ++++++++++++++++++-------------
 attr.h                      | 31 ++++++++++---------
 builtin/add.c               |  6 ++--
 builtin/cat-file.c          |  2 +-
 builtin/check-attr.c        |  6 ++--
 builtin/checkout-index.c    |  1 +
 builtin/checkout.c          |  6 ++--
 builtin/clean.c             |  2 +-
 builtin/commit.c            |  2 +-
 builtin/difftool.c          |  4 +--
 builtin/grep.c              |  6 ++--
 builtin/ls-files.c          | 17 ++++++-----
 builtin/pack-objects.c      |  2 +-
 builtin/reset.c             |  4 +--
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 builtin/update-index.c      |  2 +-
 cache.h                     |  9 +++---
 convert.c                   | 41 ++++++++++++++-----------
 convert.h                   | 61 +++++++++++++++++++++----------------
 diff-lib.c                  |  4 +--
 diff.c                      |  2 +-
 dir.c                       | 27 +++++++++-------
 dir.h                       | 16 ++++++----
 entry.c                     | 10 +++---
 ll-merge.c                  |  4 +--
 merge-recursive.c           |  4 +--
 pathspec.c                  |  2 +-
 preload-index.c             |  3 +-
 read-cache.c                | 19 +++++++-----
 rerere.c                    |  2 +-
 resolve-undo.c              |  5 +--
 revision.c                  |  2 +-
 sha1-file.c                 |  4 +--
 submodule.c                 |  8 ++---
 unpack-trees.c              | 57 +++++++++++++++++++++-------------
 unpack-trees.h              |  4 +--
 userdiff.c                  |  2 +-
 ws.c                        |  2 +-
 wt-status.c                 |  6 ++--
 42 files changed, 258 insertions(+), 197 deletions(-)

-- 
2.18.0.rc0.333.g22e6ee6cdf

