Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A75A14F9E4
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107061; cv=none; b=uIlxv00hlCBZiiNjQNw9qqpbeu07DZ/Nu1luP7hBQjVPUaBBOE2nnF4zzAkLUrq0joSuPpMJLL4TWgiDi7lCbtk0LYHzfUB7/3caEkFe4uMI9gpOnyjPJCR5PpvU3Mmvqd4qyOUI2pksV7mldgSY8zlcDUKN5cORpK29wKPr9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107061; c=relaxed/simple;
	bh=vka7D1YvkNoawzIH1rBzrAJo5TnTNvYyefzVskRk0ug=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uJkPlPe1ZmFtPhwbvU5QmpgUnzK/1yxbrEoYvg3wH/H5Nv8ftkuBmh9HnEleSCCC7YjEBFtSixViyfjI2k6pIvbms+H8Z1UHwNzstH9TWPN4azR+FDFQLyYkggakHSDXhtsDLrosKv88iCtyWAXyEmT3ZK3UTmc9uHbVCqTdBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ag3woo1U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qjDH5WQc; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ag3woo1U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qjDH5WQc"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 79CC218000B6
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:57:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 07:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1718107058; x=1718193458; bh=PTYu1UAh6i/0WCTPEsQm4XfoY06hDMu0
	2yUgNGuYCTA=; b=Ag3woo1U0vNtIJDEpxq0jiOQ9ItIOhn25FqmtKb6O3NBECay
	XXH1BmWpvxtWAyVeyGrRQa6xUkgTflhB9UuQSmaG149ZlzNfHIAymUOAZPGi6Y55
	vcVg+Tl+TkoiA/3555i5I8nrA9GsscoBG/sOPPsh4mHxucMbxe6MuriA9K5U3PTn
	6zIpRRGnRG1HlWP1Nf5o5xiD0vxngkJTTRKAITDotf6StyadmJL5PwDZD4zrbvGU
	TA49iJidTGpacp62dWomSnoV6vVmcxZYHv1L30OEHcyU/u0jRZIP+vIz1+sPdaML
	cMmIv5K7WKCIoeSkc4Ti+SSxIXCCUNQuG8YOQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1718107058; x=1718193458; bh=PTYu1UAh6i/0WCTPEsQm4XfoY06hDMu02yU
	gNGuYCTA=; b=qjDH5WQcLG0jF3rdMkzllWhMueJtJ/3rLRAD2sY4FNsm6dbhfDa
	ctXb4shLKYfZ7tsvoD5esD1upMJn8UxQHsnuWipSXGRr39iek3crbKhRbiJSdm1l
	7C/bwemHZofJUsL2B5VSWlBZceFs6DEoOfs3XTOE4EvvKA+rB+JmgI+lU+w0YYJ+
	fHK7IetzO8sCLRuXvW04MWL7/ulol7GSGj8p5+2YOdoFrn3ZaF1X6D5hq9xFrxUT
	tYFApqFKB4yWo0e4Hm3F+tk8vcWraDovJ32iac620ftoR3pr9jz3gDbQc/+6eT1Q
	pEPYtjmtyNDgVG3FNcTRLEu9h8+/JQkfRDw==
X-ME-Sender: <xms:sTtoZjc7znqNSSPkgLieCFgnt_L-X8s4_CZ-CoerN2F67KeSKbaMHw>
    <xme:sTtoZpO8rCPYPdc7jvY8sWsk5EEzPv7wYVbqUenyjM5MTcmD-XQYxzuvAwAs9Gx5l
    INZ_56AABEaoNKbLw>
