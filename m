Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CC212B2F
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547558; cv=none; b=cV21eQhiCyX1i63LHbPgY6D0Qhu1lsmsCjjcJxiBzXjTBqSe67F6O856G757mevJBwvATuzqjTN0rrk4HkxG0mhhtvwItqbjYduMOExWP0/bRWgnvc1RpvORrhMaFYrPCGiS6RUiOFIaPkylB2TpO3BlIXMd7IIL1Klh92inYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547558; c=relaxed/simple;
	bh=4zm9yoeayWZEoBI3tVdgj4FKGfDiNrpd6JmfGtg1msc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRrCQkOK7ZP7L+iWsdx3Bin3MOREOjK4irF5n6PQr33lwtiEM5XWr9oFfufXaVwRLo6VWLcNcWx5ahcyntjqEt5p0Nq4AC/A7iKAHF06sPjRiQBv3oh+NBiUEDo/fFRuO9rTbXvm0IL0tsSWvxbXgTj324kdigki1UVMdRAvc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nK9y6ez/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O06BodqD; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nK9y6ez/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O06BodqD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4992911401B6;
	Wed, 22 Jan 2025 07:05:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 22 Jan 2025 07:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547556;
	 x=1737633956; bh=YXPIS7c3UyGVrQhe6aSse6uQPxFSSLfE8nTySMqYjZw=; b=
	nK9y6ez/GKpXxmCkquyMs1kgL7VGJbmoWG4EhxmqkUXerSMkw/c9uyNK/ErGq7yH
	fl4/xIAiMw7chMJo/kGJ8A9NJAZwFDeXmtIAr65M9E7za1mw4W0NGAa1uzjE8MvH
	TyQ88Pzvx5oktEA9opixIVVfKvAZue9m+MZZVrJoxE7qzp4dO6D/ufjcaDnFITpn
	I5x3YEGO19uTdTeml7QmfSK3Grd8ORwhd+rvJZHIneBMkB+W2civ+J3wsaoq2WNB
	GskiuLQMPMLyuwJN+GJGMCbyuK60uT5tZ8TAQ+Uh9sxT/++g87ajQTnnGNb6CihL
	Rva2DLw56bJAwM0rEmS8fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547556; x=
	1737633956; bh=YXPIS7c3UyGVrQhe6aSse6uQPxFSSLfE8nTySMqYjZw=; b=O
	06BodqDL1pZrzxlm/2oD+iVmNb8jGsJytBYf7IzvDUc1e6aE4NC4mUaUphcuCvD6
	xGiqWehzlGFN9sBz02uqV5rgACk+233Hnz9sCMyDoLHPTpmKraCF0J8snMYfsair
	fPI2tlb7Kol6fk4dVfLLefs5n18noQkoYDquyxfffZ3u2Yadid3Hgpee0vRl2Efw
	0RbuncA05pViZ2VY5rS1zqmNlXhfdhJbENSypVrg7geTMX7Xlf8XBdQ6pTm784YX
	Xbi8KLpYR/YS5aejum1Q4oo2mM2IgO2pnoVEvVvZjI+4c5MrLh8UBxY/ouDPPIXZ
	ukjcb2a1K2SFCmvI1Lhyw==
X-ME-Sender: <xms:JN-QZ0PE2P8IJREOxlaUtWnhS35IMMM0iOqOlyMIJaiuXkCmORygnw>
    <xme:JN-QZ6_eWf90tzVrAmf_1uDuRaVpDy3S_EYVlYRfCr551ecBsrYgkmMZCQc6ynshx
    og-HVkCKOZWS_WKZA>
X-ME-Received: <xmr:JN-QZ7RiCXoBFousdo1SmCe2aGdA6yZmPXSEDTZcXlQt1yYz8cNIlKJUwzph2oaoz1MYeUXxv9pkilMdmXDuHYVSleZUGXRTIq_6Rvsv0agA-PM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhruges
    ghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:JN-QZ8sqgL8casqBpfRob44m0XoMKVvJW5zrqA6hhz6tO3-J1FGfJA>
    <xmx:JN-QZ8debGntwRHrM-HS5HrtSqypTyiRN3NrJoTqlMt_mwP4Qqsm9A>
    <xmx:JN-QZw3BpbLq0SNonkLdcuhq4WEOpN5sf9nzgqmAHGKOvOctHdFqtA>
    <xmx:JN-QZw9ynqzDRSEEl58YYt2YTmL-gv5eOgQzYxxHoKTODCYKjxAKwQ>
    <xmx:JN-QZ0TAW2E6QjO8txIov-WPIEZ7-FFd4iQelPxFZolpNOa5zv3Q2M3R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 757f48de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:47 +0100
Subject: [PATCH v3 04/11] meson: fix dependencies for generated headers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-4-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We generate a couple of headers from our documentation. These headers
are added to the libgit sources, but two of them aren't used by the
library, but instead by our builtins. This can cause parallel builds to
fail because the builtin object may be compiled before the header was
generated.

Fix the issue by adding both "config-list.h" and "hook-list.h" to the
list of builtin sources. While "command-list.h" is generated similarly,
it is used by "help.c" and thus part of the libgit sources indeed.

Reported-by: Evan Martin <evan.martin@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 213998986e..4053024dad 100644
--- a/meson.build
+++ b/meson.build
@@ -487,6 +487,13 @@ libgit_sources = [
   'xdiff/xutils.c',
 ]
 
+libgit_sources += custom_target(
+  input: 'command-list.txt',
+  output: 'command-list.h',
+  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
+  env: script_environment,
+)
+
 builtin_sources = [
   'builtin/add.c',
   'builtin/am.c',
@@ -614,14 +621,7 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
-libgit_sources += custom_target(
-  input: 'command-list.txt',
-  output: 'command-list.h',
-  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
-  env: script_environment,
-)
-
-libgit_sources += custom_target(
+builtin_sources += custom_target(
   output: 'config-list.h',
   command: [
     shell,
@@ -632,7 +632,7 @@ libgit_sources += custom_target(
   env: script_environment,
 )
 
-libgit_sources += custom_target(
+builtin_sources += custom_target(
   input: 'Documentation/githooks.txt',
   output: 'hook-list.h',
   command: [

-- 
2.48.1.321.gbf1f004a4a.dirty

