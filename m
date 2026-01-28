Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E1311946
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590173; cv=none; b=dqtl1RWy6bjUJiGK1i3HZbRIBQXGTa2tYs8K2NoQwnoUK8GDU65fzjLxbUyiuLuwODej7j+8Zy9JL0e6lBa+p/0RrNcUW0XrYf5KO7O9EvYIp8QFuXO+LNi7Awux/dzZOaRkSlM4G5L5uAl3bDWKzKlcmcZf3MxVWaut9HYelkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590173; c=relaxed/simple;
	bh=L4BFzNrWsVjauAEYWU8mKVxc2G6J1Cbk3bOH7PiGjS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GheHQty7cE0geO4S3mxxRUNHXG/VLIgs+MqEUqh6JbHq/UwqPU8qHqi5AM2ShR5piI+SJtWN9Z13Dw44+V/vBgc8CwSmfIFX2wbcXTdfHSAI7NlZrBjb+OUKZe3+DI6KEycRylPrcuYHzLdo/utk6lZMb12XINale7ZoUYDNEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y/cEs+zH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d88Nr1xb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y/cEs+zH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d88Nr1xb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AB042EC0184;
	Wed, 28 Jan 2026 03:49:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Jan 2026 03:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1769590170; x=1769676570; bh=PqeO8FRh1J
	pHHvGl0Sycd1HZXMNXyBI5pFUvQ5GOLao=; b=Y/cEs+zHmJLtOXu7euIkiXhDvc
	sjGoa+acKgqXQE0cy+AJx8qgl6hxbnXvgsJoqo5hjJhKX8ixzYnNrP/b43SkKo2o
	oCCMGT8tXoFo5j4xsWPAPW7P95PN/4rX4QjqeZUkeXX9olRwfJd5BihfgfqIbNUR
	mURkQcSsuVALif8nZRuI7SJ83+hqrvAHINOaSv8kap0RDesGQor2Efai3l/aKVmI
	qsN9RoTQkJlWDUWpzErEoNgx/Myue6VQK+1nce1SmXKy9dhqrAGX2iE+bDkvFmzZ
	vuSgs7CgrIQjcz0ojB6+qcE0jz+UdxB6tyerbYjJK2JvPchTbylPzkiSFbEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1769590170; x=1769676570; bh=PqeO8FRh1JpHHvGl0Sycd1HZXMNX
	yBI5pFUvQ5GOLao=; b=d88Nr1xbNbD528J+08NdLaf/8lqJW1szIPMZPUD2dXnO
	JM6xNc9HXdrWX2nplCh1TeXaXJOYGEIz5Y1yeLpJ45HL9UYJ96ymA8F3DJfNOfv9
	N86NxfO3mB+LQWTBw61miy1tbNWKuL5vsbgMMAaLmy4/R8x65lD1ALn3EalVAKDe
	YvD1YJIOPpnVlGyKeAFtyk5E+TqyMUf5zVw+fEckR49BY8D+0vc3mWUlF2VHbIs2
	KIa++4XI08MmSF20dOkCzJ+ViWzjz4pIYss8a93UFAmJC2L8o3ZYwMk2/WGLrmzA
	BCn91QtOY246NT4XdbxdS3536NHpYoPhNubPwAeZxg==
X-ME-Sender: <xms:ms15ac1vTqPyUh7M98zGgIeZisiv6Ls4G2ZYLOdRc7qnHsFxQ692Cw>
    <xme:ms15adFnZ7C6rS-Nt8buwGRO9Nxe8_HzImXqcmdwvVr1BaFAs_p579yfLwmtaJGwx
    UpT-9iThQZcOB7SXBG_RlfWnilLFLByWzYCojiMnftvuhAeX5rDysc>
X-ME-Received: <xmr:ms15aSjwQSrg-3sJr92vGkE-G4Yk9JYN9Px6pMTYgrycETYlwEUWBTjPWr1Xfg0rRVZsZORWcX_QOUhL_bYwUK52-k47-wPGqCh6mtNJTmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ms15aQ96kXj_C8-jtMElZ4rOul7bVQSkl1AavjHlbXslq0aE3FPDPg>
    <xmx:ms15aRrwNHs49dm5SNvcI6cVxsE4NwPlyqKvLIvlTH8RmfrhT_rp0g>
    <xmx:ms15aX-C0YbarRJ6aNi_n7OyPQVE81EN0AJmBOo5F6Th7X0nAjk1cw>
    <xmx:ms15adVcG-07Dfi2hfZzEO57kTk3r8XI7Iu7gMLjGpKon5qon8dH1Q>
    <xmx:ms15aS95ll2Cs727LUdsCJ3Fek_TO0QwrdTUoTz4DB2obqbd2K_YExV1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 03:49:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3f7edf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Jan 2026 08:49:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] Fix misuse of `refs_for_each_ref_in()`
Date: Wed, 28 Jan 2026 09:49:19 +0100
Message-Id: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI/NeWkC/x2NQQrCMBQFr1L+2gdNWoN6FXER64v9iGnJp1Iov
 buhy2FgZhNjUZrcmk0Kf2o65Qru1Mgwxvwm9FVZfOtD6/wFzx7zx5B0RZoKGIcRhQma8VVbjLi
 GyODZuS6epXbmqnU9HvfHvv8BwqU+aHMAAAA=
X-Change-ID: 20260128-b4-pks-fix-for-each-ref-in-misuse-96ae62e313a5
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

Hi,

this small patch series fixes a bug I have discovered where configuring
"pack.preferBitmapTips" to an exact branch will cause Git to `BUG()`.

The root cause of this bug is misuse of `refs_for_each_ref_in()`: this
function accepts a prefix to yield refs for, and then strips the prefix
for each ref. Consequently, if passed an exact refname, then stripping
the prefix would make us end up with an empty refname, and that is not
supposed to happen.

There was one other caller that got it wrong, too, and which is also
fixed in this patch series.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
      pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
      bisect: fix misuse of `refs_for_each_ref_in()`

 bisect.c                    |  8 ++++----
 builtin/pack-objects.c      | 19 ++-----------------
 pack-bitmap.c               | 18 +++++++++++++++++-
 pack-bitmap.h               |  9 ++++++++-
 repack-midx.c               | 14 +++-----------
 t/t5310-pack-bitmaps.sh     | 35 +++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 36 ++++++++++++++++++++++++++++++++++++
 7 files changed, 105 insertions(+), 34 deletions(-)


---
base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
change-id: 20260128-b4-pks-fix-for-each-ref-in-misuse-96ae62e313a5

