Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512528DF29
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375810; cv=none; b=LHsVN+VezVmnCYonHG6/MTEVYG66bl2pnN/a8rfzpa2RYyd0cHOgVLfDHTcbr96A8CUzzGLChz35SrXbNTbIGm5r7J1t+sGL29/iP10MeFdxDg2cIbVMCT/++c2a5jHQNmbBytuBm/Fe22UoIjNGoa+HmUBKU/CYJt/wIh+Q5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375810; c=relaxed/simple;
	bh=QCr0PvE+77hO3EUh/hfvcm/NEMDL9lK3HbncrLDFfhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4qj377N+slmHfctuckpswkMhBU2MH6Q6EQiIY5uF5y1cNwgYixL1ahQEZPIa/K0YyQOvLb6++OxcTNWonezXLBPUz7pNf3wjMapXoGifdun2R6nSzHiX/l+UWw84v/bmIsXs7jKr+EzqJIUIRM9k+Cpj3E91OizGTxGVYN7ElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VGbhze6p; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VGbhze6p"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e302191a3so12435067b3.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375807; x=1750980607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MKItNeqPND1XyV2G4eO0zdz0J0hQjDR3NaThTgsfJnU=;
        b=VGbhze6pSIs/CcVOYxjU2beUwO9rBq+39nZfbkj7ttGPEv6wP4xv4K7NxH0bzgRKH1
         XNvA5oV3jBryqZdp0BhEFsWpMWCFWammEzxKgYz2HoezUEZ0eYI5TXy9SJZbWgNSyRVv
         Almw2jDGqTK+DwknVVdleCj/HghJl2z+NQgRN08CjRAUCCYlJtF9H6b6ImSb1SQm15oh
         /by+M8yT90rk6J7xtJV3yf6Ovl4JIXC7zku1ovkYvfEHVIyxBFllOQ9ti1HTrVvLyw1M
         lvUh7G+lgJkB1a1NFg7zYxxtns/QI6bTDVkdYkvBLz77LDOSh5ObcweHyqrjFOQRHkK9
         9MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375807; x=1750980607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKItNeqPND1XyV2G4eO0zdz0J0hQjDR3NaThTgsfJnU=;
        b=DVieDo0cVbx5oAmP5TRAHHlmTXBYsH3EKOHAF1Wj3EjtbydGy+cLBXZYxInZjk6aS8
         CCqWZF74vur0g9yJm+bwnL4H4pGlUx+HMJLzC6y9w3z4qW1TJDlUEf7OzZlfxbuv9AnG
         8HYMzNQcUYT+u1m2wcHWxCG3x6j7McaDkVu65+2kp2gsWrFo9e4MpY5qS6YSdqsjxsvw
         7vcCTChOLQqPMZFmiOxtpnf+zPb74N2Qp5SkjZ1+Phx0rG6MmzS6Bs12EMSSUhJ43+y8
         1EO/81UW+H3ScDlSjVVgA/7mtB9BGaRgUDwUHcrZJHuI4tcRmLlDfIpNMYz68h/SpjRN
         iZbw==
X-Gm-Message-State: AOJu0Yw6/gUdjqssbP1lOpU4Rpu7cqOZXsp2FquCMM+xmIc25KsLfGxt
	eFgAQ6fUL/9aKv3BbhC/2p19RmlTqXwrqSVcjcQB9E03K0g6BTq+NCi/u0sQBuqyYaoYvtGWCe+
	YQEhd
X-Gm-Gg: ASbGnctJGx7D++C0B1feK8vOHhUuLwykWTvSgTsMAI+B5joGIrV15o4FAWnyT5VSYS5
	HiBOKbzgeuaGleSOlqEmKc8jQAz8fPq14Q1qNB3iAlyHEU7h3OYerW8Kf2NW6y3idzqJRkq5xiJ
	Q5JFV0yQlzFG0eluZlkR4AozgsxU1JVtuF18eeGoG+OLnF7HscEXw0xheeNUlGPHvH3yevp/Ubl
	JzhxNAVCUzlIVcUfMSy+5YfGASK9QrQY+LYfvZb/5GJivAmUrZlhZKeGfwfZW8U3V+DeOEV/Bva
	fD30FN4VrDsS8CjTFAXPMbx4GYRoTbRkQQOOdQ8ZrEEv/mynHDNwCX5zEKpsnEKtPYdWcodCy4h
	yz5XxZaS2yfbLHD/Ah3ZMzQ7Yp32RYW84BA==
