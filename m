Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C523D3CF5
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999834; cv=none; b=WJ3YhnRQP4stzWTxu9T+NYu0JJhBzNKf+gNLbpqMFGEaZ9KyftXdoJjnO/taOoxkvRhAk3fE7Rz+WUz5raEUeRSSE/G8cWZIfE2nQpXbqXFzjvN04+U7sx8YIt3Vcg2J5P3qmrY+ZYV4VnKt5yfw6aRRpA+d23iuTERoUMKSX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999834; c=relaxed/simple;
	bh=UJerkGlpwqnSH12uJZYrWzaUXT7XdqOCN0ZeqVf/u9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=kCkNYC0l2c6Y8O6QkIpR+Fsc0BwSSv3eWcvTrekYRqQCLKLcAJ1UcMyOb3g+VmgmFHPyYrkYy6w0zJkO63YSELfbhwTB4qyNb9xoTf8QUGvQW7B+Q+VHCxUqIdxhTUXn9r8xLCN6FYt6FwV2s97mAaFB+VVp/LrQCKqpASSIFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D6JCQ+Ri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcvZn8/h; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D6JCQ+Ri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcvZn8/h"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 119F17A0152;
	Wed, 21 Jan 2026 07:50:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 21 Jan 2026 07:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999830;
	 x=1769086230; bh=Q3yc8jr7C9DA47ZKB9edP3Sqq0HbZlr5AohyDd8zEFI=; b=
	D6JCQ+RiCj8mqFkjosqOCZELUX6/24tACedxaIGBDm/8YdgCY2WeO56peQjsrV4O
	d1RqzIeaTPS1n8oedIh/kul5YEHt8g5WQV787StDhwZU38XWGWo/60Ikz9j4Ahv7
	PTGv375o48csU52raQKukOcV7aYZD218dVcAECLz5ApRLdq/kfC7iLjG4/O7WFC+
	VdDel/aZ16LKyfteW2RUmUOgiYMYzdM79XYE2Oe1mrXDHB+lq4BLRGrF2T7KLU+d
	QG7pziSwWoEyE7DQddoSfwxop1DJih70HJOfzBuYQbwc3FLHS8EfX5LDVK6J9IC/
	KfG9Fjf8HIMrXnGwB0u3HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999830; x=
	1769086230; bh=Q3yc8jr7C9DA47ZKB9edP3Sqq0HbZlr5AohyDd8zEFI=; b=U
	cvZn8/hbVwQQs1MZyy5qmFspoxWOyHmpSk1YPgooC8QJ5I/jirWs9mOTzm+O4+ZK
	F1JTgkTofFLS2fv9GWMUhbxj6vPaSkHaD0f+N9JOzybPoGMRpUKXi1cO8oDi3RpA
	i6hirF0lny0asXf7VukxIa5lAPguzKtGSkbjRGOr4pPcWs3S2jaATYtf2SaEdKlo
	gmHoP8t+bLAtjbgSnbUCcZ0kkEcTjpew/nIY6uFU71T5u+46V90p1GQGZS9yOZY3
	O+OTn4Cfc5smEAGErJDwvvGPM0ZZTs8YeOixDd8ne4x5ejp+/aB/czqdsJqhSddj
	9v7W5D5Vw68ozFgbtXflw==
X-ME-Sender: <xms:lstwabcLIYzOUDqlBr5zqeYEg0quB-_HNSQJvzTSKh7szmclWsO53Q>
    <xme:lstwaYMnezwhUVb8QHVrhvTTupktE4ajq1wM_KemVcVOqGO6_3gn6cJNHHv0xz3NT
    FwJkc4eIBT66RT68_Nk-1kaBpLgy0URfLjxsVrsdxvKW-2-YpMF4A>
X-ME-Received: <xmr:lstwaZiSndpFyhW8ljjJP6FMXQhe_07JcNb4Xzkg6hrDCo4-YBWQ4W7bPnIW9IAJekxDwCf6iwQOv5WMtLQoNQpWoh-Be4y7KidJQADOSLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:lstwab0IDHRuvxCP5sNF-z6FgWHv38lWxjISibQ9r589g4IIiKdn2A>
    <xmx:lstwaTi8dtr8_auZK7PV3oYevnvWTqd03sDAyczJhXD1YpGlmpSsnw>
    <xmx:lstwabfB3hPfs7uBgTJmWRArLbDwQF7INsluR1wLfuU02U75-jQEcQ>
    <xmx:lstwaWn4gWbW5-yH__PdPQI9SlJ6cnAgZkNuL66NtIImoNrsnOAUsw>
    <xmx:lstwadDmYClk31Yigea0cl2uYv98UdLC1LN-MFkl7omXmdiUaQwjttMF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c666080 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/14] odb: introduce `odb_for_each_object()`
