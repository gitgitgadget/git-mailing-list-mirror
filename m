Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7793F8EDE
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964971; cv=none; b=SYz/HXLbFV/UnfYD3l9Q0XanIGQd5xqIVTZTFtnRAFV+55CgACuwDEdjO+nUIIlIc/lecglWX5d0p+DkZJhwPNd3mze+7GYtnUEVqZMfDFWULKdQZmClN/A6VwzHsYOI2c0UYzri1D+XF9T2Z+hjzASoA916173KTD6H2X2lnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964971; c=relaxed/simple;
	bh=yaOdWN+gu2hGRsUUWCP578eGfcx9zqE0c0yRRPojte4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DO2nu0OMSEpHI4pwQpR6ENOa8cS5cT48xhGKpvLSC01Dq/bvIR5Q8dYyYIirz4s8bvumUK1TyZs4sLG5E2e86z6HSD6zNowTo8KZKlbOmXthh806xe9rWKnLVObSsHZEKdhTXy2CdoFB91mA6K1+0nlKPZVOcFj3DElxkLBUG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Af5PODb5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DarU1sxe; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Af5PODb5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DarU1sxe"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 12D8CEC01E0;
	Mon, 17 Aug 2026 07:09:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 17 Aug 2026 07:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786964969;
	 x=1787051369; bh=ou6fK3+NEtOKvdsF0r6xMLdYDmQRt1DSGRUA2h5Xvbs=; b=
	Af5PODb5XOCKhuuIF73Tud9D2WTbHkqWBqa+2DLXwt1CzjXBMkSBgX6l1EuheRpL
	7WGTix6e6eKXCOXyT1oX60SSdiDbneW2U++bl5XOLJ9YrvdEoC+IGZDXHzTkTGPw
	NyCWMYAs6MFbs3S6BSA2s0wD8B7q6cPUmtm13FDWrBenQUmzCaQYTuuGlZtdeUcC
	oiKQQtSC/w/FnJSkX78xiNm/az9Byu2x7AnfimlFj0EzZnYhIvGNzLHHmclV0BOB
	alFprSWfBS1I45enihu3qlIh0J9dsEhJz05GQzirboMyIK2lmD+Rqy3ZIdUAPsk4
	s/dyVJ95n8kq3gUuz1Bc/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786964969; x=
	1787051369; bh=ou6fK3+NEtOKvdsF0r6xMLdYDmQRt1DSGRUA2h5Xvbs=; b=D
	arU1sxeAMRux3a7XxkJBFG0i+G36HF9nhu0fb2n3eJrGxqnZUI1Py0+ZKSytEQ/n
	Q5V8F1PtDNVpZT2bcSW2BVlMZTdyqGeAS2RCEWW8y4koYSWYaSRAiLA3YeDtbU+n
	tHnPXU7NLZWyY3kWE7cKqEDYXdY4S6EXFYfx6nleIIDsV53ap2e8KOfGcmlv+qj0
	S5PS39eK+FufChN6G+4jUe3g1yu4cGlQDuF6e4DmaQacXc7pWKV7S3D7HVO9c6xj
	EsXzbJcgch3X1qL8XS5ZK8laIeyEM5j47ItMk9NaNUyPEHiIhD5tyouHV5ILia7N
	2ITOspkv5eJ446l1DzW9w==
X-ME-Sender: <xms:6OuCar-JgXhiIRV6nupxXaplThn2s778cqdWaRv4iIssSnd95ykQFQ>
    <xme:6OuCausALLI3V_fa6QyUo7OITkcJsXwUBShsJxUncoLGXLlqg8n77_Bedsx1xCIha
    EQi3R51rSEhtmi6RNokA79Lmh62hScmTgQSTvsIhq2WQtgUezd7T1M>
