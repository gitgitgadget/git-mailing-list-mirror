Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316E366
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415790; cv=none; b=k6aKwj4ORnpkUU3x9S6R3RGh9o4rrvJUtzkWLuQ2a+7U6XR6XKk/X5Bq69YQAz0r7afvsUQic1SI/JijGeygO2yxrLM0mifTMcDJDWkuHXsxWESm2DmyR7XxuxGxvIp7kzKljS/NzWwkqo+Q69YnJz0EJ0m8xKjs14ISrf/hESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415790; c=relaxed/simple;
	bh=pQrMtLkTbBe/0msz8iYseJkdueuf/1UiFgi+yMKvqko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=GQrPUmQPHwEIFFGL6694Ewi9LowoSN2PxpEAkeWb9ZVE4hnzXtISMjjfygpBdGWSygaMJZpkgE1am4tFmj+TTXYx2bNGL0z/jKQ785NI9wfXop2EyQtRs5CZ3sRqS4MMBz9D4dLh4cRkZahrMkZ8iWbEu26rQKxdXFLrI8U8pzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KwmGUgRx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmsLK88t; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KwmGUgRx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmsLK88t"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B699140019F;
	Tue,  9 Sep 2025 07:03:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 07:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415787;
	 x=1757502187; bh=LFl5MRA1zwTZlK2/sfzgVkLsz0gvi4gzQZB+kbl1l8w=; b=
	KwmGUgRxB2wOtyGpPGH02VKjzufSv2NmMa1E9Umw0OEeVSiDyK9jGWtTNLJ6NWp1
	nPUClxTh9dbELgUDbmL0PtR28n8Z3lI4fdr7q+kcwssDjr8sDemjz1i1Bp06P3z0
	+3Y/7ak/83SlHfNPdvoHbQcIXBV34G2TQjxxm7wXjfyt/tDEL1uTk8W3+k9n6Kiv
	+in04IbRA1+tdWc8ZvKaMqCjtAfodVcIf7czGGJlXYgfRJ2acRLzteQqyuN2QaHt
	U2XIfTPiuIYWxd157YEGe/69dF9jeJcTz6KN69hkgqCwqxTZ3U2A+K5y+sOLejmD
	TZdUv2bJwzX2mAB018cfcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415787; x=
	1757502187; bh=LFl5MRA1zwTZlK2/sfzgVkLsz0gvi4gzQZB+kbl1l8w=; b=Q
	msLK88tMoI7QzrN3G/d3f2lVh01b7RkTssWRc1nI/mUUObkKi8195z0tL9IPZEWI
	95E2Fq2GXTqSM3bmWWwi+KqwY0ZmFoeN9OPlHW8xcOG3dXfY1Cbh1tViSGeqz+Mj
	JqKnifXJZhdFn7YKKLSH4MlXJr/u01uRXksy3anc7WyIX9DJOWqEOwH3bvzPy3OV
	/1oca3P9tXqqGjFMkXBR2dQrjU/YKHDfH3ergv/I9IfNAJ9xIV8wbQsXVut4ppuv
	oz5AQvzn0Ell+tSer2wWi2OC4fwNzOT3roLM2hOD7VkbSt6lrCtOqItqlogC+d1C
	k5YdtrqkWLMdcB2u5BXJw==
X-ME-Sender: <xms:awnAaOGy-hGgIYUwhpz_KVWgawIDlnd4GIhDndgmRh-Nae91pz6vGg>
    <xme:awnAaK3i8oyFNaUJlbg6XHbQMp_Sqe1nsHOpcjApm90jnljoFt4dQdLIXe9NFoebc
    yeGUsybBS2eyLnIEQ>
X-ME-Received: <xmr:awnAaOkbL76sFgc23vXv1PLFWOEe0AJDaoazhVsP93r7HJe1NwTWs4vhCdkVmIeyw20HaAiy3pSntIlAId36S_q91-H3-ROyPE2-a-ivyao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:awnAaC_1A0vyb3nsRi-m8PX6AyQ28ELDka6TG0vzwYF_w5ezVwjRIw>
    <xmx:awnAaLr4R0yVu1xT-fvLUr9R-KhoAsvPTk_STJb-4ft_UipJbKDQFQ>
    <xmx:awnAaDlLzRHL1dDODzpvf8hJK6BpiNcvFSTPo4vGMjjjbtVQ2vFJwA>
    <xmx:awnAaKh--8OloZPpeyuOUH0yaoeM0vMPO3Jejc6ZWnNPZL2_EVZIlQ>
    <xmx:awnAaGJF9UjmJEGbeyezR0jPJJ59wC-w9avis3toDmngk16UFeRxhD7M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8432bfc3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/15] packfile: carve out a new packfile store
