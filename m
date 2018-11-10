Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93AEE1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeKJPdW (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34212 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeKJPdV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so3387765ljd.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRr4sjy6QX+fYV5LNEBTv8ZavhuktuvoR7NhAJzlNe8=;
        b=JoJoSDky2s1pO931WOYTLasnfZdNZhKufDF4u/0oZ+hDZpRUw3rhQaSDd+JOVVQKM4
         9hqJqnnVCIgBz/IucWcI3B/wmabEA6PaAfudXCeFmh1nC8rHxA1hg34KqEd/hJVDnok7
         Uk8df5QxAB9BK4gBS1EIAkJg/m3AprjU5z2e4DYODskw8pY7OsanjB7SAnkVNL/SCv5P
         o8u3bh3r9mIXX8Bqt79nb9emy/3uhZ1xJIJIOwpVFtf7sOGJeVypJe0Ol0XLZklmx0/n
         1c770lT6TMysU9Ic9btoPhTVa/mZJqjpLL0ZK8KCyUtTYrrLY2Hh8fDsnUSD2WglVLHq
         JHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRr4sjy6QX+fYV5LNEBTv8ZavhuktuvoR7NhAJzlNe8=;
        b=UJ0LrMfx51YxfW6qWMybiPN29qBJsnpIoLbkZWUy8E3ZmT0zT67/c0A6HrdTPceGNn
         zHFwFNLEoJqDMyPNGPn6C6+BT4WYfXxQcs8NVyDsokEcKULarykw6meQqKWWs2rdOhtC
         DVpRqtNeXhTHmtE+JPTsoBC9h38seXSdElBkcsSlDJ+iUn0ONq6HxHkhZdz+ah93bqpD
         ws6NAHXFJchyOLe8fFgx7MhFQICW6BWLGLi54Znpr30SE/a/MfKBvIoYTA8tK4GaHWXE
         0y0mrEBjXqhxHhwXxsI2NBFbgzpn3tZ/FRS5cRkDXvSzCP6smbP9zvKRM3jt3RRuZnto
         fWxA==
X-Gm-Message-State: AGRZ1gKmUfEdbGGmH3ZS2N4L3D7xLgPy5/X7N4Hf4b/DiflXXxOCdJCJ
        PI5w7tMokjG+42pguhEJ30qFAb/v
X-Google-Smtp-Source: AJdET5d/cmu7JUNisV/+wiNKxb/ABAxGXmBhaCBDRBk1INOso8LDyb+TGJtvME15xn+eu2SPxZFN9A==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr6268856lje.115.1541828973214;
        Fri, 09 Nov 2018 21:49:33 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:32 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 13/22] bundle.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:01 +0100
Message-Id: <20181110054910.10568-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/bundle.c |  7 ++++---
 bundle.c         | 26 ++++++++++++++------------
 bundle.h         |  9 +++++----
 transport.c      |  2 +-
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index d0de59b94f..9e9c65d9c6 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -40,7 +40,7 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 			usage(builtin_bundle_usage);
 			return 1;
 		}
-		if (verify_bundle(&header, 1))
+		if (verify_bundle(the_repository, &header, 1))
 			return 1;
 		fprintf(stderr, _("%s is okay\n"), bundle_file);
 		return 0;
@@ -56,11 +56,12 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		}
 		if (!startup_info->have_repository)
 			die(_("Need a repository to create a bundle."));
-		return !!create_bundle(&header, bundle_file, argc, argv);
+		return !!create_bundle(the_repository, &header,
+				       bundle_file, argc, argv);
 	} else if (!strcmp(cmd, "unbundle")) {
 		if (!startup_info->have_repository)
 			die(_("Need a repository to unbundle."));
-		return !!unbundle(&header, bundle_fd, 0) ||
+		return !!unbundle(the_repository, &header, bundle_fd, 0) ||
 			list_bundle_refs(&header, argc, argv);
 	} else
 		usage(builtin_bundle_usage);
