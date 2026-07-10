Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A96341ADF
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673346; cv=none; b=rWvR1jsmTiEhI93ihPKF9RadfdqkfzXU4JA6pFR76yO6WAp2NntV8Li3iHBElHiw1Yy+JJaJUtFDHY5Kbh80xXLE0C4x+zOKGMpRAqxE2aj35sE6FxfCCeDpCTzjQNwcnf57nRbD0bdgGP4VjjSfi1d9FzxjKHFKhVvYU4+GxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673346; c=relaxed/simple;
	bh=ZI9zhia0750W7K56tmpdLpzjErrwK3CgDDdza51r5/g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=YRW7EBSN9jfKSMeeeGxSMqRKn6sFebfaIqj6VAY20L2u0FOGxkqQkJT1i5+l03rhokbOmFhgX/leqSa5Cg18ecJUIkdINUsVopI+I4AQzKxLMFCU8Gx8Ub+EdMIH7zrt5IQqZd/ZH2p8SeztNY83SXRF5HlalsFZqHG+qPCzyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ci7WeD57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YTKSRhpb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ci7WeD57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YTKSRhpb"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C77FEC0112;
	Fri, 10 Jul 2026 04:49:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jul 2026 04:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673343;
	 x=1783759743; bh=n3JltU2r0TEzNvI6H2USNyAXpizGawjQRHOWaRSrbBA=; b=
	Ci7WeD576NmOucrJl4BgGZ/k2QI9i7DysCt+kv2662jcqMNvh9hvC2jlsSEjbx/W
	baPMCH2EqYN8xa+RXrZ2FQiF6FYUaZEPAAvwR4ZzWTjRQIugZmqaL43vwgULRxY4
	d4eI10vyQRROIBO10mJXlNnfijlkvqWgGXAKr/t0wN5HaG44+geqWt6F0wD81kmc
	Cgm8euukHy9D+9zR04btwVu/MX1u0O6k+jkXPFqzGU5cbufovk54OBCCvVT9UOGR
	O6DTsuyG9Z/ypmjfmrLPuZRiXA7nmkyIjjLTiPyypUCafv1UgfEf589aGSSyjvAZ
	AGj3ch1xzLGwaTY3qt62nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673343; x=
	1783759743; bh=n3JltU2r0TEzNvI6H2USNyAXpizGawjQRHOWaRSrbBA=; b=Y
	TKSRhpbesy8SkrcEc06E+tkMD/RCjAUCb2Z117AL41dsefRGbamEMLMah2OCqt3J
	rdOnF0ogNWKsApZI9XCKQSzy8v6Jul7j73jbvKkr/jumL2I7bgvAnSMBbg2icMgX
	Vu6oiH/I7OkqPF31VHMAuNd1OlixYmOvdFdT++XGokCpwK+q7RT12do7UbXHHEjU
	Buulv79MMTnRKdHTmDn6+FnBGtRZOAiqW6eMOZpx8cebGxv2xKFxBy6aztL9O7SN
	YnTgg8d3W/e0R4f8sAsOlQNx+OaqNkvxiiv6ld0bfc8q5wn1EodFl2DKUoBPX/PF
	H0EvrkOwwsjaCsKa/y5ew==
X-ME-Sender: <xms:_7FQagTJu3DE555BHjqUxTzKBj5D7fHAjXjtQY3m2RYgK7XRKkAE0w>
    <xme:_7FQalMmEDDORglyU_sS5XdOncQ8uF1Ue6X5O4Ccgk56GM-XIfookv4-ZQWHpjgVb
    T9wO8TT8bsdwuPygZoHExUoThrazmKO-fjP1ETwbyOOgl42LCgX>
X-ME-Received: <xmr:_7FQarPrUHz_nDZJXKnJamtSoI1rdx9kASqnHfX_y17o2A7Ac4keLz3SFzEyxBmKH3Hz_nK8P3vPl7-2DAORo27aTy6IssBeI5xHjTQZuPjQBA>
X-ME-Proxy-Cause: dmFkZTGVxzZDNbEOxmeF/o8Bpi8h9l1BtdGazS3CRNkaOQUo7/RVY4KIBki8YnwiUM6BiG
    Gv27M9GBmI/wmC7EGjnh1AN7jzhwot9zpzp13gBr4PvLfi61cGTIlMpBaZlAxnwFIqpRPd
    XFYTcGqr4e9g4Y0bpg1HQVMftERhKHgqts+4Q6WMuQReI9vhhUgSmozGOYffemmwVU+WeX
    Kb735UGkgJyKxQwbP3OvwVIYUzlXX2PK7/GklD7yxKKzZiljvLPLLEsod1IGV/Pxi07hrd
    VsqrOwdkkJEMEZEe5MpFiVo4cNA2f/sCtQGEa75tvagzemeVelkfXDLmVro5YhEP0b49YZ
    n6aPDH91xcIVagKwX8mVc98iANUt4J7sbJEE7WBh93vC+izkiL1zzDVCjrC85Mbqr/XA9o
    2NlWy8ZyENu3LvhYJr1X5QMCemisqFr5c7HRoYzjT0cBBIIXRAFYhaauUfb1ovN1HWBrMg
    w5DdOFs1156S0oLKHbUr3cWVw9L4z0LtHgNeDlCxFF9jZQ+xmcQgBisj5YoRGfG2KLnMdT
    OA+vh2/RD2c1OHDyJVOeWpGBW4m+x/M3NMg2m/f90TedoUVz5qU/4Kft985mtFQdbIZ/bz
    wqQyvDc4Oh52OiPMp0MFa6/tRexvmP8vrt7u6HvLBIvWFdIFsPaO3iMRwbLA
