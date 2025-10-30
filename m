Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326433890A
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820730; cv=none; b=TcRUgDxUp6dgfQ3MrbzIkZ6TU04VY/J16CbVhT6wcwt0emkktJa4EtGjWE9Utf5/iWBjOUg0HSxX/MHvGK6xdG2MXAQ0AFBc3ZXgvoVgzu/VRyvg2qbnKtYD/Pr6PK/vRtObkUvOL3ldfD+YtIS5/bk04rAFB3UNrSxqfpoNZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820730; c=relaxed/simple;
	bh=gzD7IOBWvmwikc+eZN1FTIJkEtq4QsYmJA3R7F6kY4A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=L4K95ou8iJGws1BwBLm2aCz2vBPCK0F5bxHjFDf8mPcIngP0hBJtUkksXf8YjnWO2u9Gmm5+trmYW1/NeEZtDmYcmMgxqyiepzamQhIdYA1t2K+AGQOEPjU4Cmdxyem5rdnaT7q6HLyppLubvLTU31x/s2uj/2BOSFBYi7KeaUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rewsy8ig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIOw8DmH; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rewsy8ig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIOw8DmH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id A053F1380045;
	Thu, 30 Oct 2025 06:38:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 06:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820726;
	 x=1761827926; bh=2uiv86+aFMZgxPFMu+Anehb+Hx74OLEDwnB31LxbyXM=; b=
	Rewsy8ig5KwfMTh3P9iRGTkPwdz8ycsoFdIKoe/GCkk9JVbjy21THhDkSOZReIJm
	ZQ57S2+v1U2XrU+cuWrbHKoKwGJ0kkLRTn4EGFKcPQCghpcrPCAlx8p63oGyP6Xa
	Hqh5Fyu2sQXj+nEWlu10J+nSp6JI0L7mSIYa0OgmSiNus3MlX+65EPdp3Ft9Ifzy
	rZQ/ejLUuDyAKilHpFcSaE0KXc1D4h+ebs3SNqsvudi1UVDP/hIR1mfzRELEIEsn
	ao7oOFP5oe377+mtiD4R/vf2UfQGe3jf3I57VP+X+836ma4Wf4HCW1Pj5/vIWwFY
	knzC31uzGmMTrNREws9+FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820726; x=
	1761827926; bh=2uiv86+aFMZgxPFMu+Anehb+Hx74OLEDwnB31LxbyXM=; b=J
	IOw8DmHO+chJTZ9b76Wo4xcs5nJuTF40Jz431fc8djo2l8iHgGFONk15E6xjj+qB
	EOwQgL+eLwoXaBOgaFoEwDUml+Iw11y8OEr6V0q6fRm9mRr1830mduxOuYVDruXI
	xR2FyRdYDeSK6LgNr0QL4DMwQRDpypkwSy390dy0qLnzha7JMvUh3u7LBkyMkdYR
	zSOKvtJkSLzYkhfjzcLqqQC+QxL0s4eT4pMiMwWEzPGInihhfFpqkRYi8vvEvZ4f
	3Ko1ZX6of14v0+o2T6yMsyvSaWkbUuUkb2IvKRBpfNc91FHzekIZlovpYytRRZ9w
	m6mlJRZ+zackKMZWICKPg==
X-ME-Sender: <xms:NUADaQ0EY7hX4KD8mHM6pLwL_Gq9jfwxuVoUKmjWCM8Tt78y1C85WA>
    <xme:NUADaSEo99xMwGQhrrPE8t_Zi6W_IL-VxjB0yfmwtFbXFnrCFwcc-NB-IESW8CYYt
    yDGqG-SD2k6wxkWQBDH85mwvVRj8yOrlbuD2nDrdCF8YDKbliZz>
