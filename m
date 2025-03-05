Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6D2505B2
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190016; cv=none; b=G2tX4k4uCWjR+61E/LeHBDyenDGTMt3ne3FtlvzyEu2kNHAVBcpnc6oFTqo5WDXZ3to1HIaziyRSG0ShfePnc/FJWWh1GNPtKG+kSjXVfb/I9veM8Gqk//fbOjYnP/ziF0c2KYO/UInfYTFQFeL27eoQIslvAXN2wTHdjNK/n8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190016; c=relaxed/simple;
	bh=C0TI3btLaJaNYlhGxbsbqfAqqUcPArOKVqZi2wnZZu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3yTRtk/CYZl3MtN//3zuHjU/oiuvHvbcPA2p8t6cFbHWNo6BunZ+rqB6s490lP1tm+rOs1jjqmYQzX5LzG934IlhliTOqfhxdkVQSiQ9u1kCZ/9FsQ8xujIn0/HBoXXHuGJha3MaFY6M7xMMe6Dk5psmmWIgVcR7HGJNLs4YZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yTdGi99r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4zFYOom; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yTdGi99r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4zFYOom"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B654411401A0;
	Wed,  5 Mar 2025 10:53:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 05 Mar 2025 10:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741190012; x=1741276412; bh=IXjUCVufUM
	4f9TKQ9ep3e2P4WCUGB10IXazktY1M7xk=; b=yTdGi99rRCJrAdrgzNCPQNrjI/
	EfxEj2g2WEM8feMPV+pZCsnzqP/vVenrUDqENv+dEBe7iv1TrWn+hgTU6WKFik3q
	8CDuQy89y7dzq5E72So0ny+7ey8P9DMgkSCv668Y9sVg5SBzO3Z9PyxrgFsQLee7
	ZWxlWTRqEqYK5If1XGfCne+0WYro70pAIeT1h7yRCihnZD6+uTIiAbUBDVoE0czq
	F/jFJ+vPq43ZTXKHUOSQTyF+7WdZbjXwKnXa5oWQ7/GRDhjIvlFq+m/C9EFqvud+
	ngPeAd91GKEB+xySbU0T1R6VSajskw7ZJNUkvbx2/o8XjiXE9VlmoHHvjn8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741190012; x=1741276412; bh=IXjUCVufUM4f9TKQ9ep3e2P4WCUGB10IXaz
	ktY1M7xk=; b=g4zFYOom1EFUy/XPCrmyVHjjFZ2gPfx5b5cOuaepjbTBvjGEDaE
	YigH0mjgq03JOLcFnTF9Xgc6HT0a2i/EeiWqNE9ieM0z9mTzGbX2lB0b4pk+4ZF8
	iKZFUHbrYQb6PLsVCEIOYyu5+McajG+XrIVViX+sY0r+QUXOu2OrDGIaigZGFOPP
	kOWevkJpqOee95PWZGQR15WfoBqlFT+6g4h4ILoTfvPc6Tw2Z2MmlLC3lMC5QMyu
	pUxQA8dNjDPBpTvfc+6LQyIUOhY0UC/AIgMFW0oeMtv5jP42dFC03ZFGT8P1Mj+3
	Pgwlb4/FDulvzB+UDn2iESUzm37H1cbm8NQ==
X-ME-Sender: <xms:e3PIZyrA1OLM7O8unKZs1IexKPqjgsOR_Y4vwmNG-KtrRMjcotdrYA>
    <xme:e3PIZwqq6ZPyE3NvrngO07YCiS8YbIGLZpVZGtsW8LgeyJx1bz52iXAPL9MtGmq9E
    CFmO7IoAdwX9jSbBw>
X-ME-Received: <xmr:e3PIZ3O62k3V6IlPsM2ytVDKNH4V5ZhU7kkuhniSPL6_eH918J3lOqDut9GSs2f_rh6jCPg6DMFiSCY-vRdmY-Il1CQe9HwxVDaS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:e3PIZx4hjIriDYNzPaRxz7vn3oKH58MTcfv8LFwi8mm2RUI9t7LleQ>
    <xmx:e3PIZx7SVqt4zJFWMRiWS_oWZVTjNXf9fv1L-Jmg2JgWTXhCXT4CTw>
    <xmx:e3PIZxgHTS0hHEuJhpqkkjpHrf-FJPyr_fsiGTPNkC7mDIfhykfncA>
    <xmx:e3PIZ74m6UowhhOSGauJdPs24iBpGOIoCGi4d1Z6IS_eYQ1X_bxIkA>
    <xmx:fHPIZ_Qn4idwJVYCt-2TseZMYyqaS_lDb9TOjfzrmKJwP8NGCWIjvHB9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 10:53:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
In-Reply-To: <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Wed, 05 Mar 2025 10:42:37 +0000")
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
	<pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
Date: Wed, 05 Mar 2025 07:53:29 -0800
Message-ID: <xmqqzfhzlbie.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We correctly omit builtin/pack-objects.o from BUILTIN_OBJS, but
forgot to add "git pack-redundant" on the EXCLUDED_PROGRAMS list,
which made "make check-docs" target notice that the command has been
removed but still is documented.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The command is still listed in the resulting "git help git"
   output, as cmd-list.perl does not yet know which commands on the
   list are to be ignored under WITH_BREAKING_CHANGES.

 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/Makefile w/Makefile
index a9b2de0692..95ac0820e9 100644
--- c/Makefile
+++ w/Makefile
@@ -1283,7 +1283,9 @@ BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
 BUILTIN_OBJS += builtin/pack-objects.o
-ifndef WITH_BREAKING_CHANGES
+ifdef WITH_BREAKING_CHANGES
+EXCLUDED_PROGRAMS += git-pack-redundant
+else
 BUILTIN_OBJS += builtin/pack-redundant.o
 endif
 BUILTIN_OBJS += builtin/pack-refs.o
