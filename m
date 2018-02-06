Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90DE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbeBFATc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:19:32 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41439 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBFAT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:19:28 -0500
Received: by mail-pl0-f66.google.com with SMTP id k8so115911pli.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=npPPdI7mJH9uSToL4ambO/23hop7cCe+3rxrYa2xBgA=;
        b=GNeUY8qhcUqYM7wWdeLsdjzkmF4Mdh5MvQMYLabUc2qNEJ0dJ1e7X2vngcqcSV7Au/
         rosjuV1pp5FYm6F/p6RXZdbZQ10x8ozUIu9PduRQ1pb9+5QsjvBwHuRLyy8bhBusqxWq
         wsOpJxT1W5sXkPDIRvt87wrDJKh26ZwunrWGOMx0pjdE7hISIDKohdUG86eIBYDz9JaC
         57z/xC/XjUP2qAu+DYwG1sArEFJGqJ1+GnLnDTTq4fZp2jSfhu9/qmZAag4aqbk6awY1
         rbuuhZ0/bwtX5vwDmpE1umvIhKRfr7eBbpld/SRkpqOHD9ByaS1pqmKedH0oNQfLaxcx
         1w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=npPPdI7mJH9uSToL4ambO/23hop7cCe+3rxrYa2xBgA=;
        b=X/tae4BYfylJ93t8uPT31X3Q2qNaxJUY/W6D6NwdWPtiatcLMJt6RYD1YecofBiQZ/
         76NW4K6azAmkewSynfx4l8YTWqtgxJgdhwSmMVfVVFBZfr+mi0XsC00ZGADhxmTW6hkT
         /9zASSoiIvPjewPDNdQk7GdGBwKEisUkesz5C2I1s0HjdD6D8wvKOY3q/WBuNnYTiumD
         sdD7Emwh5g59iv7GXK4bAmyZuEsg2oEPwtYoL2dNoBjk4cJN6n9MvfWNukcYi0UMGShk
         QcYpPE3gsRTQhKGaQWD6d3TIuy65BOEND8T+aB0T4796GXvw/q5772ixztFCLWgTLLE6
         Ooqw==
X-Gm-Message-State: APf1xPActvZ35VrDCPR198CqCxyZGpahs9AeqFC1rbZEHiFnTXoq7LWQ
        6HeNZrZvtKsU3qzG4WpTcap1w77ZWcM=
X-Google-Smtp-Source: AH8x226fFlL0NHSPxi+mI5ntQIyKCpqfaGmmpIkh6PiHXFX65jJ/CUqByPovkuGNNCJorN3WkqelVw==
X-Received: by 2002:a17:902:424:: with SMTP id 33-v6mr531284ple.57.1517876367071;
        Mon, 05 Feb 2018 16:19:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t29sm6459494pfj.21.2018.02.05.16.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:19:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 110/194] object-store: add repository argument to check_sha1_signature
Date:   Mon,  5 Feb 2018 16:16:25 -0800
Message-Id: <20180206001749.218943-12-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of check_sha1_signature to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fast-export.c                 |  2 +-
 builtin/index-pack.c                  |  2 +-
 builtin/mktag.c                       |  4 +++-
 contrib/coccinelle/object_store.cocci | 10 ++++++++++
 object-store.h                        |  3 ++-
 object.c                              |  4 ++--
 pack-check.c                          |  2 +-
 sha1_file.c                           |  4 ++--
 8 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b0f229351d..5d524e7dd2 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -242,7 +242,7 @@ static void export_blob(const struct object_id *oid)
 		buf = read_sha1_file(oid->hash, &type, &size);
 		if (!buf)
 			die ("Could not read blob %s", oid_to_hex(oid));
