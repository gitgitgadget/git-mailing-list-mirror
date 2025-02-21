Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900A1E2848
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124061; cv=none; b=E5z4fd6YA3EkTq4x95lqOi6hYIjEZTIWLlNpTppX+CtrlFGUUyyIKVcM+XpSNerrtdkqYj73HT2barMivc49haSXnb+zML6xt7htfGw6YqrNg8ta2geqa/YW9XFpGUtBIp8cCJRRWKn5QXefJnuwtejJ+bF/RSJGWrcNTXGxcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124061; c=relaxed/simple;
	bh=JdnqqcZlmNtdRFlu4EJqlfnYnHKFmckzR36bO0N3FZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jmpLJwpj9AYsPAkh+h6tVPO0i/jpwt+4UEcQ+HwEADBFYfSy2nhPVMPZB9s1iwADWJNS6OOBVYn8J+XamI31wFTzs98a9H6Un13+ciZsQqB4v9KOmO6vwiv0A2eJTmlCVqc/zkZ4jlaoOV+SQLmEo/fEulsET1/7afbclIL6Wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VFGROCbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EcaWoXrZ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VFGROCbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EcaWoXrZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B47F01140182
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Feb 2025 02:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1740124056; x=1740210456; bh=5iwoIFW8fS
	WStPqSHKLqDrtOuzHBNUvVXLF7v6SJ4C8=; b=VFGROCbCKn4sWkk7cf+vW/rglY
	HK0HUQ1dTCR2sHBHmvA6e+aqxMQUED9OAwOG2sKKjPIoHuYZDIGX9vEmJpqth6N7
	MrBRolsQruAt5tR99mvOykrimIxd7ZzCWsY+VX80wnlHBy7zsXYLAPaVnmONpJHD
	Z4buchyej+0WE2U8RjvQQz7dBwyWGim4lYQLM8lqyTF9NuH/7Tv/7iG/R1WS9NMw
	6upHqdVvcgDAHVkGJLwPuNuXd4fiYuw3Qgkt4QL7vq/9sfYWSmobbf5ByCf4FSe1
	s082GvIx2wyS0ei3r+5RWmyesxtoppG/mdpyXibwQml36OXy5zCypJyIdK7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1740124056; x=1740210456; bh=5iwoIFW8fSWStPqSHKLqDrtOuzHB
	NUvVXLF7v6SJ4C8=; b=EcaWoXrZqjb4/JoLfdH8ccDdgLjMZAVwlBIPS0OTcGpD
	upoyRUwNBWDTIIWCWVs+ahFbdpvDHcssfQY87iHhnRtoN0jRRv/orkTkcrUwHAxm
	tdP0Qrl/U6l4M5HU2EkcdKQkvaEwvifPIm8Jd9el95rWkllx7+cGekxhW2z8kfZp
	cDT4qjfExR7ksihNmgEeUr2bq2mLGAnDue9bk1rDvFyRi4EJ8cdTTecAXk/+EYXJ
	e1vjnypWWfkMbdlWs2HvdcmhpifrqPQiKmaucayAN2/Pbxyv8JP0T27cbXA+tanS
	OTYx80FrSkVL7zWArKPBvbb5paX/fA0DV41Z1ftPyA==
X-ME-Sender: <xms:mC-4Z2txup5JdUTy3JktuB3-OBRRDIo9Z5rXekzulf_iEt6yHYVgwQ>
    <xme:mC-4Z7eI4rd6VeJ3LaJowo2ZvsjnXoFKOtYYZjYPu__9M8cVVgipXcP1c_8qvgasS
    chlzoonvzVNUpyzEA>
X-ME-Received: <xmr:mC-4Zxz4XITsqctTUbL-xHp_AYuNBbh0OchwwzElogptvMr1PjUPs6WVj_yvgHXNBVEVFdQVYxAsRftI3HSMClwtwSme-uBhq5uuFZh-L3eQuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffuff
    fkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefueekkeetue
    fgveejjeefheefgfekteefkeffgffgvedtieevleehffffieekheenucffohhmrghinhep
    ghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mC-4ZxM4Mil3v23CTZymaVtYKDnQz_kDuE8xDlC9jaOISktE5_gZQA>
    <xmx:mC-4Z2-2ihADd4MMzKyf6XnztFKGQilg2aY7hyx43CuZ1DGp3npOFQ>
    <xmx:mC-4Z5UDMpwYN1kFwV9XMeEC8Y105mtlgb-hY8yWThWU0UavvUXJHw>
    <xmx:mC-4Z_f1fGawwWj_C4umeDYcGQJxqkj6Z1wO7uUkHFPzqaHqoJSrvg>
    <xmx:mC-4Z8kSY4MPuU4lU0slQ0dBsH_wn7JmKc5In11WOuoDkGUdV4F7VXjU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 79a0c629 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/9] builtin/cat-file: allow filtering objects in batch
 mode
Date: Fri, 21 Feb 2025 08:47:25 +0100
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI0vuGcC/x2NwQqDMBAFf0X27MIm6KH+ivRg41O3ioYklIr47
 0aPM4eZgyKCIlJTHBTw06jbmsGUBbmpW0ew9pnJiq3FWmE/R3Zd4kEX8Pb5wiVOu8ctEgK/TCV
 O0NeAoVzxAYP+n0P7Ps8LHCjJrXEAAAA=
