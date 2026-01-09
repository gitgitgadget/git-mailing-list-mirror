Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406C35C1A1
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962401; cv=none; b=uQiHF5UJZY1lvMaBJDYRj17sC/Y4vsDUg99QJ64Y50O2xxQajkTcXRbZorJoqgX2Q33kS5SV8xyMgexsQ55rK5s+4Tz5V8ek1zH9JvNrGGEa7htWqToaM+I9JFnOxyTVejbG9iTUwX97gTVgNDNZ6n98VoaiSXmUkSH0kdonxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962401; c=relaxed/simple;
	bh=Mzv5JI5+aU72I7BZL2UwoMlTJq6gEGpYoqe2dOsb1F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bezXBMsu2eLd1i6OTpNQRttDXnu9xIFWu9sv3TgEOGJoyGawWWXp/SMNshjrj2xxolx6/RHhgbiH8gt0COEi8SRUzmvl1mYQUr/7yZO9ILU6dBhQCYFf52JT+17Lvo41Rn48vddbpH9CQFxPcbIlQDfElQiP4m7nSiIso1TGUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GYmBLSWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M0S7Wtsv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GYmBLSWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M0S7Wtsv"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 220571D0018D;
	Fri,  9 Jan 2026 07:39:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 07:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962398;
	 x=1768048798; bh=wKX1+M8lY2jqQ/Fm9yjwWnhEdcoujgIVB6eODkB7IXk=; b=
	GYmBLSWo+sXj2yU1iZ7yPfk3a3EETUQeULqxQJEdB7KQ0MQRU+/mkvERE4tkiu0+
	Gtr34tXy1Z8t1Hp6x9dgfRqs1o9RU7Vzp/+geacifl/Y/XvqDXqKsUr9sox4Ryav
	+k7wT6yKCJyrEqSM905l7BPK7eF+K4+ku9GyxkE6Dh0M2rzHO+is4WCvmdGo4ciV
	fSiGWkPxh1Q5SzchWfFPWV6G1zBI/QTKnpOJQobj/oxM9pt90KQQ8jhcQ3yqkIWX
	sjhAqyAgFUxiO+dYZHsuly/pjE/bjc5de340XikwhDA40bDdmIi/lkxSKXDwPdLS
	1brnZCCMFf5jLauumycG9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962398; x=
	1768048798; bh=wKX1+M8lY2jqQ/Fm9yjwWnhEdcoujgIVB6eODkB7IXk=; b=M
	0S7WtsvLZe+rLi9tEsuaIjTLwDmMYaiGmtCiur762XVvTRhWuAd56oWBEkCIoyQN
	J1X13+AZrqVTfgLe/tj3uWWP4bvwWxTtj0FqsbNIAo/9inAFVgaNgvBP2cHSarGm
	QAyLgnP5uks2a29QlnQXuz1QT4FkzN5LfqzbJKUtLy+nOazOgAsKWSsu7htKDrRS
	TYBx8DazpnvlcfysCZ+WjPR18edOxOeDxHH59OBXqBwaSh4iXOg6pvjv8NOQ6qOY
	ZoLmYpcotgxknoVjwizTdUn+pWunzNJ14ia7vS1EfjMQ2+YPXsZsthT55299Df3Q
	K4NvKTB0cvk+muPh4AYlA==
X-ME-Sender: <xms:HvdgaZ1jXU01HkHkyq6s8vIYGXuaZ8liT1nx1t7zq7ikldYwhuc0QA>
    <xme:HvdgaXhv0IQLzt1orqcrwa6ymP3RdX93ERT6iDxXW4TmCig7unqAJWVL4axUd_5zp
    ru4Nlq4G0dkHBtbUNYtTvxw-IRs2z2hkDSNiffobyjzNlOLpwlcKj0>
X-ME-Received: <xmr:HvdgaXROA9iQEZOP0AijRK8spqEj_g3L6AboHrC2bZCgVWfwQ9INMCVkF79LkPnQ_xt9PGAe2XcCqWXXCTbGp6Z_xH4_9oBw8GBiacUO2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HvdgaQgjn8Ub-rBZM1P3wseMWhaxwhHkqhgG7B-6CO5oovP09GgH6A>
    <xmx:Hvdgaf6V_MN6dSuVEfig0_KxjCp5AbNdvW5TjZCAQdNbm4kkYYpo9w>
    <xmx:HvdgaVCSB_akc1bO-IJjNtUCzk1VLnK-ELgn6sOpFbboYxv9mlxoKg>
    <xmx:HvdgaeY1QD40yMThyNNjjkH6i1Ewi-DNnUoJrSWrfub89GXG70N-RA>
    <xmx:HvdgaT9_-BbOZphhGUAk7-YJ8AirhH-CJEswczbJ-sjQX5ioTqyfXi7Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c30dd289 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:38 +0100
Subject: [PATCH 09/17] refs/files: extract generic symref target checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-9-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The consistency checks for the "files" backend contain a couple of
verifications for symrefs that verify generic properties of the target
reference. These properties need to hold for every backend, no matter
whether it's using the "files" or "reftable" backend.

Reimplementing these checks for every single backend doesn't really make
sense. Extract it into a generic `refs_fsck_symref()` function that can
be used my other backends, as well. The "reftable" backend will be wired
up in a subsequent commit.

