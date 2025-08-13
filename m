Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F691DE2D7
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066340; cv=none; b=ROMqYUzhOKkFlq6Aerbij0CVbVwLXy1hVP4l3G1Rci5iB3AUxIs38KL48z1O0KZcn+OcXFMd8QexaDyfzau4Y0GwpfBkL3yzoY/WgfpjfKGdvnNV9KsPRphkyOMU2WAdwSSM8FZKGeSkL7NIYYaOrFkB3Za9OWbGHGvzP/xhMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066340; c=relaxed/simple;
	bh=AZZqJnzkdklPrc7Ozmrue8JOdTvk+qcSUv01x7cynuE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=gHYxXtL4l6dwQZtEksxASRZEH84kl780krpBcwuEjoRLfFNZ3o13MNjbvjSeZPHlCjMMXqQEBzK5os7wzUWKxRGSP/GY9zVPxSIjSonvDy6OwdVpQaDqqkpARY/bMPTjofDfDER7y0RaJ1t8FRkhFXizciFANLJvmaWZJF3l/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Semsjsbw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMOBpt9d; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Semsjsbw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMOBpt9d"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01CCD7A0127;
	Wed, 13 Aug 2025 02:25:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 02:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755066334;
	 x=1755152734; bh=I8RHuXX4Ke1feKOYSztoz4n4z24mAgxU3UgoqmINeSQ=; b=
	SemsjsbwTWSiv903qbC3w8CDjOUlFcaZdh77zItsvLLXTjJIEwb5Eq47hImf1CW1
	X9S5iBnEcfFhTL5yWC8H9tVtR63N9+YvKc97343V0QtNwbtcBaOYyMlaEgyVMpmU
	tfYLd4KzFIvcCC6IyQToUIzpZ7EO8l04PEpAolS7Hr3ka0ENheagNYdukCY0QR2T
	LPiRUtlxtiaL0uqtLg8HZusk9wwU4uxOaIZ7EXia9yS/JL5YQr1wHhXM/SmX9zsC
	aQ1r9ev+fW1IRQNUfU0rr/GtUE+NsNyGamIz7JMMAJwpqOuQfTyTYF2Vtv7n4m2G
	yQH8j/kGAAu34MC36WTfkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755066334; x=
	1755152734; bh=I8RHuXX4Ke1feKOYSztoz4n4z24mAgxU3UgoqmINeSQ=; b=j
	MOBpt9dih2t7PJ5Ufh4Z64BxJIYGobUgd0jKH3nGntPdGQW1WHspRCSDrch0O26P
	vs2puvaxoXH2TddBi4X8KjKy7AcnBldaWi6c67rVwsD1rstNAcsYUsnt3767PcVK
	mw3vc6HE0eyv6lymQMNdfFo5wXoq5MKh6QN4+iDXbt2Ni0zFV76v6bw4ZAp044pp
	v7Vo32pF+05leglPyzDQcZHPGG6c3B5TIW1e1a92C3ZKW+GrnDDbcMMpF9tT8iXm
	/QZnBfii28zSh/6sKg6/Wa1PB1UtYEuwHzpEsNgzqV38ZPOzYOmekwmrtvh4iVWW
	+Iqd6LttqYJGoGMLqMhnA==
X-ME-Sender: <xms:3i-caP2-r3FEBNNBBSLa2l3z1eIeTUpOzAET-SuGWp2zIq-zlSutdQ>
    <xme:3i-caJkyumdxIAXDAHzKOawjkQQ4LyDz2ynM7D6kBgi4DFC4F7UJ668hb4cQfPiCj
    57EtiGRSdDUpZOBeQ>
X-ME-Received: <xmr:3i-caGUrakwUjpcWSiSJ5iXP8DFJW_0oUkmK7Z1w8BArKhMzcr_esrl9FpemluLTi5_YnB5LTEh8DYIin29lBKUy-LcSMal8PUND4iiy9aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegtrghrvghnrghssehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3i-caPv0YrizQBv3kE9m4cCIggwFHEvL2flleiPAzBgMuMcDNwixtQ>
    <xmx:3i-caJYqnO9ZBFmLjdD_4cwLll6DuZGk_qCuwI_NIJiImJpTyU8Zow>
    <xmx:3i-caOUtQgDz-XosmvOO4DmuBkk9hrlVQLXibovmu0ZKjIXuCgBzmg>
    <xmx:3i-caOSJ9m1nkeuDTIOM1TLNv-ZWvA3SMDkoWdSnUBqEqC_fbUlC6w>
    <xmx:3i-caCAqfsuaRTaqFO-OQjTIrCMzVSO6M9o2SwwhHsvYvfiJigv5IjNH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:25:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id beb851f9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:25:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/8] reftable: a couple of improvements for libgit2