X-ME-Received: <xmr:6OuCauCTHXYzDefj0LMcgwlkgh15syqPDa9Bi6wbQ_qm-VH6oS9uUj3BfEY_PHR7VNJ-q5Qm939FVjfhhI2wc7dzu7XfcZ17pyaVX4i3nw>
X-ME-Proxy-Cause: dmFkZTGw1kpxbsMKvKnuB2NwOPV18M0BKhsa+gxX4R+Q4bo5nMm+V1nsVIzIGAUyGRv5Pw
    6UBQv96PoCcvsVlC2yuglrg+ZJ3EJTRyxWaRzKgRH1tK9SLeN22gISK+yO+iO6olEMXpZg
    ZMarcB42X6an8jVpL+DfY8ta1edJfqEa9dfNuvfJ+6RBg8k7y6dh/tgwV4GMieOf5Z0ezI
    +D2nB0uDr/gdkASGgRDkA3zhnGcZtTHKSx7WuwrrqUkTEJuRlZ728Y3+EE4lsVz5DGF6Zj
    F7DDiU3IZ4ekc2YQtDdpZoAIaVIsCA2wvSPxcS5ObD6i7ERrlRTjEoi8Di7jIgcRGhucOu
    BwZNWNTYsNMhtcaYwTzlloXCkQCZMIQnkWlZa5N2qD4Caj4+erpHWg7JR2CYsKV4U9TLl0
    2s7Skd1JTRTCoBBseFX2yC9PAsWCYOKuXusqZP1CD0STRoJFEDt1TCNVs8moiKs+fAUbSN
    +fJ1/iqPwYm/vJ05ksbSNTdT+HrBN562xnmzUW2eCgDDAezYuNYmHEqC7dPIWoMw3XzXlw
    QhboXW0OeVUfXCOr4cimZ2W0EmyS088k4bYJteTnUfUWham2A3QOG6TRGXXxJPOZ1HVlnQ
    LkcqGCztZkEnawDPYlpznAqLcamTEKhSb+u10urFLiIztsDM/exsFPnnlHzg
X-ME-Proxy: <xmx:6OuCamVEE0kAatV2Yood3hLDgeWc8uYd7pqUFXBzRcy0E8oLRTw8fg>
    <xmx:6OuCasASBL3zGYw3np4m9neWE-fEZMSE3x4iqlHx5pf2F2rNATok3Q>
    <xmx:6OuCap_JKjtbw9gp74tPu2yaClzUNvrDi5WgtEHITkD_uRchIwSAbQ>
    <xmx:6OuCajHG2-oubDFytow6DHcQOEmqJ9H6av3mLNe6gXSj0-LgvbsH1A>
    <xmx:6euCah_viZ2CrysGWoaaThdHOlWmkRUWEyKD6g42fXxwWNGq_dk2X9jR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:09:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd39a671 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 11:09:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] odb: eagerly load alternates
Date: Mon, 17 Aug 2026 13:09:20 +0200
Message-Id: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6dsy0gEFX3sO4mMIAVQTSViIh3
 N2Cxrhk+ZM3780kHFvDTpyiSVgejDNdG0a8i0ReU1sxmCJsoVAdMMME+ruDrtDAVLFtRugt92Q
 ZqPFsW/LsIOZSI8UZY1GIIApIaV5r5HL9bPfUN879Yl6I2jjf2XH9YpAL9w1K3BIcJCCUWFJCC
 WLC8hyO9uYhltqg/n1qk08FX6qUPlKqc8n0883z/AbS3UObMwEAAA==
X-Change-ID: 20260804-pks-odb-eagerly-prepare-alternates-3efb0a38e0dd
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

when initializing the object database we only eagerly initialize the
primary object database source. If the primary source has alternates,
those alternates are only initialized the first time we really access
the object database.

When introduced in ace1534d6f (Introduce SHA1_FILE_DIRECTORIES to
support multiple object databases., 2005-05-07), alternates were
originally only loaded when a given object wasn't found in the primary
object database. This was also reinforced by later optimization, for
example in 693d2bc625 (Attempt to delay prepare_alt_odb during get_sha1,
2007-05-26), where we tried to avoid loading alternates in even more
cases. But as Git has evolved, we eventually started to eagerly parse
alternates all over the codebase, including on every single object
lookup, and consequently deferring this operation does not really buy us
much anymore.

The result of this is that we have calls to `odb_prepare_alternates()`
cluttered all over the code base. This is somewhat awkward, and as
almost every Git command ends up reading objects at it doesn't even buy
us anything.

This patch series thus gets rid of the lazy-loading. Besides simplifying
the codebase a bit, it also prepares us for moving alternates into the
"files" backend as discussed in [1].

The series is built on top of 010afd3166 (The 12th batch, 2026-08-07)
with ps/odb-make-creation-pluggable at e927cfeb21 (odb: make creation of
on-disk structures pluggable, 2026-08-07) merged into it.

Changes in v3:
  - Create object database after we have written the complete repository
    configuration in `init_db()`.
  - Document that we might want to drop case-insensitive deduplication
    of alternates going forward.
  - Better explain why we have to migrate to `struct hashmap`.
  - Link to v2: https://patch.msgid.link/20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im

