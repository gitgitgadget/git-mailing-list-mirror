Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2691D0F47
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058506; cv=none; b=exkq377I/CDxV8WUkXSrxqHc6+TTCoJ/7xNT5ZYRgYcV9l5VtKQ1/v8LDkGDo+VAQfsO3harFpQLNS90bEDFpQZL8REqXKuBCU2pjTrwJATtbKpHekbCjzw4sJRfpynZc9xPNU5UssPtxl6O6bizlkCcWfzZvWS4MONfB4J2Itc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058506; c=relaxed/simple;
	bh=ooZA4elBAMKIYoiazagzstzJ1ZuYjDEtj0t5YN61bOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dxZWiGNFd5s+AKZJtQ/WAmRNSVVIJb+QIdghspDB/eCbtQ/kdwM6REnucUJWwWTRk8bfGBlw72PMsem2Zm6zmndyBJTKJZrwJRqpy6BNNk0rEioxJDPPaGh1Fld4SxabWCRVSAURq/WW8LAC8Dq2ebzkbL8DKo+sfJBH42Qaqk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L3Ncir1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LojOj7BO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L3Ncir1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LojOj7BO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 58EAD1140155
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 Nov 2024 04:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1731058503; x=1731144903; bh=Tbf76HDpbI
	NWbCe3ITpQEkSwYjJ9hmUiMaOUlcWqTaQ=; b=L3Ncir1tnYR4gS0ZTRVdzDoeMM
	4BEjY5r753cUqRPgPZcdcqEJ4ORYK7TeuA4F6ZV0qxQDPWW14Z9l5uY37T67uV3D
	Qsu9uGpkQpuR/HNRjjy0ti4Iv4mpK1AW6MoowJbGFyUjMxPhfUYZPHOpF23EfnDx
	3VnDLzjvjY3bj/WGcL03JtMEh6I5utRRxScrC6uM1FW9bOBkJz3DSdKYSNtS9hq5
	/LeGsgpPEb49lXNkaAhLkuiEZcA9wgV1aLX3cMgSCPmTu/1E3Z43L6sJuuEE9b2k
	0cv2++l9uted6IJivDI0sOXyvfYSy4KvxP3Zzn3EyimDoW0BE1/0NCei4UwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731058503; x=1731144903; bh=Tbf76HDpbINWbCe3ITpQEkSwYjJ9
	hmUiMaOUlcWqTaQ=; b=LojOj7BOud0fnpS3dsKTzNtvbCdBMJ9X0QOc2H9auMhn
	ssGW4DjcVYq8wTvWlmW8ZGj+GSnX83a4g3CyJAoTVEpJjK/1D+H6vDytYXG6lu4V
	7mdBtEXWD1BAEGEcKOARfERiueHVZmqvrlzHTSQUK6cEbe+E0kQ4LQj7N2oQoL/H
	y62cg3UAgch41sYR6swzGa9Um0sXZaPYV0ILq2r4KY9wwDvIECcdJ/qVQnYZ9CvZ
	2s3gGBiM/xGBOfvqW9q4E28yHvIEHvlO6450iH2o29/CeKtvlyq5z7UXjH3w5L/1
	so3EA8AxQwaW8aHowKn+1mM4HxLeZmiHuT0GuhNE4g==
X-ME-Sender: <xms:RtstZyuHcYBOVNPNcAWyEi4_aZvUz5sUpg9DaGNMR7a7b5q9zzsYBw>
    <xme:RtstZ3dLYd0Hvqsu4l2t5VM4YprjuKWdtzGo2nybKzgh7f03h9tuY10BR1_j3hQHs
    bLoquq949TMFq-bhw>
X-ME-Received: <xmr:RtstZ9xjTmeSV9lbJropvgdBGkdIvrE_ohtXuA7L3hgxUgdERb539V_pIiWmqYUAGp8NyclUNexb_uEfR5eJqWyXSAOkO7udJDaXLTXm9GxGTGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgffvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffleeghfejfeejtd
    eufeffgfekkeejhfeiffdugedtgfeuvdegtdelhfejueegjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RtstZ9OYy4WequNfq3b2WxmblsH69S0zHH2yw7vJv_F7bI0oe03W3w>
    <xmx:RtstZy9oxfsq4tDTurXTail-7v71AmI108GMOnvE7nv8PboByaXC3Q>
    <xmx:RtstZ1Uy4tzaFqzapQ1T2oJm1nyKk7uzWUX2qeWXROfThelTq5WADA>
    <xmx:RtstZ7ddgdSVNGFpomub95fwvKHwZnHjgM2YzGehWFAyKj7WghiKKQ>
    <xmx:R9stZ4nL__H8IaIpxCAuG7D0TVaY-Xt9khIv2Pv3tD54qbRGZ93mZnJK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82dffbe8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] refs: optimize ref format migrations
