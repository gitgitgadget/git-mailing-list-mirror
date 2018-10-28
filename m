Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE001F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJ1Pf5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34286 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeJ1Pf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id n26-v6so3743251lfl.1
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQVSExHnUwhG2EPgQ/94UDJTceY0O+VNXHgtXyl0wGU=;
        b=fSRmvHPMUzIEqB3/Uw3XnoVPMAvmQ5BZkyGfzeCH/NiCSZk4YLxkOhOaOo6qCvHHVJ
         YGOIsrf26SV4E6A1n2e8VU12Ps4BngAlYs2e5cljU18pEm3F8qbrJ64ZgauJv6/G6+88
         h+dRi1cR3WvVLBULlLU5j4hSdwQxNxa8rjNqsTwO5gqv//pklaJ8N/5pELzK46RWxY8y
         JoYOWIKbz4TSCsF/6Cj6IfTXpkxC0+QcARoKA8vnrIsBhyGjF9CKMr1woG95qV2TuqSo
         GXstMvgLl5nXw9CG3QQEOKQ12dl7fKAiGP3VH3KlvHFD8n75nJGlAx9+VedBuVicbGw/
         aeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQVSExHnUwhG2EPgQ/94UDJTceY0O+VNXHgtXyl0wGU=;
        b=Q+rRBvjIqQtyML8JnFrbZ+gONaa8m42252m6gkOI3Fxvz9YoSUy9UjPHYgr5ZZ8UFa
         9eVl1IdY7pxbfch/0cm+RX7ASfaCh2ZOrrh2OJmfOb3ATXRzQGFvliW/IahsCN3WfbAv
         vBS4yxRntPMdqKyBfH+ka5HRqplJjKimOgr2j1IflNoNjZqRejzfrL16Ai5h7kG8sVLX
         RiyIBEp9obG1xHJWww2R1lv7y+A5jknvzFyD3WPcGynKimIIge5TdJYikeMpqxtMXs/0
         3iPMp3xuZ/rPpWPvqGpE1R6+PpglSpP3/LF7gKUELva5Dv/uibguDwPbham/CyWJEfdx
         BHmA==
X-Gm-Message-State: AGRZ1gK8Nf7zwgcPRjiludI+D1SmyZRrSjTkmpXIkWMLU6/SB6IkAF+F
        bEHT1u4Ti+/Mes8hbVxYFTgQvGSl
X-Google-Smtp-Source: AJdET5e9y+6V9EjTHd3iVj088Xpl2i+W6JA1kOLajIYkL74B6KaSMxC+7y6SNhuUHYZJAVzaPonXMA==
X-Received: by 2002:a19:5186:: with SMTP id g6mr5403954lfl.143.1540709531063;
        Sat, 27 Oct 2018 23:52:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/12] remote.c: mark messages for translation
Date:   Sun, 28 Oct 2018 07:51:53 +0100
Message-Id: <20181028065157.26727-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 remote.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/remote.c b/remote.c
index 81f4f01b00..11b33d1625 100644
--- a/remote.c
+++ b/remote.c
@@ -359,7 +359,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		return 0;
 	/* Handle remote.<name>.* variables */
 	if (*name == '/') {
-		warning("Config remote shorthand cannot begin with '/': %s",
+		warning(_("config remote shorthand cannot begin with '/': %s"),
 			name);
 		return 0;
 	}
@@ -406,7 +406,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!remote->receivepack)
 			remote->receivepack = v;
 		else
-			error("more than one receivepack given, using the first");
+			error(_("more than one receivepack given, using the first"));
 	} else if (!strcmp(subkey, "uploadpack")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
@@ -414,7 +414,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!remote->uploadpack)
 			remote->uploadpack = v;
 		else
-			error("more than one uploadpack given, using the first");
+			error(_("more than one uploadpack given, using the first"));
 	} else if (!strcmp(subkey, "tagopt")) {
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
@@ -620,7 +620,7 @@ static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 			 * FETCH_HEAD_IGNORE entries always appear at
 			 * the end of the list.
 			 */
-			die(_("Internal error"));
+			BUG("Internal error");
 		}
 	}
 	free(ref2->peer_ref);
