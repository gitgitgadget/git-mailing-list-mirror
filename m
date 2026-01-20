Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE91477989
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922774; cv=none; b=EIUiJyAubN0UOmnN1VW8lWe3cngphGKanbFzgCcz0Oi1EMMXRYQ9+80Kuihr9C5uGmKupC5J7+LY+RL/w9pt/mkjEKHTPWjlb1+LwB2IgoYIjg57SotmTU2I4pH0Gbh1iPjmDG+NfyRPoi2yQnFDp1KPtGlK04EMXO+iIiWUCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922774; c=relaxed/simple;
	bh=tK+0CT7RqnY/ThG3HA5wGrEsRo/WN4hH0hRIlnb3zIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=c6BVdn/tx32/IfiSvp73l8gMOuXDu+pyXwtYUVin62IpSNrkYc+e5fU86xgGM7RX++RSZZcLQieTcC8QHaQO02BQsgCvLBOrN8Vrxxoe9VcKlDqs9F+3tdCEcHTbvCtPjTWyFoJTeQe6iBsLNxUHX5cwx1Ul1U79hRnlreGK87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NSR1ndGX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+tv3Fle; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NSR1ndGX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+tv3Fle"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 212C51D0009D;
	Tue, 20 Jan 2026 10:26:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 10:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922768;
	 x=1769009168; bh=pSBE214ksXAFowvq28R3fS6jBDrBoAG/f3tMmWafarQ=; b=
	NSR1ndGXweRvk+BWt3fIoTK8QN6JIuZ94PdPw+YuCGfSU3jvYLI0W/ZqO5P6luTl
	Kik/fMijKsaek0v+F6eIRMRwxsbv2zFB63/p6u09o6NmZU5N2XQfuybGKDyMPweI
	WLyXT2L739/odnWmgazNmtw3wc/84SUd4QC8SU7znEN0bfGkzlEDxxG3MT6JXl27
	huX1ZKhYYPyer/XLxodBtwZ2kxek5pzA/+WCqV99BkT2zjn3scetvUvDZjdz7ror
	UlevCA6ffOhnRvdgAdLZrxSb5vZ0VlW+qoL1G/fJe1NfnFWQJoeQFHXdXj2Sd0ak
	rpcN5rHI/fDd+9rJ7O1UNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922768; x=
	1769009168; bh=pSBE214ksXAFowvq28R3fS6jBDrBoAG/f3tMmWafarQ=; b=p
	+tv3Fleae3s9Gfls/rOhn7s/+UDf7GyVEmcys4Xkk6cyW2+ulonKyRTlmaxUXas+
	+lQ2IHwtVaJexnKYdUi73oUgjdxbLPqdzFpOzvKAithtrrr9b7sVNvkLkmBeKtDm
	3kUv7xN3mYjw/GC4tqxMAw8vBk9znJ9Rt3Yzvbb0Oz2imEApT49bXQY08KCR3Qk8
	MzzAm1QA73oR7anlwvqsF3zYFv0swNzFuXsGK1vzI4IWzg93z76PTtdMjxiUzM4x
	0smVWV/ZUXuezDya3TDXM9QXAuhKjziPLqgGiBa+t3Gx2+LlZgnf9T96sbiyvIT5
	923KwZhdUmr08z1lPspMw==
X-ME-Sender: <xms:kJ5vaWorS_i8A_oO3JoKUMYl8_Yg9ZgvModpjuwN5OZU6DLVF3RlVQ>
    <xme:kJ5vabp46ZVpHYZq4C2xuSPRRVfhqTmOZaWRFzgrQmLUrO8L07TKe6N5xJAZ8qM0g
    ShztCDMseR4rnbELi5MAWmGKjG4S7bXgbeyaFOwBLlpVk5-XjG3tg>
X-ME-Received: <xmr:kJ5vaQORQZzewrKdWdtFybWmIueJLlqkLraO1Fz8-Q_D2uw6IPteAHmC9xjSvwwvhjUDRC4g2HiZS5nLk2xA2eRxSwWuUYpsH62DuQ5Ulw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:kJ5vaUx-F5JND5_xtIfB1Yp6OusfllDiUrJc_jAJJGOOe-aixY_4bw>
    <xmx:kJ5vaRtEylJ2clW6dStRrSTmHBteXHgKhnYj6EkHZiR_UgqGXe62Dw>
    <xmx:kJ5vaV6PyXrEWAPjHo58kLaT268lHaVKJ6CfHxyyL6CE2tH8EX0ToA>
    <xmx:kJ5vaYSSM5UYiNXu_YNm28sNZvGcY1T2cyJMa00nOAd0EiqdydD-kA>
    <xmx:kJ5vafv4P-ms1OBhbSvV-le8v0tH685vm_-bx7fYulPbkUOvhnJpOOI1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c08e3184 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/14] odb: introduce `odb_for_each_object()`
Date: Tue, 20 Jan 2026 16:25:56 +0100
Message-Id: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAISeb2kC/4WNTQ6CMBCFr0Jm7ZiWWKSuvIdh0Z+pjEZKWtJoC
 He3cgGX38t731shU2LKcGlWSFQ4c5wqtIcG3GimOyH7ytCKthNSKpyfGaO3GGJCMm7EaB/kFuy
 EPffOk9DBQ13PiQK/d/NtqDxyXmL67EdF/tL/ziJRoDrJ3mjpldf6WptHfsGwbdsXASqWfrsAA
 AA=
