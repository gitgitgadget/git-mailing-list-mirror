Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19539DBFD
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957543; cv=none; b=jsB5T4ZuBc7dj4Arqk1g/hRalfQsZIMz3Gisecc13Yy0xNSdo6aoXP8n+My+HSq86HAT0Pu2u57Bk7gv+4JbHcLgwYWaXfD/hYHio1mLhN9UssvTarjpF4q10zs/DJ3gEXg/BFl8DdasxWQLsoahnAo0ADvlbIi4rb6LdR/i7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957543; c=relaxed/simple;
	bh=V4+3np65tUXMVbkoStslbQEtnhBv/xNfb05SLMPCPUo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYirfH4f9wOKOWIdZgw6xjjI0LEOO+6C+0/HKeRhkZ13/tSEk5daLB2McvEx3U6Q25a6wDcwWb8/8IpJLwl1wtNT4CApPVKuHXCI8vG2NP5BuGQ4b5CvRYqDHfNCkFh2WbkycOef0/tFLeywxrXt2jPGY7VfW9PIyMPEqmztVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dYEq3Et+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QhtuBj22; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dYEq3Et+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QhtuBj22"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B9A37A0096;
	Fri, 28 Aug 2026 18:52:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 28 Aug 2026 18:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957541; x=
	1788043941; bh=VVam8XbaCPUXQVSm18rUfyLiqOib/jAuDWq/zK4JjxY=; b=d
	YEq3Et+1HDboNC5J4fSQucS/2nB9e/3DUUqR/YW7GKxYMRblywB0mR6dcZ6x8INz
	YUzBMHNwXv1j6qOtQoHaahf8VMhtM/a2goyXFGWLExoc+LaGEkt8RtxTLz9DitGL
	z13P+68Hs4gTJs777bOMT1fzhSkjC+8MTqzcPs5SZnxZ2NcaNnpcHpEsxO7/r5vR
	JXcE+j1sbrmIRE7900ABJF+b8QJsJa4qnEU3BhRGayjcAWz6gNEE6Ej68fqWzJiv
	DZaq1KIVoD1vWJzga873WN8Og0khhsq+ESKl5uzzwFpOstOzZGredQLJCyyIB3BZ
	jGqHPFd1F9wg+1wgsjc9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957541; x=1788043941; bh=VVam8XbaCPUXQVSm18rUfyLiqOib
	/jAuDWq/zK4JjxY=; b=QhtuBj22XuyfXT7YCtk6gXAl8J8aZXARCJMDp+PhHgq+
	P72ygaGYXUNrONOKeAww8yq2h+NO4sIrdeSIxp8/cgW+MZskKFW2d0RiEM8VpVkW
	SXXYNnR+nfXwHp+JGOFD6+ZLSCJfD1rcoABI8wOr+f4jOiW2SDNO/BQVsS+PsqSZ
	JK2o9seRCWWlglDXevZdC9bEsDYFDdJjyLBdTuoEBntLrRPfKt6KRp5hhmqtEqfd
	21r4aUV7oqYt6gCaA1o3Ti4u3+1pHCly+vRightIo89LbHVQ348sZlyfItRQlylT
	Q42kut2hiyg8xDlthykep1dGTrNZfqDGJZnNIDP6Bw==
X-ME-Sender: <xms:JBGSap1pzakHHEdKe6NZlcyusAIpUWt4gvNI8ZPkYW2c1Gc1mtwNaQ>
    <xme:JBGSamGlqDSAaJiEeUsnwEiXc0NAq5CLHmH0Gv54E9S5yf8hewchqmMNJeQVcctdh
    vJa4IdDEpggvh5FX9dVc3mVpOUlCAed8qYihgDEQnpkG3-fvi9gEZg>
