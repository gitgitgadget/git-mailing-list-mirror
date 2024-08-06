Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C239FF3
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958602; cv=none; b=pNRltLm4K/P9coIw+v/e3aMrSfR/8qWLvqVNxe4W8lSl7bKYP27aHXYmXNjvGoPSHOimZEVGRVYPczdo6hHK6SQ+WeuLSLAx+kWaoXjQ9x41YWnoguRruqVrskTM5eV74PBXvQfF3o5QnAw4vDGqDqvw9LEPQTjUfFPwjNuxdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958602; c=relaxed/simple;
	bh=pAChfd0DHZ9yYBD5onupolz5yyXQ3/7S01/fBtJw804=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii0zhywhendzPkXabO5CemANXmuOArtyRxWq02Q+tbSogoFOEIHsyBoU8GHApiSEhQufvZF5EGoY6j4UwFzXVyyPYphp3Vhajp9o19/4jXftzME+1dY2mL90JRm1vmcwv03gegCUfQ0/ROGPLai1W6eIfQKklEtZqY9A/kNxdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FBrM3rbP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FBrM3rbP"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-67b709024bfso8294787b3.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958598; x=1723563398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRAVve9PIfdsfIaLrD5yAYypUWg9DzSy0m2etITBXtE=;
        b=FBrM3rbP4p+WtHYFwo876+7sfphqmC90AuEg72F2NVPVC6DAOlg9AJdUtwbcgx4Ame
         ZjR9NbwcVTS6Rk7ZqPqp7XThuUQwk7HtEjpMSputyqx39YfLzYFY2TEUe5A0Y+lYQ50v
         VKdAugAWT7Lez4+J/IZGMvb+ETNCJWNFyuwwceZ8F08ldGx7oRY40R4+qQdbMAHar7GG
         YHvxh0PpKU+hyv78zz7Mqr45BFevndrZPdTjPIIByqaVtGtxQKsHFJbcuQHtCec3fL1e
         asmOjgBIl7cAHSpczQLgeCx2yRGH178p6Ddq4vUGWD53jCkyY4urb2LIEkKYUcmT1QFW
         f4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958598; x=1723563398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRAVve9PIfdsfIaLrD5yAYypUWg9DzSy0m2etITBXtE=;
        b=eO3339DSVfs6B5VoO/CUXpgT5z4VD6LAtO9s92YFYnCHtg/gvBVdWqoE/GUlp9bXQF
         xIk3Xsw0v5ZfLVQ3tE4NbdoV28EkcAYkJP6hq9TIt3dHEax0dsg+62hekukZd2kez0aD
         yu07IThxXv68zj+F26U/dGMY5E9OuVnwDDnyn2+hLuuca4am7AOMnBj6E6GgtgMjTLcB
         4rg/0Ul7Yp+Ake5NTaFYHKup413pD7KNV15Z3zG46LJQ2qiNJFvsJ928yFVvEzvrDh0s
         7ZO0AaCLSaBD/SAV3CL+cmLBi/c+ulrvcq+S9npCAEU7ojHoopbvBm1HQ70c101uamUx
         CVEw==
X-Gm-Message-State: AOJu0YwzyNELsnLNaYyzxR8rK8VtETJaLV2LsqYEJbHfBHNkKVQC2Cdb
	RJGcmurZ4qQ5YtFmt5TwV8ADo5CaGEtSX/WatzemFOckNm9SJlFeDCGrOMw/Mgub+pfIJJ3a0F7
	c
X-Google-Smtp-Source: AGHT+IEPzSqzDom9EMP713NIyJKARlMe9AapLTVRkt8wt6Mpbjs3HcNNyx1x8ysy97XMBWuvmLhnWw==
X-Received: by 2002:a0d:dac4:0:b0:64b:89cd:7db8 with SMTP id 00721157ae682-689637fccf9mr163645377b3.28.1722958598535;
        Tue, 06 Aug 2024 08:36:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a10659ad7sm15806957b3.59.2024.08.06.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:36:37 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:36:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <cover.1722958595.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

This series implements incremental MIDXs, which allow for storing
a MIDX across multiple layers, each with their own distinct set of
packs.

This round is also similar to the previous one, but is rebased on
current 'master' (406f326d27 (The second batch, 2024-08-01)) and has
been updated in response to review from Peff on the previous round.

As usual, a range-diff is below, but the main changes since last time
are as follows:

  - Documentation improvements to clarify what happens when both an
    incremental- and non-incremental MIDX are both present in a
    repository.

  - Commit message typofix on 3/19 to fix an error in one of the
    technical examples.

  - Dropped a custom 'local_pack_int_id' in 4/19 to make the remaining
    diff easier to read.

  - Minor bugfix in 7/19 where we incorrectly terminated the object
    abbreviation disambiguation step for incremental MIDXs.

  - Various additional bits of information in the commit message to
    explain anything that was subtle.

