Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332B199E95
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530984; cv=none; b=paDeDv66pKdCVZdUsy4qlDqMNwF3QjrnbfMTYvURXD9YyNw8TyLSary9/Ai9NDGwIB3fq3ehYbC6vBq/w5YC+jT8neDlm8SnPN6IVeYNtb5NW/WzgwLYxvzb7HFBRxD7brtwVTR2KN0sfiRx3RflKgiZCXsUDsnR2PZeHj1/2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530984; c=relaxed/simple;
	bh=rblmIVlmQeoJa9epGSp0XyYAS5PHDIgfn4+UACaO9t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr7p/m+kIaJqmdk0Dni3kmVYVOqLDzS0oxNgqOkkddHLp2oJJrh2Elo4R2pHmh0/K59X4TxKcRHrr4axLpbDPWZ7JJ2jcCaotG/2knf8yW/Ugik42/Js1y0Ax9lNLSUEkwObT+Gw9AWftAajv0+Cogv8PwYb2h+PP8zDu9GYtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OldrCHra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPdXnz0E; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OldrCHra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPdXnz0E"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4532111400DB;
	Thu,  5 Sep 2024 06:09:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 06:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530982; x=1725617382; bh=eMUxY7aO7b
	y7bE+OOsl2DwEqLYDj/Kaz4whM4imcRgo=; b=OldrCHraf8A3Lnu7cGf9HfWqgT
	8Z4snguw6QBXVqjw1cdy+clSvO00bAwTN5F5BB9dfcyVhPAjsUq6xD9+vDTdTfjT
	17Cw+Y7IXn86CefrSv4t3GM36QQRfcoanU6IOCK+iIUUmKNwrXE1VTiGgAat7Nmm
	y1Dkzy1sOKlTAP23Ol7S/6Hhw7S3Vfp5jvy30Ofbx5Igr6ncrvPORyQZu8ApJADR
	z+cHM2M/t4rFpun8ryXvS8VIqICg83JQIRnmX3xdC1GMaJ50UxtLDDaZN6MPnoxy
	wQuOaAmdgpLgGsMc26RMa9NjZgZAug/b7qKkZ4iwmcnYY4VpHAdJwYAZ9AHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530982; x=1725617382; bh=eMUxY7aO7by7bE+OOsl2DwEqLYDj
	/Kaz4whM4imcRgo=; b=gPdXnz0EAX5Pbt6X+qBrEPeY7xCVNFf7wZnmyZ+5jX0S
	BH2xyZCsHw5VhvIjhI8Oz2n9COuD1Ng2q1HWZTy7RZ2fj30BrcmWOYsTjNM4fOBt
	qFdUAxgKrMfR9XQGAF9JakW4ZYG6jvWA7YTs8OlCBHTSfMzm56TTXn8LWtqjk3Oc
	zpWbAZXhcg8gAGBO48LicSPsP7a1CqVLoNvrnc6F0mgorvWsPrdI1+em7lvc0Z8j
	KhHV/h69O2aRuBZ2hiz5qRYeHSz2eh9cNtYWAOIJ9pCo6yMFd5ZGJjth86v16OvY
	K9sE3/NulIoK5I8d8WSCKwm/ptkBlA3s28e6Z/q+LA==
X-ME-Sender: <xms:ZoPZZuzK3Hm2xdIPeFSdwpsP6qWxhrP20AjbeDKy3KYHPHNdmW13-A>
    <xme:ZoPZZqSK2ELwTJGytvKtSNBPRU5r0Uds6V576APC0y2SN6t9ENMsWxyVSqt9kW5k2
    WV6ebLvKoIIbIzSgA>
X-ME-Received: <xmr:ZoPZZgW4UgEM0qGWiMvAwaFwGkssZ49Oe1qz1-TPYvd9o3NUFpJMBneu3Gof7WCnql9M8rYv8asaYFbUlN46OqbC737BL3Sa3VIqnQLjkOchpHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZoPZZkhEDCG6hJqHOFvzp2H-_-MwMfpYj5xKFbeKJ9Xcgd6e226ryw>
    <xmx:ZoPZZgCHNbbeNESjsmdoVFdAOYxKYVnPFKo__P3xWFeYqe0TQWZ5DQ>
    <xmx:ZoPZZlIX-6CysOOpcnTOnKTLWkJF9YyTb07i877dnlMOxCUr0qhJ7w>
    <xmx:ZoPZZnArEjAHBqgI0vU_fJI3quq3HHGmRdaBKEw-vAbT1MeboZXUQQ>
    <xmx:ZoPZZi3DAskq1JmvL4585brszVCI12UeuAMIFzaRYWE5qqf8El28h4MS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33a5755a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:29 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 21/22] merge-ort: fix two leaks when handling directory
 rename modifications
Message-ID: <db0e7a8733ae52e5fe0f513ebbfacac5a4ac5bbb.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

There are two leaks in `apply_directory_rename_modifications()`:

  - We do not release the `dirs_to_insert` string list.

  - We do not release some `conflict_info` we put into the
    `opt->priv->paths` string map.

The former is trivial to fix. The latter is a bit less straight forward:
the `util` pointer of the string map may sometimes point to data that
has been allocated via `CALLOC()`, while at other times it may point to
data that has been allocated via a `mem_pool`.

It very much seems like an oversight that we didn't also allocate the
conflict info in this code path via the memory pool, though. So let's
fix that, which will also plug the memory leak for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-ort.c                         | 4 +++-
 t/t6423-merge-rename-directories.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 3752c7e595d..0ed3cd06b1a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2710,7 +2710,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		struct conflict_info *dir_ci;
 		char *cur_dir = dirs_to_insert.items[i].string;
 
-		CALLOC_ARRAY(dir_ci, 1);
+		dir_ci = mem_pool_calloc(&opt->priv->pool, 1, sizeof(*dir_ci));
 
 		dir_ci->merged.directory_name = parent_name;
 		len = strlen(parent_name);
@@ -2838,6 +2838,8 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	 * Finally, record the new location.
 	 */
 	pair->two->path = new_path;
+
+	string_list_clear(&dirs_to_insert, 0);
 }
 
 /*** Function Grouping: functions related to regular rename detection ***/
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 88d1cf2cde9..4aaaf38be68 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -25,6 +25,7 @@ test_description="recursive merge with directory renames"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
-- 
2.46.0.519.g2e7b89e038.dirty

