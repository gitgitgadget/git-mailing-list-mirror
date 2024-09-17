Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993E84E1C
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557191; cv=none; b=EcPm+kN/l4hJaUPDXjdsB8KduKXToLXmwuZo68bpQ4QwuemE48DkvVehWL9kqaMPWVh93zx3mhDlcqFtNFoCXL3VhWRLaBnUcyv613Y/FVzkvacdm0eKUusygptBYit9LcSoyzMRTfI/oOgjcDNTCW2uD+B9g97r+ocdBUjv12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557191; c=relaxed/simple;
	bh=JRczXhdTZFFTGsvwfWw9C4RE7xglDBO8Lg4foNhF3cw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kofVwSGLxZ7+AmBW6k8YNiRHCqqLQtJoUivfgp57r0z80uTvZCayewFO//aL/lLZAEgMI16rLXSdqDugLeV2U1PBEeEn7JzeijRt1Ggy7eVHJ8y3Oop7684MSJVwruueNKq1wE60F8RUKrmXSklAlHY3XtN2fJu+WBaz1R/3zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oEf9r4VY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fvtQPQ0D; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oEf9r4VY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fvtQPQ0D"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8AF7213803FD
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 03:13:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 17 Sep 2024 03:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1726557188; x=1726643588; bh=lu5UTkOv9wiDwXv9ZpuRvxkSW59P3d9Z
	PxntIea/TS4=; b=oEf9r4VYIA1kC/b/3MwZP7NTBhov+ALbg8WDrwZdWmGO2Ot2
	xreUwlLtI96uSvMv2GZAkJcu7TS3lYwTyHCIkLWk7E54sbsn+d4NrXaEuCE5tjsy
	/mMySbtPWvWu7bqIyCDjJzZVh75RJ/stmaAPqEuqCWHHN0TfK/lZhuUzgpidGNoE
	e58nmpyY9G68BXsBy9wKS+J0CoAJIWOuwK8ofMLG2gXw+QyI+UKHwk0NR1JmnNtE
	1jlnKkcZt60oY5x47zrgJGsHL2+nL4yYLlnM4phkLWtOY5FvVwkglxCVkAJ7ZVHw
	UG0irA3yVgiZqRDkx7v9sh1Jz7MfoR30+BplzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1726557188; x=1726643588; bh=lu5UTkOv9wiDwXv9ZpuRvxkSW59P3d9ZPxn
	tIea/TS4=; b=fvtQPQ0DD/tCdQCMye+8np97J3TTxVx7LtSfPEorJPsHKoIXlW+
	RB0lqRlN5kcyI1UzzoYU+OcH1edqD+KfaLCGh7mjS5m0e/JaWGha415Vmbx7GQqq
	CK37Arfp0wSN1o3XQ/WyxlS1ikcrddfa8JbtYLusfYCa44w8tpPn+tvVOdesd5Ql
	Dx/ZlINKLllwm7Fppm2V2NbH8zIk8Lz1c4KZuWU1tBvwZYP5rropEDIAol05nVIc
	hnqvGcAc9iPqr/p8cZcANnlM4fInR34O2OijYStZZmnv1OdJiiQDfQBUb/abPkM+
	jE6oVRxPSKlOXCjt6ht9KMASPnSY73o7+uQ==
X-ME-Sender: <xms:BCzpZmlIiYoLnTq0sOjCDgZzntbxUGcQMrTBpxv90NS6ZX78hxn5pw>
    <xme:BCzpZt1GRGpJvwBmI9OX55CXLlKhHc05zt5ZZcL3Y28iWmKmB63qOQz4aWpGdScQf
    bM6lRPnjwLeD0pHWw>
X-ME-Received: <xmr:BCzpZkoS2YccQcGTPh6afo3zr-KtdJAXxtmxSeDbzvXTWFdgGtKfLqw2BzBdrhjNiY3IcF2zRKUJVbjqWNStJHnHEvVkOdvRJkt7XLzhmyWJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeljeegveegffduje
    fhveehhfejgeekvddvleetkedtudffieejudeiudffveelfeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BCzpZqmx9iryDx0ViNwSugUFjnsHNQ4erTAriAMnkEUqUPrUbT1ZWA>
    <xmx:BCzpZk0_t4DN9qh8v5pL4YL1VNQf-S2MHqaxpY9Blgrt8O_aoFZetw>
    <xmx:BCzpZhu-xxIct0tr7gOqpn7Y43Umjt2irGNVtib65L2lWc_L7gqJig>
    <xmx:BCzpZgXFWZHW13nU-5CIKsbomAI_seq6P_J-YlxEpcoWUzErNgCS2g>
    <xmx:BCzpZh_p6IFoW8uTFbJQTDVNU_5Uo19PXN-jeUztXW6VJq6VS7M7_-hi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Sep 2024 03:13:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5e7e92a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Sep 2024 07:12:47 +0000 (UTC)
Date: Tue, 17 Sep 2024 09:13:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/3] cache-tree: fix segfaults with invalid cache-trees
Message-ID: <cover.1726556195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this small patch series fixes segfaults that can happen when the index
has a corrupted cache-tree extension. This scenario is covered by t4058,
which documented this segfault. I've noitced that this triggers the leak
sanitizer, so I've decided to fix these segfaults now and handle them
gracefully.

Patrick

Patrick Steinhardt (3):
  cache-tree: refactor verification to return error codes
  cache-tree: detect mismatching number of index entries
  unpack-trees: detect mismatching number of cache-tree/index entries

 cache-tree.c               | 102 ++++++++++++++++++++++++++-----------
 cache-tree.h               |   2 +-
 read-cache.c               |   5 +-
 t/t4058-diff-duplicates.sh |  19 ++++---
 unpack-trees.c             |  12 +++--
 5 files changed, 97 insertions(+), 43 deletions(-)

-- 
2.46.0.551.gc5ee8f2d1c.dirty

