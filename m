Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998DE3112DA
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096696; cv=none; b=dInl3kqQj0nWJ8fw2ElHNo+dmyyGewZTXKM9gYWQYvEJdi5NU4hKbiMtP4ip37ymu919U40r8rYTsF2UwsUYy8joX3Nv19K65/HP4cXvZ/XL5uQiaShhKykvLmfvW4/euqI0dGNHUFbH+/Jiit2/VFbsiYzIihK9koSdWuhsag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096696; c=relaxed/simple;
	bh=dj2dJjhAVhgdvyTdm4ayP1fffZk/he6PiE07t8cJbPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XV2m26iCuC9SkxQvqWEBkPn1x9Dm7xd3lHdHR8K8Hyw1tCeIv2bTMyCogCQ0JJFyBlAB1im8TE/QWQcGoLrpWbylTrUWmGgBhbNPftaSji2wG/gwLLejZ3tpHtfzWAENPqs4973TPjvucfZrmhAEH1faBoWCIa6DTHBIWE/16H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bKXI+Ru5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVLcrRxD; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bKXI+Ru5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVLcrRxD"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E98177A0064;
	Mon, 18 May 2026 05:31:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 18 May 2026 05:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096694;
	 x=1779183094; bh=qCPXRpNvGVyexBG1g0jN71a43FBiF/GB1fAhwRE+mV4=; b=
	bKXI+Ru5IpWygsVJKtFGpbmTNCM3jckLOhdvdhKiXsZqGYPTbnNDfPU/IlNAQzdr
	8nZ+fOHzxeImRboFMzPHUiIBjC9N91opSUjp7iTNA4SpglusAde2eNvLfIdRau7z
	2+nTjBYFIB+HCeq+/jHk0qgPm2CuIUQBJCwXmqPcbcti3xzQyQXGFn0UGZBKjnEx
	0KWqxz2JhM1h8ZTd9E000YlhzfSkFrx5fFAB7oKHMdc2SPfEyeB1w7lOuQCiQA9m
	Ut5S5AJWKPGctNMUoUYfPmC+DCt1nfV6AhrfCvTC1FE7KRwmGUItKxo/53Xr1t4T
	yceTsDzuuinc/hyWCTdxEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096694; x=
	1779183094; bh=qCPXRpNvGVyexBG1g0jN71a43FBiF/GB1fAhwRE+mV4=; b=Z
	VLcrRxDilEwavoI4Tc3m/Aos7VoXtl38Rx8+xuIQhX/JIUdmwOtouG1wUshTEp03
	VjZNwO6Sou9cdxZGjquDPkUknNxdqFdBYkUgp16aNZRew5MmRxa65BGiYnkcHcn7
	DSiiYDK4e8mTFth0QLRezqu/y2L9utA+EMbnEiG8i1asagwaerZS0SJYO7CKO2ph
	XiH3XO6sZAJuVAvtjwFd93zd1Rdkmjd4eOo0KDcyk+1GwWnDNMS+HNDUy9QtoOA+
	2Ns5ocHk70z9pJ+WOABb/HwfIxjQlVCvdMweTKenO/UTKwRuPrgl6p+DQhYNkxhW
	uZ1YQQsoB/EEdV1Dz6FOw==
X-ME-Sender: <xms:dtwKatrCD1ChQUuzaR31rStxk7DbcJMS9Ss6o_WiYet0q8-MWD-HIg>
    <xme:dtwKami56geh2pFAF2XC8DGHM6xD5Zd5QFWZcagL3og_xF0G9d8v8fJ3obYwsk9H0
    v1ctTBcWbG_VAbS7YHR8gEkilzMuQoKXS1fQEdNBbaAwL6gb44fx7E>
X-ME-Received: <xmr:dtwKaij0dgCqIUqQ9NOQk4ZUdEisK9ihamwooNjAdtvcl7YMeYxeWCN58wP-apJDTYbEiRhtSFx9pEuEo_V2yS2UebIrxZRLRdlu3HKvSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dtwKakgPg1xXvnfkikgIOEk9Ck7rmJKRK7ke0JvU0K0Cj7pHatkC1Q>
    <xmx:dtwKaqLu_d7TD4GlT90x4433c-Qn2XI0VF6zuFNCS47y4kxbbtBs-w>
    <xmx:dtwKarGA2JP48HtaqIrmGt4vJJJbpVTaU4ugqqRrQwIoucTLAxJDeQ>
    <xmx:dtwKamQZM-7ihVzDF1TR2pBW17vnp_uQX8ECuARus5B9gTuXoYqLAg>
    <xmx:dtwKapwWGnTBljFVxECC98X2AxqhbFJi94WzNuNEVd0ss_lunUR7oASo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba717f83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:31:02 +0200
Subject: [PATCH v2 11/18] setup: stop using `the_repository` in
 `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-11-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `setup_git_env()` and instead accept the
repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Furthermore, the function is never used outside of "setup.c". Drop the
declaration in "environment.h" and make it static.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.h | 2 --
 setup.c       | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/environment.h b/environment.h
index 123a71cdc8..9eb97b3869 100644
--- a/environment.h
+++ b/environment.h
@@ -147,8 +147,6 @@ void repo_config_values_init(struct repo_config_values *cfg);
  * Please do not add new global config variables here.
  */
 # ifdef USE_THE_REPOSITORY_VARIABLE
-void setup_git_env(const char *git_dir);
-
 /*
  * Returns true iff we have a configured git repository (either via
  * setup_git_directory, or in the environment via $GIT_DIR).
diff --git a/setup.c b/setup.c
index 796ac5792f..8965f8ccaf 100644
--- a/setup.c
+++ b/setup.c
@@ -1074,9 +1074,9 @@ static void setup_git_env_internal(struct repository *repo,
 		fetch_if_missing = 0;
 }
 
-void setup_git_env(const char *git_dir)
+static void setup_git_env(struct repository *repo, const char *git_dir)
 {
-	setup_git_env_internal(the_repository, git_dir, false);
+	setup_git_env_internal(repo, git_dir, false);
 }
 
 static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
@@ -1988,7 +1988,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env(gitdir);
+			setup_git_env(the_repository, gitdir);
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);

-- 
2.54.0.771.g3ed373ac14.dirty

