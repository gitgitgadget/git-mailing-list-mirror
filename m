Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D40275846
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913147; cv=none; b=YtKvUQkCaMNi6J3QTPCVrIUDtZqTM8k+8D8pwITDEG5e6AN88tPmIwnXQs2edCiHEql8hWqB6z0+0Jd/GUKRwrJq3b6Wsceh2gWWNNxAuMZtX3bwN8JThnjl+GoXbYh/pircDWrUegGOc3qyGh6L49xGQibrS1oeDd8OY/Uc9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913147; c=relaxed/simple;
	bh=bYn4f6y2L3CDRrGBJ5qTgwwDJvj8LGj5javXNEbq/dk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=i70eEEI62Q1SjFR+DTQV4qJeJ/Of0mLcm1rW09E4UVrfv9vCJPBaoGlkUxzwBkj/uQ7fnFZQk627llJ9+4SWAkNhNIU2bAaSLQPxDV4k6YA0Iu/n/kwSznx3mEau3445jn6H4Qfd8nVHUANcHLQItHMs4MhI/HJEexGFrUEurmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zJFYpnpa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+j8KWj5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zJFYpnpa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+j8KWj5"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D3C9114022C;
	Tue, 29 Apr 2025 03:52:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 29 Apr 2025 03:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745913144;
	 x=1745999544; bh=NQ7+Pmtj69SLJ+ZOXHuh8os4uSu4Fui4UKMU3tOgoI4=; b=
	zJFYpnpaWKiqpPRMQkPYCvB2WVU1ccaEa3cMOrUbKfteZgr75PSwp4hIIe5PrtjY
	VOiTpk5bNhPefvAO6f/iWgkh5fqicMKk9bzfgDBdweunMlkK5FPMg7eWmE9Q9ydb
	VqSOE1G8emVasEeVsTvN4rKNpM2VKvyfLAvUg/dXQKKRt5zvoT2K90qCnpv9rmZj
	QMDFHUR7uaQJx7ThwtovQes763G2wJYE2jZkaUPI5DAskVZl/SWZpvXkTIJvvvWq
	PBsGE7JC9AWiwGfb6iDq03U6ahdRL9+imF/lO8RavHKp7anm63F1aekAugh6SJIa
	i3LIO+TB50mybmKfiSuE+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745913144; x=
	1745999544; bh=NQ7+Pmtj69SLJ+ZOXHuh8os4uSu4Fui4UKMU3tOgoI4=; b=X
	+j8KWj5FplLJ5n08VDeNbEhCaCZNgak1ryd+putFijN7LE0+bDJce7CxTKv/I4j+
	Y4sXdlqsSV+cK1YPr6Pxp3UaOjsduCmHDirvo3sHmioNlTCziz0rUhCxIEVGB2lP
	ppqe2BtV6tDpft1ZZZ67ep2MG7rQDesenY+AGTychdILUlf9rrZm9wFAklRUL9NQ
	q0zGeKsiQa4gKVVIbFONHhmkxKzsd8CvRK4FzhyqkThG9luquPVWIs8+UFh3QdSY
	4AzRXejx/kBbuZ8hj434rLetJOp4ctG0ThfkP8hw9qKuBM88st+3GH67u+Il8hlK
	iLe2ce+e7bIiv6iLaWGmQ==
X-ME-Sender: <xms:N4UQaEEAA1JkIuToP4xocG6BoJHC-FF_5yt0K8YelYT_POsPuXmcrw>
    <xme:N4UQaNWdY3_Yk9_h_fBrIly139P2jP7SNXYCQLDKrOdzSMU5BiNYugcD-FyouuWnd
    71eaIt_QWX3nrWEGg>
