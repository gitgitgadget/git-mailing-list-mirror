Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03E81F404
	for <e@80x24.org>; Sat,  7 Apr 2018 16:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeDGQnT (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 12:43:19 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41564 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeDGQnS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 12:43:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id o102-v6so4518475lfg.8
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=0rjBjFJSshuZ3VKR0uNEGGsnNfU0adJJx+jLv+aIUUc=;
        b=Y9+L0+MOUBKW8m1D1iGgfHD6u0BV4SQXKwCoVMvR2I1y9M86OGczDqF/vxnFUu9goi
         jhLAyRvPEfAGpfJTbxYNaETmblDC4vL5mDaHo7OSYHDWNXv1jKC8d49CSdP2LEOSk+av
         oF2xHpr1kFEgN6gXy15gXRRJbM6x8ClyhA3vyb7GINvmgJW2C4hViwtCwGohVyiI+8Co
         6Yqhj4dANRMMSu4EyJC4wPWOXm4CQ8segQO06KYxkmevcZFl3UrDjiOnBQCPApfMtRVC
         v1cE5zPoIFvjCbHgMZBGirdyZKP0dms+BKwLUBZwfDPJfnmMdfgWMHXShRsg+0kC++u6
         SDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=0rjBjFJSshuZ3VKR0uNEGGsnNfU0adJJx+jLv+aIUUc=;
        b=aEzneI4cxUwFfI52EXE7vdko/5BHXJHA3NTQpGVvjeFXh6I24LIYS7xgCJNFTCbn3d
         HmTv2lO4pSKdVORP5bQ3suXaGEf9i4HdQoPxYmfkrQfYNvS8DYUjXuuU0XRkPg0hZQn1
         Prr5/+558aw1PWGpdYfwrxpaIKsWPF7gY1t3l8qFkEqa8RgkX/OBRlQZSlV638g4enNY
         kA524A0wL5jidOrdo8ltPI39gOL90AHOE5iyA6x8tYbJzpLsDJC+M9miFhdgv8Utb4xN
         mDab5SBDEVCGUaP/WKF4UlxyadlBqSlg7HnypPL+aVPTdnMxFj0JSc1BXifu3OwnAKg/
         XN0A==
X-Gm-Message-State: ALQs6tDY0+CKr8hozPoinW2vsM4zw6v9wcO64v25ynizxjkBzkIw6+SJ
        EQ4fPv7IjE73RdoKDl1QMtvP/1aopUs=
X-Google-Smtp-Source: AIpwx49RwyJAhoc98l49PVfTT/SXBv5UQ5/UzmQAL2T/5Qfd+lFRQ7fTg6AO7wpZbtx3LXymeFx2tw==
X-Received: by 2002:a19:a8d4:: with SMTP id r203-v6mr2836661lfe.146.1523119396810;
        Sat, 07 Apr 2018 09:43:16 -0700 (PDT)
Received: from localhost.localdomain (c-5eea2591-74736162.cust.telenor.se. [94.234.37.145])
        by smtp.gmail.com with ESMTPSA id f200-v6sm2613958lff.35.2018.04.07.09.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Apr 2018 09:43:15 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Subject: [PATCH v11 1/4] ref-filter: use "struct object_id" consistently
Date:   Sat,  7 Apr 2018 18:42:47 +0200
Message-Id: <20180407164250.54303-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180402005248.52418-1-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Internally we store a "struct object_id", and all of our
callers have one to pass us. But we insist that they peel it
to its bare-sha1 hash, which we then hashcpy() into place.
Let's pass it around as an object_id, which future-proofs us
for a post-sha1 world.
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 ref-filter.c         | 10 +++++-----
 ref-filter.h         |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index da186691e..42278f516 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -117,7 +117,7 @@ static int verify_tag(const char *name, const char *ref,
 		return -1;
 
 	if (format->format)
-		pretty_print_ref(name, oid->hash, format);
+		pretty_print_ref(name, oid, format);
 
 	return 0;
 }
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index ad7b79fa5..6fa04b751 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -72,7 +72,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		}
 
 		if (format.format)
-			pretty_print_ref(name, oid.hash, &format);
+			pretty_print_ref(name, &oid, &format);
 	}
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216..ade97a848 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1826,12 +1826,12 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 
 /* Allocate space for a new ref_array_item and copy the objectname and flag to it */
 static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const unsigned char *objectname,
+						 const struct object_id *oid,
 						 int flag)
 {
 	struct ref_array_item *ref;
 	FLEX_ALLOC_STR(ref, refname, refname);
-	hashcpy(ref->objectname.hash, objectname);
+	oidcpy(&ref->objectname, oid);
 	ref->flag = flag;
 
 	return ref;
@@ -1927,7 +1927,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid->hash, flag);
+	ref = new_ref_array_item(refname, oid, flag);
 	ref->commit = commit;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
@@ -2165,11 +2165,11 @@ void show_ref_array_item(struct ref_array_item *info,
 	putchar('\n');
 }
 
-void pretty_print_ref(const char *name, const unsigned char *sha1,
+void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
-	ref_item = new_ref_array_item(name, sha1, 0);
+	ref_item = new_ref_array_item(name, oid, 0);
 	ref_item->kind = ref_kind_from_refname(name);
 	show_ref_array_item(ref_item, format);
 	free_array_item(ref_item);
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b3..68268f9eb 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -132,7 +132,7 @@ void setup_ref_filter_porcelain_msg(void);
  * Print a single ref, outside of any ref-filter. Note that the
  * name must be a fully qualified refname.
  */
-void pretty_print_ref(const char *name, const unsigned char *sha1,
+void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format);
 
 #endif /*  REF_FILTER_H  */
-- 
2.14.3 (Apple Git-98)

