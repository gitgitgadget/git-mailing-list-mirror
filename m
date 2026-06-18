Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CFF40D58F
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765683; cv=none; b=hTBzijR7g6yby3uAlN257FDyWp1yIE0UlsL9TOkzhDD7r9lY0U4D3RS3n5QuGSedbLPvURDn+dJB9qpE6YXTspXcz1F9ZvmR4f0WjZyhWK3vPQvmGElpLE3XbazMso/s+kq470UVpzn8MSp64NhaChO3GpYgUvIxtQ3CKhqugzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765683; c=relaxed/simple;
	bh=xVuoDjZWN1u2HVPOkvN6ppVpN6jI/R3RPr/hx95QBaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYDtlSvX7CnfidytYKep81sTxqy29ambKmtZKT5exPwsOj5Iz0OFtfkqz5SCmBJXF543Weco/qdZ8K7oU7h6stnh6FciwwpXL784oatcCTpp0o6uP+6Jj1ixZFCrJJzeU/8QW16W5nCFxhrm6Uf1LnN4LoimthzSL6c3FqTrS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZGgtSJ8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hocOyVeL; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZGgtSJ8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hocOyVeL"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EAF7B1D0006E;
	Thu, 18 Jun 2026 02:54:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 18 Jun 2026 02:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765681;
	 x=1781852081; bh=E56Fz+Yra0GqUbyqpaHRd2fYQPVWVjH9Q2bf4wIOIPA=; b=
	ZGgtSJ8ETNwJrbjDtxcI7QAXk0Xt28Zmy61L7WwBkIn1sSYH51unXKoiTSMH6E3y
	AVOCZwpFOOWfoCefuWakO/0qDR4njsB8lfbLvTtKtcb/eyF0kpQjWWGF920m4OmG
	S07Movb/e0g05A+zseBxE8H5d6N/orySQywVNX75j/jMR8wctFylmi75x7XpwANe
	FoWApSTLPMseRZ3x4xC6UyagABXvhSrtMSvZIoojUwhfigUNotJqZ49xaoZTasbt
	LEys5Yj2oIFG5bjBNVHKY9FimlY9tF8CKVZmbcJzkIeFV1QbhZcSPpJhdZ/QFM4f
	EO5hEZ2FFgX2sGP55m/tOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765681; x=
	1781852081; bh=E56Fz+Yra0GqUbyqpaHRd2fYQPVWVjH9Q2bf4wIOIPA=; b=h
	ocOyVeL3PDGzXYIbbcVs+tkaw1oBr1AVgHl0jiIuhrfKNmRQLsMFO9GbEsCEcr+t
	P37wDTD4exvlMaBRUgqrOzvTK4+z4DD/A0BcAA22rYR4R+6Ve9r7XG0tYlEGnmW5
	PjIn0EGA6q6CGm4f89eH+WGyFC3UlTb+NySsVkSM4+ivrypTHbDXbfRWSZzEQa4p
	tbrC0FcizCW/lcfsve5up6Yk0IX/ztHezv8gYdQsckYMa+lT7tqf6a6OUG/vPGEu
	dfyCTjE3cOXTebcmNXFBq0ZtHkOag6cgGHTujZ8RbpJJP10TJ8P937dZkrgQTfyu
	XPNL04Tz0S8k7rqfjF+2w==
X-ME-Sender: <xms:MZYzaqc_c9Mi2O4i9D-vWHuhR_P5Fn-i9a68bM59PfdswsbIpxPMRQ>
    <xme:MZYzarPkZHbvWZjNJ-cdYevCKLsWsinMV-9VadKyKZ_bT9xq-frQam8QrRN-WOHcd
    PVq7K22gGFNiRsYjpvTgdDD0BrhQQgjKYqbOzeKRUHh4ljc5iGo>