X-ME-Received: <xmr:JBGSaniGGLhKf7Tc5Y7S3qd-0MHtj7H8XW6vDZfJVMmoFGDLrG-W0dgjE80BQ7hvJ1rDLoVZibmJYsdCxbgdavQ46mMSqDNe3A>
X-ME-Proxy-Cause: dmFkZTFrpTwiHSUIsRhuhIiyrg7KUJfh8QuYcswElzTZ4rtsLKaTl9LXy9loZ6Dem46BTd
    Msc70tAIzbu2UrQ72NkrqLHHtw7kFWJpBZWHuRjpPNQabzm6J0mQ1IPakv6Qo2b/eqSuSe
    qKgkf1OnRlOBC9OntmJixzclU6NABD+p3iN/TntlCnhtUXXFTSQVGyaHm90KPuo3Iu5GOA
    AusCH1lf7XL1OY3nD/SbcdRFcM7KIzNYdQDjHDcgPiigF2sbk+c39sl9gLJeQwDL5Tfn4s
    dV0Dijl7kJPRsJ5E8bzvsG4oNuvqC0mt5ebla5FPqk3FV5qddScKupypraISBWl61wLPdW
    +XQV2XK/2l++fSbwj7SdSNjsPrj9zc1xfatD5wE3BrZK9JDgX+17WdYFla1AU0bQKQF//l
    l7SoPRcLEqRPkKa6DzGzu8R4CT+XgHN+e3JnowbA1oXIa5+xqFQNdR1fNaY9+BWvA2M4cq
    we0sH9i9yMIfN1LlI0UvE80B4MVp29hyjrGFfXTTuAHxojLMF5p26JPAApZXCjc9coJOZ5
    NDeSo0s7ovC1ybrEz08UC/F4SpfXv8lmFQeTIIzj24mE1e1fMxdq3EK2qhUq80NWiDPyYj
    UvzU37xuS8aP7Mv3KAhtwsO/d2/0VuWO6HCBJzh6rSIpgPVNk86zS/79PHUw
X-ME-Proxy: <xmx:JBGSah9au5mKSJMWOM7QBCarzlxoGrMjroQdrhMJIjtCgQgBDvrZcQ>
    <xmx:JBGSauq2F6jVKiqan5z4iy3hYyRmMh0Wxkwq9QIogZKteuzoI26MUA>
    <xmx:JBGSag8JvwmEcnFBcT2uWJmMZCA05EmTrjfhZ6vrbDuRoZvEz3T_IA>
    <xmx:JBGSaiUI4_9lXuZJgkEYKHkAQKUrQBenbO7Zhvj0Kbx1dfa5f9jLyw>
    <xmx:JRGSalOKcOskFTrtXnDnfuj4VgB2yotSgY3d0yNv7K7b0jz09ncYqmKY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 8/8] checkout: move post_checkout_hook() to checkout.c
Date: Fri, 28 Aug 2026 15:52:06 -0700
Message-ID: <20260828225206.310500-9-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260828225206.310500-1-gitster@pobox.com>
References: <xmqqh5kd3lm3.fsf@gitster.g>
 <20260828225206.310500-1-gitster@pobox.com>
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

This step in the series is entirely optional and is here primarily
for illustration.  We may later want to teach 'git worktree' to
trigger the 'post-checkout' hook, for example, in which case such
libification may turn out to be useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 18 ------------------
 checkout.c         | 22 ++++++++++++++++++++++
 checkout.h         |  8 ++++++++
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f13d70b224..b13e2ff205 100644
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
diff --git a/checkout.c b/checkout.c
index 1588b116ee..d007648f50 100644
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
@@ -73,3 +77,21 @@ char *unique_tracking_name(const char *name, struct object_id *oid,
 	}
 	return NULL;
 }
+
+int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
+		       int changed)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
+	/*
+	 * "new_commit" can be NULL when checking out from the index before
+	 * a commit exists.
+	 */
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
+		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
+		     changed ? "1" : "0",
+		     NULL);
+
+	return run_hooks_opt(the_repository, "post-checkout", &opt);
+}
diff --git a/checkout.h b/checkout.h
index 55920e7aeb..9c2f2449dc 100644
--- a/checkout.h
+++ b/checkout.h
@@ -3,6 +3,8 @@
 
 #include "hash.h"
 
+struct commit;
+
 /*
  * Check if the branch name uniquely matches a branch name on a remote
  * tracking branch.  Return the name of the remote if such a branch
@@ -12,4 +14,10 @@ char *unique_tracking_name(const char *name,
 			   struct object_id *oid,
 			   int *dwim_remotes_matched);
 
+/*
+ * Run the post-checkout hook.
+ */
+int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
+		       int changed);
+
 #endif /* CHECKOUT_H */
-- 
2.55.0-884-g76cf8659c2

