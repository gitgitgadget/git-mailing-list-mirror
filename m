Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360530F548
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122930; cv=none; b=E7jDb2iCMa82mpv0L7wdh7AmInHN4bg6WUo9fIaSicTHIIGma/VMbNgnA6LvhcRDg0GCsYJAOj7aIO22Yrpurp0h5tRsLtYaza3gcaUh2BlcSgq0P4Unc3FKhwzFRawIFS8wnLTXF3pat1E5JwNVTp6/53s0Xned6cp6ucoYJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122930; c=relaxed/simple;
	bh=K7+VkvR3ZXjinFAQoSb5+5OaI0U/D+i6082HInzktJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKDN4lMfbO5xoJYXAl3KQyuu49Pwr05YkunygjXdDdg+F+BPSr4m8ix2wbHSNY42P9gAcxcDM82oNbjkFTmXDqCb/BBOsvlyZ4rdc5Rhzij0Hu6xdYksCKfjfpxFeaY8lTFZ8rKotq3F/jfUpwtVTNvPbj1QBf1k/X3cJjq2AN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i+70xFLB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQKKNDIz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i+70xFLB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQKKNDIz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 32889EC0086;
	Sun, 30 Aug 2026 16:48:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 30 Aug 2026 16:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122928; x=
	1788209328; bh=5zm6q5g+iSY9B1IwWenRPfQ33djHCNWzxeYiqiAw3T8=; b=i
	+70xFLBaIT+2S+ZPl8hOmRvtrQpOQN49d3oyPWhpY6aCAvJ2tqYiAjKirFxrWrym
	d7OG31kJ5QGCm9AtthCwKHvH+bKsKnCLZBb+El0xmAuQVQqGe375vsgyZA1h3n7N
	8CgJae668G6f5778FDbZUmBNdHHHIsILSsOkM/iW2iOKf0bNti2j7pm92SN8lDuA
	NUDvPYGKyjRwFaQg0f42Sn1xSZXjhQhhNh4k22wtWDSKZY4z2+gWca/opGzc28J/
	QSeDGmgdIEwveZF0PZCajSRLrM3BZ8OWqg7w6liwJlFs9aN90PG1z6g8tOVO39RH
	8JlInUqIho1TLZ6kqdxjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122928; x=1788209328; bh=5zm6q5g+iSY9B1IwWenRPfQ33djH
	CNWzxeYiqiAw3T8=; b=MQKKNDIztHERwA6aSxD2UlqFu+gPp/kIXKYGzgdUgY3u
	qKLc+OQiP3xB+z2MiuZRPz5tBgH2Jg5TCnb807spulLvIc6YuHk88Wl0atjVTmeK
	1ZqPcB8WoJ6SP2uLxcGtM5iFl6DHGbRfg/7I+mYPW5Q59rCj0jce0lZ3O8Wy1VTF
	a/ia5ZIYuqmy3O5Tw8PMPegrKfXWlC3AWpOBVNfuH7JF8RzxHdVp/jiyNs5T7dk9
	9FLyieKpLLQdqy5Ngju8WRpHdLm3tUE56ApaBCu1ohAUMT7Srdyv2Y48V3luR6/9
	F/6ABYz+3MHyZJOPLLqLOBRHkhTkaZ1I7t0qgqw11A==
X-ME-Sender: <xms:MJeUahy5EUqrNqya_GNpeVYpafs_IWOBQ6Acva5naT0w6Z1Bp7NgJw>
    <xme:MJeUanSYPjy94ux13XYY-HB28ZsxVG-afCBDnSc8gTIDB3pj0gPLlFt5_cdSuPdVO
    kww7QjXI_PFK54ufMDfF65pPYoGt500BPfHh1SDHocJ9mcEKxte>
X-ME-Received: <xmr:MJeUao8X2DrKBukm7ibQ6WRz8Cl_KezCz3wDfVqEvHHluaEH1LkroUPstlVVYcLGm5HbVyfeIpMQ9Torp5e-NxJuJkQhrAq-JA>
X-ME-Proxy-Cause: dmFkZTFScx5N3yID/Wd8piL81iio/vbFBvkFUjI0kIswckuEWS4J5hDifEykfqhESoeOdC
    mwVC8gsuMoEHcRCa0lvsSozaXSelQ6CrY0zT742PYgh1E2l/nRGebCx4/z1qYDE67jEG39
    /B2iVXiolehkRkNhZgPNwdXbXryA2vLv8f0n8e9ovVR6aOgUoOuueTLTatZkiWO+ay2+6r
    c0lcpVsTuIoMHKtwg2MuyTGIZdu33aW/DIf85hVtEgSZr+eNkyWfTuwnHkUaE19zISEs6P
    GdP8ByQrI20KvDmh30LXRH/4yC8jlRNe4SFbibbt/pnsMtVQm6k9k69VKYlig4q9SCItUo
    r8cHOclxLQAGtBkqUcrPHD7PQA6sIV9fxhYSIiIYG6fvTlrgmVDko75JtJc3h37cZYZIvN
    kDOqrSg7G9eJtKb9EPkr7N3059YTgSYlEUGo3nIpmY4lQZ6c325hxQJ1iuV9qU6JODzJyZ
    BgOPtAVDMombAu6TovXILmhXLJorkK0TLHtbETFFda2poP9n0k4Zrn80uU0lMNebKJ7Yld
    Wtvew7Hk9o0yY7PC/U8Yh36M41nTyyKrNUx+bNvfIwmAzPESnM473SE8O2a0CetR+MtcTX
    wFx/LOfqQLeuWZzr9/oWiiog4vEjPMFgEV2o1L4w1b5HCz364clCdnHBXNlw
