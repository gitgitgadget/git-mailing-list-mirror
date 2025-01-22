Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7420FAAB
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545501; cv=none; b=jdfMGRv6ghhE8VR/Yi2dCUu1K9gd1wYLxR033F1n6JI4iSG93mngbpywkCIcGJbpoVuyOOr1X7/6kO3CcAXSsk61a8RNsxXMa8kQ0TyUFRaltoymZRX45xPqfFDxyt5Y6aKTVVrLWmXOUD2rNJdhh6v38T/ZSK9BG0+hWTxw2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545501; c=relaxed/simple;
	bh=rzTeWvGl4h9Qku+ZNea5uGN9IVHtX82P5Jlfd1wxjkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PcAU+N/8q0O3we2KxeLSAcx1zTZswB1aJbUCRhD1gk05bd6SmFkbZMFKOGteKbHN2xcL3lFUBIzsFofl41sCnqXjVdpm8jFIH/L4pS3nIftg0RBGCBdddyE3CgGM/EGQFmSz7C752QAkxbbfS2ZHMP4V6f5/iMyWkHuPGDmpscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TBTG5WfF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jS+o8EzW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TBTG5WfF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jS+o8EzW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A7D52540137;
	Wed, 22 Jan 2025 06:31:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jan 2025 06:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737545498;
	 x=1737631898; bh=GOJQmiAOwCOERunYnHREnCebAHa/voaXtA7jmRVbAfo=; b=
	TBTG5WfFNUAtWiVnwk20qHhzQJgwCN2i1hugT7hsZlaWOzhO8zmEKDGKINF6PDqp
	8CHIFC43JTu3/aKDY8BsPHHZ0V6RHE+AkiEV9qac+cUtpLBTzWBvF8o1ZLL9HuBg
	0N8BTTCMPLnrTbo8h7d9VFhhVDHVvJZ2JYefm/M7kq4Gge8PzsZkFUf94c4fAqWl
	UX+r1DwjaUWTs1qTyV7bwscOUXlJpAkC6vjdzgeKIbqhf7+IeDr3HGr/arltzxaB
	DD+vV0iEMUV2dYyjeEPev1oee8xKfHra0nQ38YDlYbuOniOtCjlJH0sraYX2ZSGT
	LAvrIUZ/a/xZ8jfZGJH8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737545498; x=
	1737631898; bh=GOJQmiAOwCOERunYnHREnCebAHa/voaXtA7jmRVbAfo=; b=j
	S+o8EzWMO5S9DZbwz8fDPRMjEhRosPKJ0g522BAMK0pA8uMhVpiqReUpvePnlk0q
	LlfGYZLiqGVZWQSJ+LyCBGK/3B8CFzeQ5V7xuW1Ayb/ZjjUV/mXbk/WBjr3UqaeE
	HCc+Co2useYiaADJcwmYwMmmrJrVkXvcHt65UkMapA5NoKrbtrK1JSMWGuvV52Ea
	KG+NQLLUc1Os8332T7+qJ5irDEcMnA6t3qcwRn0ZG9Jqv0f+EdZYaasN+CYwnoyp
	TZQdwQ413Q/kvXlAZ5CWpEsre309hpq4IiytbLkM0FVe/SZhAvRcvZd9gcvZ3LNP
	B7pO+F9BxjD8vzviRsghQ==
X-ME-Sender: <xms:GteQZ-BV-t5TPD55s3al_M5A7yaNJkbBn3q_DXsOzXwMYzQcAv4EhA>
    <xme:GteQZ4jsM4zBrrAp2ys-Ei8tfEAfcuSBb0ZwzCnD5S-DonRW1Ubv7lYXVK38SnPua
    Mi9a9dw5P5Ud7b3Cg>
X-ME-Received: <xmr:GteQZxk-Xk2m7_6kvlb-WR92uaEadzifd7PyuYI7koQ_ZcM765HqMbVM-Udk82Jf-a_of5md-YWP_CAwzJLglR3eWlQ0VCOArwQOSlQLZpHQbhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsg
    hrihgughgvrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheprhhosggvrhhtrdgtohhupheskhhoohhrughinhgrthgvshdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegt
    hhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GteQZ8xS2s4NyABX3VRk_SPzF7viiaxg0RwR82VKdwnLBktgMvqR2w>
    <xmx:GteQZzRNrLEDwAI3yQCFlmdKZuWVJuxjOxfWwzC74Spf9nYdTw2K-Q>
    <xmx:GteQZ3YzkDihogA_E9l882mENx4WDPWh5fcyAfmmJp8sksaZBuwEww>
    <xmx:GteQZ8R-B9uqdr2fur8BGDy9vfnyyecCaczcoV8m2j6IOVPAOfrCNw>
    <xmx:GteQZyHzKCcjeME0URl8MLmNGKN_63If1X3TKhsWoWbdBkOllnvIVAZs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 06:31:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 064c7e9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 11:31:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 12:31:32 +0100
Subject: [PATCH v4 4/5] builtin/pack-redundant: remove subcommand with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-pks-remote-branches-deprecation-v4-4-5cbf5b28afd5@pks.im>
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
In-Reply-To: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Robert Coup <robert.coup@koordinates.com>, 
 Christian Couder <chriscool@tuxfamily.org>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

The git-pack-redundant(1) subcommand has been announced for removal with
53a92c9552 (Documentation/BreakingChanges: announce removal of
git-pack-redundant(1), 2024-09-02). Stop compiling the subcommand in
case the `WITH_BREAKING_CHANGES` build flag is set.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                  | 2 ++
 git.c                     | 2 ++
 t/t5323-pack-redundant.sh | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index dc3c980aa7..e6b0d85980 100644
--- a/Makefile
+++ b/Makefile
@@ -1278,7 +1278,9 @@ BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
 BUILTIN_OBJS += builtin/pack-objects.o
+ifndef WITH_BREAKING_CHANGES
 BUILTIN_OBJS += builtin/pack-redundant.o
+endif
 BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
 BUILTIN_OBJS += builtin/prune-packed.o
diff --git a/git.c b/git.c
index 46b3c740c5..a13c32bcdc 100644
--- a/git.c
+++ b/git.c
@@ -589,7 +589,9 @@ static struct cmd_struct commands[] = {
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+#ifndef WITH_BREAKING_CHANGES
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
+#endif
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 8dbbcc5e51..688cd9706c 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -36,6 +36,12 @@ relationship between packs and objects is as follows:
 
 . ./test-lib.sh
 
+if ! test_have_prereq WITHOUT_BREAKING_CHANGES
+then
+	skip_all='skipping git-pack-redundant tests; built with breaking changes'
+	test_done
+fi
+
 main_repo=main.git
 shared_repo=shared.git
 

-- 
2.48.1.321.gbf1f004a4a.dirty