Date: Fri, 08 Nov 2024 10:34:40 +0100
Message-Id: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADHbLWcC/x2MwQqDMBAFf0X23IVExBZ/RXqI5pkuRQ1ZkVLx3
 108DszMQYoiUOqqgwp2UVkXA/+oaPyEJYElGlPt6sZ79+L8VS6YlNe8ySx/8CyphM065Ta6EUA
 ThuFJtshmyu/e9+/zvABWHUqibgAAAA==
X-Change-ID: 20241108-pks-refs-optimize-migrations-6d0ceee4abb7
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

Hi,

I have recently learned that ref format migrations can take a
significant amount of time in the order of minutes when migrating
millions of refs. This is probably not entirely surprising: the initial
focus for the logic to migrate ref backends was mostly focussed on
getting the basic feature working, and I didn't yet invest any time into
optimizing the code path at all. But I was still mildly surprised that
the migration of a couple million refs was taking minutes to finish.

This patch series thus optimizes how we migrate ref formats. This is
mostly done by expanding upon the "initial transaction" semantics that
we already use for git-clone(1). These semantics allow us to assume that
the ref backend is completely empty and that there are no concurrent
writers, and thus we are free to perform certain optimizations that
wouldn't have otherwise been possible. On the one hand this allows us to
drop needless collision checks. On the other hand, it also allows us to
write regular refs directly into the "packed-refs" file when migrating
from the "reftable" backend to the "files" backend.

This leads to some significant speedups. Migrating 1 million refs from
"files" to "reftable":

    Benchmark 1: migrate files:reftable (refcount = 1000000, revision = origin/master)
      Time (mean ± σ):      4.580 s ±  0.062 s    [User: 1.818 s, System: 2.746 s]
      Range (min … max):    4.534 s …  4.743 s    10 runs

    Benchmark 2: migrate files:reftable (refcount = 1000000, revision = pks-refs-optimize-migrations)
      Time (mean ± σ):     767.7 ms ±   9.5 ms    [User: 629.2 ms, System: 126.1 ms]
      Range (min … max):   755.8 ms … 786.9 ms    10 runs

    Summary
      migrate files:reftable (refcount = 1000000, revision = pks-refs-optimize-migrations) ran
        5.97 ± 0.11 times faster than migrate files:reftable (refcount = 1000000, revision = origin/master)

And migrating from "reftable" to "files:

    Benchmark 1: migrate reftable:files (refcount = 1000000, revision = origin/master)
      Time (mean ± σ):     35.409 s ±  0.302 s    [User: 5.061 s, System: 29.244 s]
      Range (min … max):   35.055 s … 35.898 s    10 runs

    Benchmark 2: migrate reftable:files (refcount = 1000000, revision = pks-refs-optimize-migrations)
      Time (mean ± σ):     855.9 ms ±  61.5 ms    [User: 646.7 ms, System: 187.1 ms]
      Range (min … max):   830.0 ms … 1030.3 ms    10 runs

    Summary
      migrate reftable:files (refcount = 1000000, revision = pks-refs-optimize-migrations) ran
       41.37 ± 2.99 times faster than migrate reftable:files (refcount = 1000000, revision = origin/master)

Thanks!

Patrick

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Patrick Steinhardt (10):
      refs: allow passing flags when setting up a transaction
      refs/files: move logic to commit initial transaction
      refs: introduce "initial" transaction flag
      refs/files: support symbolic and root refs in initial transaction
      refs: use "initial" transaction semantics to migrate refs
      refs: skip collision checks in initial transactions
      refs: don't normalize log messages with `REF_SKIP_CREATE_REFLOG`
      reftable/writer: optimize allocations by using a scratch buffer
      reftable/block: rename `block_writer::buf` variable
      reftable/block: optimize allocations by using scratch buffer

 branch.c                  |   2 +-
 builtin/clone.c           |   4 +-
 builtin/fast-import.c     |   4 +-
 builtin/fetch.c           |   4 +-
 builtin/receive-pack.c    |   4 +-
 builtin/replace.c         |   2 +-
 builtin/tag.c             |   2 +-
 builtin/update-ref.c      |   4 +-
 refs.c                    |  70 ++++++-------
 refs.h                    |  45 +++++----
 refs/debug.c              |  13 ---
 refs/files-backend.c      | 244 +++++++++++++++++++++++++---------------------
 refs/packed-backend.c     |   8 --
 refs/refs-internal.h      |   2 +-
 refs/reftable-backend.c   |  14 +--
 reftable/block.c          |  33 +++----
 reftable/block.h          |   9 +-
 reftable/writer.c         |  23 +++--
 reftable/writer.h         |   1 +
 sequencer.c               |   6 +-
 t/helper/test-ref-store.c |   2 +-
 t/t1460-refs-migrate.sh   |   2 +-
 walker.c                  |   2 +-
 23 files changed, 247 insertions(+), 253 deletions(-)
---
base-commit: facbe4f633e4ad31e641f64617bc88074c659959
change-id: 20241108-pks-refs-optimize-migrations-6d0ceee4abb7

Best regards,
-- 
Patrick Steinhardt <ps@pks.im>

