Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC7378D68
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379218; cv=none; b=Ncxy9dAFvbB4mXC1aRvbvN1Ia8flwKldBOnY6HfVV9b0FivZkmx+oGVQqx3wYpPoTMKr4Jj7teryKQFy45TDbrBYqA8Wjg5xQi8hgwZYU06DrVBiOCNhYBMYREtLEtYGHh8xdSY+6xZiqSivdZVIFzJlLo2wzMUmG+j4UcDHIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379218; c=relaxed/simple;
	bh=X2LB1y0xWiJ7Ty+tivAHzHm9RJpChefjHPp0fe0+dvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmhyj224x8Ti6sKuTIF2ELGyk0EhMONKNZk7d0q06YvctHe0ZrguyUILjgmZNhpz/ZFM0sk9YOxxKoFFZYkKxT+WLLczYhyejk00yRjfSk4LRq7r0fcQ1VtUgCupDpuWsr4zyNfPtvoq5ZTj+p0P1tKwiG4RNCPL9vbUDjg626w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k03EptJg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GPqaKrUQ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k03EptJg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GPqaKrUQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8DEE07A016E;
	Thu, 25 Jun 2026 05:20:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 25 Jun 2026 05:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379216;
	 x=1782465616; bh=RuwxwOm6s3bm3AscrHXxdkVHea2PwpBh9u8xx/1zYoM=; b=
	k03EptJgc/KRSFX2QEZ/XbbWkhlNnZ4xkvZVehugG/CR0ps/ydmQbX+jnkIwVzAk
	bspMVdBMl5sVKtc65oBu3j/EYTX5PTKINNDgQvIgNf1q+0rdOw3qzbIyfjeasAuo
	Avi/bPq0Ot+7eVIdCBRJtn2Yk0ouQH9cN61zOFij0mG7+zbK7gc4SaN3yMW32owe
	+iwJwq5zc0APBLzJqDGlUpoeufbrE4nlQE78YJ5dcTVK68dlwqV+Twb9+7M0nkGf
	L/D0goZqkotUNGdmjEtAuBrqBoRSXOj7Khm1AAHlDmq3YjVHP6T0EKuYomqKbEXL
	bKsVy5VfoTc+sv2G+cHDJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379216; x=
	1782465616; bh=RuwxwOm6s3bm3AscrHXxdkVHea2PwpBh9u8xx/1zYoM=; b=G
	PqaKrUQCU++jx5oM5jJLcUsBKzNptFm+P8eYvrjzDOuu2Y0BHquf/4//pLI0EkUI
	XeAbdsbK+n5rA0y36CWHtSWb5G3hp0yG2WBzqaw262LDFZoOfXGEkk9/AoRECRNT
	EdI2iPTP41Fz0RArIwO9A1JO9DZYZXJNKRNgkYvcr5g9dH7+GGe+Z3zvJa9okFe4
	vbh1oGdR+0lcD/2OWcOLvHIiZ6phtYyI1D/av1BXMCsJ/SK5NPdN1gUA3dhwXG1a
	NFLTN1kXhTU6801fERC/X90qtL3Q+DqepambadvddV++r8/D1w38WFbiQcQiTiDh
	VVPESRTg5r9VymVW4O2RA==
X-ME-Sender: <xms:0PI8al3RLnDZjfPXyby8wV-wj6ps9fA14Gm-z_HYjXMnYyfJdTyDwA>
    <xme:0PI8ajFz8941cWYRT5elZFkG6G_pGCdG4K1m4zFgyTJsBXuUCYTFhxMMJoCqqDXaA
    whmnFNrm79T9cJnBIgReXm7HZ6utVzOxvXo3MZfYN9QCM2ZcuI4UJE>
