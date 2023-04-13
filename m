Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3353CC77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjDMLQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDMLQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675607D83
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B441F5C00B9;
        Thu, 13 Apr 2023 07:16:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Apr 2023 07:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384567; x=1681470967; bh=Oe
        IsKNpKg4uO73AqsAwqoJivbUJW/mbzSK37qhuBIfU=; b=aVKQhZ87EhDuKEKY+i
        iNOng3cHQtSrG4F33rUYb7qOxJ90sMNe0i1TFUUGQGKmvqAwCOy69sKyz8oV2l5B
        5fHVAG+qWf7a4LQXXuVXqJOtEDylF12tDUSrb+kVaaVl6K+Zg7+yCfntTEYNhNtH
        lFDF459qRSh92eDZyarrwWKy5EfNcLiNIN6SOf+Roy+aJNhtA55wjtYIr6Q0Gq68
        GA/0eVjBJ0zThONvvQz19EU7n4dwrL1/Z+qzMm991NpDVJeg8/XWiEmFIwiiBXLe
        cuEyh+SjT6DSGxq5C0rVi8Y4Ik4XgC1WlFirXbgae/OosjOpqZkl3PW8zvVSkcQm
        cMpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384567; x=1681470967; bh=OeIsKNpKg4uO7
        3AqsAwqoJivbUJW/mbzSK37qhuBIfU=; b=FjutwW9H0kEryLvCMxVFltdZcxxBT
        t+sUvhiR01zZMruxCgZgq5PTN7B8JDXOt1jdKfylHHikbyQb0du+Z6oEe+PO7uln
        WunNP+LScBRPtP7B8hsNfmuSERHU423guo2IDtV7MWk8N/LpZEn2LoNMc9gWNqrW
        M3B7CWdN6LFcIMZTWP4mEGQS9F4yuonlKEJZ7kYiIne8WiaYKUgOwPZIaB75LPex
        u8OdiedlzvwTfBZvdQmlmzQCgvLcCGnxnwQLWutDtxgjsf35CrgPMGKG5X9b+W/c
        1BQgwkxmx6Sn5OtB9l49WHRSgvmnaWo6sT2bgAU05366PSnZ5ngru0hHA==
X-ME-Sender: <xms:d-Q3ZHtLciQaNo3GPwT0XDBIGUme9h2gYTSFAVAOrjB-2zgS4rd2NQ>
    <xme:d-Q3ZIfB1LtI8VnopLANrl_sWybQz6L59kL1OzUkWraTHMf-Hbo9QRMiudl43cSXn
    TblwKky6p0w9lh_Sw>
X-ME-Received: <xmr:d-Q3ZKwISpEkcKA4VQlm7yjKkxV1OMDwBgvRuIGPNumzLai8zyKdO8kqQ8wGmfKc-80hYLWCWBP5yGJX_CUVTA0M2nyFDlb6Qx_rQBX0FUlzFCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:d-Q3ZGOlw8uM88z_9IVpONUCeuTAcYoJHsFvRwOlxdIzsx6AzL7fGw>
    <xmx:d-Q3ZH8hbBZBH71MphepxZKIyK6MpQfRuuzJTz3D7KUsjbWiBXn1Jg>
    <xmx:d-Q3ZGX5HDYqP3d2BnVHlkGErVlFZNHveN6paSac4LADpU2FWVQshg>
    <xmx:d-Q3ZJI_5IEiSsjUUsVJBW5jM1u0XQw6jE72GT_6agyyigt_9vU37w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:06 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id adcb26de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:15:41 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 00/10] repack: fix geometric repacking with gitalternates
Message-ID: <cover.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l4xeR+C/NEH1D5GO"
Content-Disposition: inline
In-Reply-To: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l4xeR+C/NEH1D5GO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series to fix geometric repacking
with repositories that are connected to an alternate object database.

