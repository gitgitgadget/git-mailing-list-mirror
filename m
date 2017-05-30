Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95CE2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbdE3Rbo (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:44 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35383 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdE3Rbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:42 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so78336722pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bOFJ0FdEPhhvNw4kYVjpn+C6LbvEaxMi9sihD6eWaxk=;
        b=WAMbrRkVuUU9i1N4AUZ84Z4AkZOdybje/8oLGeQUeJ+6p5wliS4QdWOfkYobsqEMwx
         G3viwmy0Ux917AZcJnE7DnC0dgYD8/Hwa7Yk7z7lFw2Guo4J72qHMLzdd6ifdyzIe0Jq
         iDyz28AqKEE5wmuA7QSi2Y4VKfhIRzRp2BQwjf9AfYDdMXC2WxxSV93T4jfHpscHpqwu
         jasUCk1CYagOAEkat3H/47rCP42uYuyZp29CJZaqPXKKwzyeKdsP5XJuzIW5tk71KuCm
         49hVYov3cVNy4+CB1AMqcafXmRiqtJKY013cWgiCCvQaUcS/jxVkF06D+iTWiKLOB5Gj
         WmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bOFJ0FdEPhhvNw4kYVjpn+C6LbvEaxMi9sihD6eWaxk=;
        b=J1/ToHl0a7IiNYT37LXHykgR/GBrA7Y/wsWOWi5o55ks/6LURKEYJjabfLHCC2QxV6
         16+SqIszKt7aLNJE+v5kpBKo0WgyBluEWdFANyyQgzznbYRlOV9WgKz9cMfnfYLKiVX6
         erSBkv4vDtnLtetBoBbcUCm0eRgrabcrlBp5rHdd4JQy+ay9RqX5owhjf6mRmpSv0nCt
         aB08weywjzUTnoQBT66ms268/CObuxVFqNYgCgs05CNuhj0wI7RixhccQDNXBa8FZI7D
         EGrPeF+54eYofPXQUhP4YbdKS0pq0jeWDFU8ooBugExxCIvKKZr/L4VrQBp5xrEkSM/l
         ggEA==
X-Gm-Message-State: AODbwcA4zz9OHxwVAVIUVx9ToOuZhxumAXcOdmkwBXH4uD+kBlzeh7em
        nJVBx4/4e8+p1dYzn/n6sA==
X-Received: by 10.99.174.77 with SMTP id e13mr26679247pgp.145.1496165501160;
        Tue, 30 May 2017 10:31:41 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:39 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 17/33] patch-ids: convert to struct object_id
Date:   Tue, 30 May 2017 10:30:53 -0700
Message-Id: <20170530173109.54904-18-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/log.c |  2 +-
 patch-ids.c   | 20 ++++++++++----------
 patch-ids.h   |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a440601ef..6bdba3444 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1354,7 +1354,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		struct object_id *patch_id;
 		if (commit->util)
 			continue;
-		if (commit_patch_id(commit, &diffopt, oid.hash, 0))
+		if (commit_patch_id(commit, &diffopt, &oid, 0))
 			die(_("cannot get patch id"));
 		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
 		patch_id = bases->patch_id + bases->nr_patch_id;
diff --git a/patch-ids.c b/patch-ids.c
index 92eba7a05..aab26cbbb 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -11,7 +11,7 @@ static int patch_id_defined(struct commit *commit)
 }
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    unsigned char *sha1, int diff_header_only)
+		    struct object_id *oid, int diff_header_only)
 {
 	if (!patch_id_defined(commit))
 		return -1;
@@ -22,7 +22,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1, diff_header_only);
+	return diff_flush_patch_id(options, oid->hash, diff_header_only);
 }
 
 /*
@@ -39,15 +39,15 @@ static int patch_id_cmp(struct patch_id *a,
 			struct patch_id *b,
 			struct diff_options *opt)
 {
-	if (is_null_sha1(a->patch_id) &&
-	    commit_patch_id(a->commit, opt, a->patch_id, 0))
+	if (is_null_oid(&a->patch_id) &&
+	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&a->commit->object.oid));
-	if (is_null_sha1(b->patch_id) &&
-	    commit_patch_id(b->commit, opt, b->patch_id, 0))
+	if (is_null_oid(&b->patch_id) &&
+	    commit_patch_id(b->commit, opt, &b->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&b->commit->object.oid));
-	return hashcmp(a->patch_id, b->patch_id);
+	return oidcmp(&a->patch_id, &b->patch_id);
 }
 
 int init_patch_ids(struct patch_ids *ids)
@@ -71,13 +71,13 @@ static int init_patch_id_entry(struct patch_id *patch,
 			       struct commit *commit,
 			       struct patch_ids *ids)
 {
-	unsigned char header_only_patch_id[GIT_MAX_RAWSZ];
+	struct object_id header_only_patch_id;
 
 	patch->commit = commit;
-	if (commit_patch_id(commit, &ids->diffopts, header_only_patch_id, 1))
+	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1))
 		return -1;
 
-	hashmap_entry_init(patch, sha1hash(header_only_patch_id));
+	hashmap_entry_init(patch, sha1hash(header_only_patch_id.hash));
 	return 0;
 }
 
diff --git a/patch-ids.h b/patch-ids.h
index b9e5751f8..bec0f727a 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -3,7 +3,7 @@
 
 struct patch_id {
 	struct hashmap_entry ent;
-	unsigned char patch_id[GIT_MAX_RAWSZ];
+	struct object_id patch_id;
 	struct commit *commit;
 };
 
@@ -13,7 +13,7 @@ struct patch_ids {
 };
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    unsigned char *sha1, int);
+		    struct object_id *oid, int);
 int init_patch_ids(struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
-- 
2.13.0.219.gdb65acc882-goog

