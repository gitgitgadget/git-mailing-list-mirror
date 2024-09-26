Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E618455A
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351209; cv=none; b=tgyex3lByoncMNYek1yU/tqzUigIkpaKu08kR7XQ4trbkqcgHOyzyF5+co0b3chkYRft8zxa5dQJEjzDm3qiTo7Z7of6t5Je3gg9ooYkRmLZbfRaQohkm3kzGc+9jF+yLMGZ0RjAT08ymRON0sEFX8k5jWZ+aTREewxNx8ikq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351209; c=relaxed/simple;
	bh=5Mh1mIUhXHetIiTZ/5fvD+hShueJ4jGUCqHaXdQAf9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxSEDG9N/zBmQJUQGOsZrxZ4OhG9QDXt844g7cXqKAUdOE3xsApI1j1iUzTZfdps0RO6uFonalHGaOzi8MYMAZQeAS4R0NIKuYokdN232GJkl3xgByHND9CD1gyKuHPBiEYaqgNSPzLAn9S4B4FxRskzT0edj1BN0+uSxClJd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ITAdLW6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xnuod9nx; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ITAdLW6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xnuod9nx"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 47043138061D;
	Thu, 26 Sep 2024 07:46:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 26 Sep 2024 07:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351207; x=1727437607; bh=49vc06f8wK
	DN1kYNnfIUHtDNWH6X+tIRbH+IG7ZjFvk=; b=ITAdLW6k7iRLcW2WV5kPl8nLRx
	nwrCiTziiejbvGmKxOBKXkluzQaeWFFZc4t1/bRlzUfdh+omigs3mCkFKA8GAeqe
	GuNdc5lFoJxZ9G6PDbeWZ570pkM4Jnrqs4S56YLPXlDjGpKTwGzy1Spe/i/1Y+FS
	bXbeB83k9oWcE+TCHG9Ceh5IRvzRiYovglQOqLMt+Ad8jk5FYq3QZtbsyK6rru/U
	qMeHrZ2ecufkMfqFAUPEVSjSnPpGqFtcUv/VIXW2fglxXHpMkFOTujfeFrXQ3yT7
	AhXqYG+nuIcxfSRVCLau2BWRdN0VlvJ2sY9U0RSmCG/WFmu2xuMSS/heVrRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351207; x=1727437607; bh=49vc06f8wKDN1kYNnfIUHtDNWH6X
	+tIRbH+IG7ZjFvk=; b=Xnuod9nx8i86Nqo62Yz9TEV5o8irrpT/r+XHCl5SsGWn
	x9WRMa8DuQOUQp9icPJjvajdfpJN5dClV3GUR8nSHoInGB5iJbuUJlyEUrZfvyUN
	4JQ3qV2xtTyh06VU4wCHSx5+CiXryJhTSTzwm/HieiyfOSgEYDI1IWhoZ0tstu67
	6zj+FeGz78ExGyywhwlOGTipYonM1J0v5yuAKSQi7uqgauSVml+4iq+T/yyBdNwq
	spqfor7D1RjwfSdn+a6NajxnxeO4FXhMK6x1MKcs+pc4+9mQ4qhK5KdwPHtEJXeN
	JBZH+D/u2jkk0YkkEmuyUQvh2ZvjVdJCcDk7AOEqJw==
X-ME-Sender: <xms:p0n1ZndNgbWx2sWpmsy9f4JGunbvV_sVHQbaOauiQImx1w2HTtBRmg>
    <xme:p0n1ZtMBUVdCR3ulDCNNiJ67EpeLP2a-1sRtnq5TufThA9jtHsFOUM7drmpyITv9X
    o_3dxdVM00eSbT8aQ>
X-ME-Received: <xmr:p0n1ZgixBZW-YAHMxaaecXMOEMXDPBNDtwLOsmo2JYbmdh3_W_kWo_J83Ws4K1Ec5wgTkMYwguhQ4WLI3q8g73zZ9s2RIBC9IJn0Pj8MsvOvOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p0n1Zo_8vPgFMNbexzwAQgWl-18oNgQ9EqFtVU4z2UAP3C-er0-FZw>
    <xmx:p0n1ZjvHd8V-zoplq6CHG1-YsptiT3Z_xshtExOTpwv97N2go4BXIA>
    <xmx:p0n1ZnFySQbVa5IqThdPhYKl_3Z2hlCI-P97WBgFDH9SuaqKI5_08A>
    <xmx:p0n1ZqPR4JqbBs61nb0YZVvRsUJA1-txkf1I_5U2X8UvjKNUgL8JEw>
    <xmx:p0n1ZjJViQxirYMTZ19R8JEVPWubtTc3EC90GLzYfNg8VHFtBLFZQjyx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7ce0ee6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:08 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/23] builtin/difftool: plug several trivial memory leaks
Message-ID: <7bb07ec2f07dbbfac06af039d1f192558150f4f9.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

There are several leaking data structures in git-difftool(1). Plug them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/difftool.c  | 6 ++++++
 t/t7800-difftool.sh | 1 +
 2 files changed, 7 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index dcc68e190c..1a68ab6699 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -660,6 +660,12 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	if (fp)
 		fclose(fp);
 
+	hashmap_clear_and_free(&working_tree_dups, struct working_tree_entry, entry);
+	hashmap_clear_and_free(&wt_modified, struct path_entry, entry);
+	hashmap_clear_and_free(&tmp_modified, struct path_entry, entry);
+	hashmap_clear_and_free(&submodules, struct pair_entry, entry);
+	hashmap_clear_and_free(&symlinks2, struct pair_entry, entry);
+	release_index(&wtindex);
 	free(lbase_dir);
 	free(rbase_dir);
 	strbuf_release(&info);
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index cc917b257e..f67b9345b8 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -11,6 +11,7 @@ Testing basic diff tool invocation
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 difftool_test_setup ()
-- 
2.46.2.852.g229c0bf0e5.dirty

