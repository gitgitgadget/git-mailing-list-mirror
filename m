Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7B26A081
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394509; cv=none; b=Rodahxzoyb6fKfnaGdYC1JX0JPtb5tLtkBEJOS6iRacz+TxGtdXuDnK4YxLMxhYX2uJvYIv2dLJEgtcwVMrbLALK0hGG/CknpiTAHD3l9luZeRjMwSiHXsN8FuGiVKUffQD3lDtxkSbJIP44ix67FqRvJOJcy97YBxNcMwS4+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394509; c=relaxed/simple;
	bh=nAxXJlBjshwVYV1aNJzkB/AyX6SU9jJCzc6aFZ8Pzo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FInc/CMS7Kt1buH1HrTVuKqSiozT67JiOjyHEuNT2Ds2eeYHjYIY3PMjrhGRbszntglLwpVBBwxSBznTsql/rGBpN7Jfd/mw1G/4ofNGbZJJ61XrAueEBbMDhpZKBC5SFYsEPz5JNHkoxoBoH/nI6EmMFu8IqWdYcftVZMarlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fY8a8aEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZv6FjKk; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fY8a8aEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZv6FjKk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 814701140106
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 03:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1745394505; x=1745480905; bh=AueUhr3hVN
	FOzAM3GxXyCqY4XtR09ORp9AFx54K9WCU=; b=fY8a8aEUyoRjhHeDJ+3VoUE/Uk
	V8wpisJJ17WvnETXUMc2D7fIaZwA/5urwpUWYQ+knk+idCEIA6hgN+4G55Rp/ZTK
	iD65Sqv+6H9rIi7g66tL+1aOTNcI0tslC/he6fS/niioO99h3IgDgExwDj7zrieS
	vlhyUXkTMZzX8JhkPS6D/tVnHYRE+9303KlE1pabOGxzw7gw+rvN5CbDjDGp1L9s
	l/vgKhIRbeZvWavYVnPXZodcMLclBKXnKchHgsKsJThQ6LzDRw04MqBuFnUGyliD
	3Xmd/9ioMkgWbAPgoUbqXfH43WQVkDbJzAigm8capdM/yzHujSC6MCrnxCcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1745394505; x=1745480905; bh=AueUhr3hVNFOzAM3GxXyCqY4XtR0
	9ORp9AFx54K9WCU=; b=EZv6FjKka6kT5AcRsABrRktKAGsUxISorclMsVdLYK7T
	+pyglw0phcJVdYrufF94tQFS3UdGtHduXVYQ0kOwyMn/RuU36AyvMz5PLBMWSR3M
	qb/h3aBrG/qtPrgYaW9nV97tS7kBRSa0K8f1AUdsq+9ukMMF2rP7xKQa0EWx+AgP
	KX7YCQt36Zn+9g8eNLlZh5WERwq9eKNEHMbjCMCaSQnqERm+RWUX/G+XRwqWk5HJ
	SIP+mUN4FEoyJrZQSGp8pogwYRPVPe8nzUcSJr3cabeMPsCOTqVGcfweaEcILpoM
	RSttcpmc4XWJDCNaF4MVcWYBr9aC9PCTHZnADBgCsQ==
X-ME-Sender: <xms:SZsIaN9Yp6Uk6Q1U6qEkkfoTNCWbclnDcXxHFDXgKQx4PMhWCl6pSw>
    <xme:SZsIaBtNo3nv4nYne6k3net-hgNKIrBu7iTlLZwzXRxAjTwBewPiijs2QLxtViySE
    dR2DQsfS_Xve4cg_A>
X-ME-Received: <xmr:SZsIaLBuEvh5QSTla3vDGkWCCjFM3_eVXqzbfR90Qti-8rUSzIVjVWCwADM4qbNRPiT03gZLTmnu55V4bzjq-bLKSYwvqZf4Vp-QF_F5hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektd
    etieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SZsIaBetbh6EaVG7lM4TJx_mJpEc5GEO_Ugbdu34gZwEkFQwZToOXg>
    <xmx:SZsIaCMhGiQWVpdVrcei5lqiEfxTVv3uX656x4TuC4L_7lESOct36w>
    <xmx:SZsIaDkqEECKzjLhgkcI_irWyX_HIMoYHEkRTUu2AkZA-_HlNLhKWg>
    <xmx:SZsIaMvB-pknQ9S_N6gwwkHYAlBFNLr4juR0hiXHs5tMwUGSZSAgHQ>
    <xmx:SZsIaJpB9cKsBT2RPhygFjscm0q1ov09n9j-KPn7RPEI2m71Oeq0_cV->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e996df3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/13] object-store: a handful of cleanups
Date: Wed, 23 Apr 2025 09:48:10 +0200
Message-Id: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADqbCGgC/x3MQQqDMBBA0auEWXcgCcaAVyldxDjqtJKEjJaCe
 HdDl2/x/wlClUlgUCdU+rJwTg3moSCuIS2EPDWD1dbpzlosH8E8vinuKHuuhHGjkI4i6EKvvde
 mM85B60ulmX//9/N1XTdXFHsMawAAAA==
X-Change-ID: 20250422-pks-object-store-cleanups-5a6077014155
To: git@vger.kernel.org
Cc: 
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


---
base-commit: ca819c0751cedd1713334882e4c83687f8478a54
change-id: 20250422-pks-object-store-cleanups-5a6077014155

