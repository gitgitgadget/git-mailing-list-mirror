Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98045191F8C
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162749; cv=none; b=HV1OENJW/1TBBugOOXmTc9Mh1tEH/1XoIbdLNJrvAc6JKn0kUHeOBmk9fBvcoIzN6NSnM0HlJv6GOs3WIscJ0i5LuBGd3v1fcxiNci2sBGe6q9bB4E0g6pJNS8Sd7QnxjkAyCTxCM6Ka+XxvGsMTtF3EmPc078QfTT1iPbXw8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162749; c=relaxed/simple;
	bh=9wQt4BHiI/bt4NyKITEtRjgp3D8b62VJEnSMyDCYMkQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3RV6Cwl0R/L6lJbT2YhUAS1OEK/XItLwlw2DBjXcukdSYnbPaeAU7NATVQz0jDJyg7AUQWFV5lLu0Oj+PnxZqVa+sw/JXJZx6ieLRo3SLUkatymNQG99ikbh/A3RV+p24U4AaAEi5lhU2ytLB+MD/iBKf6ozIwhPoEjJn8rMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HSPgQyJA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYeYbBWH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HSPgQyJA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYeYbBWH"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id ABB5E138FC5F
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 20 Aug 2024 10:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162746; x=1724249146; bh=jJaGu/U2tT
	ESezbyhYQIMT3CF0nv9IjwY5IFbxYDrss=; b=HSPgQyJARPkd8BbZZokc2dcGkk
	e+55LbvP9FAZtu9F5uOuLjpIn+GukK87Bh4z1XwZpgwyjGg3h/IWSdwR05vV6e4n
	fa22MdijOR7Fg4zGsgahl+Q1wGgni9HUOWIO5gkk3c89QfB11208okX3ZJauU0n+
	P4IxUqxH6g0TbXTjn3CZgdr7kOqqs/tAQzfa59WolNNssD+J4b9hjv79UBxnCA2T
	N6NOlOqFomMUIUgwvOyx+ExwxL1E6RbhJzVUldvQtYLTdtbCdrisangXUJAO/5vW
	4FfWxUhUbZRS8dwhLcj5NW651nHjaRVWggalmgrjOt6jHiATy3ec8fYuQYfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162746; x=1724249146; bh=jJaGu/U2tTESezbyhYQIMT3CF0nv
	9IjwY5IFbxYDrss=; b=DYeYbBWHo79BatZFbgTm+gdMIPZJPW15ItYtbn2jh6D5
	M5vrELki/gWIxh6q4cilFtuKcAx4JUTJA4pRh1+oRqh0zxGuSF//UpahEW/d/yOG
	LNsFgSabqJYlb3V2tOqPDPQpj3ZLFmJ4kbkz1IuDNEKy7dQ4ccT3LgLGchbtyh0A
	jr0Ruqx/9HhdtMVXuvsq7jnH1TtrwZXY09U1n8NJ/4T0HNIxs+rn5tffEKWF1GOC
	xUmHYtvF6plvSbU4rS6hdcvZegLfr8n0RA8zkhtH8i9ImNHnMKLHRK/y55ORKicY
	7T38uvjfMuhYgVRrxW30taMBE0NExdaz1wzHi0nh5A==
X-ME-Sender: <xms:uqLEZqb2_siYedaAUEnGRyg8o20lr37nCQRwAMlxdYC-Cky7cFtZ_w>
    <xme:uqLEZtZEJkO8vES1etMf1EHXOJOckNHOl2BilgHeu7hl7EUo4T1KxECXPP9-ro_Cb
    rNDeOSPxD5X_n2MMQ>
X-ME-Received: <xmr:uqLEZk_ry_mjPfvzLl72_pxi1x4ZoVjakorGbUwHcBwVDHEc3Gb5oGpextBnIf-FpoqSz3WyXfetukVHyyaPVTSkJhbV6DfygpN5OQDirDBAslpgmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uqLEZsqW80ToF4FvL3NkRfm-LSHO13nZPdxzkQsZizJgYcbKmiJ0iA>
    <xmx:uqLEZlp0rJ_EmQDBZ6Z8U86cgu3awKud1cHLMwjTvap-vZz60FTbow>
    <xmx:uqLEZqQC1bzDParlMCFcDvS_yfwro6506GcQC4nOHkOB6Sa6JQuLzw>
    <xmx:uqLEZloJ3-C2ncLqH8gqF8FZqeDjUbLRVyjzuihvWck48BwVjDYYtw>
    <xmx:uqLEZmDxlopC-P_kOepBZloxvg0eg9NyDfHTlGZoH0PP_z2yT4AeqUdJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d80dbe4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:14 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/20] builtin/fetch-pack: fix leaking refs
Message-ID: <1c94195488d2db8ba169368a6c28171d5a2640f3.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

We build several ref lists in git-fetch-pack(1), but never free them.
Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch-pack.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index af329e8d5cf..fe404d1305b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -46,7 +46,7 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 {
 	int i, ret;
-	struct ref *ref = NULL;
+	struct ref *fetched_refs = NULL, *remote_refs = NULL;
 	const char *dest = NULL;
 	struct ref **sought = NULL;
 	int nr_sought = 0, alloc_sought = 0;
@@ -228,19 +228,20 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 	version = discover_version(&reader);
 	switch (version) {
 	case protocol_v2:
-		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL,
+		get_remote_refs(fd[1], &reader, &remote_refs, 0, NULL, NULL,
 				args.stateless_rpc);
 		break;
 	case protocol_v1:
 	case protocol_v0:
-		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
+		get_remote_heads(&reader, &remote_refs, 0, NULL, &shallow);
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
 
-	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
+	fetched_refs = fetch_pack(&args, fd, remote_refs, sought, nr_sought,
 			 &shallow, pack_lockfiles_ptr, version);
+
 	if (pack_lockfiles.nr) {
 		int i;
 
@@ -260,7 +261,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 	if (finish_connect(conn))
 		return 1;
 
-	ret = !ref;
+	ret = !fetched_refs;
 
 	/*
 	 * If the heads to pull were given, we should have consumed
@@ -270,11 +271,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 	 */
 	ret |= report_unmatched_refs(sought, nr_sought);
 
-	while (ref) {
+	for (struct ref *ref = fetched_refs; ref; ref = ref->next)
 		printf("%s %s\n",
 		       oid_to_hex(&ref->old_oid), ref->name);
-		ref = ref->next;
-	}
 
+	for (size_t i = 0; i < nr_sought; i++)
+		free_one_ref(sought[i]);
+	free(sought);
+	free_refs(fetched_refs);
+	free_refs(remote_refs);
 	return ret;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

