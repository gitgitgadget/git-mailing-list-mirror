Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267743AB2
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162705; cv=none; b=gnYOHywC34C/k0DVT/nXkZ1lWAqOucIfxvbVIrQwxBPv0tjk+sbbCct4Iv3tgVIEQ9kRw98Ub1U1RJRO8G9DzF4eCfeGhP2RrD3rKcWJAGWq5/WapDR11aEBh2Dw9VKsfSwzormLxyhftJOK3kQb5i2Tr5fsH4vcyNwc/coUuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162705; c=relaxed/simple;
	bh=IavKdE/LvRk0dzdc0UPk1fVNAR7dxmW2E7mzPHVDBJg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cNTMn/8flSKHRK4zT2sX5xJIaHv/lF4xnTG14kal6f3/FuiL9imcyumNV1DxROP3eDONwumTIElQM9aT8hi1w7xvKVD2g5EHcwCaQaZmpVPaJXlA6kxgCYTTuNg/N+IH16WEioyA/niWJ1riRbnMQYuwWYI2WcJE7MmyfnKcZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B9XJL1ON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1+nJ/rq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B9XJL1ON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1+nJ/rq"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 88BF51151A89
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 20 Aug 2024 10:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1724162702; x=1724249102; bh=eZnP83btJX2hX69aeEl2jQqlNfJbll8t
	Wycpsv8hS7Q=; b=B9XJL1ONk+BrmZQtuqO0sjQgl1UMYTpIff+cepkTpKCUyTFk
	Ua3vYL2dK8y1XHvFF0C/+rKeiL6P3QUmiG63c3VCU5i6VQoRQ7QpIzwrmVol1gFb
	Dvw5kcJmAeM1s84wsGufBnEfcMPAGkrpif2r04VDrrLToTHiP/5aHKhe5l+QxWet
	QtYv67N391yBbouocsYR6Stvs5C2T6g+/nQxq2eZmpeHVqsRSLVtjGVlSQoD+Nee
	Qb9cAU5Y5tFYB8bqCvE4eR02nRR0IsHQ1rdWz9ygGj6PeY//BgbBa0lhtoUrqfKJ
	/QrXJG5DI71z5GDRRxbMN6HlaG/WIiZlkrjYxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1724162702; x=1724249102; bh=eZnP83btJX2hX69aeEl2jQqlNfJbll8tWyc
	psv8hS7Q=; b=G1+nJ/rq+UlWn5u7YItk0J2iKCuOXrSiXzjz/OD0QHGUThB7aH6
	ywhgipN86q2v4jvPaNJGR5H/zgyzlNiMxfIk1hjNA6iHOPpVJgngdA2rf7hXX/Hd
	V4AmwbqV+4gz9Zxc0nQPB9gwOLYcQyYoUSG/oC3zRDFdlw//mjPC7pmlKRiEOwbe
	GrxSL7SUmn2I8YcBCm3mZMpgKSjsn+/2O79aPNm7MznaSrtUwiOMm1PvBepHsDlt
	5GpmVrtPzjROWJo0tPf+WN1M/q99hGfbOyWTkZUMYqK+V296dJOvVMwhbmonS6re
	BA5nzL9sBejipLtHEm/FwzamL4/gn1GWlHQ==
X-ME-Sender: <xms:jqLEZtKjJUnV1kNk6xD3P2_pnHZ7018svC4SRXZ5AFHT3G0fjHzmeg>
    <xme:jqLEZpKIw1_kHMGyaR2pQj5-Y3vRda8WtrizYuRlOPqPV2PYgLsbym-R_SwcixgCR
    q7iP9Ako-t4Qjptbw>
X-ME-Received: <xmr:jqLEZluq7OzU09C0mgZma2-OY8-Wmhv3YlM_8r6V1tPXs676wNhuRj1M_afrSJg3RnMKiSk_DsibbPzGi6lgYqp9KtqDaZThxioNeyqYHYvEVb4HNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghr
    ughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleehkedtieetfeeiff
    egieevkeejhfdvkeetjeefkeetgeejleelffeftdffgeeunecuffhomhgrihhnpehhthht
    phdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jqLEZua2mbxZgI4Qvq9d7I0UrcToWhoAzCGtTYMEXyIB7t14a7zH8Q>
    <xmx:jqLEZkZIEbSk6haEKtcYrp0kZ0uRk-5J7jYy_KXb13Cler_csutg1g>
    <xmx:jqLEZiBGuQewY7oTcbwwlYNTjVLNFRk9oOrDQW2jrqkb2MI3Qc1dng>
    <xmx:jqLEZiYtAZfRK9iYjbueUUqwioFDgdiZLsi_cTTnZrtnw83LOg5upA>
    <xmx:jqLEZvx4_ixnePEqoRANoczpIXA0L1DRNNkm8nZjkERjOOFTiEt8rBg_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1bc4335e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:30 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:04:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/20] Memory leak fixes (pt.5)
