Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865B26D4CD
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155910; cv=none; b=Ixq21XxtUixUDtYlB0B4Ge0gX6eAuyEa4nirj2SaSToWpHlvoKUwZS8H38216uim+NhCOBvC969DoHscY0FirQtBStw+GkKd9VonIVGepG1q3a9fvr8kuX8wlRUwgDdYhvknnrVx/s4U8k1GWnAMnpjSjQyLQHywi02+V0OJOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155910; c=relaxed/simple;
	bh=L2SWVEguSoTTGKW323Bk3S2xDVmLgOfeixuAGPsyabU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o1+Yi9wnFXZccIc3OF4kK0v35Mo2fYct3ZJTwB9mzdbuKLtRA8CoOPN4vVHkEudncX4+PaDLFC2XRqvw8UvtiltDomGkoWx4fG+lqCNnJcOzuG6JhdMC1UCdLlgKcWPay+xeQaFVMvtr40C5CzNftfMFQCV2h6p6QLUzVsYHEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JGN7Sn7O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3tMf6Qt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JGN7Sn7O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3tMf6Qt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B919BEC05A6;
	Tue, 10 Mar 2026 11:18:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 11:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1773155907; x=1773242307; bh=rdRpnVENIQ
	OfBiPmaih1Rd7N+ECgB2DoLsOAP8uyXF8=; b=JGN7Sn7OowvkfIJP9AE2rI1eXS
	BymqfgDjlHeOhIHh57SEIGWbOJuWTdJaTJiTuXtOv0wQkAWfn025WiRBbQc/LdI6
	AF6rLEs59s7yGKNx5eD3FrmjVG0SvUMMcgqvMsL60YjEfKODNpoeJm/J9dn9HjU2
	Xn9wNNw3r53SRbmfwm+HxmqXoE6v6kn6ahaQoB+PCiR1cjsxmIQgA6gJFOGlofwW
	LlBd2i+/jngdlpHPPdzYL525oRDOb+u5lcC0Vct/odtuG1AOqg9sv5q3et2Zj0UO
	/UFqTd2/HtTEFWdu8EEpeRHCb7cqJAV/BdHz29yn9LZI8ppBZbNCZriOAn4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773155907; x=1773242307; bh=rdRpnVENIQOfBiPmaih1Rd7N+ECg
	B2DoLsOAP8uyXF8=; b=k3tMf6QtaQgLgze1UCtYRyOcT11iH88HPZdMXVZ+Sxxv
	1X+FVZIspDgPEagYZGbC9S14UasmlOv8PySOSqTnqRZA0JS7l5MjUSNMm0f05pjE
	TvwXyoL/aPc1nF9ri2bSn5iiYVU4MJVWHGvOVrwNxbfHrlAXO28faw4P63kvIWmA
	8bpwv6nBzARjTjQwhwcXD1nFDeNF1eIfYxJ7J1ROax/8vuBCa+v7hvVWYXCbAeNS
	+uhQBadep/EQzykBH0to6l6ZD/GehxTzGgzrweph2X/zxr99SliItFXMACoSwyzA
	NipXO4g555Qg/tu/3xeueAkMlEqGPiyZpaYotqsLdw==
X-ME-Sender: <xms:QzawaVhNiX9WUjrBFRTWZAId99Sjz4YXWpgnvluNSnwZMuObxDQB8g>
    <xme:QzawaQCeph4dwGoZ2JbDDwYEbm-u118BhtS7Bg9D6u0OD5mVm2MIY680l6WW1nbsl
    5UJCP0Zlhll8nkdEtblhXMdh7oztPiR-hZmV5PAdFsV6S-ytm0puQ>
X-ME-Received: <xmr:QzawaSs8LpuDW7jNMkE9GsBdVKXhuTzZLBoXRBDiOcizLCPidKKwznWQBThjG_CpHUDc3uRf8jNQxQPYV7GpoH-JWSi1MdxeYtrKV3jJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QzawaVaJPIbTMgT_ShACBQ9Jh_Q3IlsyAqzT8xYC4NS7VJS76KRoFw>
    <xmx:QzawaVU7OKSl8d_7mgxLVWnRivpK3Y4wXn52l2uKsChTYVuuPl7EpQ>
    <xmx:QzawaZ6MM3eyhz7FxY77lWZ7CMTfVa4AigURaBFyPZfjTQkDeywGpg>
    <xmx:QzawaQiGhZJWpE-XmvJG5QkXybTE4IWe19lJlwXgnCJVFQmWbsu1CA>
    <xmx:QzawadQKgQojr68nTRtxn2eFUtPt8TST0QpWy7A9nx21fHEB5x-UDd9d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 11:18:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45d299b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 15:18:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] odb: introduce generic object counting
Date: Tue, 10 Mar 2026 16:18:20 +0100
Message-Id: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD02sGkC/x3NwQrCMAyA4VcZORuYoXTqq4iHNUtnFJrRbCKMv
 bvF43f5/x1cqorDrduhykddrTScTx3wcyyzoE7NQD3FnihgCri8HW1K6LZVFmTbyoqWXsKrYxi
 uWeKFOMcMrbJUyfr9H+6P4/gB4QVf9HEAAAA=
X-Change-ID: 20260224-b4-pks-odb-source-count-objects-479fe682cf6f
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this small patch series introduces generic object counting for pluggable
object databases. The series is built on top of d181b9354c (The 13th
batch, 2026-03-09) with ps/odb-sources at d6fc6fe6f8 (odb/source: make
`begin_transaction()` function pluggable, 2026-03-05) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (6):
      odb: stop including "odb/source.h"
      packfile: extract logic to count number of objects
      object-file: extract logic to approximate object count
      object-file: generalize counting objects
      odb/source: introduce generic object counting
      odb: introduce generic object counting

 builtin/gc.c                | 44 +++++++++----------------
 builtin/multi-pack-index.c  |  1 +
 builtin/submodule--helper.c |  1 +
 commit-graph.c              |  3 +-
 object-file.c               | 57 ++++++++++++++++++++++++++++++++
 object-file.h               | 14 ++++++++
 object-name.c               |  6 +++-
 odb.c                       | 37 ++++++++++++++++++++-
 odb.h                       | 76 +++++++++++++++++++++++++++++++++++++++++--
 odb/source-files.c          | 30 +++++++++++++++++
 odb/source.h                | 79 ++++++++++++++++-----------------------------
 odb/streaming.c             |  1 +
 packfile.c                  | 48 +++++++++++++--------------
 packfile.h                  | 16 +++++----
 repository.c                |  1 +
 submodule-config.c          |  1 +
 tmp-objdir.c                |  1 +
 17 files changed, 299 insertions(+), 117 deletions(-)


---
base-commit: 2247f478a898a7f8f8322cc51bdeb1cc773d8f4a
change-id: 20260224-b4-pks-odb-source-count-objects-479fe682cf6f