@@ -680,7 +680,7 @@ static int match_name_with_pattern(const char *key, const char *name,
 	size_t namelen;
 	int ret;
 	if (!kstar)
-		die("Key '%s' of pattern had no '*'", key);
+		die(_("key '%s' of pattern had no '*'"), key);
 	klen = kstar - key;
 	ksuffixlen = strlen(kstar + 1);
 	namelen = strlen(name);
@@ -690,7 +690,7 @@ static int match_name_with_pattern(const char *key, const char *name,
 		struct strbuf sb = STRBUF_INIT;
 		const char *vstar = strchr(value, '*');
 		if (!vstar)
-			die("Value '%s' of pattern has no '*'", value);
+			die(_("value '%s' of pattern has no '*'"), value);
 		strbuf_add(&sb, value, vstar - value);
 		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
 		strbuf_addstr(&sb, vstar + 1);
@@ -707,7 +707,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	int find_src = !query->src;
 
 	if (find_src && !query->dst)
-		error("query_refspecs_multiple: need either src or dst");
+		BUG("query_refspecs_multiple: need either src or dst");
 
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
@@ -735,7 +735,7 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	char **result = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
-		return error("query_refspecs: need either src or dst");
+		BUG("query_refspecs: need either src or dst");
 
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
@@ -995,12 +995,12 @@ static int match_explicit_lhs(struct ref *src,
 		 * way to delete 'other' ref at the remote end.
 		 */
 		if (try_explicit_object_name(rs->src, match) < 0)
-			return error("src refspec %s does not match any.", rs->src);
+			return error(_("src refspec %s does not match any"), rs->src);
 		if (allocated_match)
 			*allocated_match = 1;
 		return 0;
 	default:
-		return error("src refspec %s matches more than one.", rs->src);
+		return error(_("src refspec %s matches more than one"), rs->src);
 	}
 }
 
@@ -1030,7 +1030,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     !starts_with(dst_value, "refs/heads/")))
-			die("%s cannot be resolved to branch.",
+			die(_("%s cannot be resolved to branch"),
 			    matched_src->name);
 	}
 
@@ -1041,30 +1041,30 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		if (starts_with(dst_value, "refs/"))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else if (is_null_oid(&matched_src->new_oid))
-			error("unable to delete '%s': remote ref does not exist",
+			error(_("unable to delete '%s': remote ref does not exist"),
 			      dst_value);
 		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
 		} else
-			error("unable to push to unqualified destination: %s\n"
-			      "The destination refspec neither matches an "
-			      "existing ref on the remote nor\n"
-			      "begins with refs/, and we are unable to "
-			      "guess a prefix based on the source ref.",
+			error(_("unable to push to unqualified destination: %s\n"
+				"The destination refspec neither matches an "
+				"existing ref on the remote nor\n"
+				"begins with refs/, and we are unable to "
+				"guess a prefix based on the source ref."),
 			      dst_value);
 		break;
 	default:
 		matched_dst = NULL;
-		error("dst refspec %s matches more than one.",
+		error(_("dst refspec %s matches more than one"),
 		      dst_value);
 		break;
 	}
 	if (!matched_dst)
 		return -1;
 	if (matched_dst->peer_ref)
-		return error("dst ref %s receives from more than one src.",
-		      matched_dst->name);
+		return error(_("dst ref %s receives from more than one src"),
+			     matched_dst->name);
 	else {
 		matched_dst->peer_ref = allocated_src ?
 					matched_src :
@@ -1750,7 +1750,7 @@ int get_fetch_map(const struct ref *remote_refs,
 			ref_map = get_remote_ref(remote_refs, name);
 		}
 		if (!missing_ok && !ref_map)
-			die("Couldn't find remote ref %s", name);
+			die(_("couldn't find remote ref %s"), name);
 		if (ref_map) {
 			ref_map->peer_ref = get_local_ref(refspec->dst);
 			if (ref_map->peer_ref && refspec->force)
@@ -1763,7 +1763,7 @@ int get_fetch_map(const struct ref *remote_refs,
 			if (!starts_with((*rmp)->peer_ref->name, "refs/") ||
 			    check_refname_format((*rmp)->peer_ref->name, 0)) {
 				struct ref *ignore = *rmp;
-				error("* Ignoring funny ref '%s' locally",
+				error(_("* Ignoring funny ref '%s' locally"),
 				      (*rmp)->peer_ref->name);
 				*rmp = (*rmp)->next;
 				free(ignore->peer_ref);
@@ -1858,7 +1858,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	repo_init_revisions(the_repository, &revs, NULL);
 	setup_revisions(argv.argc, argv.argv, &revs, NULL);
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 
 	/* ... and count the commits on each side. */
 	while (1) {
@@ -2131,7 +2131,8 @@ static int parse_push_cas_option(struct push_cas_option *cas, const char *arg, i
 	else if (!colon[1])
 		oidclr(&entry->expect);
 	else if (get_oid(colon + 1, &entry->expect))
-		return error("cannot parse expected object name '%s'", colon + 1);
+		return error(_("cannot parse expected object name '%s'"),
+			     colon + 1);
 	return 0;
 }
 
-- 
2.19.1.647.g708186aaf9

