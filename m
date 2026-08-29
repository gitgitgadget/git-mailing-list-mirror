Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19519049B
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787969116; cv=none; b=tGn7blowxj8Y51KXe2zVEI8yOBmzkVo56GH0dzDN0miLIFI5K3Dhy/7q7OMmviMVIbO9APln1Fep339TzWcFY2a2xnotsLEfyb9DF3cLan0X33RucJCEzBBaUCSxntpxzmt05uZoLFKkZ/gSZjNytwRlAaO1WhpOpHBHI2IDaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787969116; c=relaxed/simple;
	bh=304igJMOPdcfelrFAQklzsK9NYqnQyvWWuH3XD9a8DA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahnuXIWGhEzv9yqxB036NTFMxqEQKheUKbzhCJsjiRIGX1kMA8RhbzjFRh+IH0PhARlCs0v8fyuo4BsCUL0N6V4LQI0iTODUIj3p8IEE6A0pNK0EN4pasP4lE3mx4tACnybenzlqu9EJZOnIYVGqOofYnJVrDNQoAjqVhYAjF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WlIr6Rlf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AYD8LEmV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WlIr6Rlf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AYD8LEmV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8351BEC0253;
	Fri, 28 Aug 2026 22:05:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 28 Aug 2026 22:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787969113; x=1788055513; bh=OBmMff+k95
	UxlT/zRstgjH+SBI3v6Cjnp2NQiiFCM1o=; b=WlIr6RlfDMfokFAcgnDuVbJGxN
	1P9n+iQQVCfF1/hdT85OqsAqnZx8XcOxU6n5wBJZeq023viLGxS+wOi+qJ/Sbxcc
	m2HSoebpRB56hBRQD2joiooCT7ZgjgsCWhWgGDTSR3cJCP+NI8mB4iW/canDFDpa
	kfOzUztNbEsPPKCONMwggYyKzUErhdl7hAh36cokKGZ6Q9gdLsXj01hqeIXUTbuu
	gR4sckR4O1N3HQtTN0po+BlOgGQnCOBQ5P5ge5VoBFIp0A7XYyzNEZZD6+uegcys
	5VMOHMWFSYjQ2AFKbOVC3qsO8LKuCSDSqRkNksMAQEjJVJUyVPImYbsUe6Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787969113; x=1788055513; bh=OBmMff+k95UxlT/zRstgjH+SBI3v6Cjnp2N
	QiiFCM1o=; b=AYD8LEmVZLXNWjoCqNbVf+Ach/MAlrJbD/R+hBwZIglgRaq9BNV
	PMXXx2GI6BKF4B85W9N7xXg6YhnQYPpwbxDjIBB/ui6IFbA/K7gGkVBPGLBojb+9
	CVEbK3YpawbDVF57mpavljI5by+8eAi5jqceGQMw7DHNUiDQ/r2E4wXdzxUhJbSo
	gxsd7Fd8GZlQBBuNLABaHIPis5mCoX1XmRWP9br88Y7BWEnXJN3TWMDCmfREW3rA
	o9EkAfyRoEhZ8sV2pT8WAOQ14dL/b8P9ePyrIhxO2H2KRSYLXLLqycMJkwrARyON
	faP3KEahF/XvbMM0VaVJO/k8TY0AARVpLJw==
X-ME-Sender: <xms:WT6SaqJ1TEzjO8MkcT4Aq7Fk1o6Hl9bwXtT2ssj2GkdY7wi04FqnRA>
    <xme:WT6SaoJBKfTRe7mkUwmzHQhgSsc9vDCqZcJFNsg7pfwUYeIipLB19QD66s0CJ2x7D
    cjdAWvNpnSNtGENNJ4lEP89UDUaw4cjIsS8U9WB94w0nA_-l8g7O1E>
X-ME-Received: <xmr:WT6SaoWmjFp-3B9RTFi8B-G9CE11lDo4XyG_PU_Ul6R-kYZU06154ybpUd_ZnU3jZsnEGnG_oWB9cG0tOgBAkLrckxyRiFeZSQ>
X-ME-Proxy-Cause: dmFkZTEo3J1ML0uGpJ9/1rZJPa+Mxr16L1sCum9dgNW1qGfOY2waMnDJBW468js75N1S6T
    oBkxgvD3KEjlBEcnOIeCTgKfPEnOFSdJd5UcakBpKBTLKGSFuKSdsEtDmezFMFVy4UnO6T
    PDQx4YU85gRHWDDPaHKzOp2sSd+Q/4Yl9yFccpxU9wtuf7B4jmLvB7/tu0UsGkRMMJKj7F
    vwPy6iknbcyfat0uJRAOr2uupXIGMSlzNhg4dg9vPYNwl7vXHy3gmiwrjGqqc5qT/KsuZE
    tj1YBUuyUvaRR4y07+ZplAFzMd2BpFlx9VetdtnlIL+LdIRHlkpkP4pU0HRDji9h3cgDDr
    vaBACvWByWwnjDHJzKtGohaivVgSRiye5vRQuqATWnAeHjDw3hKGthlCf98T1vF+s45xSU
    ZwXFASsbjgi3q+yVSgUREfCHfSB2vgYsUb+Kn6vYJg+MBxvjOgGN4ZQuAVbalwgRemNPhI
    UvwM0nPS1xEFYlciT+1Jb84WslQqjWGTzAXjGwhSR4doWl8gR7Iev6TSj3irsNRwhKcAhs
    jx+/m2hp3FB7KSGPr8FjQYXHuF93sGp07fuf0KrKACW/OlaFHkZRQS/R/g0xX6b4+sTU8G
    /IwDuAfk5q/hnMfnIfA5SduroRRjQogLUplgQ+dqcwXlv7oghCahpzVI6oiw
X-ME-Proxy: <xmx:WT6Saqit9Ou2usrXyild-xa-78WSDXbk_Kz2YCklZ_i80BTwXm1h6w>
    <xmx:WT6Saj9e2fsGDw8NT-AKnmZZfEPLNrhN_lelHCQDwK-8ccrFhTqKJA>
    <xmx:WT6SakCm5adXcCElrqhj7cO1bC7yJbz6O7CmOVaCufaH4InS9K9nUw>
    <xmx:WT6SagL8uW7FPE0xnLdeON6GTrVoKSR4VCmcbeVtdrS6EVnFDp_nrA>
    <xmx:WT6Satj8Bs067783PNJtKs6wJj5QElIWKU_k4T5ASQOxkoW5-YYeinMb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 22:05:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 8/8] checkout: move post_checkout_hook() to checkout.c
In-Reply-To: <xmqq7bl93lbk.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	28 Aug 2026 15:57:19 -0700")
References: <xmqqh5kd3lm3.fsf@gitster.g>
	<20260828225206.310500-1-gitster@pobox.com>
	<20260828225206.310500-9-gitster@pobox.com>
	<xmqq7bl93lbk.fsf@gitster.g>
Date: Fri, 28 Aug 2026 19:05:11 -0700
Message-ID: <xmqqse3x1y20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Not a very good illustration.  We should teach the caller to pass
> "struct repository *repo" to this function, and then teach this
> function to learn what hash algorithm to use from the given
> repository instance.

I've locally amended this step like so.

The dependency on 'the_repository' has been removed.  While OK when
the helper was in builtin/checkout.c as an integral part of 'git
checkout' (and 'git restore'), this is no longer true for a common
utility function.  So it now takes a pointer to 'struct repository'
and uses its associated hash algorithm.

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

