Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8723FC5A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820085; cv=none; b=oVc42d5Vh+rzA/BjRhDoR4pbPPNUWjQ6ppofRxMTOcqIJCouYlCeQS7iUBquWtJgrpfyjBurHM1Mnb8pfDlC42rg4WMeHXwtyB0907UsIqnsxhQ5zqsJHacTdV+xjzYMj3FeoVMHbdp2YSpmYVVqWgNi7eBRsq2FhyTUQC5DVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820085; c=relaxed/simple;
	bh=Rm7/k0A33LLSkfy5dYmQzBe3EX9GrPVlxRoRD7bqCMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nk2dv3WABzLbqrdUv2yW21nWRE8kk7FCIL8SKthXnkqdi1Uj9SEtzYo9xygNUJLva0z/uflS0E1dsMHPZw8daRImTreXkk8LOoUgrSG/enWoIntT/CXWoa4Cpa+BF8+so5k/HKqhAgwan5OvJkZg+5/fhUjvT/mE/qIzp39GYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cnjGqRxv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hn6RN6eZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cnjGqRxv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hn6RN6eZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A0FB1D000CC
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 30 Jun 2026 07:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820083;
	 x=1782906483; bh=lbcqlXcge9AKsJcNdMXLKg46qNmLkfN8eTtXBCvoi8k=; b=
	cnjGqRxvof/OE+fOLn/l1534eVUPjTttFACQqG3ZXnrjOv2zxAKRLh1O2kaB1V1M
	3Q5zyeAY4Q3bG+6wsJuC9fvTmbtSGmzFhlQqJpFW7cmgu3ZamkXb8wzqQDPkmP0b
	WtwX9n8fygPd7xp8Gs5m9MYRgSb+J16BUPupnPGX+ZaUOaksJSi/uGN79ZKSpUiz
	H5Puip+5VezmJAEfhG+dxmOrH1nU/boDHkQUlG2izlvbaQD67+4g7g+fm81Tii37
	8nksZYYHt2havHIvV0WHl3tx1Dy87eK6E+x5zZfcyFZ9BYuU0QCTwgMuFEikNAMx
	ME+zR7sMPztK7yFgcXngqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820083; x=
	1782906483; bh=lbcqlXcge9AKsJcNdMXLKg46qNmLkfN8eTtXBCvoi8k=; b=h
	n6RN6eZSuyk4+eqAPQV4/kyaDo8YP+OXC74O1R0/Owgwc76xJzgl3nc6b0Kjpj/E
	5eX+zClfglnkl+m1wT3zHpi0BDuKLHvHhPEihUs9EKS1qQRJmo9CtdEjFMbcYo7N
	SCR5BJPlYKPmr7QnDp9qSla+OBrMvi5w+dr4G4woTB7O+S126heJwc3JAABgDqmh
	BIVbb2tUzFXvqH4OIQ9PDYD0gBa4n5e4XetOnm3QSImy/b8ay0v4I/74ABsVIAri
	7njPk5hu1yYfVIkj60hKPaoSRLfPze3ob/WO2CFak0RUCOF9ypIISGU/ZnPqxaIJ
	nkmyKLQbA10UII+FMEB1A==
X-ME-Sender: <xms:86xDarSyD8L18oBRstYOIZwIcFRopum9IVr2uVAPeuGanF-EXEl8Xg>
    <xme:86xDajvjzDeZD8ob1epCU4QokIHjbtuaV-CfBx3XsE2TUGEyuhUO53au01CkPi8I3
    2QJF2TMy70hf1HWvIgazKGd9RfMPCEGPdg1YRePbS2PF8HM_Hi5WQ>
