Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11156208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 19:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390138AbeHGVRI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 17:17:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40317 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389561AbeHGVRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 17:17:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19-v6so14279603ljc.7
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Chrts0DKk6/EDo+zUS46ON8qkNG1ltL+9qrGqRaMmC8=;
        b=qpLDR+WUXXufMTtk+dzhz4E5yj4l2X9hwsEBxu33IBZ/fOE4wybWZ99Q1fg5/Pv0dO
         cbPLZ1G0bpu/OyIZnGYhMF39hOATcrFmfHdzKKghjQyECyQTMjXv/HnD6isOjMKt8ZLk
         OqloONuWlQqPWBXb/nGJ1ptKHk8DatJMQ4w3AUMxWFwiDesReaGZYlPotiAmq8BbCMP1
         ixSAdiLxZRIt6BVCtX7NP29sN7mlghvZVXILN/nxovFrZQb8g5kORo17cimRFwSRS8O5
         h0WF+6qnIDZiox8FmMfgQmghjdChCIuvZM9XqYW5Q8wKUnNIZtprNnhrqwuAmFVNezAX
         f33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Chrts0DKk6/EDo+zUS46ON8qkNG1ltL+9qrGqRaMmC8=;
        b=FukmUp3ypwUxX4LdIyima38a5dn+/VdPAeRIVDHT+m/azqNMbqHrLyR/kKUV0Tadd1
         k93WEHSuNDRh6ygSL8VEyrFpzsbdQ6ovl//AYluZf5FHI8O0WWGw3oGQCgsfVp3YeRib
         uRysVEl/B26QVl9XjwXB25e0qMe2Om8RrmhFdC4v1QfUjh9Uv3TrLLqpdkLhjxAAHpSU
         ds/sQjZ1BPKGlK0zIcGuV4P4YxIIpadFYjeDssJk7qdx8EOVbZI6/HuAHE9r/i6cpbBN
         IFXGX7yC+0PitkDl/ZEN375Y7Su13GetcF+x/MIu8R0xQ+qHhgP28VLuEOqo865/y31Q
         AwhA==
X-Gm-Message-State: AOUpUlGKDfY10atFm38QttgHY7MZaqu6L45ue1HYknuWbt5MlM3kqYt5
        SC85AVrgiXRcsnu01X8/Kj0=
X-Google-Smtp-Source: AAOMgpfVPba1lZu3MTEmIh9yRmPFpi4JScvLXyq73IFGmoaJT/pW3FoMSIpnrUcYrVwb2CYDHq+MRg==
X-Received: by 2002:a2e:84c6:: with SMTP id q6-v6mr17445139ljh.65.1533668480935;
        Tue, 07 Aug 2018 12:01:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm407787lfl.1.2018.08.07.12.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 12:01:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Elijah Newren <newren@gmail.com>,
        tboegi@web.de, Junio C Hamano <gitster@pobox.com>,
        git@jeffhostetler.com
Subject: [PATCH v2] clone: report duplicate entries on case-insensitive filesystems
Date:   Tue,  7 Aug 2018 21:01:10 +0200
Message-Id: <20180807190110.16216-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.915.gd571298aae
In-Reply-To: <20180730152756.15012-1-pclouds@gmail.com>
References: <20180730152756.15012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paths that only differ in case work fine in a case-sensitive
filesystems, but if those repos are cloned in a case-insensitive one,
you'll get problems. The first thing to notice is "git status" will
never be clean with no indication what exactly is "dirty".

This patch helps the situation a bit by pointing out the problem at
clone time. Even though this patch talks about case sensitivity, the
patch makes no assumption about folding rules by the filesystem. It
simply observes that if an entry has been already checked out at clone
time when we're about to write a new path, some folding rules are
behind this.

I do not make any suggestions to fix or workaround the problem because
there are many different options, especially when the problem comes
from folding rules other than case (e.g. UTF-8 normalization, Windows
special paths...)

In the previous iteration, inode has been suggested to find the
matching entry. But it is platform specific, and because we already
have a common function for matching stat, the function is used here
even if it's more expensive. Bonus point is we don't need some "#ifdef
platform" around this code.

The cost goes higher when we find duplicated entries at the bottom of
the index, but the number of these entries should be very small that
total extra cost should not be really noticeable.