X-ME-Received: <xmr:MZYzaghAXItQ488TSHtlUzeIDkbAiUg8Iq1MDhtxzSjPMjqr_JY46NSgHkIWx8ZZwAvGooQSuAS0rep7HrNaVYZN_v5fGWiikghGciBsag>
X-ME-Proxy-Cause: dmFkZTFD6dk3bOvvX0yaVMjewMZkeTdhDwFjQkN7CKbrsc6RX0hrYV0S0wDnX/SLDtagvs
    OXl/+ys6J6Ef+ualX4oOCc6rpWlLgwUd+CDYp+J4f9tlVotwnOyNo/D2Ul+hiGJ2GnOpwO
    20YD1dz+jK59WSjSeqbvZIbS7LjQbwOZCvQ25fWlXFborkKwttqiF//EPtS1SKQOJhwE9p
    V3KhMGYjicitMSxnodz6t0JekyXT6bD5QV2YO0G8PEP3srRCCjxK6NZiPsNL9hezzRVkL4
    4yQ1ZKu2ng6hTy03G2N6EA5XYfWUIQofvB/33+yVj+xfadwE0sg/Gf4tc/U+tgG/YyDirr
    Fms/6q91kwup/+B47lYZN0rOnibLnE0IV1eoNcsiGG3U1P02dvoq6NOn5x86qRX6l4JdM8
    AGzvC+uz6VxC7TRMnMdyOeQ4CpO6oOlf+m9Q8sxes/pZRi4NqSWHi8rkggXS5kCBSZ6CDg
    ouxGB1tfpKKdxMsPomgjRz5F2y9919kTZ1tyuKcDi4E2J77WfWYas/IzGpNF3lL+KuqdiY
    MZLB6uhWojhCZ3aXtSfFt3BL7E1doHRvusYXvgEqh5P55bRpQLYZKticChA01QZvURaBnE
    CG/l0L5OAbMqeRgSbcPc0914jZglhe/VyNNMnRgZ0XiKN0lXKknVy0Cqykaw
X-ME-Proxy: <xmx:MZYzam2BTgj-oi7lb5dYrac1vlflPbGN-o9uZ9ci0sI2uozpz-fwPA>
    <xmx:MZYzaig_cpVVsyIxZJXPFKkO4Vjj32XPjXv8xPTmkzgv-KeXlAt6Vw>
    <xmx:MZYzauch2X1KJ2eaIYmIrVSbBQqbHBBjjARdLoyxMGQ8XPyx8R6G1w>
    <xmx:MZYzatkMyMQIxIGcsLqhqDwrwttqm0rGCjUQlxEgjT-OL8i-O1Tpgw>
    <xmx:MZYzatkBi4xHzaOsS857UsXyd7cpZvZls7cKLqR1z2etx0JUGqnJjEkr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b50e7aec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Jun 2026 08:54:30 +0200
Subject: [PATCH v3 1/8] setup: inline `check_and_apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-1-2a5669e8f486@pks.im>
References: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
In-Reply-To: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

We have two callsites of `check_and_apply_repository_format()`. In a
subsequent commit we'll want to adapt one of those callsites to change
the order in which we read and apply the repository format, at which
point the helper function will not really be a good fit for us anymore.

Inline the function to both of the callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index b4652651df..a9db1f2c23 100644
--- a/setup.c
+++ b/setup.c
@@ -1788,32 +1788,6 @@ int apply_repository_format(struct repository *repo,
 	return 0;
 }
 
-/*
- * Check the repository format version in the path found in repo_get_git_dir(repo),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-static void check_and_apply_repository_format(struct repository *repo,
-					      struct repository_format *fmt,
-					      enum apply_repository_format_flags flags)
-{
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	struct strbuf err = STRBUF_INIT;
-
-	if (!fmt)
-		fmt = &repo_fmt;
-
-	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
-	if (apply_repository_format(repo, fmt, flags, &err) < 0)
-		die("%s", err.buf);
-	startup_info->have_repository = 1;
-
-	clear_repository_format(&repo_fmt);
-}
-
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
@@ -1887,9 +1861,17 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
+		struct repository_format fmt = REPOSITORY_FORMAT_INIT;
+		struct strbuf err = STRBUF_INIT;
+
 		set_git_dir(repo, ".", 0);
-		check_and_apply_repository_format(repo, NULL,
-						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
+		check_repository_format_gently(".", &fmt, NULL);
+		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+			die("%s", err.buf);
+		startup_info->have_repository = 1;
+
+		clear_repository_format(&fmt);
+		strbuf_release(&err);
 		return path;
 	}
 
@@ -2820,6 +2802,7 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2846,9 +2829,10 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_and_apply_repository_format(repo, &repo_fmt,
-					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
-
+	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+		die("%s", err.buf);
+	startup_info->have_repository = 1;
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
@@ -2904,6 +2888,7 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
+	strbuf_release(&err);
 	free(original_git_dir);
 	return 0;
 }

-- 
2.55.0.rc0.786.g65d90a0328.dirty

