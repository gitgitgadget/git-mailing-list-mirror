Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0DE172BD5
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519701; cv=none; b=E+CgyqcGLfmHRPI0XY1Yiy7E2rFecNFPej+7zxgO8tJYRzFfpM3baNcidk3fLkZScakMBB6wJc8ha7C+qz9H3H/cX8YaOaBLLX2pvtICoAC9c8dKn9cPGtdSpGNlzLOpicuMzA6wQ7k0rdYqtPvexdBjI37jYCBMYxHFLjXnMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519701; c=relaxed/simple;
	bh=AnEHNaK3poB9maNqpMgRaf/t8P30ctfS33XJzK5mBFU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B2aaWydfZXaNO7LC7/DBOj/aUIJmveIgfqEby+kVyDX0WesY9wp2DuxhVYCZrQ+3ilOUTP9RX6VIH2mxstVfUTmXE2gU+h4OuUED4Xje4OreBa+1JnJRyov8RgjQeO6uMwt2D5Q1CpZqbbbLo1jYQE0FSq9Pp95g6TZ9IF02QVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FVcXj3Ji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mGRUSPUR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FVcXj3Ji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGRUSPUR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA03A1140143;
	Tue,  1 Apr 2025 11:01:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 11:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1743519698; x=1743606098; bh=XuGIuZiwEB
	tdHdTI7Pa2q7gbMb/rglY8r16wReVkhWE=; b=FVcXj3Jil3s6unnzrr9i332DpK
	yHQgvtQvXzIbU1tAZJ4f58TNHgWy+wYHl0670lmAB9iSnV9Hgh8eIbHxCpW8ilyp
	PjsQ5QwwEKebokrIkW6hRD41tn2lwtoeldEUopz2G2NJGSxw7JjHVJuuG/QT3aPM
	thADSWtteDOY57fLRa4c6m4mQzCbrAu1XOIV/6Xpe0iyYEKIt8/JVo6Mb5VSXa2i
	9qKUjw4+eedy0d36MC9GzcpcrWlzlWf4vyqw+l3nKonJiKW50l+gWbO264UanRe+
	z50jQFQxQkKXLFV6BpRazhG57bAwudeXpNz0a1LPYks6t4U/1ud8VNCCBmZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743519698; x=1743606098; bh=XuGIuZiwEBtdHdTI7Pa2q7gbMb/r
	glY8r16wReVkhWE=; b=mGRUSPURqqLapNm5gax4G2YOwp8eszSAl/TGW0q06NZl
	yNou2tfCB5HJeChSrEREy/5qKbrbeHYogXvRhlPoD4Jfh1UTN2tVsxVw0TTjHbL3
	Eyks4+cdiBHlV0+IVNm7yEzSm1MHyKgzq8VcfFsZ1dXWu4UfNbvC5E13IrLYUOrY
	cJ3j0TTSNb3JhDV/G07YBmOuH4h1rDBdBXYz4oSznmQ1SswWG+wofk8Wq5OIbv5n
	AvY2+yYKYY7msqaqIj9Pp2O5bdmFpq0yzfCCkVEGYt3a7gDxFJ/mRQDFSi1JHArv
	+1sKe2nBwnDnEkQbjK9UY83XqErA8M5kRzWKORausw==
X-ME-Sender: <xms:zP_rZx5XmapNcMyPBEzbPwh-kJtn983Z27hV2CIs-CVOtjp0acYFPg>
    <xme:zP_rZ-4nLQNCqyKEIOxZpemodrUCuQADv6ZWymVH32x3WkSnAZJnMHjGzfRwDolJD
    dpy_L7Qmc_103zdIQ>
X-ME-Received: <xmr:zP_rZ4cs4hZbZmBRfDPkReuD6Wa4fAxwt7sGC_9N3gyfjJBlCHjK2rxPY5DLwbnXb226sDRH8vtGp_-VgFXy-7vAqWFYQ82Ozq1VpuFaF1lfxKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueeh
    gfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehsthholhgvvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqd
    gsvghrlhhinhdruggv
