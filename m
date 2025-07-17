Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048F2BE056
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749433; cv=none; b=NZfSEc9y3R3gLUZSE5e4hHnxKmURGF126L1Kj8Q0tS7DPi7L8aCz/djB1Eqc2CEtYAVRHGv+mn+FMgOg1pnpWGcG0K29j7mghhql2T12edR/a65zr4bs9sMwt4xKBo6aaeYS043ppEyjUC1czvLKuEtsRw7Ci8YfxXGt/9u9B/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749433; c=relaxed/simple;
	bh=Umr1CQtclHOmPc7FkDHysSueVco+M6yJ1WpIbWyNvpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skHHPDWEv3nzq57gNDvt9sX1Es+IaH1iIGQ+lnH+GyQSRNjEIjt38EI57hMvegh7gwaYK7VTsuuk2bFk1Vf/sD80YkxF6bjXD98OIVnFuZHK2LNVCJrZwOpF80ZSVspYKejrONTMFPMnk8LJeTRssBmLi70yimxZ8ikmp/nbwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cZJ0S1Nu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeiyDH9z; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cZJ0S1Nu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeiyDH9z"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0146B7A021D
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 17 Jul 2025 06:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749430;
	 x=1752835830; bh=e1ZAlI79OV6pPBp54MkgGuGDx8VTsZ02claxJoEdwMg=; b=
	cZJ0S1Nu2J9XvccvkdyC3zuAnKrZVP+czO/r1sjgFeZiT1BFELd6CdW/hNrDesAR
	0XqXSvDf+VXlvuvu/SG+JdG1Y8qSnhMY5EAvL9gGnSa18voT9xo9WD3tN1A2GF+4
	LqGflYQjzVQO+JkJC+XGmnNUEmROPlSu4ygCiiBW8Jvo1Tf3EUNjJ7GOhkAvKmHB
	77SoY8aWyninLvaAIIXAM8Lrd0JithcqRqHF3joneEGJFGsdnWgNddBUz89ppN0s
	5MjV0T2ekN9AgESL+3y6CDLwOLTkVBExRCmfmIxzyOMngSz+wk1pjoq1R7p4R1yi
	BaJmH7VhKoY8DI2r/oavEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749430; x=
	1752835830; bh=e1ZAlI79OV6pPBp54MkgGuGDx8VTsZ02claxJoEdwMg=; b=H
	eiyDH9z/Z1IxGKVvdMozGBSH/HgjPHh1UvvczAe2ncm47jKQsCyQNinZuv12J6gO
	uubrxGwdnLvU/5SJ+lqonRyfr3TlhIdRYf+2TgDzwrTiHQywwMLT1071+3p0N4iT
	EhUgCgSSdNA0O1I+etErUJaqyos9l8sbAwtz8cY093+HYFx4OrNCGED1PnovdVeh
	Ijtsr8iV/ait+pItJheDJkIvi81e2SPfJIGFuuTls05ZcssmjPWY1vLR7k+TFnfk
	nt8iP67mc16StbTBHBKJcBHgclL6+ENBC9aagW8q2ydOgEk9FT8Tg1wSBBFZaWom
	gTgKhGcbrv0sV1RHa6GOw==
X-ME-Sender: <xms:dtV4aMwUBcqjELT94H_k0E1SmtHmmuaE1OAsBKPN8bEUW5idxsyx8A>
    <xme:dtV4aCSOCyWwPEt-1zhOdpR5GEId7Jk_kFM0oI8mCUXkpx3l4ORJc21W15Am5trVs
    XItib33buQmbjLTZA>
X-ME-Received: <xmr:dtV4aHteRdEIlMN8KlatW56Wyqy3H1n_iFmKo7oBhmo4rkwQwLyn87ZbwTu1nNIIoG_DWuAze-5SzF6YM-5kmEmK1dkY817Y_oUtYqNWoonU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:dtV4aMux9NGvmkfm4ZcBClijrKtbXaVXJg569Qlc2uXharK4Iue1BA>
    <xmx:dtV4aFwCu-_1xVGuTm-LOJQxWhiqNvpeNS3KkmVyx1dDiS3Jf9qzHg>
    <xmx:dtV4aKiyjRp2ZzwvwDdoh5NDQKNdJoN-23jYjOmAilt6cXruIBzaNA>
    <xmx:dtV4aBChS9iSU6O4BSZ3jpGzhHTiBxxi7AvYKphAORRk0XHDUG8QrQ>
    <xmx:dtV4aHrfq7r83vQrG35YymteTt3RwVcS-6NMxh3pRKy1RJb0Ti_UU2Dh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4a8d1e8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:39 +0200
Subject: [PATCH 19/21] config: remove unused `the_repository` wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-19-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.50.1.465.gcb3da1c9e6.dirty

