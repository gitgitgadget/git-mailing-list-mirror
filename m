Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D12327A7
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564942; cv=none; b=kSH0ZBV2GESSCPsYGAK9eX6bH3xd2D51g2zAufXP2/p+gKLNQU/3qwITLKy174zcchSO68XklvFBx2qEtOk2L/u64K/Up5l9zLHV0yVeT1IWfaYze4lotRc4q5m4Y29bvn+y3FEkHaX1HevNNgI2oDvF2v/o9N+uRaZvuzOF7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564942; c=relaxed/simple;
	bh=NwOjjVILxYceS9vnG54vIs6ubpJgBx4AE6saiX+39tA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=n/ViytTO7vKoZzxBlnuevpcUdM+QoL8midW3Z7O54r+vA9pCtg1hCjcO+SpA5ThI+iULfDaWPklzEvYKjUIUi91LUDGcWov+b4dUmpxXaMc7Y66/INuMiCKbTSAUmlKp5qVxqzbYW/4c7+Z2usG9+yPv0gYXqI8Mnp+rstMpPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iwqzPTG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A+tYMSUD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iwqzPTG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+tYMSUD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 66B2513801FF;
	Fri, 25 Apr 2025 03:08:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564938;
	 x=1745651338; bh=wArKIksXxSl8w41KeHtn88Lol9JBSJeXpmRSjZhnrzk=; b=
	iwqzPTG7OMn+7+3rkRcDcXMZJDWKkPjXIXD5X1SFREP4mnq/62m3ul0j1aSF0MoF
	PNOpAcxTxkrT17szl++bEfCsWYKUZxMgpovIZU1/XZEiyE8bKk4CyhYIb3d7WXau
	k4WLAnG+pIjejhprPEkbkgkQj9maYO+PKx/V4KRgzEpdahI62u+5aX9HAOfEmsh1
	W4a98AVlSOYFdsRnkjp8SXGVuWZ+xeqH5APGcMs6h6mPHSMegjws1Ry5fBOjLsQ3
	krQYTYcgbBRN2SNLi+y7EDp3bpH2fcnpjXyVJU6TwAZQkGMS95unHH9srGkQiYS7
	U5FYIoBFPBYKVXVXqkcVRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564938; x=
	1745651338; bh=wArKIksXxSl8w41KeHtn88Lol9JBSJeXpmRSjZhnrzk=; b=A
	+tYMSUDhw57ZsL03IAydh0qe6pxQ6hcaux8jQpY+0jEN2Y2FZRuKRuxSiETE0JTG
	XK0PZEUWjwVfGmkNiGpNGDAMc4upCX7nPZLxyAG2vzX3qLRW4umiOHW87J3r1HNL
	F0NwBg/GM/tUUbJ2VXtVmKEfSWtIRlDN6AUlLd/L7CcfbUTgB+EjUqgaAYXV271X
	WIwi0iMEjFxw+0NsGBUNC+3IKFs59vtJLt+og+bLlSfYhKIvaycsW7cjIF3oQHcC
	m86jLqUt0YL/QhHwTABdA//sq6Tb5UrvFWuiEgRi8wY5H4IJbnPHthddXKHgidzD
	MCeu0dCuE/1juRVEVHncw==
X-ME-Sender: <xms:CjULaC1877sLyULSgoyFW8KKSjo5fYVnIgQqbX9qjhkFdFr8WIVX1Q>
    <xme:CjULaFFp-vWcCo8UWpmIawkXiJ94wkWbvSCkPCgsOcTW7sPJVj0oCMgdC7tW729lm
    bY4KBzuka4q73ifoA>
X-ME-Received: <xmr:CjULaK71SQIHWydaTs84wTOZh4w4axN-NjFwQy5a9l4pkvgjRuD09_mOno7HgqcWr9CbsmgMOwD9jO1CxD16y4WeOzh9HmGRQKxrAlVi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CjULaD1bgxFjlFU41i1zRhZGeY84nTCedkWfE2ZOF8ACT9xE-YVyZA>
    <xmx:CjULaFFrZrdf6rA32MCsbULGBPKCst4nwg0pBuZhnqnE5j7FAgxKRA>
    <xmx:CjULaM8TmciShD91DDvg0npkompB2jvCRHqSW1xZQjDYpN667cOAHw>
    <xmx:CjULaKn6aijkXCnlwlWDugS9U7sQ3TCEtqnS_0BnHE-DtkQ4EbBwCQ>
    <xmx:CjULaMiMoET81iGOW0U0xTCs8-5y3aKZ8B8_PR3v51UNtsODugn6IpHG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:08:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9dcbd7c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:08:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/13] object-store: a handful of cleanups
Date: Fri, 25 Apr 2025 09:08:51 +0200
Message-Id: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQ1C2gC/32NzQ6CMBCEX4Xs2TXdSoV44j0MhwqLrD+UtEg0p
 O9uIfHq8ZvMfLNAYC8c4JQt4HmWIG5IoHcZNL0drozSJgattFG51jjeA7rLjZsJw+Q8Y/NgO7z
 GgMYeVVEoyskYSPvRcyfvzX2uE/eyDj7b1Uxr+rMe/lhnQoUldWVOZE2ryip19/KEOsb4BVFZS
 0S/AAAA
