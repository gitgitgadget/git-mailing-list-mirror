Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1AA1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934890AbeGFTeS (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:34:18 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:44284 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934885AbeGFTeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:34:16 -0400
Received: by mail-vk0-f74.google.com with SMTP id b67-v6so4954536vka.11
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=+RgJVAgnjcsktuemx3txK4jGZAm6QFc2eoTsWL5T4IU=;
        b=JXBWsWpkjxps34ISiRAQ2Z/KyGsghxNeEESChrg0/TUdQAfl9b9KB9E2oeIsZ89feO
         lmmPhw9o95RSBbTVJQVGm1bt5upl1gTAghIh6e7bS2q7C8rEFkN3eKDoLFXqo8Y7B7K+
         siJvHpPvwED++x77T4I0+Igsustfu05Pq9R6XQ+16CMq22ZKS4pIRcvRr3ClKsxJ2tQw
         VcWbKGMifZF7RsP2i3jMQEPMKZJz5QQ5XuS3TFtks0tRdj3gKEwFvTm/aVUCw/pG71zJ
         0k+xhmgbTa8kWB2eMKy070reyNlGSGV9A4pLgrNeh/KerHFacSgy0A+GJ8lQhlkixItj
         niqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=+RgJVAgnjcsktuemx3txK4jGZAm6QFc2eoTsWL5T4IU=;
        b=FgSnQZ1wsoZB+BKXZyFq531jgu5ri1Lur+LCyIKxRwpj7KujmhDe7vISaJwoynm+VT
         sW0wZAIScPw/NFKf0HE8xyDwbCD5CC2p8QcxeU9OSo4pDVBnO0v7uQZPFjuKTuy3W6sb
         kwuLJ9XmQFOl7sYz/mVs4zsYB+KMWh33o3cY5jadCA8RZ+RqWUL0LK9RLhKOkrXrOzUk
         QFPJf0tvwtcfZ0jcL+WWDLrZbFb/zxibDThyuzPuTf6oddh9V2xyb/gYDfYMvvPNOU0L
         8NYwtQtGMvvHi8OEA1v8zvgJxceOlE1XDy/Z83F7LupxcXLmBs3N6T7t6uRmwECMA9tv
         SNTg==
X-Gm-Message-State: APt69E0z8IDnfDjKygEnUPAv+P0U0PDLaT1g6BqdyUYOOLgfCAYNmh9v
        MG3B7+JXM/p5R4gBedmMYBOySz/YyecWjI72gzhhYkOYsK/osqe567MH2IiHmf8C99bsN829pYa
        utyi5cYxYabciy4qD4grnhSdSGMWj7gWFEB6hUy9tdQ/PKTwI//jucgbvPhRJmjUiC/iuCQjFBu
        RR
X-Google-Smtp-Source: AAOMgpdWuOT2Blvc0thCGb2IHwIKp6+Q2p9CSSwaIIJpbWQa5TrGfEMd2erdmgpuV/sL2T8FtXOVdp6c/LwyFEzHn83i
MIME-Version: 1.0
X-Received: by 2002:a1f:b42:: with SMTP id 63-v6mr5345966vkl.24.1530905655935;
 Fri, 06 Jul 2018 12:34:15 -0700 (PDT)
Date:   Fri,  6 Jul 2018 12:34:09 -0700
In-Reply-To: <cover.1530905323.git.jonathantanmy@google.com>
Message-Id: <e122c58f6febf265f9eadbfbac34a2f5729dffe2.1530905323.git.jonathantanmy@google.com>
References: <cover.1530905323.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 1/2] upload-pack: send refs' objects despite "filter"
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A filter line in a request to upload-pack filters out objects regardless
of whether they are directly referenced by a "want" line or not. This
means that cloning with "--filter=blob:none" (or another filter that
excludes blobs) from a repository with at least one ref pointing to a
blob (for example, the Git repository itself) results in output like the
following:

    error: missing object referenced by 'refs/tags/junio-gpg-pub'

and if that particular blob is not referenced by a fetched tree, the
resulting clone fails fsck because there is no object from the remote to
vouch that the missing object is a promisor object.

Update both the protocol and the upload-pack implementation to include
all explicitly specified "want" objects in the packfile regardless of
the filter specification.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/pack-protocol.txt |  4 +++-
 list-objects.c                            |  6 +++---
 object.h                                  |  2 +-
 revision.c                                |  1 +
 revision.h                                |  3 ++-
 t/t5317-pack-objects-filter-objects.sh    | 16 ++++++++++++++++
 t/t5616-partial-clone.sh                  | 16 ++++++++++++++++
 7 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 7fee6b780a..508a344cf1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -284,7 +284,9 @@ information is sent back to the client in the next step.
 The client can optionally request that pack-objects omit various
 objects from the packfile using one of several filtering techniques.
 These are intended for use with partial clone and partial fetch
