Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885EB305946
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649735; cv=none; b=hURxu/tJ9lSKtyIBmanPOrotpp1XsgZmtOc572XskihwCQLPg5+5LRQJn0yUFbTDVI5UT2FG2w8qwcr502YL95+D4NJYsuRFAllTpVk2YoNnZ125NjPiosvHgQkiOI4knEY8nq2RchlszYbk1zjRH1qdWB0dudT9Mp4hPKd1TJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649735; c=relaxed/simple;
	bh=MVrebqT5A+l+66gMgZ1dmphFaeR1WeWofIQHxKpgMe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOnpGW9LkkHRKrMdWnM+IUzQkzYlWd8bKvp4Cjj/wK1+TPhxVtpiWh64BACNUza7yOs6k0ZhgYS0vy0OgeN0qiT7SQ5g+b2xpad3WHfkPgVuTo6pL/6PdYYhKJ4jzrP/9yFJ53qrGcE25W5dX71BT3bRiZyL/R+5vSxuxQpFIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OtXsRdGm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zKIB14MF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OtXsRdGm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zKIB14MF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B2999EC0389;
	Tue, 28 Oct 2025 07:08:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 28 Oct 2025 07:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761649731;
	 x=1761736131; bh=Z5EMcDtnGGSe5O0RuQ9Jq+KYESm1YPA70rKui/Sxam0=; b=
	OtXsRdGmalp8GQWDLixB7g/OpoQL8a4SI1V+Ba0a85BSWzt9olx2OsWDQX+4B7gF
	WHk/gHfv3EWYOqZeuDDx+qiQyCKmDh30YzJWk5AJ74en/tMiY68BfQwiPGrTEqwg
	a2wxFbhzWvzDgE/5df4SSjAA0uMSzPREHi0iOQZSStRF3VSF7HomKOHVuqW+bXw6
	jfe+nNS2hXH7uI1r8xpR1/FLOTtozGYVBiNXv5GA8u1Rh8V0zpA+wjoMYMKGUuuO
	KQ2GuGxdwYGhEexbFDTBRDm3lgDC9j6S8ahCmWg1iXg5Cfv4D22vW5F8a9b1qPZj
	dCEek1lFT7CLhplHnF3rwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761649731; x=
	1761736131; bh=Z5EMcDtnGGSe5O0RuQ9Jq+KYESm1YPA70rKui/Sxam0=; b=z
	KIB14MF8nBMqQOjuT5eF3RcbexfMk/+ShS9SAPFVSwBDjrRLw+eoSKJlKPVbIuYU
	EbTWonePZhd/Y3PleDawTlr2iSqYgJZYsOzt8eiYNjN1BEDLNMuKUGQKH+FEHPOF
	SGhubLvN7ZxYA1e4WFWWhmelcZV+zpbop5qelxAVvqyDm/01i0t0iewfTtKmRrvA
	J3tbiJ1DLy8RyOj1EHClecminEyQ1csz/SMrX8m4QpX/nv5VSCFfkuyVESEDlICZ
	MWjeru99r9WvEYLVeZ4Flo/zeWZDo0GBa6PNP/kMhzyXQNPLbv4cUwH5m94WbaKD
	KBAX+1bZXu9oDN8rWhWKw==
X-ME-Sender: <xms:Q6QAaTsQiLbW_Ooe6yHDv-jeJ-KWLwfd72w2b-UP0dKI1EqOkeVT4A>
    <xme:Q6QAab7iucjt45ZhDR-ICy-rkK57TCW0WLQM4lkAPjXS3vd6jbJwHeHz77uyY9KMW
    rLQLtUfzT9W5wsjhl8wtd3F79coE4euz2FHCWBA301v9foCtbzs>
X-ME-Received: <xmr:Q6QAaUJHgniXcQJtHxa-sUyAlGG9BK6nByaCuOwOKX0DqwjFugvhWfhKNf_5t6iin6oNEzxUvhiRCp5PaYLoSmiMC3iqZpnQ3G8Uoa0nYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Q6QAab4mIDEllFOfDEnlRGrymY5jhSvIj_SPnJFoL6gGCgXYB_AJUg>
    <xmx:Q6QAaXyuCLNOxNEgbQPWybqpBJA0wuujRHZOXI3qRnWDRNd8JuciGw>
    <xmx:Q6QAafYzV3RJMqPbU421SDTMD0U09si9S3bPnxxFe4n_kdZNfC6aiA>
    <xmx:Q6QAaZQta4rusUkzjeaSNUTi-y8I5RYPSIESSqfScL_X8oCZx6wXkw>
    <xmx:Q6QAaZyZCC841I6Snc0Ej5TdjjcUtyQIiGmGK8DzZnAFIxAHcODJCK8x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 07:08:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23158b53 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 11:08:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Oct 2025 12:08:34 +0100
Subject: [PATCH 4/8] packfile: fix approximation of object counts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pks-packfiles-store-drop-list-v1-4-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When approximating the number of objects in a repository we only take
into account two data sources, the multi-pack index and the packfile
indices, as both of these data structures allow us to easily figure out
how many objects they contain.

But the way we currently approximate the number of objects is broken in
presence of a multi-pack index. This is due to two separate reasons:

  - We have recently introduced initial infrastructure for incremental
    multi-pack indices. Starting with that series, `num_objects` only
    counts the number of objects of a specific layer of the MIDX chain,
    so we do not take into account objects from parent layers.

    This issue is fixed by adding `num_objects_in_base`, which contains
    the sum of all objects in previous layers.

  - When using the multi-pack index we may count objects contained in
    packfiles twice: once via the multi-pack index, but then we again
    count them via the packfile itself.

    This issue is fixed by skipping any packfiles that have an MIDX.

Overall, given that we _always_ count the packs, we can only end up
overestimating the number of objects, and the overestimation is limited
to a factor of two at most.

The consequences of those issues are very limited though, as we only
approximate object counts in a small number of cases:

  - When writing a commit-graph we use the approximate object count to
    display the upper limit of a progress display.

  - In `repo_find_unique_abbrev_r()` we use it to specify a lower limit
    of how many hex digits we want to abbreviate to. Given that we use
    power-of-two here to derive the lower limit we may end up with an
    abbreviated hash that is one digit longer than required.

  - In `estimate_repack_memory()` we may end up overestimating how much
    memory a repack needs to pack objects. Conseuqently, we may end up
    dropping some packfiles from a repack.

None of these are really game-changing. But it's nice to fix those
issues regardless.

While at it, convert the code to use `repo_for_each_pack()`.
Furthermore, use `odb_prepare_alternates()` instead of explicitly
preparing the packfile store. We really only want to prepare the object
database sources, and `get_multi_pack_index()` already knows to prepare
the packfile store for us.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6aa2ca8ac9e..6722c3b2b88 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1143,16 +1143,16 @@ unsigned long repo_approximate_object_count(struct repository *r)
 		unsigned long count = 0;
 		struct packed_git *p;
 
-		packfile_store_prepare(r->objects->packfiles);
+		odb_prepare_alternates(r->objects);
 
 		for (source = r->objects->sources; source; source = source->next) {
 			struct multi_pack_index *m = get_multi_pack_index(source);
 			if (m)
-				count += m->num_objects;
+				count += m->num_objects + m->num_objects_in_base;
 		}
 
-		for (p = r->objects->packfiles->packs; p; p = p->next) {
-			if (open_pack_index(p))
+		repo_for_each_pack(r, p) {
+			if (open_pack_index(p) || p->multi_pack_index)
 				continue;
 			count += p->num_objects;
 		}

-- 
2.51.2.997.g839fc31de9.dirty

