Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E874B1E7F
	for <git@vger.kernel.org>; Wed,  7 May 2025 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746660172; cv=none; b=hetvSEq1kNYlWYIGruYbqtbJzPrqOFg3Rg9vZAp4lAm9VTODvsin+iy2A8XkaSRGcG1kexW0xGfa5/NBO2iMDKlJBUk3oF5/7MOVXH7AjYQ7h+P4NRXpQYfWZaGH8SMQ1TH/QwVRHBeARtEsg84AeGBk4hbTWcC83lrhcx24roI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746660172; c=relaxed/simple;
	bh=9wSm45isYn5zlddnOISfXqMqvgFhrhLnh/s7G3agHig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFeDwWi+GznZtMK9FC26ol3bYEbA88LLF5lDJuBp/UCH607Ppsxzx7oKAut851oGUZQ82iZB+3reLDYPqL6jVYl0q5IhGZCv0VVP9T2FSsvM3rYQUJ6Hv3V6cYoteFI2p+GWFsullEuzydgNI1Ezc7ytM4KSMka2fqfU5ZAywvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YdSG4SNI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vtHxXmn7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YdSG4SNI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vtHxXmn7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FA2C114013B;
	Wed,  7 May 2025 19:22:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 07 May 2025 19:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746660168; x=1746746568; bh=ar0igKuyVE
	ozp3hiQnXeUBtgb/j9iFXWc46JySRS8dY=; b=YdSG4SNIfd7vgXM4DjRbbo+hR9
	iN2GaMQ+DodcVdvlDugyXoPZGQH6Ohf+Z95xA9nduRiOP9y3wyKZtI6jsAjCn3Tw
	LSj4QV0H7RgSP+fWLJ8nUE1x/C2IqN27PUE0qByfS5d9dVbAraguaTBVUGbeBG4c
	IA1nOr8DR9zxYPD5VgykjPPFN93SzZXBHVSAu7jopvq09dTUEkhYXdrTaNS18KYX
	Q+RLUsbzz9k/gtAMNxSCkAvX3g5htW/yLW807JfaJsJx5aQACKvIuaWfu3u7n3+3
	aEvgIbAekogIV8FryL3TFMNrr1yj+JKz/gL7I6izkQHPGb5snE7SPb4IzQww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746660168; x=1746746568; bh=ar0igKuyVEozp3hiQnXeUBtgb/j9iFXWc46
	JySRS8dY=; b=vtHxXmn7mda+DAH/RaW1ajlZqwXjGfeRjzBh1ilwakzRUntXV8Y
	bHSONao0mFVRNZ2g53/KFXZhQA+HZ5jGMyqACNQm+H9BPxBMCyS0PS76WdEffUEf
	PYTO8zeLSKmfgahrZaOyhXS/bXjkxDJVK6ineB7CBMiRZjZsYtSzB86ODGY8DTGb
	EpzeSAAHNkS092Z6HeBSk8CXPvR3IwTU863JntSc0NksQgktEcNo6pcf9kKIUj8n
	ySRs8UepMZY2LZ4ESmB9LH+o7k/eiKpGAlPt5kh1ARPYuTW0zWpn6vVPPdbuIJmM
	msdjfrHEBXecQu0OhW4B/4QHfsYdiKJgsdQ==
X-ME-Sender: <xms:SOsbaMy-sYXNraHuK3jYDcrKQid30yyMBb_nsfKo_TKPK27lWYA1wQ>
    <xme:SOsbaAShH7Ki4CsMGDB3H6Pj6V4CWmVfS_jZEsA6na1h3dw5SO0PGEdp167-z4QF6
    DOtNL8duVRLMwLBXQ>
X-ME-Received: <xmr:SOsbaOV-MSG4LJPGl82PdVDOYa1fUJoSOezPyAbGrt-RtB0EaT4CipkQeLR1ktj680D5xU8o78hElPNCyRyXJ0Fn6p87ze4Bw-lF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SOsbaKgxFHC02jXZF6-w59jGa01Flolxt4AXlW5eeLwhg65oi8WZQA>
    <xmx:SOsbaODYWZAnP9uc0XWn7AWtfQFOgMeRbC2E18Num4eXu7A-d0fxEQ>
    <xmx:SOsbaLIzgd6ao_F8HMsLSJKpArdM9mimbD3BWlbFGvd0M-yU1kq7Pg>
    <xmx:SOsbaFCAKkgxWKsy1QP4s9GloXWSS1lUdBiY3hlT3-1azMfockEmtg>
    <xmx:SOsbaPxi_XfsPkUQ3C4D3aOQuRpFGr8oKlnzWWbkP3ifCvtb1QMBKmx7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 19:22:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/17] object-store: carve out the object database
 subsystem
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 May 2025 13:09:13 +0200")
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
Date: Wed, 07 May 2025 16:22:46 -0700
Message-ID: <xmqqh61w9fax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series refactors the object store subsystem to become more
> self-contained by getting rid of `the_repository`. Instead of passing in
> the repository explicitly, we start to pass in the object store itself,
> which is in contrast to many other refactorings we did, but in line with
> what we did for the ref store, as well.