X-ME-Received: <xmr:NUADad7Jny0sEHEQHYw6D5FA0oMzUbBmvYdirP6CLxDff01WxwKPZLYq_NivrZDV4LSsBLbPbOuie4Vgaa567uh6I-OKt04PeRFySI_iwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeevffdtledvleegteehhfefgffgudffieehudeguedvieelveduieegjefgjeei
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgtrgguughsthhhvghfvghttghhvg
    guphgrtghkthhothhhvghsthhorhgvshhothhhrghtfigvtggrnhgrtggtvghsshhithhs
    ohgsjhgvtghtshdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NUADaYt1LnIYNxdLmAkFwvjB52bv8XSHn-uXLFHOqhUn_OU105TO0A>
    <xmx:NkADae4jyO54987YfdOjPnaoV1lbyqCM13GnXwG5lHlW896ABqVkgw>
    <xmx:NkADaTVufU2amNSPszQxF1rQqO1qbysrvlRpEQrnDAlBsPtFn4PTcw>
    <xmx:NkADaQ-eMsY1KbRSQGU3Lba5o1JGT8ILxQ5vO6IBmuGYmOW4ef3XUQ>
    <xmx:NkADaY0koqHAkMTwJN66K08kl_CMpeydkzoMrkoiC6OJmqtN7il7_cdL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:38:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7cc57100 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:38:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] packfiles: track pack lists via the packfile store
Date: Thu, 30 Oct 2025 11:38:37 +0100
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1AA2kC/4XNwQ6CMAyA4VchPVvTDVTk5HsYDhOKNCAsKyEaw
 rs7iHePf9N+XUA5CCsUyQKBZ1EZhxj2kEDVuuHJKHVssGRPhgyh7xS9q7pGelbUaQyMdRg99qI
 TnjN25LLq6tIHRMMHbuS9+/cydivbxWd/N5tt+pNt/keeDRKayOaWUnIXd4v7R3lBua7rF4Q0Y
 n3HAAAA
X-Change-ID: 20251010-pks-packfiles-store-drop-list-64ea0a4c9a3b
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

Hi,

while the recently-introduced packfile store tracks the head of the pack
lists, the actual lists themselves are still stored in a globally linked
list via the `struct packed_git::next` pointer. This makes it quite hard
to split up that list into per-object-source lists, as the assumption is
embedded in many places that one packfile will identify all the others.

This patch series thus moves the ownership of the lists into the
packfile store. This prepares us for a subsequent change where we can
push the packfile store one level down, from the object database into
the object source. So this is the second-last series before I'm done
refactoring the packfile subsystem.

Note: I'd like to have some extra careful eyes on the last patch. This
patch merges the two packfile lists we currently have (MRU and
mtime-sorted). It is not needed to achieve my goal in this series, but
there was some discussion around whether we really need both lists. I
don't think we do, and in fact I think it causes confusion which of
these one should really use.

The default is to use the mtime-sorted list, which I think is the wrong
choice in many cases, but that is only by gut feeling. So I'm dropping
that list in favor of the MRU list, but there is one gotcha here: when
iterating through packfiles and then reading their respective objects,
we end up in an infinite loop because we end up moving the respective
packfile to the front of the list again. I'm fixing that with a new
field that skips the MRU update, but I'm not quite sure wheter I think
that this is too fragile or not.

The series is built on top of 419c72cb8a (Sync with Git 2.51.2,
2025-10-26) with ps/remove-packfile-store-get-packs at ecad863c12
(packfile: rename `packfile_store_get_all_packs()`, 2025-10-09) merged
into it.

Changes in v2:
  - A couple of commit message typo fixes.
  - Avoid opening the pack index in `repo_approximate_object_count()` in
    case we don't want to access the packfile in the first place.
  - Further simplifications for `has_sha1_pack_kept_or_nonlocal()`.
    Also, fix how we skip over the last-found pack.
  - Completely reword the motivation why we unconditionally start to add
    packfiles to the MRU list.
  - Link to v1: https://lore.kernel.org/r/20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      packfile: use a `strmap` to store packs by name
      packfile: move the MRU list into the packfile store
      http: refactor subsystem to use `packfile_list`s
      packfile: fix approximation of object counts
      builtin/pack-objects: simplify logic to find kept or nonlocal objects
      packfile: move list of packs into the packfile store
      packfile: always add packfiles to MRU when adding a pack
      packfile: track packs via the MRU list exclusively

 builtin/fast-import.c  |   4 +-
 builtin/pack-objects.c |  37 ++++----
 http-push.c            |   6 +-
 http-walker.c          |  26 ++----
 http.c                 |  21 ++---
 http.h                 |   5 +-
 midx.c                 |   2 -
 packfile.c             | 224 +++++++++++++++++++++++++++++--------------------
 packfile.h             |  70 ++++++++++------
 9 files changed, 223 insertions(+), 172 deletions(-)

