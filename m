Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7E218ADE
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595512; cv=none; b=eECEjvQ6i3rIUlOHKdGe3dqfamZetIFs4ny4ZvQHUHEzCfUUbMfE6fK+ZfKEV6dOdKsoKek53TLx4jqA3rFSbDYjJ8iuNRkBqJVpvOzIxsbyMEJCfYbYtD89ZK354p6Gl6yM7LDvWCm3etFTNqDuD5i+X8e+p+ymcMzpehT9yuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595512; c=relaxed/simple;
	bh=hC4I6p7C9Cg5HsKXQ5lE+SiGtd7NZqLoUZ+wSedQ29Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKJjy3oWo/x1l0FfDMGCy+lsx1igM2hjFHJ7F3VcbxNbekS9DTtMwpNK3mfRLOQp7SmmB6f7K0t78qGWOfABXOLVZ0u+BL7gg0o9LGjHi0Aqa031eCOpmviMcogMETg/ruC3EfWcQwz5qbDXdVr6c0Ccyvkju+hctrdJthJKoK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HbATTQbT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ew7SGJgj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HbATTQbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ew7SGJgj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25DA72540064;
	Fri, 25 Apr 2025 11:38:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 25 Apr 2025 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1745595509; x=
	1745681909; bh=Jz0LMlKwQ/TwoNZpB2t+MDlDVSosfJpanGQLhA/coSc=; b=H
	bATTQbT0a0cIrMZA2Vb6BKQ4Ks3V+psnUXEKSQ/Me0B6wPFS6eDD66EZUCH4IOYZ
	wRv/QCSR2YTO7cpj3F+1cDExq8IA3XUnS5BQG0y8mDmD2cWU7vyxfawvFEWPZLmh
	jJNG7qmTrZNkq1cvcLLd3rYQ3eEqlCvKR2V9ojbS+ab/PIEF9CZCF8dja8rIo8Fn
	e9rbjf3WLXSn276pYQXejL6psI2GNdJlnOM+iABellpl9STK7rnV2oiGdH8Uu2ei
	W7DBOk0EaVdtOS3pqJObRWrI4Z2HKoft4glB/n6OtRabnN85ucrC23eyS8RdlXHO
	dIZW28ukwYCzADYgVsSGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1745595509; x=1745681909; bh=J
	z0LMlKwQ/TwoNZpB2t+MDlDVSosfJpanGQLhA/coSc=; b=Ew7SGJgj2KfBwI3Xp
	rqHKICmdoVYMGDCZxX6kZE960eEsDItdnq2HJ0HHT29YIilU/NdAboiLpRFQ0fo1
	MN/21ufpr5WBn1XZT8aCieFnIK+xQb9aCIpTPp9ZG2BikAw9yNhE+aPkyIbQzX5C
	MusMfLZk7wvx3GwQ1z1Yatsl4EISof3z+xL0c7m3ak3G2W78PlV+i2ft9/rSnsT+
	pe+pTZL6K9vP73GrhBCkqNOgLA4bHgo0srxzLzbJPbYArrUF/gGMuKdiA5b5EXHV
	ZuJQqND2Qbhm6nDxcLyqeB7ghw8WM7NJoQ2Gxzhlydri9sW5IMJ5VlVhWngWuXmJ
	14AQA==
X-ME-Sender: <xms:dKwLaAYICwId_RJP5aBBvqutiwX32MWEcCsj8jauBQTALky6KXKczg>
    <xme:dKwLaLbqZam71TTF7FmztZd6b36Xzia4O26X0zThKoXTEYmK7hxM4dR2U0RV5Gc8b
    OWmt1v3accoez0ijw>
X-ME-Received: <xmr:dKwLaK_LbNx7inZELuYNJvGYRVgxMoBPW3dZDCizrWSBEusGvhQisDMRw3pucKiZieW2cfg-x8RflO8oXjUpN_EZtL3HP5mXVjYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdfflefhueetgfektedthfduleffudet
    leefieeulefhvdduieeukefhtddvudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:dKwLaKpfiWXNO442Y9DTS2hvijwb8Ij_VJuaZKma1Kud6jVopC376g>
    <xmx:dKwLaLo7bIDaLaMAmEcbPtFhs6fIG0tp8zqzRR20CJfK2Zzu1A9uew>
    <xmx:dKwLaIQmHciN37HliVbb5eMZdLYzaS3zrzbDR2IKIQZK68NA88tVBw>
    <xmx:dKwLaLqPUdFEZBxejCfh75CZHObfbcPDx3CAyfR5OJSDckzEiyvhFA>
    <xmx:dKwLaL73H_Mrq4M2iTPAJukcZ-_jbRffLAhFGg2vR4yjKkpZob7VB6LQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 11:38:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] ci: update unavailable external software handling
Date: Fri, 25 Apr 2025 08:38:25 -0700
Message-ID: <20250425153827.147585-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-564-g9a5a794ec8
In-Reply-To: <xmqqr01guwuq.fsf@gitster.g>
References: <xmqqr01guwuq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So here is a small update based on Dscho's suggestions to the change
we fast-tracked down to 'maint' in order to work around CI failures
due to eclipse.org's outage.

Junio C Hamano (2):
  ci: update the message for unavailble third-party software
  ci: download JGit from maven, not eclipse.org

 ci/install-dependencies.sh | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

-- 
2.49.0-564-g9a5a794ec8

