Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC033C2E
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956417; cv=none; b=WKf1+/AX4gHGpbJRn1+iZvKmNV1FuxHMlgzk90wk/YEkdDC2GCIxMKug9MUGzmQNuGtxfgbPDvmzhRFRgpPttIbQkseyRiETU2hHgykj5MSGVzd2p4ctIyxT9fN8gcQCLcCXSkgj3SdZF38W62C9OxuCYYWlDW73WgNvkdlo9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956417; c=relaxed/simple;
	bh=vwRzzdbdtVcynWkZv90/RXInmkQOo/jP6+v8dMrebxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CWgYP1v7H/nAYZc2dy0NkBVBjefVIRCTiKUdvYrtMkGvGtjlqWFVYmLLJqGCgwau5SEBW5pF3nKgCNNdWhfIR/dZ7EEmBBvUfwdMGIDaH8vNvLv4ypsc2/QYCfCr/HtXL2ab8dAVxJIjc9fsn983bVTrEISkkuV+gjqi/P2Hy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ALyOGHNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uKGlONhx; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ALyOGHNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uKGlONhx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CBA5CEC008B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:26:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 07:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1774956414; x=1775042814; bh=eXVuwrzVaD
	mpYIIe9Ksx3skcd3gp6C5pggr3BK+243E=; b=ALyOGHNFbRA/1Amgi6ZC2DRy4W
	Mz1lyJCvSvoxKLHmvctygsMoYw6Li9GVODrKICPqe1yE0XECYXVmTALfUDUHYgzi
	cUnPMbLcoXmfgp1x1C1k7iiNxKcmWEteeuc7+o/bjIVKnA1vLel5ez/3INOgfn0O
	c/oMTaT0U80hQOZ1blTW63GWvFe0wRV7Fyq5QsZb8fqr+1tE1pQ+G8rip8CtTb46
	ZEXQLaR5jyHxUgMKIGFYtbGOSSSmjcewffwgBf7oepju+LRGyH9IUYVzYxT9dPfC
	8VcQ5Y4eDcU5BpUL58N7w/ZSZqQd74GiKweOp2PknHY5jR2YzFdcifyrWGAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1774956414; x=1775042814; bh=eXVuwrzVaDmpYIIe9Ksx3skcd3gp
	6C5pggr3BK+243E=; b=uKGlONhxvbqr8nvELhggnbwRDMLO+JWBEd6raBSLSeOy
	K+C+Xh8PfH0p3bW6lSyCucvOpwC9bWu5InUQW5V86RbHpuTdl/viG2js8RQGntCw
	HM69YiLR12gmTQdFCT8r0HTMbqcHVKzu9i/bJdCDP9nRNqdJV0y6eTZrPnhGxRg6
	B9ulwNGuLxa6y5i2JuO0iaMmVM/h9enkSeQRPLrMMXyIKCfKu6YZBdWYhi6OlYB5
	XGcV+4wFD2tMEIw8vrp8NViHZs419PPd6hjh7cT1OseyOwjCR+yUAyaRVsfLYIHL
	TXtdyy68KoO6YZzI6o7VAJ3O7OmrL03BWFVZkPPKNw==
X-ME-Sender: <xms:fq_LabPqwUmT-_MAYn4gf3EFCg55Fug2gLpfcORfEcM5aEQC8SJ6FQ>
    <xme:fq_Lac7UEd7CIAGqgcX4sOT2y_IXHNArn0JNRDCwmmicKW1m0SEs57tl9gkP3MbT1
    SGCnhfxWHuB9FwPKx0ZndesisS2PswMOapj5Cc22BV_BdemA4dB>
X-ME-Received: <xmr:fq_Laf4a0-D_wn5hc7WrKXhwDyTSwDPbeSui6SPhI74gSeQ8Mjh4TacF7JpB5Pa6FAT5Rsm52osONluHkyM_pYG_cMS-xzNEmbpoH9Tc7Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhedtmdenuc
    fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffekfedvgfevfeeikeekgffgvdffkedvudevudefvdfhteehtdefkeeivddviedunecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fq_LaU0zwPISVbkWduyHur29ntZxU72Jh6ldGehLJgsKmethjrMjyQ>
    <xmx:fq_LaTX7Dbw67wJLdldc0UZL9FtDDqdTm_9PAPZCHy1qljHKIulssg>
    <xmx:fq_LaX6ALO57Ix02inziqMtBxtYGD_0mWgaopA_pn_K_WvFjkOOuxQ>
    <xmx:fq_LaSLziiuZ4pM6euoqvQTzwx0rqfq5cNOXYkApDUsfgXChx-lSCw>
    <xmx:fq_Laf_vC6QVowLFPw-BjtZZMCuKEA_6M-WtZ0sNYrdr2USheJucN2He>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 07:26:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0c21250 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 11:26:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] reftable: some more portability improvements
Date: Tue, 31 Mar 2026 13:26:46 +0200
Message-Id: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHevy2kC/yWM0QrCMAxFf2Xk2UBNYWP+iviw1nSLjq00VZSxf
 zfDt3u4h7OBchFWuDQbFH6LyroYnE8NxGlYRka5GwM5ap33DvNTsXCqQ5gZ81psyCz1i0k+rOh
 bDqlPRF0ksEg29ziscb39WV/hwbEeVdj3Hxvgi1yCAAAA
X-Change-ID: 20260330-pks-reftable-portability-fixes-36ebf9f227c2
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Hi,

this patch series contains the last set of portability improvements
that currently sits in the reftable implementation of libgit2. With
these patches merged lbigit2 is able to fully reuse the reftable library
while only having to provide its own system headers.

I've got a test run with libgit2 at [1], the code in Git is tested at
[2]. Overall we're quite close -- the pull requests to implement the
repository extension and to adjust handling of pseudo-refs have been
merged. Still missing is a couple of test fixes, but once those are
merged the reftable backend itself will be in review.

Thanks!

Patrick

[1]: https://github.com/libgit2/libgit2/pull/7117
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/535

---
Patrick Steinhardt (6):
      reftable/system: provide `REFTABLE_INLINE()` macro
      reftable/stack: don't call fsync(3p) unless provided
      reftable/fsck: use REFTABLE_UNUSED instead of UNUSED
      reftable/system: add abstraction to retrieve time in milliseconds
      reftable/system: add abstraction to mmap files
      reftable: introduce "reftable-system.h" header

 reftable/basics.h               | 20 ++++++++++----------
 reftable/blocksource.c          | 19 +++++++------------
 reftable/fsck.c                 |  2 +-
 reftable/pq.h                   |  4 ++--
 reftable/record.h               |  4 ++--
 reftable/reftable-basics.h      |  2 +-
 reftable/reftable-block.h       |  3 +--
 reftable/reftable-blocksource.h |  2 +-
 reftable/reftable-error.h       |  2 ++
 reftable/reftable-fsck.h        |  1 +
 reftable/reftable-iterator.h    |  1 +
 reftable/reftable-merged.h      |  1 +
 reftable/reftable-record.h      |  2 +-
 reftable/reftable-stack.h       |  1 +
 reftable/reftable-system.h      |  7 +++++++
 reftable/reftable-table.h       |  1 +
 reftable/reftable-writer.h      |  4 +---
 reftable/stack.c                | 29 +++++------------------------
 reftable/system.c               | 26 ++++++++++++++++++++++++++
 reftable/system.h               | 26 ++++++++++++++++++++++++--
 20 files changed, 96 insertions(+), 61 deletions(-)


---
base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
change-id: 20260330-pks-reftable-portability-fixes-36ebf9f227c2