Date: Wed, 21 Jan 2026 13:50:16 +0100
Message-Id: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIjLcGkC/4XNwQ7CIAyA4VcxnK0BJnN48j2Mh0GLQ+NYYCGaZ
 e8u28F4MR7/pv06sUTRU2LHzcQiZZ986EtU2w2zXdtfCTyWZpLLmguhYLgnCGjAhQjU2g6CuZE
 doebm0Fgkrh2ycj1Ecv65yudL6c6nMcTX+iiLZfrfzAI4qL1oWi1QodansrnzD7aAWX4hkv9GZ
 EGQK2scVli75oPM8/wGtiIGRgABAAA=
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

Changes in v3:
  - Fix error code propagation in last commit.
  - Link to v2: https://lore.kernel.org/r/20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im

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
 builtin/pack-objects.c |  47 ++++++-------
 commit-graph.c         |  46 +++++++++----
 object-file.c          | 120 +++++++++++++++++++++------------
 object-file.h          |  21 +++---
 odb.c                  |  29 ++++++++
 odb.h                  |  43 ++++++++++--
 packfile.c             | 180 +++++++++++++++++++++++++++++++++----------------
 packfile.h             |  18 ++++-
 reachable.c            | 129 ++++++++++-------------------------
 repack-promisor.c      |   8 +--
 revision.c             |  10 ++-
 13 files changed, 426 insertions(+), 312 deletions(-)

Range-diff versus v2:

 1:  3cd6a9b898 =  1:  f931af359e odb: rename `FOR_EACH_OBJECT_*` flags
 2:  2b9a766928 =  2:  4454d3b8e6 odb: fix flags parameter to be unsigned
 3:  e5a8257291 =  3:  0953291ffc object-file: extract function to read object info from path
 4:  309fb50d2a =  4:  b0a8ff2d9d object-file: introduce function to iterate through objects
 5:  8332af532d =  5:  def018bbca packfile: extract function to iterate through objects of a store
 6:  17675561dc =  6:  caccd45aa0 packfile: introduce function to iterate through objects
 7:  aa79e2f2ea =  7:  4e429e52b2 odb: introduce `odb_for_each_object()`
 8:  33737e286b =  8:  8f16adec2c builtin/fsck: refactor to use `odb_for_each_object()`
 9:  606b944a67 =  9:  a1c95ffc4f treewide: enumerate promisor objects via `odb_for_each_object()`
10:  bf31434259 = 10:  c0ecc5517e treewide: drop uses of `for_each_{loose,packed}_object()`
11:  359ac505ae = 11:  1687ac9f3c odb: introduce mtime fields for object info requests
12:  eb7c6f5571 = 12:  1d4b35e3a5 builtin/pack-objects: use `packfile_store_for_each_object()`
13:  80227f4d71 = 13:  f360ff980a reachable: convert to use `odb_for_each_object()`
14:  b614e33feb ! 14:  bbad8b1a2b odb: drop unused `for_each_{loose,packed}_object()` functions
    @@ packfile.c: int packfile_store_for_each_object(struct packfile_store *store,
     +		ret = for_each_object_in_pack(p, packfile_store_for_each_object_wrapper,
     +					      &data, flags);
     +		if (ret)
    -+			break;
    ++			goto out;
     +	}
     +
    -+	store->skip_mru_updates = false;
    ++	ret = 0;
      
    - 	return pack_errors ? -1 : 0;
    +-	return pack_errors ? -1 : 0;
    ++out:
    ++	store->skip_mru_updates = false;
    ++
    ++	if (!ret && pack_errors)
    ++		ret = -1;
    ++	return ret;
      }
    + 
    + struct add_promisor_object_data {
     
      ## packfile.h ##
     @@ packfile.h: typedef int each_packed_object_fn(const struct object_id *oid,

---
base-commit: 1ff0e42d332523a11cc3d61b8d8463db5f9f14e8
change-id: 20260115-pks-odb-for-each-object-60b78cde09fd

