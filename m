Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211B18C323
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540431; cv=none; b=nefrR+T7/llyK7AA03wRLcj3s13fxwgpqnma8B6m3Yeb4IYpwT2Ojq3+Mvnsw2QCy/ztJU5BjWFwOZeyUIUxkRzWc9V22DHqRrH9RaO+LKZpE1J9bRTCL2hfF14EgWVAIk3homGKeHscKNuFOJW1TAEJpGh/kA63TKyKnGjobBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540431; c=relaxed/simple;
	bh=Rd2BZ320rkppg29DKbnsJgIylyzgcIUnKXnmhKfu3i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUCvVmD8r+baG64jzo+hUT/VN3tZoc5qe+vgxFY+EQGpphLst3hxaIdw1By2mCpCqDAxv1xfmjdTCJku+/JuTiYV3ADiDSQHpXS4eOEkfDgPZHPms/tWGkbGq8A9QpLO8pvefCINSJwnswgXIxCFCzkxUYM6aTP4v1gDaJNq6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FOaDuGBU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBalP4P6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FOaDuGBU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBalP4P6"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8BB9711519D0;
	Tue, 13 Aug 2024 05:13:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540429; x=1723626829; bh=w2UOh0YL7c
	jCA2fff3BDWRUgHS5FgtCOGQ5CbWeLT4I=; b=FOaDuGBU5yitQTbxkgO1XiKRiA
	PvO3LPSUtI6APqkQHcVcXMDpkJB9CB4ozdk5eOcyD0mx+VEBzvDX9Ll/y/DXZHse
	zx2o833t0I95BMiVAKR4UIzTEszdd5K88/rMoKUUt4TKtfbChHUoWtMjERemDJdW
	h1gH7zV27GePd1gRd4nrUyIF66KfC5INpJCBxk6g5mQqCSha/LUs6SgFYqYiV+zt
	TuXwIPS4gEICNZhCtN3ybYzqg34XAcM522suQp5T/WclpV02zhY3DeAjIO7m/AP+
	/+9AMGWRZChGZ7UpD67ihULfXJrZuJltWMQWlHjcxdyamGIZ0ZcBXcJ8IsnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540429; x=1723626829; bh=w2UOh0YL7cjCA2fff3BDWRUgHS5F
	gtCOGQ5CbWeLT4I=; b=dBalP4P6Ol1dcsMSApiR3dV2vQyeIQeDS7LwM8IPmKm1
	zBiziT3annN1r2Ymr94BJ4AOxXcpRlol0PSrJiHsLw0wcUCais1syJ3LHrkO0BVB
	paZ07Udn0Tih/VZVAjLS2jiu08JhXCR5Vjj1yKVhqkt0km1i+VaXqj7CYHUuo7FK
	uOh6b+htkg2UnboJ0wUfCK4N4gNiFulPJNhrCR+imfhedjFXXpYjb/I77m+xDc+Y
	EaadYN8/2VoUTLBysDhf/iIv29H4vHaG9bAabN8fJ/S3cszjp8CgMHBtTurYzqRS
	d9Q5PHMaAoZLL2RY4P5NNO/Kd5X2FYfPFJ+MwVuqLQ==
X-ME-Sender: <xms:zSO7ZsmzFrb8_RcWDvAeOqINFuzHF5KBEmJEG_HwUTnG5W9400pjKQ>
    <xme:zSO7Zr0-c0CV2yGDn94N1UkOGIDctTpDGViwbCBtRf29haEgfTt55G_EplQhzwuDb
    oTa2s_4FlOSFrohaQ>
X-ME-Received: <xmr:zSO7ZqrcC68rChXWKnT2O5W2_gR6lIbQkvRwj01xK9ZFTma4Q7nW9-uBS1L0nftsyWAX13Ff6yOqbNGv_vEtTUDft0Wqcm7qJA1NdctqOn7NqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zSO7Zokc6U3TIDtteNBX0Q04nw9NOtwsVFnk6pnVwbHtZPyalmvMzg>
    <xmx:zSO7Zq0AdPQu7hnNBQ2OP_1Vo8GtjmjDpRQ7SVAeMtggy-puZ59tDA>
    <xmx:zSO7ZvtTYnR2J1jdJC86JsZZBd2YDyC2ndfOWxPplzisLUOH1HmFwg>
    <xmx:zSO7ZmXVUm1Ujap-kEfjN0fzNje_mUNuG3apOwlCpHD2hKTp-uztpQ>
    <xmx:zSO7ZvwdxQCVSFt-uXsnqUmkRYlAlyhNQQ5zW3NHY7_K3Huh3Y5UlE0z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c4057ef9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:31 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/20] config: expose `repo_config_clear()`
Message-ID: <5e73ef6cec809a3f1009d302b8721b56b048898d.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

While we already have `repo_config_clear()` as an alternative to
`git_config_clear()` that doesn't rely on `the_repository`, it is not
exposed to callers outside of the config subsystem. Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 2 +-
 config.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index ac89b708e7..476cd73c9e 100644
--- a/config.c
+++ b/config.c
@@ -2564,7 +2564,7 @@ static void git_config_check_init(struct repository *repo)
 	repo_read_config(repo);
 }
 
-static void repo_config_clear(struct repository *repo)
+void repo_config_clear(struct repository *repo)
 {
 	if (!repo->config || !repo->config->hash_initialized)
 		return;
diff --git a/config.h b/config.h
index b13e1bfb8d..8eb3efa0c4 100644
--- a/config.h
+++ b/config.h
@@ -651,6 +651,7 @@ int git_config_get_string_multi(const char *key,
  * Resets and invalidates the config cache.
  */
 void git_config_clear(void);
+void repo_config_clear(struct repository *repo);
 
 /**
  * Allocates and copies the retrieved string into the `dest` parameter for
-- 
2.46.0.46.g406f326d27.dirty

