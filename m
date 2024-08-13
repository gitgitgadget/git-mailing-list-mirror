Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB658ABF
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534813; cv=none; b=jJ5uOw8r4yjaFb7wQo1ucYwysPH/Nw9nyK8BjCHgwkNlQNHRp7tDHUI55qrnzXQK1FoX8MjoNkTyRWYPrbw524FPy/ZxHiN1iorZCnLxnuBrF/53QnR7gTwfpTbrBlP0JHFqz5a3Fn0muk7JTBkmUngpd+tAGr1h0OzrlvRLHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534813; c=relaxed/simple;
	bh=/U/9gplQF6tx0NJw8SCDV0VszAU7QV04yUZcsFnqjWY=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To; b=Bi7kn2DqE4xpjawPt+VTNr4dgZd1pU0rg0K8YVw5eWxPaPjkQ0ceL7Pm5KSgEyGIOIdM3oJ/Fxt49+LkLDCyRIXW9Qv66bTvjNN78syW+BEHmEmoGDU/JO4L3Ekxx2LgVrhdGy/tDy+qnGHo10xLXSR4Iail1NKgi9d/nvOL0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hicksca.dev; spf=pass smtp.mailfrom=hicksca.dev; dkim=pass (2048-bit key) header.d=hicksca.dev header.i=@hicksca.dev header.b=mNSkBG+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cy+OSkLl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hicksca.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hicksca.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hicksca.dev header.i=@hicksca.dev header.b="mNSkBG+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cy+OSkLl"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 55C10138FDDF
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:40:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 03:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hicksca.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1723534809; x=1723621209; bh=/U/9gplQF6tx0NJw8SCDV0VszAU7QV04
	yUZcsFnqjWY=; b=mNSkBG+BK65Ypk9VdRuSF/szKZIj/LmZj/XmnajJD4AtE+w7
	F3/UNnVW8hxHI4O6CY1wzrRtps174UZY6LiEu+fwIJbt6FRgZpShx+0BJz8pZI1U
	3BYfhQJMADjloXyRksktF3Fp28MpkrEnW85Dr44n+yCxa4GI/gfjDaNoOWC5vKom
	SMmbrA6VhVjNI95ce/qSf8lcC3Cecnt+Ltlgv3i/66bO7BPnD5YhXZp2qw9opf5K
	yA08wgpHiZ2x0suWIp+VeMGszScr3twBnlcBoEbKP7DOhB7ziR5OHx/jhZ9mKoLU
	AQg5ySlPXanrge3jupRHb6ZWB2rTj9PcbXysaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1723534809; x=1723621209; bh=/U/9gplQF6tx0NJw8SCDV0VszAU7QV04yUZ
	csFnqjWY=; b=Cy+OSkLlgp4/G/E5AqmwKCMVq0LO2P2zH4JbxuTDR8Gql6hMNbP
	9C1kX1gT1z8x7X7lyIHZdxO7ozb3FdWrERpIbijIbANhH04G4Nf4Ul16JRlKm7WH
	jDqZjmRrZS1Y+pAegr7CyMWy/ETRbo3qEx4ZOoPDAWGn01AKN56cWyxbHuGpfQJt
	YJ9Ym08pwSbgyZNWsxXgVMAf5dv5WmyrERURGtoaVGW78KNoViuQ5bBL1v1/lIlh
	eCkconXrX/zZhDXf3Q63jzLv90F848gWSQWD5Tois8o6r/lrPI100AyPJ2I9Osvn
	wQdXOtNMSOyxTNmVfHIuA7H3epaLiRQrVAw==
X-ME-Sender: <xms:2Q27ZkiM8U07c-LKUMWL7FBopsG2GYjIsGVxcmW_lmWcuo3Fx0sFPQ>
    <xme:2Q27ZtCGNz7nEZO87d2t62LMHkz_dC3eB3yq0CM-amD08b2ptykUh0GQlX1ARzDxL
    uyoWQfeBXwHzQ6Uig>