Nice.  I do prefer to keep the scope of the "what's affected" object
smaller than just assume that passing a repository is fine.  The
interaction among object database, the index and the ref database is
a bit subtle, in that the former should mostly be usable without the
latter (i.e. "you throw a stream of data at it, and it registers it
as an object and returns an object name") but some operations you'd
need all (e.g. prunability).  With use of alternate object store, we
cannot say "by specifying a repository, we can specify its object
store", as there is no "the single object store" linked to the
repository.

> This series also starts to properly scope functions to the carved out
> object database subsystem, which requires a bit of shuffling. This
> allows us to have a short-and-sweet `odb_` prefix for functions and
> prepares us for a future with pluggable object backends.

Good.

> The series is structured as follows:
>
>   - Patches 1 to 3 rename `struct object_store` and `struct
>     object_directory` as well as the code files.
>
>   - Patches 4 to 12 refactor "odb.c" to get rid of `the_repository`.
>
>   - Patches 13 to 17 adjust the name of remaining functions so that they
>     can be clearly attributed to the ODB. I'm happy to kick these
>     patches out of this series and resend them at a later point in case
>     they create too much turmoil.
>
> This series is built on top of 6f84262c44a (The eleventh batch,
> 2025-05-05) with ps/object-store-cleanup at 8a9e27be821 (object-store:
> drop `repo_has_object_file()`, 2025-04-29) merged into it. There are a
> couple of trivial conflicts when merged with "seen", I have appended the
> merge conflict resolution as a patch at the end of this mail.
>
> Thanks!
>
> Patrick
>
> -- >8 --
>
> diff --cc builtin/pack-objects.c
> index e88a13dbb9f,2936a08e130..00000000000
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@@ -4063,9 -4318,10 +4320,10 @@@ static void add_objects_in_unpacked_pac
>   }
>   
>   static int add_loose_object(const struct object_id *oid, const char *path,
> - 			    void *data UNUSED)
> + 			    void *data)
>   {
> + 	struct rev_info *revs = data;
>  -	enum object_type type = oid_object_info(the_repository, oid, NULL);
>  +	enum object_type type = odb_read_object_info(the_repository->objects, oid, NULL);
>   
>   	if (type < 0) {
>   		warning(_("loose object at %s could not be examined"), path);
> diff --cc odb.h
> index 03f269c4e82,af0b3d856f5..00000000000
> --- a/odb.h
> +++ b/odb.h
> @@@ -338,25 -258,10 +338,28 @@@ struct object_info 
>   /* Die if object corruption (not just an object being missing) was detected. */
>   #define OBJECT_INFO_DIE_IF_CORRUPT 32
>   
>  -int oid_object_info_extended(struct repository *r,
>  -			     const struct object_id *,
>  -			     struct object_info *, unsigned flags);
>  +/*
>  + * Read object info from the object database and populate the `object_info`
>  + * structure. Returns 0 on success, a negative error code otherwise.
>  + */
>  +int odb_read_object_info_extended(struct object_database *odb,
>  +				  const struct object_id *oid,
>  +				  struct object_info *oi,
>  +				  unsigned flags);
>  +
>  +/*
>  + * Read a subset of object info for the given object ID. Returns an `enum
>  + * object_type` on success, a negative error code otherwise. If successful and
>  + * `sizep` is non-NULL, then the size of the object will be written to the
>  + * pointer.
>  + */
>  +int odb_read_object_info(struct object_database *odb,
>  +			 const struct object_id *oid,
>  +			 unsigned long *sizep);
>  +
> ++/* Free pointers inside of object_info, but not object_info itself */
> ++void free_object_info_contents(struct object_info *object_info);
> + 
>   enum {
>   	/* Retry packed storage after checking packed and loose storage */
>   	HAS_OBJECT_RECHECK_PACKED = (1 << 0),
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index 1b2c6c4d27c..6c2abb78055 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -4,7 +4,7 @@
>  #include "pkt-line.h"
>  #include "connect.h"
>  #include "oid-array.h"
> -#include "object-store.h"
> +#include "odb.h"
>  #include "fetch-object-info.h"
>  #include "string-list.h"
>  
> diff --git a/fetch-object-info.h b/fetch-object-info.h
> index 7910d7f1532..d35284bd6bc 100644
> --- a/fetch-object-info.h
> +++ b/fetch-object-info.h
> @@ -3,7 +3,7 @@
>  
>  #include "pkt-line.h"
>  #include "protocol.h"
> -#include "object-store.h"
> +#include "odb.h"
>  
>  struct object_info_args {
>  	struct string_list *object_info_options;
> diff --git a/transport.h b/transport.h
> index 5a4f27451ae..3ef3acf8650 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -5,7 +5,7 @@
>  #include "remote.h"
>  #include "list-objects-filter-options.h"
>  #include "string-list.h"
> -#include "object-store.h"
> +#include "odb.h"
>  
>  struct git_transport_options {
>  	unsigned thin : 1;
>
> ---
> Patrick Steinhardt (17):
>       object-store: rename `raw_object_store` to `object_database`
>       object-store: rename `object_directory` to `odb_backend`
>       object-store: rename files to "odb.{c,h}"
>       odb: introduce parent pointers
>       odb: get rid of `the_repository` in `find_odb()`
>       odb: get rid of `the_repository` in `assert_oid_type()`
>       odb: get rid of `the_repository` in `assert_oid_type()`
>       odb: get rid of `the_repository` when handling alternates
>       odb: get rid of `the_repository`  in `for_each()` functions
>       odb: get rid of `the_repository` when handling the primary backend
>       odb: get rid of `the_repository` when handling submodule backends
>       odb: trivial refactorings to get rid of `the_repository`
>       odb: rename `oid_object_info()`
>       odb: rename `repo_read_object_file()`
>       odb: rename `has_object()`
>       odb: rename `pretend_object_file()`
>       odb: rename `read_object_with_reference()`
>
>  Documentation/user-manual.adoc          |   4 +-
>  Makefile                                |   2 +-
>  apply.c                                 |  14 +-
>  archive-tar.c                           |   2 +-
>  archive-zip.c                           |   2 +-
>  archive.c                               |   6 +-
>  attr.c                                  |   4 +-
>  bisect.c                                |   8 +-
>  blame.c                                 |  22 +-
>  builtin/backfill.c                      |   6 +-
>  builtin/blame.c                         |   6 +-
>  builtin/cat-file.c                      |  62 +++--
>  builtin/checkout.c                      |   2 +-
>  builtin/clone.c                         |  14 +-
>  builtin/commit-graph.c                  |  20 +-
>  builtin/commit-tree.c                   |   4 +-
>  builtin/count-objects.c                 |   4 +-
>  builtin/describe.c                      |   5 +-
>  builtin/difftool.c                      |   4 +-
>  builtin/fast-export.c                   |  10 +-
>  builtin/fast-import.c                   |  49 ++--
>  builtin/fetch.c                         |  21 +-
>  builtin/fsck.c                          |  31 +--
>  builtin/gc.c                            |  16 +-
>  builtin/grep.c                          |  26 +--
>  builtin/hash-object.c                   |   2 +-
>  builtin/index-pack.c                    |  29 +--
>  builtin/log.c                           |   4 +-
>  builtin/ls-files.c                      |   4 +-
>  builtin/ls-tree.c                       |   6 +-
>  builtin/merge-file.c                    |   2 +-
>  builtin/merge-tree.c                    |  14 +-
>  builtin/mktag.c                         |   6 +-
>  builtin/mktree.c                        |  10 +-
>  builtin/multi-pack-index.c              |   6 +-
>  builtin/notes.c                         |   8 +-
>  builtin/pack-objects.c                  |  70 +++---
>  builtin/pack-redundant.c                |   2 +-
>  builtin/prune.c                         |   6 +-
>  builtin/receive-pack.c                  |   9 +-
>  builtin/remote.c                        |   6 +-
>  builtin/repack.c                        |   7 +-
>  builtin/replace.c                       |  12 +-
>  builtin/rev-list.c                      |   8 +-
>  builtin/show-ref.c                      |   6 +-
>  builtin/submodule--helper.c             |   7 +-
>  builtin/tag.c                           |  10 +-
>  builtin/unpack-file.c                   |   4 +-
>  builtin/unpack-objects.c                |  12 +-
>  bulk-checkin.c                          |   6 +-
>  bundle-uri.c                            |   5 +-
>  bundle.c                                |   6 +-
>  cache-tree.c                            |  17 +-
>  combine-diff.c                          |   4 +-
>  commit-graph.c                          |  56 ++---
>  commit-graph.h                          |  20 +-
>  commit.c                                |  15 +-
>  config.c                                |   4 +-
>  connected.c                             |   2 +-
>  contrib/coccinelle/the_repository.cocci |   2 +-
>  diagnose.c                              |   8 +-
>  diff.c                                  |  20 +-
>  dir.c                                   |   2 +-
>  entry.c                                 |   6 +-
>  fetch-pack.c                            |  17 +-
>  fmt-merge-msg.c                         |   6 +-
>  fsck.c                                  |   4 +-
>  grep.c                                  |   6 +-
>  http-backend.c                          |   2 +-
>  http-push.c                             |  20 +-
>  http-walker.c                           |  12 +-
>  http.c                                  |   6 +-
>  list-objects-filter.c                   |   4 +-
>  list-objects.c                          |   6 +-
>  log-tree.c                              |   2 +-
>  loose.c                                 |  24 +-
>  mailmap.c                               |   4 +-
>  match-trees.c                           |   6 +-
>  merge-blobs.c                           |  10 +-
>  merge-ort.c                             |   8 +-
>  meson.build                             |   2 +-
>  midx-write.c                            |   2 +-
>  midx.c                                  |   6 +-
>  notes-cache.c                           |   4 +-
>  notes-merge.c                           |   4 +-
>  notes.c                                 |  19 +-
>  object-file.c                           |  60 ++---
>  object-file.h                           |  12 +-
>  object-name.c                           |  24 +-
>  object.c                                |   8 +-
>  object-store.c => odb.c                 | 395 +++++++++++++++++---------------
>  object-store.h => odb.h                 | 271 ++++++++++++++++------
>  oss-fuzz/fuzz-pack-idx.c                |   2 +-
>  pack-bitmap-write.c                     |   9 +-
>  pack-bitmap.c                           |  10 +-
>  pack-check.c                            |   2 +-
>  pack-mtimes.c                           |   2 +-
>  pack-objects.h                          |   2 +-
>  pack-revindex.c                         |   2 +-
>  pack-write.c                            |  10 +-
>  packfile.c                              |  29 +--
>  packfile.h                              |   8 +-
>  path.c                                  |   4 +-
>  promisor-remote.c                       |   6 +-
>  protocol-caps.c                         |   4 +-
>  reachable.c                             |   2 +-
>  read-cache.c                            |  14 +-
>  ref-filter.c                            |   6 +-
>  reflog.c                                |   8 +-
>  refs.c                                  |   7 +-
>  remote.c                                |   9 +-
>  replace-object.c                        |   2 +-
>  replace-object.h                        |   2 +-
>  repository.c                            |  21 +-
>  repository.h                            |   4 +-
>  rerere.c                                |   7 +-
>  revision.c                              |   5 +-
>  send-pack.c                             |   4 +-
>  sequencer.c                             |   7 +-
>  server-info.c                           |   2 +-
>  shallow.c                               |  14 +-
>  streaming.c                             |  10 +-
>  submodule-config.c                      |   9 +-
>  submodule.c                             |  32 +--
>  submodule.h                             |   9 -
>  t/helper/test-find-pack.c               |   2 +-
>  t/helper/test-pack-mtimes.c             |   2 +-
>  t/helper/test-partial-clone.c           |   4 +-
>  t/helper/test-read-graph.c              |   8 +-
>  t/helper/test-read-midx.c               |   2 +-
>  t/helper/test-ref-store.c               |   4 +-
>  tag.c                                   |  10 +-
>  tmp-objdir.c                            |  18 +-
>  tree-walk.c                             |  18 +-
>  tree.c                                  |   6 +-
>  unpack-trees.c                          |   2 +-
>  upload-pack.c                           |   4 +-
>  walker.c                                |   6 +-
>  xdiff-interface.c                       |   4 +-
>  139 files changed, 1104 insertions(+), 961 deletions(-)
>
>
> ---
> base-commit: 046efb6f2b050efd580e1c1750b77328a1790c0e
> change-id: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1
