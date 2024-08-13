Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7B17BB34
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540436; cv=none; b=bqZb+eEuFoTGcF+NllzTRz8+GjKFqV1iF3JP0BmXxs/QTKdOxv5BSmwc+nDiJvPJ0iRyR2N3yO6HT6juf4pbiAsH1u0oiSuRkAKr5N82JLRHLR2TZkJD/aYYgHtgnky/ZlBJJnw5ww3uTNH1VmDCK8B1IlChvtiHmyIM+XiwR3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540436; c=relaxed/simple;
	bh=/EFj+1y8Ny3evhRDxTz1R2Da1BZMxqhDfrZz+KTjA6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCn5sO2Q6BMy/5CEJwX8qVVgku11F+W1YL9lp6Utwm2I4RoJ9dQLHFRTD2hpaIhwpcXgZgpYXP+34Yc90tkNoMKCX73GIUhEtn7MFRkfXlxdbjktpRAkBsNH6imWySWkYowdV6M40M2NM9SF0Y/8oqOGaK1L7A8KhzfMOSItMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HCVvLRIb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZZtSgy2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HCVvLRIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZZtSgy2"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B88D611519D0;
	Tue, 13 Aug 2024 05:13:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540433; x=1723626833; bh=/ZkGNfDzxi
	G7TcdqMd9hWolC1zRKJSSwqlj0CDgbsL8=; b=HCVvLRIbcnSBLu9p89e/FVEaOW
	MdtmOIiZhwXiJnv9rtmNpp0wkiKquSpzk3+cT9QBn5xBFTBEIsfhc2VHT7GXQKQo
	hXTsTc50SOBj84HRyd8p0vHYI4WDlKju7T0xtWaGMeChyFhSskR3kQVkRqpVYDkz
	E/jSJ8HqNSIo2wPy3lCt6mj6ur9cBHPCcv7slsUbMABiU6cfgzN1bSaxb8WNztub
	rYnU6YCOY4TB63ge/o+f7w8iMcTVcH+abQGwyCD2m1WMD8siKAgEHTNRA/N1X0sK
	mGbyHElcpNaj1ceL7vPJrvcK3AMBHl75JUE23mCgL7knozGff+wb/yE3vU+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540433; x=1723626833; bh=/ZkGNfDzxiG7TcdqMd9hWolC1zRK
	JSSwqlj0CDgbsL8=; b=LZZtSgy2+NFiuNqJiQvgpOCI9xtWuRn7TCE1uG9VJ3mX
	6lp1JgaKTMi64PAwIsyPI4IEOwlW4IW9eKXsYt2oAJ3NPhci+76GRBocigcAqv8j
	aiS4H++UiyEUQkN4HPRATuAHkiX+HCzUlNTx9ld/bRW5Nwm/5vEwSUxcM/VEoLno
	2kUwLDxZrMkhuyaIHALJBLqU0851mIyLqyEfDPbG85xp2DetvwmWaFfSo8b9HsXM
	vLly6SIpwNJYLV6TlgC3tTwuaAhBvBcXW6XRV8DCU7wxxi31hVYFrHzJuArZOu7A
	+FDZo6JJsLnlLPEqJrGhClMmbnf0oR5WgZukDblA0g==
X-ME-Sender: <xms:0SO7ZtWpJTmzMdmPOQBXp_1FfaWJKbFT9Mn3nvI_GJS8wm6igwcUhA>
    <xme:0SO7ZtnJ8Lk-ofM6z-HIxwklIKhCb23J1sRsVx1PVm0cEQa_UBjSR03TKY7kOHPtL
    MWdOfpJT0n9IEym7A>
