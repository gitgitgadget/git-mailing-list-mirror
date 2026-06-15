Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB43ECBEE
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531820; cv=none; b=WeYBcnU/ozSRT5oo7pwrmvWC2JUbXNuIk3tyA+D1GQB1c4cC6puXb82h5xK+L0asFzAeR0s4dduye07P1JE61T2qOyo+VlB37o/EV52WDppWG4OkyVdY7TVMII3rFJ7G5NCRoWSvzkEO9txXaWGK1UUw26mn+7XoNy4hD7FzWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531820; c=relaxed/simple;
	bh=gvpgYRArrsLhsSRXXCDEker4BLVxipb+uRZ3GSg2kZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdoZsq6RNkKC5xVKEDe8yactCsU5IUSuCvuKAp2Ftxs3VrZTnrfKxdkPSslgfmXmfsFqqZSVD5fGA4twFPOe1rhFkYYraCQI5G+x6zpqdoDrgG5VKhH1rUImnVf5wLeyy+jhBjuELVYe9gi2Jgwlm61A7Wd81bsVR4NjN8xRdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rx3oleFY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Glpjaskh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rx3oleFY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Glpjaskh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94CB61400042;
	Mon, 15 Jun 2026 09:56:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 15 Jun 2026 09:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531818;
	 x=1781618218; bh=6mrHVWCFHokmcQXEhuljHJbdv+UhI4e0S42z4oJTjMk=; b=
	rx3oleFY28UalAqOtjVxFM/33QfLXGYZRn20ijP97LwPb1v+Xvly5/SAC0wOzqwa
	StmXkjNYrjMK8+Ol5Kb2YOpaOhdF2llsyi+rQst5YeCaVgOtYzWwvg7QZqBOl7Sp
	GkSEQkn3WOg0+6IKzQJdT5XWMr1ta0N28gCYy+rttuP1ap+AKxUKzsy16oLRpKHj
	IuFuCVxg9QCEdRW/l0iOasdbBzjE6fPT2qc6k//09e8h97Cpl0yncpqSs1FOAbK8
	vbLj2Y1q3hGxE9zc0kWFhTKQNpGl9ytBOCRBduQKfrDeK+gXnwjQ56nmO90Q41YJ
	Qa90fsSLmkCTEihsZAaMQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531818; x=
	1781618218; bh=6mrHVWCFHokmcQXEhuljHJbdv+UhI4e0S42z4oJTjMk=; b=G
	lpjaskhu6e6iYdTjyguAatdsBNY1rtii//UVERyXZZGh8JoZW8JYO9TtDk4MzFeu
	rBaCBV9EI//cw7Zw8icRzv5M4EKCz6CDJSyVAjrulzUL+kUmRjf2lABtPVqk/MwH
	7RZNDRBjosrq1UAYjJW7imb1ytBDBtl4PX3ZamO2xW6zovE/CDyqFeCp8RupBBy3
	N8btd3bwDSWh/wINdWTcIMCZQ4qHBxs0vZDVg5QDsXA+jmCqQeNTCNp9Ov8LFoaX
	JiDGSdmIdlsewZ4pQVxBkMBc18avS6gq84x7OBhyq0aTLm/mTYh5lKXfXrGp23nB
	kdx8ic2bq0RzbTV4gfI9Q==
X-ME-Sender: <xms:qgQwav6QeQelRYnJYOoGurMv13zysCAgfoWYsG6FkJze2gV-nDgRdw>
    <xme:qgQwasXnAAf5_kEkJaviHGTV7ny31sxD4ndyrsZknFKDhvbNXui5gg0kb3b7SQsAB
    rI-ZJ3Eyiitl0ZRMCg-vOdtkunwAPzrB_FihOByVSdpttbnqjPpGw>
