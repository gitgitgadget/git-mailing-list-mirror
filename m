Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F443204F74
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905892; cv=none; b=nBtP0lvI8EiWibT+ehSuhaJ5FkUGi+gPLaUrprdHgZ58y2NNED/1x4IMn3Tbs0wB/dvWDbSRbVVofwEtRGKo6syENn6c1tDfInNhIvFMeloCp0nH3qWFXhaEhpfzY6zsiQIr71OJpesPtg9TILg3Ewx2ZMKii4ZsQeZiC5wV3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905892; c=relaxed/simple;
	bh=xfDBzPWcTjWs5icWTrPCX0/mhEI+qIYw+0wiKW5lGOE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plNQ2gAVm0UErnr2tXohAOlzbWuy6PBzfVz8aoeXDJ+OBCi/UxHs0/xT17sr1vWb5syXF9rvH1m4MsfhoEim+hzNIHh99idNgb2Ua3px166B5jNSgHomyINs5QxkH8z3cvDpARX2/UrrCMD/CX30EXVthEurLnI3X5JuwS3WD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f20Vnlvf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ga3YWBe6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f20Vnlvf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ga3YWBe6"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 658731140084
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 10:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905890; x=1730992290; bh=Uz+t6wSNdL
	y4mwoJczEDXdHpRHiZ9HQoMh+GE/nGDpY=; b=f20VnlvfkrODRE9MeAyLJNFOJp
	uyeNU1ucrqfEPIxXg6ZchxbRc0OJyW+W3M3nxP1ErmXyIbfchrwp2gWOTyO5E1cx
	/aTe3q+64BhBrunH/XQmSBdtmF9dIc99Mtts6LO7AP3vll2A2sf/TxQJACzDDjAl
	WXur6SmYbfSyFJO09rt3uWB0r2oT1PraIavZ7aZpBMDK/cIne8ezswm1826H4F7X
	dos9DzwEs7c5IDlFhUoequC9dIu1a90TlYagSCDV5kSOw5gkUd6L+vawaTbgwmzO
	Uzn4FAhQiyWRVKX2vUd9VeVbZb1lKUAJIbFTaY4xyvjkiDfB6c/y6Vwj7glg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905890; x=1730992290; bh=Uz+t6wSNdLy4mwoJczEDXdHpRHiZ9HQoMh+
	GE/nGDpY=; b=Ga3YWBe6EKwjRTk0t9H8bpq1Lme+WGCLKsp2SSISeH8nZ0WGonL
	POet1fnz0YG0k4ybFa78PXxjryJktA+dyW8HFktYnDY8e2PeL20yno1awtWMuA13
	9J63t3VnN58UmjqvyOpTsayOV/GjRgX7QaHW4BiAjagCAqS/qy5BFlGChCoOF2gy
	kg5q16LpJ/d9RFTmvd1oqw1C9w/KqGZAs3ihSiMSd4acW4qbBFqo4E54yK5wnJIH
	6aaODdJw4dBjrh/ovUBFVEQ7LXwkKH5LLutNmvNpF/mLESRx+E2gMCLAwyWIkiiC
	f1iO3cRMcGELUzFW1pclncgdSMD/oTYLsxw==
X-ME-Sender: <xms:IocrZxbJr52BzJiAFYan6VrvxDQZ7kBeNNAdxJbiEAQsGtULWXW74w>
    <xme:IocrZ4Z-wM6F7RaoDpBZzt4mkOY7k5La296I5rchFtgk_SnfnPBqBfUEwZgBW57aP
    oACYaU9xk1beb2mqg>
