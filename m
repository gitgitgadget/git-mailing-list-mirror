Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CB1A0AF5
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677359; cv=none; b=gweaCoO2P548HPrjkJgVjS1Viy+9bqgx27p/E+S7E26f/mHbqus51OWTle0BPGhheYAuQc6fV+NnF2yHIQUQVWhImNDAH2YC8Vyh71BPti32OM0jLkkJ6gDb22gTUF/2dfC3n0XbhHvyXrieuWGMTFOmaCfISPornndDRFU3ZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677359; c=relaxed/simple;
	bh=4++g0AsU8hefztBbqxxw4uWmbjFiJQCIV68UBWuXldc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D+utJAKxghMftbyGTW/r8fEruCIdzeq7DSCJdb3j0bBa1fK8nT58xVf5ON8ugxnpfAUyF4gh4sBqYeveEBrdqxmQu7wut65uuOmZewnRNRzlwh/7TOJKo3PVYbq/2nRzGTnZOnnuUor/cKBEslfl6k8mogyKPtCPUI2xxXCg2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1scGr5nT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UmNVlbTW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1scGr5nT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UmNVlbTW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 016601380766;
	Wed, 23 Oct 2024 05:55:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 23 Oct 2024 05:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1729677356; x=1729763756; bh=kmm3DRgdyRGg/Si3B1nhxSvVLSWF1Efm
	tG71gCSrXqs=; b=1scGr5nTiF5GdeoRRjv//p3FJ0dg47L5EPOd/uAyM3gRXwRr
	zXHLHkl0cg3v20NaofpryjzLbpTLL469XpfQMTFfselZVn2gYAazELlRACe+E+j9
	25CB176UoxA1zBcThrpwNJkAG0+HuTV+A1LN29DAwR9/Jb53ZUwBtr8NzbQFOqsy
	2YGNt4oSDFHU6m//xLux0w3+lN0JG+MRgwyGL45Xzp5izimmgw2yAVxuvFpqsFqS
	/jqq7PiA7UkW5huieoytiCvHEZVDck9rKcdD1cVCvdF4eVgEjxfmp+T25u9h+rRC
	OZjSxhwZoLbz6FcCzmNaZvxIadoV/ZsolAUhgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1729677356; x=1729763756; bh=kmm3DRgdyRGg/Si3B1nhxSvVLSWF1EfmtG7
	1gCSrXqs=; b=UmNVlbTWfwc5QP/aX1VHdaqkv9+ogK0K0PgRibroOEsO/VtgDlK
	VTpWf9x6YuDUIQTw7FK4knwMRAmFhhCCyEScU/92ObEQmeXVNsyl7UT5JAuEN4Vy
	I9e5HACeiLBYY08Ttqu/3OrnU0F88Ne5Xr7GqWTXiv+lucBtaNZfBXgmO8et34Fb
	A4bZlpOwOlmC7cENub2BIAdh2ODdMq0m0pY10eqxpGUFrSoR2+p3IK6fvbpv19C5
	ZbrkeCAMNxtvZN9jze4m+rJt62wZGS8ZYKogNphjdIQLniDZfK90znop2walJiiM
	ELknD/nliwgdZqxHfE3JVqywzYQ3Rvc3uIw==
X-ME-Sender: <xms:LMgYZx2f-2Q0tX5GPaq5lMsjjGgG5h-jFguZe0U8SzrpYnTkko_2YA>
    <xme:LMgYZ4HpyCwsyoTdSoPOsfFHMk18XmzaR0JfQZ0TM_rPt5L-JwTPkal-rVHW-LfjT
    T-LkrrY_ByLf8GIqQ>