-operations.  See `rev-list` for possible "filter-spec" values.
+operations. An object that does not meet a filter-spec value is
+omitted unless explicitly requested in a 'want' line. See `rev-list`
+for possible filter-spec values.
 
 Once all the 'want's and 'shallow's (and optional 'deepen') are
 transferred, clients MUST send a flush-pkt, to tell the server side
diff --git a/list-objects.c b/list-objects.c
index 3eec510357..be4118889a 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -47,7 +47,7 @@ static void process_blob(struct rev_info *revs,
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	if (filter_fn)
+	if (!(obj->flags & USER_GIVEN) && filter_fn)
 		r = filter_fn(LOFS_BLOB, obj,
 			      path->buf, &path->buf[pathlen],
 			      filter_data);
@@ -132,7 +132,7 @@ static void process_tree(struct rev_info *revs,
 	}
 
 	strbuf_addstr(base, name);
-	if (filter_fn)
+	if (!(obj->flags & USER_GIVEN) && filter_fn)
 		r = filter_fn(LOFS_BEGIN_TREE, obj,
 			      base->buf, &base->buf[baselen],
 			      filter_data);
@@ -171,7 +171,7 @@ static void process_tree(struct rev_info *revs,
 				     cb_data, filter_fn, filter_data);
 	}
 
-	if (filter_fn) {
+	if (!(obj->flags & USER_GIVEN) && filter_fn) {
 		r = filter_fn(LOFS_END_TREE, obj,
 			      base->buf, &base->buf[baselen],
 			      filter_data);
diff --git a/object.h b/object.h
index 5c13955000..cf8da6ba83 100644
--- a/object.h
+++ b/object.h
@@ -27,7 +27,7 @@ struct object_array {
 
 /*
  * object flag allocation:
- * revision.h:               0---------10                                26
+ * revision.h:               0---------10                              2526
  * fetch-pack.c:             0----5
  * walker.c:                 0-2
  * upload-pack.c:                4       11----------------19
diff --git a/revision.c b/revision.c
index 40fd91ff2b..1b37da988d 100644
--- a/revision.c
+++ b/revision.c
@@ -172,6 +172,7 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		strbuf_release(&buf);
 		return; /* do not add the commit itself */
 	}
+	obj->flags |= USER_GIVEN;
 	add_object_array_with_path(obj, name, &revs->pending, mode, path);
 }
 
diff --git a/revision.h b/revision.h
index b8c47b98e2..dc8f96366e 100644
--- a/revision.h
+++ b/revision.h
@@ -19,8 +19,9 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
 #define BOTTOM		(1u<<10)
+#define USER_GIVEN	(1u<<25) /* given directly by the user */
 #define TRACK_LINEAR	(1u<<26)
-#define ALL_REV_FLAGS	(((1u<<11)-1) | TRACK_LINEAR)
+#define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 1b0acc383b..6710c8bc8c 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -160,6 +160,22 @@ test_expect_success 'verify blob:limit=1k' '
 	test_cmp observed expected
 '
 
+test_expect_success 'verify explicitly specifying oversized blob in input' '
+	git -C r2 ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
+	HEAD
+	$(git -C r2 rev-parse HEAD:large.10000)
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+	git -C r2 verify-pack -v ../filter.pack \
+		| grep blob \
+		| awk -f print_1.awk \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
 test_expect_success 'verify blob:limit=1m' '
 	git -C r2 ls-files -s large.1000 large.10000 \
 		| awk -f print_2.awk \
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index cee5565367..8a2bf86491 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -154,4 +154,20 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack -
 	grep "git index-pack.*--fsck-objects" trace
 '
 
+test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
+	rm -rf src dst &&
+	git init src &&
+	test_commit -C src x &&
+	test_config -C src uploadpack.allowfilter 1 &&
+	test_config -C src uploadpack.allowanysha1inwant 1 &&
+
+	# Create a tag pointing to a blob.
+	BLOB=$(echo blob-contents | git -C src hash-object --stdin -w) &&
+	git -C src tag myblob "$BLOB" &&
+
+	git clone --filter="blob:none" "file://$(pwd)/src" dst 2>err &&
+	! grep "does not point to a valid object" err &&
+	git -C dst fsck
+'
+
 test_done
-- 
2.18.0.203.gfac676dfb9-goog

