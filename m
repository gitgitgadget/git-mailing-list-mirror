Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F251F151C
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135297; cv=none; b=gpoOgLc8xK7e6nJdR8zYCJIF7gD/pqnB+/zy2skRX4qKi5YIwCMen5YTJhsaSGQy7ZnMYIIjfHAFZFG5Nlx/9b60lZ/cIKvwvx21HrxoKF9vIkwCiXYrzIrxKG2LaTzRqdvLLOoVKUSvEX85kX0mE72BxRUr4JeP7+1paCBZ6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135297; c=relaxed/simple;
	bh=Uy5IL4LS+dZ6otogvLHoHbBWZtDZLAUd2hFFJWh5KV0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=djkhj1HPJogXzsBtcSMcg2E2GQXSH/1RAmijBpuhLOwDunvrQkTbR76Rki15UavoNRIoBbMbWSPWG5u22KiWeT4rsbiJP6q6ko3az9h9hKjYTVg5/TX/amuzuc54gHJhOxAZvuBKL+nhWAZStT1zsWdTHA0gdyvsm1zfR9AQ/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IvO7FXbg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AzzhpJEr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IvO7FXbg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzzhpJEr"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BCD841380F73;
	Thu,  1 May 2025 17:34:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 01 May 2025 17:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1746135293; x=1746221693; bh=jC6iOTt+CagJ+X+Rd1HZj
	n0SPuvivQ/LbL7SXw9mu7A=; b=IvO7FXbgCZ6K7azYG0ucwD41DrNPHPFQ8LXxC
	xudlK0O5I6Rgwluzv+i+4zoNi+jrSA2CCElCZZXVTk3ZjeQSIOFm/7woOI3qLKpv
	LM0ju5L2TxHImVwWWKa4py52/X36N+P3OOAE3Cs99YQXyteppj8HIPXisGDHDuJo
	DEVsjcHhks51O12P0B+yhEWKB5ZEkZrYa0shk2Req++qXHItNCcH77Xkrp+sarxQ
	emAm++DEQmJtuUrk3cWBv9DlVcalMM+YHjiYECI71Q+Vb7wGtCyxJynQaCQ0Sgnv
	Mdr8huU2p2fgPfov80OnhP8T5xz1Yyi1+3BsdlWfSQtbfp1uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746135293; x=1746221693; bh=jC6iOTt+CagJ+X+Rd1HZjn0SPuvivQ/LbL7
	SXw9mu7A=; b=AzzhpJErn1jZxyIXYlCiazxwsnpVLGn/VvqGd4eV2g390OtUkTM
	uXnPBLwg5gUbOLJrDq7Es1lfyrOyBXYiWe2EJIYTpHSwJFQGHZLm8V4XZ65R4NzM
	xGRGkeuzlPc2dUHPVOD89OarVsse22xcra8Gcv8K5GJ3WF/QhNCB/EkFmqaRphiy
	omocGR5g8BzaHH6+WXTR913gldP//h3V5N3s23AmnTjVR5TRJyHLFekM+hVzV+On
	p/vBAyX0dM1ORskc8xsSjCyu9JbA+SXX3VCZa7KOair+4nCjS5XrroAcbq84xspe
	F0fYoKntw11Vh6L5tU4SZO2BG+rZybYngZg==
X-ME-Sender: <xms:_egTaJTpIdkACAGK6Og7fmhcE9zR5LWZ-LI6G1LZxHZMLxcscNLAQQ>
    <xme:_egTaCyIsd8KwpfNg4WQgxehE50E7ajtJwCNrExrkR9x9wWsH0ZLSu9OvaF8yXe-O
    SGslatpLBONG2V3tQ>
X-ME-Received: <xmr:_egTaO3a3mZ7ZhmBH1Id_pB4QoBnbF_TpeO8oTmVU7n7aR6g9AZmTN6udzFzPzsBy-vN7z-QRpHqBk8f3V_VIewvj-0D_HMGEr_u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeelve
    duffeltdejgfdvueevgefgveeludehtddujeetgeffieeljeeuieethffhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_egTaBCR86JgK6Xou8cTPYAb_3J7A-EJCxXxlWEo81A3JzM-ir-GqA>
    <xmx:_egTaCjoDA2nfPX_7trs40hKP3wOl3pIC5LUdJVkaU_1PzG3A2WQ3Q>
    <xmx:_egTaFpl2Vwe67U_QbbNMUcUH71bCE81BcB4U3JYZCEUjG5M0pRh9g>
    <xmx:_egTaNiUNMcX-tD-apfFvP99tJLerfMn_Kpvd9pJfDEFOT4mn-lzXQ>
    <xmx:_egTaNRdT6KSw3HAVzLXBiwfvpv5fu8Nf26bBB0taqGnc27B3G3a1zFt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:34:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] Nominating "whatchanged" for removal
Date: Thu,  1 May 2025 14:34:50 -0700
Message-ID: <20250501213452.370729-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This does not go far enough to touch the "Git 3.0 removal" list in
Documentation/BreakingChanges.adoc, but is a preparatory step
necessary if we ever wanted to do so in the future.

The first step is to split out the long "we marked this for removal.
tell us at git@vger.kernel.org if you still use it, and in the
meantime we refuse to proceed without --i-still-use-this" message
out of "git pack-redundant" implementation and makes it reusable.

The second step is to use that helper to mark "git whatchanged" for
removal.

Junio C Hamano (2):
  you-still-use-that??: help deprecating commands for removal
  whatchanged: require --i-still-use-this

 Documentation/git-whatchanged.adoc | 10 ++++++++--
 builtin/log.c                      | 13 +++++++++++++
 builtin/pack-redundant.c           | 10 ++--------
 git-compat-util.h                  |  2 ++
 t/t4013-diff-various.sh            | 17 +++++++++++++++--
 t/t5323-pack-redundant.sh          |  5 +++++
 usage.c                            | 12 ++++++++++++
 7 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.49.0-599-g90c2cffacf