While at it, improve the consistency checks so that we don't complain
about refs pointing to a non-ref target in case the target refname
format does not verify. Otherwise it's very likely that we'll generate
both error messages, which feels somewhat redundant in this case.

Note that the function has a couple of `UNUSED` parameters. These will
become referenced in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c               | 21 ++++++++++++++++++++
 refs.h               | 10 ++++++++++
 refs/files-backend.c | 54 ++++++++++++++++++++--------------------------------
 3 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index e06e0cb072..739bf9fefc 100644
--- a/refs.c
+++ b/refs.c
@@ -320,6 +320,27 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
+int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
+		     struct fsck_ref_report *report,
+		     const char *refname UNUSED, const char *target)
+{
+	if (is_root_ref(target))
+		return 0;
+
+	if (check_refname_format(target, 0) &&
+	    fsck_report_ref(o, report, FSCK_MSG_BAD_REFERENT_NAME,
+			    "points to invalid refname '%s'", target))
+		return -1;
+
+	if (!starts_with(target, "refs/") &&
+	    !starts_with(target, "worktrees/") &&
+	    fsck_report_ref(o, report, FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
+			    "points to non-ref target '%s'", target))
+		return -1;
+
+	return 0;
+}
+
 int refs_fsck(struct ref_store *refs, struct fsck_options *o,
 	      struct worktree *wt)
 {
diff --git a/refs.h b/refs.h
index d9051bbb04..d91fcb2d2f 100644
--- a/refs.h
+++ b/refs.h
@@ -653,6 +653,16 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
  */
 int check_refname_format(const char *refname, int flags);
 
+struct fsck_ref_report;
+
+/*
+ * Perform generic checks for a specific symref target. This function is
+ * expected to be called by the ref backends for every symbolic ref.
+ */
+int refs_fsck_symref(struct ref_store *refs, struct fsck_options *o,
+		     struct fsck_ref_report *report,
+		     const char *refname, const char *target);
+
 /*
  * Check the reference database for consistency. Return 0 if refs and
  * reflogs are consistent, and non-zero otherwise. The errors will be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ff047d0df..72c1db849e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3718,53 +3718,39 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *path,
 				  int mode);
 
-static int files_fsck_symref_target(struct fsck_options *o,
+static int files_fsck_symref_target(struct ref_store *ref_store,
+				    struct fsck_options *o,
 				    struct fsck_ref_report *report,
+				    const char *refname,
 				    struct strbuf *referent,
 				    unsigned int symbolic_link)
 {
-	int is_referent_root;
 	char orig_last_byte;
 	size_t orig_len;
 	int ret = 0;
 
 	orig_len = referent->len;
 	orig_last_byte = referent->buf[orig_len - 1];
-	if (!symbolic_link)
-		strbuf_rtrim(referent);
-
-	is_referent_root = is_root_ref(referent->buf);
-	if (!is_referent_root &&
-	    !starts_with(referent->buf, "refs/") &&
-	    !starts_with(referent->buf, "worktrees/")) {
-		ret |= fsck_report_ref(o, report,
-				       FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
-				       "points to non-ref target '%s'", referent->buf);
-	}
 
-	if (!is_referent_root && check_refname_format(referent->buf, 0)) {
-		ret |= fsck_report_ref(o, report,
-				       FSCK_MSG_BAD_REFERENT_NAME,
-				       "points to invalid refname '%s'", referent->buf);
-	}
+	if (!symbolic_link) {
+		strbuf_rtrim(referent);
 
-	if (symbolic_link)
-		goto out;
+		if (referent->len == orig_len ||
+		    (referent->len < orig_len && orig_last_byte != '\n')) {
+			ret |= fsck_report_ref(o, report,
+					       FSCK_MSG_REF_MISSING_NEWLINE,
+					       "misses LF at the end");
+		}
 
-	if (referent->len == orig_len ||
-	    (referent->len < orig_len && orig_last_byte != '\n')) {
-		ret |= fsck_report_ref(o, report,
-				       FSCK_MSG_REF_MISSING_NEWLINE,
-				       "misses LF at the end");
+		if (referent->len != orig_len && referent->len != orig_len - 1) {
+			ret |= fsck_report_ref(o, report,
+					       FSCK_MSG_TRAILING_REF_CONTENT,
+					       "has trailing whitespaces or newlines");
+		}
 	}
 
-	if (referent->len != orig_len && referent->len != orig_len - 1) {
-		ret |= fsck_report_ref(o, report,
-				       FSCK_MSG_TRAILING_REF_CONTENT,
-				       "has trailing whitespaces or newlines");
-	}
+	ret |= refs_fsck_symref(ref_store, o, report, refname, referent->buf);
 
-out:
 	return ret ? -1 : 0;
 }
 
@@ -3807,7 +3793,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		else
 			strbuf_addbuf(&referent, &ref_content);
 
-		ret |= files_fsck_symref_target(o, &report, &referent, 1);
+		ret |= files_fsck_symref_target(ref_store, o, &report,
+						target_name, &referent, 1);
 		goto cleanup;
 	}
 
@@ -3847,7 +3834,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 			goto cleanup;
 		}
 	} else {
-		ret = files_fsck_symref_target(o, &report, &referent, 0);
+		ret = files_fsck_symref_target(ref_store, o, &report,
+					       target_name, &referent, 0);
 		goto cleanup;
 	}
 

-- 
2.52.0.542.g9473a8513b.dirty

