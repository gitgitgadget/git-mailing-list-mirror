Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A397F7FC
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474413; cv=none; b=bCx7qTAiPkFVl1C6tUrWZB86zhxiqJ4h2OczNcKGYxarLa3IZ6rK91TbF2QkSKTWK9brJSPEDktCwMlx2PpahD8WSdlE0vp8FEHm71yuPYet7cN+HuXyt7TurV0j6AY7vI11JwLSIiHh64BKcrFJDJDbpIEhlUCYXlIISbcFgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474413; c=relaxed/simple;
	bh=aiCZtligYjZaBoGIrlVwYbjB+8y+EZrYqTZR//AbH18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRBgDaNeXMev8Lug0b0hvETAlauqVthE5DJKQ8ytTSbFufiEjYHZb8z60CR3dLtSluPOKxTfGqF3eLJmxqVeILm+mcrApQIXqBVkfhbQBkxV7bCi9GBQreMSV9oWuya5buyOmPq481npU7bdwvecAu67AtGMoJuFL4sjT4nBwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=O64TXD6u; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="O64TXD6u"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7d7f7151f0so347880276.0
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474409; x=1749079209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQcwPT2JaYRVjg4VjX6YEj4Qe+WQbY0L2wxMY9OYTNo=;
        b=O64TXD6uQueRMUla7f4QndSOp05tlqpyqxzxlLKz3Oi4ow7O4pRSC9xEB6M6Xb4hJx
         kZRIRE96BrYG51dgUOliz/E8t+9lNFdl2Hr9TRVZ0NEmgw6awC3YyrbzGk7tmdEhKMHR
         13oeZ4nXBtgGdPcr5ub58rvl5ud0NBV1M9+bx6poPp5HVkS4F0cA+Zw66LvsmrI0tbMz
         qu2SjqS7PMNBr9VpDFqbSwtxK6U6Twm5BuI3yEBRbhD8kk5L1gh+jotGCSv8EGOvk5qQ
         U1q6HakBw1F4WPLFdcGAomjTsPD2QU8P7J1OUse+CHpgtsfGNDKcP0y+7gJW0oqR4Odh
         Tihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474409; x=1749079209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQcwPT2JaYRVjg4VjX6YEj4Qe+WQbY0L2wxMY9OYTNo=;
        b=hGlA5BdKqU+RMGMe0woab97XbzyjxTG1tNH6idXpzTJgDDCBmkR9b0L7C9yP2+d2Mn
         nYs9jWGprPMjO691vWEPRp+QrQB7bV2lnQbHVgZZ0+taKLhrl3VLzHKc11UkMfa3JsBY
         In2XrD5Cn6TwBLIHBZ+EbX856N31GrcjGfQnTMMYAvfO+SmZjgLjtxv47LtD9Xc5VwKR
         UOrBDiLz7dmoMIKV2f1u3qDLVN6wog6Hv2lxGL4MzSWE9KtmX/JNZyMRuBsqZYLhEook
         uVoQnx0DGj4CBu6787xfVLmnSN5445A55h3KmBkABXaCoJnqJ2oYpe25h5Tge5XjI4zY
         d7wQ==
X-Gm-Message-State: AOJu0YzOjMjEV4kI5Dxmf573TihtXxBFAQ+v0Quls/wJMRcdOw/RNrV5
	1x3iZlOvRx6FiIuBhx7fTiDt+zy/BgAvPmTlWee0Jg6bq5KTpFqOB/VV8AnAuJoIJiq996DTknj
	8z9WM
X-Gm-Gg: ASbGncuRHHYAPsno/yQ8+h2wg4bsWumimkWw/rBT+vCspDQnqMr9iJsmhCao744vwfh
	ejy/LdCVXvI35xjbOIviYeCVt+qIC/ziwV9Omr3BU0IYLG2PZTlMa+KKfxMnWTO3la7cpp+XRia
	l9a6Dy8pnUIng8NAM/o2QCJ5dzxhmYoGh2TEe23ggXJMHqmgEFJL+zw+AtHxwY8UkPIfqujuktB
	Iftv7JpZ6hC13lqslhGUJ6HSFmMH826dpPV4kYhDbclFrO+IYLIbgnz+NVQG6WO8aS46RZS6MwW
	eiZ9zhpsSKGVYQ4l9DH+ZWKWb9xDt5b+/Bz6xO6EjtA5aapjdkjSyh9Psvooxxn4ckoe5uaG8tY
	l+bqBwPVOTVRs4u4WhnfTyio=