Thanks in advance for any review! :-)

Taylor Blau (19):
  Documentation: describe incremental MIDX format
  midx: add new fields for incremental MIDX chains
  midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
  midx: teach `prepare_midx_pack()` about incremental MIDXs
  midx: teach `nth_midxed_object_oid()` about incremental MIDXs
  midx: teach `nth_bitmapped_pack()` about incremental MIDXs
  midx: introduce `bsearch_one_midx()`
  midx: teach `bsearch_midx()` about incremental MIDXs
  midx: teach `nth_midxed_offset()` about incremental MIDXs
  midx: teach `fill_midx_entry()` about incremental MIDXs
  midx: remove unused `midx_locate_pack()`
  midx: teach `midx_contains_pack()` about incremental MIDXs
  midx: teach `midx_preferred_pack()` about incremental MIDXs
  midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
  midx: support reading incremental MIDX chains
  midx: implement verification support for incremental MIDXs
  t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
  t/t5313-pack-bounds-checks.sh: prepare for sub-directories
  midx: implement support for writing incremental MIDX chains

 Documentation/git-multi-pack-index.txt       |  11 +-
 Documentation/technical/multi-pack-index.txt | 103 +++++
 builtin/multi-pack-index.c                   |   2 +
 builtin/repack.c                             |   8 +-
 ci/run-build-and-tests.sh                    |   2 +-
 midx-write.c                                 | 326 ++++++++++++---
 midx.c                                       | 405 ++++++++++++++++---
 midx.h                                       |  26 +-
 object-name.c                                |  99 ++---
 packfile.c                                   |  21 +-
 packfile.h                                   |   4 +
 t/README                                     |   6 +-
 t/helper/test-read-midx.c                    |  24 +-
 t/lib-bitmap.sh                              |   6 +-
 t/lib-midx.sh                                |  28 ++
 t/t0410-partial-clone.sh                     |   2 -
 t/t5310-pack-bitmaps.sh                      |   4 -
 t/t5313-pack-bounds-checks.sh                |   8 +-
 t/t5319-multi-pack-index.sh                  |  30 +-
 t/t5326-multi-pack-bitmaps.sh                |   4 +-
 t/t5327-multi-pack-bitmaps-rev.sh            |   6 +-
 t/t5332-multi-pack-reuse.sh                  |   2 +
 t/t5334-incremental-multi-pack-index.sh      |  46 +++
 t/t7700-repack.sh                            |  48 +--
 24 files changed, 960 insertions(+), 261 deletions(-)
 create mode 100755 t/t5334-incremental-multi-pack-index.sh

