Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBCA2C026C
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155734; cv=none; b=MvYZuhShRwIeXwN/MXva1zplmEm6bZupI/5ml9JwzG1+od5YjHMc900XnHunKOWMN+R2VIn6Vw2uP2ZFF0nZBK9X6m+J30MK4mTEL8dp3yMmrfb/NSygkve3ezVtaZznNzcBgix23PDS70iI8yyFJadowU2CywgExh/lmtsu0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155734; c=relaxed/simple;
	bh=0YuH/3HogaXSJIn8iLYp332SJjmd6hftRqcvMo4SG4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CztRbCFVT+t9a3EGQ10K25yOI5HMPYBC9t6opamqX6BuKpzkj2YylNjf3tMMQShq3mvKWDZ01eHM5fKy88HtZUwG4vlMlC67FVKMfcYJzfXLBYd7scMa9OoULe9aZFav9Avn/bqgDysxxa9qEvDYUJQxodwt10HmeAIfqlJmYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pbzs8WHP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axNQwzok; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pbzs8WHP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axNQwzok"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 233201D00171;
	Mon,  3 Nov 2025 02:42:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 03 Nov 2025 02:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155728;
	 x=1762242128; bh=ugIn9Pgdw1nPC6queg92atNoZWarTYEseSvsmVa3zcs=; b=
	pbzs8WHPWBDwyqkwrPP+UQbBJ0FpTlxFAYQTmzblQc28SGz1IDcEC68I+AlGzsjo
	sia3PfFhqopOtK+RkiLAZEqmRPIrZP4hpHeuutMfvqMLonKzlMWBRoizc1U62pEu
	rUBDdShvO54WbN/EXqETNBAjxFdJDj7IprlcQ5qIbu8IVTZq9rQI27MdjWphERHC
	AzL42fN3e9NKLgROJyYlVTP9O1YHJZnOj7QDMcGhlLcc/Y7iIFxT3DIQV2MnV6IT
	nM/QonY4VRqNZeGfpyQ92AW5hJUhmw1xzSD3FoDDZpWzTVfIrMJuWFxzZG6BLffV
	NqO3RgDNpq3qYwxuX9JaHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155728; x=
	1762242128; bh=ugIn9Pgdw1nPC6queg92atNoZWarTYEseSvsmVa3zcs=; b=a
	xNQwzok6E3UrWsG8gj11lpRB32aXKiWV+Z8e+XwYAB2cGmAZU1Tqbuz3LvhF63se
	21qYU66HuB5zhqFMZ3XlviGZVABswlnEAsUPRlNXLm509CrkltwOJMd98DgEwYzl
	XYKt7KvPp5eUrS17/TSxbzk9CYH5WFLu5J4JWWPtqZMz5qCSpLuHNzM63sUdliJV
	fwp71Ea2/SLkay9D/sRJS63U2a60BVQdzMdn8fbJwco1sIybAu+xYKCtkfUlTrQb
	RxV2wXlS7HwAAwPGJIhNo9618VP6ngh/RiGt+xBnn3WOVndP2TU6VyeCrSWdCQuh
	ETjKVYUn4v8T+9AehNu7A==
X-ME-Sender: <xms:0FwIaT9-8USjAmAv3RyD-TJ7poMynSNMNhusl117TPUTVPL-zJQ-3g>
    <xme:0FwIaXJSJQh9_518zdEX4l7AAKZShCafA71swx-ANd5_d0-rZuXRqS9J8foIkmdnR
    FoBXR-jkU5VzIlk4PIlDRiQbG5cYUq7XelYChy8rveDZs3khAGq>