Date: Tue, 09 Sep 2025 13:02:59 +0200
Message-Id: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMJwGgC/3XOTQ6CMBAF4KuQrq1ppz9SV97DuKgwlQYF0ppGQ
 7i7hZigC5Zv8uabGUnE4DGSYzGSgMlH33c5yF1BqsZ2N6S+zpkAA8VKpulV0qGNdLBV6/wdI43
 PPiC1UlrNysoKo0leHgI6/1rg8yXnxs+993In8Xn6JbnZIhOnjHKdVQnIQdlTbu39g8xegh8D+
 KYB2ag50yCEUmjcnyFWwzDYNEQ2tAEFhxId1usf0zR9AHrCNylBAQAA
X-Change-ID: 20250806-b4-pks-packfiles-store-a44a608ca396
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

information about a object database's packfiles is currently distributed
across two different structures:

  - `struct packed_git` contains the `next` pointer as well as the
    `mru_head`, both of which serve to store the list of packfiles.

  - `struct object_database` contains several fields that relate to the
    packfiles.

So we don't really have a central data structure that tracks our
packfiles, and consequently responsibilities aren't always clear cut.
A consequence for the upcoming pluggable object databases is that this
makes it very hard to move management of packfiles from the object
database level down into the object database source.

This patch series introduces a new `struct packfile_store`, which is
about to become the single source of truth for managing packfiles, and
carves out the packfile store subsystem.

This is the first step to make packfiles work with pluggable object
databases. Next steps will be to:

  - Move the `struct packed_git::next` and `struct packed::mru_head`
    pointers into the packfile store so that `struct packed_git` only
    tracks a single packfile.

  - Push the `struct packfile_store` down one level so that it's not
    hosted by the object database anymore, but instead by the object
    database source.

Changes in v2:
  - Convert the `initialized` flag into a boolean.
  - Polish some commit messages.
  - Some smaller formatting changes to the layout of `struct
    object_database`.
  - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im

Changes in v3:
  - Rebased on top of master at 6ad8021821 (The fifth batch, 2025-08-29)
    with ps/object-store-midx-dedup-info at 13296ac909 (midx: compute
    paths via their source, 2025-08-11) merged into it. This fixes
    various conflicts with "seen". There's still two conflicts: a
    trivial one with jt/de-global-bulk-checkin. And a more complex one
    with tb/prepare-midx-pack-cleanup. I don't think it's necessary to
    really address the first one, but I'm unsure how to proceed with the
    second one given that the patch series still seems to be cooking.
  - Set `struct object_database::packfiles` to `NULL` after free'ing it.
  - Add a comment to explain the kept cache.
  - Fix a missing `obj_read_lock()` call.
  - Drop the commit that always adds packfiles to the MRU. I've moved
    this into a subsequent patch series.
  - Avoid some overly long lines by storing the pointer to the packfile
    store on the stack.
  - Point out the difference between `get_all_packs()` and
    `get_packed_git()`.
  - Link to v2: https://lore.kernel.org/r/20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im