Message-ID: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

another week, another set of memory leak fixes. With this series we're
down to ~128 leaking test suites, down from 359 before starting with
this effort. So we're about 2/3rds done. Naturally, part 6 is also
almost ready.

This series is built on top of bb9c16bd4f (The sixth batch, 2024-08-19)
with Junio's ps/leakfixes-part-4 at 77d4b3dd73 (builtin/diff: free
symmetric diff members, 2024-08-14) merged into it.

Thanks!

Patrick

Patrick Steinhardt (20):
  mailinfo: fix leaking header data
  convert: fix leaks when resetting attributes
  pretty: fix memory leaks when parsing pretty formats
  pretty: fix leaking key/value separator buffer
  builtin/merge-tree: fix leaking `-X` strategy options
  builtin/upload-archive: fix leaking args passed to `write_archive()`
  builtin/archive: fix leaking `OPT_FILENAME()` value
  midx-write: fix leaking hashfile on error cases
  builtin/repack: fix leaks when computing packs to repack
  t/helper: fix leaking multi-pack-indices in "read-midx"
  transport: fix leaking OID arrays in git:// transport data
  builtin/send-pack: fix leaking refspecs
  sideband: fix leaks when configuring sideband colors
  builtin/fetch-pack: fix leaking refs
  remote: fix leaking config strings
  remote: fix leaks when matching refspecs
  remote: fix leaking peer ref when expanding refmap
  builtin/fetch: fix leaking transaction with `--atomic`
  transport: fix leaking arguments when fetching from bundle
  transport: fix leaking negotiation tips

 archive.c                           | 10 ++++++
 builtin/archive.c                   |  7 ++--
 builtin/fetch-pack.c                | 20 ++++++-----
 builtin/fetch.c                     |  8 ++---
 builtin/merge-tree.c                | 13 +++++--
 builtin/repack.c                    | 36 ++++++++++++++-----
 builtin/send-pack.c                 |  1 +
 builtin/upload-archive.c            |  8 +++--
 convert.c                           |  3 ++
 mailinfo.c                          | 17 +++++++--
 midx-write.c                        | 24 ++++++-------
 pretty.c                            | 13 +++++--
 remote.c                            | 55 +++++++++++++++++++++--------
 sideband.c                          |  8 +++--
 t/helper/test-read-midx.c           |  8 ++++-
 t/t4150-am.sh                       |  1 +
 t/t4205-log-pretty-formats.sh       |  2 ++
 t/t4301-merge-tree-write-tree.sh    |  1 +
 t/t5000-tar-tree.sh                 |  1 +
 t/t5003-archive-zip.sh              |  1 +
 t/t5100-mailinfo.sh                 |  1 +
 t/t5319-multi-pack-index.sh         |  2 ++
 t/t5400-send-pack.sh                |  1 +
 t/t5401-update-hooks.sh             |  2 ++
 t/t5408-send-pack-stdin.sh          |  2 ++
 t/t5409-colorize-remote-messages.sh |  1 +
 t/t5501-fetch-push-alternates.sh    |  1 +
 t/t5505-remote.sh                   |  1 +
 t/t5510-fetch.sh                    |  1 +
 t/t5519-push-alternates.sh          |  1 +
 t/t5536-fetch-conflicts.sh          |  1 +
 t/t5548-push-porcelain.sh           |  1 +
 t/t5553-set-upstream.sh             |  1 +
 t/t5574-fetch-output.sh             |  1 +
 t/t5703-upload-pack-ref-in-want.sh  |  1 +
 t/t5812-proto-disable-http.sh       |  2 ++
 t/t6050-replace.sh                  |  1 +
 t/t7704-repack-cruft.sh             |  1 +
 transport.c                         |  8 +++++
 39 files changed, 203 insertions(+), 64 deletions(-)

-- 
2.46.0.164.g477ce5ccd6.dirty

