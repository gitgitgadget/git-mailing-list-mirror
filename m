Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA281DED60
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860047; cv=none; b=RsV/moIwWMBPPaqZkBqf67W8FDGzYXprltmwU+/zl8JFu+eXdpKiUONssFgC+eYHEidKxNcKA4ISTzXidRwGFSW6xi7u7tGEDsCEWtu6cx8OZyvfdT2MCgsQ7SmVjZo5Oez9RwPx2pJ8xM/DikY6DKdY0sjoigra163Ea5e4bu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860047; c=relaxed/simple;
	bh=n6Dmjiv3qszJ/9cb0fT9KOnuNo3+9bvUQELsBGeFnNQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=J5fUDSWHOjxYWCd1FgN2yzDUbQIp5TfJyH42GkkNNXqnaMCvu6MooExEYu6c2LNxmCKDQuqAkG9HIx1YssGuJ52TDq8kYIkfqho/LQtUlp3AyJ9hjnRfR8wVFa7FcLxrPO2qVqdjAUcCTt9kbk6cXqbeU8GncVD2K+m0UVdhDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I+UHTKSb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bnSCOYun; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I+UHTKSb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bnSCOYun"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 08746114012A;
	Mon,  2 Jun 2025 06:27:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Jun 2025 06:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748860040;
	 x=1748946440; bh=sB0Lz707mV9lsFjBzJVEnMcSCRQtv6oUu8PbOwin4RU=; b=
	I+UHTKSbaOYn8kfh8kipE8LrVmuyk4UCwzRpQo5TSudKnHXD40TpGkjZ9Nu4myEv
	u5p3VciISKQqOp4mWIBxdP+bX6nzZAsG3pkxJI4mnkw//AbAfCU8RmavJ0j6rq9b
	Rx752bAFSx0fY2HHJIp1Jp76M4kMZy45ObIQK8Q95FFrRY6pcNYodJOjtFOtgAt7
	rUkAGHVOIysqXmEc9imbE5gpshr9Vx21WpQAJoWbzYQ0FZa5Q5XqljJemFiYouPA
	1injzpzcgY/dwHcQLpZIrDrl43JKpcPm0NrCkJqR7Gj96nbYcyOKUZoqIDRQOaOy
	oAHG6fR7WALIkBR+X5TWVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748860040; x=
	1748946440; bh=sB0Lz707mV9lsFjBzJVEnMcSCRQtv6oUu8PbOwin4RU=; b=b
	nSCOYunS1yjc8SJhH506jznTAxtkpR+7c3rGGP0QZ/xSrf5kYtoWeWxCQg6XTKl0
	ZqkmmBl6yonH5G1OKjhB0qochs3Sf0e8ya9xh5qOn1gECCGmK3QFpIhnjc1TgzF5
	60Gv0BuJJI4VhfGoWE9oihVlp6Qv6q6TNdTAwp+TQkIViGaqX7eRwFyGZhvaAycc
	K7QU576I37G37ytga5WbnzJ+VZcJyAhRvVRUYRKHZ2zfwQruXdlyLBQu514KU61N
	ESx6pehANC8xysUlMSxWCkIoyCtXfx4AdZ09SB3uo0L2SEnnu5g7N7x4oWIObrLN
	ZPQ7WiRZeS4+L4J9AlReA==
X-ME-Sender: <xms:h3w9aO7KM7Cfioyk1KbQqvPH98JrkaF2jFcY0AoWIg9elier5gdq3Q>
    <xme:h3w9aH5XvU27t8Rq0fkdnpaBy50m7z06DYga7rq0m3t8_jFD9OOXo7UhW5aufecCr
    qyUY6DvbU1D6pEAdA>
X-ME-Received: <xmr:h3w9aNfMwRlrkp3_cZfNM6XxOHaILiH-OumkrF8qopZ88ZJVmNJgSWzQC2Q4t29T6YH8B_yWvC8oOLkIx4zBMexjQizM7Ch8poG5HdHlQI3tcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfg
    jghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedt
    ueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iHw9aLLNpKLIbuFy44Z5k7qVAGzjdbAyzZQS6W-I5qh37JpxgWIAXA>
    <xmx:iHw9aCJFVYnHP1U2M7Q62AE25yC0WPs7CVIensusLKteZPCmaC997A>
    <xmx:iHw9aMyXqc1z_ypLd6COnBDQQdJ_Mjvr6HbjI0rNAkK1wSOt5_tokA>
    <xmx:iHw9aGJ7RDo2zO0uyzkiIwfOsvJEVWcEXOrufN5PVZ1tacqn429Hlw>
    <xmx:iHw9aBxKn1CmN1Gaiei_6g1POUxZJwGciBGQrLiBWimgyjZRtpeKIckC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:27:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b4ce208 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:27:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/17] object-store: carve out the object database
 subsystem
Date: Mon, 02 Jun 2025 12:27:01 +0200
Message-Id: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZ8PWgC/43NQQrCMBAF0KtI1o4k07S2rryHuDDJxEbRlKRUR
 Xp3p4KiuzKr/+G/eYpMKVAWm8VTJBpCDvHKQS8XwraH65EgOM4CJZaSD7pzhmhOZHvIfUwEtwh
 9S5Coizlw84DGVtY4XzttlGCoS+TD/f1kt+fchmn5eP8c1NR++GoOPyiQYGVpaqS1UVhtebQKF
 zHZA/56zSwP2VOy8GVjfE1Y/3nFj6f0LK9gT6+dV07TwSF+vXEcX+/UkF1xAQAA
X-Change-ID: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series refactors the object store subsystem to become more
self-contained by getting rid of `the_repository`. Instead of passing in
the repository explicitly, we start to pass in the object store itself,
which is in contrast to many other refactorings we did, but in line with
what we did for the ref store, as well.

This series also starts to properly scope functions to the carved out
object database subsystem, which requires a bit of shuffling. This
allows us to have a short-and-sweet `odb_` prefix for functions and
prepares us for a future with pluggable object backends.

The series is structured as follows:

  - Patches 1 to 3 rename `struct object_store` and `struct
    object_directory` as well as the code files.

  - Patches 4 to 12 refactor "odb.c" to get rid of `the_repository`.

  - Patches 13 to 17 adjust the name of remaining functions so that they
    can be clearly attributed to the ODB. I'm happy to kick these
    patches out of this series and resend them at a later point in case
    they create too much turmoil.

This series is built on top of 6f84262c44a (The eleventh batch,
2025-05-05) with ps/object-store-cleanup at 8a9e27be821 (object-store:
drop `repo_has_object_file()`, 2025-04-29) merged into it. There are a
couple of trivial conflicts when merged with "seen", I have appended the
merge conflict resolution as a patch at the end of this mail.

Changes in v2:
  - Fix for a copy-and-pasted commit message.
  - Rename `struct odb_backend` to `struct odb_alternate`. I'm happy to
    revert to the previous name if we ultimately think it's the better
    suited one.
  - A couple of fixes to move changes into the correct commit. `git
    rebase -x 'meson compile -C build'` is now clean.
  - I _didn't_ back out the rename to "odb.{c,h}". Junio has already
    fixed the fallout, so it's probably more work for him to kick it out
    again than to just leave it in.
  - Link to v1: https://lore.kernel.org/r/20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im

Changes in v3:
  - Polishing for some comments and commit messages.
  - Link to v2: https://lore.kernel.org/r/20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im

Changes in v4:
  - Rebased the patch series on top of 7014b55638d (A bit more topics
    for -rc1, 2025-05-30). This fixes a couple of merge conflicts, most
    importantly with jk/no-funny-object-types.
  - Rename `struct odb_alternate` to `odb_source`.
  - Link to v3: https://lore.kernel.org/r/20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (17):
      object-store: rename `raw_object_store` to `object_database`
      object-store: rename `object_directory` to `odb_source`
      object-store: rename files to "odb.{c,h}"
      odb: introduce parent pointers
      odb: get rid of `the_repository` in `find_odb()`
      odb: get rid of `the_repository` in `assert_oid_type()`
      odb: get rid of `the_repository` in `odb_mkstemp()`
      odb: get rid of `the_repository` when handling alternates
      odb: get rid of `the_repository`  in `for_each()` functions
      odb: get rid of `the_repository` when handling the primary source
      odb: get rid of `the_repository` when handling submodule sources
      odb: trivial refactorings to get rid of `the_repository`
      odb: rename `oid_object_info()`
      odb: rename `repo_read_object_file()`
      odb: rename `has_object()`
      odb: rename `pretend_object_file()`
      odb: rename `read_object_with_reference()`

 Documentation/user-manual.adoc          |   4 +-
 Makefile                                |   2 +-
 apply.c                                 |  14 +-
 archive-tar.c                           |   2 +-
 archive-zip.c                           |   2 +-
 archive.c                               |   6 +-
 attr.c                                  |   4 +-
 bisect.c                                |   8 +-
 blame.c                                 |  22 +-
 builtin/backfill.c                      |   6 +-
 builtin/blame.c                         |   6 +-
 builtin/cat-file.c                      |  62 ++---
 builtin/checkout.c                      |   2 +-
 builtin/clone.c                         |  14 +-
 builtin/commit-graph.c                  |  20 +-
 builtin/commit-tree.c                   |   4 +-
 builtin/count-objects.c                 |   6 +-
 builtin/describe.c                      |   5 +-
 builtin/difftool.c                      |   4 +-
 builtin/fast-export.c                   |  10 +-
 builtin/fast-import.c                   |  49 ++--
 builtin/fetch.c                         |  21 +-
 builtin/fsck.c                          |  31 ++-
 builtin/gc.c                            |  16 +-
 builtin/grep.c                          |  26 +-
 builtin/hash-object.c                   |   2 +-
 builtin/index-pack.c                    |  29 +-
 builtin/log.c                           |   4 +-
 builtin/ls-files.c                      |   4 +-
 builtin/ls-tree.c                       |   6 +-
 builtin/merge-file.c                    |   2 +-
 builtin/merge-tree.c                    |  14 +-
 builtin/mktag.c                         |   6 +-
 builtin/mktree.c                        |  10 +-
 builtin/multi-pack-index.c              |   6 +-
 builtin/notes.c                         |   8 +-
 builtin/pack-objects.c                  |  70 ++---
 builtin/pack-redundant.c                |   2 +-
 builtin/prune.c                         |   6 +-
 builtin/receive-pack.c                  |   9 +-
 builtin/remote.c                        |   6 +-
 builtin/repack.c                        |   7 +-
 builtin/replace.c                       |  12 +-
 builtin/rev-list.c                      |   8 +-
 builtin/show-ref.c                      |   6 +-
 builtin/submodule--helper.c             |  11 +-
 builtin/tag.c                           |  10 +-
 builtin/unpack-file.c                   |   4 +-
 builtin/unpack-objects.c                |  12 +-
 bulk-checkin.c                          |   6 +-
 bundle-uri.c                            |   5 +-
 bundle.c                                |   6 +-
 cache-tree.c                            |  17 +-
 combine-diff.c                          |   4 +-
 commit-graph.c                          | 106 +++----
 commit-graph.h                          |  20 +-
 commit.c                                |  15 +-
 config.c                                |   4 +-
 connected.c                             |   2 +-
 contrib/coccinelle/the_repository.cocci |   2 +-
 diagnose.c                              |  12 +-
 diff.c                                  |  20 +-
 dir.c                                   |   2 +-
 entry.c                                 |   6 +-
 fetch-pack.c                            |  17 +-
 fmt-merge-msg.c                         |   6 +-
 fsck.c                                  |   4 +-
 grep.c                                  |   6 +-
 http-backend.c                          |   2 +-
 http-push.c                             |  20 +-
 http-walker.c                           |  12 +-
 http.c                                  |   6 +-
 list-objects-filter.c                   |   4 +-
 list-objects.c                          |   6 +-
 log-tree.c                              |   2 +-
 loose.c                                 |  46 ++--
 mailmap.c                               |   4 +-
 match-trees.c                           |   6 +-
 merge-blobs.c                           |  10 +-
 merge-ort.c                             |   8 +-
 meson.build                             |   2 +-
 midx-write.c                            |   2 +-
 midx.c                                  |   6 +-
 notes-cache.c                           |   4 +-
 notes-merge.c                           |   4 +-
 notes.c                                 |  19 +-
 object-file.c                           |  94 +++----
 object-file.h                           |  12 +-
 object-name.c                           |  24 +-
 object-store.h                          | 338 -----------------------
 object.c                                |   8 +-
 object-store.c => odb.c                 | 413 +++++++++++++++-------------
 odb.h                                   | 472 ++++++++++++++++++++++++++++++++
 oss-fuzz/fuzz-pack-idx.c                |   2 +-
 pack-bitmap-write.c                     |   9 +-
 pack-bitmap.c                           |  10 +-
 pack-check.c                            |   2 +-
 pack-mtimes.c                           |   2 +-
 pack-objects.h                          |   2 +-
 pack-revindex.c                         |   2 +-
 pack-write.c                            |  10 +-
 packfile.c                              |  29 +-
 packfile.h                              |   8 +-
 path.c                                  |   4 +-
 promisor-remote.c                       |   6 +-
 protocol-caps.c                         |   4 +-
 reachable.c                             |   2 +-
 read-cache.c                            |  14 +-
 ref-filter.c                            |   6 +-
 reflog.c                                |   8 +-
 refs.c                                  |   7 +-
 remote.c                                |   9 +-
 replace-object.c                        |   2 +-
 replace-object.h                        |   2 +-
 repository.c                            |  21 +-
 repository.h                            |   4 +-
 rerere.c                                |   7 +-
 revision.c                              |   5 +-
 send-pack.c                             |   4 +-
 sequencer.c                             |   7 +-
 server-info.c                           |   2 +-
 shallow.c                               |  14 +-
 streaming.c                             |  10 +-
 submodule-config.c                      |   9 +-
 submodule.c                             |  32 +--
 submodule.h                             |   9 -
 t/helper/test-find-pack.c               |   2 +-
 t/helper/test-pack-mtimes.c             |   2 +-
 t/helper/test-partial-clone.c           |   4 +-
 t/helper/test-read-graph.c              |   8 +-
 t/helper/test-read-midx.c               |   2 +-
 t/helper/test-ref-store.c               |   4 +-
 tag.c                                   |  10 +-
 tmp-objdir.c                            |  30 +-
 tree-walk.c                             |  18 +-
 tree.c                                  |   6 +-
 unpack-trees.c                          |   2 +-
 upload-pack.c                           |   4 +-
 walker.c                                |   6 +-
 xdiff-interface.c                       |   4 +-
 140 files changed, 1452 insertions(+), 1298 deletions(-)