Range-diff against v2:
 1:  014588b3ec !  1:  90b21b11ed Documentation: describe incremental MIDX format
    @@ Documentation/technical/multi-pack-index.txt: Design Details
     +extending the incremental MIDX format to support reachability bitmaps.
     +The design below specifically takes this into account, and support for
     +reachability bitmaps will be added in a future patch series. It is
    -+omitted from this series for the same reason as above.
    ++omitted from the current implementation for the same reason as above.
     ++
     +In brief, to support reachability bitmaps with the incremental MIDX
     +feature, the concept of the pseudo-pack order is extended across each
    @@ Documentation/technical/multi-pack-index.txt: Design Details
     +multi-pack-index chain. The `multi-pack-index-$H2.midx` file contains
     +the second layer of the chain, and so on.
     +
    ++When both an incremental- and non-incremental MIDX are present, the
    ++non-incremental MIDX is always read first.
    ++
     +=== Object positions for incremental MIDXs
     +
     +In the original multi-pack-index design, we refer to objects via their
 2:  337ebc6de7 =  2:  0d3b19c59f midx: add new fields for incremental MIDX chains
 3:  f449a72877 !  3:  5cd742b677 midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
    @@ Commit message
           objects contained in all layers of the incremental MIDX chain, not any
           particular layer. For example, consider MIDX chain with two individual
           MIDXs, one with 4 objects and another with 3 objects. If the MIDX with
    -      4 objects appears earlier in the chain, then asking for pack "6" would
    +      4 objects appears earlier in the chain, then asking for object 6 would
           return the second object in the MIDX with 3 objects.
     
         [^2]: Building on the previous example, asking for object 6 in a MIDX
 4:  f88569c819 !  4:  372104c73d midx: teach `prepare_midx_pack()` about incremental MIDXs
    @@ midx.c: static uint32_t midx_for_object(struct multi_pack_index **_m, uint32_t p
      		die(_("bad pack-int-id: %u (%u total packs)"),
     -		    pack_int_id, m->num_packs);
     +		    pack_int_id, m->num_packs + m->num_packs_in_base);
    - 
    --	if (m->packs[pack_int_id])
    ++
     +	*_m = m;
     +
     +	return pack_int_id - m->num_packs_in_base;
    @@ midx.c: static uint32_t midx_for_object(struct multi_pack_index **_m, uint32_t p
     +{
     +	struct strbuf pack_name = STRBUF_INIT;
     +	struct packed_git *p;
    -+	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
     +
    -+	if (m->packs[local_pack_int_id])
    ++	pack_int_id = midx_for_pack(&m, pack_int_id);
    + 
    + 	if (m->packs[pack_int_id])
      		return 0;
    - 
    - 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
    --		    m->pack_names[pack_int_id]);
    -+		    m->pack_names[local_pack_int_id]);
    - 
    - 	p = add_packed_git(pack_name.buf, pack_name.len, m->local);
    - 	strbuf_release(&pack_name);
    -@@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t
    - 		return 1;
    - 
    - 	p->multi_pack_index = 1;
    --	m->packs[pack_int_id] = p;
    -+	m->packs[local_pack_int_id] = p;
    - 	install_packed_git(r, p);
    - 	list_add_tail(&p->mru, &r->objects->packed_git_mru);
    - 
 5:  ec57ff4349 =  5:  e68a3ceff9 midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 6:  650b8c8c21 !  6:  ff2d7bc5ca midx: teach `nth_bitmapped_pack()` about incremental MIDXs
    @@ Commit message
         ID. Likewise, when reading the 'BTMP' chunk, use the MIDX-local offset
         when accessing the data within that chunk.
     
    +    (Note that the both the call to prepare_midx_pack() and the assignment
    +    of bp->pack_int_id both care about the global pack_int_id, so avoid
    +    shadowing the given 'pack_int_id' parameter).
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## midx.c ##
 7:  bfd1dadbf1 !  7:  32c3fceada midx: introduce `bsearch_one_midx()`
    @@ object-name.c: static int match_hash(unsigned len, const unsigned char *a, const
      
     -	if (!num)
     -		return;
    -+		num = m->num_objects + m->num_objects_in_base;
    ++		if (!m->num_objects)
    ++			continue;
      
     -	bsearch_midx(&ds->bin_pfx, m, &first);
    -+		if (!num)
    -+			continue;
    ++		num = m->num_objects + m->num_objects_in_base;
      
     -	/*
     -	 * At this point, "first" is the location of the lowest object
 8:  38bd45bd24 =  8:  16db6c98ce midx: teach `bsearch_midx()` about incremental MIDXs
 9:  342ed56033 =  9:  761c7c59ba midx: teach `nth_midxed_offset()` about incremental MIDXs
10:  2b335c45ae = 10:  8366456d29 midx: teach `fill_midx_entry()` about incremental MIDXs
11:  22de5898f3 = 11:  909d927c47 midx: remove unused `midx_locate_pack()`
12:  fb60f2b022 = 12:  71127601b5 midx: teach `midx_contains_pack()` about incremental MIDXs
13:  38b642d404 = 13:  2f98ebb141 midx: teach `midx_preferred_pack()` about incremental MIDXs
14:  594386da10 ! 14:  550ae2dc93 midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
    @@ Commit message
             MIDX layers when dealing with an incremental MIDX chain by calling
             itself when given a MIDX with a non-NULL `base_midx`.
     
    +    Note that after 0c5a62f14b (midx-write.c: do not read existing MIDX with
    +    `packs_to_include`, 2024-06-11), we do not use this function with an
    +    existing MIDX (incremental or not) when generating a MIDX with
    +    --stdin-packs, and likewise for incremental MIDXs.
    +
    +    But it is still used when adding the fanout table from an incremental
    +    MIDX when generating a non-incremental MIDX (without --stdin-packs, of
    +    course).
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## midx-write.c ##
15:  dad130799c ! 15:  9ae1bc415e midx: support reading incremental MIDX chains
    @@ Commit message
         in the commit after next.)
     
         The core of this change involves following the order specified in the
    -    MIDX chain and opening up MIDXs in the chain one-by-one, adding them to
    -    the previous layer's `->base_midx` pointer at each step.
    +    MIDX chain in reverse and opening up MIDXs in the chain one-by-one,
    +    adding them to the previous layer's `->base_midx` pointer at each step.
     
         In order to implement this, the `load_multi_pack_index()` function is
         taught to call a new `load_multi_pack_index_chain()` function if loading
16:  ad976ef413 = 16:  3d4181df51 midx: implement verification support for incremental MIDXs
17:  23912425bf = 17:  3b268f91bf t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
18:  814da1916d = 18:  09d74f8942 t/t5313-pack-bounds-checks.sh: prepare for sub-directories
19:  e2b5961b45 = 19:  5d467d38a8 midx: implement support for writing incremental MIDX chains

base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
2.46.0.46.g406f326d27.dirty
