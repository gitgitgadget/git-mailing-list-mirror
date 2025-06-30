Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125879D2
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310651; cv=none; b=h2mDW8BoTCTgihitsoy7iOtKBF26MkDR2mlnssFv7gPSA9q+2IWq5n2LwTsS7D2/79ou2jc1SkE7OwBPgz6AXq77E1V+eKSK2xbgoYDWGcb5mYLnqlghr/UP2kGNUERAu42sVWhWQegyhTNo/n4dmO8BhhzWFuy9SttKFoY4994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310651; c=relaxed/simple;
	bh=InnWjGmDxGl413PkQ2FQnI3HtZbPDEAiZXADtaCS1Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=poSr+qPzDYbkRRQbAHxIIScjZujgDKxw/bKtlCuxxwI7SlQxR3aaDggfPcHw2VbSK80x1Ip34lX9d6oslItKRcAUbmTOZ6HF7wK0t9bhp0UqnXlIJ5FvGwKExJLPhCe1OjFzptSYRYT4f8sJtmu1ryhDVVfLjeoHW8zEA51Qubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=s7pX66SS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eF5gvgKD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="s7pX66SS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eF5gvgKD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A7D114002F0;
	Mon, 30 Jun 2025 15:10:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Jun 2025 15:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1751310648; x=1751397048; bh=+z
	5ugzHzsekzEa95125wknTRa1wiG46QjiCTp/ppqFE=; b=s7pX66SS+j9MZa9d06
	Z7TChLAF8n1DH8Dih32FvMHlDRfKHhDGNHfIw0wfdfbfFZLdphQsbCv2tfjTcbjb
	1t5+KDE5AWAAqCeRrpQYe/3+AKMWmz5Yx0orP/NxX5My2WuMcCpfLpV89rgWmqgy
	JKmji8VMRyD/0u6TM/8AJTkZiMo+VDW0dHxbs28/sUW9kpdlOCOkRQSHoqSIHSrp
	upG5y3z9K0gxjWygaNHXGrX24le0PxrKRp7XKj+BqLdoS5LT5Zgl0VpM2vTn4y5k
	j/QU5c4AYvL5ZINiUMd0Oer3I4D4NCisWs7DaUxS5ojR+0L9HbHtiYKdK4sn5BbE
	Br1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1751310648; x=1751397048; bh=+z5ugzHzsekzEa95125wknTRa1wi
	G46QjiCTp/ppqFE=; b=eF5gvgKDKx+NkgpcckOyNlc0cUBMv9cIMtixnnH5VcsJ
	NkHzM+rwX6Zg7WANjPTX5kx1qQ9/TpB0YzpwWpR7keb38iwnYU78QmIP75KtM26w
	ya+oqzsMfHeQCBvhwlTegbAJbGkE/RizDlJ2xNihpwXjhBlaLQG7vcD/3zgx68hP
	x5EykIN4VESUZuVQOiGvgd1AhEHw+64EG0hEPNz2aM2dvIz3E/T75lGAmk3bXdUJ
	0h4+wHG5zMT5KttnZ3q9NqfDL6tUxgp6FBIib83WgXv4gug7mNkg5Y82BGVjkT8w
	k5m/pN/VW9KfXY1ws4IkZBY8aCf09ZTalyraZDTkGg==
X-ME-Sender: <xms:N-FiaJWvcKa3S6qdwgvYoC6KG86QlOYWEsmCy2lhHHra51x47pVrBKI>
    <xme:N-FiaJm8DHevkyHjWCk_rngyjNH6Oy9Q_Q79_l7l6_YdxNeoLtiwaTsMC3v7iovBW
    xYld3QWjsSXaazuPg>
X-ME-Received: <xmr:N-FiaFYbSqS49YmBjk7e7uCEbBqFdogybjP2cRMRYlN-ANk9zJKLWeS44D85Y5lR1v97wD7Ztz0NJk1LK0t1OoV74PHQ0d78AqTQo2I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnh
    eptefgkeejffdufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvihhlrg
    esfhhrvggvrdhfrh
X-ME-Proxy: <xmx:N-FiaMVTSJTzr2MRAVKwouqfvgImrIxTRiqtCZAfEB_77GMwmGC2cA>
    <xmx:N-FiaDlt7mmPCqpjmiFQ8pX2mCjZHqjVRGLDAlfXZ9xqfOF9PZS3JA>
    <xmx:N-FiaJdTGPD9puX4fHhdDbDNOV0YW52CE5H2qeZfOQwM4iR_TJiUYg>
    <xmx:N-FiaNHSRolV2BV_OZMNmtC6uitqYlctzMyJKtO4HxJVTpzk3fnDfg>
    <xmx:OOFiaGnmRD8g0996RgpSrflPKLOmZnwFilusQaopHYGS167zFP4Mf2jo>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 15:10:46 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 0/5] doc: config: update for the ps/config-subcommands series
Date: Mon, 30 Jun 2025 21:10:22 +0200
Message-ID: <cover.1751310455.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0-KH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Update git-config(1) according to the ps/config-subcommands series
(fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15)):

1. Document `--show-names`
2. Document `--value`
3. Mention `--value` throughout instead of the deprecated
   `value-pattern`
4. Mention `--url` in the synopsis

Kristoffer Haugsbakk (5):
  doc: config: document --[no-]show-names
  doc: config: use --value=<pattern> consistently
  doc: config: document --[no-]value
  doc: config: use --value instead of value-pattern
  doc: config: mention --url in the synopsis

 Documentation/git-config.adoc | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
-- 
2.50.0.138.gf67de2ec4e7

