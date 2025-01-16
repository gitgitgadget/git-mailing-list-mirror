Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A619259A
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022124; cv=none; b=ZLDRGFSlnwWjRwH1Q03r+e+dujcsD76HjvSdqrEs/MMuKwVFvViEUIVL5jEgjfoZSE+8jGeiqw3DcSD8BixdyFRgTbkHDM4exvtxTxakcAycIrfzeXoyJVtbA1/AUfjA1u0ma7vyaowvvD3zeuNrrpiSc8mNmrHpYfasRq7Ggm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022124; c=relaxed/simple;
	bh=P7c/HfCuA1mCuNkzCjoU3lexBxMS/TArjf89N93bLMA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AB+e6H58ts2w0/JdT0QVhxdkqpBtCxMIKKsTtBNM2FiTOebdzGaJzWMr1N3Dx42XttmPJtB5uLdsByvif8lDvLJ8Ad46xctFrn/CzMy6BL2N+cJgNvA6xe5/+s7KvuNy0buDZvZzihHSpD2tXJftr+O5zKYfuSNuY37i+J6q9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pzrF7WrJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNpuzsRA; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pzrF7WrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNpuzsRA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F6B02540126
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 05:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1737022122; x=1737108522; bh=HOCssKXjYi
	XzIilyO0ydSBCqw2Xo8I7YYTuc3DKGRWY=; b=pzrF7WrJm72lQNkmv7odvC9xfy
	cILqTlGA1LnJpTqEnIuFI4jNfy/23zgoStMF5ku+5bcipocbdWB0eZ72DkfVgEd2
	oZQ56zJAzsfKzYASrQEzmv0YB8AsgKpRo4YmF1kjDWS6b8c1Rt/lh11VmTpqSVjF
	PIer2viYlh1fp2ydDieG9m+eGcmxO7ekprzOe8Pn+6FTLOsfbNLxBzcOq9Qj6dRu
	cT1QXiPngSrq5Zj3/1TjIbRJbwjdGx48UY/My1SfmkTYwORjHXmovJ6ljq85+jfE
	EuvzI6uBwh5dmgBqgCG1bWyAXCRBciHrEvvAanTWElW5LoBZyrIcQeZs29sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1737022122; x=1737108522; bh=HOCssKXjYiXzIilyO0ydSBCqw2Xo
	8I7YYTuc3DKGRWY=; b=fNpuzsRAryP00WyMqoLpb3tFMFby9vj5a/aQ7t67buxL
	69xsA0unXc1E09BkA65cVkhVxiYvbLqRv3MRcIS1W8936KJrie4NDMntEMyZH9lK
	eWhRogFtmXHrqaxwQ+mrinOF5we3YZd2iT6xmeN70VhcC+EiZAWEXKPNAICyQgO2
	bhnvL0G9SSs3JB/+alB4bOZfryq+EwQsK3pnsngPaMtYcCTJ1t6VjkZze5GYsio6
	5TWTZ7FPydmutEBzOQidAqyU5oz1PzuwNeQvuH0lzGSBnLX+rIM9D58tf6xn/qgx
	N32le1gsB/ZMZp4WJELR1yLQpXPmom7HUZ1bwJpUcg==
X-ME-Sender: <xms:qdqIZyiGmQUQgc9kF8t7dIJx6vfHiPJ3QFr_Nk9u2C8no4xZxSzNkQ>
    <xme:qdqIZzArvPXUBGQLaVI01S7nnHbf6EpBP6g02tcJYORWLAR73mlNyvAQz3Ju5O2WX
    f-laYiO7tdeCl2b8w>
X-ME-Received: <xmr:qdqIZ6HbixeQXJK8ZcieYJX2ttlmnW0vJwoUM5Gxj5N34NsoNECHTEBf5_cEnyXeBl_02v9bcF9LxHnXsL0FJgyf7HsallFxsVIBVDglXoO1aKRFFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qtqIZ7SVLgksrwpjc592fBxUBAtSV3tLpDhRY3X-ct5yNX8rIu6XSw>
    <xmx:qtqIZ_w5iRmDEOPxeY_2ovmuByCfkzoluX5y_wB7xj6x4dn23chZLA>
    <xmx:qtqIZ560vKaoJWflUbf9-Sd2bIQEriYL0ACxpuaOVD5Ljpf9REeS_w>
    <xmx:qtqIZ8xs5IDs-TkeVeB-z_6tcs85e116FUvAx1B-WAn5IZ1vh4HtBw>
    <xmx:qtqIZ4ojV6jOQw01hWssR8RkaJtCKMURQVHzOb3SdKB9Gs1kV-1bSCSl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5423f98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] reftable: fix -Wsign-compare warnings
Date: Thu, 16 Jan 2025 11:08:32 +0100
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDaiGcC/x3MWwrCMBBG4a2UeXYgKb3hVsSHSfrbDtU0ZESE0
 r0bfPzgcA4yFIXRtTmo4KOme6rwl4biKmkB61xNrWt75/3AoeO8GRc83hKeYNMlcdxfWQp4gkg
 QjF10A9VFrpl+//vb/Tx/JSLIJ24AAAA=
X-Change-ID: 20250116-b4-pks-reftable-sign-compare-8eaabae74c06
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

during the last steps of converting the reftable codebase to become a
standalone library I noticed that the new -Wsign-compare warnings
created a bit of a problem due to the `DISABLE_SIGN_COMPARE_WARNINGS`
macro that we started using. As a consequence I wasn't able to easily
drop "git-compat-util.h" anymore. This patch series is thus addresses
the issue by fixing all sign comparison warnings in the reftable
library.

Thanks!

Patrick

---
Patrick Steinhardt (10):
      meson: stop disabling -Wsign-compare
      reftable/record: drop unused `print` function pointer
      reftable/record: handle overflows when decoding varints
      reftable/basics: adjust `common_prefix_size()` to return `size_t`
      reftable/basics: adjust `hash_size()` to return `uint32_t`
      reftable/block: adapt header and footer size to return a `size_t`
      reftable/block: adjust type of the restart length
      reftable/blocksource: adjust type of the block length
      reftable/blocksource: adjust `read_block()` to return `ssize_t`
      reftable: address trivial -Wsign-compare warnings

 meson.build                         |   1 -
 reftable/basics.c                   |  10 ++--
 reftable/basics.h                   |   4 +-
 reftable/block.c                    |  20 +++----
 reftable/block.h                    |  14 ++---
 reftable/blocksource.c              |   8 +--
 reftable/reader.c                   |  32 +++++-----
 reftable/reader.h                   |   6 +-
 reftable/record.c                   | 116 ++++++++++++++++--------------------
 reftable/record.h                   |  23 +++----
 reftable/reftable-blocksource.h     |  13 ++--
 reftable/reftable-record.h          |   4 +-
 reftable/reftable-writer.h          |   2 +-
 reftable/stack.c                    |  12 ++--
 reftable/system.h                   |   2 -
 reftable/writer.c                   |   7 +--
 t/unit-tests/t-reftable-basics.c    |   2 +-
 t/unit-tests/t-reftable-readwrite.c |   2 +-
 t/unit-tests/t-reftable-record.c    |  19 +++++-
 19 files changed, 148 insertions(+), 149 deletions(-)


---
base-commit: 757161efcca150a9a96b312d9e780a071e601a03
change-id: 20250116-b4-pks-reftable-sign-compare-8eaabae74c06