X-ME-Received: <xmr:sTtoZsi03KqHXMZcDi2LYDdo4R8cb3jmBtdvmVsbixA4twCYSMkKTinFn0mOK6k1qjhriaTeuFogUz7G0dDS1bipC49AJHmilZgX-vjXgJ3nEwx3rkNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepleehfeegieeuudegfeffhfejtdeukeduieeuud
    eivdetueeitdekffefffetteejnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughu
    mhgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:sTtoZk8VqGeQXtB1OSw_MRWyurdXYZR3-X291V7e5J66lBy-rwNqrA>
    <xmx:sTtoZvvQzYhuJ9IH9Xiknb2Bh8hlaSQKyrbPiQIasfYYCCI9sx1BCQ>
    <xmx:sTtoZjEZrvsAziLCmkOYWMPC7jZaLmNbNBXc_J-YF5eKMOrQ7rxFvQ>
    <xmx:sTtoZmNRjL1cBkPYB9NXZO8zpOjKjpRiW4xZYRd-bs52bkHm3YW9xw>
    <xmx:sjtoZoXbqALODOb7WNo3Arv1QKrN8WE6JPNyZ2AQtUYYX_7hcG-cvVWP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:57:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 793939af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:57:26 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:57:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/21] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
Message-ID: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CVlgXgWoa7jSls9D"
Content-Disposition: inline


--CVlgXgWoa7jSls9D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

use of the `the_repository` variable is nowadays considered to be
deprecated, and over time we want to convert our codebase to stop using
it in favor of explicitly passing down the repository to functions via
parameters. This effort faces some important problems though.

  - It is hard to prove that a certain code unit does not use
    `the_repository` anymore when sending patch series. The reviewer has
    no way to verify that it's not used anymore without reading through
    the code itself.

  - It is easy to sneak in new usages of `the_repository` by accident
    into a code unit that is already `the_repository`-clean.

  - There are many functions which implicitly use `the_repository`,
    which is really hard to spot.

This patch series aims to address those problems by introducing a new
`USE_THE_REPOSITORY_VARIABLE` macro. When unset, then the declarations
of `the_repository`, `the_hash_algo` and some functions that implicitly
depend on them will be hidden away. This makes it trivial to demonstrate
that a code unit is `the_repository`-free by removing the definition of
any such macro.

The patch series doesn't aim to be perfect. There are still many
functions that implicitly depend on `the_repository` which are not
hidden away. Those can be addressed over time, either by guarding them
as required or, even better, removing such functions altogether.

The series is structured as follows:

  - Patches 1 to 8 refactor "hash.h" such that its functions do not
    depend on `the_repository` anymore. As these are used almost
    everywhere, the whole patch series would be rather moot without such
    a refactoring as everything would depend on `the_repository`.

  - Patch 9 introduces `USE_THE_REPOSITORY_VARIABLE`, guarding the
    declaration of `the_repository` and `the_hash_algo`.

  - Patch 11 merges "hash-ll.h" back into "hash.h" as the split is now
    mostly pointless.

  - Patches 12 to 20 refactor various users of "hex.h" to not use
    functions depending on `the_repository` anymore.

  - Patch 21 guards declarations of functions that depend on
    `the_repository` in "hex.h".

The series depends on ps/ref-sotrage-migration at 25a0023f28
(builtin/refs: new command to migrate ref storage formats, 2024-06-06).
This is moslty due to patch 10, which fixes a cyclic include that breaks
the build once we merge "hash-ll.h" back into "hash.h".

There are some minor textual and semantic conflicts with "seen" that can
be fixed as shown below.

Thanks!