Changes compared to v2:

    - I've simplified patch 1 to reset the preferred pack index instead
      of moving around some of the checks. This also causes us to print
      the warning for missing preferred packfiles again.

    - I've fixed the logic in patch 2 to find the preferred packfile to
      not return a packfile that would be rolled up in a geometric
      repack.

    - I've added an additional patch to split out preexisting tests for
      `--stdin-packs` into their own test file.

    - I've changed the unportable test added for geometric repacking
      with `-l` that used stat(1) to instead use our `test-tool chmtime`
      helper.

    - I've changed the logic that disables writing bitmaps in git-repack
      to cover more cases. It now always kicks in when doing a repack
      with `-l` that asks for bitmaps when connected to an alternate
      object directory.

    - In general, there's a bunch of small improvements left and right
      for the tests I'm adding.

Thanks for all the feedback so far.

Patrick

Patrick Steinhardt (10):
  midx: fix segfault with no packs and invalid preferred pack
  repack: fix trying to use preferred pack in alternates
  repack: fix generating multi-pack-index with only non-local packs
  pack-objects: split out `--stdin-packs` tests into separate file
  pack-objects: fix error when packing same pack twice
  pack-objects: fix error when same packfile is included and excluded
  pack-objects: extend test coverage of `--stdin-packs` with alternates
  t/helper: allow chmtime to print verbosely without modifying mtime
  repack: honor `-l` when calculating pack geometry
  repack: disable writing bitmaps when doing a local repack

 builtin/pack-objects.c        |  10 +-
 builtin/repack.c              |  62 ++++++++-
 midx.c                        |   6 +-
 object-file.c                 |   6 +
 object-store.h                |   1 +
 t/helper/test-chmtime.c       |   2 +-
 t/t5300-pack-object.sh        | 135 -------------------
 t/t5319-multi-pack-index.sh   |  12 ++
 t/t5331-pack-objects-stdin.sh | 240 ++++++++++++++++++++++++++++++++++
 t/t7700-repack.sh             |  17 +++
 t/t7703-repack-geometric.sh   | 165 +++++++++++++++++++++++
 11 files changed, 505 insertions(+), 151 deletions(-)
 create mode 100755 t/t5331-pack-objects-stdin.sh

Range-diff against v2:
 1:  8c384aabde !  1:  dd8145bead midx: fix segfault with no packs and inva=
lid preferred pack
    @@ Commit message
         will cause a segfault as we blindly index into the array of packfi=
les,
         which would be empty.
    =20
    -    Fix this bug by exiting early in case we have determined that the =
MIDX
    -    wouldn't have any packfiles to index. While the request itself doe=
s not
    -    make much sense anyway, it is still preferable to exit gracefully =
than
    -    to abort.
    +    Fix this bug by resetting the preferred packfile index to `-1` bef=
ore
    +    searching for the preferred pack. This fixes the segfault as we al=
ready
    +    check for whether the index is `> - 1`. If it is not, we simply do=