X-ME-Received: <xmr:N4UQaOLp8-qchf75-GnUQD2ZWY2bLDZRl-CsAOmTt8ILdRq57IGRh7y3HgZf9loYtxOywyCbWjZVlak15aoLKhx5ValpXOJeioDTvS7IrAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:N4UQaGENNwstdufWNPWCVzmAPxcodwnh__lUCRrkJTIPDHn3JGLGDA>
    <xmx:N4UQaKWcJezsbwBxtsHPTkKAmK9WtKvA7qYK8HpHsHV58fAyctYeFw>
    <xmx:N4UQaJOMwlWCHPgJ4kT_FxHkCxUhlQN2Ax6K8yvwaEolqCY5grCOvQ>
    <xmx:N4UQaB1-Q9LANZexbwN7HUYW-vEtmAbzviFRv0ktFZNcjpsvJqEIRQ>
    <xmx:OIUQaNDFufUkJApCO2X9_hZCEeKaa6wHAdMandcB4-RIQs0k6x54P61L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:52:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 900de493 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:52:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/7] object-store: a handful of cleanups
Date: Tue, 29 Apr 2025 09:52:14 +0200
Message-Id: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC6FEGgC/33Ozw6CMAwG8FchPVuzDgboyfcwHgYUmcqfbLhoC
 O/uINF44vg1/X7tBI6tYQfHaALL3jjTdyHEuwjKRndXRlOFDFJIJRIpcbg77IsblyO6sbeM5YN
 19xwcKp2KLBOUkFIQ+oPl2rxW+3wJuTFL4b2e8rRMv2q8oXpCgTnVeUKkVSXyU9jdmxYW0st/R
 m0xMjBpXFN6UEX4UvyYeZ4/i4qXxQYBAAA=
X-Change-ID: 20250422-pks-object-store-cleanups-5a6077014155
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series contains a handful of cleanups to the object store
subsystem:

  - A couple of definitions are moved out of "object-store.h" as they
    belong to other subsystems.

  - Some functions are dropped and/or renamed.

  - The biggest part is the removal of `repo_has_object_file()`. This
    function and its `_with_flags()` variant are marked as deprecated,
    with the replacement being `has_object()`. The benefit of that
    function is that it doesn't reload packfiles and doesn't fetch
    promisor objects by default so that it becomes more explicit when
    one really wants to do so.

These cleanups are in preparation for getting rid of `the_repository` in
"object-store.c".

The patch series is built on top of 4bbb303af69 (The seventh batch,
2025-04-17) with ps/object-file-cleanup at 68cd492a3e6 (object-store:
merge "object-store-ll.h" and "object-store.h", 2025-04-15) merged into
it.

Changes in v2:
  - A handful of improvements for commit messages.
  - Link to v1: https://lore.kernel.org/r/20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im

Changes in v3:
  - Move around `hash_object_file()`, which I missed in previous
    iterations.
  - Don't try to fix up callsites where we end up fetching promised
    objects. This patch series now only does a trivial 1:1 conversion.
  - Clarify why we're sunsetting `repo_has_object_file()`.
  - Link to v2: https://lore.kernel.org/r/20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      object-store: move `struct packed_git` into "packfile.h"
      object-store: drop `loose_object_path()`
      object-store: move and rename `odb_pack_keep()`
      object-store: move function declarations to their respective subsystems
      object-store: allow fetching objects via `has_object()`
      treewide: convert users of `repo_has_object_file()` to `has_object()`
      object-store: drop `repo_has_object_file()`

 builtin/cat-file.c       |   3 +-
 builtin/clone.c          |   4 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |   3 +-
 builtin/fetch.c          |  15 ++--
 builtin/gc.c             |   2 +-
 builtin/index-pack.c     |   7 +-
 builtin/receive-pack.c   |   4 +-
 builtin/remote.c         |   3 +-
 builtin/show-ref.c       |   3 +-
 builtin/unpack-objects.c |   3 +-
 bulk-checkin.c           |   3 +-
 cache-tree.c             |  13 +++-
 convert.c                |   2 +-
 diffcore-rename.c        |   2 +-
 dir.c                    |   2 +-
 fetch-pack.c             |   7 +-
 http-push.c              |  11 ++-
 http-walker.c            |   9 ++-
 http.c                   |   4 +-
 list-objects.c           |   3 +-
 log-tree.c               |   2 +-
 notes.c                  |   3 +-
 object-file.c            |   4 +-
 object-file.h            |  81 ++++++++++++++++++++
 object-name.c            |   2 +-
 object-store.c           |  44 ++---------
 object-store.h           | 195 +++--------------------------------------------
 pack-objects.h           |   1 +
 packfile.h               |  78 ++++++++++++++++++-
 path.c                   |  14 ++++
 path.h                   |   7 ++
 prune-packed.c           |   2 +-
 reachable.c              |   2 +-
 reflog.c                 |   3 +-
 refs.c                   |   2 +-
 remote.c                 |   2 +-
 send-pack.c              |   5 +-
 shallow.c                |   9 ++-
 upload-pack.c            |   3 +-
 walker.c                 |   3 +-
 41 files changed, 278 insertions(+), 289 deletions(-)