X-ME-Received: <xmr:0FwIaeaOjBHUGTLBOMC1mYu5kqys4kOV5z_bqwMsEsrUlYBYvOAXN82lWPQnU7wvSHGnpC0jxWHHr6409ifi12BMzZ3lYoy8c590Rt4Vt3PK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0FwIaZL_DdoBqNV884kXa7uv2ycy4i28FhBgUmpZKVcv-1YoGbCzqg>
    <xmx:0FwIacB4jAx_WsoEKBj-ltk8LY9rIi3tnE66Jp01x5e5Vd03u6mcEA>
    <xmx:0FwIaepq3WdKeCrB0wZHSxZhsLw8tA8mdsp7x8s7rVPOOUvNNwkGsw>
    <xmx:0FwIaXjL3xBMW6WLl0hJX77PrT_WlFVgvnyJ1nPUiOXCCKa9paqMZQ>
    <xmx:0FwIaTK_lQE8BKtlz4LqXL87a_9gKtpPGwsgSz5L76tpyboQJgIJUdWJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fbae29b3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/13] Carve out loose object source
Date: Mon, 03 Nov 2025 08:41:55 +0100
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMNcCGkC/33NQQrCMBAF0KtI1o5kJpGoK+8hLtJ0akO1KYkEp
 fTupkXEjS7/8P+bUSSOnpM4rEYROfvkQ1+CWq+Ea21/YfB1yYIkbVGigUrD0CUIdQXXEBJDZV3
 HfQ0VspTKaURpRJkPkRv/WOjTueTWp3uIz+VTxvn6Rkn/RjOCBLS6NMkop3bH0tv4m5jFTF+Kw
 j8KFWVPsjGElhuDH2WaphfOGt+BAwEAAA==
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

  - Patches 5 to 8 create a new `struct source_loose` and move all
    state that is specific to loose objects into it.

  - Patches 9 to 13 then adjust functions to work on top of that new
    structure.

The motivation here is to make handling of loose objects completely
self-contained as a step towards pluggable object databases.

Changes in v3:
  - Rename `struct odb_loose_source` to `odb_source_loose`. Adjust its
    functions accordingly.
  - Link to v2: https://lore.kernel.org/r/20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im

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
      object-file: introduce `struct odb_source_loose`
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