Date: Wed, 13 Aug 2025 08:25:24 +0200
Message-Id: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQvnGgC/43NQQ7CIBAF0KsY1o6BgWJx5T2Mi1IHnahtA02jM
 b274MLoSpd/8v+bh0gUmZLYLB4i0sSJ+y4Hs1yI9tR0RwI+5CxQYiVrqWA4J4gUxsZfCALfKEH
 oI1zYH3lEqCx6V7mmslKLjAy5W0rZ2O1zPnEa+3h//ZtUuf5NTwokBGMsqVbr1rttHqz4Koo74
 adlflpYLArSonSNq82XpT8shT8tna02aI9o17Vd09ua5/kJHm8GN2EBAAA=
X-Change-ID: 20250801-pks-reftable-fixes-for-libgit2-562b959a5603
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series contains a couple of improvements I required for
libgit2. With those changes libgit2 is now able to run its full test
suite with reftable-enabled repositories. I still need to invest a bit
of work to make it memory-leak free and compile on Windows, but overall
I think that support for reftables is almost ready.

Changes in v2:
  - Another commit that fixes handling of outdated stacks when doing
    compaction. This issue is hit in libgit2, which has a test that
    performs writes with a couple dozen concurrent threads.
  - Add a link to past discussions around `{0}` vs `{{0}}` as provided
    by Eric.
  - Link to v1: https://lore.kernel.org/r/20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im

Changes in v3:
  - Adapt `reftable_stack_init_addition()` to `memset()` the addition
    instead of using `{{0}}`.
  - Add another commit on top that makes the `flock` interface more
    robust by not relying on `errno`.
  - Add another commit to fix races with concurrent writers caused by
    the backend not passing `REFTABLE_STACK_NEW_ADDITION_RELOAD`.
  - Link to v2: https://lore.kernel.org/r/20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im

Changes in v4:
  - Adjust stale commit message.
  - Fix a typo while at it.
  - Link to v3: https://lore.kernel.org/r/20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      reftable/writer: fix type used for number of records
      reftable/writer: drop Git-specific `QSORT()` macro
      reftable/stack: reorder code to avoid forward declarations
      reftable/stack: fix compiler warning due to missing braces
      reftable/stack: allow passing flags to `reftable_stack_add()`
      reftable/stack: handle outdated stacks when compacting
      reftable: don't second-guess errors from flock interface
      refs/reftable: always reload stacks when creating lock

 refs/reftable-backend.c         |  23 ++-
 reftable/reftable-stack.h       |   9 +-
 reftable/reftable-writer.h      |   4 +-
 reftable/stack.c                | 439 +++++++++++++++++++---------------------
 reftable/system.c               |   2 +-
 reftable/system.h               |   4 +-
 reftable/writer.c               |  23 ++-
 t/unit-tests/t-reftable-stack.c |  50 ++---
 8 files changed, 275 insertions(+), 279 deletions(-)

Range-diff versus v3:

1:  afb757e6c1 = 1:  631293a69e reftable/writer: fix type used for number of records
2:  75dd5f6cb6 = 2:  a583b9f51c reftable/writer: drop Git-specific `QSORT()` macro
3:  6badd0ae26 = 3:  7153526268 reftable/stack: reorder code to avoid forward declarations
4:  9f5aa7f808 = 4:  7372cbe037 reftable/stack: fix compiler warning due to missing braces
5:  d4fea00eb2 ! 5:  57810b984e reftable/stack: allow passing flags to `reftable_stack_add()`
    @@ Commit message
         stack.
     
         Add a `flags` field to plug this gap and pass it through accordingly.
    -    For now this new flag won't be used by us, but it will be used by
    -    libgit2.
    +    This flag will be used in a subsequent patch and by libgit2.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
6:  d2cdd89280 = 6:  211d3f646e reftable/stack: handle outdated stacks when compacting
7:  635dd20dcd ! 7:  f8d541af00 reftable: don't second-guess errors from flock interface
    @@ reftable/system.h: struct reftable_flock {
       * we block indefinitely.
       *
     - * Retrun 0 on success, a reftable error code on error.
    -+ * Retrun 0 on success, a reftable error code on error. Specifically,
    ++ * Return 0 on success, a reftable error code on error. Specifically,
     + * `REFTABLE_LOCK_ERROR` should be returned in case the target path is already
     + * locked.
       */
8:  4396793747 = 8:  912d00a4a8 refs/reftable: always reload stacks when creating lock

---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250801-pks-reftable-fixes-for-libgit2-562b959a5603