X-Change-ID: 20250422-pks-object-store-cleanups-5a6077014155
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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

Thanks!

Patrick

---
Patrick Steinhardt (13):
      object-store: move `struct packed_git` into "packfile.h"
      object-store: drop `loose_object_path()`
      object-store: move and rename `odb_pack_keep()`
      object-store: move function declarations to their respective subsystems
      object-store: allow fetching objects via `has_object()`
      treewide: trivial conversions of `repo_has_object_file()`
      builtin/index-pack: don't fetch promised objects for collision check
      builtin/show-ref: don't fetch objects when printing refs
      refs: don't fetch promisor objects in `ref_resolves_to_object()`
      http-walker: don't fetch objects via promisor remotes
      list-objects: clarify how promised blobs are excluded
      bulk-checkin: don't fetch promised objects on write
      object-store: drop `repo_has_object_file()`

 builtin/cat-file.c       |   3 +-
 builtin/clone.c          |   4 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |   3 +-
 builtin/fetch.c          |  15 ++--
 builtin/gc.c             |   2 +-
 builtin/index-pack.c     |   6 +-
 builtin/receive-pack.c   |   4 +-
 builtin/remote.c         |   3 +-
 builtin/show-ref.c       |   2 +-
 builtin/unpack-objects.c |   3 +-
 bulk-checkin.c           |   2 +-
 cache-tree.c             |  13 +++-
 fetch-pack.c             |   7 +-
 http-push.c              |  11 ++-
 http-walker.c            |   7 +-
 http.c                   |   4 +-
 list-objects.c           |   3 +-
 notes.c                  |   3 +-
 object-file.c            |   4 +-
 object-file.h            |  77 +++++++++++++++++++
 object-name.c            |   2 +-
 object-store.c           |  44 ++---------
 object-store.h           | 191 +++--------------------------------------------
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
 37 files changed, 265 insertions(+), 281 deletions(-)

Range-diff versus v1:

 1:  b4f8a00f4c4 =  1:  019c27227dc object-store: move `struct packed_git` into "packfile.h"
 2:  8684c481949 =  2:  b372e8214de object-store: drop `loose_object_path()`
 3:  f4f5127f44f !  3:  fa51af2ee24 object-store: move and rename `odb_pack_keep()`
    @@ Commit message
     
         The function `odb_pack_keep()` creates a file at the passed-in path. If
         this fails, then the function re-tries by first creating any potentially
    -    missing leading directoriesk and then trying to create the file once
    +    missing leading directories and then trying to create the file once
         again. As such, this function doesn't host any kind of logic that is
         specific to the object store, but is rather a generic helper function.
     
 4:  9f94d3c4780 =  4:  04ad9a1b228 object-store: move function declarations to their respective subsystems
 5:  0a187fe90db =  5:  3d45b334f4b object-store: allow fetching objects via `has_object()`
 6:  4ebdf7510d2 =  6:  6101dfc393a treewide: trivial conversions of `repo_has_object_file()`
 7:  739de6f8c67 !  7:  35eca639ba4 builtin/index-pack: don't fetch promised objects for collision check
    @@ Commit message
         whether we already have an object with the same object ID, but different
         contents in the repository.
     
    -    The check whether the collision check is really needed is performed via
    -    `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)`. But unless
    -    explicitly told otherwise via `OBJECT_INFO_SKIP_FETCH_OBJECT`, this
    -    function will also cause us to fetch the object ID in case it is part of
    -    a promisor pack. As such, we may end up fetching the object only to
    -    check whether the fetched object and the object that we're indexing have
    -    the same content.
    +    The check whether the collision check is really needed is only performed
    +    in case `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)` tells
    +    us that the object exists. But unless explicitly told otherwise by
    +    passing `OBJECT_INFO_SKIP_FETCH_OBJECT`, this function will also cause
    +    us to fetch the object in case it is part of a promisor pack. As such,
    +    we may end up fetching the object only to check whether the fetched
    +    object and the object that we're indexing have the same content.
     
         This behaviour is highly dubious and more likely than not unintended.
         Fix it by converting to `has_object()`, which knows to neither reload
 8:  0a79bfdbf14 =  8:  9975d86c59d builtin/show-ref: don't fetch objects when printing refs
 9:  3a1ebffcdb0 !  9:  41ad3e7ede2 refs: don't fetch promisor objects in `ref_resolves_to_object()`
    @@ Commit message
     
         Similar to the preceding commit, don't try to fetch objects pointed to
         by references. Any reference whose object does not exist is broken by
    -    definition an, so we should report it accordingly.
    +    definition, so we should report it accordingly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
10:  a21cfe3dc91 = 10:  e7bb54ba5bd http-walker: don't fetch objects via promisor remotes
11:  b939734e9e6 = 11:  bef052ff785 list-objects: clarify how promised blobs are excluded
12:  8e8a5041af3 = 12:  45023c6e96f bulk-checkin: don't fetch promised objects on write
13:  68deca60383 = 13:  c263ae0f4cf object-store: drop `repo_has_object_file()`

---
base-commit: ca819c0751cedd1713334882e4c83687f8478a54
change-id: 20250422-pks-object-store-cleanups-5a6077014155