X-Google-Smtp-Source: AGHT+IEQ+SWS2/lML1i+hh7h+GYPPOvqgcKaHtOl7vNKNRZ9dMV70QqQIGMldoRSsIX8BFuAsWiaxw==
X-Received: by 2002:a05:690c:c08:b0:70e:53a1:a814 with SMTP id 00721157ae682-712c6788737mr12603907b3.29.1750375806975;
        Thu, 19 Jun 2025 16:30:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4a238e7sm2086577b3.47.2025.06.19.16.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:06 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/9] repack: avoid MIDX'ing cruft pack(s) where possible
Message-ID: <cover.1750375803.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

(Junio: I rebased this onto the tip of current 'master', which is
f9aa0eedb3 (Start 2.51 cycle, the first batch, 2025-06-17) at the time
of writing.)

Here is another small reroll of my series to create MIDXs that do not
include a repository's cruft pack(s).

The bulk of the series is unchanged, save for a couple of points I'll
discuss below. As usual, a complete-range diff is included below for
convenience. There are two tiny but important changes that I included
here as a result of rolling this out to GitHub's infrastructure. They
are:

 - Tolerating missing objects in the follow-on traversal. When missing
   an object in a non "follow" `--stdin-packs` traversal, we didn't
   notice it because that traversal does not add discovered objects to
   the packing list. That is not the case for `--stdin-packs=follow`
   traversals which do. This has been corrected, and is explained in
   detail in the penultimate commit.

 - The behavior when writing a MIDX after a noop repack. There are
   some cases here where we may need to include the cruft pack in the
   MIDX depending on how the existing packs are structured. This is
   corrected and explained in more detail in the final commit.

There is an additional change that Carlo Marcelo Arenas Belón pointed
out[1] that drops the non-portable "grep -o" invocations added by the
previous round.

I promised in the last round that I'd report any interesting findings
after deploying this to GitHub's infrastructure. Here they are:

 - On unreachable object-heavy repositories, I was able to measure
   about a ~5% performance improvement across many operations.

 - GitHub's average time to repack a repository went down by about
   ~20% as a result of rolling this change out everywhere.

Thanks in advance for any review :-).

[1]: <lfrgmt2ukanevmcctzsnc422iv2l2nb3qmiddpsj6jnyvz4m4s@5eohhsm6knw3>

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
 builtin/pack-objects.c              | 193 ++++++++++++++++++----------
 builtin/repack.c                    | 184 +++++++++++++++++++++++---
 t/t5331-pack-objects-stdin.sh       | 122 +++++++++++++++++-
 t/t7704-repack-cruft.sh             | 145 +++++++++++++++++++++
 6 files changed, 570 insertions(+), 91 deletions(-)