This patch is tested with vim-colorschemes repository on a JFS partion
with case insensitive support on Linux. This repository has two files
darkBlue.vim and darkblue.vim.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 has completely different approach so no point in sending
 interdiff.

 One nice thing about this is we don't need platform specific code for
 detecting the duplicate entries. I think ce_match_stat() works even
 on Windows. And it's now equally expensive on all platforms :D

 builtin/clone.c |  1 +
 cache.h         |  2 ++
 entry.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c  | 23 +++++++++++++++++++++++
 unpack-trees.h  |  1 +
 5 files changed, 71 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9ebb5acf56..38d5609282 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -748,6 +748,7 @@ static int checkout(int submodule_progress)
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
 	opts.merge = 1;
+	opts.clone = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/cache.h b/cache.h
index 8dc7134f00..cdf0984707 100644
--- a/cache.h
+++ b/cache.h
@@ -1515,9 +1515,11 @@ struct checkout {
 	const char *base_dir;
 	int base_dir_len;
 	struct delayed_checkout *delayed_checkout;
+	int *nr_duplicates;
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
+		 clone:1,
 		 refresh_cache:1;
 };
 #define CHECKOUT_INIT { NULL, "" }
diff --git a/entry.c b/entry.c
index b5d1d3cf23..3917bfc874 100644
--- a/entry.c
+++ b/entry.c
@@ -399,6 +399,47 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 	return lstat(path, st);
 }
 
+static void mark_duplicate_entries(const struct checkout *state,
+				   struct cache_entry *ce, struct stat *st)
+{
+	int i;
+	int *count = state->nr_duplicates;
+
+	if (!count)
+		BUG("state->nr_duplicates must not be NULL");
+
+	ce->ce_flags |= CE_MATCHED;
+	(*count)++;
+
+	if (!state->refresh_cache)
+		BUG("We need this to narrow down the set of updated entries");
+
+	for (i = 0; i < state->istate->cache_nr; i++) {
+		struct cache_entry *dup = state->istate->cache[i];
+
+		/*
+		 * This entry has not been checked out yet, otherwise
+		 * its stat info must have been updated. And since we
+		 * check out from top to bottom, the rest is guaranteed
+		 * not checked out. Stop now.
+		 */
+		if (!ce_uptodate(dup))
+			break;
+
+		if (dup->ce_flags & CE_MATCHED)
+			continue;
+
+		if (ce_match_stat(dup, st,
+				  CE_MATCH_IGNORE_VALID |
+				  CE_MATCH_IGNORE_SKIP_WORKTREE))
+			continue;
+
+		dup->ce_flags |= CE_MATCHED;
+		(*count)++;
+		break;
+	}
+}
+
 /*
  * Write the contents from ce out to the working tree.
  *
@@ -455,6 +496,9 @@ int checkout_entry(struct cache_entry *ce,
 			return -1;
 		}
 
+		if (state->clone)
+			mark_duplicate_entries(state, ce, &st);
+
 		/*
 		 * We unlink the old file, to get the new one with the
 		 * right permissions (including umask, which is nasty
diff --git a/unpack-trees.c b/unpack-trees.c
index f9efee0836..1b0c11142a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -344,12 +344,20 @@ static int check_updates(struct unpack_trees_options *o)
 	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 	int i;
+	int nr_duplicates = 0;
 
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
 	state.istate = index;
 
+	if (o->clone) {
+		state.clone = 1;
+		state.nr_duplicates = &nr_duplicates;
+		for (i = 0; i < index->cache_nr; i++)
+			index->cache[i]->ce_flags &= ~CE_MATCHED;
+	}
+
 	progress = get_progress(o);
 
 	if (o->update)
@@ -414,6 +422,21 @@ static int check_updates(struct unpack_trees_options *o)
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+
+	if (o->clone && state.nr_duplicates) {
+		warning(_("the following paths in this repository only differ in case\n"
+			  "from another path and will cause problems because you have cloned\n"
+			  "it on an case-insensitive filesytem:\n"));
+		for (i = 0; i < index->cache_nr; i++) {
+			struct cache_entry *ce = index->cache[i];
+
+			if (!(ce->ce_flags & CE_MATCHED))
+				continue;
+			fprintf(stderr, "  '%s'\n", ce->name);
+			ce->ce_flags &= ~CE_MATCHED;
+		}
+	}
+
 	return errs != 0;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..d940f1c5c2 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -42,6 +42,7 @@ struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
 		     update,
+		     clone,
 		     index_only,
 		     nontrivial_merge,
 		     trivial_merges_only,
-- 
2.18.0.915.gd571298aae