X-ME-Received: <xmr:0PI8aq4fPMRHdfRN-NtYs5sTRqP0_WynWWNJFeYAcsoN9txD5UBMyw174n1hwH-_IqOBBGCQYvFAd-sH3Y7j7U53lNIhrXN4L8PRXw_PuA>
X-ME-Proxy-Cause: dmFkZTFJny8F8bT1vobP8mT/gHA8dRfG54tdLYssF9mGrBAZ33fvzfK1eqPxa29sDtYAhN
    5tkjpw8eG7f8oUYXwWxFvXTfK5hurMwltmfD04NzD/ZqkQDnNm5LG5e+36110BPFzMSHq2
    HQfiw4sPCG9XizI+bbWfQ70k6NFeQGil+Q4g9AnIT5X8yKcTuUqmWhXByog3KGvZ/ni4kX
    k9V/L/9g4/bQonvKK8Brc7cK3ZOQt+0LqTZPmn4ByHyhrpuP3EGvOEGRCSWZpe6rchkvz9
    cVZP4E7MkYqSCORu71W7wFgpoNuZR9ZptCacni39b4NdZsabOObv28iAAOaljK7R002QSH
    kUISDNcruUqM7T6nlNLbNucsJXOWzx0BfgVbckuVYewl2iT66HgVudoUU3nobi0mCYUBON
    O+vCnbGLYig6PNDBFvrSjOiyaWpXyfHulGinrMc6o49rWHrqGl1k7b2TOEcSe7zaeEPQUd
    h7Dja8f4PWSo/54WhjyZfnV9MNbWz/bgDv7fXsllDIC03q6WKuhhlsyX65tm7LV+ptv/YS
    IMHETsDG0SS9AIakkKJY7chjFVcQxbB35V6VawQRzjBAObAvO454y1Pbjr0n8ZuBthPJj9
    Ly/vIY4YJT3e4K7i7zswyhTH++XeOikWE0KzRQvChC1Z7vmsUNEOmntdy8OQ
X-ME-Proxy: <xmx:0PI8ahvfl4MLmecmUJMhiFSGAd7Z2qMqi1P_pQRprL_ZgERuASc6Kw>
    <xmx:0PI8aj52QT5t6Sa_hMjTZ4fuqyrOBXcpdDYaikEPeuzt_N9xjnwm7Q>
    <xmx:0PI8akVa2WVtcjPBKqMcFIkJ7GoCbL8iIGumZHhO3mPGlvkxF3mhug>
    <xmx:0PI8at-ALDpm0yO4P4RJmXaVsSccXaqLqyFhTw-cYBiv1r33vmdI3g>
    <xmx:0PI8ap_mjgbcVGmxdQ9rLIUAr133W2O0jXchLSBlKXoX_NlOBNcfHzY2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7fffde5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:01 +0200
Subject: [PATCH v6 03/11] setup: don't apply "GIT_REFERENCE_BACKEND"
 without a repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-3-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When discovering a repository we eventually also apply the
"GIT_REFERENCE_BACKEND" environment variable to the repository. There's
two problems with that:

  - We do this unconditionally, which is rather pointless: we really
    only have to configure the repository when we have found one.

  - We have already applied the repository format at that point in time,
    so we need to manually reapply it.

Move the logic around so that we only apply the environment variable
when a repository was discovered. This also allows us to drop the
explcit call to `repo_set_ref_storage_format()` because we now adjust
the format before we apply it via `apply_repository_format()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/setup.c b/setup.c
index 2748155964..79125db565 100644
--- a/setup.c
+++ b/setup.c
@@ -1906,7 +1906,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
-	const char *ref_backend_uri;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
@@ -2032,6 +2031,25 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
+			const char *ref_backend_uri;
+
+			/*
+			 * The env variable should override the repository config
+			 * for 'extensions.refStorage'.
+			 */
+			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+			if (ref_backend_uri) {
+				char *format;
+
+				free(repo_fmt.ref_storage_payload);
+
+				parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
+				repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
+				if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+					die(_("unknown ref storage format: '%s'"), format);
+
+				free(format);
+			}
 
 			if (apply_repository_format(repo, &repo_fmt,
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
@@ -2057,25 +2075,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
-	/*
-	 * The env variable should override the repository config
-	 * for 'extensions.refStorage'.
-	 */
-	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
-	if (ref_backend_uri) {
-		char *backend, *payload;
-		enum ref_storage_format format;
-
-		parse_reference_uri(ref_backend_uri, &backend, &payload);
-		format = ref_storage_format_by_name(backend);
-		if (format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format: '%s'"), backend);
-		repo_set_ref_storage_format(repo, format, payload);
-
-		free(backend);
-		free(payload);
-	}
-
 	setup_original_cwd(repo);
 
 	strbuf_release(&dir);

-- 
2.55.0.rc1.745.g43192e7977.dirty

