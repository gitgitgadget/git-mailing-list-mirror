Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E6B660
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704645; cv=none; b=CmNxWJ61kh8HHy8Ad/YoYdq3g4V24j0ToDfne/ZAr0YVPF25NJBsWUFhQB/NIBzpmpBTnfgCY82gIy4so9YF0ISqXoOY8hOPg5YeOaUsC3PEsWbPX/FNH1dDnCA+LhKlsn+TTZpBHKDdwB1r48bGnVX6xErY6zgAT4jRIJU0dFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704645; c=relaxed/simple;
	bh=JIRvVd+47H6T3oX9Rsp84lcVnxSlXR4F7nx2yrjN3Lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8EXbL9z5JTMCQJGFIvVRX9ysLMRjci0csD/2821lz07efFabw3iFB3lDqMQe/SlZ9qabq8d7tuxlprnvqF6n0M3kh5KiAColinYnjq1vXmdRSQblAVmAcbReq0XhbQbhyWXSqqzgQyUuKevUDYHYZBdFDzlNSa6WMex69jP/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kgPGGb33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CmK8tgIq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kgPGGb33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CmK8tgIq"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id C2B591D00065;
	Wed, 16 Jul 2025 18:24:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 16 Jul 2025 18:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752704641;
	 x=1752791041; bh=yJVsHpBZWe602pJ6PgT0yWhCJJA5TaqlA+bOD1r/p3I=; b=
	kgPGGb33H3uZSH8xm1RofAQeveOWpgEm3JVlx14RpaEF+gwpIyCenYY1LmQE7K/K
	vfKDS8Y7y2Rexb9wOZxnVliIdmRRcd0ECgugxwn62DhuJ7BBdrYKu4vlCFWI0npP
	VPKojEQW2vXDjhL5Fpky9xxA0mjjksilSdjxQcW7h402mnybnZZDf/wvZ4T3QELU
	q+e/ivW5CSTd1oM/6ZPpxjZZY+TP8gy+aj3P+DV+pbugSuuASsZenQsLPBP5jQ5i
	+gRRj1ThXZe/+CB7LwLytPVeauxqBKnWPgwFTVZJp3rDb+Qi9/2+x2S0MlBTBcPD
	LyE7K/YIflcsPsMgWBaSOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752704641; x=
	1752791041; bh=yJVsHpBZWe602pJ6PgT0yWhCJJA5TaqlA+bOD1r/p3I=; b=C
	mK8tgIqVcoQh05WnX2nW+5Q1oPj61oskjH37ZxvCo9iMcyNmLxGaqVp1KD/bpTHF
	pa9MS5W9wVA+UBEuLvb3qcJIxazSQOEEeA0x3hZ0YuvQv021b0fIEIyYHtu3FoVp
	PiYVEVzCPCZUpTk2YDFBx2eKjTcPq+DPR8Sip5QMNkLbWyjicg6hAQAyLE5vgGt2
	64fWiL6UXSEwD/59x1lG1Ri48SbCGkrDtRxoK/R6opHHdQeN8+2SkjXCfEpyYIMe
	KO1ysw8RP5g2CxWYTiDFbu2bDm5RabdeA0HMMapyedF9cvRrMwG5f9Q9oHex2N05
	ctVJt28h22qr6zt9hkMEQ==
X-ME-Sender: <xms:gSZ4aO66u5TFw_ZE3Az5NmzXzfUKt9PxisDlwKY7QQG2nTnQ2PFO_Q>
    <xme:gSZ4aCd5MiMvJEJ3F6vd_LLE_NGiqQe-PxHFkBxVRJ4MVn4YzThtraO3gqOsfXCqe
    dfYAgx7NNogKBHggg>
X-ME-Received: <xmr:gSZ4aKCtarCNqFfxhrKy-ixd1daPPoKGFohnsMnlw_193ZJRmiJq2qKxO0gMtiGZ8zx9vFMnqV_GKpI2uqVkuzoOWjXvqoii3oiPV-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gSZ4aN_iKnI4E8uqZH-gOcZbE69EeyEf13GgEZuMTydckEDU8LGYfw>
    <xmx:gSZ4aNJAQfqy97ixj_A3vBhT6f1LARDEVpCOo9MfvHf4SnLKXlx3eA>
    <xmx:gSZ4aOhYiJMoX-VJRoGx9VI8t1Ku0BxW_gNyFVtvkQMLNdFr23ArzA>
    <xmx:gSZ4aF4x-5EwPV1-i_uIgmBHAB58lGtaOwN6ZgknSW84Ed0YK80Kkw>
    <xmx:gSZ4aOqBj78uWNLO2G0AL0tnLZNzbY2DhnncXJ5CQ47HAXPqlqn4aXJg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 18:24:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to prio_queue
In-Reply-To: <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 15 Jul 2025 16:51:07 +0200")
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
	<bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
Date: Wed, 16 Jul 2025 15:23:59 -0700
Message-ID: <xmqqtt3b93ls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>  t/perf/p1501-rev-parse-oneline.sh | 55 +++++++++++++++++++++++++++++++
>  create mode 100755 t/perf/p1501-rev-parse-oneline.sh

This unfortunately calls for something like.

Tonight's integration cycle I have this on top of your series
in 'seen'.

Subject: [PATCH] fixup! commit: convert pop_most_recent_commit() to prio_queue

 t/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/meson.build b/t/meson.build
index d052fc3e23..b39f6d008d 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1117,6 +1117,7 @@ benchmarks = [
   'perf/p1450-fsck.sh',
   'perf/p1451-fsck-skip-list.sh',
   'perf/p1500-graph-walks.sh',
+  'perf/p1501-rev-parse-oneline.sh',
   'perf/p2000-sparse-operations.sh',
   'perf/p3400-rebase.sh',
   'perf/p3404-rebase-interactive.sh',
-- 
2.50.1-447-g1e759a1f67