X-ME-Received: <xmr:IocrZz-bisjRYNyz3fVnyw8Hih621QXLdmGx5mg6JqqZa9PNkItYwk2-3zgXotXRGd5AiGVPrNwcme2QFiGISQj313E_MTiWe_L8lnpmre54Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IocrZ_ofdu8CWMjHziI6-DzxqOIvAzkP4AtBZHVD_tPrdAv97e2Pow>
    <xmx:IocrZ8r9wZjyNsQeZGZE-hQtr67qGnWLbMKkTdderdpKcvGIOwYawQ>
    <xmx:IocrZ1Qnu_ea3G6_lDcQUHbMntnGZHVOrS_ILwv0Jv220ByIqN9zaw>
    <xmx:IocrZ0rIEixlmrOll-wsPocWcBdfTYPdJS0KC6TO3DKeOSRwvrZJRg>
    <xmx:IocrZ5BwjzyjdSP_6IbRCLtK7a0Fcx1aJUG0cWq8gfT97KZU5_fc5e05>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5736cb8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:11:05 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/26] git-compat-util: drop `UNLEAK()` annotation
Message-ID: <2d64a941d511a88a25c1f8258b5c5682089fdae9.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

There are two users of `UNLEAK()` left in our codebase:

  - In "builtin/clone.c", annotating the `repo` variable. That leak has
    already been fixed though as you can see in the context, where we do
    know to free `repo_to_free`.

  - In "builtin/diff.c", to unleak entries of the `blob[]` array. That
    leak has also been fixed, because the entries we assign to that
    array come from `rev.pending.objects`, and we do eventually release
    `rev`.

This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
easy for the annotation to become stale. A second issue is that its
whole intent is to paper over leaks. And while that has been a necessary
evil in the past, because Git was leaking left and right, it isn't
really much of an issue nowadays where our test suite has no known leaks
anymore.

Remove the last two users and drop the now-unused `UNLEAK()` annotation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  1 -
 builtin/diff.c    |  1 -
 git-compat-util.h | 20 --------------------
 usage.c           | 15 ---------------
 4 files changed, 37 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 59fcb317a68..e851b1475d7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1586,7 +1586,6 @@ int cmd_clone(int argc,
 	free(dir);
 	free(path);
 	free(repo_to_free);
-	UNLEAK(repo);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	transport_ls_refs_options_release(&transport_ls_refs_options);
diff --git a/builtin/diff.c b/builtin/diff.c
index dca52d4221e..2fe92f373e9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -628,6 +628,5 @@ int cmd_diff(int argc,
 	release_revisions(&rev);
 	object_array_clear(&ent);
 	symdiff_release(&sdiff);
-	UNLEAK(blob);
 	return result;
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index e4a306dd563..a06d4f3809e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1527,26 +1527,6 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-/*
- * You can mark a stack variable with UNLEAK(var) to avoid it being
- * reported as a leak by tools like LSAN or valgrind. The argument
- * should generally be the variable itself (not its address and not what
- * it points to). It's safe to use this on pointers which may already
- * have been freed, or on pointers which may still be in use.
- *
- * Use this _only_ for a variable that leaks by going out of scope at
- * program exit (so only from cmd_* functions or their direct helpers).
- * Normal functions, especially those which may be called multiple
- * times, should actually free their memory. This is only meant as
- * an annotation, and does nothing in non-leak-checking builds.
- */
-#ifdef SUPPRESS_ANNOTATED_LEAKS
-void unleak_memory(const void *ptr, size_t len);
-#define UNLEAK(var) unleak_memory(&(var), sizeof(var))
-#else
-#define UNLEAK(var) do {} while (0)
-#endif
-
 #define z_const
 #include <zlib.h>
 
diff --git a/usage.c b/usage.c
index 7a2f7805f57..29a9725784a 100644
--- a/usage.c
+++ b/usage.c
@@ -350,18 +350,3 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 	trace2_cmd_error_va(fmt, ap);
 	va_end(ap);
 }
-
-#ifdef SUPPRESS_ANNOTATED_LEAKS
-void unleak_memory(const void *ptr, size_t len)
-{
-	static struct suppressed_leak_root {
-		struct suppressed_leak_root *next;
-		char data[FLEX_ARRAY];
-	} *suppressed_leaks;
-	struct suppressed_leak_root *root;
-
-	FLEX_ALLOC_MEM(root, data, ptr, len);
-	root->next = suppressed_leaks;
-	suppressed_leaks = root;
-}
-#endif
-- 
2.47.0.229.g8f8d6eee53.dirty

