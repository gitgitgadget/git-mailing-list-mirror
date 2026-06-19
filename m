Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7B367B81
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868489; cv=none; b=ajkukirTvXqRm1PPjZnj3kZT44BFfIXQ9bD6/5Vq7pCT2s5mRm4NaqAx62MvztqNvi7rYG/gRnmnZyDgA7lt4Isl/UI5VqXa6aDU1ZD6Vp8r3vbGkg45W+T8mxRFIFz4OnHtqbOcFidohUbCTETRkPqGWnv9qO7bpIr3xnVIY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868489; c=relaxed/simple;
	bh=jPyHGdrvrN02RtV5tMXQHWhl6Qgx7L/6Ox65pqNNTvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCIGK8SOOXd2h49XIe2hZRCNJSBzOaEBZ9poNpI4xcYuw33HNBUwmgyyz716wONe7Vg0fZFs5cnhREl2JkjS+NDegxZPOZ2CYVVE3HutjyDXnl6DaPtMJMqcNFSwfSy+rNfvJSgCX9Rpkcq3dmG8iuorjdBYzkwKXW07vIgaVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F99ZiRvY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJStvah8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F99ZiRvY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJStvah8"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 82D6C1D0015E;
	Fri, 19 Jun 2026 07:28:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 19 Jun 2026 07:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868486;
	 x=1781954886; bh=zNfGMB7glZzRVWGk0T2VoVLJtB5H3C8lRBcl8GpKr1U=; b=
	F99ZiRvYFKChMdimXLcW9UZjEWWkM1Sa1qjzdKfetmSMDcPV+agFhJnIGb/PKKae
	10rxoAOHwhtY9199XkTD35CnSMjFQfA+GmKKQhLfqz8KkykDdOKZUC41R0NWkztP
	qNBqJziPRIxDgh2ixfQv6SDbjVZe6BGLUAbBlVYa3YbFegfi6GWLeJR8mIFAvZB9
	W8E4pk91D41ziB9yzMYWX1hzERGJQCJD57fMdAOSuda8LixJ5Yrf9Bi21OhSuFAD
	6Pw+pvCCS/4nWEPzCRGI4dMJcaNFoqJVBKlj7X3tkBxm5Tjq+cPG6wCAD4PXjm60
	k7avYoMunY3KPCeOmAjQhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868486; x=
	1781954886; bh=zNfGMB7glZzRVWGk0T2VoVLJtB5H3C8lRBcl8GpKr1U=; b=C
	JStvah87cJDuPQIeeWMG4UoVV5Y8kIR+loQklfcpDGHySAHZCPzcXZq/koWa0Phn
	PNp8w0JLb4YQnptiWcyeQk63SJMxUueSdVtCT74zTn/dBCr/PPdWLJOEWtww4ZOk
	FMwv770avddeBXELhhtDC74aTjEdsnF3w6S84E7FwfqhiFe1HTniymbkZTitIsju
	iCn/J/lWyKuXoomcbPElG45E4tledm/c663/1Uf03UagrrzL7kGqCDCGcG2NP+g+
	Lz6136hDgfqg3CJ1cua+rGtct2GVT/yvpqqzTaJdYsLoWON73UdVljrGiti/u0h1
	s/49MJYAjMo+D5/TUA1cw==
X-ME-Sender: <xms:xic1ar2bb5jOoeXaSVvVFDX48uKiIBG_WgC3jZO2nx5L7UiMcYIFeQ>
    <xme:xic1ahHe2whyXuTkf60vv420YW44euxoLDWC2EGKEuRDa-En2E4TaULxJUfB7j6PH
    DHf1OwLNOTPTJC-cS-re30cK5Afx_UDo_h39vVOvtlM_FMfbtzV2so>
X-ME-Received: <xmr:xic1ag7htjIkURBoOhjwmYFQ2j4MfibHT-FRDoxC6q8OtaR38Hi1a0TcR7ZObrUFJ_ilXMxapKTu3kEv3lKhP4YMOsBRP3LbUAFvJw1e8sI>
X-ME-Proxy-Cause: dmFkZTEde8rkG7Ow/YQajJOxpUKYHnTWdG0AUznTDLiHmSMbSqWzB/6nKIAIdk1nkTwS0K
    C8jTqdNp1V7h/KMFCwexCiiwcxkUoPM3XGMXsNXnEqixWMufecGwaAXNpfHOfwmwhgziKB
    gEME1JUhRUF4zEWjEcolbPL4SS80OZZVhDQXhaESCZsPSITOIFAzr9mdv/wwDKbMEUglz6
    Lrw5108LV8TWN60J1S3iQg3WXtzla3Zx7Q2iJ+qofdJhYzq3vyVO5Ie87s6Y7SykEWxrmz
    /vmzMKfUyKVDBOQcXezzDDbfTiNE3Vevxi8qzYGVvv3v5UE9OxNTzNX4wxQEWsT+cwQANh
    WZHfK62B8sQvb0C8zInoZHfhHGRCu50qIEhfdg7lfk/deOIb9vaDsSvYlK72cn55j+5mlm
    6mPi0YR4Y46IORVcfcoqwZep6pvUjk6x46hU+N1HTN+lPOsGem1+dNzH7GQYxZ+qiKvK/6
    hdd282FQlQaMzfrI0gGgXei3NUk/lg+M/IXcj87cGzxRTsyKZb2wzd67DQVbrsYAqhPZA2
    viTlRJb8wun5/rzpxR44FijEZ9QVXA23kbHXM1wLiese1bz+H287xmv9u6KDAgs4H/SmW9
    yXfdzvLVJSlsPCdW2VscyvCVWR0NxI9Gf5c87DCzEWQ/CeNcesPCUmpDdQwg
X-ME-Proxy: <xmx:xic1avt0GFwEf9SmBhuvEHPCoHvB31Lc8ZcjvIfnDbHm9eEm56rpzw>
    <xmx:xic1ap6GKF4uYgEdCbUd97J8MSNuiHk1amSIx7FRHZTIcJOvXMjt5w>
    <xmx:xic1aiWTcey_K3HnKzsloLH3aUYpoaYcVRssA9tiugIJpFeqcXNXWA>
    <xmx:xic1aj_4lfovJ9wxI3Msaa1msq4qILsQ6L74xYLwD_AThE-cuswtEw>
    <xmx:xic1av9JzsW4XdQPl3XckpqwhUALWsyjxQmkaxO8uv53e6Fwjd-Pq-jJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 470432ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:49 +0200
Subject: [PATCH v4 01/10] setup: inline
 `check_and_apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-1-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
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
2.55.0.rc1.722.g2b3ac350e6.dirty

