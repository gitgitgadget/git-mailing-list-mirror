Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7491F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeBFA0l (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:26:41 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45863 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeBFA0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:26:39 -0500
Received: by mail-pg0-f68.google.com with SMTP id m136so160194pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YzWDWdZiWqDupQ0HA5Cx8rtZO7kHjWT3qtrqJ6UKCVs=;
        b=HI2L7whXm+xisfwsM46jZJwpPqdcpwUJc973PwpPXhtNIjCCVwxMgddqAzPpU3/jHe
         pxyx+HBctP/ljlKHdAfvxxVXQF+51yn2dWpLxS5N0pqnRoBsvo3TeJ7sXpO+AZXLfJ6u
         GkpwqGnPZ3h0RXV1j8YypGZrFhoXpzaVmoErO851+AKBfwfrLw5nTbFwe8dHRk8cmNQT
         UCu6lWyMJ9E5eTwbeYYp3vIQCHcGbaGAGRRq2r/RuJCT49hxCSmlVLi00N6X4Bq0H7om
         oPTF+OzB52ol/N9IR2aEZLLAHgiGYmz5T5CzQt2k336ji2w9oFKOrhrW0klCZRCsWDhz
         yvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YzWDWdZiWqDupQ0HA5Cx8rtZO7kHjWT3qtrqJ6UKCVs=;
        b=kSzTh5W7tf9jvexlJjKf7tI76JBXma8OZAzfIV2KBDw1yCoOVhf97KafaEXmrZfsvW
         4Vy7/Cff12rdgJn8S4IjB9BC9DwD+FFfKtadUmyxnBbU8+evstVc3icjaEdrh3ya94Tb
         c0mw5SBUKjBYgQAKv/oQKJiacL78TUBNCwV91gA/hysJxqzMhhfyRn+S4sswyqK90qWN
         ySirmrxfLlFw6YvIsJ8CidGLpXZIEkZL/fUXV0EYWkDBOcVsqLMoLCEvfYA+FukMdnp+
         2i+Jm2UG6Fn0ab/rGT6OciQ28e/HJAuJuV/6/AGHrf6HfK367KmfeNUrov2XAhVG+Ddm
         aGGw==
X-Gm-Message-State: APf1xPAgcCj0i1nbPc+jXVFaNLA1dyPlDIilRA8tvNCHGZm9vW6UK+5g
        j7ve6s4y+tkq3PYo3xH3PZez138STaQ=
X-Google-Smtp-Source: AH8x225r5VJHmB88+5VgxJeIJ/WfhkV3Qe4FC0wV/mhoRJmWPu8ArUzcxwKM8bF/6fwCknBAWpFNsA==
X-Received: by 10.98.75.218 with SMTP id d87mr559306pfj.11.1517876798618;
        Mon, 05 Feb 2018 16:26:38 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q15sm3912105pgv.38.2018.02.05.16.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:26:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 153/194] shallow: add repository argument to register_shallow
Date:   Mon,  5 Feb 2018 16:17:08 -0800
Message-Id: <20180206001749.218943-55-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-objects.c | 2 +-
 builtin/receive-pack.c | 2 +-
 commit.h               | 3 ++-
 fetch-pack.c           | 2 +-
 shallow.c              | 4 ++--
 upload-pack.c          | 7 ++++---
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 77275058e4..a16ecc3fe0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2864,7 +2864,7 @@ static void get_object_list(int ac, const char **av)
 				struct object_id oid;
 				if (get_oid_hex(line + 10, &oid))
 					die("not an SHA-1 '%s'", line + 10);
-				register_shallow(&oid);
+				register_shallow(the_repository, &oid);
 				use_bitmap_index = 0;
 				continue;
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 22d805a8ff..7d00f0bad6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -905,7 +905,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	 * not lose these new roots..
 	 */
 	for (i = 0; i < extra.nr; i++)
-		register_shallow(&extra.oid[i]);
+		register_shallow(the_repository, &extra.oid[i]);
 
 	si->shallow_ref[cmd->index] = 0;
 	oid_array_clear(&extra);
diff --git a/commit.h b/commit.h
index 7ef21a0fbf..0c854d3679 100644
--- a/commit.h
+++ b/commit.h
@@ -196,7 +196,8 @@ extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n,
 
 struct oid_array;
 struct ref;
-extern int register_shallow(const struct object_id *oid);
+#define register_shallow(r, o) register_shallow_##r(o);
+extern int register_shallow_the_repository(const struct object_id *oid);
 extern int unregister_shallow(const struct object_id *oid);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
 extern int is_repository_shallow(void);
diff --git a/fetch-pack.c b/fetch-pack.c
index e8b1fc0d1b..1cd738fd62 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -425,7 +425,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (skip_prefix(line, "shallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
 					die(_("invalid shallow line: %s"), line);
-				register_shallow(&oid);
+				register_shallow(the_repository, &oid);
 				continue;
 			}
 			if (skip_prefix(line, "unshallow ", &arg)) {
diff --git a/shallow.c b/shallow.c
index c26e99fedd..67feeb3a4f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -29,7 +29,7 @@ void set_alternate_shallow_file_the_repository(const char *path, int override)
 	alternate_shallow_file = xstrdup_or_null(path);
 }
 
-int register_shallow(const struct object_id *oid)
+int register_shallow_the_repository(const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
@@ -70,7 +70,7 @@ int is_repository_shallow(void)
 		struct object_id oid;
 		if (get_oid_hex(buf, &oid))
 			die("bad shallow line: %s", buf);
-		register_shallow(&oid);
+		register_shallow(the_repository, &oid);
 	}
 	fclose(fp);
 	return is_shallow;
diff --git a/upload-pack.c b/upload-pack.c
index 9c003553f8..ed2d394ace 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -646,7 +646,7 @@ static void send_shallow(struct commit_list *result)
 		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
 			packet_write_fmt(1, "shallow %s",
 					 oid_to_hex(&object->oid));
-			register_shallow(&object->oid);
+			register_shallow(the_repository, &object->oid);
 			shallow_nr++;
 		}
 		result = result->next;
@@ -683,7 +683,7 @@ static void send_unshallow(const struct object_array *shallows)
 			add_object_array(object, NULL, &extra_edge_obj);
 		}
 		/* make sure commit traversal conforms to client */
-		register_shallow(&object->oid);
+		register_shallow(the_repository, &object->oid);
 	}
 }
 
@@ -887,7 +887,8 @@ static void receive_needs(void)
 		if (shallows.nr > 0) {
 			int i;
 			for (i = 0; i < shallows.nr; i++)
-				register_shallow(&shallows.objects[i].item->oid);
+				register_shallow(the_repository,
+						 &shallows.objects[i].item->oid);
 		}
 
 	shallow_nr += shallows.nr;
-- 
2.15.1.433.g936d1b9894.dirty

