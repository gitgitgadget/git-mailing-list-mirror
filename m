Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B152E7F38
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891168; cv=none; b=Ik4mhs16AvhbP1ec7w4KoIX9qnj1Snj3R6pc0Rrsj3S2tVwcCXYdz+DQdvo4DasTOXh7iS5Ydq6EoONR8/u/u70eSAJ5nxAvMylWF0QLQU+Jo3OQwuk8f/P5GPwznSBKgVCXXM9ps4/+zxwskYm4ouoWTlSnAk6fR+odqXpN6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891168; c=relaxed/simple;
	bh=hG0vQP5hgImC+Gjwuyy7WmUv8jSJLOhcHJUk+F4NDeo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ART3unuaBFb2P2b8oq+fuCEroYUqzPcEYsMwFIkz3z0AZr800SdPy+plFJ5yrmuSG26Y8Gj9YhTPOZGUyK/d0aJtyIL/qziahoKuQtmVwK7b+09L46ZtHuMxmbNV51H90noX6WOWMmDxsZb64H2yOdEr9aNcWO9QlSsGUoLonzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nZw43YzN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n75aaS54; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nZw43YzN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n75aaS54"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CAE61EC01E4;
	Fri, 31 Oct 2025 02:12:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 31 Oct 2025 02:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891164;
	 x=1761977564; bh=EyENU/qVtomxABs3fJRkI1GhM5Coto+YeMMO8DcL8x0=; b=
	nZw43YzN5r10CTtlXt6S53YeSSGqKXhMvFXp3h97lmvCTTgpQYK0vIq+TAen2eDH
	6gC3uWT2TNRDUZ3+GFlEw23vOFXIad6XiACFvoJEm2NqwDCCxkC9ExMFAHROmA7C
	OuCKbJv7TgPELYdss0n0VtpS9jk4ygIgxytatF+xttgOnOASuu+xSMpAMhw4n5g1
	0WHQ1ETQL5Fi2bGc6qXPJlzdwH/A0ctKGnecsL/dQa98lYVOgcwqb5j8bIadXt5k
	an4jOpjIP996+nSFud8xkUrm8sHoOWcqn5XNX+dISPd+bDhRtg48SBZrMirqcDOg
	pgMmMuCifwKKuwIYFQwz6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891164; x=
	1761977564; bh=EyENU/qVtomxABs3fJRkI1GhM5Coto+YeMMO8DcL8x0=; b=n
	75aaS54e7u+O3AJeMUvcnaf595KgoWEuZ3pLQBWa420W9YOlSUbIsrt366fbSErp
	pxv6jc5zDH3Ob+iKbrpIVL5RgNInQfoEdwahP2Cq015ypakhBIpIsf1jFXl2p1CB
	0289544LqDPxu+D5RPy6PfusuEpQdspOoIJWX87/8pc5zmwndfaj662F8lVx4lmt
	k3/GThbQSv/zLOpslzmKmDx7BVDHaRFOAr14Yqj836JJKcLiwaQt0HB/rBesUb+c
	Ou+fAZqhhm2Pun+u13cRTnm5Qee4NUnDlN/ZkwR3FaMgoLp91uVdM9/v5NXfzZOz
	abER5hYQBsByd4zK5PqKg==
X-ME-Sender: <xms:XFMEaQojZFx6AlVjgObEIHUrDGX_K9aZUq9rlGz1ByQq6j2TeNunng>
    <xme:XFMEaeHeJ_m-vcmF1krjMR2jDlvoNpdMkJVBB6wRxto6wbSA1iSGSTUDyCZ3VcMqJ
    vLvJrQKR9Q2_MI0B53QhWvGYdQHRYDXs26GjQKip5h6djoc9rfNfg>
