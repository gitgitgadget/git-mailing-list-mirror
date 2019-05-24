Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1D31F462
	for <e@80x24.org>; Fri, 24 May 2019 12:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391271AbfEXMDh (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 08:03:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35965 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbfEXMDg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 08:03:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so14059145edx.3
        for <git@vger.kernel.org>; Fri, 24 May 2019 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOK06SmgMFdwPIc3swtyeFYly5Q3pH7WRUcKycAy92Y=;
        b=SKGPr9fKTiQN2FR6MZuLLdNTq8lJAACILRCI/BlkAxv8N55D9FXKESu78Y20Yd0A5c
         nAT9uznDzFmgPUnDFkD2aYYvUta4AIoN3ghyPG1UZJ3RxPFJ3q0+HFji8mGp3QvkMGVI
         CSOe2u6LWmdQICAuHoZz/FnhvuSduN9bVkJZQjdsjU0WQ4OX2N+7Gt2wD/+UvqFVcR1Y
         iZhwSkxuv+tllQAOXW/twww054KLYFIM07uva8I/bEc3AJkbwrVe8jGsL8nLWJ2MrG6E
         YgoPqukVrew4W77+wRvCVu/7Na8l6bfFaUix/IP5QdxVCge5GVAU4Y28rhYk9lUk0N3K
         CPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOK06SmgMFdwPIc3swtyeFYly5Q3pH7WRUcKycAy92Y=;
        b=tGgIGMajzICRoG72f/+viR/8AbClc4p8xGiRE8cOXyXcKmtrLEXeaPE+bJqqYHyb4+
         SYa3/hCtHSO2LkmEJY7jt3BnWxt6xdFKavOt5B4Sct0jIq+mrOWyQwRLu1y5MSbwFE/w
         C0jizisXtO/3q02liFef1dOZNjXvqdiumnOsVCQcfAAgWa9tEfnRo684GFqpVQQVISnw
         I0sYjrRybsZaiecGvvTub8BwZBzdXTHrRZLAyMobd+0sW4mpNTH7yCDFiQ+k+2QHiBt2
         pfCBfJV6lyydDNfSiZKeILS4Z1kSXrqOd7Xuoiblc062AR8lqvRF0v7bsRHHCP0wrYYq
         NW6A==
X-Gm-Message-State: APjAAAWi3Lmb3uDXIPWgMDp/huD4JVMeFaMkzlZFgMrjlNEcFQSOknL8
        XF8BaUV7YCRLfgS+7YNrUVvaabWXDK0=
X-Google-Smtp-Source: APXvYqxyADBg8R9lmEUy+qwi353Aky1Elc2EgfAZ7iCW9zAJS7Y6LwH/P5pCujgR2hnfJWf17zy1MQ==
X-Received: by 2002:aa7:cb44:: with SMTP id w4mr104899692edt.233.1558699414593;
        Fri, 24 May 2019 05:03:34 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id f25sm685340ede.44.2019.05.24.05.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 05:03:33 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
Date:   Fri, 24 May 2019 14:03:18 +0200
Message-Id: <20190524120318.4851-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If someone wants to use as a filter a sparse file that is in the
repository, something like "--filter=sparse:oid=<ref>:<path>"
already works.

So 'sparse:path' is only interesting if the sparse file is not in
the repository. In this case though the current implementation has
a big security issue, as it makes it possible to ask the server to
read any file, like for example /etc/password, and to explore the
filesystem, as well as individual lines of files.

If someone is interested in using a sparse file that is not in the
repository as a filter, then at the minimum a config option, such
as "uploadpack.sparsePathFilter", should be implemented first to
restrict the directory from which the files specified by
'sparse:path' can be read.

For now though, let's just disable 'sparse:path' filters.
---
 list-objects-filter-options.c |  9 ++++++---
 list-objects-filter-options.h |  2 --
 list-objects-filter.c         | 22 ----------------------
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0036f7378..007c104b93 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -78,9 +78,12 @@ static int gently_parse_list_objects_filter(
 		return 0;
 
 	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
-		filter_options->choice = LOFC_SPARSE_PATH;
-		filter_options->sparse_path_value = strdup(v0);
-		return 0;
+		if (errbuf) {
+			strbuf_addstr(
+				errbuf,
+				_("sparse:path filters are now disabled"));
+		}
+		return 1;
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index e3adc78ebf..c54f0000fb 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -13,7 +13,6 @@ enum list_objects_filter_choice {
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
-	LOFC_SPARSE_PATH,
 	LOFC__COUNT /* must be last */
 };
 
@@ -44,7 +43,6 @@ struct list_objects_filter_options {
 	 * choice.
 	 */
 	struct object_id *sparse_oid_value;
-	char *sparse_path_value;
 	unsigned long blob_limit_value;
 	unsigned long tree_exclude_depth;
 };
diff --git a/list-objects-filter.c b/list-objects-filter.c
index ee449de3f7..53f90442c5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -478,27 +478,6 @@ static void *filter_sparse_oid__init(
 	return d;
 }
 
-static void *filter_sparse_path__init(
-	struct oidset *omitted,
-	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
-{
-	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
-	if (add_excludes_from_file_to_list(filter_options->sparse_path_value,
-					   NULL, 0, &d->el, NULL) < 0)
-		die("could not load filter specification");
-
-	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
-	d->array_frame[d->nr].defval = 0; /* default to include */
-	d->array_frame[d->nr].child_prov_omit = 0;
-
-	*filter_fn = filter_sparse;
-	*filter_free_fn = filter_sparse_free;
-	return d;
-}
-
 typedef void *(*filter_init_fn)(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
@@ -514,7 +493,6 @@ static filter_init_fn s_filters[] = {
 	filter_blobs_limit__init,
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
-	filter_sparse_path__init,
 };
 
 void *list_objects_filter__init(
-- 
2.22.0.rc1

