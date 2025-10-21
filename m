Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF68460
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 05:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024343; cv=none; b=E8GQppuh9i4Z+3Z3JrCgQvEIWxm7VjMC6ShdAvE77FJ/UNm1gXWLdkLOBSA7vFdFMkY7Lb9KUmcSDnLgIEM8XDzJAUg90Yt+k4aFaOPBs+gYiqV+yJJJgRdinvkXebHoPfTGZbeQxU20hBJ6gCnl84KbopCc8ehc2tTVEUMr4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024343; c=relaxed/simple;
	bh=OzNz8LlFrR96K04oI4/ZePRbMG/J9GCdrbq/Jyl5PDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIeNZ25eH6MnEy7ocpuJCEb4MQ6s6qHFfwwVSL/+7xSsOqfEhXMvJfXilsBnHsS2lLgqSnb7ElXBMmoiIwqHsPdfaA3G5NV/If1C7kOOe6Cz3H6/097b5i+iv7D2rdvUPLYmSOR09wbfTP008j1fp/lVDenvnNa0cGNjVDGQ7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BiPsm/Wb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y+ENAbk6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BiPsm/Wb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+ENAbk6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C05A1EC00DA;
	Tue, 21 Oct 2025 01:25:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 01:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761024340; x=1761110740; bh=jTNrzy2PSD
	40CEYjdUvyfyZc+eHheMMoyffU58FAl5Q=; b=BiPsm/WbQ9bMV2l+Ni6cZEwZvz
	W0esLFxFlf7HVis+uEyocOkLnkFfQauB+MEQwdSX3fmPgZuyPy8eOqXdjGpO44Ka
	bfe63XW9XOBpFBTEcUhgfValP5EAYdDaD1567HTdO6GFvvDH92BlRatsuMAcKkFr
	0gngFPR08K+E8yM2OV9gJ6t/N4biCKSEp7DvLk7r9Y+iLpSSqydh9TjhViS7nhuD
	7Jx0H9djdoK0S5/sifx3mTEys9Wf9856qusQjMk+zyZzgof0kwYGrF9ZCRZqqfxg
	TNEMN7MIjz+zW2AcRPzgGVxKA25nu6aiOcPmIN3n6CB1UQ8svA3CvF8r+now==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761024340; x=1761110740; bh=jTNrzy2PSD40CEYjdUvyfyZc+eHheMMoyff
	U58FAl5Q=; b=Y+ENAbk6LLzXHQtjvgaIlXMMnGKXdaYHzvVKDRfYUdgOgL3zxUD
	xX+tP6sbUilaQ+JKvN5RaLQ1P+y1bHLW94KNCgmr4N4AWdCPmwWkWxt8bo7+IUL9
	1KspuUbBcDyFJ8ecsLED+CEu4lOX1RGXYPreL/htRQHmx2eR1wgB0yO/ahyfjGSN
	ew5vpx8Xso4ufCR8UX3RFgZVqLZAR/EEya65G0yka3h2T+aMC+VzDRagurr3XYCV
	0aPhreuENpkEwt5s1cxOi4TWXV8UtBeAvZDajUgFrXUlbAdoaQnDYfrORTDUzwJ+
	aRSFHnbiBhoaqKT35qW9uPe1AIbPlQDvIcQ==
X-ME-Sender: <xms:VBn3aNwPyQsEyjDRECI16cypfGrEDiEuKVbbry6wao0GXXslu3v8yA>
    <xme:VBn3aDQIP-jG0m9yyRYmRCBKKN25QlMflF_zr3fX18_ff17kf3r0u6FA10LJzDcbc
    wTCNX7cN3zi8vBjfeiFpB7UJxAYEHC54H6F8Yl50SCVE1TQ06TYvQ>
