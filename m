Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9409C32771
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 04:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9452084D
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 04:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPAu55VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbgALEPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 23:15:34 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:36802 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732129AbgALEPd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 23:15:33 -0500
Received: by mail-pj1-f73.google.com with SMTP id m61so4422476pjb.1
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 20:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I8ZJrKMmNogbEz2NWWc/mcIMb8/ne05IGgMc3OYFcQk=;
        b=PPAu55VKuqPNa3Qylka8UsmRDkp1mtYOKpZYV2WU6kHEJvQWK34+2hQKqiMJfkJur6
         jK7W1A8zjd1P/zhderCCisivmzfZwsFfItAmv+IJBpE7qYYsiP/4UWmn03B531rxTk6k
         Al2IsXqEUPcBks1b+NmISwE2kUEAMlUqYCfkYIvL4yE/vr3BVSoxPr7Xdr0yeCUw1hmL
         CKnzBgnixrtunB/fphG8IteAsnD2kQfCWjB15i9jVyVIRA5YXR7GA8F8H4uT65GZvHim
         Esj2FclSAuFHuRE/ipdJbiJDCSUzYbx8vTSTAL45VoA3fhlMCpoDcZazVrbyeziwk4ZT
         4ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I8ZJrKMmNogbEz2NWWc/mcIMb8/ne05IGgMc3OYFcQk=;
        b=GK/FbR0UlDQbcqPZ9San1jFDirmYvIJX+oMp5tQkIP9QfYykSclMo9ofoTivvxdjTC
         LbpG64xu35pIfETDjxvV5E/+wmA1h1IetKmxmQ/qrZNs8QWQwjcrYHrrB5mY90HyUz78
         1qH/94KQ3VH6z3AsEicHLE35VY2YrScHvDP+gxaM3cn3de9bB+xOW/y52z3LZ4pbeRt4
         c4oY37zZ28s/LaTeEQc2puZdEQK4mXb8U5U1x5u4hicseAldC7NuCYSw+p5YdZ28YbPu
         wNNnIFad0vcK6XqUe/NVVMkfWLm5ZTt7SOT01RnQi+Ymf7Bk8VUUKOTCJ0g5Fp5WioqJ
         bYJw==
X-Gm-Message-State: APjAAAWCIelFQKHdNIqNvBSr02Et7T/jB1kXRDLK8/5eZ63MH7I+ix40
        glVABvrX9UQOWKXC7YZAErm4y25pcHkD85DvrT9xh7SXiResMG0xDdFlmlVE/VPi+PhA3t3Vj5/
        JqUd1WqOyXGNr3Ju/0qoJbbpXlUYswhfjLt43w3UGiJ0ikC7ea0mSgWXWxarNaHdb1uVFbV0lWn
        m9
X-Google-Smtp-Source: APXvYqy7sRYA8ps2PhjmEausecKgmwSkXNgzQpsN4kKkCKIHMaghu8f16vH3yB9swogdrLicx7B+bHj6z9X8WlaRt5N7
X-Received: by 2002:a65:56c6:: with SMTP id w6mr14697230pgs.167.1578802532934;
 Sat, 11 Jan 2020 20:15:32 -0800 (PST)
Date:   Sat, 11 Jan 2020 20:15:24 -0800
In-Reply-To: <cover.1578802317.git.jonathantanmy@google.com>
Message-Id: <6a4f704e475fe1669e63731333fce9ed09d17d0c.1578802317.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1578802317.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 1/2] connected: verify promisor-ness of partial clone
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit dfa33a298d ("clone: do faster object check for partial clones",
2019-04-21) optimized the connectivity check done when cloning with
--filter to check only the existence of objects directly pointed to by
refs. But this is not sufficient: they also need to be promisor objects.
Make this check more robust by instead checking that these objects are
promisor objects, that is, they appear in a promisor pack.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c |  5 +++--
 connected.c     | 19 ++++++++++++++-----
 connected.h     | 11 ++++++-----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0fc89ae2b9..0516181052 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -673,7 +673,7 @@ static void update_remote_refs(const struct ref *refs,
 			       const char *msg,
 			       struct transport *transport,
 			       int check_connectivity,
-			       int check_refs_only)
+			       int check_refs_are_promisor_objects_only)
 {
 	const struct ref *rm = mapped_refs;
 
@@ -682,7 +682,8 @@ static void update_remote_refs(const struct ref *refs,
 
 		opt.transport = transport;
 		opt.progress = transport->progress;
-		opt.check_refs_only = !!check_refs_only;
+		opt.check_refs_are_promisor_objects_only =
+			!!check_refs_are_promisor_objects_only;
 
 		if (check_connected(iterate_ref_map, &rm, &opt))
 			die(_("remote did not send all necessary objects"));
diff --git a/connected.c b/connected.c
index c337f5f7f4..7e9bd1bc62 100644
--- a/connected.c
+++ b/connected.c
@@ -52,19 +52,28 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_release(&idx_file);
 	}
 
-	if (opt->check_refs_only) {
+	if (opt->check_refs_are_promisor_objects_only) {
 		/*
 		 * For partial clones, we don't want to have to do a regular
 		 * connectivity check because we have to enumerate and exclude
 		 * all promisor objects (slow), and then the connectivity check
 		 * itself becomes a no-op because in a partial clone every
 		 * object is a promisor object. Instead, just make sure we
-		 * received the objects pointed to by each wanted ref.
+		 * received, in a promisor packfile, the objects pointed to by
+		 * each wanted ref.
 		 */
 		do {
-			if (!repo_has_object_file_with_flags(the_repository, &oid,
-							     OBJECT_INFO_SKIP_FETCH_OBJECT))
-				return 1;
+			struct packed_git *p;
+
+			for (p = get_all_packs(the_repository); p; p = p->next) {
+				if (!p->pack_promisor)
+					continue;
+				if (find_pack_entry_one(oid.hash, p))
+					goto promisor_pack_found;
+			}
+			return 1;
+promisor_pack_found:
+			;
 		} while (!fn(cb_data, &oid));
 		return 0;
 	}
diff --git a/connected.h b/connected.h
index ce2e7d8f2e..eba5c261ba 100644
--- a/connected.h
+++ b/connected.h
@@ -48,12 +48,13 @@ struct check_connected_options {
 	unsigned is_deepening_fetch : 1;
 
 	/*
-	 * If non-zero, only check the top-level objects referenced by the
-	 * wanted refs (passed in as cb_data). This is useful for partial
-	 * clones, where enumerating and excluding all promisor objects is very
-	 * slow and the commit-walk itself becomes a no-op.
+	 * If non-zero, only check that the top-level objects referenced by the
+	 * wanted refs (passed in as cb_data) are promisor objects. This is
+	 * useful for partial clones, where enumerating and excluding all
+	 * promisor objects is very slow and the commit-walk itself becomes a
+	 * no-op.
 	 */
-	unsigned check_refs_only : 1;
+	unsigned check_refs_are_promisor_objects_only : 1;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
-- 
2.25.0.rc1.283.g88dfdc4193-goog