Range-diff versus v2:

 1:  3b0282e9621 =  1:  ade4c11cb5c object-store: move `struct packed_git` into "packfile.h"
 2:  60871520f14 =  2:  a38ae18bf91 object-store: drop `loose_object_path()`
 3:  a3eb7be5cc4 =  3:  cb14eafdffa object-store: move and rename `odb_pack_keep()`
 4:  2fbf97b6826 !  4:  d1b3c0a23f9 object-store: move function declarations to their respective subsystems
    @@ builtin/gc.c
      #include "pack-objects.h"
      #include "path.h"
     
    + ## convert.c ##
    +@@
    + #include "copy.h"
    + #include "gettext.h"
    + #include "hex.h"
    +-#include "object-store.h"
    ++#include "object-file.h"
    + #include "attr.h"
    + #include "run-command.h"
    + #include "quote.h"
    +
    + ## diffcore-rename.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "diff.h"
    + #include "diffcore.h"
    +-#include "object-store.h"
    ++#include "object-file.h"
    + #include "hashmap.h"
    + #include "mem-pool.h"
    + #include "oid-array.h"
    +
    + ## dir.c ##
    +@@
    + #include "environment.h"
    + #include "gettext.h"
    + #include "name-hash.h"
    +-#include "object-store.h"
    ++#include "object-file.h"
    + #include "path.h"
    + #include "refs.h"
    + #include "repository.h"
    +
    + ## log-tree.c ##
    +@@
    + #include "environment.h"
    + #include "hex.h"
    + #include "object-name.h"
    +-#include "object-store.h"
    ++#include "object-file.h"
    + #include "repository.h"
    + #include "tmp-objdir.h"
    + #include "commit.h"
    +
      ## object-file.h ##
     @@
      
    @@ object-file.h: int has_loose_object_nonlocal(const struct object_id *);
      /**
       * format_object_header() is a thin wrapper around s xsnprintf() that
       * writes the initial "<type> <obj-len>" part of the loose object
    +@@ object-file.h: int finalize_object_file(const char *tmpfile, const char *filename);
    + int finalize_object_file_flags(const char *tmpfile, const char *filename,
    + 			       enum finalize_object_file_flags flags);
    + 
    ++void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    ++		      unsigned long len, enum object_type type,
    ++		      struct object_id *oid);
    ++
    + /* Helper to check and "touch" a file */
    + int check_and_freshen_file(const char *fn, int freshen);
    + 
     
      ## object-name.c ##
     @@
    @@ object-store.h: void raw_object_store_clear(struct raw_object_store *o);
      void *repo_read_object_file(struct repository *r,
      			    const struct object_id *oid,
      			    enum object_type *type,
    +@@ object-store.h: void *repo_read_object_file(struct repository *r,
    + /* Read and unpack an object file into memory, write memory to an object file */
    + int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
    + 
    +-void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    +-		      unsigned long len, enum object_type type,
    +-		      struct object_id *oid);
    +-
    + /*
    +  * Add an object file to the in-memory object store, without writing it
    +  * to disk.
     @@ object-store.h: static inline void obj_read_unlock(void)
      	if(obj_read_use_lock)
      		pthread_mutex_unlock(&obj_read_mutex);
 5:  6e165b497e4 !  5:  7b8a6286f6a object-store: allow fetching objects via `has_object()`
    @@ Commit message
         object-store: allow fetching objects via `has_object()`
     
         We're about to fully remove `repo_has_object_file()` in favor of
    -    `has_object()` given that the latter has better defaults: it neither
    -    reloads packfiles by default nor does it fetch any promised objects in
    -    case they are missing.
    -
    -    The latter usecase keeps us from converting a couple of callsites that
    -    currently do fetch objects though. It is not really clear whether _all_
    -    of those callsites should be fetching objects, but for a subset of them
    -    it is the desired behaviour indeed.
    +    `has_object()`. The latter function does not yet have a way to fetch
    +    missing objects via a promisor remote though, which means that it cannot
    +    fully replace all usecases of `repo_has_object_file()`.
     
         Introduce a new flag `HAS_OBJECT_FETCH_PROMISOR` that causes the
         function to optionally fetch missing objects which are part of a
    -    promisor pack.
    +    promisor pack. This flag will be used in the subsequent commit.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 6:  325178adf42 !  6:  a7733b66fd6 treewide: trivial conversions of `repo_has_object_file()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    treewide: trivial conversions of `repo_has_object_file()`
    +    treewide: convert users of `repo_has_object_file()` to `has_object()`
     
         As the comment of `repo_has_object_file()` and its `_with_flags()`
         variant tells us, these functions are considered to be deprecated in
    -    favor of `has_object()`. The benefit of the replacement is better
    -    defaults: it doesn't fetch missing objects via promisor remotes, and
    -    neither does it reload packfiles if an object wasn't found by default.
    +    favor of `has_object()`. There are a couple of slight benefits in favor
    +    of the replacement:
     
    -    Start sunsetting the functions by replacing trivial callsites of it with
    -    `has_object()`:
    +      - The new function has a short-and-sweet name.
    +
    +      - More explicit defaults: `has_object()` doesn't fetch missing objects
    +        via promisor remotes, and neither does it reload packfiles if an
    +        object wasn't found by default. This ensures that it becomes
    +        immediately obvious when a simple object existence check may result
    +        in expensive actions.
    +
    +    Most importantly though, it is confusing that we have two sets of
    +    functions that ultimately do the same thing, but with different
    +    defaults.
    +
    +    Start sunsetting `repo_has_object_file()` and its `_with_flags()`
    +    sibling by replacing all callsites with `has_object()`:
     
           - `repo_has_object_file(...)` is equivalent to
             `has_object(..., HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)`.
    @@ Commit message
           - `repo_has_object_file_with_flags(..., OBJECT_INFO_SKIP_FETCH_OBJECT)`
             is equivalent to `has_object(..., HAS_OBJECT_RECHECK_PACKED)`.
     
    -    While converting callsites to use `HAS_OBJECT_FETCH_PROMISOR` retains
    -    the current behaviour, it is not entirely clear whether all of them
    -    really should be fetching promised objects. A subset of such callsites
    -    where it is obvious that they really shouldn't fetch objects has been
    -    left out of this commit and will be adapted over the next couple of
    -    commits.
    +      - `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)`
    +        is equivalent to `has_object(..., HAS_OBJECT_FETCH_PROMISOR)`.
    +
    +    The replacements should be functionally equivalent.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *ref_map)
      	}
      
     
    + ## builtin/index-pack.c ##
    +@@ builtin/index-pack.c: static void sha1_object(const void *data, struct object_entry *obj_entry,
    + 
    + 	if (startup_info->have_repository) {
    + 		read_lock();
    +-		collision_test_needed =
    +-			repo_has_object_file_with_flags(the_repository, oid,
    +-							OBJECT_INFO_QUICK);
    ++		collision_test_needed = has_object(the_repository, oid,
    ++						   HAS_OBJECT_FETCH_PROMISOR);
    + 		read_unlock();
    + 	}
    + 
    +
      ## builtin/receive-pack.c ##
     @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct shallow_info *si)
      		}
    @@ builtin/remote.c: static int get_push_ref_states(const struct ref *remote_refs,
      			info->status = PUSH_STATUS_FASTFORWARD;
      		else
     
    + ## builtin/show-ref.c ##
    +@@ builtin/show-ref.c: static void show_one(const struct show_one_options *opts,
    + 	const char *hex;
    + 	struct object_id peeled;
    + 
    +-	if (!repo_has_object_file(the_repository, oid))
    ++	if (!has_object(the_repository, oid,
    ++			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
    + 		die("git show-ref: bad ref %s (%s)", refname,
    + 		    oid_to_hex(oid));
    + 
    +
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
      		delta_data = get_data(delta_size);
    @@ builtin/unpack-objects.c: static void unpack_delta_entry(enum object_type type,
      		else if (resolve_against_held(nr, &base_oid,
      					      delta_data, delta_size))
     
    + ## bulk-checkin.c ##
    +@@ bulk-checkin.c: static void flush_batch_fsync(void)
    + static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
    + {
    + 	/* The object may already exist in the repository */
    +-	if (repo_has_object_file(the_repository, oid))
    ++	if (has_object(the_repository, oid,
    ++		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
    + 		return 1;
    + 
    + 	/* Might want to keep the list sorted */
    +
      ## cache-tree.c ##
     @@ cache-tree.c: int cache_tree_fully_valid(struct cache_tree *it)
      	int i;
    @@ http-push.c: int cmd_main(int argc, const char **argv)
      				       &ref->old_oid)) {
      				/*
     
    + ## http-walker.c ##
    +@@ http-walker.c: static int fill_active_slot(void *data UNUSED)
    + 	list_for_each_safe(pos, tmp, head) {
    + 		obj_req = list_entry(pos, struct object_request, node);
    + 		if (obj_req->state == WAITING) {
    +-			if (repo_has_object_file(the_repository, &obj_req->oid))
    ++			if (has_object(the_repository, &obj_req->oid,
    ++				       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
    + 				obj_req->state = COMPLETE;
    + 			else {
    + 				start_object_request(obj_req);
    +@@ http-walker.c: static int fetch_object(struct walker *walker, const struct object_id *oid)
    + 	if (!obj_req)
    + 		return error("Couldn't find request for %s in the queue", hex);
    + 
    +-	if (repo_has_object_file(the_repository, &obj_req->oid)) {
    ++	if (has_object(the_repository, &obj_req->oid,
    ++		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
    + 		if (obj_req->req)
    + 			abort_http_object_request(&obj_req->req);
    + 		abort_object_request(obj_req);
    +
    + ## list-objects.c ##
    +@@ list-objects.c: static void process_blob(struct traversal_context *ctx,
    + 	 * of missing objects.
    + 	 */
    + 	if (ctx->revs->exclude_promisor_objects &&
    +-	    !repo_has_object_file(the_repository, &obj->oid) &&
    ++	    !has_object(the_repository, &obj->oid,
    ++			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
    + 	    is_promisor_object(ctx->revs->repo, &obj->oid))
    + 		return;
    + 
    +
      ## notes.c ##
     @@ notes.c: static int prune_notes_helper(const struct object_id *object_oid,
      	struct note_delete_list **l = (struct note_delete_list **) cb_data;
    @@ reflog.c: static int tree_is_complete(const struct object_id *oid)
      			tree->object.flags |= INCOMPLETE;
      			complete = 0;
     
    + ## refs.c ##
    +@@ refs.c: int ref_resolves_to_object(const char *refname,
    + {
    + 	if (flags & REF_ISBROKEN)
    + 		return 0;
    +-	if (!repo_has_object_file(repo, oid)) {
    ++	if (!has_object(repo, oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
    + 		error(_("%s does not point to a valid object!"), refname);
    + 		return 0;
    + 	}
    +
      ## remote.c ##
     @@ remote.c: void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
      		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 7:  ab0dc1c5ce3 <  -:  ----------- builtin/index-pack: don't fetch promised objects for collision check
 8:  89c314a7dfd <  -:  ----------- builtin/show-ref: don't fetch objects when printing refs
 9:  a1f647f264f <  -:  ----------- refs: don't fetch promisor objects in `ref_resolves_to_object()`
10:  624aa140720 <  -:  ----------- http-walker: don't fetch objects via promisor remotes
11:  a2604942569 <  -:  ----------- list-objects: clarify how promised blobs are excluded
12:  d08d6092580 <  -:  ----------- bulk-checkin: don't fetch promised objects on write
13:  84af5509257 =  7:  60aeb060bd5 object-store: drop `repo_has_object_file()`

---
base-commit: ca819c0751cedd1713334882e4c83687f8478a54
change-id: 20250422-pks-object-store-cleanups-5a6077014155

