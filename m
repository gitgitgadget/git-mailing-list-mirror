Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189261F5E6
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931187; cv=none; b=OptRa2OAC8oL9N4bvcGCbF5pQ2CcRDqwoWnExgNRpUNiM/7oHuX6TwCKtauLjVMWUgIcrGsqzruZ2Wn5b/6yBLPBYq5V1HV9qlwwZPe+34+sBCCMQHKseISU6c2rTtcBIxbj3tzVs5/xcTgxsybem16gHt0+Vj2x2fj/8aICBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931187; c=relaxed/simple;
	bh=I0t+sgkKDhnl2SsSw8I0UakS9kFHgIA/QU00OPQ7kKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzUKhx/Gbyklfc+xNExSJuWSHDRZbR/ZLuz7RcFTXqnDWyEbAe5eMPdbl9Gz5+vwuGsLwrIIbaFpfZjRGbNtG3nnwAA6faFxbJzFhsZ88DMix2bRHTXhonoP9OT46Lj1m7vCFrNLS6IQ+3LMwfcKVtoON568bfTO40/x1bscK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=e7SrrncE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZO7yYBl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="e7SrrncE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZO7yYBl"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 10915114016A;
	Tue, 23 Apr 2024 23:59:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 23 Apr 2024 23:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1713931184; x=1714017584; bh=6r9s0S4HySBXMGYc3GINp
	hH3AQtPDIZO3GXY8kvdXu0=; b=e7SrrncECwOFgoNeG6TvnAj4GH/YdkOmNDKsu
	FCia4xkJjJnBn3BBbBIU/QVZpgoI4TRtutQ9iUUfzrknOOV6SDSeq2DSZU+jC1MA
	9d1gBB7NFwdK4yOAPpYzK4gEVEE/7PtUzzpc6rkm/TjcyceWs0h93mFyiW8Bj5Ax
	uKYSNQsJwqluQcEYShALlGYDAcOGvMSHb/7Gkh9HjAQ4zZWKwM7G5LvLHnmEyAiV
	hAWdTW6mCECc/rdJbQToJYmzFcsIG96IkVZiM4UekKHDlXbwoe4v8mVwE8jSqkUF
	2Q4wy4UGR+TQXiUm7Kaj9tmDo61T387FsGIpEmzkDMkHaL0pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713931184; x=1714017584; bh=6r9s0S4HySBXMGYc3GINphH3AQtP
	DIZO3GXY8kvdXu0=; b=BZO7yYBlZdxwZZTq+9BkPTR0dy/ezhLgZGVpTFisiWpt
	KR+/MhYjdRjcMoz56r6HNdACURmzCBderxOzCv/oJh4SFHEzbq95W6KdKgGvXiQX
	KGz12XyKe/18F1WIaUBjsCUJkzH9d+Ha8kdDHWddYFl2ThijfmN1KDGgWMoyCfBd
	tkXq0K8qYLPOVVwiuj3N1EctAqAPmqfcGCuo5PXOaEtsGOXU7zYmUsvhEjGj8Ful
	KqqLq6Gn6PeAjlNZqYFAMsSZMVTFFfem+YKxNSWbfZBfWlnAV72NFQeAlao4zkM4
	BT2bNRVFVA5EzrkNJXuIChm7wM8YJG/cqSjkBK9uig==
X-ME-Sender: <xms:r4MoZmBQR7O44qNRQTifaxeocyKYQPlruFFZZ_YlcjnWLOpCotimDg>
    <xme:r4MoZgiVCQiO_3jBo2n450GRplJak2VP6sjcFGkLCxgRXtEgYUMdteDm1AeVptCxp
    TDeH5d4nsMgsnei3Q>
X-ME-Received: <xmr:r4MoZpn8uVLnlntkJW7sT19bAhdGmFFSq0H5DttfY_eumOgaqS7356Qm6PM7ix-oxuhcn7TXrMjQyTW8jTVTKN_k0pjIPfXyvMNPTA7iH6UuFe4kDSEKlajd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhlihhu
    rdhioheqnecuggftrfgrthhtvghrnhepfeetueelkeeuheetudeigeeggeetgeegtdetud
    egfeefvdetjeehgfelffffheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:r4MoZkxvESLWjH0QFi6hMMX1U7eb21F1BHSPm1Yj493GH0sUDRZn_Q>
    <xmx:r4MoZrRvvukpACpAH2uGF400S5ZeDRmsGVihuFi-vzryiS8Po8f2SA>
    <xmx:r4MoZvbjRzFRc163p1gznJxisqmawcTy3TnMmSskarcP-GXJV3p61g>
    <xmx:r4MoZkSl0H8XYZ5wn6w7y-Jx2VfkwmCHqo9aRPkW68TQb0hY1JWdFA>
    <xmx:sIMoZmc_vBZlJMdlQFiDNZivFSe_8H6OqTKSnwBiia2vb4wBDc1wHVtX>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 23:59:42 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH 0/2] advice: add "all" option to disable all hints
Date: Wed, 24 Apr 2024 13:58:55 +1000
Message-ID: <20240424035857.84583-1-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series adds an "all" advice hint type that can be used as a
convenience option for disabling all advice hints. This is useful in a
server context where advice hints won't be seen by a human, and hints
that change over time may cause test failures.

This value should only be set to "false", at which point all hints will
be disabled. Individual hints can then be enabled by setting their
respective types to "true".

The series also modifies the `advise` test tool so it's able to test the
normal and special case branches in the advice_enabled() function, and
adds a few more test cases to verify behaviour.

Cheers,
James

James Liu (2):
  advice: allow advice type to be provided in tests
  advice: add "all" option to disable all hints

 Documentation/config/advice.txt |  5 +++
 advice.c                        |  8 +++++
 advice.h                        |  1 +
 t/helper/test-advise.c          | 20 +++++++----
 t/t0018-advice.sh               | 63 +++++++++++++++++++++++++++++++--
 5 files changed, 88 insertions(+), 9 deletions(-)

-- 
2.44.0

