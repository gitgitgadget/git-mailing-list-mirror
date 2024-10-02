Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346A1E7676
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866575; cv=none; b=rj5R2NTXcagFAdmTT+8NvdL8Ji3653jE6iVioOPpaGcHeSFzt5PakY2DbpcxU1rwp6pbz4PPOFa6T0U643p+n+sSDa5gx4c7lpF6WL5I80x8cOBQuxHwRaROpjgvluzQEh5iCRVlN6/XBkKRqws6KIpJYd7OrUsBeF2Bq7jKE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866575; c=relaxed/simple;
	bh=vV0AsLiyRRy9aJacPjNjqGAPQUnFNugOVkPW5R/4AgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHiGClaHIQ2uK4W8JgmQhQdydkp82guYfmwdsU3O2hY+BrQz7rJCXYZeZZPV+petBfjN/AzdBRjtlXK0EAtk1ADwDlt/6e1Tu/zZJ08UIyUKH+AinMUzeUTMfDwJ24oNJXM9klLNff3INxwXiLaa3Asw9KA1udHOSaKSqqhKnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZOGw5N2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RwEw+hNi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZOGw5N2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RwEw+hNi"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E4BE313804BF;
	Wed,  2 Oct 2024 06:56:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 02 Oct 2024 06:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866572; x=1727952972; bh=xD9RQLoIJ4
	TVbE8oPxgkWYjBzZfkkgReWNVwOJFNAVs=; b=eZOGw5N2RHXqxkIN/NkaK67IKo
	mtUzPcglp7xr5ppFb2be/m866t1rRLRQt5TKiJ0pHF6b32fmFuYpG/1P0we4b660
	jrx1idD5sL6nhh8gT8okuEfuEj0/C3qAfnaVcyXW/KpropeEp9SD57wM8YAZn8Zl
	zbHemJJv2KwyKgfC6p0Tu4uzeg5Aib3wiaOkbweS+dGPMP+SsIP1mitoGlAMLmhH
	ZG+bjU/bRl41jV3+oY0HAwFbb/R/MWP9aDxwzAdLQUH//Gs6scJeEvi8wmEf7I2N
	3u/vTULtppVgNjQfqxL8iWy05WdaY2ne2yzke3Qc9Vxeg0hbd8iRvnqnVjCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866572; x=1727952972; bh=xD9RQLoIJ4TVbE8oPxgkWYjBzZfk
	kgReWNVwOJFNAVs=; b=RwEw+hNiAYYerm8z7nE33yjWfFOTRYfSuACHwtGaohrL
	4W1BAwsmSW7DlGifaRYSAGrAFNcZDRJ54LFVvlolVPFhZa7qNqqb46nnzXv7BGbi
	jB/EHPPrbNK9NXy24ov29v8nUGX8rp9y1U2IkUs6fFBxpBHQPFAOkl13KOH49nbQ
	5ltdZFDJbY0GJvIkU592EuVJlLLg6KE+g7sX+tSKVJOs1eYZZPurMxkxRcp+e1IP
	OFYQRDmiax9cUzhIp0DI0A8BktflvsQOU1cE+b0H7fUYAra80dzmUQ9X+ttVnMhm
	T+UrI8LkT+RhwAoz3//hinY0skUD02djbDhCXCteyg==
X-ME-Sender: <xms:zCb9Zogl8AKBsaqlojwBgInFj5j8k87Y5LUFSddddinL3aPRxkW6Kw>
    <xme:zCb9ZhBHTtPsmGrh0VkY3t5clzljd987qosPLAa6cQsPE1hC62WtDBDr4rvT9ZjWw
    LD25ZSsOiFivCRZhQ>
X-ME-Received: <xmr:zCb9ZgH6TKY501XIr3WswT_5bah5ZmpRh6VgOJA7eWkLhyj3Rze_TDih9eszflUvn58nBuUV0YDz0IXo2LmFHGG7xUMUEmy9T_KpnGylga6mojqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvg
    hthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:zCb9ZpTEMpPbMKLfSaxA2sXU19k6EJDf5h2V0_09ESApoHmtXcbcZw>
    <xmx:zCb9Zlxv7hUYIx1JpIwIsrlbdByDHgGhHc4b9Rm36F-PixVTnzU06w>
    <xmx:zCb9Zn6uSIBShzgihoStky1UJKxW6QiO3XtwYvmKXcEV4x2XXe_sQw>
    <xmx:zCb9ZiwRfX5fqDFs93MVTESIQFN-WfqB7gE7ZyaX8eV-yl_C6ozXaA>
    <xmx:zCb9ZnsZFyAH4EKrKTqQ6uWrm1Ri6vwuAB7bXCZN0RR__u26EMq0eK-Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dabc0000 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:21 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 15/25] reftable/stack: handle allocation failures in
 `stack_compact_range()`
Message-ID: <6aaae4baa6ec9bccf8f8e8a517dcebda995b65b2.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

Handle allocation failures in `stack_compact_range()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1b77c9d014..2e6dd513d7 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1131,6 +1131,11 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * from the point of view of the newer process.
 	 */
 	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
+	if (!table_locks) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	for (i = last + 1; i > first; i--) {
 		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
 
@@ -1312,8 +1317,18 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * thus have to allocate `readers_len + 1` many entries.
 		 */
 		REFTABLE_CALLOC_ARRAY(names, st->merged->readers_len + 1);
-		for (size_t i = 0; i < st->merged->readers_len; i++)
-			names[i] = xstrdup(st->readers[i]->name);
+		if (!names) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
+
+		for (size_t i = 0; i < st->merged->readers_len; i++) {
+			names[i] = reftable_strdup(st->readers[i]->name);
+			if (!names[i]) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
+		}
 		first_to_replace = first;
 		last_to_replace = last;
 	}
-- 
2.47.0.rc0.dirty

