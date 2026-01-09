Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C6347FFE
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947597; cv=none; b=ZGvufc03WOlpXyOoizTZKaQt6VnJEa1lMXCYUsgZOVk4YYA49EHlzp99vEoP/2Oum/OCea8WyR4YvBV/Kj4bkRkoPrDbfbzQBxRTrDVlW21m0zYiuvdO9DlrKDx4OEzap0O+I+clAol38CPa1fdNG4kSfBCm2opQ36VM01LK5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947597; c=relaxed/simple;
	bh=++5q1fMrlFo2ULm7pi11/jgqLWa6Ck7UJFtUlNYXHLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=PMBkwjfTYuWeTgLm/9GR4n5qK24KwFyYiv+a23au+b6AGF9oJzIwyU8fJ3qsGD73rNXt/femu9HGVx7AOnQoaBiTJcoSMMHrMg5D4aJx4J3ehINoTPdt0GHNyDH8MqD4UUzl1u+4MCyy0+Zja0bse1T7WIxzu8Wy927LQ7buDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d5WQB43o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5XbA6mM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d5WQB43o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5XbA6mM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5849B140005B;
	Fri,  9 Jan 2026 03:33:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 03:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947595;
	 x=1768033995; bh=f16M0PjgGxnvbSRSiMtgcEWxWVVEfIZQib1yHbXOM4k=; b=
	d5WQB43o9ZME4k5CAqz1czvDyq+se1La3o3ifk+t0zgH4wqvJLkSxhk0TJ0gNVeS
	fp6UVRk31Ntb1yfaokJ7Qy3TyezQphPqSQhq8DapFaPU+k2mOsmW4QQW/zggbtd2
	mAoOjowj3Y8yqqbifD8ytY9Ahh/r4HMCadIWbtaYg13Eti8uZsXIw2avC/9dG0TK
	Oh7vxJ1TcouS791dsf5ljvQFWVfkueub6u73IzoGhk0avQEqxe/Aq1e1G0tw3gFD
	EoyjB+Va3kO2WCnh1dpEZleNjBVIIatw+McTXVMjH/MMfdfCKsj9Qhx0r7EZBTqF
	FNNQFxj31Dd6R3op5LCT7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947595; x=
	1768033995; bh=f16M0PjgGxnvbSRSiMtgcEWxWVVEfIZQib1yHbXOM4k=; b=Q
	5XbA6mMLzLsZutKTAYylUOPDfZN5tHZ4olCY6D55Rh+afOM+nusXuojYKlawasFy
	7Jw3Wlzz5OWnfZNke4V82t7hBteylnymm03gp+sC7M1vyd1orx2Biltx0B9OsdlP
	QzO20wkiLtnNqLBKFKZGzAm8aG7dWbAgO0lfJOZW7YmfN0bgqknUPb58ssV6kg0R
	0k3bcVselK/E5Blx+51tIy5HQLKt5xP8EbTcuaG8HC5F7OzBIuI9LDvabFqm+fbp
	9wREtmHcUQ92MSCroCmyhZAFWw7ZDwctnHDZ+sXpSndB5x92GwH0MBrxOWGa+dZd
	EfsIzEoh3v4ivOutyxwOQ==
X-ME-Sender: <xms:Sr1gacqZq4iq21KXLWOykcxalB2-9AEGRiHxOHntl6LKAawPnXJkOQ>
    <xme:Sr1gaZq3orLTiQzBgEDnkvt3NurI_882p1MmDamh_LLmqhEF-lcWMg4mGenkq45yI
    KqQvNtZBMkQXevHaVLLz4Wmiz7Y0sjOQgsUpQNVOYagF-F6TFZxnA>
X-ME-Received: <xmr:Sr1gaWOWHnz7lco613TS5Ru7O3BhOH-naombYZkabGQQ-lT6yckXFrKKLOq76z3VRagjm5M1pn9NrgpvM3cZoCjfOHXvjK3WqpXE6FVR5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Sr1gaSwIh6rcpsrZMaPkSXYYbBqIIU71QlKKz5TuT_Vral1as3lBVw>
    <xmx:Sr1gaXs4p0rht5mCwuZ3tUQTBxsAY4WtLlLbLPAsc85n2kopJaNfbg>
    <xmx:Sr1gaT7c6w8McuBbQbLaH-qa-dC0UdqGWtUDv_S61F9kDnOSb7I8GA>
    <xmx:Sr1gaeSNXwQJen_KO7EDY3e8i75dVdJc7yVTeKPspvDNPbGgZ-d72A>
    <xmx:S71gaXNtnQoxY9YrEfJ16a7f0_UFKm37JXyEZ9pMduitxrPV_DHwpmgT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ab3f175 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] Start tracking packfiles per object database
 source
Date: Fri, 09 Jan 2026 09:33:08 +0100
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAES9YGkC/4XNzQ6CMAzA8VcxO1uzlY0PT76H8TBHkYYIZNNFQ
 3h3BzHGkx7/TfvrJAJ5piD2m0l4ihx46FNk241wre0vBFynFijRKJQKzhrGLsBoXQfhNniCyBb
 CcPeOoKl1VjtZ5MYWIhGjp4YfK388pW55OXmu36Japm9Ymd9wVCBBZ5m1TucGK3NIuzu+ikWN+
 C2VfyRMUo6lrqQsHKH6SPM8vwCr1DtQDwEAAA==
X-Change-ID: 20251201-b4-pks-pack-store-via-source-fd43dc0765a7
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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

Changes in v3:
  - Fix a commit message typo.
  - Link to v2: https://lore.kernel.org/r/20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im

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

Range-diff versus v2:

 1:  be2e03d09a =  1:  3c4a729c4b packfile: create store via its owning source
 2:  11902d6203 =  2:  7c34d0704f packfile: pass source to `prepare_pack()`
 3:  4cc8fe64fa =  3:  34f6a6e84c packfile: refactor kept-pack cache to work with packfile stores
 4:  f6cfa54a3e =  4:  ba6c3af972 packfile: refactor misleading code when unusing pack windows
 5:  0f9d97d10c =  5:  0b83159e54 packfile: move packfile store into object source
 6:  426fe55d38 =  6:  2de6b860cf packfile: only prepare owning store in `packfile_store_get_packs()`
 7:  0f959db581 =  7:  c020bd5bc8 packfile: only prepare owning store in `packfile_store_prepare()`
 8:  0692b83a0c !  8:  998a96bf05 packfile: inline `find_kept_pack_entry()`
    @@ Commit message
         packfile: inline `find_kept_pack_entry()`
     
         The `find_kept_pack_entry()` function is only used in
    -    `has_oject_kept_pack()`, which is only a trivial wrapper itself. Inline
    +    `has_object_kept_pack()`, which is only a trivial wrapper itself. Inline
         the latter into the former.
     
         Furthermore, reorder the code so that we can drop the declaration of the
 9:  e9dc4bc63d =  9:  320e88c3d7 packfile: refactor `find_pack_entry()` to work on the packfile store
10:  eef3e7868e = 10:  62062a7696 packfile: move MIDX into packfile store

---
base-commit: a531cef344bcbcdca16c33bd34fbf4ec0065ab5e
change-id: 20251201-b4-pks-pack-store-via-source-fd43dc0765a7

