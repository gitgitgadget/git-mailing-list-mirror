Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D4194A59
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541521; cv=none; b=rl/3LXvzVkD4wTwpROSZX3iZ03hDPGuTVxaMBMV1CASl7eQO1TEKj+BPXxM+89MRptboLZgD5bIoVnvvOnwJ/giNDdzaBKL7bdUcmLWIe4/eCYkMZoTOZFNkxyjpIV0xvgGqqIQL7cT1WyiRjY6KwyWuCFIsLRH4GljdbU/rSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541521; c=relaxed/simple;
	bh=ITE4erRc/b8Y/qTNPG/XLEHIMWZjT1sbyXWO5GLDM6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA2PTGI8su0IYC2l5ycvSZLMBHI8MsEOMZL+5Cz4ada001nlk0i4ziLzvaIcxeVltUbPuU/JIwG1XbMqKgcSaAnDJl0VL9D4rNfVdxWebtvPWXFOT0IUgvGQ5u2YtavsTYUh66Z6sozllA0+er9ZYmakboQcnTRGLRKIirWPLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DNFo9Pl+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVTiOcbE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DNFo9Pl+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVTiOcbE"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 060CA138FCF9;
	Tue, 13 Aug 2024 05:31:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541519; x=1723627919; bh=r5fZSpie5H
	T8amF2hqjnv7n2KKUlCZFOuB9vonuv/XE=; b=DNFo9Pl+jyZz0/5uY0Q7ukVhKU
	9Rn2K07z3x84a9x8zKv3OG5iBn8VcT5hfYTmr+7KYT10JPR/oInKa4O7nv9kJlxU
	DMyJEPLGOiKDFsWQs61QpdxhlTIic1ZsxfU6bvApzqR/2S6oAU4WsaX5A+V0BTO7
	MENFBUaRRiSw4zXybiuYNuNCnFPNzRx75pk0eVYEXYkX1v5uFfIx+TYfXWBJAapt
	b+rv5ypdFQNSIIBhM4xP2cwF36mizI17LDEJtDfadoGxWC/QhiQNxUDKSQ31JgFo
	fqMG4YQjri8D3QLX4nHi1AtmOlMP84S3lsvUKEDTXewJ0YpelnGYkyex422w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541519; x=1723627919; bh=r5fZSpie5HT8amF2hqjnv7n2KKUl
	CZFOuB9vonuv/XE=; b=cVTiOcbEmgXL457Jt0UA8B9sx3HnVG9y5gdbtqzIC3rJ
	676rvs/0ThtYkRawBguFpwa4ZVjwVeeLi2jToEMUhi+7/K2wq0zZVTlNP8M6daG0
	x7V0m9L+ODrFlaa4bR7+gVpF40+bs0lISiWPvm04ya81cCJiBXXOkeqkIRt5FfyL
	ybSxosFwDUo1OA40v+lU3UQ85vS6Y8cOqh04E9Vp+YlH7MGo8YVIfHdmDuA3SzeM
	9Z16TJRLp109/2u17pG3M84IXxzwHYaec7BqNS7prz+PiFXEbB6E+8DXgHSsxcuo
	3fnX1x6t6tvpmF86XFJ5mHB6B+VKz4tBAdFy0KEm/Q==
X-ME-Sender: <xms:Dii7ZoEu0jF1zA0BOjPP59FToNoi_cRB8mgG9jmX-RUcJ7LTsou7Bw>
    <xme:Dii7ZhXPJxHDZ3BbTeYKqiURW8ctO0qdjj7bvvRzkON2xFQulfF62oVIjiWHJi39o
    Ye52zDlhkUykvsdfw>
X-ME-Received: <xmr:Dii7ZiJivCadZaEQy1tJQ7ZmnsvmWeo-UFjya6khQ7Ztd884Byb6qqBEFZDbqFn-MuyNX48i985PaGgOLkCKMWil8yl601ncoWTTYt2H1FqBiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Dii7ZqHAm_ZkNRPsxsVrLxiZ4PARMpvxgiMyq3_7mpMRmbVNvjdVng>
    <xmx:Dii7ZuVuEV4YZnJ3fNhio9sFLd7nqg-gnrA7zWqfDRTAZCPUcgWm4w>
    <xmx:Dii7ZtOREAkRKMB3rlBktSFTmFjGRE3FHMXPSlzn9GU7WhVy5tbnBA>
    <xmx:Dii7Zl06M5o_OPt6E2BA2BzOwxwJAqJLhYIcUYIM4lQSdswZRFXvyw>
    <xmx:Dyi7ZgI2nGiufTZGj_rlba2UVx6CkKJzhlG6dR0q7dKxRtX97_qMoEIA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ea3bc97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:41 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 16/22] unpack-trees: clear index when not propagating it
Message-ID: <5d4934b1a9cf402cbae2f25ef4e0254d45e31e21.1723540931.git.ps@pks.im>
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

When provided a pointer to a destination index, then `unpack_trees()`
will end up copying its `o->internal.result` index into the provided
pointer. In those cases it is thus not necessary to free the index, as
we have transferred ownership of it.

There are cases though where we do not end up transferring ownership of
the memory, but `clear_unpack_trees_porcelain()` will never discard the
index in that case and thus cause a memory leak. And right now it cannot
do so in the first place because we have no indicator of whether we did
or didn't transfer ownership of the index.

Adapt the code to zero out the index in case we transfer its ownership.
Like this, we can now unconditionally discard the index when being asked
to clear the `unpack_trees_options`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3705-add-sparse-checkout.sh | 1 +
 unpack-trees.c                 | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2bade9e804..6ae45a788d 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -2,6 +2,7 @@
 
 test_description='git add in sparse checked out working trees'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SPARSE_ENTRY_BLOB=""
diff --git a/unpack-trees.c b/unpack-trees.c
index 7dc884fafd..9a55cb6204 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -210,6 +210,7 @@ void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 {
 	strvec_clear(&opts->internal.msgs_to_free);
 	memset(opts->internal.msgs, 0, sizeof(opts->internal.msgs));
+	discard_index(&opts->internal.result);
 }
 
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
@@ -2082,6 +2083,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		o->internal.result.updated_workdir = 1;
 		discard_index(o->dst_index);
 		*o->dst_index = o->internal.result;
+		memset(&o->internal.result, 0, sizeof(o->internal.result));
 	} else {
 		discard_index(&o->internal.result);
 	}
-- 
2.46.0.46.g406f326d27.dirty