X-ME-Proxy: <xmx:MJeUaurK2hSdhg7MgbSJ9iRKaX6WTzcKh1JoOz59xDX7_TKnm1ngYw>
    <xmx:MJeUalkf9VjIoGJrADP9ijG8A0rOkAMxbGc-sQaK4TaqMLDEYnpx6g>
    <xmx:MJeUalI6LMxvozakjJmYFyJq4rPmhYQHNMh1u7lT5s9B5UzHyVwNOg>
    <xmx:MJeUaqwzZ2ZiPfc9w9zHECdmmGy8RfgpFqEFOVk-SsIlYHB4qJXhSw>
    <xmx:MJeUalKFpdJpl4RMXfPSCavZtbr65ULt9hvys7PZXQXCob_UeUqpctP->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 8/8] checkout: move post_checkout_hook() to checkout.c
Date: Sun, 30 Aug 2026 13:48:35 -0700
Message-ID: <20260830204835.1040408-9-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260830204835.1040408-1-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com>
 <20260830204835.1040408-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

post_checkout_hook() in builtin/checkout.c runs the 'post-checkout' hook
after switching branches or checking out paths.

Move post_checkout_hook() to checkout.c and declare it in checkout.h
so that other subsystems can invoke the post-checkout hook without
depending on builtin/checkout.c.

Remove the dependency on 'the_repository'.  While OK when the helper
was in builtin/checkout.c as an integral part of 'git checkout' (and
'git restore'), this is no longer true for a common utility
function.  Have it take a pointer to 'struct repository' and use its
associated hash algorithm.

This step in the series is entirely optional and is here primarily
for illustration.  We may later want to teach 'git worktree' to
trigger the 'post-checkout' hook, for example, in which case such
libification may turn out to be useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 23 +++--------------------
 checkout.c         | 28 ++++++++++++++++++++++++++++
 checkout.h         | 10 ++++++++++
 3 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9771c848c5..c6e29e9526 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -124,24 +124,6 @@ static void branch_info_release(struct branch_info *info)
 	free(info->checkout);
 }
 
-static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
-			      int changed)
-{
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
-
-	/*
-	 * "new_commit" can be NULL when checking out from the index before
-	 * a commit exists.
-	 */
-	strvec_pushl(&opt.args,
-		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
-		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
-		     changed ? "1" : "0",
-		     NULL);
-
-	return run_hooks_opt(the_repository, "post-checkout", &opt);
-}
-
 /*
  * Handle a tree object and determine if we need to recurse into the
  * tree (READ_TREE_RECURSIVE) or skip it (0).
@@ -718,7 +700,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			   &rev, NULL);
 	head = lookup_commit_reference_gently(the_repository, &rev, 1);
 
-	errs |= post_checkout_hook(head, head, 0);
+	errs |= post_checkout_hook(the_repository, head, head, 0);
 	return errs;
 }
 
@@ -1273,7 +1255,8 @@ static int switch_branches(const struct checkout_opts *opts,
 		}
 	}
 
-	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
+	ret = post_checkout_hook(the_repository,
+				 old_branch_info.commit, new_branch_info->commit, 1);
 	branch_info_release(&old_branch_info);
 	strbuf_release(&old_commit_shortname);
 	strbuf_release(&autostash_msg);
diff --git a/checkout.c b/checkout.c
index 1588b116ee..28c5c18d96 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,6 +1,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "commit.h"
+#include "hex.h"
+#include "hook.h"
 #include "object-name.h"
 #include "remote.h"
 #include "refspec.h"
@@ -8,6 +11,7 @@
 #include "checkout.h"
 #include "config.h"
 #include "strbuf.h"
+#include "strvec.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
@@ -73,3 +77,27 @@ char *unique_tracking_name(const char *name, struct object_id *oid,
 	}
 	return NULL;
 }
+
+int post_checkout_hook(struct repository *repo,
+		       struct commit *old_commit, struct commit *new_commit,
+		       int changed)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+	const struct git_hash_algo *hash_algo = repo->hash_algo;
+
+	/*
+	 * "new_commit" can be NULL when checking out from the index before
+	 * a commit exists.
+	 */
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit
+				? &old_commit->object.oid
+				: null_oid(hash_algo)),
+		     oid_to_hex(new_commit ?
+				&new_commit->object.oid
+				: null_oid(hash_algo)),
+		     changed ? "1" : "0",
+		     NULL);
+
+	return run_hooks_opt(repo, "post-checkout", &opt);
+}
diff --git a/checkout.h b/checkout.h
index 55920e7aeb..6d8d2c2bab 100644
--- a/checkout.h
+++ b/checkout.h
@@ -3,6 +3,9 @@
 
 #include "hash.h"
 
+struct commit;
+struct repository;
+
 /*
  * Check if the branch name uniquely matches a branch name on a remote
  * tracking branch.  Return the name of the remote if such a branch
@@ -12,4 +15,11 @@ char *unique_tracking_name(const char *name,
 			   struct object_id *oid,
 			   int *dwim_remotes_matched);
 
+/*
+ * Run the post-checkout hook.
+ */
+int post_checkout_hook(struct repository *,
+		       struct commit *old_commit, struct commit *new_commit,
+		       int changed);
+
 #endif /* CHECKOUT_H */
-- 
2.55.0-884-g76cf8659c2