Changes in v2:
  - Add a missing word to a commit message.
  - Explain why we don't have to handle GIT_ALTERNATE_OBJECT_DIRECTORIES
    when re-preparing the object database.
  - Link to v1: https://patch.msgid.link/20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im

Thanks!

Patrick

[1]: <amLgMqkqxR8mKIbT@pks.im>

---
Patrick Steinhardt (5):
      setup: create ref and object databases after config is written
      odb: decouple source path comparisons from `the_repository`
      odb: eagerly initialize alternates
      odb: drop `loaded_alternates` field
      odb: drop `alternates_db` field

 builtin/fsck.c         |   3 --
 builtin/pack-objects.c |   3 --
 commit-graph.c         |   4 --
 loose.c                |   1 -
 object-name.c          |   1 -
 odb.c                  | 124 +++++++++++++++++++++++++++----------------------
 odb.h                  |  22 ++++-----
 odb/source.h           |   7 +++
 odb/streaming.c        |   1 -
 pack-bitmap.c          |   2 -
 packfile.c             |   1 -
 packfile.h             |   2 -
 setup.c                |  12 ++---
 13 files changed, 91 insertions(+), 92 deletions(-)

Range-diff versus v2:

-:  ---------- > 1:  2adb64d17c setup: create ref and object databases after config is written
1:  6255ac7964 ! 2:  736b8d8eb4 odb: decouple source path comparisons from `the_repository`
    @@ Commit message
         database. Instead of using `fspathhash()` and `fspatheq()` we resolve
         "core.ignoreCase" manually and then use the correct comparison function
         based on the result. This requires us to migrate to a `struct hashmap`,
    -    as the khash interface does not give us the ability to change these
    -    functions.
    +    as the khash interface does not give us the ability to pass an arbitrary
    +    payload to these functions, and hence we'd have to use global state to
    +    decide which of those to use.
     
         Note that we can unconditionally use `strihash()` to compute entry
         hashes regardless of case sensitivity: a hash function only needs to
    @@ Commit message
         case-insensitive equality.
     
         Overall it's quite debatable whether all of this complexity really is
    -    worth it, or whether we should just linearly search through all sources
    -    to find duplicates. But the mentioned commit cares about cases with
    -    thousands of alternates, and a linear search would of course regress
    -    performance quite a bit. This doesn't really feel like a reasonable case
    -    to care about though, but I don't feel comfortable regressing it anyway.
    +    worth it, out of two reasons:
    +
    +      - We could linearly search through all sources to find duplicates. But
    +        the mentioned commit cares about cases with thousands of alternates,
    +        and a linear search would of course regress performance quite a bit.
    +        This doesn't really feel like a reasonable case to care about, but I
    +        don't feel comfortable regressing it anyway.
    +
    +      - It's dubious whether we should handle "core.ignoreCase" in the first
    +        place. The downside would be that we might add the same alternate
    +        multiple times with different casing. But this is an edge case, and
    +        it's not even fully fixed because we don't resolve symlinks or
    +        mountpoints, either.
    +
    +    So for now, keep this infrastructure in-place while removing the global
    +    dependency on `the_repository`. We may want to revisit this in the
    +    future though.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ odb.c
      
     -KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
     -	struct odb_source *, 1, fspathhash, fspatheq)
    ++/*
    ++ * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
    ++ * _may_ be the same. This requires quite a bit of boilerplate for dubious
    ++ * benefit:
    ++ *
    ++ *   - Duplicating alternates should really only lead to regressed performance.
    ++ *
    ++ *   - We don't properly resolve symlinks or mointpoints, so we may still end
    ++ *     up duplicating alternates.
    ++ *
    ++ *   - The value may be lying, in which case we might deduplicate alternates
    ++ *     that are in fact not mapping to the same directory.
    ++ *
    ++ * We should investigate whether we can remove this whole mechanism outright.
    ++ */
     +static int odb_source_paths_cmp(struct object_database *o,
     +				const char *a, const char *b)
     +{
2:  4743659d76 = 3:  a9db918b49 odb: eagerly initialize alternates
3:  4a62dde9d0 = 4:  369a566a6a odb: drop `loaded_alternates` field
4:  e978a5a47d = 5:  a0a22a0bd2 odb: drop `alternates_db` field

---
base-commit: f6ad67a7977439ad8351d42e6ccfd11f714db765
change-id: 20260804-pks-odb-eagerly-prepare-alternates-3efb0a38e0dd