Range-diff versus v3:

 1:  043ce74ca7c =  1:  159c8dbbe70 object-store: rename `raw_object_store` to `object_database`
 2:  9a723eebf54 !  2:  6b9fea59a10 object-store: rename `object_directory` to `odb_alternate`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    object-store: rename `object_directory` to `odb_alternate`
    +    object-store: rename `object_directory` to `odb_source`
     
         The `object_directory` structure is used as an access point for a single
         object directory like ".git/objects". While the structure isn't yet
    @@ Commit message
         named after their subsystem, which means that we would start to bake the
         current name into the codebase more and more.
     
    -    Let's preempt this by renaming the structure to `odb_alternate` now
    -    already. This name is agnostic of how exactly objects are stored while
    -    still specifically pinpointing that this is about an alternate object
    -    database. Furthermore, it is already used in Git to represent this
    -    context -- the only stretch is that the primary object directory is now
    -    the primary alternate.
    +    Let's preempt this by renaming the structure. There have been a couple
    +    alternatives that were discussed:
    +
    +      - `odb_backend` was discarded because it led to the association that
    +        one object database has a single backend, but the model is that one
    +        alternate has one backend. Furthermore, "backend" is more about the
    +        actual backing implementation and less about the high-level concept.
    +
    +      - `odb_alternate` was discarded because it is a bit of a stretch to
    +        also call the main object directory an "alternate".
    +
    +    Instead, pick `odb_source` as the new name. It makes it sufficiently
    +    clear that there can be multiple sources and does not cause confusion
    +    when mixed with the already-existing "alternate" terminology.
     
         In the future, this change allows us to easily introduce for example a
    -    `odb_files_alternate` and other format-specific implementations.
    +    `odb_files_source` and other format-specific implementations.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv, con
      {
      	struct commit_graph *graph = NULL;
     -	struct object_directory *odb = NULL;
    -+	struct odb_alternate *alternate = NULL;
    ++	struct odb_source *source = NULL;
      	char *graph_name;
      	char *chain_name;
      	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv, con
     -	odb = find_odb(the_repository, opts.obj_dir);
     -	graph_name = get_commit_graph_filename(odb);
     -	chain_name = get_commit_graph_chain_filename(odb);
    -+	alternate = find_odb(the_repository, opts.obj_dir);
    -+	graph_name = get_commit_graph_filename(alternate);
    -+	chain_name = get_commit_graph_chain_filename(alternate);
    ++	source = find_odb(the_repository, opts.obj_dir);
    ++	graph_name = get_commit_graph_filename(source);
    ++	chain_name = get_commit_graph_chain_filename(source);
      	if (open_commit_graph(graph_name, &fd, &st))
      		opened = OPENED_GRAPH;
      	else if (errno != ENOENT)
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv, con
      		return 0;
      	else if (opened == OPENED_GRAPH)
     -		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
    -+		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, alternate);
    ++		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, source);
      	else
      		graph = load_commit_graph_chain_fd_st(the_repository, fd, &st,
      						      &incomplete_chain);
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv, cons
      	struct strbuf buf = STRBUF_INIT;
      	struct oidset commits = OIDSET_INIT;
     -	struct object_directory *odb = NULL;
    -+	struct odb_alternate *alternate = NULL;
    ++	struct odb_source *source = NULL;
      	int result = 0;
      	enum commit_graph_write_flags flags = 0;
      	struct progress *progress = NULL;
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv, cons
      		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
      
     -	odb = find_odb(the_repository, opts.obj_dir);
    -+	alternate = find_odb(the_repository, opts.obj_dir);
    ++	source = find_odb(the_repository, opts.obj_dir);
      
      	if (opts.reachable) {
     -		if (write_commit_graph_reachable(odb, flags, &write_opts))
    -+		if (write_commit_graph_reachable(alternate, flags, &write_opts))
    ++		if (write_commit_graph_reachable(source, flags, &write_opts))
      			result = 1;
      		goto cleanup;
      	}
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv, cons
      	}
      
     -	if (write_commit_graph(odb,
    -+	if (write_commit_graph(alternate,
    ++	if (write_commit_graph(source,
      			       opts.stdin_packs ? &pack_indexes : NULL,
      			       opts.stdin_commits ? &commits : NULL,
      			       flags,
    @@ builtin/count-objects.c: static int count_cruft(const char *basename UNUSED, con
      }
      
     -static int print_alternate(struct object_directory *odb, void *data UNUSED)
    -+static int print_alternate(struct odb_alternate *alternate, void *data UNUSED)
    ++static int print_alternate(struct odb_source *alternate, void *data UNUSED)
      {
      	printf("alternate: ");
     -	quote_c_style(odb->path, NULL, stdout, 0);
    @@ builtin/fetch.c: int cmd_fetch(int argc,
      
      		trace2_region_enter("fetch", "write-commit-graph", the_repository);
     -		write_commit_graph_reachable(the_repository->objects->odb,
    -+		write_commit_graph_reachable(the_repository->objects->alternates,
    ++		write_commit_graph_reachable(the_repository->objects->sources,
      					     commit_graph_flags,
      					     NULL);
      		trace2_region_leave("fetch", "write-commit-graph", the_repository);
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      {
      	int i;
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	/* fsck knows how to handle missing promisor objects */
      	fetch_if_missing = 0;
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      		prepare_alt_odb(the_repository);
     -		for (odb = the_repository->objects->odb; odb; odb = odb->next)
     -			fsck_object_dir(odb->path);
    -+		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next)
    -+			fsck_object_dir(alternate->path);
    ++		for (source = the_repository->objects->sources; source; source = source->next)
    ++			fsck_object_dir(source->path);
      
      		if (check_full) {
      			struct packed_git *p;
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      
      		prepare_alt_odb(the_repository);
     -		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
    -+		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
    ++		for (source = the_repository->objects->sources; source; source = source->next) {
      			child_process_init(&commit_graph_verify);
      			commit_graph_verify.git_cmd = 1;
      			strvec_pushl(&commit_graph_verify.args, "commit-graph",
     -				     "verify", "--object-dir", odb->path, NULL);
    -+				     "verify", "--object-dir", alternate->path, NULL);
    ++				     "verify", "--object-dir", source->path, NULL);
      			if (show_progress)
      				strvec_push(&commit_graph_verify.args, "--progress");
      			else
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      
      		prepare_alt_odb(the_repository);
     -		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
    -+		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
    ++		for (source = the_repository->objects->sources; source; source = source->next) {
      			child_process_init(&midx_verify);
      			midx_verify.git_cmd = 1;
      			strvec_pushl(&midx_verify.args, "multi-pack-index",
     -				     "verify", "--object-dir", odb->path, NULL);
    -+				     "verify", "--object-dir", alternate->path, NULL);
    ++				     "verify", "--object-dir", source->path, NULL);
      			if (show_progress)
      				strvec_push(&midx_verify.args, "--progress");
      			else
     
      ## builtin/gc.c ##
    -@@ builtin/gc.c: struct repository *repo UNUSED)
    +@@ builtin/gc.c: int cmd_gc(int argc,
      	}
      
      	if (the_repository->settings.gc_write_commit_graph == 1)
     -		write_commit_graph_reachable(the_repository->objects->odb,
    -+		write_commit_graph_reachable(the_repository->objects->alternates,
    ++		write_commit_graph_reachable(the_repository->objects->sources,
      					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
      					     NULL);
      
    @@ builtin/gc.c: static int loose_object_auto_condition(struct gc_config *cfg UNUSE
      		return 1;
      
     -	return for_each_loose_file_in_objdir(the_repository->objects->odb->path,
    -+	return for_each_loose_file_in_objdir(the_repository->objects->alternates->path,
    ++	return for_each_loose_file_in_objdir(the_repository->objects->sources->path,
      					     loose_object_count,
      					     NULL, NULL, &count);
      }
    @@ builtin/gc.c: static int pack_loose(struct maintenance_run_opts *opts)
      	 * if there are no loose objects.
      	 */
     -	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
    -+	if (!for_each_loose_file_in_objdir(r->objects->alternates->path,
    ++	if (!for_each_loose_file_in_objdir(r->objects->sources->path,
      					   bail_on_loose,
      					   NULL, NULL, NULL))
      		return 0;
    @@ builtin/gc.c: static int pack_loose(struct maintenance_run_opts *opts)
      	else
      		strvec_push(&pack_proc.args, "--no-quiet");
     -	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
    -+	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->alternates->path);
    ++	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->sources->path);
      
      	pack_proc.in = -1;
      
    @@ builtin/gc.c: static int pack_loose(struct maintenance_run_opts *opts)
      		data.batch_size--; /* Decrease for equality on limit. */
      
     -	for_each_loose_file_in_objdir(r->objects->odb->path,
    -+	for_each_loose_file_in_objdir(r->objects->alternates->path,
    ++	for_each_loose_file_in_objdir(r->objects->sources->path,
      				      write_loose_object_to_stdin,
      				      NULL,
      				      NULL,
    @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts
      	struct lock_file lk;
      	struct repository *r = the_repository;
     -	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
    -+	char *lock_path = xstrfmt("%s/maintenance", r->objects->alternates->path);
    ++	char *lock_path = xstrfmt("%s/maintenance", r->objects->sources->path);
      
      	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
      		/*
    @@ builtin/gc.c: static int update_background_schedule(const struct maintenance_sta
      	int result = 0;
      	struct lock_file lk;
     -	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
    -+	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->alternates->path);
    ++	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->sources->path);
      
      	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
      		if (errno == EEXIST)
    @@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
      	 * unexpected code interaction, it won't be needed).
      	 */
     -	add_submodule_odb_by_path(subrepo->objects->odb->path);
    -+	add_submodule_odb_by_path(subrepo->objects->alternates->path);
    ++	add_submodule_odb_by_path(subrepo->objects->sources->path);
      	obj_read_unlock();
      
      	memcpy(&subopt, opt, sizeof(subopt));
    @@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc,
      	    the_repository->objects &&
     -	    the_repository->objects->odb)
     -		opts.object_dir = xstrdup(the_repository->objects->odb->path);
    -+	    the_repository->objects->alternates)
    -+		opts.object_dir = xstrdup(the_repository->objects->alternates->path);
    ++	    the_repository->objects->sources)
    ++		opts.object_dir = xstrdup(the_repository->objects->sources->path);
      
      	argc = parse_options(argc, argv, prefix, options,
      			     builtin_multi_pack_index_usage, 0);
    @@ builtin/submodule--helper.c: static const char alternate_error_advice[] = N_(
      
      static int add_possible_reference_from_superproject(
     -		struct object_directory *odb, void *sas_cb)
    -+		struct odb_alternate *alt_odb, void *sas_cb)
    ++		struct odb_source *alt_odb, void *sas_cb)
      {
      	struct submodule_alternate_setup *sas = sas_cb;
      	size_t len;
    @@ bundle.c: int verify_bundle(struct repository *r,
      	};
      
     -	if (!r || !r->objects || !r->objects->odb)
    -+	if (!r || !r->objects || !r->objects->alternates)
    ++	if (!r || !r->objects || !r->objects->sources)
      		return error(_("need a repository to verify a bundle"));
      
      	for (i = 0; i < p->nr; i++) {
    @@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
      		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
      
     -	if (write_commit_graph_reachable(the_repository->objects->odb,
    -+	if (write_commit_graph_reachable(the_repository->objects->alternates,
    ++	if (write_commit_graph_reachable(the_repository->objects->sources,
      					 flags, NULL))
      		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
      }
    @@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
      }
      
     -char *get_commit_graph_filename(struct object_directory *obj_dir)
    -+char *get_commit_graph_filename(struct odb_alternate *alternate)
    ++char *get_commit_graph_filename(struct odb_source *source)
      {
     -	return xstrfmt("%s/info/commit-graph", obj_dir->path);
    -+	return xstrfmt("%s/info/commit-graph", alternate->path);
    ++	return xstrfmt("%s/info/commit-graph", source->path);
      }
      
     -static char *get_split_graph_filename(struct object_directory *odb,
    -+static char *get_split_graph_filename(struct odb_alternate *alternate,
    ++static char *get_split_graph_filename(struct odb_source *source,
      				      const char *oid_hex)
      {
     -	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", odb->path,
    -+	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", alternate->path,
    ++	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", source->path,
      		       oid_hex);
      }
      
     -char *get_commit_graph_chain_filename(struct object_directory *odb)
    -+char *get_commit_graph_chain_filename(struct odb_alternate *alternate)
    ++char *get_commit_graph_chain_filename(struct odb_source *source)
      {
     -	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
    -+	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", alternate->path);
    ++	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", source->path);
      }
      
      static struct commit_graph *alloc_commit_graph(void)
    @@ commit-graph.c: int open_commit_graph(const char *graph_file, int *fd, struct st
      struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
      						 int fd, struct stat *st,
     -						 struct object_directory *odb)
    -+						 struct odb_alternate *alternate)
    ++						 struct odb_source *source)
      {
      	void *graph_map;
      	size_t graph_size;
    @@ commit-graph.c: struct commit_graph *load_commit_graph_one_fd_st(struct reposito
      
      	if (ret)
     -		ret->odb = odb;
    -+		ret->alternate = alternate;
    ++		ret->odb_source = source;
      	else
      		munmap(graph_map, graph_size);
      
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
      static struct commit_graph *load_commit_graph_one(struct repository *r,
      						  const char *graph_file,
     -						  struct object_directory *odb)
    -+						  struct odb_alternate *alternate)
    ++						  struct odb_source *source)
      {
      
      	struct stat st;
    @@ commit-graph.c: static struct commit_graph *load_commit_graph_one(struct reposit
      		return NULL;
      
     -	g = load_commit_graph_one_fd_st(r, fd, &st, odb);
    -+	g = load_commit_graph_one_fd_st(r, fd, &st, alternate);
    ++	g = load_commit_graph_one_fd_st(r, fd, &st, source);
      
      	if (g)
      		g->filename = xstrdup(graph_file);
    @@ commit-graph.c: static struct commit_graph *load_commit_graph_one(struct reposit
      
      static struct commit_graph *load_commit_graph_v1(struct repository *r,
     -						 struct object_directory *odb)
    -+						 struct odb_alternate *alternate)
    ++						 struct odb_source *source)
      {
     -	char *graph_name = get_commit_graph_filename(odb);
     -	struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
    -+	char *graph_name = get_commit_graph_filename(alternate);
    -+	struct commit_graph *g = load_commit_graph_one(r, graph_name, alternate);
    ++	char *graph_name = get_commit_graph_filename(source);
    ++	struct commit_graph *g = load_commit_graph_one(r, graph_name, source);
      	free(graph_name);
      
      	return g;
    @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct reposi
      
      	for (i = 0; i < count; i++) {
     -		struct object_directory *odb;
    -+		struct odb_alternate *alternate;
    ++		struct odb_source *source;
      
      		if (strbuf_getline_lf(&line, fp) == EOF)
      			break;
    @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct reposi
     -		for (odb = r->objects->odb; odb; odb = odb->next) {
     -			char *graph_name = get_split_graph_filename(odb, line.buf);
     -			struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
    -+		for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    -+			char *graph_name = get_split_graph_filename(alternate, line.buf);
    -+			struct commit_graph *g = load_commit_graph_one(r, graph_name, alternate);
    ++		for (source = r->objects->sources; source; source = source->next) {
    ++			char *graph_name = get_split_graph_filename(source, line.buf);
    ++			struct commit_graph *g = load_commit_graph_one(r, graph_name, source);
      
      			free(graph_name);
      
    @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct reposi
      
      static struct commit_graph *load_commit_graph_chain(struct repository *r,
     -						    struct object_directory *odb)
    -+						    struct odb_alternate *alternate)
    ++						    struct odb_source *source)
      {
     -	char *chain_file = get_commit_graph_chain_filename(odb);
    -+	char *chain_file = get_commit_graph_chain_filename(alternate);
    ++	char *chain_file = get_commit_graph_chain_filename(source);
      	struct stat st;
      	int fd;
      	struct commit_graph *g = NULL;
    @@ commit-graph.c: static struct commit_graph *load_commit_graph_chain(struct repos
      
      struct commit_graph *read_commit_graph_one(struct repository *r,
     -					   struct object_directory *odb)
    -+					   struct odb_alternate *alternate)
    ++					   struct odb_source *source)
      {
     -	struct commit_graph *g = load_commit_graph_v1(r, odb);
    -+	struct commit_graph *g = load_commit_graph_v1(r, alternate);
    ++	struct commit_graph *g = load_commit_graph_v1(r, source);
      
      	if (!g)
     -		g = load_commit_graph_chain(r, odb);
    -+		g = load_commit_graph_chain(r, alternate);
    ++		g = load_commit_graph_chain(r, source);
      
      	return g;
      }
      
      static void prepare_commit_graph_one(struct repository *r,
     -				     struct object_directory *odb)
    -+				     struct odb_alternate *alternate)
    ++				     struct odb_source *source)
      {
      
      	if (r->objects->commit_graph)
      		return;
      
     -	r->objects->commit_graph = read_commit_graph_one(r, odb);
    -+	r->objects->commit_graph = read_commit_graph_one(r, alternate);
    ++	r->objects->commit_graph = read_commit_graph_one(r, source);
      }
      
      /*
    @@ commit-graph.c: static void prepare_commit_graph_one(struct repository *r,
      static int prepare_commit_graph(struct repository *r)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	/*
      	 * Early return if there is no git dir or if the commit graph is
    @@ commit-graph.c: static int prepare_commit_graph(struct repository *r)
     -	     !r->objects->commit_graph && odb;
     -	     odb = odb->next)
     -		prepare_commit_graph_one(r, odb);
    -+	for (alternate = r->objects->alternates;
    -+	     !r->objects->commit_graph && alternate;
    -+	     alternate = alternate->next)
    -+		prepare_commit_graph_one(r, alternate);
    ++	for (source = r->objects->sources;
    ++	     !r->objects->commit_graph && source;
    ++	     source = source->next)
    ++		prepare_commit_graph_one(r, source);
      	return !!r->objects->commit_graph;
      }
      
    @@ commit-graph.c: struct packed_commit_list {
      struct write_commit_graph_context {
      	struct repository *r;
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *odb_source;
      	char *graph_name;
      	struct oid_array oids;
      	struct packed_commit_list commits;
    @@ commit-graph.c: static int add_ref_to_set(const char *refname UNUSED,
      }
      
     -int write_commit_graph_reachable(struct object_directory *odb,
    -+int write_commit_graph_reachable(struct odb_alternate *alternate,
    ++int write_commit_graph_reachable(struct odb_source *source,
      				 enum commit_graph_write_flags flags,
      				 const struct commit_graph_opts *opts)
      {
    @@ commit-graph.c: int write_commit_graph_reachable(struct object_directory *odb,
      	stop_progress(&data.progress);
      
     -	result = write_commit_graph(odb, NULL, &commits,
    -+	result = write_commit_graph(alternate, NULL, &commits,
    ++	result = write_commit_graph(source, NULL, &commits,
      				    flags, opts);
      
      	oidset_clear(&commits);
    @@ commit-graph.c: static int fill_oids_from_packs(struct write_commit_graph_contex
      	int ret = 0;
      
     -	strbuf_addf(&packname, "%s/pack/", ctx->odb->path);
    -+	strbuf_addf(&packname, "%s/pack/", ctx->alternate->path);
    ++	strbuf_addf(&packname, "%s/pack/", ctx->odb_source->path);
      	dirlen = packname.len;
      	if (ctx->report_progress) {
      		strbuf_addf(&progress_title,
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      		strbuf_addf(&tmp_file,
      			    "%s/info/commit-graphs/tmp_graph_XXXXXX",
     -			    ctx->odb->path);
    -+			    ctx->alternate->path);
    ++			    ctx->odb_source->path);
      		ctx->graph_name = strbuf_detach(&tmp_file, NULL);
      	} else {
     -		ctx->graph_name = get_commit_graph_filename(ctx->odb);
    -+		ctx->graph_name = get_commit_graph_filename(ctx->alternate);
    ++		ctx->graph_name = get_commit_graph_filename(ctx->odb_source);
      	}
      
      	if (safe_create_leading_directories(the_repository, ctx->graph_name)) {
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      
      	if (ctx->split) {
     -		char *lock_name = get_commit_graph_chain_filename(ctx->odb);
    -+		char *lock_name = get_commit_graph_chain_filename(ctx->alternate);
    ++		char *lock_name = get_commit_graph_chain_filename(ctx->odb_source);
      
      		hold_lock_file_for_update_mode(&lk, lock_name,
      					       LOCK_DIE_ON_ERROR, 0444);
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
      		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
     -		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb, new_base_hash);
    -+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->alternate, new_base_hash);
    ++		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb_source, new_base_hash);
      
      		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
      		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      			}
      		} else {
     -			char *graph_name = get_commit_graph_filename(ctx->odb);
    -+			char *graph_name = get_commit_graph_filename(ctx->alternate);
    ++			char *graph_name = get_commit_graph_filename(ctx->odb_source);
      			unlink(graph_name);
      			free(graph_name);
      		}
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
      		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
     -		final_graph_name = get_split_graph_filename(ctx->odb,
    -+		final_graph_name = get_split_graph_filename(ctx->alternate,
    ++		final_graph_name = get_split_graph_filename(ctx->odb_source,
      					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
      		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
      		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
    @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph
      		while (g && (g->num_commits <= st_mult(size_mult, num_commits) ||
      			    (max_commits && num_commits > max_commits))) {
     -			if (g->odb != ctx->odb)
    -+			if (g->alternate != ctx->alternate)
    ++			if (g->odb_source != ctx->odb_source)
      				break;
      
      			if (unsigned_add_overflows(num_commits, g->num_commits))
    @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph
      
      	if (ctx->num_commit_graphs_after == 2) {
     -		char *old_graph_name = get_commit_graph_filename(g->odb);
    -+		char *old_graph_name = get_commit_graph_filename(g->alternate);
    ++		char *old_graph_name = get_commit_graph_filename(g->odb_source);
      
      		if (!strcmp(g->filename, old_graph_name) &&
     -		    g->odb != ctx->odb) {
    -+		    g->alternate != ctx->alternate) {
    ++		    g->odb_source != ctx->odb_source) {
      			ctx->num_commit_graphs_after = 1;
      			ctx->new_base_graph = NULL;
      		}
    @@ commit-graph.c: static void expire_commit_graphs(struct write_commit_graph_conte
      		expire_time = ctx->opts->expire_time;
      	if (!ctx->split) {
     -		char *chain_file_name = get_commit_graph_chain_filename(ctx->odb);
    -+		char *chain_file_name = get_commit_graph_chain_filename(ctx->alternate);
    ++		char *chain_file_name = get_commit_graph_chain_filename(ctx->odb_source);
      		unlink(chain_file_name);
      		free(chain_file_name);
      		ctx->num_commit_graphs_after = 0;
      	}
      
     -	strbuf_addstr(&path, ctx->odb->path);
    -+	strbuf_addstr(&path, ctx->alternate->path);
    ++	strbuf_addstr(&path, ctx->odb_source->path);
      	strbuf_addstr(&path, "/info/commit-graphs");
      	dir = opendir(path.buf);
      
    @@ commit-graph.c: static void expire_commit_graphs(struct write_commit_graph_conte
      }
      
     -int write_commit_graph(struct object_directory *odb,
    -+int write_commit_graph(struct odb_alternate *alternate,
    ++int write_commit_graph(struct odb_source *source,
      		       const struct string_list *const pack_indexes,
      		       struct oidset *commits,
      		       enum commit_graph_write_flags flags,
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
    - 
    - 	CALLOC_ARRAY(ctx, 1);
    - 	ctx->r = r;
    --	ctx->odb = odb;
    -+	ctx->alternate = alternate;
    - 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
    - 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
    - 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
    + 	struct repository *r = the_repository;
    + 	struct write_commit_graph_context ctx = {
    + 		.r = r,
    +-		.odb = odb,
    ++		.odb_source = source,
    + 		.append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
    + 		.report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
    + 		.split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,
     
      ## commit-graph.h ##
     @@ commit-graph.h: struct repository;
    @@ commit-graph.h: struct repository;
      
     -char *get_commit_graph_filename(struct object_directory *odb);
     -char *get_commit_graph_chain_filename(struct object_directory *odb);
    -+char *get_commit_graph_filename(struct odb_alternate *alternate);
    -+char *get_commit_graph_chain_filename(struct odb_alternate *alternate);
    ++char *get_commit_graph_filename(struct odb_source *source);
    ++char *get_commit_graph_chain_filename(struct odb_source *source);
      int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
      int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st);
      
    @@ commit-graph.h: struct commit_graph {
      	struct object_id oid;
      	char *filename;
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *odb_source;
      
      	uint32_t num_commits_in_base;
      	unsigned int read_generation_data;
    @@ commit-graph.h: struct commit_graph {
      struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
      						 int fd, struct stat *st,
     -						 struct object_directory *odb);
    -+						 struct odb_alternate *alternate);
    ++						 struct odb_source *source);
      struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
      						   int fd, struct stat *st,
      						   int *incomplete_chain);
      struct commit_graph *read_commit_graph_one(struct repository *r,
     -					   struct object_directory *odb);
    -+					   struct odb_alternate *alternate);
    ++					   struct odb_source *source);
      
      struct repo_settings;
      
    @@ commit-graph.h: struct commit_graph_opts {
       * methods will return 0 without writing a commit-graph.
       */
     -int write_commit_graph_reachable(struct object_directory *odb,
    -+int write_commit_graph_reachable(struct odb_alternate *alternate,
    ++int write_commit_graph_reachable(struct odb_source *source,
      				 enum commit_graph_write_flags flags,
      				 const struct commit_graph_opts *opts);
     -int write_commit_graph(struct object_directory *odb,
    -+int write_commit_graph(struct odb_alternate *alternate,
    ++int write_commit_graph(struct odb_source *source,
      		       const struct string_list *pack_indexes,
      		       struct oidset *commits,
      		       enum commit_graph_write_flags flags,
    @@ diagnose.c: static void dir_file_stats_objects(const char *full_path,
      }
      
     -static int dir_file_stats(struct object_directory *object_dir, void *data)
    -+static int dir_file_stats(struct odb_alternate *alternate, void *data)
    ++static int dir_file_stats(struct odb_source *source, void *data)
      {
      	struct strbuf *buf = data;
      
     -	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
    -+	strbuf_addf(buf, "Contents of %s:\n", alternate->path);
    ++	strbuf_addf(buf, "Contents of %s:\n", source->path);
      
     -	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
    -+	for_each_file_in_pack_dir(alternate->path, dir_file_stats_objects,
    ++	for_each_file_in_pack_dir(source->path, dir_file_stats_objects,
      				  data);
      
      	return 0;
    @@ diagnose.c: int create_diagnostics_archive(struct repository *r,
      	strbuf_reset(&buf);
      	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
     -	dir_file_stats(r->objects->odb, &buf);
    -+	dir_file_stats(r->objects->alternates, &buf);
    ++	dir_file_stats(r->objects->sources, &buf);
      	foreach_alt_odb(dir_file_stats, &buf);
      	strvec_push(&archiver_args, buf.buf);
      
    @@ http-walker.c: static int fetch_object(struct walker *walker, const struct objec
      	} else if (req->rename < 0) {
      		struct strbuf buf = STRBUF_INIT;
     -		odb_loose_path(the_repository->objects->odb, &buf, &req->oid);
    -+		odb_loose_path(the_repository->objects->alternates, &buf, &req->oid);
    ++		odb_loose_path(the_repository->objects->sources, &buf, &req->oid);
      		ret = error("unable to write sha1 filename %s", buf.buf);
      		strbuf_release(&buf);
      	}
    @@ http.c: struct http_object_request *new_http_object_request(const char *base_url
      	freq->localfile = -1;
      
     -	odb_loose_path(the_repository->objects->odb, &filename, oid);
    -+	odb_loose_path(the_repository->objects->alternates, &filename, oid);
    ++	odb_loose_path(the_repository->objects->sources, &filename, oid);
      	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
      
      	strbuf_addf(&prevfile, "%s.prev", filename.buf);
    @@ http.c: int finish_http_object_request(struct http_object_request *freq)
      		return -1;
      	}
     -	odb_loose_path(the_repository->objects->odb, &filename, &freq->oid);
    -+	odb_loose_path(the_repository->objects->alternates, &filename, &freq->oid);
    ++	odb_loose_path(the_repository->objects->sources, &filename, &freq->oid);
      	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
      	strbuf_release(&filename);
      
    @@ loose.c: static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *k
      }
      
     -static int insert_loose_map(struct object_directory *odb,
    -+static int insert_loose_map(struct odb_alternate *alternate,
    ++static int insert_loose_map(struct odb_source *source,
      			    const struct object_id *oid,
      			    const struct object_id *compat_oid)
      {
     -	struct loose_object_map *map = odb->loose_map;
    -+	struct loose_object_map *map = alternate->loose_map;
    ++	struct loose_object_map *map = source->loose_map;
      	int inserted = 0;
      
      	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
      	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
      	if (inserted)
     -		oidtree_insert(odb->loose_objects_cache, compat_oid);
    -+		oidtree_insert(alternate->loose_objects_cache, compat_oid);
    ++		oidtree_insert(source->loose_objects_cache, compat_oid);
      
      	return inserted;
      }
      
     -static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
    -+static int load_one_loose_object_map(struct repository *repo, struct odb_alternate *alternate)
    ++static int load_one_loose_object_map(struct repository *repo, struct odb_source *source)
      {
      	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
      	FILE *fp;
    @@ loose.c: static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *k
     -	if (!dir->loose_objects_cache) {
     -		ALLOC_ARRAY(dir->loose_objects_cache, 1);
     -		oidtree_init(dir->loose_objects_cache);
    -+	if (!alternate->loose_map)
    -+		loose_object_map_init(&alternate->loose_map);
    -+	if (!alternate->loose_objects_cache) {
    -+		ALLOC_ARRAY(alternate->loose_objects_cache, 1);
    -+		oidtree_init(alternate->loose_objects_cache);
    ++	if (!source->loose_map)
    ++		loose_object_map_init(&source->loose_map);
    ++	if (!source->loose_objects_cache) {
    ++		ALLOC_ARRAY(source->loose_objects_cache, 1);
    ++		oidtree_init(source->loose_objects_cache);
      	}
      
     -	insert_loose_map(dir, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
     -	insert_loose_map(dir, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
     -	insert_loose_map(dir, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
    -+	insert_loose_map(alternate, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
    -+	insert_loose_map(alternate, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
    -+	insert_loose_map(alternate, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
    ++	insert_loose_map(source, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
    ++	insert_loose_map(source, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
    ++	insert_loose_map(source, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
      
      	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
      	fp = fopen(path.buf, "rb");
    @@ loose.c: static int load_one_loose_object_map(struct repository *repo, struct ob
      		    p != buf.buf + buf.len)
      			goto err;
     -		insert_loose_map(dir, &oid, &compat_oid);
    -+		insert_loose_map(alternate, &oid, &compat_oid);
    ++		insert_loose_map(source, &oid, &compat_oid);
      	}
      
      	strbuf_release(&buf);
    @@ loose.c: static int load_one_loose_object_map(struct repository *repo, struct ob
      int repo_read_loose_object_map(struct repository *repo)
      {
     -	struct object_directory *dir;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	if (!should_use_loose_object_map(repo))
      		return 0;
    @@ loose.c: static int load_one_loose_object_map(struct repository *repo, struct ob
      
     -	for (dir = repo->objects->odb; dir; dir = dir->next) {
     -		if (load_one_loose_object_map(repo, dir) < 0) {
    -+	for (alternate = repo->objects->alternates; alternate; alternate = alternate->next) {
    -+		if (load_one_loose_object_map(repo, alternate) < 0) {
    ++	for (source = repo->objects->sources; source; source = source->next) {
    ++		if (load_one_loose_object_map(repo, source) < 0) {
      			return -1;
      		}
      	}
    @@ loose.c: int repo_read_loose_object_map(struct repository *repo)
      int repo_write_loose_object_map(struct repository *repo)
      {
     -	kh_oid_map_t *map = repo->objects->odb->loose_map->to_compat;
    -+	kh_oid_map_t *map = repo->objects->alternates->loose_map->to_compat;
    ++	kh_oid_map_t *map = repo->objects->sources->loose_map->to_compat;
      	struct lock_file lock;
      	int fd;
      	khiter_t iter;
    @@ loose.c: int repo_add_loose_object_map(struct repository *repo, const struct obj
      		return 0;
      
     -	inserted = insert_loose_map(repo->objects->odb, oid, compat_oid);
    -+	inserted = insert_loose_map(repo->objects->alternates, oid, compat_oid);
    ++	inserted = insert_loose_map(repo->objects->sources, oid, compat_oid);
      	if (inserted)
      		return write_one_object(repo, oid, compat_oid);
      	return 0;
    @@ loose.c: int repo_loose_object_map_oid(struct repository *repo,
      			      struct object_id *dest)
      {
     -	struct object_directory *dir;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      	kh_oid_map_t *map;
      	khiter_t pos;
      
     -	for (dir = repo->objects->odb; dir; dir = dir->next) {
     -		struct loose_object_map *loose_map = dir->loose_map;
    -+	for (alternate = repo->objects->alternates; alternate; alternate = alternate->next) {
    -+		struct loose_object_map *loose_map = alternate->loose_map;
    ++	for (source = repo->objects->sources; source; source = source->next) {
    ++		struct loose_object_map *loose_map = source->loose_map;
      		if (!loose_map)
      			continue;
      		map = (to == repo->compat_hash_algo) ?
    @@ midx.c: void clear_midx_file(struct repository *r)
      	struct strbuf midx = STRBUF_INIT;
      
     -	get_midx_filename(r->hash_algo, &midx, r->objects->odb->path);
    -+	get_midx_filename(r->hash_algo, &midx, r->objects->alternates->path);
    ++	get_midx_filename(r->hash_algo, &midx, r->objects->sources->path);
      
      	if (r->objects && r->objects->multi_pack_index) {
      		close_midx(r->objects->multi_pack_index);
    @@ midx.c: void clear_midx_file(struct repository *r)
      
     -	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_BITMAP, NULL);
     -	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_REV, NULL);
    -+	clear_midx_files_ext(r->objects->alternates->path, MIDX_EXT_BITMAP, NULL);
    -+	clear_midx_files_ext(r->objects->alternates->path, MIDX_EXT_REV, NULL);
    ++	clear_midx_files_ext(r->objects->sources->path, MIDX_EXT_BITMAP, NULL);
    ++	clear_midx_files_ext(r->objects->sources->path, MIDX_EXT_REV, NULL);
      
      	strbuf_release(&midx);
      }
    @@ object-file.c: static void fill_loose_path(struct strbuf *buf, const struct obje
      }
      
     -const char *odb_loose_path(struct object_directory *odb,
    -+const char *odb_loose_path(struct odb_alternate *alternate,
    ++const char *odb_loose_path(struct odb_source *source,
      			   struct strbuf *buf,
      			   const struct object_id *oid)
      {
      	strbuf_reset(buf);
     -	strbuf_addstr(buf, odb->path);
    -+	strbuf_addstr(buf, alternate->path);
    ++	strbuf_addstr(buf, source->path);
      	strbuf_addch(buf, '/');
      	fill_loose_path(buf, oid);
      	return buf->buf;
    @@ object-file.c: int check_and_freshen_file(const char *fn, int freshen)
      }
      
     -static int check_and_freshen_odb(struct object_directory *odb,
    -+static int check_and_freshen_odb(struct odb_alternate *alternate,
    ++static int check_and_freshen_odb(struct odb_source *source,
      				 const struct object_id *oid,
      				 int freshen)
      {
      	static struct strbuf path = STRBUF_INIT;
     -	odb_loose_path(odb, &path, oid);
    -+	odb_loose_path(alternate, &path, oid);
    ++	odb_loose_path(source, &path, oid);
      	return check_and_freshen_file(path.buf, freshen);
      }
      
      static int check_and_freshen_local(const struct object_id *oid, int freshen)
      {
     -	return check_and_freshen_odb(the_repository->objects->odb, oid, freshen);
    -+	return check_and_freshen_odb(the_repository->objects->alternates, oid, freshen);
    ++	return check_and_freshen_odb(the_repository->objects->sources, oid, freshen);
      }
      
      static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	prepare_alt_odb(the_repository);
     -	for (odb = the_repository->objects->odb->next; odb; odb = odb->next) {
     -		if (check_and_freshen_odb(odb, oid, freshen))
    -+	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
    -+		if (check_and_freshen_odb(alternate, oid, freshen))
    ++	for (source = the_repository->objects->sources->next; source; source = source->next) {
    ++		if (check_and_freshen_odb(source, oid, freshen))
      			return 1;
      	}
      	return 0;
    @@ object-file.c: int stream_object_signature(struct repository *r, const struct ob
      			     struct stat *st, const char **path)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      	static struct strbuf buf = STRBUF_INIT;
      
      	prepare_alt_odb(r);
     -	for (odb = r->objects->odb; odb; odb = odb->next) {
     -		*path = odb_loose_path(odb, &buf, oid);
    -+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    -+		*path = odb_loose_path(alternate, &buf, oid);
    ++	for (source = r->objects->sources; source; source = source->next) {
    ++		*path = odb_loose_path(source, &buf, oid);
      		if (!lstat(*path, st))
      			return 0;
      	}
    @@ object-file.c: static int open_loose_object(struct repository *r,
      {
      	int fd;
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      	int most_interesting_errno = ENOENT;
      	static struct strbuf buf = STRBUF_INIT;
      
      	prepare_alt_odb(r);
     -	for (odb = r->objects->odb; odb; odb = odb->next) {
     -		*path = odb_loose_path(odb, &buf, oid);
    -+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    -+		*path = odb_loose_path(alternate, &buf, oid);
    ++	for (source = r->objects->sources; source; source = source->next) {
    ++		*path = odb_loose_path(source, &buf, oid);
      		fd = git_open(*path);
      		if (fd >= 0)
      			return fd;
    @@ object-file.c: static int open_loose_object(struct repository *r,
      			   const struct object_id *oid)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	prepare_alt_odb(r);
     -	for (odb = r->objects->odb; odb; odb = odb->next) {
     -		if (oidtree_contains(odb_loose_cache(odb, oid), oid))
    -+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    -+		if (oidtree_contains(odb_loose_cache(alternate, oid), oid))
    ++	for (source = r->objects->sources; source; source = source->next) {
    ++		if (oidtree_contains(odb_loose_cache(source, oid), oid))
      			return 1;
      	}
      	return 0;
    @@ object-file.c: void hash_object_file(const struct git_hash_algo *algo, const voi
      static void close_loose_object(int fd, const char *filename)
      {
     -	if (the_repository->objects->odb->will_destroy)
    -+	if (the_repository->objects->alternates->will_destroy)
    ++	if (the_repository->objects->sources->will_destroy)
      		goto out;
      
      	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      		prepare_loose_object_bulk_checkin();
      
     -	odb_loose_path(the_repository->objects->odb, &filename, oid);
    -+	odb_loose_path(the_repository->objects->alternates, &filename, oid);
    ++	odb_loose_path(the_repository->objects->sources, &filename, oid);
      
      	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
      				       &stream, compressed, sizeof(compressed),
    @@ object-file.c: int stream_loose_object(struct input_stream *in_stream, size_t le
      	}
      
     -	odb_loose_path(the_repository->objects->odb, &filename, oid);
    -+	odb_loose_path(the_repository->objects->alternates, &filename, oid);
    ++	odb_loose_path(the_repository->objects->sources, &filename, oid);
      
      	/* We finally know the object path, and create the missing dir. */
      	dirlen = directory_size(filename.buf);
    @@ object-file.c: int for_each_loose_file_in_objdir(const char *path,
      			  enum for_each_object_flags flags)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	prepare_alt_odb(the_repository);
     -	for (odb = the_repository->objects->odb; odb; odb = odb->next) {
     -		int r = for_each_loose_file_in_objdir(odb->path, cb, NULL,
    -+	for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
    -+		int r = for_each_loose_file_in_objdir(alternate->path, cb, NULL,
    ++	for (source = the_repository->objects->sources; source; source = source->next) {
    ++		int r = for_each_loose_file_in_objdir(source->path, cb, NULL,
      						      NULL, data);
      		if (r)
      			return r;
    @@ object-file.c: static int append_loose_object(const struct object_id *oid,
      
     -struct oidtree *odb_loose_cache(struct object_directory *odb,
     -				  const struct object_id *oid)
    -+struct oidtree *odb_loose_cache(struct odb_alternate *alternate,
    ++struct oidtree *odb_loose_cache(struct odb_source *source,
     +				const struct object_id *oid)
      {
      	int subdir_nr = oid->hash[0];
      	struct strbuf buf = STRBUF_INIT;
     -	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
    -+	size_t word_bits = bitsizeof(alternate->loose_objects_subdir_seen[0]);
    ++	size_t word_bits = bitsizeof(source->loose_objects_subdir_seen[0]);
      	size_t word_index = subdir_nr / word_bits;
      	size_t mask = (size_t)1u << (subdir_nr % word_bits);
      	uint32_t *bitmap;
      
      	if (subdir_nr < 0 ||
     -	    subdir_nr >= bitsizeof(odb->loose_objects_subdir_seen))
    -+	    subdir_nr >= bitsizeof(alternate->loose_objects_subdir_seen))
    ++	    subdir_nr >= bitsizeof(source->loose_objects_subdir_seen))
      		BUG("subdir_nr out of range");
      
     -	bitmap = &odb->loose_objects_subdir_seen[word_index];
    -+	bitmap = &alternate->loose_objects_subdir_seen[word_index];
    ++	bitmap = &source->loose_objects_subdir_seen[word_index];
      	if (*bitmap & mask)
     -		return odb->loose_objects_cache;
     -	if (!odb->loose_objects_cache) {
     -		ALLOC_ARRAY(odb->loose_objects_cache, 1);
     -		oidtree_init(odb->loose_objects_cache);
    -+		return alternate->loose_objects_cache;
    -+	if (!alternate->loose_objects_cache) {
    -+		ALLOC_ARRAY(alternate->loose_objects_cache, 1);
    -+		oidtree_init(alternate->loose_objects_cache);
    ++		return source->loose_objects_cache;
    ++	if (!source->loose_objects_cache) {
    ++		ALLOC_ARRAY(source->loose_objects_cache, 1);
    ++		oidtree_init(source->loose_objects_cache);
      	}
     -	strbuf_addstr(&buf, odb->path);
    -+	strbuf_addstr(&buf, alternate->path);
    ++	strbuf_addstr(&buf, source->path);
      	for_each_file_in_obj_subdir(subdir_nr, &buf,
      				    append_loose_object,
      				    NULL, NULL,
     -				    odb->loose_objects_cache);
    -+				    alternate->loose_objects_cache);
    ++				    source->loose_objects_cache);
      	*bitmap |= mask;
      	strbuf_release(&buf);
     -	return odb->loose_objects_cache;
    -+	return alternate->loose_objects_cache;
    ++	return source->loose_objects_cache;
      }
      
     -void odb_clear_loose_cache(struct object_directory *odb)
    -+void odb_clear_loose_cache(struct odb_alternate *alternate)
    ++void odb_clear_loose_cache(struct odb_source *source)
      {
     -	oidtree_clear(odb->loose_objects_cache);
     -	FREE_AND_NULL(odb->loose_objects_cache);
     -	memset(&odb->loose_objects_subdir_seen, 0,
     -	       sizeof(odb->loose_objects_subdir_seen));
    -+	oidtree_clear(alternate->loose_objects_cache);
    -+	FREE_AND_NULL(alternate->loose_objects_cache);
    -+	memset(&alternate->loose_objects_subdir_seen, 0,
    -+	       sizeof(alternate->loose_objects_subdir_seen));
    ++	oidtree_clear(source->loose_objects_cache);
    ++	FREE_AND_NULL(source->loose_objects_cache);
    ++	memset(&source->loose_objects_subdir_seen, 0,
    ++	       sizeof(source->loose_objects_subdir_seen));
      }
      
      static int check_stream_oid(git_zstream *stream,
    @@ object-file.h: enum {
      int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
      
     -struct object_directory;
    -+struct odb_alternate;
    ++struct odb_source;
      
      /*
       * Populate and return the loose object cache array corresponding to the
       * given object ID.
       */
     -struct oidtree *odb_loose_cache(struct object_directory *odb,
    -+struct oidtree *odb_loose_cache(struct odb_alternate *alternate,
    ++struct oidtree *odb_loose_cache(struct odb_source *source,
      				const struct object_id *oid);
      
      /* Empty the loose object cache for the specified object directory. */
     -void odb_clear_loose_cache(struct object_directory *odb);
    -+void odb_clear_loose_cache(struct odb_alternate *alternate);
    ++void odb_clear_loose_cache(struct odb_source *source);
      
      /*
       * Put in `buf` the name of the file in the local object database that
       * would be used to store a loose object with the specified oid.
       */
     -const char *odb_loose_path(struct object_directory *odb,
    -+const char *odb_loose_path(struct odb_alternate *alternate,
    ++const char *odb_loose_path(struct odb_source *source,
      			   struct strbuf *buf,
      			   const struct object_id *oid);
      
    @@ object-name.c: static enum cb_next match_prefix(const struct object_id *oid, voi
      static void find_short_object_filename(struct disambiguate_state *ds)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
     -	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next)
     -		oidtree_each(odb_loose_cache(odb, &ds->bin_pfx),
    -+	for (alternate = ds->repo->objects->alternates; alternate && !ds->ambiguous; alternate = alternate->next)
    -+		oidtree_each(odb_loose_cache(alternate, &ds->bin_pfx),
    ++	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
    ++		oidtree_each(odb_loose_cache(source, &ds->bin_pfx),
      				&ds->bin_pfx, ds->len, match_prefix, ds);
      }
      
    @@ object-store.c
      
      KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
     -	struct object_directory *, 1, fspathhash, fspatheq)
    -+	struct odb_alternate *, 1, fspathhash, fspatheq)
    ++	struct odb_source *, 1, fspathhash, fspatheq)
      
      /*
       * This is meant to hold a *small* number of objects that you would
    @@ object-store.c: static int alt_odb_usable(struct object_database *o,
      	 * thing twice, or object directory itself.
      	 */
     -	if (!o->odb_by_path) {
    -+	if (!o->alternate_by_path) {
    ++	if (!o->source_by_path) {
      		khiter_t p;
      
     -		o->odb_by_path = kh_init_odb_path_map();
     -		assert(!o->odb->next);
     -		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
    -+		o->alternate_by_path = kh_init_odb_path_map();
    -+		assert(!o->alternates->next);
    -+		p = kh_put_odb_path_map(o->alternate_by_path, o->alternates->path, &r);
    ++		o->source_by_path = kh_init_odb_path_map();
    ++		assert(!o->sources->next);
    ++		p = kh_put_odb_path_map(o->source_by_path, o->sources->path, &r);
      		assert(r == 1); /* never used */
     -		kh_value(o->odb_by_path, p) = o->odb;
    -+		kh_value(o->alternate_by_path, p) = o->alternates;
    ++		kh_value(o->source_by_path, p) = o->sources;
      	}
      	if (fspatheq(path->buf, normalized_objdir))
      		return 0;
     -	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
    -+	*pos = kh_put_odb_path_map(o->alternate_by_path, path->buf, &r);
    ++	*pos = kh_put_odb_path_map(o->source_by_path, path->buf, &r);
      	/* r: 0 = exists, 1 = never used, 2 = deleted */
      	return r == 0 ? 0 : 1;
      }
    @@ object-store.c: static int alt_odb_usable(struct object_database *o,
       *
       * The variable alt_odb_list points at the list of struct
     - * object_directory.  The elements on this list come from
    -+ * odb_alternate.  The elements on this list come from
    ++ * odb_source.  The elements on this list come from
       * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
       * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
       * whose contents is similar to that environment variable but can be
    @@ object-store.c: static void read_info_alternates(struct repository *r,
      	const char *relative_base, int depth, const char *normalized_objdir)
      {
     -	struct object_directory *ent;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *alternate;
      	struct strbuf pathbuf = STRBUF_INIT;
      	struct strbuf tmp = STRBUF_INIT;
      	khiter_t pos;
    @@ object-store.c: static int link_alt_odb_entry(struct repository *r, const struct
     -	/* pathbuf.buf is already in r->objects->odb_by_path */
     -	ent->path = strbuf_detach(&pathbuf, NULL);
     +	CALLOC_ARRAY(alternate, 1);
    -+	/* pathbuf.buf is already in r->objects->alternate_by_path */
    ++	/* pathbuf.buf is already in r->objects->source_by_path */
     +	alternate->path = strbuf_detach(&pathbuf, NULL);
      
      	/* add the alternate entry */
    @@ object-store.c: static int link_alt_odb_entry(struct repository *r, const struct
     -	ent->next = NULL;
     -	assert(r->objects->odb_by_path);
     -	kh_value(r->objects->odb_by_path, pos) = ent;
    -+	*r->objects->alternates_tail = alternate;
    -+	r->objects->alternates_tail = &(alternate->next);
    ++	*r->objects->sources_tail = alternate;
    ++	r->objects->sources_tail = &(alternate->next);
     +	alternate->next = NULL;
    -+	assert(r->objects->alternate_by_path);
    -+	kh_value(r->objects->alternate_by_path, pos) = alternate;
    ++	assert(r->objects->source_by_path);
    ++	kh_value(r->objects->source_by_path, pos) = alternate;
      
      	/* recursively add alternates */
     -	read_info_alternates(r, ent->path, depth + 1);
    @@ object-store.c: static void link_alt_odb_entries(struct repository *r, const cha
      	}
      
     -	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
    -+	strbuf_realpath(&objdirbuf, r->objects->alternates->path, 1);
    ++	strbuf_realpath(&objdirbuf, r->objects->sources->path, 1);
      
      	while (*alt) {
      		alt = parse_alt_odb_entry(alt, sep, &entry);
    @@ object-store.c: void add_to_alternates_memory(const char *reference)
      }
      
     -struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
    -+struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destroy)
    ++struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
      {
     -	struct object_directory *new_odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	/*
      	 * Make sure alternates are initialized, or else our entry may be
    @@ object-store.c: struct object_directory *set_temporary_primary_odb(const char *d
      	 */
     -	new_odb = xcalloc(1, sizeof(*new_odb));
     -	new_odb->path = xstrdup(dir);
    -+	alternate = xcalloc(1, sizeof(*alternate));
    -+	alternate->path = xstrdup(dir);
    ++	source = xcalloc(1, sizeof(*source));
    ++	source->path = xstrdup(dir);
      
      	/*
      	 * Disable ref updates while a temporary odb is active, since
    @@ object-store.c: struct object_directory *set_temporary_primary_odb(const char *d
     -	new_odb->next = the_repository->objects->odb;
     -	the_repository->objects->odb = new_odb;
     -	return new_odb->next;
    -+	alternate->disable_ref_updates = 1;
    -+	alternate->will_destroy = will_destroy;
    -+	alternate->next = the_repository->objects->alternates;
    -+	the_repository->objects->alternates = alternate;
    -+	return alternate->next;
    ++	source->disable_ref_updates = 1;
    ++	source->will_destroy = will_destroy;
    ++	source->next = the_repository->objects->sources;
    ++	the_repository->objects->sources = source;
    ++	return source->next;
      }
      
     -static void free_object_directory(struct object_directory *odb)
    -+static void free_object_directory(struct odb_alternate *alternate)
    ++static void free_object_directory(struct odb_source *source)
      {
     -	free(odb->path);
     -	odb_clear_loose_cache(odb);
     -	loose_object_map_clear(&odb->loose_map);
     -	free(odb);
    -+	free(alternate->path);
    -+	odb_clear_loose_cache(alternate);
    -+	loose_object_map_clear(&alternate->loose_map);
    -+	free(alternate);
    ++	free(source->path);
    ++	odb_clear_loose_cache(source);
    ++	loose_object_map_clear(&source->loose_map);
    ++	free(source);
      }
      
     -void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
    -+void restore_primary_odb(struct odb_alternate *restore_alt, const char *old_path)
    ++void restore_primary_odb(struct odb_source *restore_alt, const char *old_path)
      {
     -	struct object_directory *cur_odb = the_repository->objects->odb;
    -+	struct odb_alternate *cur_alt = the_repository->objects->alternates;
    ++	struct odb_source *cur_alt = the_repository->objects->sources;
      
     -	if (strcmp(old_path, cur_odb->path))
     +	if (strcmp(old_path, cur_alt->path))
    @@ object-store.c: struct object_directory *set_temporary_primary_odb(const char *d
      
     -	the_repository->objects->odb = restore_odb;
     -	free_object_directory(cur_odb);
    -+	the_repository->objects->alternates = restore_alt;
    ++	the_repository->objects->sources = restore_alt;
     +	free_object_directory(cur_alt);
      }
      
    @@ object-store.c: char *compute_alternate_path(const char *path, struct strbuf *er
      }
      
     -struct object_directory *find_odb(struct repository *r, const char *obj_dir)
    -+struct odb_alternate *find_odb(struct repository *r, const char *obj_dir)
    ++struct odb_source *find_odb(struct repository *r, const char *obj_dir)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      	char *obj_dir_real = real_pathdup(obj_dir, 1);
      	struct strbuf odb_path_real = STRBUF_INIT;
      
      	prepare_alt_odb(r);
     -	for (odb = r->objects->odb; odb; odb = odb->next) {
     -		strbuf_realpath(&odb_path_real, odb->path, 1);
    -+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    -+		strbuf_realpath(&odb_path_real, alternate->path, 1);
    ++	for (source = r->objects->sources; source; source = source->next) {
    ++		strbuf_realpath(&odb_path_real, source->path, 1);
      		if (!strcmp(obj_dir_real, odb_path_real.buf))
      			break;
      	}
    @@ object-store.c: struct object_directory *find_odb(struct repository *r, const ch
      	strbuf_release(&odb_path_real);
      
     -	if (!odb)
    -+	if (!alternate)
    ++	if (!source)
      		die(_("could not find object directory matching %s"), obj_dir);
     -	return odb;
    -+	return alternate;
    ++	return source;
      }
      
      static void fill_alternate_refs_command(struct child_process *cmd,
    @@ object-store.c: struct alternate_refs_data {
      };
      
     -static int refs_from_alternate_cb(struct object_directory *e,
    -+static int refs_from_alternate_cb(struct odb_alternate *alternate,
    ++static int refs_from_alternate_cb(struct odb_source *alternate,
      				  void *data)
      {
      	struct strbuf path = STRBUF_INIT;
    @@ object-store.c: void for_each_alternate_ref(alternate_ref_fn fn, void *data)
      int foreach_alt_odb(alt_odb_fn fn, void *cb)
      {
     -	struct object_directory *ent;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *alternate;
      	int r = 0;
      
      	prepare_alt_odb(the_repository);
     -	for (ent = the_repository->objects->odb->next; ent; ent = ent->next) {
     -		r = fn(ent, cb);
    -+	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
    ++	for (alternate = the_repository->objects->sources->next; alternate; alternate = alternate->next) {
     +		r = fn(alternate, cb);
      		if (r)
      			break;
    @@ object-store.c: void prepare_alt_odb(struct repository *r)
      	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
      
     -	read_info_alternates(r, r->objects->odb->path, 0);
    -+	read_info_alternates(r, r->objects->alternates->path, 0);
    ++	read_info_alternates(r, r->objects->sources->path, 0);
      	r->objects->loaded_alternates = 1;
      }
      
    @@ object-store.c: void prepare_alt_odb(struct repository *r)
      {
      	prepare_alt_odb(r);
     -	return !!r->objects->odb->next;
    -+	return !!r->objects->alternates->next;
    ++	return !!r->objects->sources->next;
      }
      
      int obj_read_use_lock = 0;
    @@ object-store.c: struct object_database *odb_new(void)
      {
     -	while (o->odb) {
     -		struct object_directory *next;
    -+	while (o->alternates) {
    -+		struct odb_alternate *next;
    ++	while (o->sources) {
    ++		struct odb_source *next;
      
     -		next = o->odb->next;
     -		free_object_directory(o->odb);
     -		o->odb = next;
    -+		next = o->alternates->next;
    -+		free_object_directory(o->alternates);
    -+		o->alternates = next;
    ++		next = o->sources->next;
    ++		free_object_directory(o->sources);
    ++		o->sources = next;
      	}
     -	kh_destroy_odb_path_map(o->odb_by_path);
     -	o->odb_by_path = NULL;
    -+	kh_destroy_odb_path_map(o->alternate_by_path);
    -+	o->alternate_by_path = NULL;
    ++	kh_destroy_odb_path_map(o->source_by_path);
    ++	o->source_by_path = NULL;
      }
      
      void odb_clear(struct object_database *o)
    @@ object-store.c: void odb_clear(struct object_database *o)
      
      	free_object_directories(o);
     -	o->odb_tail = NULL;
    -+	o->alternates_tail = NULL;
    ++	o->sources_tail = NULL;
      	o->loaded_alternates = 0;
      
      	for (size_t i = 0; i < o->cached_object_nr; i++)
    @@ object-store.h: struct oidtree;
     -struct object_directory {
     -	struct object_directory *next;
     +/*
    -+ * The alternate is the part of the object database that stores the actual
    ++ * The source is the part of the object database that stores the actual
     + * objects. It thus encapsulates the logic to read and write the specific
    -+ * on-disk format. An object database can have multiple alternates, and
    -+ * exactly one primary alternate that is used when writing new objects.
    ++ * on-disk format. An object database can have multiple sources:
    ++ *
    ++ *   - The primary source, which is typically located in "$GIT_DIR/objects".
    ++ *     This is where new objects are usually written to.
    ++ *
    ++ *   - Alternate sources, which are configured via "objects/info/alternates" or
    ++ *     via the GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable. These
    ++ *     alternate sources are only used to read objects.
     + */
    -+struct odb_alternate {
    -+	struct odb_alternate *next;
    ++struct odb_source {
    ++	struct odb_source *next;
      
      	/*
      	 * Used to store the results of readdir(3) calls when we are OK
    +@@ object-store.h: struct object_directory {
    + 	int will_destroy;
    + 
    + 	/*
    +-	 * Path to the alternative object store. If this is a relative path,
    +-	 * it is relative to the current working directory.
    ++	 * Path to the source. If this is a relative path, it is relative to
    ++	 * the current working directory.
    + 	 */
    + 	char *path;
    + };
     @@ object-store.h: struct object_directory {
      void prepare_alt_odb(struct repository *r);
      int has_alt_odb(struct repository *r);
      char *compute_alternate_path(const char *path, struct strbuf *err);
     -struct object_directory *find_odb(struct repository *r, const char *obj_dir);
     -typedef int alt_odb_fn(struct object_directory *, void *);
    -+struct odb_alternate *find_odb(struct repository *r, const char *obj_dir);
    -+typedef int alt_odb_fn(struct odb_alternate *, void *);
    ++struct odb_source *find_odb(struct repository *r, const char *obj_dir);
    ++typedef int alt_odb_fn(struct odb_source *, void *);
      int foreach_alt_odb(alt_odb_fn, void*);
      typedef void alternate_ref_fn(const struct object_id *oid, void *);
      void for_each_alternate_ref(alternate_ref_fn, void *);
    @@ object-store.h: void add_to_alternates_memory(const char *dir);
       * object directory; returns the former primary object directory.
       */
     -struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
    -+struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destroy);
    ++struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy);
      
      /*
       * Restore a previous ODB replaced by set_temporary_main_odb.
       */
     -void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
    -+void restore_primary_odb(struct odb_alternate *restore_alternate, const char *old_path);
    ++void restore_primary_odb(struct odb_source *restore_alternate, const char *old_path);
      
      struct packed_git;
      struct multi_pack_index;
    @@ object-store.h: struct object_database {
     -	struct object_directory *odb;
     -	struct object_directory **odb_tail;
     -	struct kh_odb_path_map *odb_by_path;
    -+	struct odb_alternate *alternates;
    -+	struct odb_alternate **alternates_tail;
    -+	struct kh_odb_path_map *alternate_by_path;
    ++	struct odb_source *sources;
    ++	struct odb_source **sources_tail;
    ++	struct kh_odb_path_map *source_by_path;
      
      	int loaded_alternates;
      
    @@ object-store.h: struct object_database {
      	 * A list of alternate object directories loaded from the environment;
      	 * this should not generally need to be accessed directly, but will
     -	 * populate the "odb" list when prepare_alt_odb() is run.
    -+	 * populate the "alternates" list when prepare_alt_odb() is run.
    ++	 * populate the "sources" list when prepare_alt_odb() is run.
      	 */
      	char *alternate_db;
      
    @@ packfile.c: static void prepare_packed_git_mru(struct repository *r)
      static void prepare_packed_git(struct repository *r)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	if (r->objects->packed_git_initialized)
      		return;
    @@ packfile.c: static void prepare_packed_git_mru(struct repository *r)
     -		int local = (odb == r->objects->odb);
     -		prepare_multi_pack_index_one(r, odb->path, local);
     -		prepare_packed_git_one(r, odb->path, local);
    -+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    -+		int local = (alternate == r->objects->alternates);
    -+		prepare_multi_pack_index_one(r, alternate->path, local);
    -+		prepare_packed_git_one(r, alternate->path, local);
    ++	for (source = r->objects->sources; source; source = source->next) {
    ++		int local = (source == r->objects->sources);
    ++		prepare_multi_pack_index_one(r, source->path, local);
    ++		prepare_packed_git_one(r, source->path, local);
      	}
      	rearrange_packed_git(r);
      
    @@ packfile.c: static void prepare_packed_git(struct repository *r)
      void reprepare_packed_git(struct repository *r)
      {
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      
      	obj_read_lock();
      
    @@ packfile.c: void reprepare_packed_git(struct repository *r)
      
     -	for (odb = r->objects->odb; odb; odb = odb->next)
     -		odb_clear_loose_cache(odb);
    -+	for (alternate = r->objects->alternates; alternate; alternate = alternate->next)
    -+		odb_clear_loose_cache(alternate);
    ++	for (source = r->objects->sources; source; source = source->next)
    ++		odb_clear_loose_cache(source);
      
      	r->objects->approximate_object_count_valid = 0;
      	r->objects->packed_git_initialized = 0;
    @@ path.c: static void adjust_git_path(struct repository *repo,
      			      repo->index_file, strlen(repo->index_file));
      	else if (dir_prefix(base, "objects"))
     -		replace_dir(buf, git_dir_len + 7, repo->objects->odb->path);
    -+		replace_dir(buf, git_dir_len + 7, repo->objects->alternates->path);
    ++		replace_dir(buf, git_dir_len + 7, repo->objects->sources->path);
      	else if (repo_settings_get_hooks_path(repo) && dir_prefix(base, "hooks"))
      		replace_dir(buf, git_dir_len + 5, repo_settings_get_hooks_path(repo));
      	else if (repo->different_commondir)
    @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
      	}
      
     -	if (refs->repo->objects->odb->disable_ref_updates) {
    -+	if (refs->repo->objects->alternates->disable_ref_updates) {
    ++	if (refs->repo->objects->sources->disable_ref_updates) {
      		strbuf_addstr(err,
      			      _("ref updates forbidden inside quarantine environment"));
      		return -1;
    @@ repository.c: const char *repo_get_common_dir(struct repository *repo)
      const char *repo_get_object_directory(struct repository *repo)
      {
     -	if (!repo->objects->odb)
    -+	if (!repo->objects->alternates)
    ++	if (!repo->objects->sources)
      		BUG("repository hasn't been set up");
     -	return repo->objects->odb->path;
    -+	return repo->objects->alternates->path;
    ++	return repo->objects->sources->path;
      }
      
      const char *repo_get_index_file(struct repository *repo)
    @@ repository.c: void repo_set_gitdir(struct repository *repo,
     -	if (!repo->objects->odb) {
     -		CALLOC_ARRAY(repo->objects->odb, 1);
     -		repo->objects->odb_tail = &repo->objects->odb->next;
    -+	if (!repo->objects->alternates) {
    -+		CALLOC_ARRAY(repo->objects->alternates, 1);
    -+		repo->objects->alternates_tail = &repo->objects->alternates->next;
    ++	if (!repo->objects->sources) {
    ++		CALLOC_ARRAY(repo->objects->sources, 1);
    ++		repo->objects->sources_tail = &repo->objects->sources->next;
      	}
     -	expand_base_dir(&repo->objects->odb->path, o->object_dir,
    -+	expand_base_dir(&repo->objects->alternates->path, o->object_dir,
    ++	expand_base_dir(&repo->objects->sources->path, o->object_dir,
      			repo->commondir, "objects");
      
     -	repo->objects->odb->disable_ref_updates = o->disable_ref_updates;
    -+	repo->objects->alternates->disable_ref_updates = o->disable_ref_updates;
    ++	repo->objects->sources->disable_ref_updates = o->disable_ref_updates;
      
      	free(repo->objects->alternate_db);
      	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
    @@ submodule-config.c: static void config_from_gitmodules(config_fn_t fn, struct re
      			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
      			if (repo != the_repository)
     -				add_submodule_odb_by_path(repo->objects->odb->path);
    -+				add_submodule_odb_by_path(repo->objects->alternates->path);
    ++				add_submodule_odb_by_path(repo->objects->sources->path);
      		} else {
      			goto out;
      		}
    @@ t/helper/test-read-graph.c: static void dump_graph_bloom_filters(struct commit_g
      {
      	struct commit_graph *graph = NULL;
     -	struct object_directory *odb;
    -+	struct odb_alternate *alternate;
    ++	struct odb_source *source;
      	int ret = 0;
      
      	setup_git_directory();
     -	odb = the_repository->objects->odb;
    -+	alternate = the_repository->objects->alternates;
    ++	source = the_repository->objects->sources;
      
      	prepare_repo_settings(the_repository);
      
     -	graph = read_commit_graph_one(the_repository, odb);
    -+	graph = read_commit_graph_one(the_repository, alternate);
    ++	graph = read_commit_graph_one(the_repository, source);
      	if (!graph) {
      		ret = 1;
      		goto done;
    @@ tmp-objdir.c: struct tmp_objdir {
      	struct strbuf path;
      	struct strvec env;
     -	struct object_directory *prev_odb;
    -+	struct odb_alternate *prev_alt;
    ++	struct odb_source *prev_source;
      	int will_destroy;
      };
      
    @@ tmp-objdir.c: int tmp_objdir_destroy(struct tmp_objdir *t)
      
     -	if (t->prev_odb)
     -		restore_primary_odb(t->prev_odb, t->path.buf);
    -+	if (t->prev_alt)
    -+		restore_primary_odb(t->prev_alt, t->path.buf);
    ++	if (t->prev_source)
    ++		restore_primary_odb(t->prev_source, t->path.buf);
      
      	err = remove_dir_recursively(&t->path, 0);
      
    @@ tmp-objdir.c: int tmp_objdir_migrate(struct tmp_objdir *t)
      
     -	if (t->prev_odb) {
     -		if (t->repo->objects->odb->will_destroy)
    -+	if (t->prev_alt) {
    -+		if (t->repo->objects->alternates->will_destroy)
    ++	if (t->prev_source) {
    ++		if (t->repo->objects->sources->will_destroy)
      			BUG("migrating an ODB that was marked for destruction");
     -		restore_primary_odb(t->prev_odb, t->path.buf);
     -		t->prev_odb = NULL;
    -+		restore_primary_odb(t->prev_alt, t->path.buf);
    -+		t->prev_alt = NULL;
    ++		restore_primary_odb(t->prev_source, t->path.buf);
    ++		t->prev_source = NULL;
      	}
      
      	strbuf_addbuf(&src, &t->path);
    @@ tmp-objdir.c: void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
      void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
      {
     -	if (t->prev_odb)
    -+	if (t->prev_alt)
    ++	if (t->prev_source)
      		BUG("the primary object database is already replaced");
     -	t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
    -+	t->prev_alt = set_temporary_primary_odb(t->path.buf, will_destroy);
    ++	t->prev_source = set_temporary_primary_odb(t->path.buf, will_destroy);
      	t->will_destroy = will_destroy;
      }
      
      struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
      {
     -	if (!the_tmp_objdir || !the_tmp_objdir->prev_odb)
    -+	if (!the_tmp_objdir || !the_tmp_objdir->prev_alt)
    ++	if (!the_tmp_objdir || !the_tmp_objdir->prev_source)
      		return NULL;
      
     -	restore_primary_odb(the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
     -	the_tmp_objdir->prev_odb = NULL;
    -+	restore_primary_odb(the_tmp_objdir->prev_alt, the_tmp_objdir->path.buf);
    -+	the_tmp_objdir->prev_alt = NULL;
    ++	restore_primary_odb(the_tmp_objdir->prev_source, the_tmp_objdir->path.buf);
    ++	the_tmp_objdir->prev_source = NULL;
      	return the_tmp_objdir;
      }
      
 3:  c9fe7a702f2 =  3:  f294d140f35 object-store: rename files to "odb.{c,h}"
 4:  2d35bc630b1 !  4:  b9cd65d68e3 odb: introduce parent pointers
    @@ Commit message
     
         In subsequent commits we'll get rid of our use of `the_repository` in
         "odb.c" in favor of explicitly passing in a `struct object_database` or
    -    a `struct odb_alternate`. In some cases though we'll need access to the
    +    a `struct odb_source`. In some cases though we'll need access to the
         repository, for example to read a config value from it, but we don't
         have a way to access the repository owning a specific object database.
     
         Introduce parent pointers for `struct object_database` to its owning
    -    repository as well as for `struct odb_alternate` to its owning object
    +    repository as well as for `struct odb_source` to its owning object
         database, which will allow us to adapt those use cases.
     
         Note that this change requires us to pass through the object database to
         `link_alt_odb_entry()` so that we can set up the parent pointers for any
    -    alternate there. The callchain is adapted to pass through the object
    +    source there. The callchain is adapted to pass through the object
         database accordingly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ odb.c: static int alt_odb_usable(struct object_database *o,
     +			      int depth,
     +			      const char *normalized_objdir)
      {
    - 	struct odb_alternate *alternate;
    + 	struct odb_source *alternate;
      	struct strbuf pathbuf = STRBUF_INIT;
     @@ odb.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
      	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
    @@ odb.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *
      		goto error;
      
      	CALLOC_ARRAY(alternate, 1);
    +-	/* pathbuf.buf is already in r->objects->source_by_path */
     +	alternate->odb = odb;
    - 	/* pathbuf.buf is already in r->objects->alternate_by_path */
    ++	/* pathbuf.buf is already in r->objects->alternate_by_path */
      	alternate->path = strbuf_detach(&pathbuf, NULL);
      
      	/* add the alternate entry */
    --	*r->objects->alternates_tail = alternate;
    --	r->objects->alternates_tail = &(alternate->next);
    -+	*odb->alternates_tail = alternate;
    -+	odb->alternates_tail = &(alternate->next);
    +-	*r->objects->sources_tail = alternate;
    +-	r->objects->sources_tail = &(alternate->next);
    ++	*odb->sources_tail = alternate;
    ++	odb->sources_tail = &(alternate->next);
      	alternate->next = NULL;
    --	assert(r->objects->alternate_by_path);
    --	kh_value(r->objects->alternate_by_path, pos) = alternate;
    -+	assert(odb->alternate_by_path);
    -+	kh_value(odb->alternate_by_path, pos) = alternate;
    +-	assert(r->objects->source_by_path);
    +-	kh_value(r->objects->source_by_path, pos) = alternate;
    ++	assert(odb->source_by_path);
    ++	kh_value(odb->source_by_path, pos) = alternate;
      
      	/* recursively add alternates */
     -	read_info_alternates(r, alternate->path, depth + 1);
    @@ odb.c: static void link_alt_odb_entries(struct repository *r, const char *alt,
      		return;
      	}
      
    --	strbuf_realpath(&objdirbuf, r->objects->alternates->path, 1);
    -+	strbuf_realpath(&objdirbuf, odb->alternates->path, 1);
    +-	strbuf_realpath(&objdirbuf, r->objects->sources->path, 1);
    ++	strbuf_realpath(&objdirbuf, odb->sources->path, 1);
      
      	while (*alt) {
      		alt = parse_alt_odb_entry(alt, sep, &entry);
    @@ odb.c: void add_to_alternates_memory(const char *reference)
      			     '\n', NULL, 0);
      }
      
    -@@ odb.c: struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destro
    +@@ odb.c: struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
      	 * alternate
      	 */
    - 	alternate = xcalloc(1, sizeof(*alternate));
    -+	alternate->odb = the_repository->objects;
    - 	alternate->path = xstrdup(dir);
    + 	source = xcalloc(1, sizeof(*source));
    ++	source->odb = the_repository->objects;
    + 	source->path = xstrdup(dir);
      
      	/*
     @@ odb.c: void prepare_alt_odb(struct repository *r)
    @@ odb.c: void prepare_alt_odb(struct repository *r)
     -	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
     +	link_alt_odb_entries(r->objects, r->objects->alternate_db, PATH_SEP, NULL, 0);
      
    --	read_info_alternates(r, r->objects->alternates->path, 0);
    -+	read_info_alternates(r->objects, r->objects->alternates->path, 0);
    +-	read_info_alternates(r, r->objects->sources->path, 0);
    ++	read_info_alternates(r->objects, r->objects->sources->path, 0);
      	r->objects->loaded_alternates = 1;
      }
      
    @@ odb.c: void assert_oid_type(const struct object_id *oid, enum object_type expect
     
      ## odb.h ##
     @@ odb.h: struct repository;
    - struct odb_alternate {
    - 	struct odb_alternate *next;
    + struct odb_source {
    + 	struct odb_source *next;
      
    -+	/* Object database that owns this alternate. */
    ++	/* Object database that owns this object source. */
     +	struct object_database *odb;
     +
      	/*
    @@ repository.c: static void set_default_hash_algo(struct repository *repo)
      	ALLOC_ARRAY(repo->index, 1);
     @@ repository.c: void repo_set_gitdir(struct repository *repo,
      
    - 	if (!repo->objects->alternates) {
    - 		CALLOC_ARRAY(repo->objects->alternates, 1);
    -+		repo->objects->alternates->odb = repo->objects;
    - 		repo->objects->alternates_tail = &repo->objects->alternates->next;
    + 	if (!repo->objects->sources) {
    + 		CALLOC_ARRAY(repo->objects->sources, 1);
    ++		repo->objects->sources->odb = repo->objects;
    + 		repo->objects->sources_tail = &repo->objects->sources->next;
      	}
    - 	expand_base_dir(&repo->objects->alternates->path, o->object_dir,
    + 	expand_base_dir(&repo->objects->sources->path, o->object_dir,
 5:  7ed8aaa8e94 <  -:  ----------- odb: get rid of `the_repository` in `find_odb()`
 -:  ----------- >  5:  ca3b9e62e03 odb: get rid of `the_repository` in `find_odb()`
 6:  3cad18408a7 =  6:  36c9802f66c odb: get rid of `the_repository` in `assert_oid_type()`
 7:  2b69ee1249b !  7:  7dcf630c701 odb: get rid of `the_repository` in `odb_mkstemp()`
    @@ odb.c: int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
     
      ## odb.h ##
     @@ odb.h: void odb_clear(struct object_database *o);
    - struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir);
    + struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
      
      /*
     - * Create a temporary file rooted in the object database directory, or
 8:  cd36a4906a9 !  8:  2d3a4a958d7 odb: get rid of `the_repository` when handling alternates
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      	} else {
     -		prepare_alt_odb(the_repository);
     +		odb_prepare_alternates(the_repository->objects);
    - 		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next)
    - 			fsck_object_dir(alternate->path);
    + 		for (source = the_repository->objects->sources; source; source = source->next)
    + 			fsck_object_dir(source->path);
      
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      	if (the_repository->settings.core_commit_graph) {
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      
     -		prepare_alt_odb(the_repository);
     +		odb_prepare_alternates(the_repository->objects);
    - 		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
    + 		for (source = the_repository->objects->sources; source; source = source->next) {
      			child_process_init(&commit_graph_verify);
      			commit_graph_verify.git_cmd = 1;
     @@ builtin/fsck.c: int cmd_fsck(int argc,
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      
     -		prepare_alt_odb(the_repository);
     +		odb_prepare_alternates(the_repository->objects);
    - 		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
    + 		for (source = the_repository->objects->sources; source; source = source->next) {
      			child_process_init(&midx_verify);
      			midx_verify.git_cmd = 1;
     
    @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct reposi
     +	odb_prepare_alternates(r->objects);
      
      	for (i = 0; i < count; i++) {
    - 		struct odb_alternate *alternate;
    + 		struct odb_source *source;
     @@ commit-graph.c: static int prepare_commit_graph(struct repository *r)
      	if (!commit_graph_compatible(r))
      		return 0;
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (alternate = r->objects->alternates;
    - 	     !r->objects->commit_graph && alternate;
    - 	     alternate = alternate->next)
    + 	for (source = r->objects->sources;
    + 	     !r->objects->commit_graph && source;
    + 	     source = source->next)
     
      ## loose.c ##
     @@ loose.c: int repo_read_loose_object_map(struct repository *repo)
    @@ loose.c: int repo_read_loose_object_map(struct repository *repo)
     -	prepare_alt_odb(repo);
     +	odb_prepare_alternates(repo->objects);
      
    - 	for (alternate = repo->objects->alternates; alternate; alternate = alternate->next) {
    - 		if (load_one_loose_object_map(repo, alternate) < 0) {
    + 	for (source = repo->objects->sources; source; source = source->next) {
    + 		if (load_one_loose_object_map(repo, source) < 0) {
     
      ## object-file.c ##
     @@ object-file.c: static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
      {
    - 	struct odb_alternate *alternate;
    + 	struct odb_source *source;
      
     -	prepare_alt_odb(the_repository);
     +	odb_prepare_alternates(the_repository->objects);
    - 	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
    - 		if (check_and_freshen_odb(alternate, oid, freshen))
    + 	for (source = the_repository->objects->sources->next; source; source = source->next) {
    + 		if (check_and_freshen_odb(source, oid, freshen))
      			return 1;
     @@ object-file.c: static int stat_loose_object(struct repository *r, const struct object_id *oid,
    - 	struct odb_alternate *alternate;
    + 	struct odb_source *source;
      	static struct strbuf buf = STRBUF_INIT;
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    - 		*path = odb_loose_path(alternate, &buf, oid);
    + 	for (source = r->objects->sources; source; source = source->next) {
    + 		*path = odb_loose_path(source, &buf, oid);
      		if (!lstat(*path, st))
     @@ object-file.c: static int open_loose_object(struct repository *r,
      	int most_interesting_errno = ENOENT;
    @@ object-file.c: static int open_loose_object(struct repository *r,
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    - 		*path = odb_loose_path(alternate, &buf, oid);
    + 	for (source = r->objects->sources; source; source = source->next) {
    + 		*path = odb_loose_path(source, &buf, oid);
      		fd = git_open(*path);
     @@ object-file.c: static int quick_has_loose(struct repository *r,
      {
    - 	struct odb_alternate *alternate;
    + 	struct odb_source *source;
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    - 		if (oidtree_contains(odb_loose_cache(alternate, oid), oid))
    + 	for (source = r->objects->sources; source; source = source->next) {
    + 		if (oidtree_contains(odb_loose_cache(source, oid), oid))
      			return 1;
     @@ object-file.c: int for_each_loose_object(each_loose_object_fn cb, void *data,
      {
    - 	struct odb_alternate *alternate;
    + 	struct odb_source *source;
      
     -	prepare_alt_odb(the_repository);
     +	odb_prepare_alternates(the_repository->objects);
    - 	for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
    - 		int r = for_each_loose_file_in_objdir(alternate->path, cb, NULL,
    + 	for (source = the_repository->objects->sources; source; source = source->next) {
    + 		int r = for_each_loose_file_in_objdir(source->path, cb, NULL,
      						      NULL, data);
     
      ## object-name.c ##
    @@ odb.c: void add_to_alternates_file(const char *reference)
      			     '\n', NULL, 0);
      }
      
    -@@ odb.c: struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destro
    +@@ odb.c: struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
      	 * Make sure alternates are initialized, or else our entry may be
      	 * overwritten when they are.
      	 */
    @@ odb.c: struct odb_alternate *set_temporary_primary_odb(const char *dir, int will
      
      	/*
      	 * Make a new primary odb and link the old primary ODB in as an
    -@@ odb.c: void restore_primary_odb(struct odb_alternate *restore_alt, const char *old_path
    +@@ odb.c: void restore_primary_odb(struct odb_source *restore_alt, const char *old_path)
      	free_object_directory(cur_alt);
      }
      
    @@ odb.c: void restore_primary_odb(struct odb_alternate *restore_alt, const char *o
      char *compute_alternate_path(const char *path, struct strbuf *err)
      {
      	char *ref_git = NULL;
    -@@ odb.c: struct odb_alternate *odb_find_alternate(struct object_database *odb, const char
    +@@ odb.c: struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
      	char *obj_dir_real = real_pathdup(obj_dir, 1);
      	struct strbuf odb_path_real = STRBUF_INIT;
      
     -	prepare_alt_odb(odb->repo);
     +	odb_prepare_alternates(odb);
    - 	for (alternate = odb->alternates; alternate; alternate = alternate->next) {
    - 		strbuf_realpath(&odb_path_real, alternate->path, 1);
    + 	for (source = odb->sources; source; source = source->next) {
    + 		strbuf_realpath(&odb_path_real, source->path, 1);
      		if (!strcmp(obj_dir_real, odb_path_real.buf))
     @@ odb.c: int foreach_alt_odb(alt_odb_fn fn, void *cb)
    - 	struct odb_alternate *alternate;
    + 	struct odb_source *alternate;
      	int r = 0;
      
     -	prepare_alt_odb(the_repository);
     +	odb_prepare_alternates(the_repository->objects);
    - 	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
    + 	for (alternate = the_repository->objects->sources->next; alternate; alternate = alternate->next) {
      		r = fn(alternate, cb);
      		if (r)
     @@ odb.c: int foreach_alt_odb(alt_odb_fn fn, void *cb)
    @@ odb.c: int foreach_alt_odb(alt_odb_fn fn, void *cb)
     -	link_alt_odb_entries(r->objects, r->objects->alternate_db, PATH_SEP, NULL, 0);
     +	link_alt_odb_entries(odb, odb->alternate_db, PATH_SEP, NULL, 0);
      
    --	read_info_alternates(r->objects, r->objects->alternates->path, 0);
    +-	read_info_alternates(r->objects, r->objects->sources->path, 0);
     -	r->objects->loaded_alternates = 1;
    -+	read_info_alternates(odb, odb->alternates->path, 0);
    ++	read_info_alternates(odb, odb->sources->path, 0);
     +	odb->loaded_alternates = 1;
      }
      
    @@ odb.c: int foreach_alt_odb(alt_odb_fn fn, void *cb)
     +int odb_has_alternates(struct object_database *odb)
      {
     -	prepare_alt_odb(r);
    --	return !!r->objects->alternates->next;
    +-	return !!r->objects->sources->next;
     +	odb_prepare_alternates(odb);
    -+	return !!odb->alternates->next;
    ++	return !!odb->sources->next;
      }
      
      int obj_read_use_lock = 0;
    @@ odb.h: struct oidtree;
     +char *compute_alternate_path(const char *path, struct strbuf *err);
     +
      /*
    -  * The alternate is the part of the object database that stores the actual
    +  * The source is the part of the object database that stores the actual
       * objects. It thus encapsulates the logic to read and write the specific
    -@@ odb.h: struct odb_alternate {
    +@@ odb.h: struct odb_source {
      	char *path;
      };
      
     -void prepare_alt_odb(struct repository *r);
     -int has_alt_odb(struct repository *r);
     -char *compute_alternate_path(const char *path, struct strbuf *err);
    - typedef int alt_odb_fn(struct odb_alternate *, void *);
    + typedef int alt_odb_fn(struct odb_source *, void *);
      int foreach_alt_odb(alt_odb_fn, void*);
      typedef void alternate_ref_fn(const struct object_id *oid, void *);
      void for_each_alternate_ref(alternate_ref_fn, void *);
    @@ odb.h: struct object_database {
      	/*
      	 * A list of alternate object directories loaded from the environment;
      	 * this should not generally need to be accessed directly, but will
    --	 * populate the "alternates" list when prepare_alt_odb() is run.
    -+	 * populate the "alternates" list when odb_prepare_alternates() is run.
    +-	 * populate the "sources" list when prepare_alt_odb() is run.
    ++	 * populate the "sources" list when odb_prepare_alternates() is run.
      	 */
      	char *alternate_db;
      
    -@@ odb.h: struct odb_alternate *odb_find_alternate(struct object_database *odb, const char
    +@@ odb.h: struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
      int odb_mkstemp(struct object_database *odb,
      		struct strbuf *temp_filename, const char *pattern);
      
     +/*
    -+ * Prepare alternate object backends for the given database by reading
    -+ * "objects/info/alternates" and opening the respective alternates.
    ++ * Prepare alternate object sources for the given database by reading
    ++ * "objects/info/alternates" and opening the respective sources.
     + */
     +void odb_prepare_alternates(struct object_database *odb);
     +
     +/*
     + * Check whether the object database has any alternates. The primary object
    -+ * backend does not count as alternate.
    ++ * source does not count as alternate.
     + */
     +int odb_has_alternates(struct object_database *odb);
     +
    @@ odb.h: struct odb_alternate *odb_find_alternate(struct object_database *odb, con
     +				const char *dir);
     +
     +/*
    -+ * Add the directory to the in-memory list of alternates (along with any
    ++ * Add the directory to the in-memory list of alternate sources (along with any
     + * recursive alternates it points to), but do not modify the on-disk alternates
     + * file.
     + */
    @@ packfile.c: static void prepare_packed_git(struct repository *r)
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    - 		int local = (alternate == r->objects->alternates);
    - 		prepare_multi_pack_index_one(r, alternate->path, local);
    + 	for (source = r->objects->sources; source; source = source->next) {
    + 		int local = (source == r->objects->sources);
    + 		prepare_multi_pack_index_one(r, source->path, local);
     @@ packfile.c: void reprepare_packed_git(struct repository *r)
      	 * the lifetime of the process.
      	 */
    @@ packfile.c: void reprepare_packed_git(struct repository *r)
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
      
    - 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next)
    - 		odb_clear_loose_cache(alternate);
    + 	for (source = r->objects->sources; source; source = source->next)
    + 		odb_clear_loose_cache(source);
     
      ## submodule.c ##
     @@ submodule.c: int register_all_submodule_odb_as_alternates(void)
 9:  e69ccfe7434 !  9:  320f73f70e0 odb: get rid of `the_repository`  in `for_each()` functions
    @@ diagnose.c
     @@ diagnose.c: int create_diagnostics_archive(struct repository *r,
      	strbuf_reset(&buf);
      	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
    - 	dir_file_stats(r->objects->alternates, &buf);
    + 	dir_file_stats(r->objects->sources, &buf);
     -	foreach_alt_odb(dir_file_stats, &buf);
     +	odb_for_each_alternate(r->objects, dir_file_stats, &buf);
      	strvec_push(&archiver_args, buf.buf);
    @@ odb.c: static void read_alternate_refs(const char *path,
     +	void *payload;
      };
      
    - static int refs_from_alternate_cb(struct odb_alternate *alternate,
    + static int refs_from_alternate_cb(struct odb_source *alternate,
     -				  void *data)
     +				  void *payload)
      {
    @@ odb.c: static void read_alternate_refs(const char *path,
      
      	if (!strbuf_realpath(&path, alternate->path, 0))
      		goto out;
    -@@ odb.c: static int refs_from_alternate_cb(struct odb_alternate *alternate,
    +@@ odb.c: static int refs_from_alternate_cb(struct odb_source *alternate,
      		goto out;
      	strbuf_setlen(&path, base_len);
      
    @@ odb.c: static int refs_from_alternate_cb(struct odb_alternate *alternate,
     +int odb_for_each_alternate(struct object_database *odb,
     +			 odb_for_each_alternate_fn cb, void *payload)
      {
    - 	struct odb_alternate *alternate;
    + 	struct odb_source *alternate;
      	int r = 0;
      
     -	odb_prepare_alternates(the_repository->objects);
    --	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
    +-	for (alternate = the_repository->objects->sources->next; alternate; alternate = alternate->next) {
     -		r = fn(alternate, cb);
     +	odb_prepare_alternates(odb);
    -+	for (alternate = odb->alternates->next; alternate; alternate = alternate->next) {
    ++	for (alternate = odb->sources->next; alternate; alternate = alternate->next) {
     +		r = cb(alternate, payload);
      		if (r)
      			break;
      	}
     
      ## odb.h ##
    -@@ odb.h: struct odb_alternate {
    +@@ odb.h: struct odb_source {
      	char *path;
      };
      
    --typedef int alt_odb_fn(struct odb_alternate *, void *);
    +-typedef int alt_odb_fn(struct odb_source *, void *);
     -int foreach_alt_odb(alt_odb_fn, void*);
     -typedef void alternate_ref_fn(const struct object_id *oid, void *);
     -void for_each_alternate_ref(alternate_ref_fn, void *);
    @@ odb.h: struct odb_alternate {
       * object directory; returns the former primary object directory.
     @@ odb.h: void odb_clear(struct object_database *o);
       */
    - struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir);
    + struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
      
     +/*
     + * Iterate through all alternates of the database and execute the provided
    @@ odb.h: void odb_clear(struct object_database *o);
     + * function returns a non-zero value, in which case the value is bubbled up
     + * from the callback.
     + */
    -+typedef int odb_for_each_alternate_fn(struct odb_alternate *, void *);
    ++typedef int odb_for_each_alternate_fn(struct odb_source *, void *);
     +int odb_for_each_alternate(struct object_database *odb,
     +			   odb_for_each_alternate_fn cb, void *payload);
     +
10:  271ab001cd6 <  -:  ----------- odb: get rid of `the_repository` when handling the primary alternate
 -:  ----------- > 10:  6a5991f3c90 odb: get rid of `the_repository` when handling the primary source
11:  cfa2d832fd6 ! 11:  aa502131265 odb: get rid of `the_repository` when handling submodule alternates
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    odb: get rid of `the_repository` when handling submodule alternates
    +    odb: get rid of `the_repository` when handling submodule sources
     
         The "--recursive" flag for git-grep(1) allows users to grep for a string
         across submodule boundaries. To make this work we add each submodule's
    -    object alternate to our own object database so that the objects can be
    +    object sources to our own object database so that the objects can be
         accessed directly.
     
         The infrastructure for this depends on a global string list of submodule
         paths. The caller is expected to call `add_submodule_odb_by_path()` for
    -    each alternate and the object database will then eventually register all
    -    submodule alternates via `do_oid_object_info_extended()` in case it
    -    isn't able to look up a specific object.
    +    each source and the object database will then eventually register all
    +    submodule sources via `do_oid_object_info_extended()` in case it isn't
    +    able to look up a specific object.
     
         This reliance on global state is of course suboptimal with regards to
         our libification efforts.
     
    -    Refactor the logic so that the list of submodule alternates is instead
    +    Refactor the logic so that the list of submodule sources is instead
         tracked in the object database itself. This allows us to lose the
    -    condition of `r == the_repository` before registering submodule
    -    alternates as we only ever add submodule alternates to `the_repository`
    -    anyway. As such, behaviour before and after this refactoring should
    -    always be the same.
    +    condition of `r == the_repository` before registering submodule sources
    +    as we only ever add submodule sources to `the_repository` anyway. As
    +    such, behaviour before and after this refactoring should always be the
    +    same.
     
         Rename the functions accordingly.
     
    @@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
      	 * lazily registered as alternates when needed (and except in an
      	 * unexpected code interaction, it won't be needed).
      	 */
    --	add_submodule_odb_by_path(subrepo->objects->alternates->path);
    -+	odb_add_submodule_alternate_by_path(the_repository->objects,
    -+					    subrepo->objects->alternates->path);
    +-	add_submodule_odb_by_path(subrepo->objects->sources->path);
    ++	odb_add_submodule_source_by_path(the_repository->objects,
    ++					 subrepo->objects->sources->path);
      	obj_read_unlock();
      
      	memcpy(&subopt, opt, sizeof(subopt));
    @@ odb.c
      #include "write-or-die.h"
      
      KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
    -@@ odb.c: struct odb_alternate *odb_find_alternate(struct object_database *odb, const char
    - 	return alternate;
    +@@ odb.c: struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
    + 	return source;
      }
      
    -+void odb_add_submodule_alternate_by_path(struct object_database *odb,
    -+					 const char *path)
    ++void odb_add_submodule_source_by_path(struct object_database *odb,
    ++				      const char *path)
     +{
    -+	string_list_insert(&odb->submodule_alternate_paths, path);
    ++	string_list_insert(&odb->submodule_source_paths, path);
     +}
     +
      static void fill_alternate_refs_command(struct child_process *cmd,
    @@ odb.c: void disable_obj_read_lock(void)
      
     +static int register_all_submodule_alternates(struct object_database *odb)
     +{
    -+	int ret = odb->submodule_alternate_paths.nr;
    ++	int ret = odb->submodule_source_paths.nr;
     +
    -+	for (size_t i = 0; i < odb->submodule_alternate_paths.nr; i++)
    ++	for (size_t i = 0; i < odb->submodule_source_paths.nr; i++)
     +		odb_add_to_alternates_memory(odb,
    -+					     odb->submodule_alternate_paths.items[i].string);
    ++					     odb->submodule_source_paths.items[i].string);
     +	if (ret) {
    -+		string_list_clear(&odb->submodule_alternate_paths, 0);
    ++		string_list_clear(&odb->submodule_source_paths, 0);
     +		trace2_data_intmax("submodule", odb->repo,
     +				   "register_all_submodule_alternates/registered", ret);
     +		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
    @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
     -		 * If any such ODBs exist, register them and try again.
     +		 * This might be an attempt at accessing a submodule object as
     +		 * if it were in main object store (having called
    -+		 * `odb_add_submodule_alternate_by_path()` on that submodule's
    ++		 * `odb_add_submodule_source_by_path()` on that submodule's
     +		 * ODB). If any such ODBs exist, register them and try again.
      		 */
     -		if (r == the_repository &&
    @@ odb.c: struct object_database *odb_new(struct repository *repo)
      	INIT_LIST_HEAD(&o->packed_git_mru);
      	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
      	pthread_mutex_init(&o->replace_mutex, NULL);
    -+	string_list_init_dup(&o->submodule_alternate_paths);
    ++	string_list_init_dup(&o->submodule_source_paths);
      	return o;
      }
      
    @@ odb.c: void odb_clear(struct object_database *o)
      	o->packed_git = NULL;
      
      	hashmap_clear(&o->pack_map);
    -+	string_list_clear(&o->submodule_alternate_paths, 0);
    ++	string_list_clear(&o->submodule_source_paths, 0);
      }
     
      ## odb.h ##
     @@
    - #include "object.h"
      #include "list.h"
      #include "oidset.h"
    + #include "oidmap.h"
     +#include "string-list.h"
      #include "thread-utils.h"
      
    @@ odb.h: struct object_database {
      	unsigned packed_git_initialized : 1;
     +
     +	/*
    -+	 * Submodule alternate paths that will be added as alternatives to
    ++	 * Submodule source paths that will be added as additional sources to
     +	 * allow lookup of submodule objects via the main object database.
     +	 */
    -+	struct string_list submodule_alternate_paths;
    ++	struct string_list submodule_source_paths;
      };
      
      struct object_database *odb_new(struct repository *repo);
    -@@ odb.h: void odb_restore_primary_alternate(struct object_database *odb,
    - 				   struct odb_alternate *restore_alt,
    - 				   const char *old_path);
    +@@ odb.h: void odb_restore_primary_source(struct object_database *odb,
    + 				struct odb_source *restore_source,
    + 				const char *old_path);
      
     +/*
    -+ * Call odb_add_submodule_alternate_by_path() to add the submodule at the given
    ++ * Call odb_add_submodule_source_by_path() to add the submodule at the given
     + * path to a list. The object stores of all submodules in that list will be
    -+ * added as alternates in the object store when looking up objects.
    ++ * added as additional sources in the object store when looking up objects.
     + */
    -+void odb_add_submodule_alternate_by_path(struct object_database *odb,
    -+					  const char *path);
    ++void odb_add_submodule_source_by_path(struct object_database *odb,
    ++				      const char *path);
     +
      /*
       * Iterate through all alternates of the database and execute the provided
    @@ submodule-config.c: static void config_from_gitmodules(config_fn_t fn, struct re
      			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
      			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
      			if (repo != the_repository)
    --				add_submodule_odb_by_path(repo->objects->alternates->path);
    -+				odb_add_submodule_alternate_by_path(the_repository->objects,
    -+								    repo->objects->alternates->path);
    +-				add_submodule_odb_by_path(repo->objects->sources->path);
    ++				odb_add_submodule_source_by_path(the_repository->objects,
    ++								 repo->objects->sources->path);
      		} else {
      			goto out;
      		}
12:  9541cc16ed7 ! 12:  a9fdf3fbb8b odb: trivial refactorings to get rid of `the_repository`
    @@ odb.c
      #include "git-compat-util.h"
      #include "abspath.h"
      #include "commit-graph.h"
    -@@ odb.c: void odb_add_submodule_alternate_by_path(struct object_database *odb,
    - 	string_list_insert(&odb->submodule_alternate_paths, path);
    +@@ odb.c: void odb_add_submodule_source_by_path(struct object_database *odb,
    + 	string_list_insert(&odb->submodule_source_paths, path);
      }
      
     -static void fill_alternate_refs_command(struct child_process *cmd,
    @@ odb.c: static void read_alternate_refs(const char *path,
      			warning(_("invalid line while parsing alternate refs: %s"),
      				line.buf);
      			break;
    -@@ odb.c: static int refs_from_alternate_cb(struct odb_alternate *alternate,
    +@@ odb.c: static int refs_from_alternate_cb(struct odb_source *alternate,
      		goto out;
      	strbuf_setlen(&path, base_len);
      
    @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
      		if (oi->delta_base_oid)
     -			oidclr(oi->delta_base_oid, the_repository->hash_algo);
     +			oidclr(oi->delta_base_oid, r->hash_algo);
    - 		if (oi->type_name)
    - 			strbuf_addstr(oi->type_name, type_name(co->type));
      		if (oi->contentp)
    + 			*oi->contentp = xmemdupz(co->buf, co->size);
    + 		oi->whence = OI_CACHED;
     @@ odb.c: static int oid_object_info_convert(struct repository *r,
      	void *content;
      	int ret;
    @@ odb.c: static int oid_object_info_convert(struct repository *r,
      	}
      
     @@ odb.c: static int oid_object_info_convert(struct repository *r,
    - 		if (type == -1)
    - 			return -1;
    + 		struct strbuf outbuf = STRBUF_INIT;
    + 
      		if (type != OBJ_BLOB) {
     -			ret = convert_object_file(the_repository, &outbuf,
     -						  the_hash_algo, input_algo,
13:  c4b1c12476e ! 13:  3f0bdecc039 odb: rename `oid_object_info()`
    @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      			return 0;
     
      ## builtin/cat-file.c ##
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      	switch (opt) {
      	case 't':
    - 		oi.type_name = &sb;
    + 		oi.typep = &type;
     -		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
     +		if (odb_read_object_info_extended(the_repository->objects, &oid, &oi, flags) < 0)
      			die("git cat-file: could not get object info");
    - 		if (sb.len) {
    - 			printf("%s\n", sb.buf);
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    + 		printf("%s\n", type_name(type));
    + 		ret = 0;
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      			oi.contentp = (void**)&buf;
      		}
      
    @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
      			die("git cat-file: could not get object info");
      
      		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      		/* else fallthrough */
      
      	case 'p':
    @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
      		if (type < 0)
      			die("Not a valid object name %s", obj_name);
      
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      
      		if (exp_type_id == OBJ_BLOB) {
      			struct object_id blob_oid;
    @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
      				char *buffer = repo_read_object_file(the_repository,
      								     &oid,
      								     &type,
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      			} else
      				oidcpy(&blob_oid, &oid);
      
    @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
      		if (oi->delta_base_oid)
     -			oidclr(oi->delta_base_oid, r->hash_algo);
     +			oidclr(oi->delta_base_oid, odb->repo->hash_algo);
    - 		if (oi->type_name)
    - 			strbuf_addstr(oi->type_name, type_name(co->type));
      		if (oi->contentp)
    + 			*oi->contentp = xmemdupz(co->buf, co->size);
    + 		oi->whence = OI_CACHED;
     @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
      	}
      
    @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
      		}
      
     @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
    - 		 * `odb_add_submodule_alternate_by_path()` on that submodule's
    + 		 * `odb_add_submodule_source_by_path()` on that submodule's
      		 * ODB). If any such ODBs exist, register them and try again.
      		 */
     -		if (register_all_submodule_alternates(r->objects))
    @@ odb.h: void *read_object_with_reference(struct repository *r,
      				 unsigned long *size,
      				 struct object_id *oid_ret);
      
    -+/* Compatibility wrappers, to be removed once Git 2.50 has been released. */
    ++/* Compatibility wrappers, to be removed once Git 2.51 has been released. */
     +#include "repository.h"
     +
     +static inline int oid_object_info_extended(struct repository *r,
14:  eeb31a420b0 ! 14:  644cd847670 odb: rename `repo_read_object_file()`
    @@ builtin/cat-file.c: static int filter_object(const char *path, unsigned mode,
      	if (!*buf)
      		return error(_("cannot read object %s '%s'"),
      			     oid_to_hex(oid), path);
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      			ret = stream_blob(&oid);
      			goto cleanup;
      		}
    @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
      		if (!buf)
      			die("Cannot read object %s", obj_name);
      
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      			struct object_id blob_oid;
      			if (odb_read_object_info(the_repository->objects,
      						 &oid, NULL) == OBJ_TAG) {
15:  ab652070bc6 ! 15:  53812350b40 odb: rename `has_object()`
    @@ builtin/backfill.c: static int fill_missing_blobs(const char *path UNUSED,
      
     
      ## builtin/cat-file.c ##
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      		goto cleanup;
      
      	case 'e':
16:  580bfe7bc24 = 16:  bcbfd390398 odb: rename `pretend_object_file()`
17:  b23d48d216a ! 17:  77f7e41f83f odb: rename `read_object_with_reference()`
    @@ Documentation/user-manual.adoc: Now, for the meat:
      the source.
     
      ## builtin/cat-file.c ##
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    +@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
      			 * fall-back to the usual case.
      			 */
      		}
    @@ odb.h: enum for_each_object_flags {
     -				 unsigned long *size,
     -				 struct object_id *oid_ret);
     -
    - /* Compatibility wrappers, to be removed once Git 2.50 has been released. */
    + /* Compatibility wrappers, to be removed once Git 2.51 has been released. */
      #include "repository.h"
      
     

---
base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
change-id: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1

