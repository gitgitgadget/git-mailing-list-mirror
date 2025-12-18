Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364A287247
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040929; cv=none; b=AJ1mrEHRKH5ZeXH2RZOhdOXJ36mlD44LtlAuFgbHmhPUSV+ZA9H8HttfO4Q2bBHG82+hEpveFBvcCgb2nDNrM4YUzUiPSV996fZsMrdgTD/te0z7DT5kud1DkqKgYqLtjtM9YL/TuRv4kg08bnYThuMDk4BRfXM1LhPbOKdpbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040929; c=relaxed/simple;
	bh=+d0eVbOgXnGQhnEtqS5X9QlLTG5kM3+zlDVTwCOwrFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=IgSxrXnsIdjOrXx+LT4Ss8ut4Ji6JGpSWvjgS+vyAdSdXoraDEH1qaIIls3N6MkPSHckv9EoUVandO2nb/XjCScjLHAC1sdHPlgsfwZWd0ibvw04bSquwnpBYs/ZKRIDABFiim4PLd/l66/ZY6UkZhTkZkDgxf/HTTU4JKy9DqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TUimBGpx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HB/uk6Nl; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TUimBGpx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HB/uk6Nl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 7F5FF1300B8A;
	Thu, 18 Dec 2025 01:55:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 18 Dec 2025 01:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040926;
	 x=1766048126; bh=HcY9ZMgVogkg8j9SKqow0aTuShYhvCopn4OJYq336/s=; b=
	TUimBGpxvNDGWx3fNFSXGc0PKoDf+ZdqNug+Px2Tm1yPzJUqwLY8KPcUKxzu4eSk
	F4cH2wAvk34FtZqmt21WDHxbkMgcIno1Fi1ayda87LuZQ1R7vyWzetrgwttoNT+r
	i4Ft79wAin4KIVoNdzgA6jDBfUkYEgMa0rd5fRfcva5ckqnMp+v54XjrtEwm3XyC
	AKWJkCv88XQr4DFJND1eeCMBzezKTFtH4Xu6kAdxH8aTLHT3gsMZkGKHfFDfCGM4
	h3PG2Ppz6sknU4xBYeJbyVZacWQjYdj6+2cM925cvlytPoJiTbpMecx3vT2NstLs
	g2eX4CFfThXlLqcQqvEg6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040926; x=
	1766048126; bh=HcY9ZMgVogkg8j9SKqow0aTuShYhvCopn4OJYq336/s=; b=H
	B/uk6NlN+23/u2grZnjdQiwG5XHKjtRLKKz2fAoFd/O59swGJKkxuEV8K7QuPu6w
	Kro9KQWSs5Ee7Fa1EnmGMoG52xWIaAcgMAJ6aQlG89ECdBYhcUl3nt8CHbt/qbG/
	eZF41VxPYi/yQhkVjURNm/bJ9B6QVJiudWh7st9zHkdPMKek8ZHbFd+EhFUzSk9l
	l3bWNp4E+w40RkE7EKzPLJjNAWZ9aSn0MgwYt+pvOnra4JRADdmvrxhoA3efv9Vv
	dvprS4Oiv/h+fF1+iJPZ+R7OrjPsHfXcRnh6FTuBaDLMDhxSqMGxLNbX+k8442S8
	op6JqzzNSiOzdEVqPJPpA==
X-ME-Sender: <xms:XqVDaSb9GrjOPIHiQzhIsp1S6Vb-KW4tCKyC981Mw23A4mny8JWQQw>
    <xme:XqVDabaMic7wqp1mt1-YNXXhLQgey9vmvST7xLxH8spB8aylCcBpBZmDwcJn9JBBT
    yAkZXUvcEiZow3mk7z4JkScczOYwaptmBmqDUUUyw3DtZnyWYVSNQ>
X-ME-Received: <xmr:XqVDaaljDUU7eKan6EX8MGrnzZG0k7vtzgK2MnGRKig82DLyGQGXQMFth3Q1Ac3dfDKMzgXA2UNr4RBAmGPwtS-47urMWmsSCML6Mw1Y_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecurfhhihhshhhinhhgqdfkkffrpghrthculdeitdejmdenuc
    fjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedv
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XqVDafyN4wMf4e7p43bBv122Jmex9XhnMBLmMWH_5n2gXAq27zHLyQ>
    <xmx:XqVDaQNaim9c-ZJNnyIZiIlpxNRWOApm9s5MnXTFBzAWbWIVBaUjsA>
    <xmx:XqVDabTwIv299GPDYIOOCeL-hCKn4vL-LIig_J4NgssHStOyFhpLBQ>
    <xmx:XqVDaWbnpgWtr8Z5TrRchUcGkHRHWxCe_QlL1zHFhCASGgCorQ6D2g>
    <xmx:XqVDaeao44aiuiGctmFeCe7GvfHESxfCxNZvOJvB3YutvzxzikG9dS64>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 60284eeb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] Start tracking packfiles per object database
 source
Date: Thu, 18 Dec 2025 07:55:19 +0100
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFelQ2kC/32NwQ6CMBBEf4Xs2TVtaSF68j8Mh9ousiFC02qjI
 fy7hXj2+CYzbxZIFJkSnKsFImVOPE8F1KECN9jpTsi+MCihjFRC4k1jGBMG60ZMzzkSZraY5ld
 0hL3XtXeibYxtoShCpJ7fu/7aFR54m3z2tyy39CeW5r84SxSo69papxujTuZSukd+QLeu6xdCF
 GFbxQAAAA==
X-Change-ID: 20251201-b4-pks-pack-store-via-source-fd43dc0765a7
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Hi,

