Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80CCD20281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969137AbdEXFQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36244 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969114AbdEXFQY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:24 -0400
Received: by mail-oi0-f66.google.com with SMTP id w138so31033517oiw.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TTTkKXbsEBDBxyyEqgIEqoTnStC+ucyuQgGukilJ8QQ=;
        b=TcdPsA6alPDUXIkW8grS2pZKOusjavZNYd654pUWnpeIK0rTegHqaIDp6qXBnMZc5B
         kxs5zYcazbVZQuHMToH+AS5STs6IGpS7MXuIjJF67aZNBH6+7n/FqQri4EvIfGBk6lsA
         PA2fAr+t2XB28Iw+uzlWbbIoy+AxVxT5GqvZ7RcW0MoIsZSUBajV601eKcxnnut8cKEG
         jGUfMnwv+PjpaJlcMCZ0BM7Ox3Bh4qVsjdM/+vLajlBppPR3E3rGRWydRl30L9XAalk5
         wynhBonzd5b3epe3l/mgYZRhfB77ry1X4RBBPrNLXkKB7SqTKANrntddwrHw+MxKj7Z6
         0B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TTTkKXbsEBDBxyyEqgIEqoTnStC+ucyuQgGukilJ8QQ=;
        b=EAEumjfz5hwyesOjzKgXm8lfw3gHYmwFbrv4jT1Vb3yN/k93Z0dalM7YD+K7P/FzzC
         JIfsnZdEl0GIro3ofpPk1Yy9oJ5IqBq0IOz4aijywpU9t+vq/09LcrBZlJKr2zYSHswZ
         uucycaBuDCtVa3QEqc8tZ/+wk0Kwi21czsYkhhyBmd8dAEd3OCUerlTPZBIEDdvqa3lH
         4yROgkuQpLS/uAZpnn/VOEzR3XL5KcsOEJBkTRm0ruDOxKGSXjHPKZ2lZavG50MPlUsd
         iFsYTeZyHzEG9DnpmKjO4+fXyD9wUcDZfwhjUpBjWBGwPJ+h9hTRCMyEG6p02yqvggR2
         oPWg==
X-Gm-Message-State: AODbwcDB0Op4Xph2JwjCf6BV/OJ8lKB6Ll9y/iJpLK/aHQGnUQIkurj5
        Y1kGhWfjAxPsjg==
X-Received: by 10.157.25.25 with SMTP id j25mr3951102ota.112.1495602983963;
        Tue, 23 May 2017 22:16:23 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:23 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 06/29] blame: rename origin-related functions
Date:   Wed, 24 May 2017 00:15:14 -0500
Message-Id: <20170524051537.29978-7-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions related to blame_origin that will be publicly exposed should
have names that better reflect what they are a part of.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 58 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 717868e..7854770 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -180,19 +180,19 @@ static void fill_origin_blob(struct diff_options *opt,
  * Origin is refcounted and usually we keep the blob contents to be
  * reused.
  */
-static inline struct blame_origin *origin_incref(struct blame_origin *o)
+static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
 {
 	if (o)
 		o->refcnt++;
 	return o;
 }
 
-static void origin_decref(struct blame_origin *o)
+static void blame_origin_decref(struct blame_origin *o)
 {
 	if (o && --o->refcnt <= 0) {
 		struct blame_origin *p, *l = NULL;
 		if (o->previous)
-			origin_decref(o->previous);
+			blame_origin_decref(o->previous);
 		free(o->file.ptr);
 		/* Should be present exactly once in commit chain */
 		for (p = o->commit->util; p; l = p, p = p->next) {
@@ -205,7 +205,7 @@ static void origin_decref(struct blame_origin *o)
 				return;
 			}
 		}
-		die("internal error in blame::origin_decref");
+		die("internal error in blame_origin_decref");
 	}
 }
 
@@ -393,7 +393,7 @@ static void coalesce(struct blame_scoreboard *sb)
 		    ent->s_lno + ent->num_lines == next->s_lno) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
-			origin_decref(next->suspect);
+			blame_origin_decref(next->suspect);
 			free(next);
 			ent->score = 0;
 			next = ent; /* again */
@@ -461,7 +461,7 @@ static struct blame_origin *get_origin(struct commit *commit, const char *path)
 				o->next = commit->util;
 				commit->util = o;
 			}
-			return origin_incref(o);
+			return blame_origin_incref(o);
 		}
 	}
 	return make_origin(commit, path);
@@ -511,7 +511,7 @@ static struct blame_origin *find_origin(struct commit *parent,
 			 * The same path between origin and its parent
 			 * without renaming -- the most common case.
 			 */
-			return origin_incref (porigin);
+			return blame_origin_incref (porigin);
 		}
 
 	/* See if the origin->path is different between parent
@@ -630,7 +630,7 @@ static void add_blame_entry(struct blame_entry ***queue,
 {
 	struct blame_entry *e = xmalloc(sizeof(*e));
 	memcpy(e, src, sizeof(*e));
-	origin_incref(e->suspect);
+	blame_origin_incref(e->suspect);
 
 	e->next = **queue;
 	**queue = e;
@@ -645,8 +645,8 @@ static void add_blame_entry(struct blame_entry ***queue,
 static void dup_entry(struct blame_entry ***queue,
 		      struct blame_entry *dst, struct blame_entry *src)
 {
-	origin_incref(src->suspect);
-	origin_decref(dst->suspect);
+	blame_origin_incref(src->suspect);
+	blame_origin_decref(dst->suspect);
 	memcpy(dst, src, sizeof(*src));
 	dst->next = **queue;
 	**queue = dst;
@@ -687,7 +687,7 @@ static void split_overlap(struct blame_entry *split,
 
 	if (e->s_lno < tlno) {
 		/* there is a pre-chunk part not blamed on parent */