X-ME-Received: <xmr:2Q27ZsGe4__705alSeIvT9V3MWDepn4gJCL-YcrguSZEDcQWYX2gKpeS9lT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurheptgggff
    fkuffhvffosehmtderreertdejnecuhfhrohhmpedfvegrrhhlucfjfdcuoegtrghhsehh
    ihgtkhhstggrrdguvghvqeenucggtffrrghtthgvrhhnpeekvdefjeetteehffegheduhe
    ehieefffekudfhffetfedugfffueetheetleelgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegtrghhsehhihgtkhhstggrrdguvghvpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2Q27ZlRqW3E8lhjuU9HDJeBkMVZldSHkpsJUjRfPY3F8JlwiGscuDQ>
    <xmx:2Q27ZhyCJ38dAFdDaryHL1r0Dc6fAArTx4ii10huh9TdMuNn8CXkEg>
    <xmx:2Q27Zj4qbl3ggXIAv8zypusVXdZlHp0PFjDlTm3IeWkeMCXOyX4tFQ>
    <xmx:2Q27ZuxBoelUo_vymw5iZBUUimp1SS6Wl5H8Y4N961abPw1EbTM4ZQ>
    <xmx:2Q27ZirsTQnMwg88jg0UN8ZrOybntZvQvbYkbsTluWS2G3diOnWdSCg5>
Feedback-ID: i48d14781:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 03:40:08 -0400 (EDT)
Content-Type: multipart/mixed;
 boundary=ca64b25f03473e8f9d7f146fd7e954572ece165ae3ebaf91888dd4f927c1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 13 Aug 2024 03:40:08 -0400
Message-Id: <D3EM3KIP9F64.368JLPGQ8MLLX@hicksca.dev>
Subject: Subscribe
From: "Carl H" <cah@hicksca.dev>
To: <git@vger.kernel.org>
X-Mailer: aerc 0.18.2

--ca64b25f03473e8f9d7f146fd7e954572ece165ae3ebaf91888dd4f927c1
Content-Type: multipart/alternative;
 boundary=a972b01d8d2b471ad96e0f08edfa0422d5761cd9e8126f9e58efccbc3c2a

--a972b01d8d2b471ad96e0f08edfa0422d5761cd9e8126f9e58efccbc3c2a
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

subscribe git

--a972b01d8d2b471ad96e0f08edfa0422d5761cd9e8126f9e58efccbc3c2a--

--ca64b25f03473e8f9d7f146fd7e954572ece165ae3ebaf91888dd4f927c1
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=hickscadotdevpub.asc
Content-Type: text/plain; charset=utf-8; name=hickscadotdevpub.asc

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptRE1FWnJMcVhCWUpLd1lCQkFI
YVJ3OEJBUWRBVUdpd0FSYW5SaUY4cmM0c04xOFJGRG5vazVCcHh1S2E0VXVjCmFLY1F3cE8wVG1o
cFkydHpZMkVnS0ZCbGNuTnZibUZzSUVkUVJ5QnJaWGtnYmpwRFlYSnNJRWdnWjJ3dGRXNDYKYUds
amEzTmpZU0IxYmpwb2FXTnJjMk5oS1NBOFkyRm9RR2hwWTJ0elkyRXVaR1YyUG9pWkJCTVdDZ0JC
RmlFRQp5VE5vejJXa0RCNTFNdnBlaDEwVDhldm1pSkFGQW1heTZsd0NHd01GQ1FlRXpnQUZDd2tJ
QndJQ0lnSUdGUW9KCkNBc0NCQllDQXdFQ0hnY0NGNEFBQ2drUWgxMFQ4ZXZtaUpDMHRBRUF1cGVP
cW5KTjFqUm1idzdnZlB0YkhUd3AKNlNURi9GcDluamZsdGlXNlE0TUJBUExSbCtJMUpYaTJ1YmxF
THcvT3F2SnVySmYyelQ1WWNhMXhPaFRTNGVNRgp1RGdFWnJMcVhCSUtLd1lCQkFHWFZRRUZBUUVI
UUtiQUhzVDg0dklvTnE5ZW5CdTNZcG1YM3h6dHJONXRpTS90CjBzMW5icDB3QXdFSUI0aCtCQmdX
Q2dBbUZpRUV5VE5vejJXa0RCNTFNdnBlaDEwVDhldm1pSkFGQW1heTZsd0MKR3d3RkNRZUV6Z0FB
Q2drUWgxMFQ4ZXZtaUpCUFRnRDdCN29ZMW4yNHFHVXo4THhVemdIUHhGT2NOY2doT094bwp3MU9O
UUI5eEhIVUJBS0JYUDBaNXp3bmRVUWpOMVBEdmZoWDVta2tXM0RHSElHWmdNK0kxQkw0QQo9RmJ5
dwotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
--ca64b25f03473e8f9d7f146fd7e954572ece165ae3ebaf91888dd4f927c1--
