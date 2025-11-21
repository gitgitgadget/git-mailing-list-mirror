Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231732ED4F
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710867; cv=none; b=D6l7nfGmCu5vnFe4Q7LXWd+f3f50aK3tI7SQ4tNxS9DTCbMgQp0dypNgosnbam2r2JUJCGJ9PLXT+mLR1gczJAxmCSq7IuzdUhUfUeyVBHJjUKVPa4vR3/TD75m5OzzvRbxJkGNPc+rMmeDbFRy1raSZq3/NCdoi5Vdu9OcRyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710867; c=relaxed/simple;
	bh=EqoCekkMJHW062A6BsQKDZnBm0foYVKKXu9ei6ZpfAo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=dEztdiVE+hjWIZJ9MuxJmwQ0553OgCrJvkMMsMVvdAn2C4yqockV5L8lIThlZ1PW7+Yq8N0LF1dCRaVH+f/OObukw/yD4+uh7A37bT1qiE3WnY+mLYIE3nLaF/62/ctxlNaorEK9FgFuOlJ6d/bRjvpXg3FxzfnAdjPmn0LiM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AE6nJ/nQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KE0yLt/9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AE6nJ/nQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KE0yLt/9"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AE6F7A0295;
	Fri, 21 Nov 2025 02:41:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 02:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710862;
	 x=1763797262; bh=tjrZVvjnjmWkAG+XeSyKAwD0BNixqpvZMZZWw1c1ReE=; b=
	AE6nJ/nQOvIsBxtCzqyKKs0RS8fK3f20qe5ZwtgLV7aCcmsKPH4LirJ4cgTe0s8d
	KcfU6ciCxPzb2CC1Fw8fUfUNPHE9zSLWS8bfwqUGFdTDdEe0iUYqpbrL8PMYsv1E
	JiUaLIq7mM0wm2FckXt3GZYZZSfVCWnRnvX3n59+KTozZWlSn0isb0xdp3cakh/M
	kqWrZNnu+8ZjCEZ2Y6EKLZk5DDydtJnIrXQZjyFLoihAEnTbMnqMfB7jg99IzXEi
	YkqUpjN01yrHSYvCGQ/GSrhNwaX8nsH9IjRXW1qbEga+FJ+Bq72cqp+C8lekFEjc
	dGLpdP7o8RRy2uP3tV44GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710862; x=
	1763797262; bh=tjrZVvjnjmWkAG+XeSyKAwD0BNixqpvZMZZWw1c1ReE=; b=K
	E0yLt/9wxAsc8fQFNqlbsug/Fd/bH9jqfyuDY4sxdR2cl7xZzpkVEEeUhkOFqvzm
	EIbif8XOtfs+og38yinE+gofSXN/ueiEVDyrkBarn6llngqYZKJOZxNYNlPZ4x1R
	HVUBmfNZYxCUfeBQmG9pjBapg1bpbhd1cSZ+fJJXYYxDf4Eq/MRTDaPqpXo6DP7a
	ND0uV+L73pnY62Lt8qn26Vpc62eA+TEY5Wzl7r48/tr1NK2KMOf3HGpAqxoC2/FN
	7i6BV3onuKAT1381yKTcOsj8ETqL3kk98eGZ7fF1t8kEB3CenFWDFvw2vroyjVLV
	odcgeolDsxKw3I8hZPu1g==
X-ME-Sender: <xms:jhcgaS1SVQfbCiEEP41lNjholQsyFahvgliRuErbQ5LW4ujzuGQJoA>
    <xme:jhcgachidkCoiOTNRrs5ZaW6RTxWr0jZsNNC8ant2ajLcFuzTpb-SfsUjsNhevkxr
    CWzqU0viyTqFcJ0BeNzwKeAYTozy0S7t2rdrkQeLwMPvhqM4HBjMQ>
X-ME-Received: <xmr:jhcgaYTHBYRarVgp8sX3X6zE3PlXIO9z60Q4R5gjsSXya900WolG4SgndiL354oF6meWLPflj02-HYfLQOvAWgvosNt05KBbVHKBxpllh-5t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jhcgadgOMbZETtl91vE7M3rdpyDWd9586ZApdPbu42p4tnQPrzY8kw>
    <xmx:jhcgaY7dug-j4YChCwCRdnTW7yUU4LoStGitEu7nTFbdpT1Bwq2BvA>
    <xmx:jhcgaaBqFwPYrbbpQZbETSP_W5IlOd4e7hL-LmipezlYsoOTFlIwxw>
    <xmx:jhcgafYvF9RYK6cwazDUzsp0ttq-VM1WrgRj1u9KsjKGrb8qTUGDZg>
    <xmx:jhcgaY8nIdvgX3QqWLvskgsrtBn2VJiWOUpQgOqQWpkDhP6i5e_5vMgy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a97df42 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:40:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/19] Refactor object read streams to work via object
 sources
