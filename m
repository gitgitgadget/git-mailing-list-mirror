Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238E71F463
	for <e@80x24.org>; Wed, 18 Sep 2019 01:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfIRB44 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 21:56:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45695 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfIRB4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 21:56:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so6916018qtj.12
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AJaOJ/bawB0fqCIqy53IcHyVuVsf3fRvXMAOuM42vY=;
        b=uQqNapHRps+PuMPB1A/MDSm0wdkWikwdi+U7EO/7L5miiDdKFlocgXS2iMh0pHf2cH
         wJSjHtQYnYl87haufSX479E41yHPlK2Vz+WCKhvGwjjzSVl+eWKR67pQwRgim/VlXXbv
         iF89LMfQ/IUzHYxr/gBAbNxYRsTr2+hRwY+vmSLJg3ImOYMJBFZkoTwSkp7No/YQ1XTp
         MwdjGf0d53jQ2TGERIwnsSv8tAahKvf937T+d/Hg+xkwMsVnWDhyJxPvEdEb5HjQJVyK
         k7tToDosNkD1GOkx+GSWedbx23Hb82D9QqRG7qzXs6se9cdhFk5ZU3mC+93itAls+wre
         6vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AJaOJ/bawB0fqCIqy53IcHyVuVsf3fRvXMAOuM42vY=;
        b=I5tOIU/10sIRs+FCThgl52xUOFzThYajOnS4urYoNWouULJdqHAJG77MTv850Ldj6t
         gFCNvKB/PdqT1XhmlboilDi3/F1Rzxz/HA6mPcQP/gQFazgFpqWZejch6ZyWaHEax5hx
         P1AZZTjXT62C2yJOv8FdcI4rzliXAIwiTMlENeil2jUpODWP8RaaKpg/4zPwzTqdTfug
         lIQPvKEM0uc68SJoj0wYEFJQodtd/R7yNHj1zBsevyAseWY2uS1B9Z0Bqmp/wZuAHVmd
         7JhtZJDVUjoX3esXQaqnganE8EqyKI76q4fR5A5lULz8KXE4uoiLDz4t2vGCl8F2Esn2
         1gWQ==
X-Gm-Message-State: APjAAAUL6HkoUoCIt87oATTYyjs3WdYVloNNs4kyhjE/aFka7E+Ns7im
        2qZWC+Nv3A/utquiJNDp4B8ojZ7pYdg=
X-Google-Smtp-Source: APXvYqzQDBNCvblY3F92zXk1/XxqRDh+cku+CJFJHFZxjmuQ/BMnkj2zkoR32XemViLxzIVHqd7x/Q==
X-Received: by 2002:ac8:2a75:: with SMTP id l50mr1940481qtl.137.1568771813793;
        Tue, 17 Sep 2019 18:56:53 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j17sm2156371qki.99.2019.09.17.18.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 18:56:53 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [RFC PATCH 2/3] object: allow parse_object_or_die() to handle any repo
Date:   Tue, 17 Sep 2019 22:56:04 -0300
Message-Id: <e819ba8a81b11db597bb33e94da869c9ca10febb.1568771073.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568771073.git.matheus.bernardino@usp.br>
References: <cover.1568771073.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_object_or_die() was added before parse_object() learned to handle
arbitrary repositories. Now that it did, let's also bring this behavior
improvement to the former, adding a struct repository argument. Also
adjust the callers and, while we are here, avoid using `oid_to_hex(oid)`
for the third parameter as it's the default when NULL is given.