X-ME-Received: <xmr:LMgYZx6qoaswQZP4C-s-_hBqYzeU0r8BKMcoZ0B7vLaqA2-KEHlA8kT2r_BVBBYfzj_tr-1eGFM4DqZ8ir_SLbyR2e9YqB-8TbFyyF4O3RiD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepieeuvdfhteetlefghfehtddvheelhfdtfffhhffgleejfedv
    teefveeltdeuiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:LMgYZ-3ON29sgNHWCU6iGXsn9mWynmlzG-4bljZS15E1z95Mz8HNog>
    <xmx:LMgYZ0HNawMbY8_Y8u2Pe50BqfUIQYr2JuL97rPbFMwmmsxzWnsiNg>
    <xmx:LMgYZ_9mIWYt_ZVY7EOjz80SFrUMCCRGBpuSe9VfdkUx6hh2CkPwzg>
    <xmx:LMgYZxmGcwbWQId4Qx_vw9HQvNgJgANu93pNJLAfYkCf-YFRncSlmg>
    <xmx:LMgYZ5ThkCt98xk8TTD9lRkZyoLH9-qqiPnvY3omLzujQsMDCoAxDOMV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:55:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a42057aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:24 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:55:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 0/7] reftable: stop using Git subsystems
Message-ID: <cover.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch series is another step towards detangling the reftable
library from libgit.a. This step removes all uses of Git subsystems like
"hash.h", "tempfile.h" and "lockfile.h" in favor of either providing our
own infra for this ("hash.h") or by implementing compatibility shims
that bridge between Git and the reftable library ("tempfile.h",
"lockfile.h").

This is the second-last step in the overall effort to detangle those two
codebases from each other. The last step will be to split out POSIX bits
from "git-compat-util.h" into a separate "compat/posix.h" header that we
then use from the reftable library such that we don't pull in any of the
Git-specific parts into it.

This series is built on top of fd3785337b (The third batch, 2024-10-22)
with ps/reftable-strbuf at 20590cd287 (reftable: handle trivial
`reftable_buf` errors, 2024-10-17) merged into it.

Thanks!

Patrick

Patrick Steinhardt (7):
  reftable/system: move "dir.h" to its only user
  reftable: explicitly handle hash format IDs
  reftable/system: stop depending on "hash.h"
  reftable/stack: stop using `fsync_component()` directly
  reftable/system: provide thin wrapper for tempfile subsystem
  reftable/stack: drop only use of `get_locked_file_path()`
  reftable/system: provide thin wrapper for lockfile subsystem

 Makefile                            |   1 +
 refs/reftable-backend.c             |  19 +++-
 reftable/basics.c                   |  13 ++-
 reftable/basics.h                   |   9 +-
 reftable/merged.c                   |   4 +-
 reftable/merged.h                   |   3 +-
 reftable/reader.c                   |  14 ++-
 reftable/reader.h                   |   4 +-
 reftable/reftable-basics.h          |  13 +++
 reftable/reftable-merged.h          |   4 +-
 reftable/reftable-reader.h          |   2 +-
 reftable/reftable-record.h          |  12 +-
 reftable/reftable-writer.h          |   8 +-
 reftable/stack.c                    | 171 ++++++++++++++--------------
 reftable/system.c                   | 126 ++++++++++++++++++++
 reftable/system.h                   |  88 +++++++++++++-
 reftable/writer.c                   |  20 +++-
 t/helper/test-reftable.c            |   4 +-
 t/unit-tests/lib-reftable.c         |   5 +-
 t/unit-tests/lib-reftable.h         |   2 +-
 t/unit-tests/t-reftable-block.c     |  41 +++----
 t/unit-tests/t-reftable-merged.c    |  26 ++---
 t/unit-tests/t-reftable-pq.c        |   3 +-
 t/unit-tests/t-reftable-reader.c    |   4 +-
 t/unit-tests/t-reftable-readwrite.c |  41 +++----
 t/unit-tests/t-reftable-record.c    |  59 +++++-----
 t/unit-tests/t-reftable-stack.c     |  37 +++---
 27 files changed, 504 insertions(+), 229 deletions(-)
 create mode 100644 reftable/system.c

-- 
2.47.0.118.gfd3785337b.dirty