X-ME-Received: <xmr:qgQwaj21t395lGjYtE7yxU9e3QoEOzyew7D49sJYTX_zUPy1ae_C1fIq04pYn47ogSAYAKOvbXXBo8-UUlgXV5i2jwmPeS2zxcMMzz-6lg>
X-ME-Proxy-Cause: dmFkZTF1FG+X5HxMGxOgCAZMy4A7SvmaeSo8nWVIUYom5oj1dQYaH7atcMinwTjrhcUyUb
    LZan+BOoi5ge9vWfhtLLsEJ6nozXuvgxf5Kre19hZamhgwR0kDzFxjz443r3LfEN0HSBzC
    eukzV1YjVJAegImryJKbJrBYtZbul/kuDL7+1mQnTd4ql7YGqXAGhhukI9FiiNwgCHqy+l
    BLSdjQUYerE20wsVpJRKZc4+wrOvLcOxsuKNhg33c7tdC3ovyr2Y8bNMARXZwwqqWISsz+
    zZJEPANDT/QdTsAiGkRM58RqOqc4pCnkclD6WNSyNVkuatZTyKu4DM5S4sdA8JUB43kSat
    pWIK1+6fkAUTlhl+H0CuFeJbF7yx2rNxnSgFFunGxjKr9qoc6JOPJBCYErsPHH8AgtTFzY
    LaNF4BOtGMOV0HRVdwsQOE2lRtuBeuTjRYW67Fw+5oE1Zdurb+nonW2g1S2fdF/Fv5sXHP
    vq27SR0KUHJQkQYb/L2pCahGdsQc6AjkzR3gJtCsA6Lni6MTeMTsIxI1xi9k+QGSiBk5Ro
    rYt5vghhsBn342jq28DVYmVasJ79Pzm1ygS9B5WHmv1mklYbzU+08CoRinnUXDzb0ROK6E
    c84CrRNPrllYzKCS9D8Ymrt+dHjfA9uDXVznZJxSXj7up8V5IC5Pic91ZBFA
X-ME-Proxy: <xmx:qgQwap18E1HT7m_hT9GsXBD5NgWc2wtg3AGmDdbjaOzCF_M20WTPww>
    <xmx:qgQwam-YXnhG__LN1h84N29Uv5VhcMwVov_fznCOhzXJgRG5yIIT9w>
    <xmx:qgQwam0iIBBgXo_gsXCkkeN_oHgJTUsIOvurG8vTIMAQTZTfKBTDHw>
    <xmx:qgQwaj-g62yJXvj5i-R8aUXjKBP28skeNpZtsiiVdls2NxCeQnmpng>
    <xmx:qgQwatDyp0ZZehROAWcCDEZGDJCef15CcVQozgSeQyb30N0LmNP-pLLI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:56:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12aa565f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:56:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:56:48 +0200
Subject: [PATCH v2 2/8] setup: stop applying repository format twice
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-2-f4854aa99859@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

When discovering the repository in "setup.c" we apply the final
repository format multiple times:

  - Once via `repository_format_configure()`, where we apply the hash
    algorithm and ref storage format to both `struct repository_format`
    and `struct repository`.

  - And once via `apply_repository_format()`, where we apply these two
    settings from `struct repository_format` to `struct repository`.

With the current flow both of these are in fact necessary. But this is
only because we call `repository_format_configure()` after we have
called `apply_repository_format()`. Consequently, if we only changed the
repository format in `repository_format_configure()` it would never
propagate to the repository.

Refactor the code so that we first configure the repository format
before applying it to the repository so that we can stop setting the
hash and reference storage format multiple times.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index a9db1f2c23..2748155964 100644
--- a/setup.c
+++ b/setup.c
@@ -2710,8 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
 	return ret;
 }
 
-static void repository_format_configure(struct repository *repo,
-					struct repository_format *repo_fmt,
+static void repository_format_configure(struct repository_format *repo_fmt,
 					int hash, enum ref_storage_format ref_format)
 {
 	struct default_format_config cfg = {
@@ -2748,7 +2747,6 @@ static void repository_format_configure(struct repository *repo,
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
 		repo_fmt->hash_algo = cfg.hash;
 	}
-	repo_set_hash_algo(repo, repo_fmt->hash_algo);
 
 	env = getenv("GIT_DEFAULT_REF_FORMAT");
 	if (repo_fmt->version >= 0 &&
@@ -2786,9 +2784,6 @@ static void repository_format_configure(struct repository *repo,
 
 		free(backend);
 	}
-
-	repo_set_ref_storage_format(repo, repo_fmt->ref_storage_format,
-				    repo_fmt->ref_storage_payload);
 }
 
 int init_db(struct repository *repo,
@@ -2830,10 +2825,10 @@ int init_db(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 	startup_info->have_repository = 1;
-	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

