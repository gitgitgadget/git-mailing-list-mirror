Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8127B1FE90
	for <e@80x24.org>; Sun, 23 Apr 2017 04:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbdDWEoa (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 00:44:30 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38538 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdDWEo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 00:44:28 -0400
Received: by mail-it0-f48.google.com with SMTP id e132so22669293ite.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2017 21:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LRuqJylqOahDR126okdaFECCSFbQLek5mNHt2rlhW0w=;
        b=dnws24ima20frbp6pCsZP6dqNN1lQ0Tw2OYXc+9+gbaQVnx6tlSBQVgQRaZFrrGi0V
         4N8CRScK3FpNqAAp3sG88tYqEFEpU4A9u0kJ2Yv+HqDYaGtCl68kruLWEBsQD01f4si8
         oScmpHuHz3LlJhSIZB1GM+d85Z4Bi306el94UW99FaimSzuxPxJ1t5KbIYerHHH9xQ8o
         E4k8V+n0Zz5pbLxxVeviTC2S9l4tuhd84NTt+MciyDSxJLDTakMEqPIH0dWSH3X+n+26
         DJN9zTt2wfZvwFJXsb66RrNS/3y4YEaOeli8sV4j6etOj90jLUEgPpD5YtD4S3HaYljj
         BFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LRuqJylqOahDR126okdaFECCSFbQLek5mNHt2rlhW0w=;
        b=eptcV9pJb551+8vaJEDDc8OSOvsoflWdUxuhpscoCwZ7Wlr3vCqzFjxuumaEW7oaxP
         MWSTkx3s1iSCY2IgKNMCHclEFVl4cAdBSwGYs4geTYfTVcLK/+XfAmIXrdoUpdnl6y2K
         evU/C754Pe9/W2PuMXxWODSSe712MxMP09w9hTItV5aIbxK9kKue4nqtmpYjfalBlBLu
         jdL747aN2SjwCiK341F1ks08U+xzN3ujSu/CEFDeO4Yy6WD+EFZHBse7F3YV6gE5FXbj
         G6I48IxsVbh0jMI5L4byPCKLx/1hCSCs2ZzhmSkCRsZbQuU/1Bm3uX+vq+HJf1dIWlOu
         kX7Q==
X-Gm-Message-State: AN3rC/56zoxdHzCSe9JzbzUUP5+8piFzyIzWPNbVG6djbmpLQcVvSoId
        fB6MYn7sjqDeGA==
X-Received: by 10.99.159.1 with SMTP id g1mr18718748pge.116.1492922667452;
        Sat, 22 Apr 2017 21:44:27 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s10sm23768633pfe.28.2017.04.22.21.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Apr 2017 21:44:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 23 Apr 2017 11:44:21 +0700
Date:   Sun, 23 Apr 2017 11:44:21 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 10/12] files-backend: make reflog iterator go through
 per-worktree reflog
Message-ID: <20170423044420.GA28419@ash>
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-11-pclouds@gmail.com>
 <d3428e5e-9ac2-0426-31fd-92d29a414b3d@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3428e5e-9ac2-0426-31fd-92d29a414b3d@alum.mit.edu>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2017 at 10:05:02AM +0200, Michael Haggerty wrote:
> I find this implementation confusing:
> 
> * `if (iter->worktree_dir_iterator)` sounds like it should mean
>   that we are iterating over worktree references but it really means
>   that we are iterating over the common references in a repository
>   that is a linked worktree.
> * `files_reflog_iterator_advance()` is called recursively, but only
>   for the first worktree reference.
> * `iter->worktree_dir_iterator` is moved over to `iter->dir_iterator`
>   when the common refs are exhausted.
> 
> Do you find it more readable as follows?:

It's a bit better, but while we're at it, why not take full advantage
of iterator abstraction?

This replacement patch (with some unrelated bits removed to reduce
distraction) adds a new meta ref-iterator that combine a per-repo and
a per-worktree iterators together. The new iterator walks through both
sub-iterators and drop the per-worktree results from the per-repo
iterator, which will be replaced with results from per-worktree
iterator.

You probably see where I'm going with this. When the new "linked
worktree ref store" comes, it will combine two per-worktree and
per-repo ref stores together and this iterator will come handy.

At that point, files-backend can go back to being oblivious about
$GIT_DIR vs $GIT_COMMON_DIR and files_reflog_iterator_begin() will be
reverted back to the version before this patch.

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4149943a6e..817b7b5d5e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3432,23 +3423,37 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	files_reflog_iterator_abort
 };
 
-static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
+static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
+						  const char *gitdir)
 {
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_READ,
-			       "reflog_iterator_begin");
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	files_reflog_path(refs, &sb, NULL);
+	strbuf_addf(&sb, "%s/logs", gitdir);
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	iter->ref_store = ref_store;
 	strbuf_release(&sb);
