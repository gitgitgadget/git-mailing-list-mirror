Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDA29C340
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749380; cv=none; b=Cvm2BLuAm/ahpw6e41HDIIA/z2lNLCdZAir/3TvaLwX6KnVK9fdKSWih4J+ZMAQTUKTKVi00wOFtsjhmMLWpjbTZnTQEMl326qxHZ1FS2graa4TstuGMYeRQIsVN7NpR/P5LytjCnrkHnNb8w/Y9RCBb9SKDKO2bUyQmzqABtxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749380; c=relaxed/simple;
	bh=58+fxsrsowUuuxH1AyxOBlmMWbuKqnfx7gugRO7WXHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjWAs+a8F0sEUxKglgr6qZ/M0CO9AIx2YLCFCsuVjntqEzkpdpq6t8S8rVVE7Oji6KaKD72e36lWhSxGnEqYccEeXsOfIMp/MDhyp3lvrJxnaVgGJs+4IyFy4p5CCPl3fmcM8D2d6ZoCWIg1iyYfF5FeeqCShJ765RGUVyDHezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G0hA+4WD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PMMM/i/K; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G0hA+4WD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMMM/i/K"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C1DE1D00030
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 17 Jul 2025 06:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749376;
	 x=1752835776; bh=QGnX4/87eONE2qdqO4uvqi/r4DInsIwHUcvXb77K8pg=; b=
	G0hA+4WDMRNGWua5LlsVvRSpRZKIxHNnV7m+ZqpUSRJAdX0LA9t37mQ/vjENC458
	wnkeQFekTcmTuGVer+wzIeZKm/7BLekckf0GdCdbpufEI96sJwdAwABE1vZ8Zdt5
	abNQ0kzIXFXsO/QEZsGQGcoKGcIZjCZAllV9AWhDHcn9/2fY7Cghk5+1ZdE3Dmbx
	caT2p852aUbK2DHSndRmJuc8rbwksWr4Ow7fUFIni0jVrLlTT3ZSsvvurDloD5pN
	R71zLGr7Oo7IkV05Kr5hMRJheeiZN3CNN/hZvW1b3SqtcG1hUSYh4n4F6goojRhT
	j1C10jwOHvzg9pGjhLShdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749376; x=
	1752835776; bh=QGnX4/87eONE2qdqO4uvqi/r4DInsIwHUcvXb77K8pg=; b=P
	MMM/i/KZHdQZl4KzhCm5MzN6dblizh/8m73Hnz19aVG+KQPFBNNcNaOTwUNP1CzR
	YyDF42iWa4tkepaKidygOcNI2+EyIW5z4coknxNhiegT2Lu+GHK5YDn57/uEnOhH
	OD0IZsvUnBY8iZ4eXczhJVvf6u+7Pg1LyyHQjVtUoikdLwdStiX/T4AFvr1G1pL7
	lumhrF5sR+4nezfoqxTdAySMDPlGbQDrufQiHwOQYDge2iOicK/o7bLdNzxIUiXr
	a1AjWTH2hEHHAmWx71I9xuMvExDLqz/uU7RGZeb4I199GUqpRx/YwbSugIIfw03J
	qSnqLFbZkC9QNpqqShstQ==
X-ME-Sender: <xms:QNV4aCNLVrUBDkvMoSV6pxUdehGAkHJWVeJkDcXgkCikCvv3e3_rCw>
    <xme:QNV4aC_bpdeD5IiY7MPEqYZFYGJuWaUaSFIh7kNbzVTkKnglfqz5p6bbkcs3DJ7NY
    Rvt6Goz36OpU7UbsA>
X-ME-Received: <xmr:QNV4aCoOVA5MgX0UBTxtltW9mDOXB2TFx0FmnCaoeTUu1SBPIiXBTrm36ItGSeAIjM-7NgfqbeBrD9hIQ1aZqksdPpPj0OZA3yD_geIz1c5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:QNV4aE65YLofbi4WqrqHZEInaTilcdfaYeMvDSeRKklFUs8BD7W2gg>
    <xmx:QNV4aCPnPXsu94yuXdtY_kp46qcXyMIOulJi5BAzm9vn77kUNXanow>
    <xmx:QNV4aGPlR5R2ALB4FyaZjTD_mqru6m8-SEi340QkKH7ASCcMzBtSOg>
    <xmx:QNV4aK88i-TqsEQUFuovAMbE7GbvLAeLmbO70bcBgI8oAxLzni5M6g>
    <xmx:QNV4aL3NhB2D1SqcqVP8NIEOJi_7RI2tXJfctByQBVn1pQzX5m_Nj-mz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0333c2ca (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:22 +0200
Subject: [PATCH 02/21] config: drop `git_config_clear()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-2-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_clear()`. All
callsites are adjusted so that they use
`repo_config_clear(the_repository, ...)` instead. While some callsites
might already have a repository available, this mechanical conversion is
the exact same as the current situation and thus cannot cause any
regression. Those sites should eventually be cleaned up in a later patch
series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.h | 5 -----
 scalar.c | 2 +-
 setup.c  | 4 ++--
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/config.h b/config.h
index 6b729fc6bbf..4eea99e9b95 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline void git_config_clear(void)
-{
-	repo_config_clear(the_repository);
-}
-
 static inline int git_config_get(const char *key)
 {
 	return repo_config_get(the_repository, key);
diff --git a/scalar.c b/scalar.c
index 3b713abca3c..2aaff5aa109 100644
--- a/scalar.c
+++ b/scalar.c
@@ -763,7 +763,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 			break;
 		}
 
-		git_config_clear();
+		repo_config_clear(the_repository);
 
 		if (repo_init(&r, gitdir.buf, commondir.buf))
 			goto loop_end;
diff --git a/setup.c b/setup.c
index 91a3affdd8f..9661c5d5d5d 100644
--- a/setup.c
+++ b/setup.c
@@ -1741,7 +1741,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * configuration (including the per-repo config file that we
 	 * ignored previously).
 	 */
-	git_config_clear();
+	repo_config_clear(the_repository);
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -2337,7 +2337,7 @@ static int create_default_files(const char *template_path,
 	 * disk).
 	 */
 	copy_templates(template_path);
-	git_config_clear();
+	repo_config_clear(the_repository);
 	repo_settings_reset_shared_repository(the_repository);
 	repo_config(the_repository, git_default_config, NULL);
 

-- 
2.50.1.465.gcb3da1c9e6.dirty

