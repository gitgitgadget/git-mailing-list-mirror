Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9B1F80AF
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497074; cv=none; b=I72Txs1hvncoh98zY/1Kc2QBC5qk4FB+LQzavD4YYjRjog0m9xI5lmfZCQXzPCB96cmT5WaKciclrTQn5oPqVD44jIbbOWcOJEQW35uFMDPrgTAvGawFKi+A6OnpNUhtxwtFzzwWZNtGeUBOEM2YCEx2ZcQR7da5alooDLsWLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497074; c=relaxed/simple;
	bh=JR5lnGeHIWxpXNiLYX/cZlB91sFC/lbsgXKkRIsJeNM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EOYgHk0DHiLdhlOeaqu7CsAFx9zFZpxa4b1zolqNbrq+OEq1mN1ffSHacA3uT652nEtgG0iAoewxq0C3w9cKANlukBgAzBANBc6Fnt6ehr0Oxq9lKyMvnbHn+SHroyAvUe6bJriIIJNAlxe2uXYf7gH3mMrGzy2jwiLCEa0N9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EFfj2TEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePl1uqw8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EFfj2TEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePl1uqw8"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 068501140190;
	Wed, 13 Nov 2024 06:24:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 06:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1731497071; x=1731583471; bh=Lt3w99MAQB
	eUvNbtYBtVPOPQzAXhSVi6ipRRxu7ghcw=; b=EFfj2TEC6Xxnf4nr5RSBz6/eKo
	ZHAGpSsAfBY70D0h/stae6RU4/rj9FQ3+oUtORq+V2UqN3dyQUjIRslrbfskJ1cR
	nQkceufMJ9TP/UNEIgsSJMC4xdVfn8Wh8+Bq7ZXz9rjF/9Yqh+L4yvkdLa9YVeoS
	R5Lb4tgMkWBC9cJ9NunC3/Y8WfAIp/dXOrvDRCrdv+7UXkdFZucXO/h2PRumyK26
	LHxloIcDmw2JY1B0r6OxsrlcfKLfMqP5zI5jzk7RElZ/N4o8EO0eTWq2jy/P8WXx
	Q8XXx3IpCKAW2zLG+ZPhJc7F0ror3au++vMPP0A90x+EFP78rQ/QM25dLaHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731497071; x=1731583471; bh=Lt3w99MAQBeUvNbtYBtVPOPQzAXh
	SVi6ipRRxu7ghcw=; b=ePl1uqw8I/6KiNjClUp+r42IaK1b4geFL2nJ/EWXfYR1
	PAwRsQOvEU/CiTMxu0n2K50ZEuDS2GapDWh+pO42iqBmQMZPtkaqLB7pCc6tqb7X
	ndhw4CG+oY9xYe94Oyl/dgvzo2+nmPoL8o1AqdsM8HXVG5dpj95PpZh88Dj9W5N7
	0ncxQxXNNw16dDpEYQqg7+9RhKj4G+bbaMsSsM4WHp8eom1UVAQIuDHu48WXQNSq
	KaYPDncgQ0Y8GXB2onNf9RRxY02cgHm0zERw6DUVYENg47XMS2K4rQ7uylbLI390
	M4Qq3U2xKRtuXL2rivPaodc9RXOzQvwQr1ePjtFQbQ==
X-ME-Sender: <xms:bow0Z64V1DRnnPKhYiRh5FOrAhSkF42g6bjON5jpZ92vMfAkiwxVxQ>
    <xme:bow0Zz6rJTIxF-s3mwEmF8hRxZvsltjHlFJbGNn8eq7bducme2dLb9wpLdAQhIcSg
    FOZPmcd6sAofTCX3Q>
X-ME-Received: <xmr:bow0Z5f1a8rqFCsRCTo3Rh-ztCTuhYG4e7bIavC3hf4oneJxNbsiZIFgwuh4Z7Qd6xU_FRywvLynoSp0mIjzeMA4e6QuI8xq7JTufFzHevg9XWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeige
    ejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiihhhihihouhdr
    jhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bow0Z3KntMxWrkeO8zEfIDQBs4YIJPlyE3y5biXLxwe-wGo6ho-b0A>
    <xmx:bow0Z-J7t-zyC7H_dz_7BWXqWXW4cMNwp_ig1vj6T5Lnjd8ST5FjzA>
    <xmx:bow0Z4xnq1RZqOqYi4J-K7hIEchOLMTYlwssjCst-pxbM1-QjTTNaw>
    <xmx:bow0ZyJwsFtvImToEtklzErkT-SsAzq_Jq9RjSnEjsvlKG18CvDiow>
    <xmx:bow0Z1VjDXzIQhxcjZ4OrWc5sp6agaORpNoCxWKtKJ-R7oQ3_6JUlsvf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 06:24:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f6d7d8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 11:23:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] transport: don't ignore git-receive-pack(1) exit code
 on atomic push
Date: Wed, 13 Nov 2024 12:24:15 +0100
Message-Id: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+MNGcC/x3NQQrCMBBG4auUWTtgmljBq4iLMPm1g9iETCqF0
 rsbXH6b93YyVIXRbdip4qumeelwp4FkjssLrKmbxvMYnHOey9u4rDZzbPmjwhVWII2xaWPJCRz
 8JCH4OF2uiXqnVDx1+z/uj+P4Ac5eQ9dzAAAA
X-Change-ID: 20241113-pks-push-atomic-respect-exit-code-436c443a657d
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
X-Mailer: b4 0.14.2

Hi,

we've hit an edge case at GitLab where an atomic push will not notice an
error when git-receive-pack(1) updates the refs, but otherwise fails
with a non-zero exit code. The push would be successful and no error
would be printed even though some things have gone wrong on the remote
side.

This patch serise fixes the issue. I'm not a 100% sure whether this fix
is correct or not because it has interactions with the "--porcelain"
mode, which is quite underspecified overall. So I'd appreciate some
extra scrutiny on this series.

Thanks!

Patrick

To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Patrick Steinhardt (2):
      t5504: modernize test by moving heredocs into test bodies
      transport: don't ignore git-receive-pack(1) exit code on atomic push

 send-pack.c                     |  2 +-
 t/t5504-fetch-receive-strict.sh | 36 +++++++++++++++++-------------------
 t/t5543-atomic-push.sh          | 30 ++++++++++++++++++++++++++++++
 transport.c                     |  9 ++-------
 4 files changed, 50 insertions(+), 27 deletions(-)

---
base-commit: 25b0f41288718625b18495de23cc066394c09a92
change-id: 20241113-pks-push-atomic-respect-exit-code-436c443a657d