Date: Fri, 21 Nov 2025 08:40:45 +0100
Message-Id: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0XIGkC/3WNQQrCMBBFr1Jm7UgSK1FXvYd0kSYTO0ibkpSgl
 NzdWNy6Gt7n/zcbJIpMCW7NBpEyJw5zBXVowI5mfhCyqwxKqLOUQuPQ4vJMGNyAkYzDtNYzoSa
 jvSBhLr6FOl4ieX7t4ntfeeS0hvje/2T5TX9Kef2nzBIFGmesFyerrPVdbR15gr6U8gGL7Vtcu
 QAAAA==
X-Change-ID: 20251107-b4-pks-odb-read-stream-7ea7f0e0a8f4
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Hi,

the `git_istream` data structure can be used to read objects from the
object database in a streaming fashion. This is used for example to read
large files that one doesn't want to load into memory in full.

In the current architecture, all the logic to handle these streams is
fully self-contained in "streaming.c". It contains the logic to set up
streams for loose, packed, in-memory and filtered objects. This doesn't
really play all that well with pluggable object databases, as it should
be the responsibility of the object database source itself to handle the
logic.

This patch series thus revamps our object read streams: instead of being
entirely contained in "streaming.c", the format-specific streams are now
created by the ODB sources. This allows each source itself to decide
whether and, if so, how to make objects streamable.

This overall requires quite a bit of refactoring, but I think that the
end result is an easier-to-understand infrastructure that is an
improvement even without pluggable object databases.

This series is built on top of v2.52.0 with ps/object-source-loose at
3e5e360888 (object-file: refactor writing objects via a stream,
2025-11-03) merged into it.

Changes in v2:
  - Some commit message improvements.
  - Drop the `type` and `size` out pointers in
    `odb_read_object_stream()` in an additional commit.
  - Improve a "hidden" variable declaration by moving it onto its own
    line.
  - Link to v1: https://lore.kernel.org/r/20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (19):
      streaming: rename `git_istream` into `odb_read_stream`
      streaming: drop the `open()` callback function
      streaming: propagate final object type via the stream
      streaming: explicitly pass packfile info when streaming a packed object
      streaming: allocate stream inside the backend-specific logic
      streaming: create structure for in-core object streams
      streaming: create structure for loose object streams
      streaming: create structure for packed object streams
      streaming: create structure for filtered object streams
      streaming: move zlib stream into backends
      packfile: introduce function to read object info from a store
      streaming: rely on object sources to create object stream
      streaming: get rid of `the_repository`
      streaming: make the `odb_read_stream` definition public
      streaming: move logic to read loose objects streams into backend
      streaming: move logic to read packed objects streams into backend
      streaming: refactor interface to be object-database-centric
      streaming: move into object database subsystem
      streaming: drop redundant type and size pointers

 Makefile               |   2 +-
 archive-tar.c          |  12 +-
 archive-zip.c          |  17 +-
 builtin/cat-file.c     |   4 +-
 builtin/fsck.c         |   5 +-
 builtin/index-pack.c   |  15 +-
 builtin/log.c          |   6 +-
 builtin/pack-objects.c |  24 ++-
 entry.c                |   4 +-
 meson.build            |   2 +-
 object-file.c          | 183 ++++++++++++++--
 object-file.h          |  42 +---
 odb.c                  |  29 +--
 odb/streaming.c        | 294 ++++++++++++++++++++++++++
 odb/streaming.h        |  67 ++++++
 packfile.c             | 199 ++++++++++++++++--
 packfile.h             |  17 +-
 parallel-checkout.c    |   5 +-
 streaming.c            | 561 -------------------------------------------------
 streaming.h            |  21 --
 20 files changed, 780 insertions(+), 729 deletions(-)

