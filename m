Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092761B85F8
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723889; cv=none; b=DUegkdI0edQRCZ0MC51MgAd3Q+GCGhxhcWigxJ5MZxK/44iWy1rKjk7su14rs/r/lN14EKQTLDY6+A/eJm/tluQ4Wl1E5qusRVuATV+sNPyTn83WNC8fkgg9wcQZMDQiExBM0dV6jhy93lTGHbjXwCuKXDfIvLPJLIqjOZ1ZPN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723889; c=relaxed/simple;
	bh=zUvszHmM7PqImKAorgNzCfaaeJMMH/uhJV0u+Z+ndS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=XXxgULjMB3OBOrEY9fhM566IT+teisWQwXspYKxIEG9fGHob+oidVUbA50+TGnE/21PwArKgbihA7d24Iv71+WecO+fDsPNTQH6IIpHwXyZRatG3t7meeSjHvhCg28cqpz4dpm/PGxyOMK2gA71WI2dmiclu5GdaaPapDYGq8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DeY55i0a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LF6wW3Il; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DeY55i0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LF6wW3Il"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B1E7254014E;
	Fri, 20 Dec 2024 14:44:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 14:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734723885;
	 x=1734810285; bh=Tt+0+y+7rSIiYGmPtMP5cjN0cnVAXTe4qkkygBasIC8=; b=
	DeY55i0aZX2f8SUzoTkq6XR5pKNQC5t1xnanbuOSRK5hTOhkm/DnjM3SONZvAszz
	Y6oMA9h7k5EjEf04BTXHXbTuUurNbW99r4lDL7byr5MluzzZ0t6vQp1DiP5d6yLT
	Ubqk3u0y62ny4EyZH5QxrVvWgx5h4IepjzfXddGyMUr2Q1DIhIZkLwCEYat0y1MF
	gyH/njQBq8k0T8+Xid2Bx337m2Fu2+Bg1T4DWBByfadJNWGsNzFZCBBER/nGZOLD
	bpCQfES/R4rayigN/r0fu6RmTujqxRxikqR2WDXawO6Ax4fcG3VAB/VK6E+7Mic4
	QfQ7BhZPUHaj1PkU1KYliQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734723885; x=
	1734810285; bh=Tt+0+y+7rSIiYGmPtMP5cjN0cnVAXTe4qkkygBasIC8=; b=L
	F6wW3IlKczZ246QaBTgSH18bjToY6oWpYapOxiD8YCm5/FrW3FMLWPfLl+usvgZJ
	o1BFMwJdo21gcmfFXPJhyYlq5mFKDr6rwiAW4lqArLE23bSlUb/ZoufJqWbjUrmy
	O02A8MxA1Tv2oRs8xQpj8dvzJNWMOQkyDCW6R8wW3AQCNz+XLHPu0clMNCpcGzvL
	UuiAI42BQI+ffoR93UvIki46dwgpCq5FzVwLqGmDi/gr2XTJ9O65tjzOpq8UrSxX
	efNz6ZlAjQ9JCXVbq31gjr0WvxFr3SPrhsm22bmtmXCrOXf9pAJEMp0dX0ipJPMR
	KiRzoeZihb1VQo1wcZdwg==
X-ME-Sender: <xms:LcllZ_K6cvGDJR8elhJKKemWHeejE4oSSlr6uiL_qcumIfkwM3_AxQ>
    <xme:LcllZzIh3VzBjEm356Je9GFnPyMJ1bgZz7iMx5QIsK_KMhB8wk4cteJlJsbkOCYpR
    OPLG4Z4ZBOQfubyyg>
X-ME-Received: <xmr:LcllZ3tmciOJtTbWKyGSfONgS6Hp_JLf6RcCEKeKtZPn6Vktaw2EWCjuFGEeZI2k6SlO5sGtrw2EWIK1Qlr4cvjU_OZUzO6ereYGgaOlY59ExQU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffuff
    fkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueeuhe
    fhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrd
    gtohhm
