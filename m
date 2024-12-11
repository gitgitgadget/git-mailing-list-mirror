Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1F208985
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914621; cv=none; b=EXfvCvm293pEnPh63AJrRcrwoBhZOhDXJ/ukGL8Bj/TgquXkGXRLPtnvDj+Lkl9lgvM0HqCI2clXcqJ917JUqriw3ygsSRVVQVOOBqUG8kTswi7Jnrs5C/P2m5og2K4XMGjrOYmaKVMW6fNoyAYAQuhWwhk/RaRsf4AXutOOT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914621; c=relaxed/simple;
	bh=RcDH65Lya9nvlFF9iLnwqaZDpRlj5exsS7JOnJMezjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDtjyMoeuS2PlSHpLhx/nVd672gnImjYEmI9YXejyZzZE6/+8NGhQwb0aD6q4qCZK1Tdv26dRdXt7RPVbb+MB1O5pbiN26G+Rovu3aiZGCC3BE3BmkZijqyVRvmHyzULpyK4k42NUt23x+l2+QKWRe+LtMY78MK8Urda5Qu/Eqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aip+Xy5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WnvMRN+O; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aip+Xy5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WnvMRN+O"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75E5D254026C
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Dec 2024 05:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914618;
	 x=1734001018; bh=IOTGSKjmXC4U8YroVozbqimtSclhvjkUP0Kuoapx4Cc=; b=
	aip+Xy5S6syvF1SzgxvWmyvZB4nV8e0FB3FHWNceV3gFXmjOBMLMth/7l4WhN040
	nEIZb4TPXHzfXbazaXu0vj+25kqyJQxldZzRbF/k+tznN+GGs4jothbc/WUm6fGQ
	Ne40y1mvdklqPSsE2x6/mVvGA1z+NQTJ6ul8QyC/j1/y7p/bKI4MfDoBQWtPmGIl
	BQsr4NlXPdkQLbkmsk1pkStrmhaD//WNIILmWwSOeq5gJ6gFkIzUqk3QYeHnNfNr
	nhrEc3aIfWEbtJAAy/waxsdb1OvjdZURzUn1e3wrPRVUA2oBEzwqC4zC5JGzV1g6
	0m5Jcw1t8/CJpOqHtD1UZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914618; x=
	1734001018; bh=IOTGSKjmXC4U8YroVozbqimtSclhvjkUP0Kuoapx4Cc=; b=W
	nvMRN+OeVLxuIEpMgscYIuEW6hplhw16JcEH5zZv80PkPXNM2Dl7GkZZr8ZpMmDG
	4W7wvNALAhKKbcECcsv2IvM6/J6MEmll9BaHgz6bUZkQMJLcKYpAYWi8bdiLsvHj
	mvojY4RR8C1qtuv2O36CT9CdpsYK9JVksqodN6HXQHr6O79NOrt7nO6Cbzd+1Pty
	KW/wulskP3mmDyyv93E6RI6/3wTGSoMxMstmHlhLMxP2NjRBT3gPNSe5m0UUf7H4
	QGQHcslwPJgFgShu/OpNY8+uPgBuXHZCE4u4POrPmg6Cnil79uEiJ9PrFyvGbAUU
	TPqysCr3ASy0KEBVkYzUg==
X-ME-Sender: <xms:-m9ZZ31QPNwHlbEu6vSs9H-5VHgrx4l3K5g61zFEzFCEyEWIjh0Qjw>
    <xme:-m9ZZ2GvMNc0YFe4eX_PKAGcJLO1tS5_QTFmNquOydsdX4V5C-N7A2Veoq3vbKFPZ
    gbKWp_XdqdF95DoDA>
X-ME-Received: <xmr:-m9ZZ34qGCCx_22Ivas4fsgBrHFTC-y9OBA9ykRbSm1J7tLoZFtywJBxbrZeJJLXKjvo8NFS-jRwNCDCyBfDZpVodY9C-qY51VFTtwcmuFw2rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-m9ZZ823ghUvHGDhYosHrthSF2bwjNfJmMi2CpGab-wbBEw8pgbs_w>
    <xmx:-m9ZZ6E0Cg1Y1vaDiYDzyA24c3tUDwSBN176qdbstNeq3WoWXyiQTw>
    <xmx:-m9ZZ9-q81sqkjHZDoZx2nXKBFHa9mdD8CLWugz007fxmFUkbVIKAg>
    <xmx:-m9ZZ3msdWyI4ePHx8mguEcnGiHNCtRMf-rVuY4JO3lIDRq1k4EkfQ>
    <xmx:-m9ZZ8MP-vRuNo-_OWtiVZDo51m4mfJMyE3ntrLMqnVHRy6IZ_uHhYyK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18ab70f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:55:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:56:40 +0100
Subject: [PATCH 4/5] builtin/pack-redundant: remove subcommand with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-remote-branches-deprecation-v1-4-1431e2369135@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
In-Reply-To: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
To: git@vger.kernel.org
Cc: 
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
index dc3c980aa7a4f42d27ed72415a636ac82b2a5684..e6b0d859803ac4d53079ec2a39143441a5662203 100644
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
index 46b3c740c5d665388917c6eee3052cc3ef8368f2..a13c32bcdc694460fcafe8079d3aa6e8caea1b4c 100644
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
index 8dbbcc5e51c06d7c5f56fcb3107860fcb66a5106..688cd9706c876a7edcaf0bcd642ae08ece188d4d 100755
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
2.47.1.447.ga7e8429e30.dirty

