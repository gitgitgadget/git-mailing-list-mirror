Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC230E0D5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862419; cv=none; b=qaoYZH2bKBxA+MNkhQDIVesLtdk7nd1yvu4glUO5RDpbxbxBp+o9RUn3upeMaFdQYBBaA9X7rmK5LcLqIw++l4hiYfvzkW5/GgHDiapesPsYBCzvkQsMlmNseA2kr0fdUukIW5sBoATMSL5INUdmE67DsZoIDCM40w9UKPPNv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862419; c=relaxed/simple;
	bh=tdWmuLAkDtv3rlqMetPrwMvtDwiJwUfYhJ6Flv3YXDA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=bRK1tJvJ55MFiGXEkhfblFk+4vRPYXOKi66QIz5SUXvWWeQ7vYuUYujgIYUy1YNH/n+AOgFe/0GFzDrOvo0OO6SVoo6pSBBOEAQoWTyF4/zsmrhIQlP3eI9dhUOxuq/jcb8em3uZ9Z37lleEBeSZFu03iwirnKSyr93KdBCLgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bKx/S2Ld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hdoQMXvn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bKx/S2Ld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdoQMXvn"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9040214001BB;
	Mon, 23 Feb 2026 11:00:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 23 Feb 2026 11:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771862417;
	 x=1771948817; bh=+bFSodJnlHTZJStVfSS8kkdDndAvl72NsvhcTyVdZeg=; b=
	bKx/S2LdXQcexHI6h96IoE7SmWYeMM1cZUg4M641j1M4pihjyzDMkT/M+Igzke5Z
	73pvFJKtArhCGys7XnF+Lnx2uJ1HEYW0c97/AnLmgLWkIjJkS/RO3e2tlnhGzt3M
	ogMHnFJKwMeYXgaMCfxRN7doBxMTT8HfKW38tjsKhYIICY/njyAbnzv6POijiuIb
	UDzb/Qx2Iv9IPOL+cyQXYe2jAuyzWFiqUDqVtRkQlygzIN//enHBBiYkI5t7eG+7
	dlUgH70dKHeH6bOskXDnOOwXL2goYdlgR9tWsQEwUsJ1qt/ntjcVRkQcfj2nX/14
	nsfRq3a7cRaLJbcVXKUwIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771862417; x=
	1771948817; bh=+bFSodJnlHTZJStVfSS8kkdDndAvl72NsvhcTyVdZeg=; b=h
	doQMXvnNrBzop4O2RiGhv32a8kgSXR5eb2QjHkWEE6PuLLowvDlF2sv6Km3A+eY9
	juoEb9o7Rsk6Z/zGLY35T6xvkBTy0V5UE3g8GwF1MqMDmT/qoEMqzwgvvdnhsWOI
	+qoqrPDePQKgSNt8iCXnVJqQKUNZqebjRQibVYx3W10DBA6mGUOOohLO/cOazxTH
	Y5MsyWDT61pYtyI9IP3TG/vpmFk+qXqn0Tu2INtXqPEjZVtmN1KoqDsa2S7C3T4n
	mJUMv3LoVL9nK1hM+ANEXglj6mLjV8aP3DdUX+rE/oA5M2Muynm8L4AopO9x8LZr
	MBKg6m6zV4wRU45mmEEkQ==
X-ME-Sender: <xms:kXmcadnwNZeNSAQZ7ten61z7Fzmrcqvoh4TVWxXrqwS6gVErPCUmQQ>
    <xme:kXmcaftokyltqmBbe6rfAk7pZF57q6QP-vP9raNBnG8FlQ8s0mwK8-WX_0Cvd9IS6
    zJld_Bi7544v0HTLeoL4NWfotDRCuvyuE6lF52D9F-C5wcMdZatBg>
X-ME-Received: <xmr:kXmcab_Hiziwlz-2V5jT1GJ73tmPGXhQ5zczeho-3jUwSk-AOhVIdRya9syPfHRdEAb0xvNeSlJXOo4rWhQuo0zsfUAElKcFk3ZffGsGpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:kXmcaZPQrvSQAUYW2h8xWJNq_SNeVa5IEhK2nUH1-WaAabg7CMvR-Q>
    <xmx:kXmcaZGdbDT8IRweJzBnAP4ll7iMzrAXlNeQKWSTfxDjKprLQ07T5w>
    <xmx:kXmcaXS2d-sNjV7JoRHUiTHH2HR4JvPyfJ6xN5eZcHvIWqIgMldJXQ>
    <xmx:kXmcaWsvDvElED1TKDhr1Zok1PB0VN7b67UouBcfVgCWXduxM3hF9g>
    <xmx:kXmcafXDaulQD3EwxnBecY1BCEh2k1tHMnLszZuUErMhMO7AGvsiawVy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:00:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 964c7f78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 16:00:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] pack-check: fix verification of large objects