X-ME-Proxy: <xmx:zP_rZ6KrpVXULMnvG04qEXQ_QtlMMCPvTzcuSP9PuthHTLWWH-4g6w>
    <xmx:zP_rZ1JkWUHUrlB9UDjT0_e8rTvGfdAmOmv-KaJ8lcF8dqmBGId6jQ>
    <xmx:zP_rZzz_rzsENxpwzwGE_cfLeYSkea9NLI8gSoXxXIMXLltg6lf_Cw>
    <xmx:zP_rZxImLU_H3OZCf9qTnyy4ucgLSWtfOO4r3vxufEnIhEzV7pKgAA>
    <xmx:0v_rZ6qJCHNKI_wS-Mt-cTSNoSBHYiRb3L8HdO5pn7gWTu4r9a-dXpjh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 11:01:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b999b054 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Apr 2025 15:01:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] parse-options: harden handling of integer values
Date: Tue, 01 Apr 2025 17:01:15 +0200
Message-Id: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALv/62cC/x3MMQqAMAxA0atIZgNNqYNeRRysRg1CLYmIIN7d4
 vjg8x8wVmGDrnpA+RKTIxVQXcG0jWlllLkYvPONC44wBsy7YR7VGI98lt5Q0skrq2EbQ4zT4sk
 RQXlk5UXu/98P7/sBfz/EMW8AAAA=
X-Change-ID: 20250401-b4-pks-parse-options-integers-9b4bbcf21011
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Hi,

this patch series addresses the issues raised in [1] and [2]. As
discussed in [1], the series also introduces a couple of safeguards to
make it harder to misuse `OPT_INTEGER()` and `OPT_MAGNITUDE()`:

  - We now track the precision of the underlying integer types. This
    makes it possible to pass arbitrarily-sized integers to those
    options, not only `int` and `unsigned long`, respectively.

  - We introduce a build assert to verify that the passed variable has
    correct signedness.

Furthermore, the series introduces `OPT_UNSIGNED()` to adapt all
callsites that previously used variables with the wrong signedness.

Thanks!

Patrick

[1]: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
[2]: <Z8HW6petWuMRWSXf@teonanacatl.net>

---
Patrick Steinhardt (5):
      global: use designated initializers for options
      parse-options: introduce precision handling for `OPTION_INTEGER`
      parse-options: introduce precision handling for `OPTION_MAGNITUDE`
      parse-options: introduce `OPTION_UNSIGNED`
      parse-options: detect mismatches in integer signedness

 apply.c                       |   4 +-
 archive.c                     |  35 +++++++---
 builtin/am.c                  |  28 +++++---
 builtin/backfill.c            |   4 +-
 builtin/clone.c               |  13 +++-
 builtin/column.c              |   2 +-
 builtin/commit-tree.c         |  12 +++-
 builtin/commit.c              |  62 ++++++++++++++----
 builtin/config.c              |  13 +++-
 builtin/describe.c            |  24 +++++--
 builtin/fetch.c               |  10 ++-
 builtin/fmt-merge-msg.c       |  27 ++++++--
 builtin/gc.c                  |  12 +++-
 builtin/grep.c                |  18 ++++--
 builtin/init-db.c             |  13 ++--
 builtin/ls-remote.c           |  11 +++-
 builtin/merge.c               |  38 ++++++++---
 builtin/read-tree.c           |  11 +++-
 builtin/rebase.c              |  25 ++++++--
 builtin/revert.c              |  12 +++-
 builtin/show-branch.c         |  13 +++-
 builtin/tag.c                 |  24 +++++--
 builtin/update-index.c        | 131 ++++++++++++++++++++++++++------------
 builtin/write-tree.c          |  12 ++--
 diff.c                        |  13 ++--
 git-compat-util.h             |   7 ++
 parse-options.c               | 145 ++++++++++++++++++++++++++++++++++++------
 parse-options.h               |  23 ++++++-
 ref-filter.h                  |  15 +++--
 t/helper/test-parse-options.c |  46 +++++++++++---
 t/t0040-parse-options.sh      |  57 ++++++++++++++++-
 31 files changed, 671 insertions(+), 189 deletions(-)


---
base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
change-id: 20250401-b4-pks-parse-options-integers-9b4bbcf21011

