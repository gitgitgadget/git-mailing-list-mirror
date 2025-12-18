Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EEC2E6CC5
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055268; cv=none; b=FPDJckbYEd8S9TFRI2pOSMGugPfRnRVl+UpE5Q6bugpC/e3wb540Z15Qnzkz03fKDKbUV1EnebwAcOipc/plXYi1dtQ4ImMvyZweyvhV4AsTjfat5gfYQSECccaEy6qeJD5hAkihl+t7fp+0HfYqyEnzGmfqaW1IWgbGzYvnezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055268; c=relaxed/simple;
	bh=EsnJG08+S4YBZfq/0CnxjZL4zj1Kbxp/guh+5Y81+pk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=IT1tbULCPzhhDvf5c1CW0Z/LVhA3zwfXKgSyzXQqzCIKSACN2Va52HONjN5uk2LoZb4+4A0hABuT7Oo4kPS7CvKW5O9Kwh+LDWe3KwGbYr68Ki47UuvahlqWUgXMOGyhfC836/aytXG36b6Mp5GnDXsWhsKOyxe/KlVszr+zgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hmzjHJ6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BR5+QL3J; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hmzjHJ6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BR5+QL3J"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 65B3D7A01AA;
	Thu, 18 Dec 2025 05:54:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 05:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766055263;
	 x=1766141663; bh=GF/n/Utu54kyoFsJvva6UO1j7iTbNV/atsDn52L/bhU=; b=
	hmzjHJ6VhouwshpWM769rLbvomeZpC2B2HH6JYfNpA82UDk1FbZJj9g28IiStDP8
	6MRqPcIEUZhCbnf0Zrs/1wGlHbpidh1jFoBbuAwfjgC6IdwkRhAR+qdxm1l0Flxv
	EVocGRQgmOveNtUoevcbJgSgMF5jFJXrUrSmM+WtMCFyhXKwuy+x3toNtBHW5KtX
	iHNasqDnugzN7MbhspHGHmobxwVJmET1a4YD6fNvufcrMfneAz7WiSQYcMXu3+5H
	MqaAqqXoLMznf8eQZIBlvxPG4us0/MPZMNE754pBQAUD2HXS9FCf/3aS6FVY5omx
	RWYim1nxnin7ndDzEe4rZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766055263; x=
	1766141663; bh=GF/n/Utu54kyoFsJvva6UO1j7iTbNV/atsDn52L/bhU=; b=B
	R5+QL3JH2IiWq74cFUmjR6aSQ91o72y5w+MKGPxXTM+In2yJ5F4CNvZIL0xoolbk
	B8VO5xP1M0TT5WgnD855FChp4IGpM5CyNL+V7NF9msTk8Z5E2rOBKWz02hb+aTu5
	9frRY4JtlmIDvgKLcYhBEXLHkS+7P6NsuRNUapBIgkts2kq19WSemZCLseSSlYVd
	haxqI7IW2UJ0l+xg1mWD9ZPeZFkInu73Hy4yLmCLnyl+Y5NHvAXzIAgTlrszi4jZ
	ATWtz0OrDU7FFq+pr046VrxmJ1dVvSgk3LYNCKg9PS9TR2UOQrvCZ6K1kcKX6uWQ
	6EFVX7Qfbc26chpGdOfhg==
X-ME-Sender: <xms:X91DaQyoG3YKEmrz2IlxICnzmYgYVZ4-DxzU8uuKOWA1FmtL5qeQvQ>
    <xme:X91DabtMoycpuvcNdA6d6DXGrzR-yftzkKvWyiidBcWMqBkdlB4UMGC0g2lZcCEA0
    P_EGJee_g-GriGpee56vhqi7uQ6QLjFG_lv2vbvqzj07eXcNmJakAA>