X-ME-Received: <xmr:VBn3aE8sbmDqrv4EnApdGn3Y3vIS0PfPx4d1ccl1j6MVTNUIRonBZDx-rONgiSY8ZvAULIJOnKmYZ8mfTOZPQHyFFY_naa-s9Rp9cd2ha5W1WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeetkedtuddvieegteettedtueeifeefjefgte
    fgledvheehkedvvdeigeeggeetheenucffohhmrghinhepvhgvrhhsihhonhdrphhsnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VBn3aKogZo1rM0_LPZqZ_2YQdpdYDhCm_lZsYy43VlTOi0bKk_7Pbg>
    <xmx:VBn3aBkiU2gw1g5Sg9J0O2mMWaNcS5v9zIBcNkGXUo9UPj5LDi3MQA>
    <xmx:VBn3aBLmq9ZHvZjwOCzrtj1tQu_umC_WcBdXZp7pQrekIHe1lhNxVw>
    <xmx:VBn3aGzUEWiX1mHLqTo3BvNrFeE1uYrp8Zo7PCrIRRUvudJmKBWPqg>
    <xmx:VBn3aBI8j5IN51pnVoXDUvx38F6atQWYrSNxGwWO0gst-vB3jIhprWH7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 01:25:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65ac910b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 05:25:38 +0000 (UTC)
Date: Tue, 21 Oct 2025 07:25:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #06; Fri, 17)
Message-ID: <aPcZTzqCn3VeGwIW@pks.im>
References: <xmqq7bwpz3pf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bwpz3pf.fsf@gitster.g>

On Mon, Oct 20, 2025 at 02:02:52PM -0700, Junio C Hamano wrote:
> * ar/run-command-hook (2025-10-17) 10 commits
>  - receive-pack: convert receive hooks to hook API
>  - receive-pack: convert update hooks to new API
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
>  - reference-transaction: use hook API instead of run-command
>  - hook: allow overriding the ungroup option
>  - transport: convert pre-push to hook API
>  - hook: convert 'post-rewrite' hook in sequencer.c to hook API
>  - hook: provide stdin via callback
>  - run-command: add stdin callback for parallelization
> 
>  Use hook API to replace ad-hoc invocation of hook scripts with the
>  run_command() API.
> 
>  Comments?
>  source: <20251017141544.1538542-1-adrian.ratiu@collabora.com>

I'll make sure tho give the current iteration another review today.

> * cc/fast-import-strip-signed-tags (2025-10-13) 5 commits
>  - fast-import: add '--signed-tags=<mode>' option
>  - fast-export: handle all kinds of tag signatures
>  - t9350: properly count annotated tags
>  - lib-gpg: allow tests with GPGSM or GPGSSH prereq first
>  - doc: git-tag: stop focusing on GPG signed tags
> 
>  "git fast-import" is taught to handle signed tags, just like it
>  recently learned to handle signed commits, in different ways.
> 
>  Will merge to 'next'?
>  source: <20251013084857.1646783-1-christian.couder@gmail.com>

Should be ready from my point of view. v2 already addressed all of
my comments, and v3 clarified the documentation in one more case. So I'm
happy with this version.

> * ps/ci-rust (2025-10-14) 8 commits
>  - rust: support for Windows
>  - ci: verify minimum supported Rust version
>  - ci: check for common Rust mistakes via Clippy
>  - rust/varint: add safety comments
>  - ci: check formatting of our Rust code
>  - ci: deduplicate calls to `apt-get update`
>  - Merge branch 'ps/gitlab-ci-windows-improvements' into ps/ci-rust
>  - Merge branch 'ps/rust-balloon' into ps/ci-rust
> 
>  CI improvements to handle the recent Rust integration better.
> 
>  Will merge to 'next'?
>  source: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>

I think it should be ready. The 3rd version only saw a single minor
fixup relative to the 2nd one.

> * ps/remove-packfile-store-get-packs (2025-10-09) 7 commits
>  - packfile: rename `packfile_store_get_all_packs()`
>  - packfile: introduce macro to iterate through packs
>  - packfile: drop `packfile_store_get_packs()`
>  - builtin/grep: simplify how we preload packs
>  - builtin/gc: convert to use `packfile_store_get_all_packs()`
>  - object-name: convert to use `packfile_store_get_all_packs()`
>  - Merge branch 'tb/incremental-midx-part-3.1' into ps/remove-packfile-store-get-packs
>  (this branch uses tb/incremental-midx-part-3.1.)
> 
>  Two slightly different ways to get at "all the packfiles" in API
>  has been cleaned up.
> 
>  Comments?
>  source: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>