n't
    +    pick a preferred packfile at all.
    =20
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## midx.c ##
     @@ midx.c: static int write_midx_internal(const char *object_dir,
    - 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
    - 	stop_progress(&ctx.progress);
    + 	}
     =20
    -+	if (!ctx.nr) {
    -+		error(_("no pack files to index."));
    -+		result =3D 1;
    -+		goto cleanup;
    -+	}
    + 	if (preferred_pack_name) {
    +-		int found =3D 0;
    ++		ctx.preferred_pack_idx =3D -1;
     +
    - 	if ((ctx.m && ctx.nr =3D=3D ctx.m->num_packs) &&
    - 	    !(packs_to_include || packs_to_drop)) {
    - 		struct bitmap_index *bitmap_git;
    + 		for (i =3D 0; i < ctx.nr; i++) {
    + 			if (!cmp_idx_or_pack_name(preferred_pack_name,
    + 						  ctx.info[i].pack_name)) {
    + 				ctx.preferred_pack_idx =3D i;
    +-				found =3D 1;
    + 				break;
    + 			}
    + 		}
    +=20
    +-		if (!found)
    ++		if (ctx.preferred_pack_idx =3D=3D -1)
    + 			warning(_("unknown preferred pack: '%s'"),
    + 				preferred_pack_name);
    + 	} else if (ctx.nr &&
    =20
      ## t/t5319-multi-pack-index.sh ##
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'write midx with -=
-stdin-packs' '
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'write midx with --=
stdin-packs'
     +	test_must_fail git -C empty multi-pack-index write \
     +		--stdin-packs --preferred-pack=3Ddoes-not-exist </dev/null 2>err &&
     +	cat >expect <<-EOF &&
    ++	warning: unknown preferred pack: ${SQ}does-not-exist${SQ}
     +	error: no pack files to index.
     +	EOF
     +	test_cmp expect err
 2:  5a6c2ead87 !  2:  c5db1bc587 repack: fix trying to use preferred pack =
in alternates
    @@ Commit message
         While at it, rename the function `get_largest_active_packfile()` to
         `get_preferred_pack()` to better document its intent.
    =20
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/repack.c ##
    @@ builtin/repack.c: static struct packed_git *get_largest_active_pack(=
struct pack_
      		return NULL;
     -	return geometry->pack[geometry->pack_nr - 1];
     +
    -+	for (i =3D geometry->pack_nr; i > 0; i--)
    ++	/*
    ++	 * The preferred pack is the largest pack above the split line. In
    ++	 * other words, it is the largest pack that does not get rolled up in
    ++	 * the geometric repack.
    ++	 */
    ++	for (i =3D geometry->pack_nr; i > geometry->split; i--)
     +		/*
     +		 * A pack that is not local would never be included in a
     +		 * multi-pack index. We thus skip over any non-local packs.
    @@ t/t7703-repack-geometric.sh: test_expect_success '--geometric with p=
ack.packSize
     +	test_must_be_empty err &&
     +
     +	# We should see that a new packfile was generated.
    -+	find shared/.git/objects/pack -type f -name "*.pack" | sort >packs &&
    -+	test $(wc -l <packs) =3D 1 &&
    ++	find shared/.git/objects/pack -type f -name "*.pack" >packs &&
    ++	test_line_count =3D 1 packs &&
     +
     +	# We should also see a multi-pack-index. This multi-pack-index should
     +	# never refer to any packfiles in the alternate object database.
    -+	# Consequentially, it should be valid even with the alternate ODB
    -+	# deleted.
    -+	rm -r shared &&
    -+	git -C member multi-pack-index verify
    ++	test -f member/.git/objects/pack/multi-pack-index &&
    ++	test-tool read-midx member/.git/objects >packs.midx &&
    ++	grep "^pack-.*\.idx$" packs.midx | sort >actual &&
    ++	basename member/.git/objects/pack/pack-*.idx >expect &&
    ++	test_cmp expect actual
     +'
     +
      test_done
 3:  f705cd6c49 !  3:  8c3193268f repack: fix generating multi-pack-index w=
ith only non-local packs
    @@ Commit message
         Fix the code to skip non-local packfiles.
    =20
         Co-authored-by: Taylor Blau <me@ttaylorr.com>
    +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/repack.c ##
    @@ builtin/repack.c: static void midx_included_packs(struct string_list=
 *include,
    =20
      ## t/t7703-repack-geometric.sh ##
     @@ t/t7703-repack-geometric.sh: test_expect_success '--geometric --wri=
te-midx with packfiles in main and alterna
    - 	git -C member multi-pack-index verify
    + 	test_cmp expect actual
      '
     =20
     +test_expect_success '--geometric --with-midx with no local objects' '
    @@ t/t7703-repack-geometric.sh: test_expect_success '--geometric --writ=
e-midx with
     +	# alternate object database does not invalidate the geometric sequen=
ce.
     +	# And we should not have a multi-pack-index because these only index
     +	# local packfiles, and there are none.
    -+	find member/.git/objects/pack -type f >actual &&
    -+	test_must_be_empty actual
    ++	test_dir_is_empty member/$packdir
     +'
     +
      test_done
 -:  ---------- >  4:  8d47d753dc pack-objects: split out `--stdin-packs` t=
ests into separate file
 4:  ff28829589 !  5:  ac528514e7 pack-objects: fix error when packing same=
 pack twice
    @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
      	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
      		const char *pack_name =3D pack_basename(p);
    =20
    - ## t/t5331-pack-objects-stdin.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+test_description=3D'pack-objects --stdin'
    -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    -+
    -+TEST_PASSES_SANITIZE_LEAK=3Dtrue
    -+. ./test-lib.sh
    + ## t/t5331-pack-objects-stdin.sh ##
    +@@ t/t5331-pack-objects-stdin.sh: export GIT_TEST_DEFAULT_INITIAL_BRAN=
CH_NAME
    + TEST_PASSES_SANITIZE_LEAK=3Dtrue
    + . ./test-lib.sh
    +=20
    ++packed_objects() {
    ++	git show-index <"$1" >tmp-object-list &&
    ++	cut -d' ' -f2 tmp-object-list | sort &&
    ++	rm tmp-object-list
    ++ }
     +
    + test_expect_success 'setup for --stdin-packs tests' '
    + 	git init stdin-packs &&
    + 	(
    +@@ t/t5331-pack-objects-stdin.sh: test_expect_success '--stdin-packs w=
ith broken links' '
    + 	)
    + '
    +=20
     +test_expect_success 'pack-objects --stdin with duplicate packfile' '
     +	test_when_finished "rm -fr repo" &&
     +
    @@ t/t5331-pack-objects-stdin.sh (new)
     +		test_commit "commit" &&
     +		git repack -ad &&
     +
    -+		(
    ++		{
     +			basename .git/objects/pack/pack-*.pack &&
     +			basename .git/objects/pack/pack-*.pack
    -+		) >packfiles &&
    ++		} >packfiles &&
     +
     +		git pack-objects --stdin-packs generated-pack <packfiles &&
    -+		test_cmp generated-pack-*.pack .git/objects/pack/pack-*.pack
    ++		packed_objects .git/objects/pack/pack-*.idx >expect &&
    ++		packed_objects generated-pack-*.idx >actual &&
    ++		test_cmp expect actual
     +	)
     +'
     +
    -+test_done
    + test_done
    =20
      ## t/t7703-repack-geometric.sh ##
     @@ t/t7703-repack-geometric.sh: test_expect_success '--geometric --wit=
h-midx with no local objects' '
    - 	test_must_be_empty actual
    + 	test_dir_is_empty member/$packdir
      '
     =20
     +test_expect_success '--geometric with same pack in main and alternate=
 ODB' '
 5:  8011603d6d !  6:  afd7c7864d pack-objects: fix error when same packfil=
e is included and excluded
    @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
     =20
    =20
      ## t/t5331-pack-objects-stdin.sh ##
    -@@ t/t5331-pack-objects-stdin.sh: export GIT_TEST_DEFAULT_INITIAL_BRAN=
CH_NAME
    - TEST_PASSES_SANITIZE_LEAK=3Dtrue
    - . ./test-lib.sh
    -=20
    -+packed_objects() {
    -+	git show-index <"$1" >tmp-object-list &&
    -+	cut -d' ' -f2 tmp-object-list &&
    -+	rm tmp-object-list
    -+ }
    -+
    - test_expect_success 'pack-objects --stdin with duplicate packfile' '
    - 	test_when_finished "rm -fr repo" &&
    -=20
     @@ t/t5331-pack-objects-stdin.sh: test_expect_success 'pack-objects --=
stdin with duplicate packfile' '
      	)
      '
    @@ t/t5331-pack-objects-stdin.sh: test_expect_success 'pack-objects --s=
tdin with du
     +		test_commit "commit" &&
     +		git repack -ad &&
     +
    -+		(
    ++		{
     +			basename .git/objects/pack/pack-*.pack &&
     +			printf "^%s\n" "$(basename .git/objects/pack/pack-*.pack)"
    -+		) >packfiles &&
    ++		} >packfiles &&
     +
     +		git pack-objects --stdin-packs generated-pack <packfiles &&
     +		packed_objects generated-pack-*.idx >packed-objects &&
 6:  3e958bf2a4 !  7:  cd135439ae pack-objects: extend test coverage of `--=
stdin-packs` with alternates
    @@ t/t5331-pack-objects-stdin.sh: test_expect_success 'pack-objects --s=
tdin with sa
     +	test_commit -C member "local-commit" &&
     +	git -C member repack -dl &&
     +
    -+	(
    -+		basename shared/.git/objects/pack/pack-*.pack  &&
    ++	{
    ++		basename shared/.git/objects/pack/pack-*.pack &&
     +		basename member/.git/objects/pack/pack-*.pack
    -+	) >packfiles &&
    ++	} >packfiles &&
     +
    -+	(
    ++	{
     +		packed_objects shared/.git/objects/pack/pack-*.idx &&
     +		packed_objects member/.git/objects/pack/pack-*.idx
    -+	) | sort >expected-objects &&
    ++	} | sort >expected-objects &&
     +
     +	git -C member pack-objects --stdin-packs generated-pack <packfiles &&
    -+	packed_objects member/generated-pack-*.idx | sort >actual-objects &&
    ++	packed_objects member/generated-pack-*.idx >actual-objects &&
     +	test_cmp expected-objects actual-objects
     +'
     +
 -:  ---------- >  8:  18bac90289 t/helper: allow chmtime to print verbosel=
y without modifying mtime
 7:  f014872ed4 !  9:  285695deaf repack: honor `-l` when calculating pack =
geometry
    @@ t/t7703-repack-geometric.sh: test_expect_success '--geometric with s=
ame pack in
     +	# packfile and thus arrive at the conclusion that the geometric
     +	# sequence is intact. We thus expect no changes.
     +	#
    -+	# Note that we are using stat(1) to verify idempotence to also verify
    -+	# that the mtime did not change. This is done in order to detect the
    -+	# case where we do repack objects, but the resulting packfile is the
    -+	# same.
    -+	stat member/.git/objects/pack/* >expected-member-packs &&
    ++	# Note that we are tweaking mtimes of the packfiles so that we can
    ++	# verify they did not change. This is done in order to detect the ca=
se
    ++	# where we do repack objects, but the resulting packfile is the same.
    ++	test-tool chmtime --verbose =3D0 member/.git/objects/pack/* >expecte=
d-member-packs &&
     +	git -C member repack --geometric=3D2 -l -d &&
    -+	stat member/.git/objects/pack/* >actual-member-packs &&
    ++	test-tool chmtime --verbose member/.git/objects/pack/* >actual-membe=
r-packs &&
     +	test_cmp expected-member-packs actual-member-packs &&
     +
    -+	(
    ++	{
     +		packed_objects shared/.git/objects/pack/pack-*.idx &&
     +		packed_objects member/.git/objects/pack/pack-*.idx
    -+	) | sort >expected-objects &&
    ++	} | sort >expected-objects &&
     +
     +	# On the other hand, when doing a non-local geometric repack we shou=
ld
     +	# see both packfiles and thus repack them. We expect that the shared
     +	# object database was not changed.
    -+	stat shared/.git/objects/pack/* >expected-shared-packs &&
    ++	test-tool chmtime --verbose =3D0 shared/.git/objects/pack/* >expecte=
d-shared-packs &&
     +	git -C member repack --geometric=3D2 -d &&
    -+	stat shared/.git/objects/pack/* >actual-shared-packs &&
    ++	test-tool chmtime --verbose shared/.git/objects/pack/* >actual-share=
d-packs &&
     +	test_cmp expected-shared-packs actual-shared-packs &&
     +
     +	# Furthermore, we expect that the member repository now has a single
 8:  b10ee7fc3d ! 10:  bb0ee0eb3c repack: disable writing bitmaps when doin=
g a local geometric repack
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    repack: disable writing bitmaps when doing a local geometric repack
    +    repack: disable writing bitmaps when doing a local repack
    =20
         In order to write a bitmap, we need to have full coverage of all o=
bjects
         that are about to be packed. In the traditional non-multi-pack-ind=
ex
    @@ Commit message
         with writing bitmaps when we have multiple packfiles as long as the
         multi-pack-index covers all objects.
    =20
    -    This is not always the case though. When writing multi-pack-indice=
s in a
    -    repository that is connected to an alternate object directory we m=
ay end
    -    up writing a multi-pack-index that only has partial coverage of ob=
jects.
    -    The end result is that writing the bitmap will fail:
    +    This is not always the case though. When asked to perform a repack=
 of
    +    local objects, only, then we cannot guarantee to have full coverag=
e of
    +    all objects regardless of whether we do a full repack or a repack =
with a
    +    multi-pack-index. The end result is that writing the bitmap will f=
ail in
    +    both worlds:
    =20
             $ git multi-pack-index write --stdin-packs --bitmap <packfiles
             warning: Failed to write bitmap index. Packfile doesn't have f=
ull closure (object 1529341d78cf45377407369acb0f4ff2b5cdae42 is missing)
    @@ Commit message
    =20
         Now there are two different ways to fix this. The first one would =
be to
         amend git-multi-pack-index(1) to disable writing bitmaps when we n=
otice
    -    that we don't have full object coverage. But we ain't really got e=
nough
    -    information there, and seeing that it is a low-level plumbing comm=
and it
    -    does not feel like the right place to fix this.
    +    that we don't have full object coverage.
    =20
    -    We can easily fix it at a higher level in git-repack(1) though. Wh=
en all
    -    of the following conditions are true:
    +        - We don't have enough information in git-multi-pack-index(1) =
in
    +          order to tell whether the local repository _should_ have full
    +          coverage. Because even when connected to an alternate object
    +          directory, it may be the case that we still have all objects
    +          around in the main object database.
    =20
    -        - We are asked to write a multi-pack index with bitmaps.
    +        - git-multi-pack-index(1) is quite a low-level tool. Automatic=
ally
    +          disabling functionality that it was asked to provide does no=
t feel
    +          like the right thing to do.
    =20
    -        - We are asked to only include local objects via `-l`.
    -
    -        - We are connected to an alternate repository that has packfil=
es.
    -
    -    Then we will override the user's ask and disable writing bitmaps w=
ith a
    -    warning. This is similar to what we do in git-pack-objects(1), whe=
re we
    -    also disable writing bitmaps in case we omit an object from the pa=
ck.
    +    We can easily fix it at a higher level in git-repack(1) though. Wh=
en
    +    asked to only include local objects via `-l` and when connected to=
 an
    +    alternate object directory then we will override the user's ask and
    +    disable writing bitmaps with a warning. This is similar to what we=
 do in
    +    git-pack-objects(1), where we also disable writing bitmaps in case=
 we
    +    omit an object from the pack.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/repack.c ##
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const=
 char *prefix)
    - 	if (pack_kept_objects < 0)
    - 		pack_kept_objects =3D write_bitmaps > 0 && !write_midx;
    -=20
    -+	if (write_midx && write_bitmaps && geometric_factor && po_args.local=
) {
    -+		struct packed_git *p;
    -+
    -+		for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
    -+			if (p->pack_local)
    -+				continue;
    -+
    -+			/*
    -+			 * When asked to do a local repack, but we have
    -+			 * packfiles that are inherited from an alternate, then
    -+			 * we cannot guarantee that the multi-pack-index would
    -+			 * have full coverage of all objects. We thus disable
    -+			 * writing bitmaps in that case.
    -+			 */
    -+			warning(_("disabling bitmap writing, as some objects are not being=
 packed"));
    -+			write_bitmaps =3D 0;
    -+			break;
    -+		}
    -+	}
    -+
      	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_mid=
x)
      		die(_(incremental_bitmap_conflict_error));
     =20
    ++	if (write_bitmaps && po_args.local && has_alt_odb(the_repository)) {
    ++		/*
    ++		 * When asked to do a local repack, but we have
    ++		 * packfiles that are inherited from an alternate, then
    ++		 * we cannot guarantee that the multi-pack-index would
    ++		 * have full coverage of all objects. We thus disable
    ++		 * writing bitmaps in that case.
    ++		 */
    ++		warning(_("disabling bitmap writing, as some objects are not being =
packed"));
    ++		write_bitmaps =3D 0;
    ++	}
    ++
    + 	if (write_midx && write_bitmaps) {
    + 		struct strbuf path =3D STRBUF_INIT;
    +=20
    +
    + ## object-file.c ##
    +@@ object-file.c: void prepare_alt_odb(struct repository *r)
    + 	r->objects->loaded_alternates =3D 1;
    + }
    +=20
    ++int has_alt_odb(struct repository *r)
    ++{
    ++	prepare_alt_odb(r);
    ++	return !!r->objects->odb->next;
    ++}
    ++
    + /* Returns 1 if we have successfully freshened the file, 0 otherwise.=
 */
    + static int freshen_file(const char *fn)
    + {
    +
    + ## object-store.h ##
    +@@ object-store.h: KHASH_INIT(odb_path_map, const char * /* key: odb_p=
ath */,
    + 	struct object_directory *, 1, fspathhash, fspatheq)
    +=20
    + void prepare_alt_odb(struct repository *r);
    ++int has_alt_odb(struct repository *r);
    + char *compute_alternate_path(const char *path, struct strbuf *err);
    + struct object_directory *find_odb(struct repository *r, const char *o=
bj_dir);
    + typedef int alt_odb_fn(struct object_directory *, void *);
    +
    + ## t/t7700-repack.sh ##
    +@@ t/t7700-repack.sh: test_expect_success SYMLINKS '--local keeps pack=
s when alternate is objectdir '
    + 	test_cmp expect actual
    + '
    +=20
    ++test_expect_success '--local disables writing bitmaps when connected =
to alternate ODB' '
    ++	test_when_finished "rm -rf shared member" &&
    ++
    ++	git init shared &&
    ++	git clone --shared shared member &&
    ++	(
    ++		cd member &&
    ++		test_commit "object" &&
    ++		git repack -Adl --write-bitmap-index 2>err &&
    ++		cat >expect <<-EOF &&
    ++		warning: disabling bitmap writing, as some objects are not being pa=
cked
    ++		EOF
    ++		test_cmp expect err &&
    ++		test ! -f .git/objects/pack-*.bitmap
    ++	)
    ++'
    ++
    + test_expect_success 'packed obs in alt ODB are repacked even when loc=
al repo is packless' '
    + 	mkdir alt_objects/pack &&
    + 	mv .git/objects/pack/* alt_objects/pack &&
    =20
      ## t/t7703-repack-geometric.sh ##
     @@ t/t7703-repack-geometric.sh: test_expect_success '--geometric -l wi=
th non-intact geometric sequence across OD
--=20
2.40.0


--l4xeR+C/NEH1D5GO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35HEACgkQVbJhu7ck
PpRR2g/8D3tnjnDFxaDrwmLaeSEbBuhnSFGlPHYk1SutzBNGaSz0xXgAyhB8HUdU
pPts3+YVDjZD3fzHCUeS/n3kVAFJS5mS7CjD7gBvn13oZavZ7WxwaJnUi7cF9rh4
t8PwJuY8VJY2C/p0XnFh7ScZowvULOhOu65GF6PieJwbchHAuxWK0pw+VRbdGeU0
CT7amSCqaj0oSjYmr7CaDuIqe3rcwVZTcgPO0BmFgHP0LJHHpSDtdD+VNIIMwHc6
Jch2KeCXwRvzqmXUwu+r72gwK7MaTsGw/m4xfdW+1qCggB9rPbgqsR0ZF5Oe4G7C
YR4OKBhlDCJ4wdZ8iOjjVUiH+Y1o7C/MvrCshg05/HV1UPhhvU/5PGsiry029Kpf
+vTfL5/pcXzPGMa/Xqhm8LTIk+f+pHOkDpV7gXv4gfU0vTCUeavtxj0WhSZKW4oJ
cStFVg+uhl3ZZhoSkPgGpb+o4BhRId8oWN0QFrP71VZgy0ydSfazLvuzeZiRv/0G
z7bpWuoBrwedT+GxlDSBEeR2O+5suWMH8BE5Ns1jMemsGqZkvnjuVmJDbiHtFwK3
jG4YJHZ3e8f7cws8LNf0PqN/W+AZUj9NZzYi0nUMu9cNBDI2f5JWm7jVhqicMfOV
g4oXnlAzJBRev++vKWuIZUQRaha8BcxUTJX1SmNPCCJHxdSJZCY=
=zUUM
-----END PGP SIGNATURE-----

--l4xeR+C/NEH1D5GO--