X-ME-Received: <xmr:XFMEaSkUIrKLzuvZ7bD4gIDIGPRpqWJuun0slPlvAWUW-csICnpUCEaUbLyWmDYyWEPVKdA5cTY1WVLXm2IcxdjuW_T6UtHC6tC4KbkEklu2UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XFMEaRnvNYP9sl-CeW4a6i7fZgSo0cVz-MCBGFA20LIrz6evfsIkaw>
    <xmx:XFMEaTu_NNaO9lMWnIxi4Nb_s8unQ5PVHOvg3XUYFP4WG9mFIAXvkQ>
    <xmx:XFMEaUnvORcgKuIb_x5Kb21S0KW2Cp5gkHAL1eIJjwcL1zAcOwk0mQ>
    <xmx:XFMEaeuBxUP7c3PYQPdGtHS4vZvC6Ts5xH3shyl09tJXbp7lRLhnLw>
    <xmx:XFMEaWGMy4rYmFoGDd_-iQZzgVSUj0ZHmBa--LAQS0gEehe2zOCaC4e5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:12:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f462978 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:12:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/13] Carve out loose object source
Date: Fri, 31 Oct 2025 07:12:36 +0100
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVTBGkC/3WNzQrCMBCEX6Xs2ZVsGol48j2kh/ysdqk2JZGil
 L67sXj1+A0z3yxQOAsXODULZJ6lSBor6F0DoXfjjVFiZdBKH0iRRW9wGgqm6PGeUmH0Lgw8RvT
 ESrXBECkLdT5lvsprU1+6yr2UZ8rv7Wmmb/qTavNfOhMqJGdqU9s2tMdz7e3lAd26rh8YiAVEv
 QAAAA==
X-Change-ID: 20251017-b4-pks-odb-loose-backend-b1e003c41107
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series carves out loose object sources. The idea is to store
all data that relates to loose objects in a single structure, similar to
our `struct packfile_store`.

The series is structured as follows:

  - Patches 1 to 4 perform some cleanups in the vicinity of object
    databases.

  - Patches 5 to 8 create a new `struct odb_loose_source` and move all
    state that is specific to loose objects into it.

  - Patches 9 to 13 then adjust functions to work on top of that new
    structure.

The motivation here is to make handling of loose objects completely
self-contained as a step towards pluggable object databases.

Changes in v2:
  - Rename `sturct odb_loose_source *` arguments from `source` to
    `loose`.
  - Some commit message improvements.
  - Link to v1: https://lore.kernel.org/r/20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (13):
      odb: fix subtle logic to check whether an alternate is usable
      odb: introduce `odb_source_new()`
      odb: adjust naming to free object sources
      object-file: move `fetch_if_missing`
      object-file: introduce `struct odb_loose_source`
      object-file: move loose object cache into loose source
      object-file: hide internals when we need to reprepare loose sources
      object-file: move loose object map into loose source
      object-file: read objects via the loose object source
      object-file: rename `has_loose_object()`
      object-file: refactor freshening of objects
      object-file: rename `write_object_file()`
      object-file: refactor writing objects via a stream

 builtin/pack-objects.c   |   4 +-
 builtin/unpack-objects.c |   7 +-
 loose.c                  |  19 ++---
 object-file.c            | 175 +++++++++++++++++++++--------------------------
 object-file.h            |  98 ++++++++++++++------------
 object-name.c            |   2 +-
 odb.c                    | 104 +++++++++++++++++++---------
 odb.h                    |  41 +++++++----
 packfile.c               |  16 +++++
 packfile.h               |   3 +
 repository.c             |  14 ++--
 streaming.c              |  11 ++-
 12 files changed, 287 insertions(+), 207 deletions(-)