I think this series should be ready once the below series is merged
down. v2 addressed all of Taylor's feedback and saw another positive
review by Justin.

> * tb/incremental-midx-part-3.1 (2025-10-15) 50 commits
>  - builtin/repack.c: clean up unused `#include`s
>  - repack: move `write_cruft_pack()` out of the builtin
>  - repack: move `write_filtered_pack()` out of the builtin
>  - repack: move `pack_kept_objects` to `struct pack_objects_args`
>  - repack: move `finish_pack_objects_cmd()` out of the builtin
>  - builtin/repack.c: pass `write_pack_opts` to `finish_pack_objects_cmd()`
>  - repack: extract `write_pack_opts_is_local()`
>  - repack: move `find_pack_prefix()` out of the builtin
>  - builtin/repack.c: use `write_pack_opts` within `write_cruft_pack()`
>  - builtin/repack.c: introduce `struct write_pack_opts`
>  - repack: 'write_midx_included_packs' API from the builtin
>  - builtin/repack.c: inline packs within `write_midx_included_packs()`
>  - builtin/repack.c: pass `repack_write_midx_opts` to `midx_included_packs`
>  - builtin/repack.c: inline `remove_redundant_bitmaps()`
>  - builtin/repack.c: reorder `remove_redundant_bitmaps()`
>  - repack: keep track of MIDX pack names using existing_packs
>  - builtin/repack.c: use a string_list for 'midx_pack_names'
>  - builtin/repack.c: extract opts struct for 'write_midx_included_packs()'
>  - builtin/repack.c: remove ref snapshotting from builtin
>  - repack: remove pack_geometry API from the builtin
>  - builtin/repack.c: pass 'packdir' to `pack_geometry_remove_redundant()`
>  - builtin/repack.c: pass 'pack_kept_objects' to `pack_geometry_init()`
>  - builtin/repack.c: rename various pack_geometry functions
>  - builtin/repack.c: remove "repack_promisor_objects()" from the builtin
>  - builtin/repack.c: pass "packtmp" to `repack_promisor_objects()`
>  - repack: remove 'generated_pack' API from the builtin
>  - builtin/repack.c: provide pack locations to `generated_pack_install()`
>  - builtin/repack.c: pass "packtmp" to `generated_pack_populate()`
>  - builtin/repack.c: factor out "generated_pack_install"
>  - builtin/repack.c: rename "struct generated_pack_data"
>  - repack: remove 'existing_packs' API from the builtin
>  - builtin/repack.c: avoid unnecessary numeric casts in existing_packs
>  - builtin/repack.c: pass "packdir" when removing packs
>  - repack: remove 'remove_redundant_pack' from the builtin
>  - builtin/repack.c: rename many 'struct existing_packs' functions
>  - repack: remove 'prepare_pack_objects' from the builtin
>  - repack: move 'delta_base_offset' to 'struct pack_objects_args'
>  - builtin/repack.c: pass both pack_objects args to repack_config
>  - repack: introduce new compilation unit
>  - builtin/repack.c: avoid using `hash_to_hex()` in pack geometry
>  - builtin/repack.c: avoid "the_hash_algo" in `finish_pack_objects_cmd()`
>  - builtin/repack: avoid "the_hash_algo" in `repack_promisor_objects()`
>  - builtin/repack.c: avoid "the_hash_algo" in `write_oid()`
>  - builtin/repack.c: avoid "the_hash_algo" when deleting packs
>  - builtin/repack.c: avoid "the_repository" when repacking promisor objects
>  - builtin/repack.c: avoid "the_repository" when removing packs
>  - builtin/repack.c: avoid "the_repository" when taking a ref snapshot
>  - builtin/repack.c: avoid "the_repository" in existing packs API
>  - builtin/repack.c: avoid "the_repository" in `cmd_repack()`
>  - Merge branch 'ps/packfile-store' into tb/incremental-midx-part-3.1
>  (this branch is used by ps/remove-packfile-store-get-packs.)
> 
>  Clean-up "git repack" machinery to prepare for incremental update
>  of midx files.
> 
>  Will merge to 'next'?
>  source: <cover.1760567210.git.me@ttaylorr.com>

Yeah, I think this one is ready to go.

Thanks!

Patrick
