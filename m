Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30233123D
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256298; cv=none; b=io6IE11CHn1t1CCjr6PYaUc+6p6ID6oB3XIm2FeK28fEfhB1T0Rybt8hBQ3wcrLX2gT2d+VhS2KWwM8wvuPIlEWFZoN6TtcxKpquuBT9XeL5dkN9AMVHTEhuPLy35LngZNebxSsN8XkOGzFQrKmcnu38ZqwJNDLvkI1ImUG5/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256298; c=relaxed/simple;
	bh=bxDZGLVdAZa2rIuRecrVQhmzr53LSq6DnTUOn/ClXD4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a+OqD5MYUrAkti75kRSpbr7Acz+tMo4nezhoG+fBEi/CAmY/PtsCLKDwSBi9pwqV7szLLY6h77vb8iuQFrija/cenwjziRNS3f87bbbEjsRN6+eih8SUHsi39GUKtmKOwarDTg2rII4PMxyRjO+RIuxPyI9V3s1xO6ziG4kTqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mNY2tMmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=awzfFIQp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mNY2tMmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awzfFIQp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 984641400041;
	Mon, 16 Feb 2026 10:38:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Feb 2026 10:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1771256295; x=1771342695; bh=CQjeJva1mX
	c3GB/AVqmciLB+n5NahGfL8UAW7gdHN/8=; b=mNY2tMmzZ/54+Xf1w9yFb4EfKl
	kFWsmWAeAFiKkAv0JUZ6jUnYcIWQypb+O7i2cXFKUMlRAjSZ++xQ2DVf32kpVTbE
	ytg6TQoK3C5zUvcRvx5yA6lNTEyxHZ0CEtO0iomPvSgXDV9tLNIuPTsuuwI6c1/T
	aofUPs33O+Qn3HvHk0iSz416/5XOF1jttgjWh352tyrRc1sUdd5v38lq3J6feImx
	7cbSPjidwQKvzNQ7N8f9aLzlamYR4pPo9dTo6/GCQIf+yeiRvT7XyNd87+v3r7ix
	X3w5akKMfYU7Jlgtn4dkNFQClbrcN3+keFAZvpFsEMHUGfg+Wth+ZrQFNf4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771256295; x=1771342695; bh=CQjeJva1mXc3GB/AVqmciLB+n5Na
	hGfL8UAW7gdHN/8=; b=awzfFIQp2wqZMTDXovQAgDa8zCCa4RJjgx/y+fdyH506
	Xkx554Y4DtSLqlLq8QKWifsHkP+5KbSH8r4vUfjQ5WD9XHClU3oMCsHpALrQL/tO
	gUkeJGOS9GLsC6SJ13AApzwa+bByWkMxvORTZVCvEwWyLLEFi/canbA1ODf3NPI/
	vYg8Qs+4KIDoVK/WtqDkKRHTGT7MVwzQDdrgaKCZkQt1D+NvPAFqOFH5a8+YIbAq
	DYS7WOJszZQeMUfPQScgZ/KFsobd76DRN2TzwDA10IJQb/pW9YV+nkIA1J1bq8I/
	KJC/JkDaO38NmYXkn82hMbBxRijbra6vOXmPHx2yyQ==
X-ME-Sender: <xms:5zmTabRRMXT_Xgyzx4jpDW1O7IqL_JBp0AFBIPPvXc97-NUQ39QMAw>
    <xme:5zmTaSwh6wpEva4BS4yKonD8yfw86HkTJ9pOudjf4x_MqLRVXmJKEBuW1ditzENFL
    rfys0ZxGY76Gnd6kHRJ6cq-YVoDNYNoq3PjAuSKySP7TcBnrnBr70k>
X-ME-Received: <xmr:5zmTaeedw9Y-fBIuVV6WTVHPvg3N82Lrez7ewl9YS6-DouPcaJcyg7u08pGBjMxi7ttlSHAYR5A7dLyiPaLpBa8943-vu4TATkpO7zehjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhi
    esghhithhlrggsrdgtohhm
X-ME-Proxy: <xmx:5zmTaWIO9jv_3ATXaCOOR6j7V3AXIe2Yw4QICVp2G0ZBJkcOUjuDjA>
    <xmx:5zmTaXGpzsBTL7X8-XaTHVC9n_Ugps4mBrgsK_ynFsVwqCKWaQn9OQ>
    <xmx:5zmTaYqW_ZPFF7NJmBveYDOnTk_BQ6uslpjV05bTHfWt8lukAldwhg>
    <xmx:5zmTaYTHBScfPqOF4psoSs32ZYTBhXnN7x6YHMGcE6WK-QEk6lmlTA>
    <xmx:5zmTafBHEx53uGgQeRoq3HPzg824UvvR8iInz9_avu5ICidF2A1Qh31T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 10:38:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79daaf8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 15:38:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] git-receive-pack(1): optimize
 `assign_shallow_commits_to_refs()`
Date: Mon, 16 Feb 2026 16:38:00 +0100
Message-Id: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANg5k2kC/x3NQQ6CMBBG4auQWTtJaaBRr2Jc1OFXJiBtOgaNh
 LvbuPw2721kKAqjc7NRwaqmaaloDw3JGJcHWIdq8s4H59vAt47zZFwg0BWco0yc8kuf+gXbGOc
 5vdnFINK7Y9+dBqqpXHDXz39zue77D2YsvKd2AAAA
X-Change-ID: 20260216-b4-pks-receive-pack-optimize-shallow-0a6cc508549d
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>
X-Mailer: b4 0.14.3

Hi,

this patch series optimizes how git-receive-pack(1) handles shallow
pushes in `assign_shallow_commits_to_refs()`. This covers some edge
cases that we have hit in a production repository, where shallow pushes
could take many minutes and allocate a ton of memory.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      commit: avoid parsing non-commits in `lookup_commit_reference_gently()`
      commit: make `repo_parse_commit_no_graph()` more robust
      commit: use commit graph in `lookup_commit_reference_gently()`

 commit.c                        | 32 +++++++++++++++++++++++++++-----
 commit.h                        | 14 ++++++++++++--
 contrib/coccinelle/commit.cocci |  2 +-
 object.c                        | 23 ++++++++++++++++++-----
 object.h                        |  5 +++++
 5 files changed, 63 insertions(+), 13 deletions(-)


---
base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
change-id: 20260216-b4-pks-receive-pack-optimize-shallow-0a6cc508549d