Patrick

    diff --cc bloom.c
    index bbf146fc30,d080a1b616..0000000000
    --- a/bloom.c
    +++ b/bloom.c
    @@@ -6,7 -6,9 +6,10 @@@
      #include "commit-graph.h"
      #include "commit.h"
      #include "commit-slab.h"
     +#include "repository.h"
    + #include "tree.h"
    + #include "tree-walk.h"
    + #include "config.h"
     =20
      define_commit_slab(bloom_filter_slab, struct bloom_filter);
     =20
    diff --cc midx.c
    index 3992b05465,5aa7e2a6e6..0000000000
    --- a/midx.c
    +++ b/midx.c
    @@@ -303,11 -530,12 +532,13 @@@ struct object_id *nth_midxed_object_oid
                        struct multi_pack_index *m,
                        uint32_t n)
      {
    - 	if (n >=3D m->num_objects)
    + 	if (n >=3D m->num_objects + m->num_objects_in_base)
            return NULL;
     =20
    + 	n =3D midx_for_object(&m, n);
    +=20
     -	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n));
     +	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
     +		the_repository->hash_algo);
        return oid;
      }
     =20
    diff --cc pack-bitmap-write.c
    index 37a8ad0fb3,6e8060f8a0..0000000000
    --- a/pack-bitmap-write.c
    +++ b/pack-bitmap-write.c
    @@@ -817,8 -1022,8 +1024,8 @@@ void bitmap_writer_finish(struct bitmap
        memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNAT=
URE));
        header.version =3D htons(default_version);
        header.options =3D htons(flags | options);
    - 	header.entry_count =3D htonl(writer->selected_nr);
    + 	header.entry_count =3D htonl(bitmap_writer_nr_selected_commits(write=
r));
     -	hashcpy(header.checksum, writer->pack_checksum);
     +	hashcpy(header.checksum, writer->pack_checksum, the_repository->hash=
_algo);
     =20
        hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_alg=