Changes in v4:
  - Small code style improvement as suggested by Junio.
  - Some commit message improvements as suggested by Karthik.
  - Link to v3: https://lore.kernel.org/r/20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (15):
      packfile: introduce a new `struct packfile_store`
      odb: move list of packfiles into `struct packfile_store`
      odb: move initialization bit into `struct packfile_store`
      odb: move packfile map into `struct packfile_store`
      odb: move MRU list of packfiles into `struct packfile_store`
      odb: move kept cache into `struct packfile_store`
      packfile: reorder functions to avoid function declaration
      packfile: refactor `prepare_packed_git()` to work on packfile store
      packfile: split up responsibilities of `reprepare_packed_git()`
      packfile: refactor `install_packed_git()` to work on packfile store
      packfile: introduce function to load and add packfiles
      packfile: move `get_multi_pack_index()` into "midx.c"
      packfile: remove `get_packed_git()`
      packfile: refactor `get_all_packs()` to work on packfile store
      packfile: refactor `get_packed_git_mru()` to work on packfile store

 builtin/backfill.c          |   2 +-
 builtin/cat-file.c          |   3 +-
 builtin/count-objects.c     |   3 +-
 builtin/fast-import.c       |  10 +-
 builtin/fsck.c              |  11 +-
 builtin/gc.c                |  14 ++-
 builtin/grep.c              |   2 +-
 builtin/index-pack.c        |  10 +-
 builtin/pack-objects.c      |  32 +++--
 builtin/pack-redundant.c    |   6 +-
 builtin/receive-pack.c      |   2 +-
 builtin/repack.c            |  11 +-
 bulk-checkin.c              |   2 +-
 connected.c                 |   5 +-
 fetch-pack.c                |   4 +-
 http-backend.c              |   5 +-
 http.c                      |   5 +-
 http.h                      |   2 +-
 midx.c                      |  29 ++---
 midx.h                      |   1 +
 object-name.c               |   6 +-
 odb.c                       |  40 +++++--
 odb.h                       |  34 ++----
 pack-bitmap.c               |   4 +-
 pack-objects.c              |   3 +-
 packfile.c                  | 286 ++++++++++++++++++++++++--------------------
 packfile.h                  | 119 +++++++++++++++---
 server-info.c               |   3 +-
 t/helper/test-find-pack.c   |   2 +-
 t/helper/test-pack-mtimes.c |   2 +-
 transport-helper.c          |   2 +-
 31 files changed, 390 insertions(+), 270 deletions(-)

Range-diff versus v3:

 1:  30e662de96 =  1:  69bca2e49d packfile: introduce a new `struct packfile_store`
 2:  60840ec43f !  2:  ff52df37e6 odb: move list of packfiles into `struct packfile_store`
    @@ packfile.c: struct packfile_store *packfile_store_new(struct object_database *od
     +	for (struct packed_git *p = store->packs; p; p = p->next) {
     +		if (p->do_not_close)
     +			BUG("want to close pack marked 'do-not-close'");
    -+		else
    -+			close_pack(p);
    ++		close_pack(p);
     +	}
     +}
     
 3:  a593254243 =  3:  4ebb964950 odb: move initialization bit into `struct packfile_store`
 4:  291a410d78 !  4:  f481469434 odb: move packfile map into `struct packfile_store`
    @@ Commit message
     
         The object database tracks a map of packfiles by their respective paths,
         which is used to figure out whether a given packfile has already been
    -    loaded.With the introduction of the `struct packfile_store` we have a
    +    loaded. With the introduction of the `struct packfile_store` we have a
         better place to host this list though.
     
    -    Move the map accordingly. `pack_map_entry_cmp()` isn't used anywhere but
    -    in "packfile.c" anymore after this change, so we convert it to a static
    -    function, as well.
    +    Move the map accordingly.
    +
    +    `pack_map_entry_cmp()` isn't used anywhere but in "packfile.c" anymore
    +    after this change, so we convert it to a static function, as well. Note
    +    that we also drop the `inline` hint: the function is used as a callback
    +    function exclusively, and callbacks cannot be inlined.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 5:  8bc7d46524 =  5:  4d54056618 odb: move MRU list of packfiles into `struct packfile_store`
 6:  2e4e13e60b =  6:  c9a61cafc6 odb: move kept cache into `struct packfile_store`
 7:  7a873bf4d1 =  7:  4896d70b5c packfile: reorder functions to avoid function declaration
 8:  fc60fc0cae =  8:  c47bf63f5c packfile: refactor `prepare_packed_git()` to work on packfile store
 9:  f15c3569ae =  9:  99203234a1 packfile: split up responsibilities of `reprepare_packed_git()`
10:  114e9ac17a = 10:  163f9acf73 packfile: refactor `install_packed_git()` to work on packfile store
11:  17aefbdef9 = 11:  8c73603ad2 packfile: introduce function to load and add packfiles
12:  9666abfb08 = 12:  199e606682 packfile: move `get_multi_pack_index()` into "midx.c"
13:  7e90938546 = 13:  f37281543d packfile: remove `get_packed_git()`
14:  f378932538 = 14:  250a389b66 packfile: refactor `get_all_packs()` to work on packfile store
15:  0b3b613612 = 15:  1d194eba71 packfile: refactor `get_packed_git_mru()` to work on packfile store

---
base-commit: 337c7a0bbcf228ce11c87d066ecee352b3e52467
change-id: 20250806-b4-pks-packfiles-store-a44a608ca396

