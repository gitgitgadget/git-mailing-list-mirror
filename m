Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA21AD410
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881498; cv=none; b=EA19WcpCLqiNTomKk6J7H2Y2uzeVz9gKmmC2Pci3957vAx2vzYCIjO4/zF6e44BytaodwfBN2fZEt303YIP9leFNKxRK2lncQHsdSLEnQ7KLItyL7X8+VNU5Eqca8uyi+SdjK0PequJs1cmWzy//iCc3d+FPKJg0BOkiUtnWfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881498; c=relaxed/simple;
	bh=kJSD3/xeUfh4Tmw+b4JTumEcvGkJo11U66czxEcLnbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r4ZkHrP10W0cXlkUKLg6B1jIrwmUc6d0PUo7veuj/sS82tqzeMnTFinDJ4SpTZJsUDP8y58FwrgFgNo+9W0p7OUTqD7tvOJj09j3ZZPoSbPAwRhLMEnmGBYkZ+icGy3Fv79rzIO7NtJ8eCp0gL+w6PhT2EjFUM52TGbDMHrSaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QuBWcHUP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=olSRCkvz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QuBWcHUP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olSRCkvz"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D27C1380285;
	Mon,  9 Sep 2024 07:31:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 09 Sep 2024 07:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1725881494; x=1725967894; bh=AP6yHaAOLHfufBocO2xU9cfgWafpQFiN
	eeWduLg8Vss=; b=QuBWcHUPdSLd57AnJJdPNouOGaade6FtXI7usPG3R3wGBkYG
	5vp5DdKbdMpHD6IUKMUh2+297x7++K1Vzdxh3lQnAWPQIsIM0pyorHs3ljorGB1c
	1n0pDbewdvtFaECQqfdOOxM5M2+MxrXFkucRZq3Kke7fQNS7Rd3RmeLYmsl1p24L
	fgeGiGuiVqvpvIlnpwGw+NHjbk5fPZvWYRLi3jbw5OG2H2iS53fXF5l22tWd0zBt
	eWcLN1SMDP+MNbANYUctqf7+gfKiLE4yXR367xZ4HsdDX986DHBpny/Uj8rnA+ct
	0v26CD7GIyyqlP3Wi55aOAD9BL+mHO7yEMreLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1725881494; x=1725967894; bh=AP6yHaAOLHfufBocO2xU9cfgWafpQFiNeeW
	duLg8Vss=; b=olSRCkvzyAAC581vmGxxL74l80eDd1v2RKO0NU56Nl57i8CWXyh
	8YcqEfxlhtN5FMa9h5wVq/YVvFYQQ5dMFTI0bNelI4CA8dLsYw3AWJ3LUJflokM3
	wQoaEbILv6VqMC2rlWUUUYkdHTIUsaM3259Buc/sG05/Ip1QRgmR1KPoPvPxS82q
	XIWck3MZb06QaasDAZH0lI1lGutwgDjFrZs1qY8FCEUo6meVN9gDc9gxWKbD0KbR
	h7tmJdxOP5TUfu5A8k15FJ1vLUiiqjWfuAJgfrJvonKDlvyX9L52UuCQxjHBswSV
	eQRfUt6IXTUM8a+YjjFSEkN6pgKsfvdGsaQ==
X-ME-Sender: <xms:ltzeZm5iz8RMenDK4t_yfO9ucoHaa6SqgiJpMJknOX9WqvmQd1TTKw>
    <xme:ltzeZv7YGYgSQLHw-WyvXeJGUGyPv0v-7yXQBwntIxPgKhfV6b6iBufQDvynzvFbu
    8EMYGTrtDRmm1f7QA>
X-ME-Received: <xmr:ltzeZlfwfXGZmk7_Aq2oIB9BDPJ87fI3wNBY80pCnQ-pp-lZe-sHt-KbE7mt3H_I5hUlfoE6B7zSsomMeGaBuiC6Jk9cD6GMxaYFrxxqcPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiuedvhfetteelgf
    fhhedtvdehlefhtdffhffhgfeljeefvdetfeevledtueeivdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ltzeZjLrpL8is-ABin5XZr3YcLaBkMClhzjFboaPjIEFiBg3pIJW0w>
    <xmx:ltzeZqLU4i7wUfb9NXrc8Z2S4qoB0n7dTNiErQTe2FdmQLIPGTPVEg>
    <xmx:ltzeZkyx3MN3luGrTcy6WfQkKubju6QbPJkRoBj4h9UgNPjCzDjEAQ>
    <xmx:ltzeZuJW73jOOno_EppZzfJFjgzVKjIAUQDPZ1BBpxiuoEnSZ0pDpw>
    <xmx:ltzeZhUUgwOgA99dMmtx55Pov-ZM1fuvDpqVkOKtod6dypjmiqzyJwd1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:31:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bbe6dcab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:31:29 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:31:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/6] refs/reftable: wire up exclude patterns
Message-ID: <cover.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch series wires up exclude patterns for the reftable backend.
Exclude patterns allow the backend to skip references internally that
match a specific pattern. This avoids having to read references that the
caller would discard immediately anyway.

The series is structured as follows:

  - Patches 1 and 2 fix two separate bugs in how we currently handle
    exclude patterns in combination with namespaces. We didn't happen to
    stumble over these bugs before because exclude patterns are only
    implemented for the "packed" backend. But once you start to pack
    refs we exclude references based on their full name instead of the
    name with the prefixed stripped. For the reftable backend we'd
    always hit those bugs because it always uses exclude patterns when
    passed.

  - Patches 3 to 5 wire up proper re-seeking of reftable iterators and
    adds some tests to demonstrate that this works as expected. This is
    a prerequisite for handling exclude patterns.

  - Patch 6 wires up exclude patterns in the reftable backend by
    re-seeking iterators once we hit an excluded reference.

Thanks!

Patrick

Patrick Steinhardt (6):
  refs: properly apply exclude patterns to namespaced refs
  builtin/receive-pack: fix exclude patterns when announcing refs
  Makefile: stop listing test library objects twice
  t/unit-tests: introduce reftable library
  reftable/reader: make table iterator reseekable
  refs/reftable: wire up support for exclude patterns

 Makefile                            |   8 +-
 builtin/receive-pack.c              |  18 ++-
 refs.c                              |  35 +++++-
 refs.h                              |   9 ++
 refs/reftable-backend.c             | 125 ++++++++++++++++++++-
 reftable/reader.c                   |   1 +
 t/t1419-exclude-refs.sh             |  33 ++++--
 t/t5509-fetch-push-namespaces.sh    |   9 ++
 t/unit-tests/lib-reftable.c         |  93 ++++++++++++++++
 t/unit-tests/lib-reftable.h         |  20 ++++
 t/unit-tests/t-reftable-merged.c    | 163 +++++++++++++++-------------
 t/unit-tests/t-reftable-reader.c    |  96 ++++++++++++++++
 t/unit-tests/t-reftable-readwrite.c | 130 +++++++---------------
 t/unit-tests/t-reftable-stack.c     |  25 ++---
 trace2.h                            |   1 +
 trace2/tr2_ctr.c                    |   5 +
 16 files changed, 570 insertions(+), 201 deletions(-)
 create mode 100644 t/unit-tests/lib-reftable.c
 create mode 100644 t/unit-tests/lib-reftable.h
 create mode 100644 t/unit-tests/t-reftable-reader.c

-- 
2.46.0.519.g2e7b89e038.dirty

