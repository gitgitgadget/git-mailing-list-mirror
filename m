Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C06A3596F
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401828; cv=none; b=diyDo69Uhu/IUz9nFg5eIN4QQO1HULF5jHxnTaYeQ7IM5WfW4hPF8lC8G9+ZMTO1S/yrmx/xA01BkSw+H2RZwE1CSjo1WZr2feJK1kfJV0gAozoWgAaX5migph2dukUcOdnyKRFCM4fbfQpbdnIhvjm4pFBbtZN+hG9VMLbcbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401828; c=relaxed/simple;
	bh=cDulZyWyh11cGoHFViQOapq2yXiaqmGLih3cgM4pTN4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nFaxYWGAL1F3x8Q6+6mVFz1lKISbT3ZOaXQY1vyEw/HXo66tvI4J+HbdlTe6HNiANLxHWJJrt1IdJdGYdWFrDsIMa92Dcqf3mqOFWAwad/5/vZzgJW6t0TyofNPcz+cUlN3nldwOWZb/jAatv6V0qVMdXwrtHUW3QIEAerfOHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bdu6rlmj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4f3BrUx; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bdu6rlmj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4f3BrUx"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 0541F1384360
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 31 Mar 2025 02:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1743401825; x=1743488225; bh=E+hvdZoD7N
	zoy9p/KYsOLULI46X04IQ1bMGQIe6yryM=; b=Bdu6rlmjvqDGR3MWjlKOq4YxSz
	w+1DTUQdsusgP+7FqJ58taZ4hOzyFKyed6mD8ckSeWiTRAydlSm4Dv2LP6R4JLkj
	208HlNfIL17EpZsTTvdJLF3WKfWdCAZLW1EX2rwIx/Ra/h6Kvf2m3DKl9Z8WAPfb
	jBy2etfNTLEscMUR9iZxWQ3dV8PR7i+gPt9xG7rngpvbUFpCAMV4E/Lri3kmAMMw
	xLoE6dkoN4XIgXDeNESzjNFel5Nc6pGzqG9LCbk1fOx8yPBYM5Rmw8+Bu6SQbYpQ
	tU6iVA1quFYSn1S+pPVaRRWZWRbkeKI8ydE4z5E8kvFv10bwHMjE6aWJUniQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743401825; x=1743488225; bh=E+hvdZoD7Nzoy9p/KYsOLULI46X0
	4IQ1bMGQIe6yryM=; b=g4f3BrUxGTDY1zfWnyBuFh8KUqIkvgEiOgiStTKJ9nkT
	nMDXiX9whgj4bVdHSeDDgS6NtFvL6thtpwASBWSuosttRjnH1jsYzqTie1OCLNho
	oAiDwrySYzlZjgs3LJ6mRcophTMSdljXJkRchHh1COp48yS8K5PD2DcddSq4JO3a
	IaFydE/HbrIzoOMqTz+B0zJdcT6gW79tReGzXq1qBnJZgxiXrtPq2JJcMYs5qAak
	0p3UpcVwO75GxB9jnEA1Hsx8Iu32AMKyF37tu0qvbBUXDJQZ++a5WUpdfAI9Ag2R
	HbU9xO2j8snhAHUEdI0CRNv4KKjMZyHESAw3t/SvrA==
X-ME-Sender: <xms:YDPqZ72OFn6uI8XnvE-g9_0C2PBhHTUxLa3Ob5I6kUb4ZjQSeo8CpQ>
    <xme:YDPqZ6GwCrhpCq9udmyU6wRUokUVSKaHQJZG2LzYwowzOITVvJogHk7z49rmZ-bci
    St2kPVsW2pMNBTYpw>
X-ME-Received: <xmr:YDPqZ74yCmHDbK57NkIcikV8Ejl20mGejdgppOGOxdwLA_oA5sjsOrLBsrmqRW_Zv2mNfUNyB5SqpCcaNh-DMXdZO1WBOTY4fAMSQn3wGc2qGkv->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektd
    etieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YDPqZw27-UqB4d0CoiC0wyx-hEoRyVnnPaxpB1ZOc2xxRgE6s_SXvA>
    <xmx:YDPqZ-EWojwhngkrPkGIhaQjLw79SGHPOxNm2nQTVlNdVT1CfODXNQ>
    <xmx:YDPqZx-A5CeE7HYXCy9Vx6HJPc6afXM7jEGJ18_-B08qK1EcoDuqwA>
    <xmx:YDPqZ7n4l7hCNGd0E0p0RqPT2rlU2HglhIcuaI4lr-LnfIX5bjP0DQ>
    <xmx:YDPqZwM7lvw1ocp-xasxe88TZ7DrgSvhGMNDs7lgxIz8Y0G9PLRZ61HC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e04aeaa7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 06:17:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] meson: wire up support for benchmarks
Date: Mon, 31 Mar 2025 08:16:43 +0200
Message-Id: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsz6mcC/x2MSQqAMAwAvyI5W9C6Vb8iHmpNNUirJCCC+HeLx
 xmYeUCQCQWG7AHGi4SOmKDMM3CbjSsqWhKDLnRTVNqocxcVUI6oZoxuC5aTsMZb1/i2r9sOUno
 yerr/7Ti97wdpGKtbZgAAAA==
X-Change-ID: 20250328-pks-meson-benchmarks-a8fac5f69467
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this small patch series implements support for running our benchmarks in
"t/perf" via Meson. The series does not aim to replace "t/perf/run",
which is more fully-featured and allows running benchmarks against
multiple different trees. Instead, this series only allows running the
benchmarks against the current tree. Users are thus expected to continue
using "t/perf/run" for more advanced usecases.

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t/perf: fix benchmarks with alternate repo formats
      t/perf: use configured PERL_PATH
      t/perf: fix benchmarks with out-of-tree builds
      meson: wire up benchmarks
      meson: wire up benchmarking options

 meson.build        |  7 ++---
 meson_options.txt  |  6 +++++
 t/meson.build      | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh | 32 ++++++++++++++++++++---
 t/perf/run         |  4 +--
 5 files changed, 117 insertions(+), 9 deletions(-)


---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250328-pks-meson-benchmarks-a8fac5f69467

