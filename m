Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897A1E0E1A
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926225; cv=none; b=DuvqM3Vth06BHHxLd9uib/MnNyDWA+9CNVlBVHPTKErB2bL4xQ+aPohMfrK5hfYaa98c4SmHGNyZb/PuWQHMdd9kIu+sRMNFwA/MyaXanGHO8NnYXHn5Y1cgBfbP0vkID6LydhjiU0evcrNJq2rho3cBPwd2+rWU/AKJgCexpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926225; c=relaxed/simple;
	bh=nF88Nu/wR9maTgZCRBwwmNSSZ1LrWt+0L+iGldetw84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2eC4iVfUEBABzjMveOruDRFYPU7Jqu+mz1Okfgut7Njf89/GrStwJYC6qrITgRdzc9/kdquAHmw2nqL9gvn+p7jyyXt6FCEUf+B6TJMkWAK4WRctIHJaC8ad9+zx00UoOFB02hB9PZy2+8xlsSjNyV+onBRzFiyXo1SyJmE0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KsDGlSDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zr8gpoh9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KsDGlSDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zr8gpoh9"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AFA01140127;
	Fri,  7 Feb 2025 06:03:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 07 Feb 2025 06:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926223;
	 x=1739012623; bh=AGD/73TEmuDe7vl0Shjgp6rtxAt+A6hOvzPVJoTdxis=; b=
	KsDGlSDzKcomIMNjQeayzYEz2nBtxdRDexfw3AicPbRN9Dqqcxg86MS/o0AbsRY5
	GzsyZC91+KYf5gMBkmBTfVwcV56BTlo/oim4KT7u0UPrOkQjhnOF6mYhsz+sI355
	EvzsYvF8/Fdls3fKCvY4z/E28tD5smj6YfnmB4U8+rxpC7FLUSI6oGuaLk/Z8qzb
	nVt7Fp+zpnLV3toyZmnS8ehPavJx9Fj1h10LJc1w4aOXw/scQa6QEpbPhHmyWaDl
	1MRik16GOHeEzRgW8UWDODVXsUTUMir/RO2MGgLmTa9MZUFeGOJFNmqvPadkLeax
	Jmy3BN/BOibBIs9fASed1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926223; x=
	1739012623; bh=AGD/73TEmuDe7vl0Shjgp6rtxAt+A6hOvzPVJoTdxis=; b=z
	r8gpoh9x1MRB7buwrjK5mENbj9KTU2QDXyvgfg2MFa2ctqs2pM7v6MuPorYx3S/L
	mTV+xaLGip5CFhj9/PSazcMOrJEBjV2qftL9tbkgD4otSLhxZUHyw9pVDjfUtEeX
	1szZjLbYlVrsfzanCPb5VPv2pQnt2D8vdBUyEDClwfArUzw552REANiUVqHXehwg
	nEPWQB7ivjGJT+K2HSbmIHEFPleFGrMAW0JBcBHMrqzwLflfTzARgxuR6W1mdUaP
	MU8cluvRt4TeAfmenRRgsSs8SfNa0J4wjxmUb0ewk+pUp78V3BgyszZS7B9EeiTZ
	If2HPP9uWfACslolmPTVg==
X-ME-Sender: <xms:j-ilZyR4v8kuhG40SoC5cgsPKo6tyGojIxC1Vvje9ZanLWaE_XCs3g>
    <xme:j-ilZ3ybnC0E7L5qSgMdCsWHWzd-svwbry0giiyppnBCoYdPfjuRHd3C2lk3965NM
    ZGVH-w_ed4M6youAA>
X-ME-Received: <xmr:j-ilZ_3zD_U0PUhdr69Y1GL6jpkd3_1nk2Cw4UqOLSNNcUKnNJBLuewqYdd7aoyqe5c9K-gBlRjY4g6eTpooIfop4yAK_MXaybMHE8INGRpb2oEV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:j-ilZ-CcH0Vl5UYMDqi23TgjPVxI_Kwz19eyvyaxXFKi49QqRKZOfw>
    <xmx:j-ilZ7jPKvBGK-6etgchV1X85OdRwEkkuGt0bWQq-tOkc1ombcmeMw>
    <xmx:j-ilZ6pdYEeYKWagRmRfkQskTjXcrLnm2TV9DPTeONSs04oCSMR8dA>
    <xmx:j-ilZ-guhC9TTnWzJrqKn0MDB7GDYCTYztJtaG2qZFR_IpLQvPWDGQ>
    <xmx:j-ilZ4sO0xLhKX7aMriYCza7Ngq6RmDcQBtWsVekMw2K17xmTJGGJ_sN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73beffba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:38 +0100
Subject: [PATCH v2 13/16] repo-settings: introduce function to clear struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-13-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

We don't provide a way to clear a `struct repo_settings`, and instead
open-code this in `repo_clear()`. This is mixing up concerns and means
that developers have to touch multiple files whenever they add a new
field to the structure in case the associated resources need to be
released.

Provide a new `repo_settings_clear()` function to improve this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repo-settings.c | 10 ++++++++--
 repo-settings.h |  1 +
 repository.c    |  2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 9d16d5399e..719cd7c85c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -21,7 +21,6 @@ static void repo_cfg_int(struct repository *r, const char *key, int *dest,
 
 void prepare_repo_settings(struct repository *r)
 {
-	const struct repo_settings defaults = REPO_SETTINGS_INIT;
 	int experimental;
 	int value;
 	const char *strval;
@@ -35,7 +34,7 @@ void prepare_repo_settings(struct repository *r)
 	if (r->settings.initialized)
 		return;
 
-	memcpy(&r->settings, &defaults, sizeof(defaults));
+	repo_settings_clear(r);
 	r->settings.initialized++;
 
 	/* Booleans config or default, cascades to other settings */
@@ -143,6 +142,13 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.packed_git_limit = ulongval;
 }
 
+void repo_settings_clear(struct repository *r)
+{
+	struct repo_settings empty = REPO_SETTINGS_INIT;
+	FREE_AND_NULL(r->settings.fsmonitor);
+	r->settings = empty;
+}
+
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
 {
 	const char *value;
diff --git a/repo-settings.h b/repo-settings.h
index 93ea0c3274..c4f7e3bd8a 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -73,6 +73,7 @@ struct repo_settings {
 }
 
 void prepare_repo_settings(struct repository *r);
+void repo_settings_clear(struct repository *r);
 
 /* Read the value for "core.logAllRefUpdates". */
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
diff --git a/repository.c b/repository.c
index 648cd88474..6cbaf2e3da 100644
--- a/repository.c
+++ b/repository.c
@@ -380,7 +380,7 @@ void repo_clear(struct repository *repo)
 	parsed_object_pool_clear(repo->parsed_objects);
 	FREE_AND_NULL(repo->parsed_objects);
 
-	FREE_AND_NULL(repo->settings.fsmonitor);
+	repo_settings_clear(repo);
 
 	if (repo->config) {
 		git_configset_clear(repo->config);

-- 
2.48.1.538.gc4cfc42d60.dirty

