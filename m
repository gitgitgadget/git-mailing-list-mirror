Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5E29B8FE
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140739; cv=none; b=qvrHXoPfQKSQk2aFUOFFCX//D8xDbeSfj5PlPeE7ytFF5MtRO7I/K5DDwE6JflnYBDSg8HjyZttJkV5DVB/xzJyOpawy9az7UgQmZt5OXebSzvjUGeKySHY1N3BHBAN30e3+BnrddjOOlf3XuuzyE+kH9Bv94IiO/MtqSynRzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140739; c=relaxed/simple;
	bh=cXHokKiWcMrCZPFAABgOD3vSi52UA7eZeKZ2PUoYgCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tE4Abj2KX6pPyXbx7k5SQP+204XM6MaSRYzneXetQe0e3csd01eCZeLjqEnlx1q9HXTiG7V8mblw9SJUVjps9cuD3EGpY/wibLfTZLVIBboMhW2tJRArMhl8CC5URvitvXiBDJl+R3jl2h8rc2RVE1mhdFdFdslpjzoc6j3SCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eBV3dLPd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yx4R1/v/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eBV3dLPd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yx4R1/v/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCC4D14001F4;
	Wed, 17 Sep 2025 16:25:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 16:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140736;
	 x=1758227136; bh=JoqnoswUReJmLfAIuZM0Y7VwmrLi54bthDKbtByu9t0=; b=
	eBV3dLPdINNziEDXcYq1SwVq5+ylRyT88aeoYeJVi4g/3oq2ke7A0UgwGKvXr9w/
	pd4E2bF+anfMfzc0WuzcFj9+iV3rOQV0tzPKa2Zu5gD33scN7Py/g3N6qiQ4157X
	Mz8pJhoKO3AJJSiLAyqIVwwU1V7DOQDmNs7nFztoojnCokYomVZrsnR7YbXow+JT
	hCUNxfx7/GuuX6OJaqbuvho9SNWo76sy+OBig0qIs0agyOk9EQo4gM27Gh/HXSzh
	djcun3l9hyGDXTtWj8c0vrQySKg55+8sqId8NNdXYaWFght2NanW8ZpBNcDxXCPB
	1QbsR9qZvrRumkFYqq+W9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140736; x=
	1758227136; bh=JoqnoswUReJmLfAIuZM0Y7VwmrLi54bthDKbtByu9t0=; b=Y
	x4R1/v//ioBP2I5pkH6EVfSB74vrAvuUm3nN0twqAi24PcoO3T/V6eQGieQ6webx
	8TsuQ6daE47qbADX3d7buGtI5Hf9cPL/c9vh35x4290WrEUkz9XxrqWZqeEgovXL
	mFZ/y2MVS48BpXU2ovuPDNw8ygnbtg/QkVeo8w/PXSY/8JhLt/ihTSgXLFNF156F
	Xtaiae/o9x8Ny8hdwfr1yVzetStJJIlV/LiI98ytmyMTYzBwc2L/QBnM+R/hOew/
	QvUaTGbvRgl7vLahhLEMCMZBL3ZXPrBP6OCaNBFyLUC+PbG6gbPxnTUEXmxI0WNf
	lNBOHBFNsFi35WDyTmxvw==
X-ME-Sender: <xms:QBnLaLZmk8KsPFnZ58Cmh2CgyYQyUeRQqZ2Ci-Pe-9RGYDfVWXU455c>
    <xme:QBnLaC2alRPj3TelFP8cUeTfKAzUkyE7xYuwi0-AEWTLrxzRerb7_9huZKEzbvoSl
    aJDI8n-8tWLsBKCBA>
X-ME-Received: <xmr:QBnLaOaCoMqiKUr064emZBq0qPXVMtxYyBoAYGCuAwaqLp0T0_vWDJm7eWnQp-2gi_ecvM-BQzXSbzxPqJgsN77vJ8AIFyarB2w-csAcHsvzz4QHsZ_dQ5xeKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QBnLaCIvcAKTwOGQ95Iy4FdDIi7FhAGihmgwFuCwsVvHjW8JTgvP7Q>
    <xmx:QBnLaFG8pFKPN-XFeDI3MwGsNd2RzQO_o-8pzImLm-lx5eZh-a0cPw>
    <xmx:QBnLaBtrCRjLxbUujYDXyy9r6G6ogq_ul9U_Owc4Rjm2HGpvuOeXTA>
    <xmx:QBnLaMvg7tf28ogMhXDAkRfrnr0gOmuXXGiarZEPP2tzJrdXrVVh3w>
    <xmx:QBnLaLxe21t8-nMGe4VSsWnqlxlCBDIj12KWk-SwQlihzdKOgnzgdnwP>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:25:35 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 1/9] =?UTF-8?q?Makefile:=20don=E2=80=99t=20add=20whatch?= =?UTF-8?q?anged=20after=20it=20has=20been=20removed?=
Date: Wed, 17 Sep 2025 22:24:11 +0200
Message-ID: <8b34e.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name> <cover.1758139856.short.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

07572f220a8 (whatchanged: remove when built with WITH_BREAKING_CHANGES,
2025-05-12) set up the removal of git-whatchanged(1) when
`WITH_BREAKING_CHANGES` is active.  Part of that work was removing it
from `commands` in `git.c`.  But the Makefile still lists it as a
builtin.  That leaves it in the limbo of being linked but not being
callable; you get the generic error about not being able to call it as
a *builtin*:

    $ git whatchanged
    fatal: cannot handle whatchanged as a builtin

instead of the expected:

    $ git whatchanged
    git: 'whatchanged' is not a git command. See 'git --help'.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v6 (new):
    
    Link/Source: https://lore.kernel.org/git/cover.1757446619.git.code@khaugsbakk.name/T/#mfa023b1c1626df68d25714a5981d8662a66199dc

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index e11340c1ae7..9311da5bb15 100644
--- a/Makefile
+++ b/Makefile
@@ -883,7 +883,9 @@ BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-switch$X
 BUILT_INS += git-version$X
+ifndef WITH_BREAKING_CHANGES
 BUILT_INS += git-whatchanged$X
+endif
 
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS += git$X
-- 
2.51.0.274.gdcb64e51a0f