the `struct packfile_store` tracks packfiles we have in the repository
so that we can look up objects stored therein. Right now, the packfile
store is tracked on the object database level -- each object database
has exactly one packfile store. Consequently, we track packfiles that
are part of different object database sources via the same packfile
store.

This patch series refactors this so that we instead have one packfile
store per ODB source. This means that access to any object, regardless
of whether it is stored in a packfile or in a loose object, is always
done via its owning source.

This is the last step required for pluggable object databases: all
object access is routed through sources, and we can thus now abstract
these sources and then plug in a different implementation. Of course,
these abstractions are still very leaky, and we still reach into the
implementation details in a bunch of files. But this is something that
will be addressed over subsequent steps.

This series is built on top of d8af7cadaa (The eighth batch, 2025-12-14)
with the following two series merged into it:

  - ps/object-read-stream at 7b94028652 (streaming: drop redundant type
    and size pointers, 2025-11-23).

  - ps/odb-misc-fixes at 8915881686 (odb: properly close sources before
    freeing them, 2025-12-11).

The latter topic isn't in "next" yet, but the second version of this
topic only contains two small memory leak fixes. I don't expect it to
change, and I guess it should land soonish anyway.

Changes in v2:
  - Fix some stale comments that still refer to `kept_pack_cache()`.
  - Improve commit messages a bit.
  - Link to v1: https://lore.kernel.org/r/20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      packfile: create store via its owning source
      packfile: pass source to `prepare_pack()`
      packfile: refactor kept-pack cache to work with packfile stores
      packfile: refactor misleading code when unusing pack windows
      packfile: move packfile store into object source
      packfile: only prepare owning store in `packfile_store_get_packs()`
      packfile: only prepare owning store in `packfile_store_prepare()`
      packfile: inline `find_kept_pack_entry()`
      packfile: refactor `find_pack_entry()` to work on the packfile store
      packfile: move MIDX into packfile store

 builtin/fast-import.c  |  37 +++++---
 builtin/grep.c         |  10 ++-
 builtin/index-pack.c   |   2 +-
 builtin/pack-objects.c | 104 +++++++++++-----------
 http.c                 |   2 +-
 midx.c                 |  19 ++--
 odb.c                  |  44 ++++------
 odb.h                  |  11 +--
 odb/streaming.c        |   9 +-
 packfile.c             | 229 +++++++++++++++++++++++++++----------------------
 packfile.h             | 102 ++++++++++++++++------
 reachable.c            |   2 +-
 revision.c             |   8 +-
 13 files changed, 329 insertions(+), 250 deletions(-)

Range-diff versus v1:

 1:  e41c8e60fd =  1:  6451ff6ca8 packfile: create store via its owning source
 2:  ceb9554eb7 =  2:  335bcb445b packfile: pass source to `prepare_pack()`
 3:  dcc58101d6 !  3:  6a0cd52c1c packfile: refactor kept-pack cache to work with packfile stores
    @@ Commit message
         move down the packfile store to be a per-object-source entity.
     
         Prepare for this and refactor the kept-pack cache to work on top of a
    -    packfile store instead.
    +    packfile store instead. While at it, rename both the function and flags
    +    specific to the kept-pack cache so that they can be properly attributed
    +    to the respective subsystems.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ packfile.c: int find_kept_pack_entry(struct repository *r,
      			return 1;
     
      ## packfile.h ##
    +@@ packfile.h: struct packfile_store {
    + 	 * is an on-disk ".keep" file or because they are marked as "kept" in
    + 	 * memory.
    + 	 *
    +-	 * Should not be accessed directly, but via `kept_pack_cache()`. The
    +-	 * list of packs gets invalidated when the stored flags and the flags
    +-	 * passed to `kept_pack_cache()` mismatch.
    ++	 * Should not be accessed directly, but via
    ++	 * `packfile_store_get_kept_pack_cache()`. The list of packs gets
    ++	 * invalidated when the stored flags and the flags passed to
    ++	 * `packfile_store_get_kept_pack_cache()` mismatch.
    + 	 */
    + 	struct {
    + 		struct packed_git **packs;
     @@ packfile.h: struct packed_git *packfile_store_load_pack(struct packfile_store *store,
      int packfile_store_freshen_object(struct packfile_store *store,
      				  const struct object_id *oid);
 4:  65f5d8828a =  4:  c0d71d3b39 packfile: refactor misleading code when unusing pack windows
 5:  2b3d057c9e =  5:  c699c49492 packfile: move packfile store into object source
 6:  49da0470ac !  6:  11d9a02292 packfile: only prepare owning store in `packfile_store_get_packs()`
    @@ Commit message
     
         When calling `packfile_store_get_packs()` we prepare not only the
         provided packfile store, but also all those of all other sources part of
    -    teh same object database. This was required when the store was still
    +    the same object database. This was required when the store was still
         sitting on the object database level. But now that it sits on the source
         level it's not anymore.
     
 7:  21db858611 =  7:  0451e4e55b packfile: only prepare owning store in `packfile_store_prepare()`
 8:  4e6d8a0d0a !  8:  16b3a80fd3 packfile: inline `find_kept_pack_entry()`
    @@ Commit message
         the latter into the former.
     
         Furthermore, reorder the code so that we can drop the declaration of the
    -    function in "packfile.h". This allow us to make the function file-local.
    +    function in "packfile.h". This allows us to make the function file-local.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 9:  11d2a90140 =  9:  4d75ea9021 packfile: refactor `find_pack_entry()` to work on the packfile store
10:  bbdbd86a94 = 10:  c86726fecd packfile: move MIDX into packfile store

---
base-commit: a531cef344bcbcdca16c33bd34fbf4ec0065ab5e
change-id: 20251201-b4-pks-pack-store-via-source-fd43dc0765a7