Date: Mon, 23 Feb 2026 17:00:05 +0100
Message-Id: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIV5nGkC/3WMQQrCMBBFr1Jm7UgygRBdeQ/pIsbUDsW2ZCQoJ
 Xd37N7le5//NpBcOAucuw1Kriy8zAp06CCNcX5k5LsykCFviByuk+AgacKB3xhjiDZE9SmAXta
 SVe+5a688sryW8tnr1f7sn1C1aDDRyTgfHN18vuh85Cf0rbUvi0nXo6UAAAA=
X-Change-ID: 20260223-pks-fsck-fix-aa8a18a223c8
In-Reply-To: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.3

Hi,

this small patch series addresses the bug reported by brian in [1].
Thanks!

Changes in v2:
  - Extend the test to verify that we actually find corrupted objects in
    both packs, even in the case where a non-corrupt version exists in
    another pack.
  - Reinstate `mark_packed_object_bad()`.
  - Fix error checking for `git_parse_ulong()`.
  - Disambiguate error conditions in `parse_object_with_flags()`.
  - Link to v1: https://lore.kernel.org/r/20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im

Patrick

[1]: <20260222183710.2963424-1-sandals@crustytoothpaste.net>

---
Patrick Steinhardt (4):
      t/helper: improve "genrandom" test helper
      object-file: adapt `stream_object_signature()` to take a stream
      packfile: expose function to read object stream for an offset
      pack-check: fix verification of large objects

 object-file.c                         | 10 +++------
 object-file.h                         |  4 +++-
 object.c                              | 19 ++++++++++++++---
 pack-check.c                          | 12 ++++++++---
 packfile.c                            | 40 +++++++++++++++++++++--------------
 packfile.h                            |  5 +++++
 t/helper/test-genrandom.c             |  5 ++++-
 t/t1006-cat-file.sh                   |  2 +-
 t/t1050-large.sh                      |  6 +++---
 t/t1450-fsck.sh                       | 40 ++++++++++++++++++++++++++++++++++-
 t/t5301-sliding-window.sh             |  2 +-
 t/t5310-pack-bitmaps.sh               |  2 +-
 t/t5710-promisor-remote-capability.sh |  4 ++--
 t/t7700-repack.sh                     |  6 +++---
 14 files changed, 114 insertions(+), 43 deletions(-)

Range-diff versus v1:

1:  1b1283e837 ! 1:  daf895aef6 t/helper: improve "genrandom" test helper
    @@ Commit message
             have to precompute them.
     
         Fix both of these issues by using `git_parse_ulong()` to parse the
    -    argumemnt. This function has better error handling, and it knows to
    +    argument. This function has better error handling, and it knows to
         handle unit suffixes.
     
         Adapt a couple of our tests to use suffixes instead of manual
    @@ t/helper/test-genrandom.c: int cmd__genrandom(int argc, const char **argv)
      
     -	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : ULONG_MAX;
     +	count = ULONG_MAX;
    -+	if (argc == 3 && git_parse_ulong(argv[2], &count) < 0)
    ++	if (argc == 3 && !git_parse_ulong(argv[2], &count))
     +		return error_errno("cannot parse argument '%s'", argv[2]);
      
      	while (count--) {
2:  9f25ed1a4b ! 2:  ebca9efaec object-file: adapt `stream_object_signature()` to take a stream
    @@ Commit message
         a preconstructed stream. Prepare for this by accepting a stream as input
         that the caller needs to assemble.
     
    +    While at it, improve the error reporting in `parse_object_with_flags()`
    +    to tell apart the two failure modes.
    +
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## object-file.c ##
    @@ object.c: struct object *parse_object_with_flags(struct repository *r,
     -			return NULL;
     +		if (!skip_hash) {
     +			struct odb_read_stream *stream = odb_read_stream_open(r->objects, oid, NULL);
    -+			if (!stream || stream_object_signature(r, stream, repl) < 0) {
    -+				error(_("hash mismatch %s"), oid_to_hex(oid));
    -+				if (stream)
    -+					odb_read_stream_close(stream);
    ++
    ++			if (!stream) {
    ++				error(_("unable to open object stream for %s"), oid_to_hex(oid));
     +				return NULL;
     +			}
     +
    -+			if (stream)
    ++			if (stream_object_signature(r, stream, repl) < 0) {
    ++				error(_("hash mismatch %s"), oid_to_hex(oid));
     +				odb_read_stream_close(stream);
    ++				return NULL;
    ++			}
    ++
    ++			odb_read_stream_close(stream);
      		}
      		parse_blob_buffer(lookup_blob(r, oid));
      		return lookup_object(r, oid);
3:  9a28867564 ! 3:  bead96797e packfile: expose function to read object stream for an offset
    @@ packfile.c: static int close_istream_pack_non_delta(struct odb_read_stream *_st)
     -				      struct packfile_store *store,
     -				      const struct object_id *oid)
     +int packfile_read_object_stream(struct odb_read_stream **out,
    ++				const struct object_id *oid,
     +				struct packed_git *pack,
     +				off_t offset)
      {
    @@ packfile.c: static int close_istream_pack_non_delta(struct odb_read_stream *_st)
      	switch (in_pack_type) {
      	default:
      		return -1; /* we do not do deltas for now */
    ++	case OBJ_BAD:
    ++		mark_bad_packed_object(pack, oid);
    ++		return -1;
    + 	case OBJ_COMMIT:
    + 	case OBJ_TREE:
    + 	case OBJ_BLOB:
     @@ packfile.c: int packfile_store_read_object_stream(struct odb_read_stream **out,
      	stream->base.type = in_pack_type;
      	stream->base.size = size;
    @@ packfile.c: int packfile_store_read_object_stream(struct odb_read_stream **out,
     +	if (!find_pack_entry(store, oid, &e))
     +		return -1;
     +
    -+	return packfile_read_object_stream(out, e.p, e.offset);
    ++	return packfile_read_object_stream(out, oid, e.p, e.offset);
     +}
     
      ## packfile.h ##
    @@ packfile.h: off_t get_delta_base(struct packed_git *p, struct pack_window **w_cu
      		     off_t delta_obj_offset);
      
     +int packfile_read_object_stream(struct odb_read_stream **out,
    ++				const struct object_id *oid,
     +				struct packed_git *pack,
     +				off_t offset);
     +
4:  4eaf958e57 ! 4:  6b69624d81 pack-check: fix verification of large objects
    @@ pack-check.c: static int verify_packfile(struct repository *r,
      				    oid_to_hex(&oid), p->pack_name);
      		else if (!data &&
     -			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
    -+			 (packfile_read_object_stream(&stream, p, entries[i].offset) < 0 ||
    ++			 (packfile_read_object_stream(&stream, &oid, p, entries[i].offset) < 0 ||
      			  stream_object_signature(r, stream, &oid) < 0))
      			err = error("packed %s from %s is corrupt",
      				    oid_to_hex(&oid), p->pack_name);
    @@ t/t1450-fsck.sh: test_expect_success 'fsck errors in packed objects' '
     +	git init repo &&
     +	(
     +		cd repo &&
    ++
    ++		# We construct two packfiles with two objects in common and one
    ++		# object not in common. The objects in common can then be
    ++		# corrupted in one of the packfiles, respectively. The other
    ++		# objects that are unique to the packs are merely used to not
    ++		# have both packs contain the same data.
     +		blob_one=$(test-tool genrandom one 200k | git hash-object -t blob -w --stdin) &&
     +		blob_two=$(test-tool genrandom two 200k | git hash-object -t blob -w --stdin) &&
    -+		printf "%s\n" "$blob_one" | git pack-objects .git/objects/pack/pack &&
    -+		printf "%s\n" "$blob_two" | git pack-objects .git/objects/pack/pack &&
    -+		remove_object "$blob_one" &&
    -+		remove_object "$blob_two" &&
    -+		git -c core.bigFileThreshold=100k fsck
    ++		blob_three=$(test-tool genrandom three 200k | git hash-object -t blob -w --stdin) &&
    ++		blob_four=$(test-tool genrandom four 200k | git hash-object -t blob -w --stdin) &&
    ++		pack_one=$(printf "%s\n" "$blob_one" "$blob_two" "$blob_three" | git pack-objects .git/objects/pack/pack) &&
    ++		pack_two=$(printf "%s\n" "$blob_two" "$blob_three" "$blob_four" | git pack-objects .git/objects/pack/pack) &&
    ++		chmod a+w .git/objects/pack/pack-*.pack &&
    ++
    ++		# Corrupt blob two in the first pack.
    ++		git verify-pack -v .git/objects/pack/pack-$pack_one >objects &&
    ++		offset_one=$(sed <objects -n "s/^$blob_two .* \(.*\)$/\1/p") &&
    ++		printf "\0" | dd of=.git/objects/pack/pack-$pack_one.pack bs=1 conv=notrunc seek=$offset_one &&
    ++
    ++		# Corrupt blob three in the second pack.
    ++		git verify-pack -v .git/objects/pack/pack-$pack_two >objects &&
    ++		offset_two=$(sed <objects -n "s/^$blob_three .* \(.*\)$/\1/p") &&
    ++		printf "\0" | dd of=.git/objects/pack/pack-$pack_two.pack bs=1 conv=notrunc seek=$offset_two &&
    ++
    ++		# We now expect to see two failures for the corrupted objects,
    ++		# even though they exist in a non-corrupted form in the
    ++		# respective other pack.
    ++		test_must_fail git -c core.bigFileThreshold=100k fsck 2>err &&
    ++		test_grep "unknown object type 0 at offset $offset_one in .git/objects/pack/pack-$pack_one.pack" err &&
    ++		test_grep "unknown object type 0 at offset $offset_two in .git/objects/pack/pack-$pack_two.pack" err
     +	)
     +'
     +

---
base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
change-id: 20260223-pks-fsck-fix-aa8a18a223c8