X-ME-Received: <xmr:0SO7ZpY_S7puKcebGUHCY1OVIHYIUPc4by7K7VxAknIBXKW3LdW6_jWoVrPs0jJEeNW5ng1KJ4Sg4nFtoW79dpEFidCS51OIsCY4c-Rm1rVcAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0SO7ZgVDVuSppA3myNnfgHSKHGjSHLGARr8Q5XO531JrM9_b0sDrIQ>
    <xmx:0SO7ZnnL0BN28ZlOtabfy9GvTEl-iGKjyQIhNAocEFhS9cGMgwml-Q>
    <xmx:0SO7Ztf0Jwm4eOPPMKbH4w5WK1zV6F_87hUZutEK2Ccpd_zyCKWoTg>
    <xmx:0SO7ZhH7zWYad-IZ7yS5eRH7Vyjq5-W6v2XkV7lirHm-lLiC-9Xv0Q>
    <xmx:0SO7Zlh-89BvteWv8qU6JBoTf1wBm4mZkssGe9KW6kNJ5T_r2lfN0lGR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 699f6840 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:36 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/20] config: pass repo to
 `git_config_get_index_threads()`
Message-ID: <35e0f4579cdd17ec098f210e9f00079d412a4180.1723540226.git.ps@pks.im>
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

Refactor `git_config_get_index_threads()` to accept a `struct
repository` such that we can get rid of the implicit dependency on
`the_repository`. Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c     | 4 ++--
 config.h     | 2 +-
 read-cache.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 476cd73c9e..387c7282e9 100644
--- a/config.c
+++ b/config.c
@@ -2826,7 +2826,7 @@ int git_config_get_max_percent_split_change(void)
 	return -1; /* default value */
 }
 
-int git_config_get_index_threads(int *dest)
+int repo_config_get_index_threads(struct repository *r, int *dest)
 {
 	int is_bool, val;
 
@@ -2836,7 +2836,7 @@ int git_config_get_index_threads(int *dest)
 		return 0;
 	}
 
-	if (!git_config_get_bool_or_int("index.threads", &is_bool, &val)) {
+	if (!repo_config_get_bool_or_int(r, "index.threads", &is_bool, &val)) {
 		if (is_bool)
 			*dest = val ? 0 : 1;
 		else
diff --git a/config.h b/config.h
index 8eb3efa0c4..3f68b30047 100644
--- a/config.h
+++ b/config.h
@@ -710,7 +710,7 @@ int git_config_get_maybe_bool(const char *key, int *dest);
  */
 int git_config_get_pathname(const char *key, char **dest);
 
-int git_config_get_index_threads(int *dest);
+int repo_config_get_index_threads(struct repository *r, int *dest);
 int git_config_get_split_index(void);
 int git_config_get_max_percent_split_change(void);
 
diff --git a/read-cache.c b/read-cache.c
index 742369b295..ad09950153 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2267,7 +2267,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	src_offset = sizeof(*hdr);
 
-	if (git_config_get_index_threads(&nr_threads))
+	if (repo_config_get_index_threads(the_repository, &nr_threads))
 		nr_threads = 1;
 
 	/* TODO: does creating more threads than cores help? */
@@ -2787,7 +2787,7 @@ static int record_eoie(void)
 	 * used for threading is written by default if the user
 	 * explicitly requested threaded index reads.
 	 */
-	return !git_config_get_index_threads(&val) && val != 1;
+	return !repo_config_get_index_threads(the_repository, &val) && val != 1;
 }
 
 static int record_ieot(void)
@@ -2802,7 +2802,7 @@ static int record_ieot(void)
 	 * written by default if the user explicitly requested
 	 * threaded index reads.
 	 */
-	return !git_config_get_index_threads(&val) && val != 1;
+	return !repo_config_get_index_threads(the_repository, &val) && val != 1;
 }
 
 enum write_extensions {
@@ -2875,7 +2875,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	hashwrite(f, &hdr, sizeof(hdr));
 
-	if (!HAVE_THREADS || git_config_get_index_threads(&nr_threads))
+	if (!HAVE_THREADS || repo_config_get_index_threads(the_repository, &nr_threads))
 		nr_threads = 1;
 
 	if (nr_threads != 1 && record_ieot()) {
-- 
2.46.0.46.g406f326d27.dirty