X-ME-Received: <xmr:X91Dafu1WbLfeTFkR-uQ-AhYF6ElKRCSTGwWCRwGSAJ75FJ2NrNxyJHuSkOT0vvtpZ971rB_l9rcXnKK0Bbmiv09itHsWLUM2ZbQhWzDzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:X91DaYOB4N9PxBvrwZPSXRcmCKkQHQgvmI_BfT1DCChbfz6No4t3Nw>
    <xmx:X91DaV1SGHAEQNndnpETSvdgMYrbkyKAPcOAIoKmlETK4hSjvk7fzw>
    <xmx:X91DacMgqDIkdT6DwitjMrd9wTCZ0H45wnKd3Ajn_QIuJsrkLok-2A>
    <xmx:X91Dad0unFrsuIISQW12g2hpBOb9zRTEHZ0qoONMqJ54ZHnQR4Ts7Q>
    <xmx:X91DaV3b6zKCcr1JpG68K9k0V8hyZcEHFH2HQIfBA0n9mmwOKn4epCvs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 05:54:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1435eb65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 10:54:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] Improvements for reading object info
Date: Thu, 18 Dec 2025 11:54:12 +0100
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFTdQ2kC/43NQQ6CMBCF4auQrh3TDqCVlfcwLCgdZDS0pCWNh
 nB3K4l7l/8k875VRApMUTTFKgIljuxdDjwUoh87dydgm1ugxFqhqsFUMD8jeGsgUGfBmwf1C7A
 bPPA0B59oIrdEkCRLRYPGs0WR5+ZAA7926tbmHjkuPrx3Oanv9Yfo/5GkQIJWvS5PurqgoWv+O
 /Ik2m3bPmpZPyndAAAA
X-Change-ID: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains various small improvements for reading object
info for either loose or packed objects. These improvements were split
out of a larger patch series where I'm about to introduce a new generic
`odb_for_each_object()` function.

Changes in v2:
  - Rebase the series on top of master with jc/object-read-stream-fix
    merged into it. I've also evicted the patch that fixes the same
    underlying issue.
  - Improve the commit message that drops OI_DBCACHED to explain why
    this is a safe refactoring.
  - Link to v1: https://lore.kernel.org/r/20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      object-file: always set OI_LOOSE when reading object info
      packfile: always declare object info to be OI_PACKED
      packfile: extend `is_delta` field to allow for "unknown" state
      packfile: always populate pack-specific info when reading object info
      packfile: disentangle return value of `packed_object_info()`
      packfile: skip unpacking object header for disk size requests
      packfile: drop repository parameter from `packed_object_info()`

 builtin/cat-file.c     |  3 +--
 builtin/pack-objects.c |  4 ++--
 commit-graph.c         |  2 +-
 object-file.c          | 19 ++++++++++++----
 odb.h                  |  8 +++++--
 pack-bitmap.c          |  3 +--
 packfile.c             | 61 ++++++++++++++++++++++++++++++--------------------
 packfile.h             |  7 ++++--
 8 files changed, 68 insertions(+), 39 deletions(-)

Range-diff versus v1:

1:  0c1a4a4745 < -:  ---------- object-file: always set OI_LOOSE when reading object info
-:  ---------- > 1:  2287c0cbd9 object-file: always set OI_LOOSE when reading object info
2:  98962428cf ! 2:  a1cd99af9c packfile: always declare object info to be OI_PACKED
    @@ Commit message
         between OI_PACKED and OI_DBCACHED only further complicates the
         interface.
     
    -    Drop the OI_DBCACHED enum completely. There don't seem to be any callers
    -    that care about the distinction.
    +    There aren't all that many callers that care about the `whence` field in
    +    the first place. In fact, there's only three:
    +
    +      - `packfile_store_read_object_info()` checks for `whence == OI_PACKED`
    +        and then populates the packfile information of the object info
    +        structure. We now start to do this also for deltified objects, which
    +        gives its callers strictly more information.
    +
    +      - `repack_local_links()` wants to determine whether the object is part
    +        of a promisor pack and checks for `whence == OI_PACKED`. If so, it
    +        verifies that the packfile is a promisor pack. It's arguably wrong
    +        to declare that an object is not part of a promisor pack only
    +        because it is stored in the delta base cache.
    +
    +      - `is_not_in_promisor_pack_obj()` does the same, but checks that a
    +        specific object is _not_ part of a promisor pack. The same reasoning
    +        as above applies.
    +
    +    Drop the OI_DBCACHED enum completely. None of the callers seem to care
    +    about the distinction.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
