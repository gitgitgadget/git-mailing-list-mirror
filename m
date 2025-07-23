Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC62F4A1A
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279773; cv=none; b=XC/dCtII69/R3MY3yQrNyRSp+0z9EUNy2HQ+IfZDD0veMRA6L8MWpJbS/7YPIpEJglV8UK2dmWmpRVc+goMjCl0Z1z4I/UHFGCdWUT85fHYaj3JLRA9P3SIk0wDnjDN7XxmSDLgbo/ZHjwDn9bsaoTQjJY2Te6CScmQIH+CwVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279773; c=relaxed/simple;
	bh=42V6RxuQKGHctgubJVczzra/OJ8BBVX5dULHANrkF1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEtXZZNCPwp2o7y24jirXNeCrmLCdDwGClEHM4Q7rIj3GAoTWriYZa+FhyNkWOgMMRXM/0f2UGO9j3WzkrimdHCc08p0xy63nDJ8ULW18LV8Y+QRe+/ZAnIrFkWSUDlBaVD7qyettfVRFkkKjk6OJcLrHUPsGS/ZsDA5nqmbgAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=srL5jjRb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nR1Zfx6A; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="srL5jjRb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nR1Zfx6A"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C9CE9EC1338;
	Wed, 23 Jul 2025 10:09:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 23 Jul 2025 10:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279770;
	 x=1753366170; bh=AH9NpT8uTzXQ6m/mFvVHLUJz7C7qCSYa64tuw692VIU=; b=
	srL5jjRbd2rv11eWjH/2aXckOo/Dr3elmjw/+dlvpdVBmZFs+e5TJwb4vMTUX9H+
	PK4gaLc2UIJqmtxMrpMMMBf+EyA2T+SyKPS/wtOX+br0rzGbxtVYjtid7lnN8svB
	rEL5Xtxkpu4mWas//Bx0xCoXiZXbuJctYuar5l5YXDciXBH8ey/J+/Gq78I3ZWaC
	pOBl2SI59LsEVKcinKtdgFJumtLxrfKp+t2Xl3qo1Em8aCYBiejCIoI6Ri+1LHiM
	pVVANF9Gz/+VJynYzWrILNC7vfh9yJtjIBQ5zCJyIaoDm8N13YrnPsnwDxTcGnv3
	HAi9RPqTY4k0OH6Ftr/WdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279770; x=
	1753366170; bh=AH9NpT8uTzXQ6m/mFvVHLUJz7C7qCSYa64tuw692VIU=; b=n
	R1Zfx6A50fHj/e/PxFD/DCAiG4RZJd/3a97ztETgTfT1ZmLrNkAgY8aSRckwvgdh
	d+/KHaXYfVJy3tQxxwRnL9F2JWnWqqZtIxschVKdGztj2dVPpGtPFKlb7lUvbxnM
	NLYPVmljwmeJ9yVzLPas1QCpY5GMh0VEcJhmqdXhvZaZTlbM1ZdOGzHZ4Mgz8qp5
	ieG/8BeC3xUxXrPuA9SIsxHlKNRB4EZKejkL1mVYAM73tNjPYMHtsDTSzv2rkJ7r
	J6tlhbYHoWqg9b9hYLOKK1Q/B6vYrAtPvqTpnyvPK35WRFtkHw++0fklfX5vCvkV
	LyEsuwsP95t6NmAF0+0+A==
X-ME-Sender: <xms:Gu2AaNQWpfm-42QxH8zicpSC10m6oUesy1yAj2nV8YzVsR-uD301Hg>
    <xme:Gu2AaG8mhrURiTsdohdmI_jNx8H6NR3vO34Bh3nWR8nCthM0au2TCMdG3hOvdZNcI
    wpT1CnM2wJ43461bw>
X-ME-Received: <xmr:Gu2AaEpg1KiAfXzwvnlXi1jIh1yOg9hfKDPIV2j8Udm9NdnxT_o5WBGglRuDGhzlDx0dENKmE7O65ip67sA-D0DffwoJKcisNuOg60FlrcVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Gu2AaDn57YrU0xhYwQGPJcsyR3-kbmGteoz-D6G2SKYKYKJ_r-ZB5g>
    <xmx:Gu2AaLI-YMHeN3qLQEC-PYEut59FHrNMRfyllCmADvqKIrKxAJoEKA>
    <xmx:Gu2AaIxQ-9EUV3WHSTOWTQRKs3fdi_38n6ogCDSTu193M2PFwAu-OQ>
    <xmx:Gu2AaDsLQY3an0NUrUnzMMGe_mNSVUw5tAb0-6D5X5AaCBf_EyuV6w>
    <xmx:Gu2AaOjwjz93ZdgkXpN1yVEAXdn3nAZzcLGVQ0fBXos-hUFWy-oX11X4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7cee7e00 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:40 +0200
Subject: [PATCH v2 19/21] config: remove unused `the_repository` wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-19-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Remove the last couple of wrapper functions that implicitly depend on
`the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/config.h b/config.h
index 61774f17db3..87baf8eeffe 100644
--- a/config.h
+++ b/config.h
@@ -718,32 +718,4 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 	lookup_config(mapping, ARRAY_SIZE(mapping), var)
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
-# ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
-{
-	return repo_config_get_bool_or_int(the_repository, key, is_bool, dest);
-}
-
-static inline int git_config_get_maybe_bool(const char *key, int *dest)
-{
-	return repo_config_get_maybe_bool(the_repository, key, dest);
-}
-
-static inline int git_config_get_pathname(const char *key, char **dest)
-{
-	return repo_config_get_pathname(the_repository, key, dest);
-}
-
-static inline void git_config_set_multivar_in_file(
-	const char *config_filename,
-	const char *key,
-	const char *value,
-	const char *value_pattern,
-	unsigned flags)
-{
-	repo_config_set_multivar_in_file(the_repository, config_filename,
-					 key, value, value_pattern, flags);
-}
-# endif /* USE_THE_REPOSITORY_VARIABLE */
-
 #endif /* CONFIG_H */

-- 
2.50.1.552.g942d659e1b.dirty