X-ME-Proxy: <xmx:LcllZ4aQD0inv39XA5dmOKNRq-_A_JDO_OfJpS8_vNs02u4Z1aOCZg>
    <xmx:LcllZ2axRFb1UiEOhqgm0cxyQ-MQIodmTCCPSeJ6j7vRGAsjnVzCiA>
    <xmx:LcllZ8DIj_Gw7Lrqagab17sYojjXTZkkIdCPfW5YoXjmcdo6kCxQ-g>
    <xmx:LcllZ0aLMgxgMMBXSDDeNpjjTagwq2ofKlNK4iQNWTtN1h3-a75nkQ>
    <xmx:LcllZ9X8E-cmjPkpaGLMm1kAeXeEr9cNcQxOJtNJXqfShS7rQ3GMLdED>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:44:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05974e6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:42:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/6] GIT-VERSION-GEN: fix overriding values
Date: Fri, 20 Dec 2024 20:44:20 +0100
Message-Id: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABTJZWcC/5XNQQ6CMBAF0KuYrh3TTotSV97DuCg4wMRQSEsaD
 eHuFhbGpS7/ZP77s4gUmKI472YRKHHkweeg9ztRd863BHzPWaBEo1BZqAyMjwgtT5AorO+Q2AH
 5xGHwPfkJpC6Mla6iGo8iQ2Oghp/byPWWc8dxGsJr20xqvf7FJwUSrLbaNbIo0chLbhy4F6ud8
 MtD+ZOH2WuUKU6uoLLW5cdbluUN2jqLbCEBAAA=
X-Change-ID: 20241219-b4-pks-git-version-via-environment-035490abec26
In-Reply-To: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Hi,

Peff reported that overriding GIT_VERSION and GIT_DATE broke recently
due to the refactoring of GIT-VERSION-GEN. This small commit series
fixes those cases, but also fixes the equivalent issue with
GIT_BUILT_FROM_COMMIT.

Changes in v2:

  - Don't strip leading `v`s when `GIT_VERSION` was set explicitly.
  - Allow setting build info via "config.mak" again.
  - Wire up build info options for Meson.
  - Link to v1: https://lore.kernel.org/r/20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im

Changes in v3:
  - Redo things such that we use Makefile templates instead and a
    separate GIT_VERSION_OVERRIDE variable. This requires a bit of
    shuffling, but fixes a problem where the version becomes "stuck" due
    to how Makefiles handle includes.
  - Add another patch to stop including GIT-VERSION-FILE in
    Documentation/Makefile.
  - Improve code flow in GIT-VERSION-GEN.
  - Link to v2: https://lore.kernel.org/r/20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      Makefile: stop including "GIT-VERSION-FILE" in docs
      Makefile: drop unneeded indirection for GIT-VERSION-GEN outputs
      Makefile: introduce template for GIT-VERSION-GEN
      GIT-VERSION-GEN: fix overriding GIT_VERSION
      GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT and GIT_DATE
      meson: add options to override build information

 Documentation/Makefile    | 17 +++++---------
 Documentation/meson.build |  1 +
 GIT-VERSION-GEN           | 58 ++++++++++++++++++++++++++++-------------------
 Makefile                  | 25 +++++++++++---------
 meson.build               | 13 +++++++++++
 meson_options.txt         | 10 ++++++++
 shared.mak                | 11 +++++++++
 7 files changed, 90 insertions(+), 45 deletions(-)

Range-diff versus v2:

1:  16c647d30b < -:  ---------- GIT-VERSION-GEN: fix overriding version via environment
2:  819154dc77 < -:  ---------- GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT and GIT_DATE
-:  ---------- > 1:  dadeded025 Makefile: stop including "GIT-VERSION-FILE" in docs
3:  b658a5a42f = 2:  e5a4fff080 Makefile: drop unneeded indirection for GIT-VERSION-GEN outputs
4:  79b407d6a2 < -:  ---------- Makefile: respect build info declared in "config.mak"
-:  ---------- > 3:  c271f33aeb Makefile: introduce template for GIT-VERSION-GEN
-:  ---------- > 4:  c4f2c8aa17 GIT-VERSION-GEN: fix overriding GIT_VERSION
-:  ---------- > 5:  5d231080e0 GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT and GIT_DATE
5:  26feb8bc81 = 6:  53bcb815c4 meson: add options to override build information

---
base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
change-id: 20241219-b4-pks-git-version-via-environment-035490abec26

