Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B11BC9EC
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110007; cv=none; b=Ed4ig+jtkKKLXN2rxjB0XJeJpVujW74HeUkVNokekE6ZFHp0yjyWwxSyekjdwvNtgIvv1KSPdDndK9eeM0pr4AIUtvjMi3tFGsvzGl4ks5yX5ai/GoyQrVPorf32Ja9Iy3yLMFrrClM+gvg5x+k3HptvHRRyakU39qkDQJoFK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110007; c=relaxed/simple;
	bh=EIeqOEsBmvZ3pD11zi2aOCH6zgUuk4uvWWtVxCF/r8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWWJfEl/tR344OnLWeb3bYlb6pL50Be7skdaqo3Usfs7yCezTS/6qcqOBoKiH300mCvH9EuB2UxbCLV9HbxJ98LjFstmtnc0V9kxreeUmVfxtG2h9SP4ALS7ck0VFQ+r0pPg0/4M6Mmm+CPFTjDWHwZU6KKoyJhZpix1iWnpp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tr442RYZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtqvzKqc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tr442RYZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtqvzKqc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D099911401D2;
	Wed, 20 Nov 2024 08:40:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 Nov 2024 08:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110005;
	 x=1732196405; bh=+eusgBIKljmlrHTWue4YklOLBIOJXhFPCw/DYnrInKw=; b=
	Tr442RYZdTCW/+rTYD6eKFYST1e7ViNKwiTuhZIv/0bwQ/OacWwJESR4tIhG0y/i
	+WWRVYdjn7CVja55GGDhCzi8/8ubec67WI7hgMrjVZLudjmyMPayAOnGIJ5EMdCk
	0B11e90vjMnnBD/blfFx9/3m/+skPQ54cAJhyVQXG7H3hNXEDJUWWHY2wFMVkbos
	4RFz9rdQuS8heO6VW39RRwrzlSfWXd3tU8lDnQv6UclwXXqhnBz9gXS+qd/5aXle
	pV4/9CxDSV9BrwRBX7HZxo+0/BLwDfI7KUCN6XGFFzWkXfCu9PUDqc3iNgd/apd0
	4ldYb/w90l2eo/HSjQsDog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110005; x=
	1732196405; bh=+eusgBIKljmlrHTWue4YklOLBIOJXhFPCw/DYnrInKw=; b=L
	tqvzKqcx4945Kx1lvZHKhGiOM9kZWhcv5r8dtnh4MdPGvBlhrbTJLx3An9fBNDsI
	KUT0eUJRslC9Uab+k2q09jkGPQwiEiiG0NGs70YsVChf3hGfUzpcxZttOM4r06C6
	igFw8Bal8+UU0Pn5ZkkjGOVIIuTvZvzlOorQbCOcM64BU0YQ8RIy7Hg/Zrawd2xX
	VckPucewgyyDXvAD+sJdomjS2zdRzyCjhxxdkaxXE+Y8N2tlTIHMxPD6dOTqnDdq
	rVLKpLhfJkqyc1Yq/XwN/4bqHp7/PminkJ/Sfzdh7pumXUQAbluJ7ONo1pyl1B74
	sqiljFFO/lbo5SlnmM/0g==
X-ME-Sender: <xms:teY9ZzgrFbxLghEXZ2pyJVxBYnQ69QtPoek3kkGVDMcLtJJFQe7FoQ>
    <xme:teY9ZwDTbckwbe28uQAPTgMZEwQnTi46Y8FTMc3a6APQDKn9HjOBbc4WqZpYZVJWF
    7qDPlkhk3m_P_3IiQ>
X-ME-Received: <xmr:teY9ZzEvteoweIVLp_iNxQYexP7Pkv-sQxb-J-53R2NWRs1WwCrc5sSeXenht_gRj_Hfhd58QKrj3hI6VZ94UFP8uoAN8WXKE7qMVC0kv1q2yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    eprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:teY9ZwSKmvuLIKRMIm9fiw6sPRXKft-WvALAYVHtOibqU8p_2S0pzA>
    <xmx:teY9ZwwgwOibF1bLNMC6WngsEkuwdFf6uOWCQ1KcSBYnm0PIeBxFRA>
    <xmx:teY9Z24JjyoSKKzfMr-iPGikvYA3eSTfKE_bRIh2lROy38cHwlYqYA>
    <xmx:teY9Z1xpZSmVgnoWA3ofl6DKpGri0rh2jgIDL7ddWwDZuA2ZI0ptoQ>
    <xmx:teY9Z6tHwAXPqk3hJw_obg3kh5enaF1j2X6JPDWjKGJO6hFb6RnhMhjh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e17ac63b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:46 +0100
Subject: [PATCH v3 17/27] builtin/help: fix leaks in `check_git_cmd()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-17-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The `check_git_cmd()` function is declared to return a string constant.
And while it sometimes does return a constant, it may also return an
allocated string in two cases:

  - When handling aliases. This case is already marked with `UNLEAK()`
    to work around the leak.

  - When handling unknown commands in case "help.autocorrect" is
    enabled. This one is not marked with `UNLEAK()`.

The function only has a single caller, so let's fix its return type to
be non-constant, consistently return an allocated string and free it at
its callsite to plug the leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/help.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 4a5a0790704b402e6f989118a0f90b52eb49dae1..6a72d991a84d9f14ecb8a711a012ed544450ca1c 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -551,12 +551,12 @@ static void show_html_page(const char *page)
 	open_html(page_path.buf);
 }
 
-static const char *check_git_cmd(const char* cmd)
+static char *check_git_cmd(const char *cmd)
 {
 	char *alias;
 
 	if (is_git_command(cmd))
-		return cmd;
+		return xstrdup(cmd);
 
 	alias = alias_lookup(cmd);
 	if (alias) {
@@ -589,14 +589,13 @@ static const char *check_git_cmd(const char* cmd)
 			die(_("bad alias.%s string: %s"), cmd,
 			    split_cmdline_strerror(count));
 		free(argv);
-		UNLEAK(alias);
 		return alias;
 	}
 
 	if (exclude_guides)
 		return help_unknown_cmd(cmd);
 
-	return cmd;
+	return xstrdup(cmd);
 }
 
 static void no_help_format(const char *opt_mode, enum help_format fmt)
@@ -642,6 +641,7 @@ int cmd_help(int argc,
 {
 	int nongit;
 	enum help_format parsed_help_format;
+	char *command = NULL;
 	const char *page;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
@@ -713,9 +713,9 @@ int cmd_help(int argc,
 	if (help_format == HELP_FORMAT_NONE)
 		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
 
-	argv[0] = check_git_cmd(argv[0]);
+	command = check_git_cmd(argv[0]);
 
-	page = cmd_to_page(argv[0]);
+	page = cmd_to_page(command);
 	switch (help_format) {
 	case HELP_FORMAT_NONE:
 	case HELP_FORMAT_MAN:
@@ -729,5 +729,6 @@ int cmd_help(int argc,
 		break;
 	}
 
+	free(command);
 	return 0;
 }

-- 
2.47.0.274.g962d0b743d.dirty