+
 	return ref_iterator;
 }
 
+static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ,
+			       "reflog_iterator_begin");
+
+	if (!strcmp(refs->gitdir, refs->gitcommondir)) {
+		return reflog_iterator_begin(ref_store, refs->gitcommondir);
+	} else {
+		return worktree_ref_iterator_begin(
+			reflog_iterator_begin(ref_store, refs->gitcommondir),
+			reflog_iterator_begin(ref_store, refs->gitdir));
+	}
+}
+
 static int ref_update_reject_duplicates(struct string_list *refnames,
 					struct strbuf *err)
 {
diff --git a/refs/iterator.c b/refs/iterator.c
index bce1f192f7..93243a00c4 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -40,6 +40,14 @@ void base_ref_iterator_free(struct ref_iterator *iter)
 	free(iter);
 }
 
+static void ref_iterator_copy_result(struct ref_iterator *dst,
+				     const struct ref_iterator *src)
+{
+	dst->refname = src->refname;
+	dst->oid = src->oid;
+	dst->flags = src->flags;
+}
+
 struct empty_ref_iterator {
 	struct ref_iterator base;
 };
@@ -382,3 +390,100 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 		return -1;
 	return retval;
 }
+
+struct worktree_ref_iterator {
+	struct ref_iterator base;
+	struct ref_iterator *per_repo_iterator;
+	struct ref_iterator *per_worktree_iterator;
+};
+
+static int worktree_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct worktree_ref_iterator *iter =
+		(struct worktree_ref_iterator *)ref_iterator;
+	int ok;
+
+	while (1) {
+		struct ref_iterator **subiter;
+		int normal_only;
+
+		if (iter->per_repo_iterator) {
+			subiter = &iter->per_repo_iterator;
+			/*
+			 * If we are in a worktree, then we only
+			 * include "normal" common references:
+			 */
+			normal_only = !!iter->per_worktree_iterator;
+		} else if (iter->per_worktree_iterator) {
+			subiter = &iter->per_worktree_iterator;
+			normal_only = 0;
+		} else {
+			ok = ITER_DONE;
+			break;
+		}
+
+		ok = ref_iterator_advance(*subiter);
+		if (ok == ITER_ERROR) {
+			*subiter = NULL;
+			break;
+		} else if (ok == ITER_DONE) {
+			*subiter = NULL;
+			/* There might still be worktree refs left: */
+			continue;
+		}
+
+		if (normal_only &&
+		    ref_type((*subiter)->refname) != REF_TYPE_NORMAL)
+			continue;
+
+		ref_iterator_copy_result(&iter->base, *subiter);
+		return ITER_OK;
+	}
+
+	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
+		return ITER_ERROR;
+
+	return ok;
+}
+
+static int worktree_ref_iterator_peel(struct ref_iterator *ref_iterator,
+					 struct object_id *peeled)
+{
+	die("BUG: ref_iterator_peel() called for reflog_iterator");
+}
+
+static int worktree_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct worktree_ref_iterator *iter =
+		(struct worktree_ref_iterator *)ref_iterator;
+	int ok = ITER_DONE;
+
+	if (iter->per_repo_iterator)
+		ok = ref_iterator_abort(iter->per_repo_iterator);
+
+	if (iter->per_worktree_iterator) {
+		int ok2 = ref_iterator_abort(iter->per_worktree_iterator);
+		if (ok2 == ITER_ERROR)
+			ok = ok2;
+	}
+
+	base_ref_iterator_free(ref_iterator);
+	return ok;
+}
+
+static struct ref_iterator_vtable worktree_ref_iterator_vtable = {
+	worktree_ref_iterator_advance,
+	worktree_ref_iterator_peel,
+	worktree_ref_iterator_abort
+};
+
+struct ref_iterator *worktree_ref_iterator_begin(struct ref_iterator *per_repo,
+						 struct ref_iterator *per_worktree)
+{
+	struct worktree_ref_iterator *iter = xcalloc(1, sizeof(*iter));
+
+	base_ref_iterator_init(&iter->base, &worktree_ref_iterator_vtable);
+	iter->per_repo_iterator = per_repo;
+	iter->per_worktree_iterator = per_worktree;
+	return &iter->base;
+}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 690498698e..dcb1f1d73d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -387,6 +387,14 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
 					       int trim);
 
+/*
+ * Wrap per_repo and per_worktree iterators. Traverse per_repo
+ * iterator, drop per-worktree refs. Then traverse per_worktree
+ * iterator.
+ */
+struct ref_iterator *worktree_ref_iterator_begin(struct ref_iterator *per_repo,
+						 struct ref_iterator *per_worktree);
+
 /* Internal implementation of reference iteration: */
 
 /*


