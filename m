Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876D2FFDCE
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649725; cv=none; b=GoVd3JJOiarn90ElvjrzF2h4DwqxGIZaB9k9iHXREaN35BwHp/bwXJHHjG/OLqy8y57TAInJvUWLzSqDQZF19ZDcrewYoeZUFiD2oYr0beoeSZHI0b5l1JzfRnPpcGQL0jv57+fWuT0P2Ey5GLhktJkC8SDNSeIs67dXeT2btuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649725; c=relaxed/simple;
	bh=KA8PylC4JQPl/IO9ovJ7EwmFeNAvGM9sPcUIVq+Cf4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fITVKstZhBjN0mmS82TlRLXGKEiWy+WV6DZcQvE/Mu017WNm3fGkqPqfsDvjlUEjqFceqtsvUgDL48JJZTcrL4ijZj8YxsULJTapVnqaaNeNNxfW7ZJOoOWsnkf9maxwvdGfkQVk7j5Fg05jJRcJzS52ZtMO8h7/OOX+nX3sbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sn3exUiM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sHsa3hG7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sn3exUiM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sHsa3hG7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85D031400357;
	Tue, 28 Oct 2025 07:08:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 07:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1761649721; x=1761736121; bh=xGl6NEMEAX
	vDCd+IUaVW875rhYzb2/czWBJVOS+AC2Q=; b=Sn3exUiMWiYWz0O65OcLiUDyWf
	keabOqrENIz5U3wqh/Aa1O2WrQK3l4SqPPhPswQlJY/BXtohcGl8YVsxZQFNwJxC
	vHEZgbSAiGetM2mU+g1iOzqXCSad1rpk3dHLoNbXcE6lQrnb8gmrCVdUZUDtqpsR
	yqZyR+ls0WOU8yM6UCIcIKyYvhh4T23cVfRgU4wIWSUOU+ExqrkrnCMVDYnp53Le
	1OSq1vrlaGNeRUADZ0zBY76u7rZNtD/mJLXSviEGjoc49pmCXyIjl0USe+81EmI4
	G01tjDV4v9kSi58U3B0SNriIZMC4Kmg6oz9gkdjsGfqD74kPoNo8u84P+KQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1761649721; x=1761736121; bh=xGl6NEMEAXvDCd+IUaVW875rhYzb
	2/czWBJVOS+AC2Q=; b=sHsa3hG7szheEJI2974NUkXzx1U4dlVc7uWePo7dPkW7
	j93aUAnOt0D1CtyMnpbmobMU3cH5annW2Ryk0Bop+31b74uoEbm3DNkppylDHkI+
	v0SIoOMSaOTejI3E7VAhjHPx01SlwBtdYh4kJaR083Sr1EbglAqaDcb11EmdUjEB
	97PB7KHUFcKV11Vq+A5ufbbQig8FwT2Dy0PJ04v8qKK24GPIUBY4KHXb3w5WjHv5
	dYyLIBurFdQJ6AJ+9vUiVxKUNEjkzBGAQgLwBQ4Tj87yvT9Bqw0ME+gSruHvTmjn
	n4/a73DTv1jSJ/XeRlQ/KIXmsXYrcQjH28UqzP6/aQ==
X-ME-Sender: <xms:OaQAaVcE2udkzq1H-fzRG--uDmrqGTsmfsh0kg0HjAs7Aq8UbhWyVg>
    <xme:OaQAaar6v7t4Z16aIG8Q_mklqcwqQ8PDESPSmiQiLPzyAYMsnhbqG8jD5EsO99B8P
    7Laf-MQgY1gLpXkO-g3FCJQyat65_qdtfwS-nvuCDJGHmmWyw_1>
X-ME-Received: <xmr:OaQAab5-KCHKH2h4M1cN5t9Q7gbh1pyhRbEoqF1KfX8UI96jRfIgcJ4pYQqmkB6wjmNs-MpiQZxbrWYXBnS746wUvEujgsXwcWulbd74mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:OaQAaYouDwSVVBZ_4jA3K1Y8A7LSk0jotbJN6IQh9BIFfq7F78uwOQ>
    <xmx:OaQAaVhI4FsjvUgdV0qtoh-gkhVQVC1g1W9kQbDuYfMbE8kmzE24WQ>
    <xmx:OaQAaaJeL6uOOO1FBOjjPk_e1Qv6lOdcDldk_xZwP83hCj9-ItT1xQ>
    <xmx:OaQAadDgW5klECjPA26NfKrpPuSc3fIweWYAvP7W_VWn8mMLeaWsWw>
    <xmx:OaQAacjtQoKxgZga8rdRNFX6LdHX-b1FpLvYwnCZWHgKwP5enGZZvd5q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 07:08:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ce17ea9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 11:08:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] packfiles: track pack lists via the packfile store
Date: Tue, 28 Oct 2025 12:08:30 +0100
Message-Id: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC+kAGkC/x3MzQqDMAwA4FeRnBdo/RnMV5EdsppuoWJLIjIQ3
 93i8bt8BxirsMHYHKC8i0leK/yjgfCj9csoczW0rh288w5LMiwUUpSFDW3LyjhrLriIbfjsmRz
 14UXdB+pRlKP87396n+cFcDKdsW8AAAA=
X-Change-ID: 20251010-pks-packfiles-store-drop-list-64ea0a4c9a3b
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
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
 builtin/pack-objects.c |  35 ++++----
 http-push.c            |   6 +-
 http-walker.c          |  26 ++----
 http.c                 |  21 ++---
 http.h                 |   5 +-
 midx.c                 |   2 -
 packfile.c             | 224 +++++++++++++++++++++++++++++--------------------
 packfile.h             |  70 ++++++++++------
 9 files changed, 222 insertions(+), 171 deletions(-)


---
base-commit: cad6ef1d7514e7450c04c2fe624a55b28d99ac88
change-id: 20251010-pks-packfiles-store-drop-list-64ea0a4c9a3b

