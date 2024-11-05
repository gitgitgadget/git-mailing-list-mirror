Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076B1DA62E
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787458; cv=none; b=AFmizGWZgFOoOyLmvJRQz/542dfYJi/DOcl7+RB78DpxsWeZhbXFY8l8Ith+1iHnh37GLGW11dgSol5r2mVNEsbTDPhChoCSLTZIjk3+MCTaQOkuJm4xXeqfZ0Jv0MetC0C0sN94efwiKKkhjTRyOiJjNdYbNWY0y90nPWVONnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787458; c=relaxed/simple;
	bh=MijheuAVZ5v+gMRF3XZQ3ZBAn/gQcpWejfjTeGCcYgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpNibri80AgFDUmNv5yrvSEqU7aDp/fpOWHZ/EaazkgsFVst1cpa0w6S9c0pfBMunOs1wxfZfaYOHZc+r8kd9xXb8iwD98Y4ixIGwjofpp6dqFP/KsB+Kr+OQ/NebBQCWqF3eP9yCS8qvSHrZBSP4UgQoTWTrEJqnK5LGXke6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pbgva2NR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EizvqUHD; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pbgva2NR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EizvqUHD"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C989625401A8;
	Tue,  5 Nov 2024 01:17:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 01:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787454; x=1730873854; bh=fRi5cI/FTz
	nLvpXmwUZpENUbnQFkYQuvD5MHZYxqPhE=; b=pbgva2NRpkKnwLTRgIk/y5Wf8r
	a0Q25Q1um6+NCI7K/DrB7bwlBE34L36t8WIdPy1ZVrJeGqO6PfbSgyn2YmWqEz7k
	xwAu8j6dcrRbfuTymscAohYCOcraDH4plafzsivuoUFkfliC2k6waEQfvKgZpcZp
	ddgVfEc0x/AQpFyxjxU712jDCYqOfg4yucmqbF3MGM7A1Vx6+XqIGqi7voBK8u0g
	cNB/m61o8bFmduRR/ErfhrJe/c4UgTeJ0Za290JNKtmYrmC/nWl3QmeGVJmCL8kd
	mS9SmEn7WEax6vw0WZYZwnqGN5/n5BmLDoHGwIia0CMd2yNNqW2Pm7fK5BCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787454; x=1730873854; bh=fRi5cI/FTznLvpXmwUZpENUbnQFkYQuvD5M
	HZYxqPhE=; b=EizvqUHDy2e8m8vcxE3j3dJIqzpJQQf4HX/oZnBpJQHIIHxS5zw
	cCm2DCNXq0uQnZ1/nCtpM5bTrCvTHXEClJPzrXKPQQUdhgTEon0iD8WzKR36qgu4
	y7Yqbslu/DSIvjTKA68rqylDuRupdT9qBfjEubgNPmuhjy/0daV0FeA+idfspFZo
	hLFaXcelqJNEhmjxxX2TSauCcAw4PbT7P51fPaCix708p+BCYoGcnzOsGopnA1Bd
	Aj8kPGrT/rxKknK5wxhurIWSax9x7nv5XR5B+NbiozjLwxE1M8gpHCib+ZQBe2Go
	QHtM4YXBwAHaIPGYMquZZrnbr7CAIbTa2Xw==
X-ME-Sender: <xms:frgpZyg72XLoYtuixpqc5o6DUwnBIa9gAgMsz8ksJw8PFOxGVOVCTQ>
    <xme:frgpZzA8epKT1Lux8mB2m5qSit7kII20scpYJ_UyvBzfO_xc7vSlNmS7bxyRmNSHr
    ABHvpxjS3rF7gNXuA>
X-ME-Received: <xmr:frgpZ6EYv0PWx4p5SDfw5oL35Djgu_nYU1G0kATbtBtj6ZsagIrA1SfybGU5XpTzLxyvocobSE5ilBALyoQWvnpekgBhxj1h3b8arYOhkZJbRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:frgpZ7SOzR_D649-zr8hGgfJzvedJaDkpNrMxkL_-yEeFydSOF3JuQ>
    <xmx:frgpZ_w-7xp4jEqP-yMsNOrf_nmOfdusDNfAOJQkrmH6x_4f_NMNDQ>
    <xmx:frgpZ57VqoOmmHqRnMs86wK1Mgtg003z4bGnYPcko1IFyM0UddShMg>
    <xmx:frgpZ8x57u_iihN5DxYX4FwLg2K_f6kPKPoU4n-v46tZCIAllbpx9w>
    <xmx:frgpZ6oBQqtoHujxGTgFvQh0Z02p7mAAPfkdUBjk60nGw12znsgMFzux>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8771e964 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:11 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 14/22] builtin/tag: fix leaking key ID on failure to sign
Message-ID: <ffa5d9eae7ec13cfca12199274e79c1e2de57a90.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

We do not free the key ID when signing a tag fails. Do so by using
the common exit path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/tag.c  | 2 +-
 t/t7004-tag.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 93d10d59157..c37c0a68fda 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -164,7 +164,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 	int ret = -1;
 
 	if (sign_buffer(buffer, &sig, keyid))
-		return -1;
+		goto out;
 
 	if (compat) {
 		const struct git_hash_algo *algo = the_repository->hash_algo;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b1316e62f46..42b3327e69b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -10,6 +10,7 @@ Tests for operations with tags.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
-- 
2.47.0.229.g8f8d6eee53.dirty