X-ME-Proxy: <xmx:_7FQatuwBQ4ohA-cVpqbzy27LDmWNUk4knq6q8uIddydlpa91oqE0Q>
    <xmx:_7FQatWKlnOBbO5s_NIODhzPhzjM2q7sXSQauv0M-xGyz-_S4P-05A>
    <xmx:_7FQatv7wTS4ckUAFJYlLzasA5huiV-GD39qzV8AFI0mTA_ef5jmqw>
    <xmx:_7FQahUIlkS3EhH9LT-dmp8OqYDyODR3QMNO_DpwYAls_KLAX4g2-A>
    <xmx:_7FQalPWWsn1x5c0XFXBEIfTy4nyQ9gYcC0LwXkORuknaBP26ge1ynUK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce8abfe9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] odb: introduce object filters to
 `odb_for_each_object()`
Date: Fri, 10 Jul 2026 10:48:52 +0200
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSxUGoC/4WOyw6CMBBFf4XM2jHt1Ae68j8MCwpTGR+UtEg0h
 H+3YFy7PMm999wRIgfhCMdshMCDRPFtAlplUDVle2GUOjGQop3aqxy7W0RfW3Q+IJdVg95euer
 Ryb3ngNpQvnOl2ZKpIY10gZ28FsG5+HJ8Lo15dU40Ensf3suDQc+5n+zwTzZoVJiTY6U3VpM1p
 1RYywOKaZo+uDAs1NsAAAA=
X-Change-ID: 20260708-pks-odb-for-each-object-filter-13286fa3523d
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series introduces object filters to `odb_for_each_object()`.
The intent of this is to make `git cat-file --batch-all-objects` work
with pluggable object databases. Right now it doesn't because it reaches
into internals of the "packed" backend to efficiently handle bitmapped
objects.

The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
2026-07-06) with ps/odb-drop-whence at 8a7ad23e11 (odb: document object
info fields, 2026-07-02) merged into it.

Changes in v2:
  - Add another patch to drop the `_1()` prefixes that aren't required
    anymore.
  - Change the approach in `open_bitmap_for_source()` to also use a
    `found` boolean instead of a confusing integer.
  - Add some more explanations to commit messages.
  - Link to v1: https://patch.msgid.link/20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      odb/source-packed: improve lookup when enumerating objects
      pack-bitmap: mark object filter as `const`
      pack-bitmap: allow aborting iteration of bitmapped objects
      pack-bitmap: iterate object sources when opening bitmaps
      pack-bitmap: drop `_1` suffix from functions that open bitmaps
      pack-bitmap: introduce function to open bitmap for a single source
      odb: introduce object filters to `odb_for_each_object()`
      builtin/cat-file: filter objects via object database

 builtin/cat-file.c     |  76 +++--------------------------
 builtin/pack-objects.c |   2 +-
 builtin/rev-list.c     |   2 +-
 odb.h                  |  12 +++++
 odb/source-packed.c    |  77 ++++++++++++++++++++++++++---
 pack-bitmap.c          | 129 +++++++++++++++++++++++++++----------------------
 pack-bitmap.h          |  10 +++-
 7 files changed, 171 insertions(+), 137 deletions(-)

Range-diff versus v1:

1:  7a1a92acbe ! 1:  b675967b78 odb/source-packed: improve lookup when enumerating objects
    @@ Metadata
      ## Commit message ##
         odb/source-packed: improve lookup when enumerating objects
     
    -    When iterating through packed objects via `odb_for_each_object()` we
    -    do so via two different mechanisms:
    +    When iterating through objects of a packed source that have a specific
    +    prefix we do so via two different methods:
     
           - When a multi-pack index is available we use that one to efficiently
             loop through all objects.
    @@ Commit message
     
           - It's subtly wrong, as it may now happen that a specific object will
             be looked up via a different pack in case it exists multiple times.
    +        This is unlikely to have any real-world consequences, but it's still
    +        the wrong thing to do.
     
         Fix the issue by using `packed_object_info()` directly. While at it,
         rename the `store` variable to `source`.
