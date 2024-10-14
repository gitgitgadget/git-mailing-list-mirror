Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4EE155C98
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906356; cv=none; b=OMHTII1lWn/NeIBZmsdF73wgOXVhhUlmytLkil0I1/wXMzQUD6ybVYt1R61av4DAfaJ2i7i9Bd+uofp9AzJjq8JbTz4MP66CGyBIP9++4YnJaiXK638bl6pqKka6hXg7PiuNJasL3N9Ng6VTxZ9BKpWcozCHS0yJ3qF84eVJy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906356; c=relaxed/simple;
	bh=jGW+xE2jheHzt/3GhOljDa3Qah9sAVHUrgHvOP60tvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjzFAKdwZYnz4S/VXiF62XuSoBYjii2DkYyLl7JBLFscNFuK1+MVG5L0uKFUvBlHWtsvb9DoFRjL3tuSoCm22VU8F3/JnhHh+StZiuvjpIfL83lKstKqXX1lZ1lQKqj4BNsrljUsglBHqXPh+uDBa4l8AfI3fScUHY09ikyhgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m1uVVoou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiIznOeZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m1uVVoou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiIznOeZ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CBB9138041A;
	Mon, 14 Oct 2024 07:45:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 14 Oct 2024 07:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728906353;
	 x=1728992753; bh=3eDVXDDmIfExpIFicARR+WZ/zzsu5Xq+HTM3SdDaEC8=; b=
	m1uVVoou3MUTLeTl0eNu2IZk/oVpfLfqls7cUqEYfal0eQaCayCytH6Jw2iIq09h
	45lAkxQaxCVRIKpU4Mzl6TyJe1CIKfyXRoDkJJVLyScTjPdj2qEg+gbe0cyA9j48
	UgBF7yirSyCrzy4IXLCKQZ9LpSv3ph0k7Qw1xlrcb/X4PhlRB11cGr2o+5aVhlUX
	I5neqRc++EZ3u5itnD7FYfWz5dZbhdpadgvD6/dYpyfT9z5eD7yMzymPh9qtulb5
	TzUNfHcEm08IIRC2HwNTij6oraR5uO6OCp26eTF53mC0Gd/enbAaC+U/GuVNgRVi
	c5s2Bqu0ty8nAfweI9q4OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728906353; x=
	1728992753; bh=3eDVXDDmIfExpIFicARR+WZ/zzsu5Xq+HTM3SdDaEC8=; b=L
	iIznOeZGppwubfHLA51yuRTz1GNd72UbhGvi/fI1znlcqPImrSf0Q5c08eDTmq9i
	BLXzEti532AJypgWs89JG92//n1MLJAxAgz0snEvtY3zyyEOTs8i0HtqXv3A94Yg
	ms9Rt51mU9d3xT7q7J2n5YTN+fZ/pE9RTT5lPi82z09whdq0VBFtt9/DZKDaKz89
	LeqintC7Q+dVCoFLq9hESrnPjJkJAto0qH2ccLMtWmb4io3KOYbd9ZF0ff4vwX9z
	1+byz6mPNKihWjpnXyapZ4a7Rca3GQMec47uwHq1D0SNvTT/p147HMg/u8ieSeDh
	nHwvFNmhUR6ZTLVdYbkFw==
X-ME-Sender: <xms:cAQNZ3v7l53rFGcgo35oL2NQlClOAP-ZxqeguDGHzp6YhK7Ua9MwsQ>
    <xme:cAQNZ4exAG0EvvrLl2v_bRWYAqL7vfNHYaVG_yLj-I0lUxjo0EtX-hznYLkrUN03J
    e3NWWe9QxZJDALc5A>
X-ME-Received: <xmr:cAQNZ6w4n7ogFzfCIUSA5qY35i7DdP6Xuofr3TLlgxyUbJvll05cJBVXTVJcnGWzKVDQRvle7P2eRJBSuYLNXXsfDdlz2kbIGGgzMmljaUkOMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrshgvuggvnhhosehmihhtrdgvughupdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cAQNZ2MVKS6PSknMTYM9krwTNQYs4dsq3uu730HTLQ_HygpXuLpyHQ>
    <xmx:cAQNZ3_RPF4lcnbXxWwfzH1DisOVvvPLfSvna2QNtWt1qkWu8ip6rQ>
    <xmx:cAQNZ2XpF4goojUyR30nW49MXiOoMa0QgttdKV4LGEzv8SIN9jXz_A>
    <xmx:cAQNZ4evmJ9a7pRRWnU7caOd5i7OIN-p020l4l8uG7B_zm_wEgUe-w>
    <xmx:cQQNZ5LvGtHNZEKzxVFnIzlK6g21tr2tWH3uH2BuGDd1s9gW-ppwBnjy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 07:45:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ba68834 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 11:44:34 +0000 (UTC)
Date: Mon, 14 Oct 2024 13:45:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH 0/2] t/unit-tests: improve clar platform compatibility
Message-ID: <cover.1728903464.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>

Hi,

this small patch series addresses two recent reports about platform
compatibility with OpenSUSE Leap and SunOS.

Thanks!

Patrick

Alejandro R. Sedeño (1):
  Makefile: adjust sed command for generating "clar-decls.h"

Patrick Steinhardt (1):
  t/unit-tests: update clar to 0810a36

 Makefile                                   |   2 +-
 t/unit-tests/clar/.editorconfig            |  13 +++
 t/unit-tests/clar/.github/workflows/ci.yml |  20 +++-
 t/unit-tests/clar/.gitignore               |   1 +
 t/unit-tests/clar/CMakeLists.txt           |  28 +++++
 t/unit-tests/clar/clar.c                   | 115 +++++++++++----------
 t/unit-tests/clar/clar/print.h             |  11 +-
 t/unit-tests/clar/clar/sandbox.h           |  17 ++-
 t/unit-tests/clar/clar/summary.h           |  14 +--
 t/unit-tests/clar/test/.gitignore          |   4 -
 t/unit-tests/clar/test/CMakeLists.txt      |  39 +++++++
 t/unit-tests/clar/test/Makefile            |  39 -------
 12 files changed, 178 insertions(+), 125 deletions(-)
 create mode 100644 t/unit-tests/clar/.editorconfig
 create mode 100644 t/unit-tests/clar/.gitignore
 create mode 100644 t/unit-tests/clar/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/.gitignore
 create mode 100644 t/unit-tests/clar/test/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/Makefile

-- 
2.47.0.dirty

