Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81034EF17
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655700; cv=none; b=SLaJqUKcTnNo3Y8t+4Bu2h3Q9iBGCBtgLawFUDM4AsPnBn4QftPG/lm9DwopyqghstG+x0BlSoWHvAMQFvqpYHoUEQT1K3R0wsA30VJ2IQmhU+8QyAXm2jiI27EGsU06oAmu6GhW7DFDrY3gwe1g7ws53L39bQwy/SAcHSMf9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655700; c=relaxed/simple;
	bh=wgciiojjec9s7CbLwDMPMrejbLhOMmrqwEP/kEuFzQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m31e6mHlfQDVvlXkqK0EVwEbpORANbBKnMjFSLlRwnL1KpYo67xpA1zt0qGJge8unATm+Gk1B2oHo2Lyjq2nl/FcdCLiJoWIpO4C/81azJXbqb4DSWN8f0CwtyvATemZfsXlVHbfPOgrAwRLfWPBnSb/3QN7DwHk+By7r/Wv4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JtdPn4Ur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZO8eP20; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JtdPn4Ur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZO8eP20"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CCBEEC00B4;
	Mon, 16 Mar 2026 06:08:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 06:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773655698;
	 x=1773742098; bh=BT1yhkpjKmLdHy7o0xGMxT9G7TrLFr4ZPak1DFXfTwo=; b=
	JtdPn4Urfnxmb2vM6ifuOQXBcN9k3u9HVMS1FOmXcoIMq0SooKME6+Hv+sfK13c7
	ZambRII2omgD04AeZ2V37bz8S4JZQZHA+v1qOmukkYuIif4hsSAa47oTP9R/HvQ6
	CkFqzZndX9lAi/sigCm9WQ6he8b6ST3MgZyh32juBHLjEGdVhT2xkCZdqyivxm8w
	FYUgS5d2NgjHgaFDldFnhviauzdAfJ+v8xusbeKyb8Y8nKm31GdMtbpr3ApPBARH
	L3cVYAhNIQIvPPT0PFyTeCd9AZm109Fh6sdF1EC0yJEfUKYNaJXbuBxmUHcce1fY
	4fWTTaTP+x2S6Lw6a5pmZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773655698; x=
	1773742098; bh=BT1yhkpjKmLdHy7o0xGMxT9G7TrLFr4ZPak1DFXfTwo=; b=G
	ZO8eP20TYrC9CAtC12tCO5fJ2t04lsetNdPuUnID/KI4xmYzmAzrq1VW3YRP21ex
	UmYinSSQd98kONN2LUsSaOOmpQTSRz0fgQtcJFp+OxSRGXkywZxxd+CvqVBdDQqY
	u3/0eH98EnhEP6D0m7rPzz06SGCjvOQJism4AF7ZT0SFMHzNJZKsZLUP5FnM3/mx
	aP8PIjwmMBlpODp5rq124OO+87DiVnyoyK893/yHYKULpR+UrANTvSTHCRpV6pMm
	ozxf1hCdY8gCfuUscLkL6pH0DznmGBNIYrfhwkJ8+lq9TT7rN2rdvf2z2gtsxJ37
	duZu82UerMlptHEEw91Ng==
X-ME-Sender: <xms:kta3aegnkGy1tewhUkfkRqZ5ng-om4ha4AuwLA_06wwZrnWMqhJCkg>
    <xme:kta3aYejXGSaQ6PcJ7HcdGmeoW-jvYlIQF9q6skmfHeuABkEueJHC1QLVh1fnrolF
    wVxUfn0vrQPbaDS1tRdad40PkDzHQWfBnPmAcFHUbHqdfQaaRVkaxU>
X-ME-Received: <xmr:kta3aVo4Zxf6VWnyJqqtvx-i9d9VOX4fMRd79260VhdbTQHazAvQ52DtOH-VNwZ76D54T7C9-B-cdUeUQb7QIQccF8adTaUpOrtFaBOqrDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:kta3adDtdjq6c2fGtQ1NWpM3JWTXWs-jDVc8VEo0YjsV_RoSkiBo3A>
    <xmx:kta3aSYIOXXgQsyJwZiQSa4foLz6bcusEQmDuCcNJse5npex1vru0A>
    <xmx:kta3aQ4vtUCYV4BaCqf7bln_vMTicyzgAaT78A_umi7Nk3BDsntDZQ>
    <xmx:kta3aTbH9F9IXn6w6FPrLn4juVRp9yJ-wKN5dS96XEiXAllsewY_SQ>
    <xmx:kta3aZyquup34mE_wFNRmOktPGeSgjLB8qta9cOnYJvolWIZoLjzvH2y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:08:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26baefb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 10:08:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Mar 2026 11:07:58 +0100
Subject: [PATCH v2 3/8] contrib: move "coverage-diff.sh" script into
 "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-b4-pks-build-infra-improvements-v2-3-4b2c2c0c0425@pks.im>
References: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
In-Reply-To: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

The "coverage-diff.sh" script can be used to get information about test
coverage fro the Git codebase. It is thus rather specific to our build
and test infrastructure and part of the developer-facing tooling. The
fact that this script is part of "contrib/" is thus rather misleading
and a historic wart.

Promote the tool into the new "tools/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 {contrib => tools}/coverage-diff.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/contrib/coverage-diff.sh b/tools/coverage-diff.sh
similarity index 100%
rename from contrib/coverage-diff.sh
rename to tools/coverage-diff.sh

-- 
2.53.0.959.g497ff81fa9.dirty