This will be used in the following patch, to allow git-grep to parse
submodule's objects.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c  |  4 ++--
 builtin/prune.c |  4 ++--
 bundle.c        | 13 ++++++++-----
 object.c        |  5 +++--
 object.h        |  4 +++-
 pack-bitmap.c   |  5 +++--
 reachable.c     |  4 ++--
 upload-pack.c   |  2 +-
 8 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2699001fbd..73ef00c426 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -455,7 +455,7 @@ static int grep_submodule(struct grep_opt *opt,
 		unsigned long size;
 		struct strbuf base = STRBUF_INIT;
 
-		object = parse_object_or_die(oid, oid_to_hex(oid));
+		object = parse_object_or_die(the_repository, oid, NULL);
 
 		grep_read_lock();
 		data = read_object_with_reference(&subrepo,
@@ -1037,7 +1037,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		object = parse_object_or_die(&oid, arg);
+		object = parse_object_or_die(the_repository, &oid, arg);
 		if (!seen_dashdash)
 			verify_non_filename(prefix, arg);
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
diff --git a/builtin/prune.c b/builtin/prune.c
index 2b76872ad2..996defe284 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -154,8 +154,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		const char *name = *argv++;
 
 		if (!get_oid(name, &oid)) {
-			struct object *object = parse_object_or_die(&oid,
-								    name);
+			struct object *object =
+				parse_object_or_die(the_repository, &oid, name);
 			add_pending_object(&revs, object, "");
 		}
 		else
diff --git a/bundle.c b/bundle.c
index b5d21cd80f..67552786a5 100644
--- a/bundle.c
+++ b/bundle.c
@@ -315,14 +315,16 @@ static int compute_and_write_prerequisites(int bundle_fd,
 		if (buf.len > 0 && buf.buf[0] == '-') {
 			write_or_die(bundle_fd, buf.buf, buf.len);
 			if (!get_oid_hex(buf.buf + 1, &oid)) {
-				struct object *object = parse_object_or_die(&oid,
-									    buf.buf);
+				struct object *object =
+					parse_object_or_die(the_repository,
+							    &oid, buf.buf);
 				object->flags |= UNINTERESTING;
 				add_pending_object(revs, object, buf.buf);
 			}
 		} else if (!get_oid_hex(buf.buf, &oid)) {
-			struct object *object = parse_object_or_die(&oid,
-								    buf.buf);
+			struct object *object =
+				parse_object_or_die(the_repository,
+						    &oid, buf.buf);
 			object->flags |= SHOWN;
 		}
 	}
@@ -406,7 +408,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 				 * end up triggering "empty bundle"
 				 * error.
 				 */
-				obj = parse_object_or_die(&oid, e->name);
+				obj = parse_object_or_die(the_repository, &oid,
+							  e->name);
 				obj->flags |= SHOWN;
 				add_pending_object(revs, obj, e->name);
 			}
diff --git a/object.c b/object.c
index 07bdd5b26e..54c4861f4c 100644
--- a/object.c
+++ b/object.c
@@ -237,10 +237,11 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 	return obj;
 }
 
-struct object *parse_object_or_die(const struct object_id *oid,
+struct object *parse_object_or_die(struct repository *r,
+				   const struct object_id *oid,
 				   const char *name)
 {
-	struct object *o = parse_object(the_repository, oid);
+	struct object *o = parse_object(r, oid);
 	if (o)
 		return o;
 
diff --git a/object.h b/object.h
index 0120892bbd..d8f02f53cd 100644
--- a/object.h
+++ b/object.h
@@ -134,7 +134,9 @@ struct object *parse_object(struct repository *r, const struct object_id *oid);
  * "name" parameter is not NULL, it is included in the error message
  * (otherwise, the hex object ID is given).
  */
-struct object *parse_object_or_die(const struct object_id *oid, const char *name);
+struct object *parse_object_or_die(struct repository *r,
+				   const struct object_id *oid,
+				   const char *name);
 
 /* Given the result of read_sha1_file(), returns the object after
  * parsing it.  eaten_p indicates if the object has a borrowed copy
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ed2befaac6..383b2351db 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -699,7 +699,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 		struct object *object = revs->pending.objects[i].item;
 
 		if (object->type == OBJ_NONE)
-			parse_object_or_die(&object->oid, NULL);
+			parse_object_or_die(the_repository, &object->oid, NULL);
 
 		while (object->type == OBJ_TAG) {
 			struct tag *tag = (struct tag *) object;
@@ -711,7 +711,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 
 			if (!tag->tagged)
 				die("bad tag");
-			object = parse_object_or_die(&tag->tagged->oid, NULL);
+			object = parse_object_or_die(the_repository,
+						     &tag->tagged->oid, NULL);
 		}
 
 		if (object->flags & UNINTERESTING)
diff --git a/reachable.c b/reachable.c
index 8f50235b28..7c5f7a0ba0 100644
--- a/reachable.c
+++ b/reachable.c
@@ -37,7 +37,7 @@ static int add_one_ref(const char *path, const struct object_id *oid,
 		return 0;
 	}
 
-	object = parse_object_or_die(oid, path);
+	object = parse_object_or_die(the_repository, oid, path);
 	add_pending_object(revs, object, "");
 
 	return 0;
@@ -86,7 +86,7 @@ static void add_recent_object(const struct object_id *oid,
 	switch (type) {
 	case OBJ_TAG:
 	case OBJ_COMMIT:
-		obj = parse_object_or_die(oid, NULL);
+		obj = parse_object_or_die(the_repository, oid, NULL);
 		break;
 	case OBJ_TREE:
 		obj = (struct object *)lookup_tree(the_repository, oid);
diff --git a/upload-pack.c b/upload-pack.c
index 222cd3ad89..648ff3355b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1220,7 +1220,7 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 		item = string_list_append(wanted_refs, arg);
 		item->util = oiddup(&oid);
 
-		o = parse_object_or_die(&oid, arg);
+		o = parse_object_or_die(the_repository, &oid, arg);
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
 			add_object_array(o, NULL, want_obj);
-- 
2.23.0

