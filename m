Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2973F5BCB
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531822; cv=none; b=YcQdwn+dvO90vATRgWujxVETjHK0tFRYXbjhInVgLucl49u73fvsQYD2NGfSTS3GBezXpHRLB+v9BMvAnnrCUpSvS61BFX21DKKmb9e0zG9WGMxeqA5Sd/oMrvgbOQWo405xd/m9JfM7pGAY/0oaecog7GBMNfCIR8pSg3RNqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531822; c=relaxed/simple;
	bh=vpyzVYLeaROuRZ94CyK1F84P1t8jEwaFaFYTzOXmgzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEBZfnnI2C4hXbsOfwhnjGQxBRz3SA/+fkGFLp1UZq+7qJwyL3Dukjm6nLMqyUVmNm0CnBq9EpRDlmuFarCQMs+5UWCMTiIIYFx+LMt3L4LOLangtAQiTSJ9b+SUBYeyIHC3dVNBNIQtKLZ+dhg20+Ax8oFbM8u6eq2hTorDtgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ezY7dTH5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSUD5rj/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ezY7dTH5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSUD5rj/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9760D14000A2;
	Mon, 15 Jun 2026 09:57:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531820;
	 x=1781618220; bh=hMgvZM8tj49V2rwzehtVQb+23f7t3gVnWZ+ZJlhj6dg=; b=
	ezY7dTH53RhOuhdDg0bFqncTeyi2AUev54rSgF7HIQdO8Rcd9KYFpBGq5dYmw4v9
	6bP/QuEUg3aG8o/hhvtCdfLhs0i9Vivb6sQ7AJ7BwLE8gbV2Og3Wcro5YRwxaA+e
	Ih1p9NNNKG2mRDiI++yZVmY8ZyqHNKUTYY2th6Ps+++xrpfRyfksBjyOo/tnUwM0
	Rg90azUuxTvKJfwT4wTAy/VuHemzgwXec7L1Qh6MjfAC4Htmf/HfAMuGejTLhhy+
	W6QRoaCdwWlSEZ7EcVZ7nfNCUUzX64y1MkAzBbxvR/ey1DUuctpSoXKux+h/djl0
	gcmK6kqGiIgQTWXPRpFHyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531820; x=
	1781618220; bh=hMgvZM8tj49V2rwzehtVQb+23f7t3gVnWZ+ZJlhj6dg=; b=j
	SUD5rj/jseoXwSe2+DSqNwCbzMVBNEurcjfx9YPvM8RGvk6kar5qVo9CVJTuTTK8
	UOj9k3iT2v5xCzf4/rXoM/dWpb0Der4gmzENnQAYLGR+PTkEndwZP0BpL3yUOypK
	ukNNDSYXSQAy/2bWMUjW1YYE/aVYJEiYGHvOhOnMoGiSoTrCFKpjUxENrlUZ+SlU
	YBLEFsxmgSamN2xnV2CTH0SkCdbgbbrnpZ9rG6jaRIfQYu71Eu4OheyQhBBqnCDa
	CaU2nElQf99gR4dnq/VzpXJb5szWpZ65kmmvKvvsfXVPRRsGou/YEIrxG1FCuNoq
	AY5rTrH6dSOeO+jPmyTYg==
X-ME-Sender: <xms:rAQwakMl8m1TH8lA6WnQWOQeF6uAshnYOZafENTrDadpR_U0MZoGGw>
    <xme:rAQwaiYHKoNYg2XPuXQIbgmBg3D_lBW8zorByr11SkauCsxbQeO_0ToJwvvC3CYUR
    Sr9AerDJHzx2NmUx30vq1RU2O5KY3Yo4yOz4YH9YKzDz5PLTfAT5A>
X-ME-Received: <xmr:rAQwaoo311qUeLR0v-3fBdmfBIva-r6K31mJC_MgnT8UAlGe4UL4gyfyHwKJuCaKiegyBgM5YS7Lc6NDmz3ovSqk9NDVYDm0LERp-5u_GA>
X-ME-Proxy-Cause: dmFkZTF1FG+X5HxMGxOgCAZMy4A7SvmaeSo8nWVIUYom5oj1dQYaH7atcMinwTjrhcUyUb
    LZan+BOoi5ge9vWfhtLLsEJ6nozXuvgxf5Kre19hZamhgwR0kDzFxjz443r3LfEN0HSBzC
    eukzV1YjVJAegImryJKbJrBYtZbul/kuDL7+1mQnTd4ql7YGqXAGhhukI9FiiNwgCHqy+l
    BLSdjQUYerE20wsVpJRKZc4+wrOvLcOxsuKNhg33c7tdC3ovyr2Y8bNMARXZwwqqWISsz+
    zZJEPANDT/QdTsAiGkRM58RqOqc4pCnkclD6WNSyNVkuatZTyKu4DM5S4sdA8JUB43kSHm
    jX/EzimeqevcNC+QIK176G+s3tVMXNr5HI1BbPq2/pFvmMxKEuIP3EJOwvTRD4c2SLMmsr
    ilACXngEZvMzEJdl/Hi0yf3g64dhHJdxNs99Mc0H8vzyuChyV5BwtdqeHDSLQ7Wc8ym2MA
    v+Q4OoTvO+XdRLRFguHSGSr+NVUQBsjhYAVqhNbfvQHboGJ4SywLiVLJiLW8xqwnGd/+8J
    GZCcRdpuZmtMioYIIlp0DZSVa+FWB9DOBQVDlljeIQvYkfK2VEKdgkCJSUBfK8vb4D597+
    2L8JP2ZFccnOthnk5ygFhfdvnYD+UeI2Rx+rDKPiAojVxaLgJdw/IdOL9S+Q
X-ME-Proxy: <xmx:rAQwamYli9Eg55SVmGp-N1Qlc9ZaNuKqg88Xx6B7fFIklabEHDKdxA>
    <xmx:rAQwagQMQpSW_6MleQQjhyKzJ9YZepzesao53KcEZCc0G3reqmioLA>
    <xmx:rAQwat42LA1Vc2H5HyXJkxZk_Ds07Bhn1O1vvI9rAqh-nlhaEFtAAw>
    <xmx:rAQwalzamdttFTiiSPirTX6t6wkHLfy4jqY7-nr_5aNNrhKKe3oO7g>
    <xmx:rAQwamE9kG2jxVyoSQ5RKyK3Igq1PrSAuBeNnpqZ0TpuahCM8SZeemfb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:56:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f10ad0a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:56:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:56:49 +0200
Subject: [PATCH v2 3/8] setup: don't apply "GIT_REFERENCE_BACKEND" without
 a repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-3-f4854aa99859@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
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
 setup.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/setup.c b/setup.c
index 2748155964..7b2e50a8c5 100644
--- a/setup.c
+++ b/setup.c
@@ -1906,7 +1906,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
-	const char *ref_backend_uri;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
@@ -2023,6 +2022,8 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
+		const char *ref_backend_uri;
+
 		if (!repo->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
@@ -2030,6 +2031,24 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			setup_git_env_internal(repo, gitdir);
 		}
 
+		/*
+		 * The env variable should override the repository config
+		 * for 'extensions.refStorage'.
+		 */
+		ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+		if (ref_backend_uri) {
+			char *format;
+
+			free(repo_fmt.ref_storage_payload);
+
+			parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
+			repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
+			if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+				die(_("unknown ref storage format: '%s'"), format);
+
+			free(format);
+		}
+
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
@@ -2057,25 +2076,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
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
2.55.0.rc0.738.g0c8ab3ebcc.dirty