X-Change-ID: 20260115-pks-odb-for-each-object-60b78cde09fd
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Hi,

this patch series introduces a generic `odb_for_each_object()` function
to iterate through objects and adapts callers to use it. The intent is
to make iteration through objects independent of the actual storage
backend.

The series is structured as follows:

  - Commits 1 to 2 do some cleanups for the for-each-object flags.

  - Commits 3 to 7 introduce the infrastructure for
    `odb_for_each_object()`.

  - Commits 8 to 13 convert a couple of callers to use the new
    interfaces.

  - Commit 14 drops now-unused functions.

The patch series is built on top of 8745eae506 (The 17th batch,
2026-01-11) with the following two series merged into it:

  - ps/read-object-info-improvements at a282a8f163 (packfile: move MIDX
    into packfile store, 2026-01-09).

  - ps/packfile-store-in-odb-source at 12d3b58b55 (packfile: drop
    repository parameter from `packed_object_info()`, 2026-01-12) .

Changes in v2:
  - Clarify the comment of `odb_for_each_object()` to point out that
    it's the callback that can abort iteration by returning a non-zero
    error code.
  - Document in the commit message that we don't yet convert all sites
    to use `odb_for_each_object()`.
  - Link to v1: https://lore.kernel.org/r/20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (14):
      odb: rename `FOR_EACH_OBJECT_*` flags
      odb: fix flags parameter to be unsigned
      object-file: extract function to read object info from path
      object-file: introduce function to iterate through objects
      packfile: extract function to iterate through objects of a store
      packfile: introduce function to iterate through objects
      odb: introduce `odb_for_each_object()`
      builtin/fsck: refactor to use `odb_for_each_object()`
      treewide: enumerate promisor objects via `odb_for_each_object()`
      treewide: drop uses of `for_each_{loose,packed}_object()`
      odb: introduce mtime fields for object info requests
      builtin/pack-objects: use `packfile_store_for_each_object()`
      reachable: convert to use `odb_for_each_object()`
      odb: drop unused `for_each_{loose,packed}_object()` functions

 builtin/cat-file.c     |  30 +++++++--
 builtin/fsck.c         |  57 ++++------------
 builtin/pack-objects.c |  47 +++++++-------
 commit-graph.c         |  46 +++++++++----
 object-file.c          | 120 ++++++++++++++++++++++------------
 object-file.h          |  21 +++---
 odb.c                  |  29 +++++++++
 odb.h                  |  43 ++++++++++--
 packfile.c             | 173 +++++++++++++++++++++++++++++++++----------------
 packfile.h             |  18 ++++-
 reachable.c            | 129 +++++++++++-------------------------
 repack-promisor.c      |   8 +--
 revision.c             |  10 ++-
 13 files changed, 420 insertions(+), 311 deletions(-)

Range-diff versus v1:

 1:  1202ac1d9d =  1:  7658b0e3d1 odb: rename `FOR_EACH_OBJECT_*` flags
 2:  8fd78aad98 =  2:  c082223854 odb: fix flags parameter to be unsigned
 3:  40e049c68b =  3:  9d00d20178 object-file: extract function to read object info from path
 4:  9eaebd1181 =  4:  213548b0ee object-file: introduce function to iterate through objects
 5:  d88e439de2 =  5:  1521d6285e packfile: extract function to iterate through objects of a store
 6:  85f52c0db7 =  6:  7dcb9e5cb1 packfile: introduce function to iterate through objects
 7:  ed42cbcf6b !  7:  9ab2a31068 odb: introduce `odb_for_each_object()`
    @@ odb.h: typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
     + * objects may be iterated over multiple times in case they are either stored
     + * in different backends or in case they are stored in multiple sources.
     + *
    -+ * Returning a non-zero error code will cause iteration to abort. The error
    -+ * code will be propagated.
    ++ * Returning a non-zero error code from the callback function will cause
    ++ * iteration to abort. The error code will be propagated.
     + *
     + * Returns 0 on success, a negative error code in case a failure occurred, or
     + * an arbitrary non-zero error code returned by the callback itself.
 8:  39e10e18ed =  8:  343f2007bb builtin/fsck: refactor to use `odb_for_each_object()`
 9:  d3a87909f2 =  9:  a524a2aae8 treewide: enumerate promisor objects via `odb_for_each_object()`
10:  06392d8a2e ! 10:  f375828c1f treewide: drop uses of `for_each_{loose,packed}_object()`
    @@ Commit message
     
         Prepare for this by refactoring the sites accordingly.
     
    +    Note that ideally, we'd convert all callsites to use the generic
    +    `odb_for_each_object()` function already. But for some callers this is
    +    not possible (yet), and it would require some significant refactorings
    +    to make this work. Converting these site will thus be deferred to a
    +    later patch series.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/cat-file.c ##
11:  4a9e5687d0 = 11:  b2b2025502 odb: introduce mtime fields for object info requests
12:  80284057a8 = 12:  8b596e7a8e builtin/pack-objects: use `packfile_store_for_each_object()`
13:  7c38197ee5 = 13:  b8bb1cf980 reachable: convert to use `odb_for_each_object()`
14:  886002ba49 = 14:  b53ac29d2c odb: drop unused `for_each_{loose,packed}_object()` functions

---
base-commit: 1ff0e42d332523a11cc3d61b8d8463db5f9f14e8
change-id: 20260115-pks-odb-for-each-object-60b78cde09fd