Range-diff versus v2:

 1:  330b7c17e6a =  1:  ed548a7ee4e odb: fix subtle logic to check whether an alternate is usable
 2:  68b2e736d20 =  2:  59d5548ddfa odb: introduce `odb_source_new()`
 3:  b6f9a3f6d26 =  3:  a417bd30153 odb: adjust naming to free object sources
 4:  fe38c58ab20 =  4:  add2b7d112f object-file: move `fetch_if_missing`
 5:  5fed6e7c429 !  5:  5245ba0c6a5 object-file: introduce `struct odb_loose_source`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    object-file: introduce `struct odb_loose_source`
    +    object-file: introduce `struct odb_source_loose`
     
         Currently, all state that relates to loose objects is held directly by
    -    the `struct odb_source`. Introduce a new `struct odb_loose_source` to
    +    the `struct odb_source`. Introduce a new `struct odb_source_loose` to
         hold the state instead so that it is entirely self-contained.
     
         This structure will eventually morph into the backend for accessing
    @@ object-file.c: void object_file_transaction_commit(struct odb_transaction *trans
      	free(transaction);
      }
     +
    -+struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
    ++struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
     +{
    -+	struct odb_loose_source *loose;
    ++	struct odb_source_loose *loose;
     +	CALLOC_ARRAY(loose, 1);
     +	loose->source = source;
     +	return loose;
     +}
     +
    -+void odb_loose_source_free(struct odb_loose_source *loose)
    ++void odb_source_loose_free(struct odb_source_loose *loose)
     +{
     +	free(loose);
     +}
    @@ object-file.h: int index_path(struct index_state *istate, struct object_id *oid,
      
      struct odb_source;
      
    -+struct odb_loose_source {
    ++struct odb_source_loose {
     +	struct odb_source *source;
     +};
     +
    -+struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
    -+void odb_loose_source_free(struct odb_loose_source *loose);
    ++struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
    ++void odb_source_loose_free(struct odb_source_loose *loose);
     +
      /*
       * Populate and return the loose object cache array corresponding to the
    @@ odb.c: struct odb_source *odb_source_new(struct object_database *odb,
      	source->odb = odb;
      	source->local = local;
      	source->path = xstrdup(path);
    -+	source->loose = odb_loose_source_new(source);
    ++	source->loose = odb_source_loose_new(source);
      
      	return source;
      }
    @@ odb.c: struct odb_source *odb_set_temporary_primary_source(struct object_databas
      static void odb_source_free(struct odb_source *source)
      {
      	free(source->path);
    -+	odb_loose_source_free(source->loose);
    ++	odb_source_loose_free(source->loose);
      	odb_clear_loose_cache(source);
      	loose_object_map_clear(&source->loose_map);
      	free(source);
    @@ odb.h: struct odb_source {
      	struct object_database *odb;
      
     +	/* Private state for loose objects. */
    -+	struct odb_loose_source *loose;
    ++	struct odb_source_loose *loose;
     +
      	/*
      	 * Used to store the results of readdir(3) calls when we are OK
 6:  a66851a6afd !  6:  3d931e4929d object-file: move loose object cache into loose source
    @@ Commit message
     
         Our loose objects use a cache that (optionally) stores all objects for
         each of the opened sharding directories. This cache is located in the
    -    `struct odb_source`, but now that we have `struct odb_loose_source` it
    +    `struct odb_source`, but now that we have `struct odb_source_loose` it
         makes sense to move it into the latter structure so that all state that
         relates to loose objects is entirely self-contained.
     
         Do so. While at it, rename corresponding functions to have a prefix that
    -    relates to `struct odb_loose_source`.
    +    relates to `struct odb_source_loose`.
     
         Note that despite this prefix, the functions still accept a `struct
         odb_source` as input. This is done intentionally: once we introduce
         pluggable object databases, we will continue to accept this struct but
    -    then do a cast inside these functions to `struct odb_loose_source`. This
    +    then do a cast inside these functions to `struct odb_source_loose`. This
         design is similar to how we do it for our ref backends.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ object-file.c: static int quick_has_loose(struct repository *r,
      	odb_prepare_alternates(r->objects);
      	for (source = r->objects->sources; source; source = source->next) {
     -		if (oidtree_contains(odb_loose_cache(source, oid), oid))
    -+		if (oidtree_contains(odb_loose_source_cache(source, oid), oid))
    ++		if (oidtree_contains(odb_source_loose_cache(source, oid), oid))
      			return 1;
      	}
      	return 0;
    @@ object-file.c: static int append_loose_object(const struct object_id *oid,
      
     -struct oidtree *odb_loose_cache(struct odb_source *source,
     -				const struct object_id *oid)
    -+struct oidtree *odb_loose_source_cache(struct odb_source *source,
    ++struct oidtree *odb_source_loose_cache(struct odb_source *source,
     +				       const struct object_id *oid)
      {
      	int subdir_nr = oid->hash[0];
    @@ object-file.c: static int append_loose_object(const struct object_id *oid,
      }
      
      static int check_stream_oid(git_zstream *stream,
    -@@ object-file.c: struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
    +@@ object-file.c: struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
      
    - void odb_loose_source_free(struct odb_loose_source *loose)
    + void odb_source_loose_free(struct odb_source_loose *loose)
      {
     +	if (!loose)
     +		return;
    @@ object-file.c: struct odb_loose_source *odb_loose_source_new(struct odb_source *
      ## object-file.h ##
     @@ object-file.h: struct odb_source;
      
    - struct odb_loose_source {
    + struct odb_source_loose {
      	struct odb_source *source;
     +
     +	/*
    @@ object-file.h: struct odb_source;
     +	struct oidtree *cache;
      };
      
    - struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
    -@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *loose);
    + struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
    +@@ object-file.h: void odb_source_loose_free(struct odb_source_loose *loose);
       * Populate and return the loose object cache array corresponding to the
       * given object ID.
       */
     -struct oidtree *odb_loose_cache(struct odb_source *source,
     -				const struct object_id *oid);
    -+struct oidtree *odb_loose_source_cache(struct odb_source *source,
    ++struct oidtree *odb_source_loose_cache(struct odb_source *source,
     +				       const struct object_id *oid);
      
      /* Empty the loose object cache for the specified object directory. */
    @@ object-name.c: static void find_short_object_filename(struct disambiguate_state
      
      	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
     -		oidtree_each(odb_loose_cache(source, &ds->bin_pfx),
    -+		oidtree_each(odb_loose_source_cache(source, &ds->bin_pfx),
    ++		oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
      				&ds->bin_pfx, ds->len, match_prefix, ds);
      }
      
    @@ odb.c
     @@ odb.c: static void odb_source_free(struct odb_source *source)
      {
      	free(source->path);
    - 	odb_loose_source_free(source->loose);
    + 	odb_source_loose_free(source->loose);
     -	odb_clear_loose_cache(source);
      	loose_object_map_clear(&source->loose_map);
      	free(source);
    @@ odb.c: static void odb_source_free(struct odb_source *source)
      ## odb.h ##
     @@ odb.h: struct odb_source {
      	/* Private state for loose objects. */
    - 	struct odb_loose_source *loose;
    + 	struct odb_source_loose *loose;
      
     -	/*
     -	 * Used to store the results of readdir(3) calls when we are OK
 7:  ac94974a4b4 !  7:  6eb525fa775 object-file: hide internals when we need to reprepare loose sources
    @@ Commit message
           - When repreparing the loose object source so that any potentially-
             stale data is getting evicted from the cache.
     
    -    The former is already handled by `odb_loose_source_free()`. But the
    +    The former is already handled by `odb_source_loose_free()`. But the
         latter case is still done manually by in `odb_reprepare()`, so we are
         leaking internals into that code.
     
    -    Introduce a new `odb_loose_source_reprepare()` function as an equivalent
    +    Introduce a new `odb_source_loose_reprepare()` function as an equivalent
         to `packfile_store_prepare()` to hide these implementation details.
         Furthermore, while at it, rename the function `odb_clear_loose_cache()`
    -    to `odb_loose_source_clear()`.
    +    to `odb_source_loose_clear()`.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## object-file.c ##
    -@@ object-file.c: struct oidtree *odb_loose_source_cache(struct odb_source *source,
    +@@ object-file.c: struct oidtree *odb_source_loose_cache(struct odb_source *source,
      	return source->loose->cache;
      }
      
     -void odb_clear_loose_cache(struct odb_source *source)
    -+static void odb_loose_source_clear_cache(struct odb_loose_source *loose)
    ++static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
      {
     -	oidtree_clear(source->loose->cache);
     -	FREE_AND_NULL(source->loose->cache);
    @@ object-file.c: struct oidtree *odb_loose_source_cache(struct odb_source *source,
     +	       sizeof(loose->subdir_seen));
     +}
     +
    -+void odb_loose_source_reprepare(struct odb_source *source)
    ++void odb_source_loose_reprepare(struct odb_source *source)
     +{
    -+	odb_loose_source_clear_cache(source->loose);
    ++	odb_source_loose_clear_cache(source->loose);
      }
      
      static int check_stream_oid(git_zstream *stream,
    -@@ object-file.c: void odb_loose_source_free(struct odb_loose_source *loose)
    +@@ object-file.c: void odb_source_loose_free(struct odb_source_loose *loose)
      {
      	if (!loose)
      		return;
     -	odb_clear_loose_cache(loose->source);
    -+	odb_loose_source_clear_cache(loose);
    ++	odb_source_loose_clear_cache(loose);
      	free(loose);
      }
     
      ## object-file.h ##
    -@@ object-file.h: struct odb_loose_source {
    - struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
    - void odb_loose_source_free(struct odb_loose_source *loose);
    +@@ object-file.h: struct odb_source_loose {
    + struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
    + void odb_source_loose_free(struct odb_source_loose *loose);
      
     +/* Reprepare the loose source by emptying the loose object cache. */
    -+void odb_loose_source_reprepare(struct odb_source *source);
    ++void odb_source_loose_reprepare(struct odb_source *source);
     +
      /*
       * Populate and return the loose object cache array corresponding to the
       * given object ID.
    -@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *loose);
    - struct oidtree *odb_loose_source_cache(struct odb_source *source,
    +@@ object-file.h: void odb_source_loose_free(struct odb_source_loose *loose);
    + struct oidtree *odb_source_loose_cache(struct odb_source *source,
      				       const struct object_id *oid);
      
     -/* Empty the loose object cache for the specified object directory. */
    @@ odb.c: void odb_reprepare(struct object_database *o)
      
      	for (source = o->sources; source; source = source->next)
     -		odb_clear_loose_cache(source);
    -+		odb_loose_source_reprepare(source);
    ++		odb_source_loose_reprepare(source);
      
      	o->approximate_object_count_valid = 0;
      
 8:  8820c59b0d1 !  8:  f5aff5356f1 object-file: move loose object map into loose source
    @@ loose.c: int repo_loose_object_map_oid(struct repository *repo,
      		map = (to == repo->compat_hash_algo) ?
     
      ## object-file.c ##
    -@@ object-file.c: void odb_loose_source_free(struct odb_loose_source *loose)
    +@@ object-file.c: void odb_source_loose_free(struct odb_source_loose *loose)
      	if (!loose)
      		return;
    - 	odb_loose_source_clear_cache(loose);
    + 	odb_source_loose_clear_cache(loose);
     +	loose_object_map_clear(&loose->map);
      	free(loose);
      }
     
      ## object-file.h ##
    -@@ object-file.h: struct odb_loose_source {
    +@@ object-file.h: struct odb_source_loose {
      	 */
      	uint32_t subdir_seen[8]; /* 256 bits */
      	struct oidtree *cache;
    @@ object-file.h: struct odb_loose_source {
     +	struct loose_object_map *map;
      };
      
    - struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
    + struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
     
      ## odb.c ##
     @@ odb.c: static void odb_source_free(struct odb_source *source)
      {
      	free(source->path);
    - 	odb_loose_source_free(source->loose);
    + 	odb_source_loose_free(source->loose);
     -	loose_object_map_clear(&source->loose_map);
      	free(source);
      }
    @@ odb.c: static void odb_source_free(struct odb_source *source)
      ## odb.h ##
     @@ odb.h: struct odb_source {
      	/* Private state for loose objects. */
    - 	struct odb_loose_source *loose;
    + 	struct odb_source_loose *loose;
      
     -	/* Map between object IDs for loose objects. */
     -	struct loose_object_map *loose_map;
 9:  0a549d59861 !  9:  2e328d81928 object-file: read objects via the loose object source
    @@ object-file.c: int stream_object_signature(struct repository *r, const struct ob
       * call to stat_loose_object().
       */
     -static int stat_loose_object(struct repository *r, const struct object_id *oid,
    -+static int stat_loose_object(struct odb_loose_source *loose,
    ++static int stat_loose_object(struct odb_source_loose *loose,
     +			     const struct object_id *oid,
      			     struct stat *st, const char **path)
      {
    @@ object-file.c: static int stat_loose_object(struct repository *r, const struct o
       * descriptor. See the caveats on the "path" parameter above.
       */
     -static int open_loose_object(struct repository *r,
    -+static int open_loose_object(struct odb_loose_source *loose,
    ++static int open_loose_object(struct odb_source_loose *loose,
      			     const struct object_id *oid, const char **path)
      {
     -	int fd;
    @@ object-file.c: static int stat_loose_object(struct repository *r, const struct o
      }
      
     -static int quick_has_loose(struct repository *r,
    -+static int quick_has_loose(struct odb_loose_source *loose,
    ++static int quick_has_loose(struct odb_source_loose *loose,
      			   const struct object_id *oid)
      {
     -	struct odb_source *source;
     -
     -	odb_prepare_alternates(r->objects);
     -	for (source = r->objects->sources; source; source = source->next) {
    --		if (oidtree_contains(odb_loose_source_cache(source, oid), oid))
    +-		if (oidtree_contains(odb_source_loose_cache(source, oid), oid))
     -			return 1;
     -	}
     -	return 0;
    -+	return !!oidtree_contains(odb_loose_source_cache(loose->source, oid), oid);
    ++	return !!oidtree_contains(odb_source_loose_cache(loose->source, oid), oid);
      }
      
      /*
    @@ object-file.c: static void *map_fd(int fd, const char *path, unsigned long *size
     -void *map_loose_object(struct repository *r,
     -		       const struct object_id *oid,
     -		       unsigned long *size)
    -+void *odb_loose_source_map_object(struct odb_source *source,
    ++void *odb_source_loose_map_object(struct odb_source *source,
     +				  const struct object_id *oid,
     +				  unsigned long *size)
      {
    @@ object-file.c: int parse_loose_header(const char *hdr, struct object_info *oi)
     -int loose_object_info(struct repository *r,
     -		      const struct object_id *oid,
     -		      struct object_info *oi, int flags)
    -+int odb_loose_source_read_object_info(struct odb_source *source,
    ++int odb_source_loose_read_object_info(struct odb_source *source,
     +				      const struct object_id *oid,
     +				      struct object_info *oi, int flags)
      {
    @@ object-file.c: int loose_object_info(struct repository *r,
      			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
     
      ## object-file.h ##
    -@@ object-file.h: void odb_loose_source_free(struct odb_loose_source *loose);
    +@@ object-file.h: void odb_source_loose_free(struct odb_source_loose *loose);
      /* Reprepare the loose source by emptying the loose object cache. */
    - void odb_loose_source_reprepare(struct odb_source *source);
    + void odb_source_loose_reprepare(struct odb_source *source);
      
    -+int odb_loose_source_read_object_info(struct odb_source *source,
    ++int odb_source_loose_read_object_info(struct odb_source *source,
     +				      const struct object_id *oid,
     +				      struct object_info *oi, int flags);
     +
    -+void *odb_loose_source_map_object(struct odb_source *source,
    ++void *odb_source_loose_map_object(struct odb_source *source,
     +				  const struct object_id *oid,
     +				  unsigned long *size);
     +
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
     -		if (!loose_object_info(odb->repo, real, oi, flags))
     -			return 0;
     +		for (source = odb->sources; source; source = source->next)
    -+			if (!odb_loose_source_read_object_info(source, real, oi, flags))
    ++			if (!odb_source_loose_read_object_info(source, real, oi, flags))
     +				return 0;
      
      		/* Not a loose object; someone else may have just packed it. */
    @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct reposi
     -	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
     +	odb_prepare_alternates(r->objects);
     +	for (source = r->objects->sources; source; source = source->next) {
    -+		st->u.loose.mapped = odb_loose_source_map_object(source, oid,
    ++		st->u.loose.mapped = odb_source_loose_map_object(source, oid,
     +								 &st->u.loose.mapsize);
     +		if (st->u.loose.mapped)
     +			break;
10:  bcc58f6f7e5 ! 10:  29787a709b3 object-file: rename `has_loose_object()`
    @@ Metadata
      ## Commit message ##
         object-file: rename `has_loose_object()`
     
    -    Rename `has_loose_object()` to `odb_loose_source_has_object()` so that
    +    Rename `has_loose_object()` to `odb_source_loose_has_object()` so that
         it becomes clear that this is tied to a specific loose object source.
         This matches our modern naming schema for functions.
     
    @@ builtin/pack-objects.c: static int want_object_in_pack_mtime(const struct object
      		struct odb_source *source = the_repository->objects->sources->next;
      		for (; source; source = source->next)
     -			if (has_loose_object(source, oid))
    -+			if (odb_loose_source_has_object(source, oid))
    ++			if (odb_source_loose_has_object(source, oid))
      				return 0;
      	}
      
    @@ builtin/pack-objects.c: static void add_cruft_object_entry(const struct object_i
      
      			for (; !found && source; source = source->next)
     -				if (has_loose_object(source, oid))
    -+				if (odb_loose_source_has_object(source, oid))
    ++				if (odb_source_loose_has_object(source, oid))
      					found = 1;
      
      			/*
    @@ object-file.c: static int check_and_freshen_source(struct odb_source *source,
      
     -int has_loose_object(struct odb_source *source,
     -		     const struct object_id *oid)
    -+int odb_loose_source_has_object(struct odb_source *source,
    ++int odb_source_loose_has_object(struct odb_source *source,
     +				const struct object_id *oid)
      {
      	return check_and_freshen_source(source, oid, 0);
    @@ object-file.c: int force_object_loose(struct odb_source *source,
      
      	for (struct odb_source *s = source->odb->sources; s; s = s->next)
     -		if (has_loose_object(s, oid))
    -+		if (odb_loose_source_has_object(s, oid))
    ++		if (odb_source_loose_has_object(s, oid))
      			return 0;
      
      	oi.typep = &type;
     
      ## object-file.h ##
    -@@ object-file.h: void *odb_loose_source_map_object(struct odb_source *source,
    +@@ object-file.h: void *odb_source_loose_map_object(struct odb_source *source,
      				  const struct object_id *oid,
      				  unsigned long *size);
      
    @@ object-file.h: void *odb_loose_source_map_object(struct odb_source *source,
     + * with the specified name.  This function does not respect replace
     + * references.
     + */
    -+int odb_loose_source_has_object(struct odb_source *source,
    ++int odb_source_loose_has_object(struct odb_source *source,
     +				const struct object_id *oid);
     +
      /*
11:  60a5e4882cd ! 11:  3b95f712fb4 object-file: refactor freshening of objects
    @@ Commit message
     
         Introduce a new `odb_freshen_object()` function that sits on the object
         database level and two functions `packfile_store_freshen_object()` and
    -    `odb_loose_source_freshen_object()`. Like this, the format-specific
    +    `odb_source_loose_freshen_object()`. Like this, the format-specific
         functions can be part of their respective subsystems, while the backend
         agnostic function to freshen an object sits at the object database
         layer.
    @@ object-file.c: static int write_loose_object(struct odb_source *source,
      
     -static int freshen_loose_object(struct object_database *odb,
     -				const struct object_id *oid)
    -+int odb_loose_source_freshen_object(struct odb_source *source,
    ++int odb_source_loose_freshen_object(struct odb_source *source,
     +				    const struct object_id *oid)
      {
     -	odb_prepare_alternates(odb);
    @@ object-file.c: int write_object_file(struct odb_source *source,
      		return -1;
     
      ## object-file.h ##
    -@@ object-file.h: void *odb_loose_source_map_object(struct odb_source *source,
    - int odb_loose_source_has_object(struct odb_source *source,
    +@@ object-file.h: void *odb_source_loose_map_object(struct odb_source *source,
    + int odb_source_loose_has_object(struct odb_source *source,
      				const struct object_id *oid);
      
    -+int odb_loose_source_freshen_object(struct odb_source *source,
    ++int odb_source_loose_freshen_object(struct odb_source *source,
     +				    const struct object_id *oid);
     +
      /*
    @@ odb.c: int odb_has_object(struct object_database *odb, const struct object_id *o
     +
     +	odb_prepare_alternates(odb);
     +	for (source = odb->sources; source; source = source->next)
    -+		if (odb_loose_source_freshen_object(source, oid))
    ++		if (odb_source_loose_freshen_object(source, oid))
     +			return 1;
     +
     +	return 0;
12:  d31eec55aec ! 12:  31970221960 object-file: rename `write_object_file()`
    @@ Metadata
      ## Commit message ##
         object-file: rename `write_object_file()`
     
    -    Rename `write_object_file()` to `odb_loose_source_write_object()` so
    +    Rename `write_object_file()` to `odb_source_loose_write_object()` so
         that it becomes clear that this is tied to a specific loose object
         source. This matches our modern naming schema for functions.
     
    @@ object-file.c: int stream_loose_object(struct odb_source *source,
     -		      const void *buf, unsigned long len,
     -		      enum object_type type, struct object_id *oid,
     -		      struct object_id *compat_oid_in, unsigned flags)
    -+int odb_loose_source_write_object(struct odb_source *source,
    ++int odb_source_loose_write_object(struct odb_source *source,
     +				  const void *buf, unsigned long len,
     +				  enum object_type type, struct object_id *oid,
     +				  struct object_id *compat_oid_in, unsigned flags)
    @@ object-file.c: int stream_loose_object(struct odb_source *source,
      	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
     
      ## object-file.h ##
    -@@ object-file.h: int odb_loose_source_has_object(struct odb_source *source,
    - int odb_loose_source_freshen_object(struct odb_source *source,
    +@@ object-file.h: int odb_source_loose_has_object(struct odb_source *source,
    + int odb_source_loose_freshen_object(struct odb_source *source,
      				    const struct object_id *oid);
      
    -+int odb_loose_source_write_object(struct odb_source *source,
    ++int odb_source_loose_write_object(struct odb_source *source,
     +				  const void *buf, unsigned long len,
     +				  enum object_type type, struct object_id *oid,
     +				  struct object_id *compat_oid_in, unsigned flags);
    @@ odb.c: int odb_write_object_ext(struct object_database *odb,
      			 unsigned flags)
      {
     -	return write_object_file(odb->sources, buf, len, type, oid, compat_oid, flags);
    -+	return odb_loose_source_write_object(odb->sources, buf, len, type,
    ++	return odb_source_loose_write_object(odb->sources, buf, len, type,
     +					     oid, compat_oid, flags);
      }
      
13:  84fbe7758d0 ! 13:  cec069fd2df object-file: refactor writing objects via a stream
    @@ Commit message
         have to be aware of the inner workings of how to stream an object to
         disk with a specific object source.
     
    -    Rename `stream_loose_object()` to `odb_loose_source_write_stream()` to
    +    Rename `stream_loose_object()` to `odb_source_loose_write_stream()` to
         clarify its scope. This matches our modern best practices around how to
         name functions.
     
    @@ builtin/unpack-objects.c: static void stream_blob(unsigned long size, unsigned n
      	if (data.status != Z_STREAM_END)
     
      ## object-file.c ##
    -@@ object-file.c: int odb_loose_source_freshen_object(struct odb_source *source,
    +@@ object-file.c: int odb_source_loose_freshen_object(struct odb_source *source,
      	return !!check_and_freshen_source(source, oid, 1);
      }
      
     -int stream_loose_object(struct odb_source *source,
     -			struct input_stream *in_stream, size_t len,
     -			struct object_id *oid)
    -+int odb_loose_source_write_stream(struct odb_source *source,
    ++int odb_source_loose_write_stream(struct odb_source *source,
     +				  struct odb_write_stream *in_stream, size_t len,
     +				  struct object_id *oid)
      {
    @@ object-file.c: int odb_loose_source_freshen_object(struct odb_source *source,
      	struct object_id compat_oid;
     
      ## object-file.h ##
    -@@ object-file.h: int odb_loose_source_write_object(struct odb_source *source,
    +@@ object-file.h: int odb_source_loose_write_object(struct odb_source *source,
      				  enum object_type type, struct object_id *oid,
      				  struct object_id *compat_oid_in, unsigned flags);
      
    -+int odb_loose_source_write_stream(struct odb_source *source,
    ++int odb_source_loose_write_stream(struct odb_source *source,
     +				  struct odb_write_stream *stream, size_t len,
     +				  struct object_id *oid);
     +
    @@ odb.c: int odb_write_object_ext(struct object_database *odb,
     +			    struct odb_write_stream *stream, size_t len,
     +			    struct object_id *oid)
     +{
    -+	return odb_loose_source_write_stream(odb->sources, stream, len, oid);
    ++	return odb_source_loose_write_stream(odb->sources, stream, len, oid);
     +}
     +
      struct object_database *odb_new(struct repository *repo)

---
base-commit: c54a18ef67e59cdbcd77d6294916d42c98c62d1d
change-id: 20251017-b4-pks-odb-loose-backend-b1e003c41107