Range-diff versus v1:

 1:  89ec27ae18 !  1:  a6534585dd streaming: rename `git_istream` into `odb_read_stream`
    @@ streaming.h
     -int close_istream(struct git_istream *);
     -ssize_t read_istream(struct git_istream *, void *, size_t);
     +struct odb_read_stream *open_istream(struct repository *, const struct object_id *,
    -+				       enum object_type *, unsigned long *,
    -+				       struct stream_filter *);
    ++				     enum object_type *, unsigned long *,
    ++				     struct stream_filter *);
     +int close_istream(struct odb_read_stream *);
     +ssize_t read_istream(struct odb_read_stream *, void *, size_t);
      
 2:  b4d37fd4f2 !  2:  23a8704740 streaming: drop the `open()` callback function
    @@ Commit message
         structure in the source itself.
     
         We could of course work around that and have the loose object source
    -    create the structure and populate it's `open()` callback, only. But
    +    create the structure and populate its `open()` callback, only. But
         this doesn't really buy us anything due to the second bullet point
         above.
     
 3:  b8bae59f58 =  3:  badcc5d72b streaming: propagate final object type via the stream
 4:  583ed2c4f3 =  4:  09f9d2e3f2 streaming: explicitly pass packfile info when streaming a packed object
 5:  af1a5a312a !  5:  40728b509c streaming: allocate stream inside the backend-specific logic
    @@ Commit message
         This works, but it's awkward in the context of pluggable object
         databases. Each backend will need its own member in that union, and as
         the structure itself is completely opaque (it's only defined in
    -    "streamgin.c") it also has the consequence that we must have the logic
    +    "streaming.c") it also has the consequence that we must have the logic
         that is specific to backends in "streaming.c".
     
         Ideally though, the infrastructure would be reversed: we have a generic
 6:  5c5c291bba !  6:  7d74c31e3d streaming: create structure for in-core object streams
    @@ streaming.c: static int open_istream_incore(struct odb_read_stream **out,
     -	struct odb_read_stream stream = {
     -		.close = close_istream_incore,
     -		.read = read_istream_incore,
    --	};
     +	struct odb_incore_read_stream stream = {
     +		.base.close = close_istream_incore,
     +		.base.read = read_istream_incore,
    -+	}, *st;
    + 	};
    ++	struct odb_incore_read_stream *st;
      	int ret;
      
     -	oi.typep = &stream.type;
 7:  58d214e576 =  7:  dd3440bff2 streaming: create structure for loose object streams
 8:  7b3d095e06 =  8:  6de8cc7c9f streaming: create structure for packed object streams
 9:  3bca3dfab5 =  9:  e00aa2b198 streaming: create structure for filtered object streams
10:  329549b6c7 = 10:  f37441494d streaming: move zlib stream into backends
11:  9d47d12cbf = 11:  8c62cfac57 packfile: introduce function to read object info from a store
12:  3a5ad53484 ! 12:  82f186e8b4 streaming: rely on object sources to create object stream
    @@ Commit message
         the different source backends anymore, but eventually it'll only have to
         call the source's callback function.
     
    -    Note that at the current poin in time we aren't full there yet:
    +    Note that at the current point in time we aren't fully there yet:
     
           - The packfile store still sits on the object database level and is
             thus agnostic of the sources.
13:  2fa2f53ac0 = 13:  a5c1b3c717 streaming: get rid of `the_repository`
14:  49e6fb06e8 ! 14:  5fdd600a0c streaming: make the `odb_read_stream` definition public
    @@ streaming.h
     +};
     +
      struct odb_read_stream *open_istream(struct repository *, const struct object_id *,
    - 				       enum object_type *, unsigned long *,
    - 				       struct stream_filter *);
    + 				     enum object_type *, unsigned long *,
    + 				     struct stream_filter *);
15:  3a944f3a31 = 15:  460cab31c9 streaming: move logic to read loose objects streams into backend
16:  60b08e3dc5 = 16:  293578ab35 streaming: move logic to read packed objects streams into backend
17:  68ef7721b0 ! 17:  e6a242f1b8 streaming: refactor interface to be object-database-centric
    @@ streaming.h: struct odb_read_stream {
      };
      
     -struct odb_read_stream *open_istream(struct repository *, const struct object_id *,
    --				       enum object_type *, unsigned long *,
    --				       struct stream_filter *);
    +-				     enum object_type *, unsigned long *,
    +-				     struct stream_filter *);
     -int close_istream(struct odb_read_stream *);
     -ssize_t read_istream(struct odb_read_stream *, void *, size_t);
     +/*
18:  8afda7d038 = 18:  95e7c2aa9b streaming: move into object database subsystem
 -:  ---------- > 19:  c8b2112d00 streaming: drop redundant type and size pointers

---
base-commit: 899e578b5b7c020aec806bd694adf2563f62843c
change-id: 20251107-b4-pks-odb-read-stream-7ea7f0e0a8f4

