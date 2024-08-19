Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2577F01
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081986; cv=none; b=L6RLx8LW6+2v93qvVb5dn1eoA44gySyraDMjkBk0wVggoBcrj6L8drvfEb0IQzDKqXKwwoCEYdwRms4NsI5tP2FsCbSTYd9H4cd9duSkL8imvCRGfOETahjPlCbR6SBHVnSgEg1cbd58MOr7h6FIH5ruFhcEhBedorPF0oX4nwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081986; c=relaxed/simple;
	bh=kzMELHZpDJ0wqkrq8dzfAsvx9sZXLtkmUYX6RPS667A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r6pFKGvqVZH89y4lwxjKzXHgIm2AT2wdQIg1SaWyq37HOaZzK8uNPnQsY13bwYFVkrofr6rx/kXB0irWO3sriqJ/2aNKiGZ+1G9+x+mZYST09zZiB50tD8CjKLgrraxdc0xghkiRnF4EN+n1WJHUaMRgpHulwdG7EJhMyDSY8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pkq9scZ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUf0qHvs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pkq9scZ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUf0qHvs"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 771BA1151AD3;
	Mon, 19 Aug 2024 11:39:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 19 Aug 2024 11:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1724081982; x=1724168382; bh=+apmJ8lLpsggbO+pYxen/BkUYMXJMJV2
	lSbRz6y6hCA=; b=Pkq9scZ5Rc+DrFzRxtWYfjJK3paysqG8IBoJBpVW5oPo89SN
	mKr5cWVfP8tM4sux4z8IyX6E1b6Sqq9eYqHPqLd9qB9q8149Hof4b/iKE9Iojgh2
	4b9itQ/LQvmQWHVKt+yOIrSlkS4ntxRep6X0Cy47eJz5XGBl9/zkFkqYDsruik03
	YhrruStOfbDcvXRLtnHyeGQjzvtK9FtRClsX3G3b5ZS7SAzxJVj+jmyRutawhQDR
	bPIGlK7TBO3WqpvpRxZkJJq05WvRT2stzprs7T0qM49lYUAy2r4Bt1p5iQqEuwr/
	A3xY6J/Tp20kbQHFePPAL60RodAswNsFOCC0oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1724081982; x=1724168382; bh=+apmJ8lLpsggbO+pYxen/BkUYMXJMJV2lSb
	Rz6y6hCA=; b=JUf0qHvsz0oxC1KRW35nphhqOBVNDi2bjDGJMjZYUPLx+dE2d0j
	D1cjMfSFbz2Z274iHM/HE3XBoiROaHUDp+JQrS2JAa5JYVHrfgsHcFjr8/+dihQy
	MRYHBHyakur+Y0klV2Ky7l+AaFwBFcH3SJXs0AAXuqUI7DQlRjsgix0QxmFRf2PA
	uvvDXwp+8lTcHFWUN9SCefYQbp6pLq2AuOvpJhRhVBr0ocvEYyQho3GjT0MA7K4P
	Jnn/0O02FZpd0+F9Fd0xwVGRiqAah2zLD2JQsY+k4FnfNqgNfFY1AOv2vars6aZ9
	8rA0/yJ/rQuJOJ2jX8ue8u34Xs8bEvd/X5A==
X-ME-Sender: <xms:PmfDZkOcT8P160kTUOgtvfliPECpEaWaL67F48-wBKkM7-jw8l_yyw>
    <xme:PmfDZq_WAx9T-_THBIycgWLHa3Q8wSCGF9dEjb2zYYpJR-xXH3mcmQ_gElYidhYAO
    FUQETtL2fezOkZyhQ>
X-ME-Received: <xmr:PmfDZrT6N0pLVu2WsjD4P1Y4laxsnoA9gs5onW3ktUpDkZfF4WRxD04hi4j3yU70ONo0ks2C_OdYySPSdyaAH6MWqq-kOUmboLR0q2gt30HSz4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiuedvhfetteelgf
    fhhedtvdehlefhtdffhffhgfeljeefvdetfeevledtueeivdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PmfDZsvi5l-iNS9qCX0eYfkiCIeBGMOXl4mSeE1S2sqqV4A5lKtOoQ>
    <xmx:PmfDZse2eJ7dVK8_BGDFpWZzwYWsiTKEpHsGmXAXsg-C8yNl686N3g>
    <xmx:PmfDZg0593_DX7dAFQa1CgozQVXngVp9XUevnkbBfX3bxpTI4TuUGA>
    <xmx:PmfDZg-KHupYJhalVjtsGfAt2mgQ0FwuYtob4IlXxEWpHd7C4zaEtg>
    <xmx:PmfDZto1oye4S0qpqnPzI0eQJn3dp4w1WJ88N8txKjVGqbT5yfVw-SR_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:39:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 942e195a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:09 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:39:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 00/10] reftable: fix reload with active iterators
Message-ID: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

as reported by Peff in [1], the reftable backend fails in t5616 in a
racy manner. The cause of this is that git-maintenance(1) processes leak
into subsequent tests and perform concurrent compaction of the stack.
The reftable backend is expected to handle this gracefully, but doesn't.

The issue can surface whenever reloading the reftable stack while an
iterator is active. In case some of the tables got compacted, we will
end up closing them and thus the iterator now tries to use those closed
tables.

This patch series fixes that issue by starting to refcount the readers.
Each iterator will bump the refcount, thus avoiding the problem. While
at it, I also found a second issue where we segfault when reloading a
table fails while reusing one of the table readers. In this scenario, we
would end up releasing the reader of the stack itself, even though it
would still be used by it.

This patch series addresses those issues by making the reftable reader
refcounted. The first 6 patches do some simplifications of code which is
close. The remaining 4 ones introduce refcounting and wire it up as
required.

With this, the following command now passes:

    make -C .. -j20 SANITIZE=address && GIT_TEST_DEFAULT_REF_FORMAT=reftable ./t5616-partial-clone.sh --run=1-16 --stress

The patch series builds on top of Junio's ps/reftable-drop-generic at
1a3c3870ee (reftable/generic: drop interface, 2024-08-14). It's only on
seen right now, but would otherise cause a bunch of conflicts.

Thanks!

[1]: <20240817121424.GA2439299@coredump.intra.peff.net>

Patrick Steinhardt (10):
  reftable/blocksource: drop malloc block source
  reftable/stack: inline `stack_compact_range_stats()`
  reftable/reader: rename `reftable_new_reader()`
  reftable/reader: inline `init_reader()`
  reftable/reader: inline `reader_close()`
  reftable/stack: fix broken refnames in `write_n_ref_tables()`
  reftable/reader: introduce refcounting
  reftable/reader: keep readers alive during iteration
  reftable/stack: reorder swapping in the reloaded stack contents
  reftable/stack: fix segfault when reload with reused readers fails

 reftable/block_test.c            |   3 +-
 reftable/blocksource.c           |  20 -----
 reftable/blocksource.h           |   2 -
 reftable/reader.c                | 149 ++++++++++++++++---------------
 reftable/reader.h                |   5 +-
 reftable/readwrite_test.c        |  85 +++++++++---------
 reftable/reftable-reader.h       |  19 ++--
 reftable/stack.c                 |  90 +++++++++++--------
 reftable/stack_test.c            | 115 +++++++++++++++++++++++-
 t/helper/test-reftable.c         |   4 +-
 t/unit-tests/t-reftable-merged.c |  10 +--
 11 files changed, 311 insertions(+), 191 deletions(-)


base-commit: 1a3c3870ee1a65b0579ccbac6b18e22b8c44c5b4
-- 
2.46.0.164.g477ce5ccd6.dirty

