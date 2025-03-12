Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828B2EAF7
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785464; cv=none; b=PY36OACMhhbbGMj0hj/Cx2inroOZGnJvYlUMZ+96gmlKQ622LxoDWm2exMzKXPEzKpQVMjQcSXqxqB4TIPfKcdsdmB4AXH6OSCXEhAol5AxOjbzBaEn0K/I/QAqnvVJgvCJsTzxzHXgLoNbZDv16Ifi6jWrh430jzKhoIQybU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785464; c=relaxed/simple;
	bh=YCw75iX1hYEl9PX49wVsTtPkSpsaxUSAlTs3ikKqTwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rUF+xSL/BMCSoi7B3Ey0KByoszqTfUe1v48odqZ37fNi1fJHmXth1UZNZpHDjML4rNc73hZDeVz8xA4J7KDXn9vgCWeO1h6nWeDxOPWPTBa52Fn1xSNvV/Wt6ytRKgkrWTRPP13LzVYsxe9tMd5iPXKjkb9qTeNx82wtdt97tXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fyE76A9M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOMlVUdi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fyE76A9M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOMlVUdi"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 0ACD5114026C;
	Wed, 12 Mar 2025 09:17:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 12 Mar 2025 09:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1741785460; x=1741871860; bh=IlFCY5MGiS
	ivE2NvVWZBCyWRzQIPwMlqXkkVubMs/+A=; b=fyE76A9MVTw6KumZNyesORW3tI
	fFCJUu6mIlgRkMU5Pq4VSb0ciEfeQ3o+N60Grs/SJT6vXhvi2jbAncp7B7ehQ85c
	FacZ338FxuPewmDUxWBjM8INdP2Ow4vKClG6LG7KsDuvzayYqMfSzlm+53Ra7sUO
	7nc+adIOvJUFZzI0exolhjr6TPzgICARh2A2g/AlNDxV/TqYxXsOvi5GsxX8qaTX
	g9Q7iS7etaDBo7L3RORYXElG8Qj2JBxnh9iZxNaCjPreyPieRBLIyvLyT/3WrdgP
	cS2KGPPPcqltTGieuPFHpD9js9dyqiqrEe6IMh7R1suRZ1dj7sIA/XhQD9yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741785460; x=1741871860; bh=IlFCY5MGiSivE2NvVWZBCyWRzQIP
	wMlqXkkVubMs/+A=; b=ZOMlVUdiX/C3iMNEkXWsKs6QbHFckvwlxUoNmrH/2r1D
	4/447uhijiFcB2QsYsd/IswGEcgPmJqJdAOMe/BnuKcn/5P6mTy6YBYsy3We7jB+
	X1FJwBPkFkV1j0M/5qpIQQxbHPDe9i8+obC4VENNPwFekqpW/Xok12uwfl6c3BgS
	7FcMUNslTf500wQAnb853kymfy96QoN6gEN2OjItI8FCbRHFTBerGy9Vcf7Fueb9
	5X1RhlEo/G9QCAEZH/aJQ6wseK7mIDX+SPyRgPFuc7MXJVQMP1ORro+HunXiirVR
	L6Y9rlqkFdsxa0uZc8Ew67DOn8E3xK6F58Dfdh6s8g==
X-ME-Sender: <xms:dInRZ3kgJppwCzHFOWH5LUBasF8zD8medklpilSsNOgJsG5UzpHtFQ>
    <xme:dInRZ62l6gi7s2YVCCtFeEDkEnOI-8BMYYQ6s-UZFtqWVdqp_Br87HOaWpVX-GgPX
    Dl-Hlls482LD9Pe9w>
X-ME-Received: <xmr:dInRZ9pQnlXAc54ayJSbyFatVTflm5c6YgEQ75h_ngVDacMoUKCl5_RdBwrI49OatdGX83VPJvLfFRtihe7Y5QrEj_DRvLtgTW-3SyDPYIBCxWTBfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueeh
    gfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dInRZ_m054p3pu45jv_ctsiTL9w5QxpkbfOp2-en2YrYjcaJato0PQ>
    <xmx:dInRZ12ID1GJiRD8QuTHoDMKmPYlytbCJCRX-x1xkfRY7QFgWN7Vpw>
    <xmx:dInRZ-s5w1TrcBP2dafyg9FVOH3pxj5TAPMeqTFJyFqauXAzSJCu8Q>
    <xmx:dInRZ5Vcah6OASxTAkk16WHATxlQSRDb_g4ASXW_Rhp7sot_2iEdhg>
    <xmx:dInRZwQJsTxAlwPiw5ApHyZIwligH5biTkxV2T90Y_TV_t4D7vJ6RrFs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 09:17:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 52a191d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 13:17:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] meson: improve handling of `-Dbreaking_changes=true`
Date: Wed, 12 Mar 2025 14:17:31 +0100
Message-Id: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGuJ0WcC/yXMSwqAMAwA0atI1gbaqvi5irioNWoQqzQgQvHuF
 l0+GCaCUGAS6LIIgS4WPnyCzjNwq/ULIU/JYJSpVKENjiWem+BOcngcA9mN/YJ/K9jo1s7OWUO
 qhvQ4A818f/9+eJ4XhZ6n0m8AAAA=
X-Change-ID: 20250312-b4-pks-meson-breaking-changes-819afcca2e07
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series improves handling of the breaking changes option
with the Meson build system as discussed in the thread starting at [1].

Thanks!

Patrick

[1]: <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>

---
Patrick Steinhardt (3):
      meson: define WITH_BREAKING_CHANGES when enabling breaking changes
      meson: don't compile git-pack-redundant(1) with breaking changes
      meson: don't install git-pack-redundant(1) docs with breaking changes

 Documentation/Makefile    |  2 +-
 Documentation/meson.build | 13 +++++++++++--
 meson.build               | 18 +++++++++++-------
 3 files changed, 23 insertions(+), 10 deletions(-)


---
base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
change-id: 20250312-b4-pks-meson-breaking-changes-819afcca2e07

