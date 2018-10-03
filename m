Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA3B1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJDFza (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 01:55:30 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:46159 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeJDFza (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 01:55:30 -0400
Received: by mail-vs1-f73.google.com with SMTP id t144-v6so2542366vsc.13
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6nEfDjltC21xAK0yk3RkvLjBSkCg8hcjBwVD5XTBP/M=;
        b=BoPtyMnvGvbIJYCzVzGXzBj9tMtJgEEaF/bJ1ZjDTC/luR2f2CU8vgcS0C8jaJQDlL
         wDQgofUNO1OYbhSTfO6IJxem1eCanmoqju4tBTYP4IXG9kmSMxCTRRl/FNoja55Tkc6/
         yCPdyule/wmicR77wCldgm9YU0Rd5zF/RzRp19HXTlF80JVkxYqokFO4y0LZMpl4OZ28
         BRuUSYaSGiUruvhiUawqYi1X+dFD+YL8zmSG9PWpeNHBfEOkDckWPvRu2OiwkAZJNs/W
         tTsVMb/dmJpd64OsDvwDjUsJm2O480d1zT4NEpoG/ySJ+CoeEzqy1P8hWek+bfLyMkeP
         Viuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6nEfDjltC21xAK0yk3RkvLjBSkCg8hcjBwVD5XTBP/M=;
        b=nzdpGaanlxGJx3qdceB46eVLtArbcxRqiZPFSda63wrQtl+QAK4ANztAGrKZhS4E9L
         Ckpbb2hdCKzHxjVsJM+L8/xRx3mEyZ4ecA/jZhoUUHs2CE1tPrnpDDD+3iSZKPa4gyGG
         NDu8WvEBJP8EEOYqnHa6s27mgbR3DpVxf0xDb3xKg0PgD89gqooPPzad6jR+YrVCAtn8
         kPkujYq21tygXF9CpoTnb4lUgKI9yL2Ktqwg/Qa/Y7J3CM0SXOtD1xTraZ7AnOW2zJdN
         wqGJ6UE0tYplm4zuog0ku7Vz1xCC/bDLWfTXO/uf1c1xKROPWMvjl64sVlQIBGne53td
         yKOQ==
X-Gm-Message-State: ABuFfohIZPL/XH0GSk8F/U9H8QNDaIfwdB1pgmE/02K4pSppfW7HfxHi
        DuiWb3crG5tVV7jtEyVL1UeWxPMs7H31m1keQdYqiReOmDajc4Z8MzIlUARBukOAEwB9Z27hhUw
        UZZIrOn5dj3xmZMVqW5ZacuqmLLd5KsVuz6sHiw4/a1t360eU8VE2WxSD+aPYt18DiBMJsiGFoX
        HF
X-Google-Smtp-Source: ACcGV63LUirXKGnKRH4+VRRDuiNfxqVQWxsuKrhw9XJ2ktB9sdqqNxRTKlQ3UhbX3AaYCXINb/PgrdoS2BB6gygr1zUH
X-Received: by 2002:a67:cf87:: with SMTP id g7-v6mr3432120vsm.12.1538607902989;
 Wed, 03 Oct 2018 16:05:02 -0700 (PDT)
Date:   Wed,  3 Oct 2018 16:04:53 -0700
In-Reply-To: <cover.1538607476.git.jonathantanmy@google.com>
Message-Id: <1142e0a4e1db9f4f5c0cee41e936a36deb64bd5d.1538607476.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180924154516.48704-1-jonathantanmy@google.com> <cover.1538607476.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 2/2] fetch-pack: exclude blobs when lazy-fetching trees
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A partial clone with missing trees can be obtained using "git clone
--filter=tree:none <repo>". In such a repository, when a tree needs to
be lazily fetched, any tree or blob it directly or indirectly references
is fetched as well, regardless of whether the original command required
those objects, or if the local repository already had some of them.

This is because the fetch protocol, which the lazy fetch uses, does not
allow clients to request that only the wanted objects be sent, which
would be the ideal solution. This patch implements a partial solution:
specify the "blob:none" filter, somewhat reducing the fetch payload.

This change has no effect when lazily fetching blobs (due to how filters
work). And if lazily fetching a commit (such repositories are difficult
to construct and is not a use case we support very well, but it is
possible), referenced commits and trees are still fetched - only the
blobs are not fetched.

The necessary code change is done in fetch_pack() instead of somewhere
closer to where the "filter" instruction is written to the wire so that
only one part of the code needs to be changed in order for users of all
protocol versions to benefit from this optimization.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c             | 14 ++++++++++++++
 fetch-pack.h             |  7 +++++++
 t/t0410-partial-clone.sh | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index b9b1211dda..5d82666a52 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1615,6 +1615,20 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	if (nr_sought)
 		nr_sought = remove_duplicates_in_refs(sought, nr_sought);
 
+	if (args->no_dependents && !args->filter_options.choice) {
+		/*
+		 * The protocol does not support requesting that only the
+		 * wanted objects be sent, so approximate this by setting a
+		 * "blob:none" filter if no filter is already set. This works
+		 * for all object types: note that wanted blobs will still be
+		 * sent because they are directly specified as a "want".
+		 *
+		 * NEEDSWORK: Add an option in the protocol to request that
+		 * only the wanted objects be sent, and implement it.
+		 */
+		parse_list_objects_filter(&args->filter_options, "blob:none");
+	}
+
 	if (!ref) {
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
diff --git a/fetch-pack.h b/fetch-pack.h
index 5b6e868802..43ec344d95 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -43,6 +43,13 @@ struct fetch_pack_args {
 	unsigned from_promisor:1;
 
 	/*
+	 * Attempt to fetch only the wanted objects, and not any objects
+	 * referred to by them. Due to protocol limitations, extraneous
+	 * objects may still be included. (When fetching non-blob
+	 * objects, only blobs are excluded; when fetching a blob, the
+	 * blob itself will still be sent. The client does not need to
+	 * know whether a wanted object is a blob or not.)
+	 *
 	 * If 1, fetch_pack() will also not modify any object flags.
 	 * This allows fetch_pack() to safely be called by any function,
 	 * regardless of which object flags it uses (if any).
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index cfd0655ea1..c521d7d6c6 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -182,6 +182,47 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 	grep "git< fetch=.*ref-in-want" trace
 '
 
+test_expect_success 'fetching of missing blobs works' '
+	rm -rf server repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	git hash-object repo/foo.t >blobhash &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+
+	git -C repo cat-file -p $(cat blobhash)
+'
+
+test_expect_success 'fetching of missing trees does not fetch blobs' '
+	rm -rf server repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	git -C repo rev-parse foo^{tree} >treehash &&
+	git hash-object repo/foo.t >blobhash &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+	git -C repo cat-file -p $(cat treehash) &&
+
+	# Ensure that the tree, but not the blob, is fetched
+	git -C repo rev-list --objects --missing=print $(cat treehash) >objects &&
+	grep "^$(cat treehash)" objects &&
+	grep "^[?]$(cat blobhash)" objects
+'
+
 test_expect_success 'rev-list stops traversal at missing and promised commit' '
 	rm -rf repo &&
 	test_create_repo repo &&
-- 
2.19.0.605.g01d371f741-goog