Range-diff versus v1:

1:  49bc9f8c9aa = 1:  56660c77d40 packfile: use a `strmap` to store packs by name
2:  4cea16b704e ! 2:  d2e003b44ca packfile: move the MRU list into the packfile store
    @@ Commit message
         object. Consequently, we need to break up the global lists of packfiles
         into per-object-source lists.
     
    -    A first step towards this goal is to move those lists ouf of `struct
    +    A first step towards this goal is to move those lists out of `struct
         packed_git` and into the packfile store. While the packfile store is
         currently sitting on the `struct object_database` level, the intent is
         to push it down one level into the `struct odb_source` in a subsequent
3:  140fc5add46 = 3:  9523423446d http: refactor subsystem to use `packfile_list`s
4:  3a0a29e80de ! 4:  3be216ddfb5 packfile: fix approximation of object counts
    @@ packfile.c: unsigned long repo_approximate_object_count(struct repository *r)
     -		for (p = r->objects->packfiles->packs; p; p = p->next) {
     -			if (open_pack_index(p))
     +		repo_for_each_pack(r, p) {
    -+			if (open_pack_index(p) || p->multi_pack_index)
    ++			if (p->multi_pack_index || open_pack_index(p))
      				continue;
      			count += p->num_objects;
      		}
5:  324d3d29234 ! 5:  867c1d5315a builtin/pack-objects: simplify logic to find kept or nonlocal objects
    @@ Commit message
         check whether the pack contains the object ID, and to skip the cached
         pack in the loop so that we don't search it twice.
     
    +    Furthermore, stop using the `(void *)1` sentinel value and instead use a
    +    simple `NULL` pointer to indicate that we don't have a last-found pack
    +    yet.
    +
         This refactoring significantly simplifies the logic and makes it much
         easier to follow.
     
    @@ builtin/pack-objects.c: static void add_unreachable_loose_objects(struct rev_inf
      static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
      {
     -	struct packfile_store *packs = the_repository->objects->packfiles;
    - 	static struct packed_git *last_found = (void *)1;
    +-	static struct packed_git *last_found = (void *)1;
    ++	static struct packed_git *last_found = NULL;
      	struct packed_git *p;
      
     -	p = (last_found != (void *)1) ? last_found :
     -					packfile_store_get_packs(packs);
    -+	if (last_found != (void *)1 && find_pack_entry_one(oid, last_found))
    ++	if (last_found && find_pack_entry_one(oid, last_found))
     +		return 1;
      
     -	while (p) {
    @@ builtin/pack-objects.c: static void add_unreachable_loose_objects(struct rev_inf
     -				p->pack_keep_in_core) &&
     -			find_pack_entry_one(oid, p)) {
     +	repo_for_each_pack(the_repository, p) {
    ++		/*
    ++		 * We have already checked `last_found`, so there is no need to
    ++		 * re-check here.
    ++		 */
    ++		if (p == last_found)
    ++			continue;
    ++
     +		if ((!p->pack_local || p->pack_keep || p->pack_keep_in_core) &&
     +		    find_pack_entry_one(oid, p)) {
      			last_found = p;
    @@ builtin/pack-objects.c: static void add_unreachable_loose_objects(struct rev_inf
     -			p = p->next;
     -		if (p == last_found)
     -			p = p->next;
    -+
    -+		/*
    -+		 * We have already checked `last_found`, so there is no need to
    -+		 * re-check here.
    -+		 */
    -+		if (p == last_found && last_found != (void *)1)
    -+			continue;
      	}
     +
      	return 0;
6:  92c7d5ab273 = 6:  21dd33b22ef packfile: move list of packs into the packfile store
7:  df86cc9f650 ! 7:  1bf0880cce8 packfile: always add packfiles to MRU when adding a pack
    @@ Metadata
      ## Commit message ##
         packfile: always add packfiles to MRU when adding a pack
     
    -    When adding a packfile to it store we add it both to the list and map of
    -    packfiles, but we don't append it to the most-recently-used list of
    -    packs. We do know to add the packfile to the MRU list as soon as we
    -    access any of its objects, but in between we're being inconistent. It
    -    doesn't help that there are some subsystems that _do_ add the packfile
    -    to the MRU after having added it, which only adds to the confusion.
    +    When preparing the packfile store we know to also prepare the MRU list
    +    of packfiles with all packs that are currently loaded in the store via
    +    `packfile_store_prepare_mru()`. So we know that the list of packs in the
    +    MRU list should match the list of packs in the non-MRU list.
    +
    +    But there are some direct or indirect callsites that add a packfile to
    +    the store via `packfile_store_add_pack()` without adding the pack to the
    +    MRU. And while functions that access the MRU (e.g. `find_pack_entry()`)
    +    know to call `packfile_store_prepare()`, which knows to prepare the MRU
    +    via `packfile_store_prepare_mru()`, that operation will be turned into a
    +    no-op because the packfile store is already prepared. So this will not
    +    cause us to add the packfile to the MRU, and consequently we won't be
    +    able to find the packfile in our MRU list.
    +
    +    There are only a handful of callers outside of "packfile.c" that add a
    +    packfile to the store:
    +
    +      - "builtin/fast-import.c" adds multiple packs of imported objects, but
    +        it knows to look up objects via `packfile_store_get_packs()`. This
    +        function does not use the MRU, so we're good.
    +
    +      - "builtin/index-pack.c" adds the indexed pack to the store in case it
    +        needs to perform consistency checks on its objects.
    +
    +      - "http.c" adds the fetched pack to the store so that we can access
    +        its objects.
    +
    +    In all of these cases we actually want to access the contained objects.
    +    And luckily, reading these objects works as expected:
    +
    +      1. We eventually end up in `do_oid_object_info_extended()`.
    +
    +      2. Calling `find_pack_entry()` fails because the MRU list doesn't
    +         contain the newly added packfile.
    +
    +      3. The callers don't pass `OBJECT_INFO_QUICK`, so we end up
    +         repreparing the object database. This will also cause us to
    +         reprepare the MRU list.
    +
    +      4. We now retry reading the object via `find_pack_entry()`, and now we
    +         succeed because the MRU list got populated.
    +
    +    This logic feels quite fragile: we intentionally add the packfile to the
    +    store, but we then ultimately rely on repreparing the entire store only
    +    to make the packfile accessible. While we do the correct thing in
    +    `do_oid_object_info_extended()`, other sites that access the MRU may not
    +    know to reprepare.
    +
    +    But besides being fragile it's also a waste of resources: repreparing
    +    the object database requires us to re-read the alternates file and
    +    discard any caches.
     
         Refactor the code so that we unconditionally add packfiles to the MRU
    -    when adding them to a packfile store.
    +    when adding them to a packfile store. This makes the logic less fragile
    +    and ensures that we don't have to reprepare the store to make the pack
    +    accessible.
     
         Note that this does not allow us to drop `packfile_store_prepare_mru()`
         just yet: while the MRU list is already populated with all packs now,
8:  cc9d35a4b09 = 8:  64571e61fac packfile: track packs via the MRU list exclusively

---
base-commit: cad6ef1d7514e7450c04c2fe624a55b28d99ac88
change-id: 20251010-pks-packfiles-store-drop-list-64ea0a4c9a3b

