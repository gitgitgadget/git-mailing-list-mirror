Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A15208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbdH3HCU (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:02:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33955 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbdH3HCT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:02:19 -0400
Received: by mail-pf0-f193.google.com with SMTP id p69so3806668pfk.1
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mOBfro3uOmvh3Q/EpHh8mMs8I9fv/pVRtB3Afe/+bhg=;
        b=RJNtOWwh6rOxlw5ND+8lV1HE+lk4ZHHno+q6sDZBGeu5tGxgj7LGaQBBHWh3kK949Y
         oKsnYisajgI8o7PwISN2M1YK680pZ2Pj2iksSCHUBeDehZ10r5Ylr8LcK49tJToyuKl3
         giQLq9qDMDyi3fSMBDzCH0Eft2lSSxYydpLxhQ1hFvp2NL8LU4YCXzD9hrXwbAgtV1La
         +BneK4vJaJSHfpuH6kVVOzNKcZQTF/J+t3y+Ox18TnP3d8gkWSn3aturw+wbzk9LaBAm
         34u2iENAed1W8Ux83iksygyOKWvikd73dtWrxW6FspjYcsYrzvQ7U41tgD9IMs7qgS4U
         Q6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mOBfro3uOmvh3Q/EpHh8mMs8I9fv/pVRtB3Afe/+bhg=;
        b=ZbHY5vWr/V029ASICnfd9pQri8c/7xeIMxPd5CiSNC5Viqg6qMfTrESR1V0Gf7L4jn
         RpTsPJC88ePEio0fxHQpIIpbUrKYotg43C5oxjMj5Asmv25XHcMbGIlNkfD3uNmN5Lkh
         +YFFJ5lJEPof8t+42/mCPQLzUXB5emRE7AdH9VINJR2ICOtUAAPq0bgoY+auhcI2+rzB
         BStqQuqEd6h3JfDrOTf70yWtfnmqcJxALY5H6SLEBiFiEWyVj/X4oZBPzrdNCJzj4sQG
         B4hdRa7g9NXQMltZT2GKBwElNvlI8/9wtwxiL90/q8wk5dgN6kfsTjP7QssdDD+aVAgO
         MwYw==
X-Gm-Message-State: AHYfb5gtXHgkIZUiEgLBt8NnKgbcUgyCYuY5y5+kdFvbp0UaDYaAQcEf
        5Oz+7BenCWT6zlO8tiM=
X-Received: by 10.84.141.1 with SMTP id 1mr729592plu.189.1504076538809;
        Wed, 30 Aug 2017 00:02:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id q67sm8421452pfg.37.2017.08.30.00.02.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:02:18 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:02:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 16/39] object-store: add repository argument to
 foreach_alt_odb
Message-ID: <20170830070216.GQ153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow foreach_alt_odb callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/count-objects.c     | 2 +-
 builtin/submodule--helper.c | 4 +++-
 cache.h                     | 2 --
 object-store.h              | 4 ++++
 sha1_file.c                 | 4 ++--
 transport.c                 | 4 +++-
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 9334648dcc..843a7d7d7e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -155,7 +155,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 		printf("size-garbage: %s\n", garbage_buf.buf);
-		foreach_alt_odb(print_alternate, NULL);
+		foreach_alt_odb(the_repository, print_alternate, NULL);
 		strbuf_release(&loose_buf);
 		strbuf_release(&pack_buf);
 		strbuf_release(&garbage_buf);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 818fe74f0a..299a71b90c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "object-store.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
@@ -598,7 +599,8 @@ static void prepare_possible_alternates(const char *sm_name,
 		die(_("Value '%s' for submodule.alternateErrorStrategy is not recognized"), error_strategy);
 
 	if (!strcmp(sm_alternate, "superproject"))
-		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
+		foreach_alt_odb(the_repository,
+				add_possible_reference_from_superproject, &sas);
 	else if (!strcmp(sm_alternate, "no"))
 		; /* do nothing */
 	else
diff --git a/cache.h b/cache.h
index 5770224167..abec62dc9b 100644
--- a/cache.h
+++ b/cache.h
@@ -1524,8 +1524,6 @@ struct alternate_object_database {
 	char path[FLEX_ARRAY];
 };
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
-typedef int alt_odb_fn(struct alternate_object_database *, void *);
-extern int foreach_alt_odb(alt_odb_fn, void*);
 
 /*
  * Allocate a "struct alternate_object_database" but do _not_ actually
diff --git a/object-store.h b/object-store.h
index e749c952d5..eef8d3b653 100644
--- a/object-store.h
+++ b/object-store.h
@@ -57,4 +57,8 @@ struct packed_git {
 #define prepare_alt_odb(r) prepare_alt_odb_##r()
 extern void prepare_alt_odb_the_repository(void);
 
+typedef int alt_odb_fn(struct alternate_object_database *, void *);
+#define foreach_alt_odb(r, fn, cb) foreach_alt_odb_##r(fn, cb)
+extern int foreach_alt_odb_the_repository(alt_odb_fn, void*);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 9211c73920..8c599dbfc2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -606,7 +606,7 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-int foreach_alt_odb(alt_odb_fn fn, void *cb)
+int foreach_alt_odb_the_repository(alt_odb_fn fn, void *cb)
 {
 	struct alternate_object_database *ent;
 	int r = 0;
@@ -2031,7 +2031,7 @@ int for_each_loose_object(each_loose_object_fn cb, void *data, unsigned flags)
 
 	alt.cb = cb;
 	alt.data = data;
-	return foreach_alt_odb(loose_from_alt_odb, &alt);
+	return foreach_alt_odb(the_repository, loose_from_alt_odb, &alt);
 }
 
 static int check_stream_sha1(git_zstream *stream,
diff --git a/transport.c b/transport.c
index d75ff0514d..426a3a3a80 100644
--- a/transport.c
+++ b/transport.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "transport.h"
+#include "repository.h"
 #include "run-command.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
@@ -11,6 +12,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "object-store.h"
 #include "branch.h"
 #include "url.h"
 #include "submodule.h"
@@ -1286,5 +1288,5 @@ void for_each_alternate_ref(alternate_ref_fn fn, void *data)
 	struct alternate_refs_data cb;
 	cb.fn = fn;
 	cb.data = data;
-	foreach_alt_odb(refs_from_alternate_cb, &cb);
+	foreach_alt_odb(the_repository, refs_from_alternate_cb, &cb);
 }
-- 
2.14.1.581.gf28d330327