X-Google-Smtp-Source: AGHT+IEMfGqYcpGdIp8KF9fCjKyKDy4oyBXHB463J8vZTCeUSXTdJOG68GJwQlDQwgk7cr6kHt/VSw==
X-Received: by 2002:a05:6902:2d05:b0:e7d:d150:4d90 with SMTP id 3f1490d57ef6-e7dd1504dd3mr8212229276.24.1748474408780;
        Wed, 28 May 2025 16:20:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f733c9f9csm32550276.17.2025.05.28.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:08 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/9] repack: avoid MIDX'ing cruft pack(s) where possible
Message-ID: <cover.1748473889.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

Here is a tiny reroll of my series to explore creating MIDXs while
repacking that don't include the cruft pack.

The only changes since last time are as follows:

 - removed a stray whitespace change in patch 2/9 caught by Junio and
   Elijah

 - reworded the final commit message based on helpful feedback from
   Elijah.

The rest of the series is unchanged, and a range-diff is included below
as usual for convenience.

A meta-note on something new since last time: I have deployed a
cherry-picked version of this series to GitHub's infrastructure a few
weeks ago. The testing repository (whose maintenance failure many years
ago precipitated commit ddee3703b3 (builtin/repack.c: add cruft packs to
MIDX during geometric repack, 2022-05-20)) has been happily running
maintenance tasks without any issues since then, and the cruft pack has
been excluded from the MIDX.

Thanks in advance for any review :-).

Taylor Blau (9):
  pack-objects: use standard option incompatibility functions
  pack-objects: limit scope in 'add_object_entry_from_pack()'
  pack-objects: factor out handling '--stdin-packs'
  pack-objects: declare 'rev_info' for '--stdin-packs' earlier
  pack-objects: perform name-hash traversal for unpacked objects
  pack-objects: fix typo in 'show_object_pack_hint()'
  pack-objects: swap 'show_{object,commit}_pack_hint'
  pack-objects: introduce '--stdin-packs=follow'
  repack: exclude cruft pack(s) from the MIDX where possible

 Documentation/config/repack.adoc    |   7 +
 Documentation/git-pack-objects.adoc |  10 +-
 builtin/pack-objects.c              | 190 ++++++++++++++++++----------
 builtin/repack.c                    | 163 +++++++++++++++++++++---
 t/t5331-pack-objects-stdin.sh       |  84 +++++++++++-
 t/t7704-repack-cruft.sh             |  90 +++++++++++++
 6 files changed, 455 insertions(+), 89 deletions(-)

