Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B01BCA0C
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944045; cv=none; b=g+9SB4ehtCMUZ95isu2i/aZM0dua5Axhu4VVATPc7jSk11GpyDmNEdFai8ijXX5WVKMoUeaH2jJlWbWJzLYBaqRmQN5UyxgGLy4SctjeauXaSZ9g9csb2IhWi5i+50/VID0O5aqm4zAonhXAKKjljwWNqJKUY0+3PwMdbleQUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944045; c=relaxed/simple;
	bh=5RFFDBej4BruAFbSmzuvXx+0DbGmQuPGMR7zsTtPl2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em006euYj9AfjT4fJNG40MZRpVuyxDVglRN9issTYPvIAbQGXrZQJ9eXRpDnRB07LL4wQsFX3rXkUu6MlEUrVurRF1ttimFvE+t4OUVvlzQiQvNV8hBsx1yAU/Q5NpozAdn+tYcg/Mh4e40zDopWDr7D9p6Lsl4YVnv4ijawUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aQ5EW2DY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4NsamuU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aQ5EW2DY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4NsamuU"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92E8F114022B;
	Mon, 18 Nov 2024 10:34:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 10:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731944042; x=1732030442; bh=1rl16BBDWb
	RyN2XADTCmGOskrcPN9FM5jTekzkBPKsQ=; b=aQ5EW2DYvaLbPOOtd8DVavYXMG
	KBFTmmxIEHVkeBsSiboe2TsV9Z5xsuCCGn+utcAexZKfD02L6qwmDAiAbErIYdck
	cCJBvmlbOPZeHuwY4TFX+TzKEXj+Wb6ju0FE12M8a/LgwWKv7opLIvtL+un2J8dU
	wUP7PEmMBY6z/4agHuKBxeB56Cmz2hskF/SwCqe+cH71qEB+18Go3bz4prlrpbwt
	6kBW41dA+S2sN9xLEFQ8FvYcJNvPU1+fOz3oJHc/h7DzvU3/GJ4rwxef1QxmDT57
	mwJoHv1zzlpU2gc/v6qK0nH5DcEhLiy+k8xlqmy4gOND+qdwFlyemnXij0ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731944042; x=1732030442; bh=1rl16BBDWbRyN2XADTCmGOskrcPN9FM5jTe
	kzkBPKsQ=; b=I4NsamuUYrC9BANtSWQGIick+bTWsDKA5c31SH/zMZFT7eJ9DaI
	MXMAphFKVrlTTMvKR1Ez4qrXx5Of1/igenJwI5JcfCIZjqLwjYE5q6lfxyS6ocDr
	o8f5rxNQnts76jMyy/XRqCctgKFsWY+qkrElHLrBYwVNCmx+QuIHFU+lo1wkp575
	Emq9vevnT29OQtjPN4ROcNQSE++ZkT5WpdBVL6qA332u9fy16fAYP16Dm22l8b65
	uGx/83MxuJ5ckKu6tAp6YelmXD68JryO6gtfuw6XOWmGtvvLRA8fTtWnJ1WyoHDf
	N3+MqLe5vLVlLMapSOTSXyup9Me6xzU4NMQ==
X-ME-Sender: <xms:al47Z3OX_o_x6rX7wiGwzNs7xLc3TUFmtlbK07pdUUw97ivL-uTVyA>
    <xme:al47Zx_qcau6mcqbo4s3lcFdDfXcrJ5U90KrG7XMBGAX_QWJ4BPHaZLCmx2FdBd0C
    fwwcQCk4qKq63feYw>
X-ME-Received: <xmr:al47Z2ThzAX8HVDyjrzWODKrLilgu2Is57b9Y3lh11lIic8e9I_8r0RGoxzgPSGxz6Mj-xAojWQuwSi2XY-SbvziHXH09k-BmVO5I_035i-L9tg_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrught
    hhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:al47Z7s7z08gyY04X37qmOsaQAbIAJa-o9n-NAkuoVNdzRGzDqHHTg>
    <xmx:al47Z_c0jqHx3mhn6ndzm8FwAdUoE7czZl_Afky7PkCH2KTgF8VKsQ>
    <xmx:al47Z30TvROWwZxGUbFpIZdg1l1sAIKjraPaWETYdOBGZ5vv2rOX-A>
    <xmx:al47Z78r3RYuSJkPntXJTYvTXFEsj8D_yq_u5TBFjFiiGcXZhtvOGQ>
    <xmx:al47Z3S_XPgsjUflx5NQCEYQF-y9o1QUdHYfwcBhdtQlyDqVHn3HlNnG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:34:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee2104c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:33:11 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:33:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/7] reftable: stop using Git subsystems
Message-ID: <cover.1731943954.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729677003.git.ps@pks.im>

Hi,

this is the third version of my patch series that continues to detangle
the reftable library from the Git codebase.

There is only a single change compared to v2, which is a clarification
that `tmpfile_rename()` also deactivates the underlying tmpfile.

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
 reftable/basics.h                   |  10 +-
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
 reftable/system.h                   |  89 ++++++++++++++-
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
 27 files changed, 506 insertions(+), 229 deletions(-)
 create mode 100644 reftable/system.c

Range-diff against v2:
1:  2b7d4e28529 = 1:  2b7d4e28529 reftable/system: move "dir.h" to its only user
2:  38cfe85bf5b = 2:  38cfe85bf5b reftable: explicitly handle hash format IDs
3:  745c1a070dd = 3:  745c1a070dd reftable/system: stop depending on "hash.h"
4:  7782652b975 = 4:  7782652b975 reftable/stack: stop using `fsync_component()` directly
5:  b15daefbc83 ! 5:  430be1045d6 reftable/system: provide thin wrapper for tempfile subsystem
    @@ reftable/system.h: license that can be found in the LICENSE file or at
     +
     +/*
     + * Rename the temporary file to the provided path. The temporary file must be
    -+ * active. Return 0 on success, a reftable error code on error.
    ++ * active. Return 0 on success, a reftable error code on error. Deactivates the
    ++ * temporary file.
     + */
     +int tmpfile_rename(struct reftable_tmpfile *t, const char *path);
      
6:  83949837a29 = 6:  b9ffdc605b9 reftable/stack: drop only use of `get_locked_file_path()`
7:  80fe5bc5e10 = 7:  e1ac1cc2e67 reftable/system: provide thin wrapper for lockfile subsystem
-- 
2.47.0.274.g962d0b743d.dirty