Range-diff versus v1:

 1:  b43ef34ba3d !  1:  f0bd0c69c8c odb: fix subtle logic to check whether an alternate is usable
    @@ Commit message
         mechanism.
     
         Make the relationship more explicit by not storing the path as part of
    -    `alt_odb_usable()`. Instead, we store the path after we have created the
    -    source now so that we can use the source's path pointer directly.
    +    `alt_odb_usable()`. Instead, store the path after we have created the
    +    source so that we can use the source's path pointer directly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 2:  a56c17be445 =  2:  b11d557b69d odb: introduce `odb_source_new()`
 3:  8d5d4f98d0c !  3:  eab62039169 odb: adjust naming to free object sources
    @@ Commit message
         are responsible for freeing a single object source or all object sources
         connected to an object database, respectively. The associated structure
         has been renamed from `struct object_directory` to `struct odb_source`
    -    recently though, so the names are somewhat stale nowadays.
    +    in a1e2581a1e (object-store: rename `object_directory` to `odb_source`,
    +    2025-07-01) though, so the names are somewhat stale nowadays.
     
         Rename them to mention the new struct name instead. Furthermore, while
         at it, adapt them to our modern naming schema where we first have the
 4:  c2e85285be2 =  4:  6afdd2679d8 object-file: move `fetch_if_missing`
 5:  3a532fcac19 !  5:  7de78e1e32b object-file: introduce `struct odb_loose_source`
    @@ object-file.c: void object_file_transaction_commit(struct odb_transaction *trans
     +	return loose;
     +}
     +
    -+void odb_loose_source_free(struct odb_loose_source *source)
    ++void odb_loose_source_free(struct odb_loose_source *loose)
     +{
    -+	free(source);
    ++	free(loose);
     +}
     
      ## object-file.h ##
    @@ object-file.h: int index_path(struct index_state *istate, struct object_id *oid,
     +};
     +
     +struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
    -+void odb_loose_source_free(struct odb_loose_source *source);
    ++void odb_loose_source_free(struct odb_loose_source *loose);
     +
      /*
       * Populate and return the loose object cache array corresponding to the
 6:  4e15e659e25 !  6:  3d14e9c3b66 object-file: move loose object cache into loose source
    @@ object-file.c: static int append_loose_object(const struct object_id *oid,
      static int check_stream_oid(git_zstream *stream,
     @@ object-file.c: struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
      
    - void odb_loose_source_free(struct odb_loose_source *source)
    + void odb_loose_source_free(struct odb_loose_source *loose)
      {
    -+	if (!source)
    ++	if (!loose)
     +		return;
    -+	odb_clear_loose_cache(source->source);
    - 	free(source);
    ++	odb_clear_loose_cache(loose->source);
    + 	free(loose);
      }
     
      ## object-file.h ##
    @@ object-file.h: struct odb_source;
      };
      
      struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
    -@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *source);
    +@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *loose);
       * Populate and return the loose object cache array corresponding to the
       * given object ID.
       */
 7:  59d08a2b560 !  7:  2167b592c03 object-file: hide internals when we need to reprepare loose sources
    @@ object-file.c: struct oidtree *odb_loose_source_cache(struct odb_source *source,
      }
      
     -void odb_clear_loose_cache(struct odb_source *source)
    -+static void odb_loose_source_clear_cache(struct odb_loose_source *source)
    ++static void odb_loose_source_clear_cache(struct odb_loose_source *loose)
      {
     -	oidtree_clear(source->loose->cache);
     -	FREE_AND_NULL(source->loose->cache);
     -	memset(&source->loose->subdir_seen, 0,
     -	       sizeof(source->loose->subdir_seen));
    -+	oidtree_clear(source->cache);
    -+	FREE_AND_NULL(source->cache);
    -+	memset(&source->subdir_seen, 0,
    -+	       sizeof(source->subdir_seen));
    ++	oidtree_clear(loose->cache);
    ++	FREE_AND_NULL(loose->cache);
    ++	memset(&loose->subdir_seen, 0,
    ++	       sizeof(loose->subdir_seen));
     +}
     +
     +void odb_loose_source_reprepare(struct odb_source *source)
    @@ object-file.c: struct oidtree *odb_loose_source_cache(struct odb_source *source,
      }
      
      static int check_stream_oid(git_zstream *stream,
    -@@ object-file.c: void odb_loose_source_free(struct odb_loose_source *source)
    +@@ object-file.c: void odb_loose_source_free(struct odb_loose_source *loose)
      {
    - 	if (!source)
    + 	if (!loose)
      		return;
    --	odb_clear_loose_cache(source->source);
    -+	odb_loose_source_clear_cache(source);
    - 	free(source);
    +-	odb_clear_loose_cache(loose->source);
    ++	odb_loose_source_clear_cache(loose);
    + 	free(loose);
      }
     
      ## object-file.h ##
     @@ object-file.h: struct odb_loose_source {
      struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
    - void odb_loose_source_free(struct odb_loose_source *source);
    + void odb_loose_source_free(struct odb_loose_source *loose);
      
     +/* Reprepare the loose source by emptying the loose object cache. */
     +void odb_loose_source_reprepare(struct odb_source *source);
    @@ object-file.h: struct odb_loose_source {
      /*
       * Populate and return the loose object cache array corresponding to the
       * given object ID.
    -@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *source);
    +@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *loose);
      struct oidtree *odb_loose_source_cache(struct odb_source *source,
      				       const struct object_id *oid);
      
 8:  8c04cdc54a0 !  8:  a9a1637a863 object-file: move loose object map into loose source
    @@ loose.c: int repo_loose_object_map_oid(struct repository *repo,
      		map = (to == repo->compat_hash_algo) ?
     
      ## object-file.c ##
    -@@ object-file.c: void odb_loose_source_free(struct odb_loose_source *source)
    - 	if (!source)
    +@@ object-file.c: void odb_loose_source_free(struct odb_loose_source *loose)
    + 	if (!loose)
      		return;
    - 	odb_loose_source_clear_cache(source);
    -+	loose_object_map_clear(&source->map);
    - 	free(source);
    + 	odb_loose_source_clear_cache(loose);
    ++	loose_object_map_clear(&loose->map);
    + 	free(loose);
      }
     
      ## object-file.h ##
 9:  8847142a317 !  9:  99d4c039bd5 object-file: read objects via the loose object source
    @@ object-file.c: int stream_object_signature(struct repository *r, const struct ob
       * call to stat_loose_object().
       */
     -static int stat_loose_object(struct repository *r, const struct object_id *oid,
    -+static int stat_loose_object(struct odb_loose_source *source,
    ++static int stat_loose_object(struct odb_loose_source *loose,
     +			     const struct object_id *oid,
      			     struct stat *st, const char **path)
      {
    @@ object-file.c: int stream_object_signature(struct repository *r, const struct ob
     -		if (!lstat(*path, st))
     -			return 0;
     -	}
    -+	*path = odb_loose_path(source->source, &buf, oid);
    ++	*path = odb_loose_path(loose->source, &buf, oid);
     +	if (!lstat(*path, st))
     +		return 0;
      
    @@ object-file.c: static int stat_loose_object(struct repository *r, const struct o
       * descriptor. See the caveats on the "path" parameter above.
       */
     -static int open_loose_object(struct repository *r,
    -+static int open_loose_object(struct odb_loose_source *source,
    ++static int open_loose_object(struct odb_loose_source *loose,
      			     const struct object_id *oid, const char **path)
      {
     -	int fd;
    @@ object-file.c: static int stat_loose_object(struct repository *r, const struct o
     -		fd = git_open(*path);
     -		if (fd >= 0)
     -			return fd;
    -+	*path = odb_loose_path(source->source, &buf, oid);
    ++	*path = odb_loose_path(loose->source, &buf, oid);
     +	fd = git_open(*path);
     +	if (fd >= 0)
     +		return fd;
    @@ object-file.c: static int stat_loose_object(struct repository *r, const struct o
      }
      
     -static int quick_has_loose(struct repository *r,
    -+static int quick_has_loose(struct odb_loose_source *source,
    ++static int quick_has_loose(struct odb_loose_source *loose,
      			   const struct object_id *oid)
      {
     -	struct odb_source *source;
    @@ object-file.c: static int stat_loose_object(struct repository *r, const struct o
     -			return 1;
     -	}
     -	return 0;
    -+	return !!oidtree_contains(odb_loose_source_cache(source->source, oid), oid);
    ++	return !!oidtree_contains(odb_loose_source_cache(loose->source, oid), oid);
      }
      
      /*
    @@ object-file.c: int loose_object_info(struct repository *r,
      			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
     
      ## object-file.h ##
    -@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *source);
    +@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *loose);
      /* Reprepare the loose source by emptying the loose object cache. */
      void odb_loose_source_reprepare(struct odb_source *source);
      
10:  c1a2d001b37 = 10:  873dedf2efc object-file: rename `has_loose_object()`
11:  2aef29ba790 = 11:  86810514083 object-file: refactor freshening of objects
12:  5c5d6928af2 = 12:  89348b4c540 object-file: rename `write_object_file()`
13:  116f8065a2a = 13:  2dd87a1f135 object-file: refactor writing objects via a stream

---
base-commit: c54a18ef67e59cdbcd77d6294916d42c98c62d1d
change-id: 20251017-b4-pks-odb-loose-backend-b1e003c41107

