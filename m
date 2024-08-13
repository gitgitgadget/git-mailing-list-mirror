Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C2189B9A
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541524; cv=none; b=APbMDw7Nibjl25OdmEZ3pfRA8fPRF5sNj+YWqRRNe+NBjyJQ2B5bl2wDet/Dbtc+dqc/oelE4i3UvlxWVk77UhtNcM+QJ5w1VjcX5TNnUfAF+Bi1mfoelwnQl7NRyx1vPhtXn1rryAPeHYGTy5AKircdCfFvc4nrwycJnxKkLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541524; c=relaxed/simple;
	bh=yrlhgSdKEnDhi1HUwtx7k/dXX5LhZXH9LP34Q/lwjIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWtxYSrjIawyNZJwXda5Zw/F5v8yFBHs2cdP5Wbnhzj0Xv3gj78rEpB/NgdRoFI9wCoGQ0hK7oq11OSmvlX4XcXToE4f/vLO8lS6wIAQkOfMuMnnbn7u2w8P9KNmOAicC0sKhnm0LmiOIF+iUjtdW821FVtdRfMOTjqsRiDyYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KpgEHABm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ckAoQIPU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KpgEHABm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckAoQIPU"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7EEB11151BB7;
	Tue, 13 Aug 2024 05:32:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 05:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541522; x=1723627922; bh=vBXD9cXde1
	d+k0rRqwemqouzQf8J3Q5zX7ul7aMo7qM=; b=KpgEHABmD3yVdKQE+CmBBo9GM1
	7EBXOw5v89l0eRKfGQVrhljn0FQhMAD/ZVZnluyCiXSCI+kSExWVqZAYNsW89aAt
	Tz6WH1pEP6D7ks3btATwNoiP94tx7izJYZx7pzG/WldL4UW+ZMMhfBl/m3uOcjMk
	ujSrCiKcA4H48d9yy5Y/DsP0LbQYoeJYVLUFoGeNZbFq7BKItW4rvDgE0He2u01+
	r9jtzGPT1Ko5lHBF8Vq/35cHVdaxXAAnysuIXJzVrxfpE+21YOxHvIw9RoTIi55W
	bCVePlLejh1iWq9kqNdd4I1nimEBWOcCVBDQBpzrA9v3MmbqMwnP27RgV/Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541522; x=1723627922; bh=vBXD9cXde1d+k0rRqwemqouzQf8J
	3Q5zX7ul7aMo7qM=; b=ckAoQIPU6gI02pzMdvjkHGVUT427vHN+ETnd0TSSs8Wn
	5StTV8esP64BAz/kCjfIvPmyMvdBBgEomYBZQpKp9VSqJpYgAa+JIaLc6YcpZ4x5
	oqGa9GW8zyHbFiJ4TSdWdAz7j2IqQ1m9PG8UY/PyPWfI8dwiFCxj/j5vDxuQsHHr
	/qoyXWUE5+2v1gF6lxaMJkd6TXbs6RaKC4cgVA0ass7Ir8eCi4jzzdMUkbLqNmza
	VyZN3rihJhSBucvNr189cftb/aIFcPFwgfxIsdXFdgh9auPpsCDWCKjbSuOqFUIF
	0z5DZ59mLNWIdhme1oUaIGcTZeEWjv3UcHxY3OR1ow==
X-ME-Sender: <xms:Eii7ZggqqEV05mY1jw4CErGpL8mbMTMXCJPyFIu4M9ESvFBBlHNHAg>
    <xme:Eii7ZpAxs7XDKV_zgKtYd-IEZHBrLKRdbhJapB6L1MsgEftIo0n3eoykxpASaJ35S
    AtKeLQkwg9pcmNu-g>
X-ME-Received: <xmr:Eii7ZoHS8-MEGXK3jjt_qNY6OerLDm-XcbdAh-wVdnud_0GFO9RcpC7S_AapYxpo9ISz8v95Z8OFApRGvL-Gqv9tx2aVrshfpLpv64y9iu-AEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjrghmvghssehjrghmvg
    hslhhiuhdrihhopdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Eii7ZhTzv0-MHk92oH9BGfBYW8ghWCd3go84gds2yj_DAz6xzkiW0g>
    <xmx:Eii7Ztw70hPN1EBo-aCH7kOR9pIWTGKaMeW-EgwgA2flLKA0igUeog>
    <xmx:Eii7Zv7AAcpz5a2SY05NRG7ipLiCmj3XPO4vzJ_9lqjeW5XJnDacPQ>
    <xmx:Eii7Zqzx6DZdp9fxMoVCoRU5Jhks_3GPi0qfsgnkf2r-lXqnsgks6A>
    <xmx:Eii7ZkkhFLeb_Bz1YfKXt6HtzTLZGOZtctndQR0B38Y-yE9JW4mfvGod>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:32:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1655c38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:44 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 17/22] diff: fix leak when parsing invalid ignore regex
 option
Message-ID: <e1b6a24fbe507c88695deca8ec71546bbd4e12d6.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

When parsing invalid ignore regexes passed via the `-I` option we don't
free already-allocated memory, leading to a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c                  | 6 +++++-
 t/t4013-diff-various.sh | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ebb7538e04..9251c47b72 100644
--- a/diff.c
+++ b/diff.c
@@ -5464,9 +5464,13 @@ static int diff_opt_ignore_regex(const struct option *opt,
 	regex_t *regex;
 
 	BUG_ON_OPT_NEG(unset);
+
 	regex = xmalloc(sizeof(*regex));
-	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
+	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE)) {
+		free(regex);
 		return error(_("invalid regex given to -I: '%s'"), arg);
+	}
+
 	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
 		   options->ignore_regex_alloc);
 	options->ignore_regex[options->ignore_regex_nr++] = regex;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3855d68dbc..87d248d034 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -8,6 +8,7 @@ test_description='Various diff formatting options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
-- 
2.46.0.46.g406f326d27.dirty