X-Change-ID: 20250220-pks-cat-file-object-type-filter-9140c0ed5ee1
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

at GitLab, we sometimes have the need to list all objects regardless of
their reachability. We use git-cat-file(1) with `--batch-all-objects` to
do this, and typically this is quite a good fit. In some cases though,
we only want to list objects of a specific type, where we then basically
have the following pipeline:

    git cat-file --batch-all-objects --batch-check='%(objecttype) %(objectname)' |
    grep '^commit ' |
    cut -d' ' -f2 |
    git cat-file --batch

This works okayish in medium-sized repositories, but once you reach a
certain size this isn't really an option anymore. In the Chromium
repository for example [1] simply listing all objects in the first
invocation of git-cat-file(1) takes around 80 to 100 seconds. The
workload is completely I/O-bottlenecked: my machine reads at ~500MB/s,
and the packfile is 50GB in size, which matches the 100 seconds that I
observe.

This series addresses the issue by introducing object filters into
git-cat-file(1). These object filters use the exact same syntax as the
filters we have in git-rev-list(1), but only a subset of them is
supported because not all filters can be computed by git-cat-file(1).
Supported are "blob:none", "blob:limit=" as well as "object:type=".

The filters alone don't really help though: we still have to scan
through the whole packfile in order to compute the packfiles. While we
are able to shed a bit of CPU time because we can stop emitting some of
the objects, we're still I/O-bottlenecked.

The second part of the series thus expands the filters so that they can
make use of bitmap indices for some of the filters, if available. This
allows us to efficiently answer the question where to find all objects
of a specific type, and thus we can avoid scanning through the packfile
and instead directly look up relevant objects, leading to a significant
speedup:

    Benchmark 1: git cat-file --batch-check --batch-all-objects --unordered --buffer --no-objects-filter
      Time (mean ± σ):     82.806 s ±  6.363 s    [User: 30.956 s, System: 8.264 s]
      Range (min … max):   73.936 s … 89.690 s    10 runs

    Benchmark 2: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tag
      Time (mean ± σ):      20.8 ms ±   1.3 ms    [User: 6.1 ms, System: 14.5 ms]
      Range (min … max):    18.2 ms …  23.6 ms    127 runs

    Benchmark 3: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=commit
      Time (mean ± σ):      1.551 s ±  0.008 s    [User: 1.401 s, System: 0.147 s]
      Range (min … max):    1.541 s …  1.566 s    10 runs

    Benchmark 4: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tree
      Time (mean ± σ):     11.169 s ±  0.046 s    [User: 10.076 s, System: 1.063 s]
      Range (min … max):   11.114 s … 11.245 s    10 runs

    Benchmark 5: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=blob
      Time (mean ± σ):     67.342 s ±  3.368 s    [User: 20.318 s, System: 7.787 s]
      Range (min … max):   62.836 s … 73.618 s    10 runs

    Benchmark 6: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=blob:none
      Time (mean ± σ):     13.032 s ±  0.072 s    [User: 11.638 s, System: 1.368 s]
      Range (min … max):   12.960 s … 13.199 s    10 runs

    Summary
      git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tag
       74.75 ± 4.61 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=commit
      538.17 ± 33.17 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tree
      627.98 ± 38.77 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=blob:none
     3244.93 ± 257.23 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=blob
     3990.07 ± 392.72 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --no-objects-filter

We now directly scale with the number of objects of a specific type
contained in the packfile instead of scaling with the overall number of
objects. It's quite fun to see how the math plays out: if you sum up the
times for each of the types you arrive at the time for the unfiltered
case.

Thanks!

Patrick

[1]: https://github.com/chromium/chromium.git

---
Patrick Steinhardt (9):
      builtin/cat-file: rename variable that tracks usage
      builtin/cat-file: wire up an option to filter objects
      builtin/cat-file: support "blob:none" objects filter
      builtin/cat-file: support "blob:limit=" objects filter
      builtin/cat-file: support "object:type=" objects filter
      pack-bitmap: expose function to iterate over bitmapped objects
      pack-bitmap: introduce function to check whether a pack is bitmapped
      builtin/cat-file: deduplicate logic to iterate over all objects
      builtin/cat-file: use bitmaps to efficiently filter by object type

 Documentation/git-cat-file.adoc |  16 +++
 builtin/cat-file.c              | 225 +++++++++++++++++++++++++++++-----------
 builtin/pack-objects.c          |   3 +-
 builtin/rev-list.c              |   3 +-
 pack-bitmap.c                   |  80 +++++++++-----
 pack-bitmap.h                   |  19 +++-
 reachable.c                     |   3 +-
 t/t1006-cat-file.sh             |  77 ++++++++++++++
 8 files changed, 339 insertions(+), 87 deletions(-)


---
base-commit: a554262210b4a2ee6fa2d594e1f09f5830888c56
change-id: 20250220-pks-cat-file-object-type-filter-9140c0ed5ee1