-		if (check_sha1_signature(oid->hash, buf, size, typename(type)) < 0)
+		if (check_sha1_signature(the_repository, oid->hash, buf, size, typename(type)) < 0)
 			die("sha1 mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f570e16bb6..0928ed8dd5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1383,7 +1383,7 @@ static void fix_unresolved_deltas(struct sha1file *f)
 		if (!base_obj->data)
 			continue;
 
-		if (check_sha1_signature(d->sha1, base_obj->data,
+		if (check_sha1_signature(the_repository, d->sha1, base_obj->data,
 				base_obj->size, typename(type)))
 			die(_("local object %s is corrupt"), sha1_to_hex(d->sha1));
 		base_obj->obj = append_obj_to_pack(f, d->sha1,
diff --git a/builtin/mktag.c b/builtin/mktag.c
index ab41735f2a..d05fdb824a 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -30,7 +30,9 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
 
 	if (buffer) {
 		if (type == type_from_string(expected_type))
-			ret = check_sha1_signature(repl, buffer, size, expected_type);
+			ret = check_sha1_signature(the_repository, repl,
+						   buffer, size,
+						   expected_type);
 		free(buffer);
 	}
 	return ret;
diff --git a/contrib/coccinelle/object_store.cocci b/contrib/coccinelle/object_store.cocci
index 800e0581e5..6e6e5454da 100644
--- a/contrib/coccinelle/object_store.cocci
+++ b/contrib/coccinelle/object_store.cocci
@@ -5,3 +5,13 @@ expression F;
  sha1_object_info(
 +the_repository,
  E, F)
+
+@@
+expression E;
+expression F;
+expression G;
+expression H;
+@@
+ check_sha1_signature(
++the_repository,
+ E, F, G, H)
diff --git a/object-store.h b/object-store.h
index a0e9824406..178268a048 100644
--- a/object-store.h
+++ b/object-store.h
@@ -106,7 +106,8 @@ extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsi
  * The in-core object data should be in "map". If "map" == NULL, reads the
  * named object using the streaming interface and rehashes it on the fly.
  */
-extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
+#define check_sha1_signature(r, s, m, sz, t) check_sha1_signature_##r(s, m, sz, t)
+extern int check_sha1_signature_the_repository(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 /*
  * Convenience for sha1_object_info_extended() with a NULL struct
diff --git a/object.c b/object.c
index a10983755c..85b0360e0a 100644
--- a/object.c
+++ b/object.c
@@ -260,7 +260,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB) ||
 	    (!obj && has_object_file(oid) &&
 	     sha1_object_info(the_repository, oid->hash, NULL) == OBJ_BLOB)) {
-		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
+		if (check_sha1_signature(the_repository, repl, NULL, 0, NULL) < 0) {
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
 		}
@@ -270,7 +270,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 
 	buffer = read_sha1_file(oid->hash, &type, &size);
 	if (buffer) {
-		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
+		if (check_sha1_signature(the_repository, repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
 			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 25afd59c7d..2eb07cf596 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -143,7 +143,7 @@ static int verify_packfile(struct packed_git *p,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(entries[i].oid.oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_sha1_signature(entries[i].oid.hash, data, size, typename(type)))
+		else if (check_sha1_signature(the_repository, entries[i].oid.hash, data, size, typename(type)))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(entries[i].oid.oid), p->pack_name);
 		else if (fn) {
diff --git a/sha1_file.c b/sha1_file.c
index 3262075497..9ef25e6154 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -802,7 +802,7 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-int check_sha1_signature(const unsigned char *sha1, void *map,
+int check_sha1_signature_the_repository(const unsigned char *sha1, void *map,
 			 unsigned long size, const char *type)
 {
 	unsigned char real_sha1[20];
@@ -2207,7 +2207,7 @@ int read_loose_object(const char *path,
 			git_inflate_end(&stream);
 			goto out;
 		}
-		if (check_sha1_signature(expected_sha1, *contents,
+		if (check_sha1_signature(the_repository, expected_sha1, *contents,
 					 *size, typename(*type))) {
 			error("sha1 mismatch for %s (expected %s)", path,
 			      sha1_to_hex(expected_sha1));
-- 
2.15.1.433.g936d1b9894.dirty