diff --git a/bundle.c b/bundle.c
index 1ef584b93b..b94992675a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -127,7 +127,9 @@ static int list_refs(struct ref_list *r, int argc, const char **argv)
 /* Remember to update object flag allocation in object.h */
 #define PREREQ_MARK (1u<<16)
 
-int verify_bundle(struct bundle_header *header, int verbose)
+int verify_bundle(struct repository *r,
+		  struct bundle_header *header,
+		  int verbose)
 {
 	/*
 	 * Do fast check, then if any prereqs are missing then go line by line
@@ -140,10 +142,10 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(the_repository, &e->oid);
+		struct object *o = parse_object(r, &e->oid);
 		if (o) {
 			o->flags |= PREREQ_MARK;
 			add_pending_object(&revs, o, e->name);
@@ -168,7 +170,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(the_repository, &e->oid);
+		struct object *o = parse_object(r, &e->oid);
 		assert(o); /* otherwise we'd have returned early */
 		if (o->flags & SHOWN)
 			continue;
@@ -180,7 +182,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	/* Clean up objects used, as they will be reused. */
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		commit = lookup_commit_reference_gently(the_repository, &e->oid, 1);
+		commit = lookup_commit_reference_gently(r, &e->oid, 1);
 		if (commit)
 			clear_commit_marks(commit, ALL_REV_FLAGS);
 	}
@@ -375,8 +377,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 			 * in terms of a tag (e.g. v2.0 from the range
 			 * "v1.0..v2.0")?
 			 */
-			struct commit *one = lookup_commit_reference(the_repository,
-								     &oid);
+			struct commit *one = lookup_commit_reference(revs->repo, &oid);
 			struct object *obj;
 
 			if (e->item == &(one->object)) {
@@ -409,8 +410,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 	return ref_count;
 }
 
-int create_bundle(struct bundle_header *header, const char *path,
-		  int argc, const char **argv)
+int create_bundle(struct repository *r, struct bundle_header *header,
+		  const char *path, int argc, const char **argv)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
@@ -441,7 +442,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(r, &revs, NULL);
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
@@ -482,7 +483,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 	return -1;
 }
 
-int unbundle(struct bundle_header *header, int bundle_fd, int flags)
+int unbundle(struct repository *r, struct bundle_header *header,
+	     int bundle_fd, int flags)
 {
 	const char *argv_index_pack[] = {"index-pack",
 					 "--fix-thin", "--stdin", NULL, NULL};
@@ -491,7 +493,7 @@ int unbundle(struct bundle_header *header, int bundle_fd, int flags)
 	if (flags & BUNDLE_VERBOSE)
 		argv_index_pack[3] = "-v";
 
-	if (verify_bundle(header, 0))
+	if (verify_bundle(r, header, 0))
 		return -1;
 	ip.argv = argv_index_pack;
 	ip.in = bundle_fd;
diff --git a/bundle.h b/bundle.h
index e9a4cb6a74..781e6f5c3a 100644
--- a/bundle.h
+++ b/bundle.h
@@ -18,11 +18,12 @@ struct bundle_header {
 
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
-int create_bundle(struct bundle_header *header, const char *path,
-		int argc, const char **argv);
-int verify_bundle(struct bundle_header *header, int verbose);
+int create_bundle(struct repository *r, struct bundle_header *header,
+		  const char *path, int argc, const char **argv);
+int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
 #define BUNDLE_VERBOSE 1
-int unbundle(struct bundle_header *header, int bundle_fd, int flags);
+int unbundle(struct repository *r, struct bundle_header *header,
+	     int bundle_fd, int flags);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 71f663743f..f6e54f6412 100644
--- a/transport.c
+++ b/transport.c
@@ -154,7 +154,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
-	return unbundle(&data->header, data->fd,
+	return unbundle(the_repository, &data->header, data->fd,
 			transport->progress ? BUNDLE_VERBOSE : 0);
 }
 
-- 
2.19.1.1231.g84aef82467