X-ME-Received: <xmr:86xDamct6vYhFnZZ-OEy4xTxwxvidVvDCVXLg3bJlY9yM__zkqfIG-5Lma7aM6LOn6iICbivCXmbW_Oss3NFNE8M8RJOVV4K6FJKnxKVv_2HHA>
X-ME-Proxy-Cause: dmFkZTFMj0npvFJ5xMu5TnTZGwl/kjNgIE3c+0+JrvywJVsBHvwNH0JmEkV9/sHb7KtHci
    MWHt4fCw++BHgU20LsJIOXEGWWe7laoLapVct5ezFWgUrSK246UxYzIlrE931fJU7zptCb
    Kt8ycW9gOfxVEBILBMqaO/gR7ZjX830aRvEzgMVkDX71WFJ1OAahhczPptAaL8l+tOR3ej
    9r8uWRRiGNgTXQd7Q16Bn4Ti/3nvp69LgGzwNNdE7d9Zs6RyP3ilqh9SA/M1mBNs2+qPBf
    vwS5f4zH1TbnYNSv0Awptv9a5rucDDTqwCIXVp+kgUqtQvSOo6yzZiVbOAfdN362M5E2dy
    iZi+LFEdQVLVwezrbtZoSLpEI/WZN00D6DmWzCfrNX6a/2XqRHb63Fwjd9uSDgNCSn1Dgc
    TOHFdy5AufzgJ8M3FgecbtXqRf0aD9lpYgti7xLV/+QLImWK6fNJX5qRNGDoHWZlBLUXn7
    1wELI3Eyo0UkZE7KQ7pi84R5gzboCpeBOGOqE4a85Yjjj+FR1eE6QQLwm+DSNYAnvUgE6H
    xUKf4kP/WRa9PAVS06iDkSKtCj584Dp9pyj+ItqrOmO2fGgMO3QeIHAHiuM3vo/QMvvtMK
    mV5uH+C+FsqT82XXH4B3Wkc7qjb7SwajPhJDOZ8BUca56WaLcR6oAsaZ3vrg
X-ME-Proxy: <xmx:86xDagJg6RubnoCp-bIQ8hDcE0v0mEieboJLjDge1Y49e9LZfEZZgg>
    <xmx:86xDakainG3WzdTDo1jgJy0yRQ0PosH0eQ7MC1P_mGC0FqFPhhKlZA>
    <xmx:86xDarvornNFn-WefYp-hNYFLdw4oXg7Pbl_hY_G5r1V900OTzpNsw>
    <xmx:86xDahsj9Cufq5WGnE_-aJd6THu4MHN45df87U8Zb8kU-hG6JhWWzA>
    <xmx:86xDavSz3YtYaI0zwRKfQiQl_ql5GA2H2KMQCNkKPBX1AHrVtTaaR1e2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db078f74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:42 +0200
Subject: [PATCH 03/13] setup: unify setup of shallow file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-3-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

It is possible to configure an arbitrary "shallow" file via two
mechanisms, and the respective logic to handle these is split across two
locations:

  - Via the "GIT_SHALLOW_FILE" environment variable, which is handled in
    `setup_git_env_internal()`.

  - Via the global "--shallow-file=" command line option, which is
    handled in `handle_options()`.

We can rather easily unify this logic by not configuring the shallow
file in `handle_options()`, but instead overwriting the environment
variable. The environment variable itself is then handled inside of
`apply_repository_format()`, which is responsible for configuring a
discovered Git directory.

This new logic is similar in nature to how we handle the other global
options already, all of which end up setting an environment variable.
So for one this gives us more consistency. But more importantly, this
change means that `the_repository` will not contain any relevant state
anymore before we hit `apply_repository_format()` once we're at the end
of this patch series. Consequently, it will become possible for us to
completely discard `the_repository` and populate it anew.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c   |  2 +-
 setup.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 387eabe38c..e5f1811b6b 100644
--- a/git.c
+++ b/git.c
@@ -306,7 +306,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
-			set_alternate_shallow_file(the_repository, (*argv)[0], 1);
+			setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[0], 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
diff --git a/setup.c b/setup.c
index f54eac5e5a..5e6b959f68 100644
--- a/setup.c
+++ b/setup.c
@@ -1046,7 +1046,6 @@ static void setup_git_env_internal(struct repository *repo,
 				   const char *git_dir)
 {
 	char *git_replace_ref_base;
-	const char *shallow_file;
 	const char *replace_ref_base;
 	struct set_gitdir_args args = { NULL };
 	struct strvec to_free = STRVEC_INIT;
@@ -1067,10 +1066,6 @@ static void setup_git_env_internal(struct repository *repo,
 							  : "refs/replace/");
 	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
 
-	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
-	if (shallow_file)
-		set_alternate_shallow_file(repo, shallow_file, 0);
-
 	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
 		fetch_if_missing = 0;
 }
@@ -1774,8 +1769,13 @@ int apply_repository_format(struct repository *repo,
 	}
 
 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
+		const char *shallow_file;
+
 		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
 		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
+		if (shallow_file)
+			set_alternate_shallow_file(repo, shallow_file, 0);
 	}
 
 	repo->bare_cfg = format->is_bare;

-- 
2.55.0.795.g602f6c329a.dirty