2:  a6c8bd7a61 = 2:  d3f9b2f781 pack-bitmap: mark object filter as `const`
3:  c38b06636b = 3:  825920205a pack-bitmap: allow aborting iteration of bitmapped objects
4:  450cdd13b7 ! 4:  a33ca8fa3b pack-bitmap: iterate object sources when opening bitmaps
    @@ pack-bitmap.c: static int load_bitmap(struct repository *r, struct bitmap_index
     +				  struct bitmap_index *bitmap_git)
      {
     -	struct packed_git *p;
    +-	int ret = -1;
     +	struct multi_pack_index *midx = get_multi_pack_index(source);
     +	struct packfile_list_entry *e;
    - 	int ret = -1;
    ++	bool found = false;
      
     -	repo_for_each_pack(r, p) {
     -		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
    @@ pack-bitmap.c: static int load_bitmap(struct repository *r, struct bitmap_index
     -				break;
     -		}
     +	if (midx && !open_midx_bitmap_1(bitmap_git, midx))
    -+		ret = 0;
    ++		found = true;
     +
     +	for (e = packfile_store_get_packs(source); e; e = e->next) {
     +		/*
     +		 * When tracing is enabled we want to keep looking to report
     +		 * duplicates even if we have already found a bitmap.
     +		 */
    -+		if (!ret && !trace2_is_enabled())
    ++		if (found && !trace2_is_enabled())
     +			break;
     +
    -+		if (open_pack_bitmap_1(bitmap_git, e->pack))
    -+			continue;
    -+		ret = 0;
    ++		if (!open_pack_bitmap_1(bitmap_git, e->pack))
    ++			found = true;
      	}
      
    - 	return ret;
    +-	return ret;
    ++	return found ? 0 : -1;
      }
      
     -static int open_midx_bitmap(struct repository *r,
    @@ pack-bitmap.c: static int load_bitmap(struct repository *r, struct bitmap_index
      {
      	struct odb_source *source;
     -	int ret = -1;
    -+	int found = 0;
    ++	bool found = false;
      
      	assert(!bitmap_git->map);
      
    @@ pack-bitmap.c: static int load_bitmap(struct repository *r, struct bitmap_index
     -	int found;
      
     -	assert(!bitmap_git->map);
    -+		found |= !open_bitmap_for_source(files->packed, bitmap_git);
    ++		if (!open_bitmap_for_source(files->packed, bitmap_git))
    ++			found = true;
      
     -	found = !open_midx_bitmap(r, bitmap_git);
     -
-:  ---------- > 5:  b890ed7163 pack-bitmap: drop `_1` suffix from functions that open bitmaps
5:  26b1957f8b = 6:  f7e466217b pack-bitmap: introduce function to open bitmap for a single source
6:  722727c76d ! 7:  27ecc0802f odb: introduce object filters to `odb_for_each_object()`
    @@ Commit message
         object filter infrastructure supports some filters that cannot be
         answered by the object database alone.
     
    +    An alternative might be to limit the filters to only those that _can_ be
    +    answered by backends. But ultimately, the filters that can be answered
    +    efficiently by the "packed" backend are completely disjunct from those
    +    that can be answered by the "loose" backend, and consequently the set of
    +    filters supported by all backends would be empty. Furthermore, it would
    +    require us to make assumptions about capabilities of future backends,
    +    which may be able to efficiently handle more filters than current ones.
    +    So in the end, this alternative would only limit us artificially.
    +
         Implement the logic for the "packed" source. Note that we use the new
         function `prepare_source_bitmap_git()` to open the bitmap: as the
         backend operates on a single object source, we must only use bitmaps
7:  90be28e904 ! 8:  e4c6aeab0a builtin/cat-file: filter objects via object database
    @@ Metadata
      ## Commit message ##
         builtin/cat-file: filter objects via object database
     
    +    When batching all objects, git-cat-file(1) reaches into the internals of
    +    the object database and manually manages bitmaps to apply object
    +    filters. This creates coupling between the command and the internals of
    +    the respective backend.
    +
         Refactor git-cat-file(1) to use the new object filter option when
         batching all objects. This significantly simplifies the logic and
         ensures that we don't have to reach into internals of the "files" source

---
base-commit: 3c8e2790f2ce15e8b5d4b4e6ced711b12649f32a
change-id: 20260708-pks-odb-for-each-object-filter-13286fa3523d

