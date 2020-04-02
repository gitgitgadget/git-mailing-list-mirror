Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC517C2BA16
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8361D20737
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njFdZPYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbgDBTT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:19:28 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42845 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732937AbgDBTT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 15:19:28 -0400
Received: by mail-pg1-f201.google.com with SMTP id g10so3858561pgg.9
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bmeGpckLvyJH+KO+r8gy9KGUkRNvdgUpS/eIbC3Vj9c=;
        b=njFdZPYdb/rkogAJx5GmiqF6b9Yu6VxNi+DwUfUKYk+IvIBLZphPb31kg4Efgdo67E
         oZ0Vgwzc87Gnc0o9u8ED24oq1GyRUJ98RhCFNg+qVX66cK/Bf1gjb2SWWg3Dg3pj+gjl
         iJKq7hy+dOxHZJGrOWctalv56s3iXb/wPvzDTqrIKbj4uqi0h+rCdGP28E+C85W7kDIE
         06HmkrWaZp9aMymjPUDPY3t8sxt6Wi1tnsEJn6SweLxaxCghnFTP1M+PuGq8oDxx1ptO
         iUJUtfA15xpsHDVulEs5nFDYxD26UowHSvRoVH03wNEWRwxRzzKlSIG7bm1q/U8+n7Hf
         876Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bmeGpckLvyJH+KO+r8gy9KGUkRNvdgUpS/eIbC3Vj9c=;
        b=j/+tA7S819MURHcSEamQLKzcEUleJAlTc7lUXV4NBBxK13I0irHp7JfSxwtCnARuwE
         z3VzvTlBpgReKLvuQVFCulLqcG35i83XSm+ywu1xbR5gDG+7hPaNICjAbgCiFFMcmASr
         aHhIbo0wqQxu+YYmHuYdxX0tPjvVMHrHXUQHc8zoTsnk15QRVRLM6dxTKRaQfGEDhc/8
         suqIUpaRwpiM82J+bi69C4ig0sCMZlnc0UXy7fu5XdJulCgpHPrisw0GZr8PEPZh2hHj
         6jFIeyuv44Mz7IO1oEy+6AxvzyrPkjaUdXMznpDlZoCpBOOh0bxOS1FHcVf67+c+xZ8c
         Rb/w==
X-Gm-Message-State: AGi0PuaES3rO5LN4tQARfguZz3MJWQhnW2z7qpwSaBXnZ5SB76SwqjSG
        bZUR9Zup2VSwXNhZoAheQQUZvD91Pi1ucYOPv7uxwSOQIl8Evn+CQVmQKHVwz4rhZM998vuOi22
        IFd+hLaY4FCJu3PHSAgqCTVjpygW4zSZOmhF/0V6W0IPRM760QkxQG+DWdurE1/lkBTrapOFQDa
        Zi
X-Google-Smtp-Source: APiQypKASzfwmKuXLoAUtlxPakZzsqWzu1Qw4yIVfa8jOBj5O0jWHRsC6febPXV6c2a3NGrGIqauH4/+KkJn4p7Wio2q
X-Received: by 2002:a17:90a:ab0a:: with SMTP id m10mr5539158pjq.105.1585855166836;
 Thu, 02 Apr 2020 12:19:26 -0700 (PDT)
Date:   Thu,  2 Apr 2020 12:19:16 -0700
In-Reply-To: <cover.1585854639.git.jonathantanmy@google.com>
Message-Id: <474eb27d9c136fb69e961546004cfb531d722e2c.1585854639.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200331020418.55640-1-jonathantanmy@google.com> <cover.1585854639.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v2 1/2] promisor-remote: accept 0 as oid_nr in function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are 3 callers to promisor_remote_get_direct() that first check if
the number of objects to be fetched is equal to 0. Fold that check into
promisor_remote_get_direct(), and in doing so, be explicit as to what
promisor_remote_get_direct() does if oid_nr is 0 (it returns 0, success,
immediately).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c |  5 ++---
 diff.c               | 11 +++++------
 promisor-remote.c    |  3 +++
 promisor-remote.h    |  8 ++++++++
 unpack-trees.c       |  5 ++---
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d967d188a3..f176dd28c8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1368,9 +1368,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 				continue;
 			oid_array_append(&to_fetch, &d->oid);
 		}
-		if (to_fetch.nr)
-			promisor_remote_get_direct(the_repository,
-						   to_fetch.oid, to_fetch.nr);
+		promisor_remote_get_direct(the_repository,
+					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 
diff --git a/diff.c b/diff.c
index 1010d806f5..f01b4d91b8 100644
--- a/diff.c
+++ b/diff.c
@@ -6520,12 +6520,11 @@ void diffcore_std(struct diff_options *options)
 			add_if_missing(options->repo, &to_fetch, p->one);
 			add_if_missing(options->repo, &to_fetch, p->two);
 		}
-		if (to_fetch.nr)
-			/*
-			 * NEEDSWORK: Consider deduplicating the OIDs sent.
-			 */
-			promisor_remote_get_direct(options->repo,
-						   to_fetch.oid, to_fetch.nr);
+		/*
+		 * NEEDSWORK: Consider deduplicating the OIDs sent.
+		 */
+		promisor_remote_get_direct(options->repo,
+					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 9f338c945f..2155dfe657 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -241,6 +241,9 @@ int promisor_remote_get_direct(struct repository *repo,
 	int to_free = 0;
 	int res = -1;
 
+	if (oid_nr == 0)
+		return 0;
+
 	promisor_remote_init();
 
 	for (r = promisors; r; r = r->next) {
diff --git a/promisor-remote.h b/promisor-remote.h
index 737bac3a33..6343c47d18 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -20,6 +20,14 @@ struct promisor_remote {
 void promisor_remote_reinit(void);
 struct promisor_remote *promisor_remote_find(const char *remote_name);
 int has_promisor_remote(void);
+
+/*
+ * Fetches all requested objects from all promisor remotes, trying them one at
+ * a time until all objects are fetched. Returns 0 upon success, and non-zero
+ * otherwise.
+ *
+ * If oid_nr is 0, this function returns 0 (success) immediately.
+ */
 int promisor_remote_get_direct(struct repository *repo,
 			       const struct object_id *oids,
 			       int oid_nr);
diff --git a/unpack-trees.c b/unpack-trees.c
index f618a644ef..4c3191b947 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -423,9 +423,8 @@ static int check_updates(struct unpack_trees_options *o)
 				continue;
 			oid_array_append(&to_fetch, &ce->oid);
 		}
-		if (to_fetch.nr)
-			promisor_remote_get_direct(the_repository,
-						   to_fetch.oid, to_fetch.nr);
+		promisor_remote_get_direct(the_repository,
+					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 	for (i = 0; i < index->cache_nr; i++) {
-- 
2.26.0.292.g33ef6b2f38-goog

