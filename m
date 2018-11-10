Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C7B1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeKJP15 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:27:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44641 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJP15 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:27:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so3348376lji.11
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOzCYZnQT4760vTDxQbUCAatLHnjUOs0uu4toctDar4=;
        b=cpfE8tU8DQyxUrL3GV5rkJOTV6k4a13g7sk7A8bFA09cGyziLEAyHjgrF0PFNSLyLM
         ba4XA21P0cSSqbT8QvMLd+RalTaBwfaZlkBuQcQ3nUlyeECLOBHr/LsYI1lJm7dIF63V
         W/NJqMZFUmmzBykvCl3qpF899W5HEX7JVgUoRRP90d84QapHtErvAGvyAsSdXOWfv7b5
         QIPlxRvD9LCTX0FzVkcEzhxakY65e+cT2AQql0M48bPHvAhO0Yte436fuydbqY5XHP2t
         89bRB+AZeOOHCVm/ssAbA3TP7TfLnqAZCWFfynBjdqHaRfNCDtiV9WtsoiRPkUm1CYIk
         bZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOzCYZnQT4760vTDxQbUCAatLHnjUOs0uu4toctDar4=;
        b=oLHC86VXMKTtXDhiW6y/nmmqMKT8gWf5p5Cp6PBZ0Ks/oN3U3hicttLBqSE7ZewclG
         ChKxv9bHkVZonL0ikBNsYUJcCXZh5t8xqa2429QqgKz9WsmbtKEy6vqXQiOPyOrCEJdt
         yoJXuZyeJVbOZl9vekxP6IQwAHxs28TFCsuzonLEdvviWJf6rpSjvxVQHiHpF+HnNuI2
         LncBJzKDfku+JAMotoPWO60FK2V4yYoUUJwB8xRg5pZru/En4lEWGHP8cQYaymHzyLeh
         IJ/k+fQuKjxx2PMg3Is84kI4q6NqW2RCx5UwO942vowU4duYEE6SKB+mOOSoXmlaqXL3
         2sgg==
X-Gm-Message-State: AGRZ1gKk6q9OKr9Lq8CJ0FNWL3CUp5F8ZoDBc07Bnnqaf1O0pk+BoNZy
        mYAcb0SOwbpiOva11lfiK50=
X-Google-Smtp-Source: AJdET5cERef8phUjmjykhoIXxDdPyRmSHqIjD8BtUV5IzJYevjavhJO7iznde0ZLB183j25FhywWAQ==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr7000850ljk.114.1541826993366;
        Fri, 09 Nov 2018 21:16:33 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:32 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 10/16] remote.c: mark messages for translation
Date:   Sat, 10 Nov 2018 06:16:09 +0100
Message-Id: <20181110051615.8641-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two strings are slightly modified to be consistent with the rest:
die() and error() start with a lowercase.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 remote.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/remote.c b/remote.c
index 257630ff21..11b33d1625 100644
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
2.19.1.1231.g84aef82467