Range-diff against v4:
 1:  f8b31c6a8d =  1:  ebaf47262a pack-objects: use standard option incompatibility functions
 2:  2753e29648 =  2:  eaa1f41b25 pack-objects: limit scope in 'add_object_entry_from_pack()'
 3:  32b49d9073 =  3:  8d0492a80d pack-objects: factor out handling '--stdin-packs'
 4:  a797ff3a83 =  4:  3d5d3b78b2 pack-objects: declare 'rev_info' for '--stdin-packs' earlier
 5:  29bf05633a =  5:  2a3676cb86 pack-objects: perform name-hash traversal for unpacked objects
 6:  0696fa1736 =  6:  bcbce75695 pack-objects: fix typo in 'show_object_pack_hint()'
 7:  1cc45b4472 =  7:  c8cf316c50 pack-objects: swap 'show_{object,commit}_pack_hint'
 8:  3e3d929bd0 !  8:  b81b6213e8 pack-objects: introduce '--stdin-packs=follow'
    @@ Commit message
         copy in the cruft pack, otherwise we cannot generate reachability
         bitmaps for any commits which reach that object.
     
    +    Note that the traversal here is best-effort, similar to the existing
    +    traversal which provides name-hash hints. This means that the object
    +    traversal may hand us back a blob that does not actually exist. We
    +    *won't* see missing trees/commits with 'ignore_missing_links' because:
    +
    +     - missing commit parents are discarded at the commit traversal stage by
    +       revision.c::process_parents()
    +
    +     - missing tag objects are discarded by revision.c::handle_commit()
    +
    +     - missing tree objects are discarded by the list-objects code in
    +       list-objects.c::process_tree()
    +
    +    But we have to handle potentially-missing blobs specially by making a
    +    separate check to ensure they exist in the repository. Failing to do so
    +    would mean that we'd add an object to the packing list which doesn't
    +    actually exist, rendering us unable to write out the pack.
    +
         This prepares us for new repacking behavior which will "resurrect"
         objects found in cruft or otherwise unspecified packs when generating
         new packs. In the context of geometric repacking, this may be used to
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
     -		return;
     +	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
     +	if (mode == STDIN_PACKS_MODE_FOLLOW) {
    ++		if (object->type == OBJ_BLOB && !has_object(the_repository,
    ++							    &object->oid, 0))
    ++			return;
     +		add_object_entry(&object->oid, object->type, name, 0);
     +	} else {
     +		struct object_entry *oe = packlist_find(&to_pack, &object->oid);
    @@ t/t5331-pack-objects-stdin.sh: test_expect_success 'pack-objects --stdin with pa
      	test_cmp expected-objects actual-objects
      '
      
    -+packdir=.git/objects/pack
    ++objdir=.git/objects
    ++packdir=$objdir/pack
     +
     +objects_in_packs () {
     +	for p in "$@"
    @@ t/t5331-pack-objects-stdin.sh: test_expect_success 'pack-objects --stdin with pa
     +		test_cmp expect actual
     +	)
     +'
    ++
    ++stdin_packs__follow_with_only () {
    ++	rm -fr stdin_packs__follow_with_only &&
    ++	git init stdin_packs__follow_with_only &&
    ++	(
    ++		cd stdin_packs__follow_with_only &&
    ++
    ++		test_commit A &&
    ++		test_commit B &&
    ++
    ++		git rev-parse "$@" >B.objects &&
    ++
    ++		echo A | git pack-objects --revs $packdir/pack &&
    ++		B="$(git pack-objects $packdir/pack <B.objects)" &&
    ++
    ++		git cat-file --batch-check="%(objectname)" --batch-all-objects >objs &&
    ++		for obj in $(cat objs)
    ++		do
    ++			rm -f $objdir/$(test_oid_to_path $obj) || return 1
    ++		done &&
    ++
    ++		( cd $packdir && ls pack-*.pack ) >in &&
    ++		git pack-objects --stdin-packs=follow --stdout >/dev/null <in
    ++	)
    ++}
    ++
    ++test_expect_success '--stdin-packs=follow tolerates missing blobs' '
    ++	stdin_packs__follow_with_only HEAD HEAD^{tree}
    ++'
    ++
    ++test_expect_success '--stdin-packs=follow tolerates missing trees' '
    ++	stdin_packs__follow_with_only HEAD HEAD:B.t
    ++'
    ++
    ++test_expect_success '--stdin-packs=follow tolerates missing commits' '
    ++	stdin_packs__follow_with_only HEAD HEAD^{tree}
    ++'
     +
      test_done
 9:  52a069ef48 !  9:  6487001f64 repack: exclude cruft pack(s) from the MIDX where possible
    @@ Commit message
         of subsequently generated packs from geometric repacking *is* closed
         under reachability.
     
    +    (One exception here is when "starting from scratch" results in a noop
    +    repack, e.g., because the non-cruft pack(s) in a repository already form
    +    a geometric progression. Since we can't tell whether or not those were
    +    generated with '--stdin-packs=follow', they may depend on
    +    once-unreachable objects, so we have to include the cruft pack in the
    +    MIDX in this case.)
    +
         Detect when this is the case and avoid including cruft packs in the MIDX
         where possible. The existing behavior remains the default, and the new
         behavior is available with the config 'repack.midxMustIncludeCruft' set
    @@ builtin/repack.c: int cmd_repack(int argc,
      	} else {
      		strvec_push(&cmd.args, "--unpacked");
     @@ builtin/repack.c: int cmd_repack(int argc,
    + 	if (ret)
    + 		goto cleanup;
    + 
    +-	if (!names.nr && !po_args.quiet)
    +-		printf_ln(_("Nothing new to pack."));
    ++	if (!names.nr) {
    ++		if (!po_args.quiet)
    ++			printf_ln(_("Nothing new to pack."));
    ++		/*
    ++		 * If we didn't write any new packs, the non-cruft packs
    ++		 * may refer to once-unreachable objects in the cruft
    ++		 * pack(s).
    ++		 *
    ++		 * If there isn't already a MIDX, the one we write
    ++		 * must include the cruft pack(s), in case the
    ++		 * non-cruft pack(s) refer to once-cruft objects.
    ++		 *
    ++		 * If there is already a MIDX, we can punt here, since
    ++		 * midx_has_unknown_packs() will make the decision for
    ++		 * us.
    ++		 */
    ++		if (!get_local_multi_pack_index(the_repository))
    ++			midx_must_contain_cruft = 1;
    ++	}
    + 
    + 	if (pack_everything & PACK_CRUFT) {
    + 		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
    +@@ builtin/repack.c: int cmd_repack(int argc,
      
      	string_list_sort(&names);
      
    @@ t/t7704-repack-cruft.sh: test_expect_success 'cruft repack respects --quiet' '
     +		cd exclude-cruft-when-necessary &&
     +
     +		test_path_is_file $(ls $packdir/pack-*.mtimes) &&
    -+		ls $packdir/pack-*.idx | sort >packs.all &&
    -+		grep -o "pack-.*\.idx$" packs.all >in &&
    -+
    -+		git multi-pack-index write --stdin-packs --bitmap <in &&
    ++		( cd $packdir && ls pack-*.idx ) | sort >packs.all &&
    ++		git multi-pack-index write --stdin-packs --bitmap <packs.all &&
     +
     +		test_commit five &&
     +		GIT_TEST_MULTI_PACK_INDEX=0 \
    @@ t/t7704-repack-cruft.sh: test_expect_success 'cruft repack respects --quiet' '
     +		test_line_count = "$(($(wc -l <packs.all) + 1))" midx.packs
     +	)
     +'
    ++
    ++test_expect_success 'repack --write-midx includes cruft when already geometric' '
    ++	git init repack--write-midx-geometric-noop &&
    ++	(
    ++		cd repack--write-midx-geometric-noop &&
    ++
    ++		git branch -M main &&
    ++		test_commit A &&
    ++		test_commit B &&
    ++
    ++		git checkout -B side &&
    ++		test_commit --no-tag C &&
    ++		C="$(git rev-parse HEAD)" &&
    ++
    ++		git checkout main &&
    ++		git branch -D side &&
    ++		git reflog expire --all --expire=all &&
    ++
    ++		# At this point we have two packs: one containing the
    ++		# objects belonging to commits A and B, and another
    ++		# (cruft) pack containing the objects belonging to
    ++		# commit C.
    ++		git repack --cruft -d &&
    ++
    ++		# Create a third pack which contains a merge commit
    ++		# making commit C reachable again.
    ++		#
    ++		# --no-ff is important here, as it ensures that we
    ++		# actually write a new object and subsequently a new
    ++		# pack to contain it.
    ++		git merge --no-ff $C &&
    ++		git repack -d &&
    ++
    ++		ls $packdir/pack-*.idx | sort >packs.all &&
    ++		cruft="$(ls $packdir/pack-*.mtimes)" &&
    ++		cruft="${cruft%.mtimes}.idx" &&
    ++
    ++		for idx in $(grep -v $cruft <packs.all)
    ++		do
    ++			git show-index <$idx >out &&
    ++			wc -l <out || return 1
    ++		done >sizes.raw &&
    ++
    ++		# Make sure that there are two non-cruft packs, and
    ++		# that one of them contains at least twice as many
    ++		# objects as the other, ensuring that they are already
    ++		# in a geometric progression.
    ++		sort -n sizes.raw >sizes &&
    ++		test_line_count = 2 sizes &&
    ++		s1=$(head -n 1 sizes) &&
    ++		s2=$(tail -n 1 sizes) &&
    ++		test "$s2" -gt "$((2 * $s1))" &&
    ++
    ++		git -c repack.midxMustContainCruft=false repack --geometric=2 \
    ++			--write-midx --write-bitmap-index
    ++	)
    ++'
     +
      test_done

base-commit: f9aa0eedb37eb94d9d3711ef0d565fd7cb3b6148
-- 
2.50.0.61.gf819b10624.dirty