o->rawsz);
        dump_bitmap(f, writer->commits);
    diff --git a/pseudo-merge.c b/pseudo-merge.c
    index e3e0393f11..f0fde13c47 100644
    --- a/pseudo-merge.c
    +++ b/pseudo-merge.c
    @@ -1,3 +1,5 @@
    +#define USE_THE_REPOSITORY_VARIABLE
    +
     #include "git-compat-util.h"
     #include "pseudo-merge.h"
     #include "date.h"
    diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
    index bfde639190..8d2acca768 100644
    --- a/t/unit-tests/lib-oid.h
    +++ b/t/unit-tests/lib-oid.h
    @@ -1,7 +1,7 @@
     #ifndef LIB_OID_H
     #define LIB_OID_H
    =20
    -#include "hash-ll.h"
    +#include "hash.h"
    =20
     /*
      * Convert arbitrary hex string to object_id.
    diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/t-example=
-decorate.c
    index 3c856a8cf2..a4a75db735 100644
    --- a/t/unit-tests/t-example-decorate.c
    +++ b/t/unit-tests/t-example-decorate.c
    @@ -1,3 +1,5 @@
    +#define USE_THE_REPOSITORY_VARIABLE
    +
     #include "test-lib.h"
     #include "object.h"
     #include "decorate.h"

Patrick Steinhardt (21):
  hash: drop (mostly) unused `is_empty_{blob,tree}_sha1()` functions
  hash: require hash algorithm in `hasheq()`, `hashcmp()` and
    `hashclr()`
  hash: require hash algorithm in `oidread()` and `oidclr()`
  global: ensure that object IDs are always padded
  hash: convert `oidcmp()` and `oideq()` to compare whole hash
  hash: make `is_null_oid()` independent of `the_repository`
  hash: require hash algorithm in `is_empty_{blob,tree}_oid()`
  hash: require hash algorithm in `empty_tree_oid_hex()`
  global: introduce `USE_THE_REPOSITORY_VARIABLE` macro
  refs: avoid include cycle with "repository.h"
  hash-ll: merge with "hash.h"
  http-fetch: don't crash when parsing packfile without a repo
  oidset: pass hash algorithm when parsing file
  protocol-caps: use hash algorithm from passed-in repository
  replace-object: use hash algorithm from passed-in repository
  compat/fsmonitor: remove dependency on `the_repository` in Darwin IPC
  t/helper: use correct object hash in partial-clone helper
  t/helper: fix segfault in "oid-array" command without repository
  t/helper: remove dependency on `the_repository` in "oidtree"
  t/helper: remove dependency on `the_repository` in "proc-receive"
  hex: guard declarations with `USE_THE_REPOSITORY_VARIABLE`

 add-interactive.c                            |   4 +-
 add-patch.c                                  |   4 +-
 apply.c                                      |   4 +-
 apply.h                                      |   2 +-
 archive-tar.c                                |   3 +
 archive-zip.c                                |   3 +
 archive.c                                    |   2 +
 attr.c                                       |   2 +
 bisect.c                                     |   2 +
 blame.c                                      |   4 +-
 bloom.c                                      |   1 +
 branch.c                                     |   2 +
 builtin.h                                    |   8 +
 builtin/am.c                                 |   8 +-
 builtin/blame.c                              |   3 +-
 builtin/fast-export.c                        |   2 +-
 builtin/fast-import.c                        |  43 ++-
 builtin/fetch-pack.c                         |   4 +-
 builtin/index-pack.c                         |  11 +-
 builtin/log.c                                |   4 +-
 builtin/merge.c                              |   7 +-
 builtin/notes.c                              |   2 +-
 builtin/pack-objects.c                       |   3 +-
 builtin/pack-redundant.c                     |  10 +-
 builtin/patch-id.c                           |   6 +-
 builtin/pull.c                               |   6 +-
 builtin/receive-pack.c                       |   4 +-
 builtin/replace.c                            |   2 +-
 builtin/rm.c                                 |   2 +-
 builtin/tag.c                                |   2 +-
 builtin/unpack-objects.c                     |   9 +-
 builtin/update-ref.c                         |   8 +-
 bulk-checkin.c                               |   3 +
 bundle-uri.c                                 |   2 +
 bundle.c                                     |   2 +
 cache-tree.c                                 |   7 +-
 checkout.c                                   |   2 +
 checkout.h                                   |   2 +-
 chunk-format.c                               |   2 +
 chunk-format.h                               |   2 +-
 combine-diff.c                               |   2 +
 commit-graph.c                               |  22 +-
 commit-graph.h                               |   2 +
 commit-reach.c                               |   2 +
 commit.c                                     |   2 +
 common-main.c                                |   2 +
 compat/fsmonitor/fsm-ipc-darwin.c            |   5 +-
 compat/sha1-chunked.c                        |   2 +-
 compat/win32/trace2_win32_process_info.c     |   2 +
 config.c                                     |   3 +
 connected.c                                  |   2 +
 convert.c                                    |   2 +
 convert.h                                    |   2 +-
 csum-file.c                                  |   9 +-
 csum-file.h                                  |   2 +-
 delta-islands.c                              |   2 +
 diagnose.c                                   |   2 +
 diff-lib.c                                   |   7 +-
 diff.c                                       |   9 +-
 diff.h                                       |   2 +-
 diffcore-break.c                             |   3 +
 diffcore-rename.c                            |   7 +-
 diffcore.h                                   |   2 +-
 dir.c                                        |   9 +-
 dir.h                                        |   2 +-
 entry.c                                      |   2 +
 environment.c                                |   3 +
 fetch-pack.c                                 |   2 +
 fmt-merge-msg.c                              |   2 +
 fsck.c                                       |   5 +-
 fsmonitor-ipc.c                              |   2 +
 git.c                                        |   2 +
 hash-ll.h                                    | 310 ----------------
 hash-lookup.c                                |   5 +-
 hash.h                                       | 366 ++++++++++++++++---
 help.c                                       |   2 +
 hex.c                                        |   8 +-
 hex.h                                        |  28 +-
 http-backend.c                               |   2 +
 http-fetch.c                                 |   8 +-
 http-push.c                                  |   5 +-
 http-walker.c                                |   6 +-
 http.c                                       |   2 +
 list-objects-filter-options.c                |   2 +
 list-objects-filter.c                        |   2 +
 list-objects.c                               |   2 +
 log-tree.c                                   |   2 +
 loose.c                                      |   2 +
 loose.h                                      |   2 +
 ls-refs.c                                    |   2 +
 mailmap.c                                    |   2 +
 match-trees.c                                |   6 +-
 merge-blobs.c                                |   2 +
 merge-ort.c                                  |   2 +
 merge-ort.h                                  |   2 +-
 merge-recursive.c                            |   3 +
 merge.c                                      |   2 +
 midx-write.c                                 |   2 +
 midx.c                                       |   5 +-
 negotiator/default.c                         |   2 +
 negotiator/skipping.c                        |   2 +
 notes-cache.c                                |   2 +
 notes-merge.c                                |   8 +-
 notes-utils.c                                |   2 +
 notes.c                                      |  14 +-
 object-file-convert.c                        |   6 +-
 object-file.c                                |  19 +-
 object-name.c                                |   2 +
 object.c                                     |   2 +
 object.h                                     |   2 +-
 oid-array.c                                  |   2 +
 oidmap.h                                     |   2 +-
 oidset.c                                     |   8 +-
 oidset.h                                     |   4 +-
 oidtree.c                                    |   4 +-
 oidtree.h                                    |   2 +-
 oss-fuzz/fuzz-commit-graph.c                 |   2 +
 pack-bitmap-write.c                          |   6 +-
 pack-bitmap.c                                |   5 +-
 pack-check.c                                 |   7 +-
 pack-revindex.c                              |   2 +
 pack-write.c                                 |   5 +-
 packfile.c                                   |  20 +-
 packfile.h                                   |   2 +
 parallel-checkout.c                          |   8 +-
 parse-options-cb.c                           |   2 +
 path.c                                       |   3 +
 pathspec.c                                   |   2 +
 pretty.c                                     |   2 +
 progress.c                                   |   2 +
 promisor-remote.c                            |   2 +
 protocol-caps.c                              |   5 +-
 range-diff.c                                 |   2 +
 reachable.c                                  |   2 +
 read-cache-ll.h                              |   2 +-
 read-cache.c                                 |  21 +-
 rebase-interactive.c                         |   2 +
 ref-filter.c                                 |   2 +
 reflog-walk.c                                |   2 +
 reflog.c                                     |   2 +
 refs.c                                       |   8 +-
 refs.h                                       |   8 +-
 refs/files-backend.c                         |   8 +-
 refs/packed-backend.c                        |   8 +-
 refs/ref-cache.h                             |   2 +-
 refs/reftable-backend.c                      |  39 +-
 refspec.c                                    |   2 +
 reftable/dump.c                              |   2 +-
 reftable/reftable-record.h                   |   2 +-
 reftable/system.h                            |   2 +-
 remote-curl.c                                |   2 +
 remote.c                                     |  10 +-
 remote.h                                     |   2 +-
 replace-object.c                             |   2 +-
 repository.h                                 |   9 +-
 rerere.c                                     |   2 +
 reset.c                                      |   2 +
 reset.h                                      |   2 +-
 resolve-undo.c                               |   5 +-
 resolve-undo.h                               |   2 +-
 revision.c                                   |   2 +
 run-command.c                                |   2 +
 scalar.c                                     |   2 +
 send-pack.c                                  |   2 +
 sequencer.c                                  |   8 +-
 serve.c                                      |   4 +-
 server-info.c                                |   2 +
 setup.c                                      |   2 +
 shallow.c                                    |   2 +
 split-index.c                                |   4 +-
 split-index.h                                |   2 +-
 streaming.c                                  |   3 +
 submodule-config.c                           |   4 +-
 submodule.c                                  |   8 +-
 t/helper/test-bitmap.c                       |   2 +
 t/helper/test-bloom.c                        |   2 +
 t/helper/test-cache-tree.c                   |   2 +
 t/helper/test-dump-cache-tree.c              |   2 +
 t/helper/test-dump-fsmonitor.c               |   2 +
 t/helper/test-dump-split-index.c             |   2 +
 t/helper/test-dump-untracked-cache.c         |   2 +
 t/helper/test-example-decorate.c             |   2 +
 t/helper/test-find-pack.c                    |   2 +
 t/helper/test-fsmonitor-client.c             |   2 +
 t/helper/test-hash-speed.c                   |   2 +-
 t/helper/test-lazy-init-name-hash.c          |   2 +
 t/helper/test-match-trees.c                  |   2 +
 t/helper/test-oid-array.c                    |   4 +
 t/helper/test-oidmap.c                       |   2 +
 t/helper/test-oidtree.c                      |   5 +-
 t/helper/test-pack-mtimes.c                  |   2 +
 t/helper/test-partial-clone.c                |   2 +-
 t/helper/test-proc-receive.c                 |   9 +-
 t/helper/test-reach.c                        |   2 +
 t/helper/test-read-cache.c                   |   2 +
 t/helper/test-read-graph.c                   |   2 +
 t/helper/test-read-midx.c                    |   2 +
 t/helper/test-ref-store.c                    |   2 +
 t/helper/test-repository.c                   |   2 +
 t/helper/test-revision-walking.c             |   2 +
 t/helper/test-scrap-cache-tree.c             |   2 +
 t/helper/test-sha1.c                         |   2 +-
 t/helper/test-sha256.c                       |   2 +-
 t/helper/test-submodule-config.c             |   4 +-
 t/helper/test-submodule-nested-repo-config.c |   2 +
 t/helper/test-submodule.c                    |   2 +
 t/helper/test-trace2.c                       |   2 +
 t/helper/test-write-cache.c                  |   2 +
 t/t0064-oid-array.sh                         |  18 +
 t/t5550-http-fetch-dumb.sh                   |   6 +
 t/test-lib-functions.sh                      |   5 +
 tag.c                                        |   2 +
 tmp-objdir.c                                 |   2 +
 transport-helper.c                           |   2 +
 transport.c                                  |   2 +
 tree-diff.c                                  |   1 +
 tree-walk.c                                  |   6 +-
 tree-walk.h                                  |   2 +-
 tree.c                                       |   2 +
 unpack-trees.c                               |   2 +
 upload-pack.c                                |   2 +
 walker.c                                     |   2 +
 worktree.c                                   |   2 +
 wt-status.c                                  |   6 +-
 xdiff-interface.c                            |   2 +
 xdiff-interface.h                            |   2 +-
 226 files changed, 993 insertions(+), 619 deletions(-)
 delete mode 100644 hash-ll.h

--=20
2.45.2.436.gcd77e87115.dirty


--CVlgXgWoa7jSls9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO6wACgkQVbJhu7ck
PpQDiw//ZR6bG4S681/7Kqsi6coG1UElOZl4J7WTYCSiuECb2UIHgb0Ymc31s4Bc
DY9NqxM/J9bD8+lkiAMJ9Y2l6KU2sSrsG8mt/ar6PeHg+akiY7WskH5yMjMqY4SF
MwXw8LeTzsKbdYw1oOCSYIDeA27JYpda2YleNhCX/jtAczi56rdMcW/OgUT90e95
4cBd15gBbC+WJc4MHfQcI5KWve1nWZODcL8HLU5Z25JeFfWkDw3/k4DLrqDz7erN
YH8MdKllZTj8kTTkhpodiXFmHHZSSwaxH6Reym+msfoSkpMt6va0mRuMUIyFSNo/
ZZSFQkF9Ksa73H1qmNS0AVKPoXKy727nmwr23MyzE44kr0MtZPfOlYjdSPqaW5s9
hbh+x+whFaGo6GXCJZ5MIRi0zfop2tiVJkciZFDHVV/XSNwKUaina25cGU75D4NY
T+Wipo5aA00cJg3BhsrJ+oVZHttFi127wzIDMipfXo/6VaO39u0PBWfFvlIlpEVu
RDUm9PZVA00XbNzC8TzZEx1qO/9+dK8CGXT0bYGLuGiEbSLywdfjZ96vT/66ETjR
S3MOlxNNv9XUSgYPrMrKRdBPSMSsMevRADiOHQp5o5rVEeMJH9GSZ4BflYcfcWts
1tEqk9OyeUuNJlhOix7V/zBShMh6+mNXBTVe40D1fIRYUPEcBDg=
=TbRz
-----END PGP SIGNATURE-----

--CVlgXgWoa7jSls9D--