3:  0a5b806934 = 3:  7a043c09ee packfile: extend `is_delta` field to allow for "unknown" state
4:  6a05c85683 ! 4:  448511cb19 packfile: always populate pack-specific info when reading object info
    @@ Metadata
      ## Commit message ##
         packfile: always populate pack-specific info when reading object info
     
    -    When reading object information from a packfile we are not always
    -    populating the pack-specific information. This happens in two cases:
    +    When reading object information via `packed_object_info()` we may not
    +    populate the object info's packfile-specific fields. This leads to
    +    inconsistent object info depending on whether the info was populated via
    +    `packfile_store_read_object_info()` or `packed_object_info()`.
     
    -      - When calling `packed_object_info()` directly instead of
    -        `packfile_store_read_object_info()`.
    -
    -      - When we've got the empty request.
    -
    -    Fix both of these issues so that we can always assume the pack info to
    -    be populated when reading object info from a pack.
    -
    -    Note that we don't really care about the second case right now, as the
    -    condition will always evaluate to false anyway. This will be fixed in
    -    the next commit.
    +    Fix this inconsistecny so that we can always assume the pack info to be
    +    populated when reading object info from a pack.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      
      out:
      	unuse_pack(&w_curs);
    -@@ packfile.c: int packfile_store_read_object_info(struct packfile_store *store,
    - 	 * We know that the caller doesn't actually need the
    - 	 * information below, so return early.
    - 	 */
    --	if (oi == &blank_oi)
    -+	if (oi == &blank_oi) {
    -+		oi->whence = OI_PACKED;
    -+		oi->u.packed.offset = e.offset;
    -+		oi->u.packed.pack = e.p;
    -+		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
    - 		return 0;
    -+	}
    - 
    - 	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
    - 	if (rtype < 0) {
     @@ packfile.c: int packfile_store_read_object_info(struct packfile_store *store,
      		return -1;
      	}
5:  b09f37400c ! 5:  e1ee6c7841 packfile: disentangle return value of `packed_object_info()`
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      
      static void *unpack_compressed_entry(struct packed_git *p,
     @@ packfile.c: int packfile_store_read_object_info(struct packfile_store *store,
    + 				    unsigned flags UNUSED)
      {
    - 	static struct object_info blank_oi = OBJECT_INFO_INIT;
      	struct pack_entry e;
     -	int rtype;
     +	int ret;
    @@ packfile.c: int packfile_store_read_object_info(struct packfile_store *store,
      	if (!find_pack_entry(store->odb->repo, oid, &e))
      		return 1;
     @@ packfile.c: int packfile_store_read_object_info(struct packfile_store *store,
    + 	if (!oi)
      		return 0;
    - 	}
      
     -	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
     -	if (rtype < 0) {
6:  253c0d47ab = 6:  77589e84b5 packfile: skip unpacking object header for disk size requests
7:  4dac51d4be < -:  ---------- packfile: fix short-circuiting of empty requests
8:  2cf441de0d ! 7:  08f4b865e5 packfile: drop repository parameter from `packed_object_info()`
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      		if (oi->typep)
      			*oi->typep = ptot;
     @@ packfile.c: int packfile_store_read_object_info(struct packfile_store *store,
    + 	if (!oi)
      		return 0;
    - 	}
      
     -	ret = packed_object_info(store->odb->repo, e.p, e.offset, oi);
     +	ret = packed_object_info(e.p, e.offset, oi);

---
base-commit: 7df68b50e49b6a1b576abb19b2e5d457749bc28b
change-id: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2