Range-diff against v3:
 1:  986bef29b5 !  1:  f8b31c6a8d pack-objects: limit scope in 'add_object_entry_from_pack()'
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>

      ## Commit message ##
    -    pack-objects: limit scope in 'add_object_entry_from_pack()'
    +    pack-objects: use standard option incompatibility functions

    -    In add_object_entry_from_pack() we declare 'revs' (given to us through
    -    the miscellaneous context argument) earlier in the "if (p)" conditional
    -    than is necessary.  Move it down as far as it can go to reduce its
    -    scope.
    +    pack-objects has a handful of explicit checks for pairs of command-line
    +    options which are mutually incompatible. Many of these pre-date
    +    a699367bb8 (i18n: factorize more 'incompatible options' messages,
    +    2022-01-31).
    +
    +    Convert the explicit checks into die_for_incompatible_opt2() calls,
    +    which simplifies the implementation and standardizes pack-objects'
    +    output when given incompatible options (e.g., --stdin-packs with
    +    --filter gives different output than --keep-unreachable with
    +    --unpack-unreachable).
    +
    +    There is one minor piece of test fallout in t5331 that expects the old
    +    format, which has been corrected.

         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## builtin/pack-objects.c ##
    -@@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct object_id *oid,
    - 		return 0;
    +@@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
    + 		strvec_push(&rp, "--unpacked");
    + 	}

    - 	if (p) {
    --		struct rev_info *revs = _data;
    - 		struct object_info oi = OBJECT_INFO_INIT;
    --
    - 		oi.typep = &type;
    +-	if (exclude_promisor_objects && exclude_promisor_objects_best_effort)
    +-		die(_("options '%s' and '%s' cannot be used together"),
    +-		    "--exclude-promisor-objects", "--exclude-promisor-objects-best-effort");
    ++	die_for_incompatible_opt2(exclude_promisor_objects,
    ++				  "--exclude-promisor-objects",
    ++				  exclude_promisor_objects_best_effort,
    ++				  "--exclude-promisor-objects-best-effort");
    + 	if (exclude_promisor_objects) {
    + 		use_internal_rev_list = 1;
    + 		fetch_if_missing = 0;
    +@@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
    + 	if (!pack_to_stdout && thin)
    + 		die(_("--thin cannot be used to build an indexable pack"));
    +
    +-	if (keep_unreachable && unpack_unreachable)
    +-		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "--unpack-unreachable");
    ++	die_for_incompatible_opt2(keep_unreachable, "--keep-unreachable",
    ++				  unpack_unreachable, "--unpack-unreachable");
    + 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
    + 		unpack_unreachable_expiration = 0;
    +
    +-	if (stdin_packs && filter_options.choice)
    +-		die(_("cannot use --filter with --stdin-packs"));
    ++	die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
    ++				  filter_options.choice, "--filter");
     +
    - 		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
    - 			die(_("could not get type of object %s in pack %s"),
    - 			    oid_to_hex(oid), p->pack_name);
    - 		} else if (type == OBJ_COMMIT) {
    -+			struct rev_info *revs = _data;
    - 			/*
    - 			 * commits in included packs are used as starting points for the
    - 			 * subsequent revision walk
    +
    + 	if (stdin_packs && use_internal_rev_list)
    + 		die(_("cannot use internal rev list with --stdin-packs"));
    +@@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
    + 	if (cruft) {
    + 		if (use_internal_rev_list)
    + 			die(_("cannot use internal rev list with --cruft"));
    +-		if (stdin_packs)
    +-			die(_("cannot use --stdin-packs with --cruft"));
    ++		die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
    ++					  cruft, "--cruft");
    + 	}
    +
    + 	/*
    +
    + ## t/t5331-pack-objects-stdin.sh ##
    +@@ t/t5331-pack-objects-stdin.sh: test_expect_success '--stdin-packs is incompatible with --filter' '
    + 		cd stdin-packs &&
    + 		test_must_fail git pack-objects --stdin-packs --stdout \
    + 			--filter=blob:none </dev/null 2>err &&
    +-		test_grep "cannot use --filter with --stdin-packs" err
    ++		test_grep "options .--stdin-packs. and .--filter. cannot be used together" err
    + 	)
    + '
    +
 -:  ---------- >  2:  2753e29648 pack-objects: limit scope in 'add_object_entry_from_pack()'
 2:  6f8fe8a4e1 =  3:  32b49d9073 pack-objects: factor out handling '--stdin-packs'
 3:  2a235461a6 =  4:  a797ff3a83 pack-objects: declare 'rev_info' for '--stdin-packs' earlier
 4:  240e90b68d =  5:  29bf05633a pack-objects: perform name-hash traversal for unpacked objects
 5:  9a18fa2e52 =  6:  0696fa1736 pack-objects: fix typo in 'show_object_pack_hint()'
 6:  6c997853f1 =  7:  1cc45b4472 pack-objects: swap 'show_{object,commit}_pack_hint'
 7:  0ff699f056 =  8:  3e3d929bd0 pack-objects: introduce '--stdin-packs=follow'
 8:  58891101f3 !  9:  52a069ef48 repack: exclude cruft pack(s) from the MIDX where possible
    @@ Commit message
         MIDX with '--write-midx' to ensure that the resulting MIDX was always
         closed under reachability in order to generate reachability bitmaps.

    -    Suppose (prior to this patch) you have a once-unreachable object packed
    -    in a cruft pack, which later on becomes reachable from one or more
    -    objects in a geometrically repacked pack. That once-unreachable object
    -    *won't* appear in the new pack, since the cruft pack was specified as
    -    neither included nor excluded to 'pack-objects --stdin-packs'. If the
    +    While the previous patch added the '--stdin-packs=follow' option to
    +    pack-objects, it is not yet on by default. Given that, suppose you have
    +    a once-unreachable object packed in a cruft pack, which later becomes
    +    reachable from one or more objects in a geometrically repacked pack.
    +    That once-unreachable object *won't* appear in the new pack, since the
    +    cruft pack was not specified as included or excluded when the
    +    geometrically repacked pack was created with 'pack-objects
    +    --stdin-packs' (*not* '--stdin-packs=follow', which is not on). If that
         new pack is included in a MIDX without the cruft pack, then trying to
         generate bitmaps for that MIDX may fail. This happens when the bitmap
         selection process picks one or more commits which reach the
    -    once-unreachable objects, commit ddee3703b3 ensures that the MIDX will
    -    be closed under reachability. Without it, we would fail to generate a
    -    MIDX bitmap.
    +    once-unreachable objects.

    +    To mitigate this failure mode, commit ddee3703b3 ensures that the MIDX
    +    will be closed under reachability by including cruft pack(s). If cruft
    +    pack(s) were not included, we would fail to generate a MIDX bitmap. But
         ddee3703b3 alludes to the fact that this is sub-optimal by saying

             [...] it's desirable to avoid including cruft packs in the MIDX

base-commit: 485f5f863615e670fd97ae40af744e14072cfe18
--
2.49.0.640.ga4de40e6a8