-		split[0].suspect = origin_incref(e->suspect);
+		split[0].suspect = blame_origin_incref(e->suspect);
 		split[0].lno = e->lno;
 		split[0].s_lno = e->s_lno;
 		split[0].num_lines = tlno - e->s_lno;
@@ -701,7 +701,7 @@ static void split_overlap(struct blame_entry *split,
 
 	if (same < e->s_lno + e->num_lines) {
 		/* there is a post-chunk part not blamed on parent */
-		split[2].suspect = origin_incref(e->suspect);
+		split[2].suspect = blame_origin_incref(e->suspect);
 		split[2].lno = e->lno + (same - e->s_lno);
 		split[2].s_lno = e->s_lno + (same - e->s_lno);
 		split[2].num_lines = e->s_lno + e->num_lines - same;
@@ -717,7 +717,7 @@ static void split_overlap(struct blame_entry *split,
 	 */
 	if (split[1].num_lines < 1)
 		return;
-	split[1].suspect = origin_incref(parent);
+	split[1].suspect = blame_origin_incref(parent);
 }
 
 /*
@@ -767,7 +767,7 @@ static void decref_split(struct blame_entry *split)
 	int i;
 
 	for (i = 0; i < 3; i++)
-		origin_decref(split[i].suspect);
+		blame_origin_decref(split[i].suspect);
 }
 
 /*
@@ -830,10 +830,10 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			n->next = diffp;
 			diffp = n;
 		} else
-			origin_decref(e->suspect);
+			blame_origin_decref(e->suspect);
 		/* Pass blame for everything before the differing
 		 * chunk to the parent */
-		e->suspect = origin_incref(parent);
+		e->suspect = blame_origin_incref(parent);
 		e->s_lno += offset;
 		e->next = samep;
 		samep = e;
@@ -874,7 +874,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			 */
 			int len = same - e->s_lno;
 			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
-			n->suspect = origin_incref(e->suspect);
+			n->suspect = blame_origin_incref(e->suspect);
 			n->lno = e->lno + len;
 			n->s_lno = e->s_lno + len;
 			n->num_lines = e->num_lines - len;
@@ -1000,7 +1000,7 @@ static void copy_split_if_better(struct blame_scoreboard *sb,
 	}
 
 	for (i = 0; i < 3; i++)
-		origin_incref(this[i].suspect);
+		blame_origin_incref(this[i].suspect);
 	decref_split(best_so_far);
 	memcpy(best_so_far, this, sizeof(struct blame_entry [3]));
 }
@@ -1280,7 +1280,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 						     this);
 				decref_split(this);
 			}
-			origin_decref(norigin);
+			blame_origin_decref(norigin);
 		}
 
 		for (j = 0; j < num_ents; j++) {
@@ -1321,8 +1321,8 @@ static void pass_whole_blame(struct blame_scoreboard *sb,
 	suspects = origin->suspects;
 	origin->suspects = NULL;
 	for (e = suspects; e; e = e->next) {
-		origin_incref(porigin);
-		origin_decref(e->suspect);
+		blame_origin_incref(porigin);
+		blame_origin_decref(e->suspect);
 		e->suspect = porigin;
 	}
 	queue_blames(sb, porigin, suspects);
@@ -1418,7 +1418,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 				continue;
 			if (!oidcmp(&porigin->blob_oid, &origin->blob_oid)) {
 				pass_whole_blame(sb, origin, porigin);
-				origin_decref(porigin);
+				blame_origin_decref(porigin);
 				goto finish;
 			}
 			for (j = same = 0; j < i; j++)
@@ -1430,7 +1430,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 			if (!same)
 				sg_origin[i] = porigin;
 			else
-				origin_decref(porigin);
+				blame_origin_decref(porigin);
 		}
 	}
 
@@ -1442,7 +1442,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		if (!porigin)
 			continue;
 		if (!origin->previous) {
-			origin_incref(porigin);
+			blame_origin_incref(porigin);
 			origin->previous = porigin;
 		}
 		pass_blame_to_parent(sb, origin, porigin);
@@ -1513,7 +1513,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	for (i = 0; i < num_sg; i++) {
 		if (sg_origin[i]) {
 			drop_origin_blob(sg_origin[i]);
-			origin_decref(sg_origin[i]);
+			blame_origin_decref(sg_origin[i]);
 		}
 	}
 	drop_origin_blob(origin);
@@ -1762,7 +1762,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 		 * We will use this suspect later in the loop,
 		 * so hold onto it in the meantime.
 		 */
-		origin_incref(suspect);
+		blame_origin_incref(suspect);
 		parse_commit(commit);
 		if (reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
@@ -1794,7 +1794,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 				break;
 			}
 		}
-		origin_decref(suspect);
+		blame_origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
 			sanity_check_refcnt(sb);
@@ -2857,13 +2857,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		ent->suspect = o;
 		ent->s_lno = bottom;
 		ent->next = next;
-		origin_incref(o);
+		blame_origin_incref(o);
 	}
 
 	o->suspects = ent;
 	prio_queue_put(&sb.commits, o->commit);
 
-	origin_decref(o);
+	blame_origin_decref(o);
 
 	range_set_release(&ranges);
 	string_list_clear(&range_list, 0);
-- 
2.9.3

