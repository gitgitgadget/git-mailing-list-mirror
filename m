Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2413BAC6
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082002; cv=none; b=WMVLXwdMPuRIA98G3QozaUcwl8jPSzUDfOJQkW1zYLzljxd0XfJaQMuFEDMHWyImihOcke70TBO3vSdUUUQPq7jhGz3UbVQmQedec9yQy26GAeXhx349kzOXwxFzU6ZONcTp1DOe9vTnIYzQT/JY8v1hR93NYCIJSDc/yz907Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082002; c=relaxed/simple;
	bh=c7ri+KL6g60uB4uCdWTqUduOOezqvYG8mAVWC0Eu+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE6om4bwi6wGZMjMKrSWe4k+KZWDXxo91aBVcV8XAweZUNNoJS1SN+3QwpIU+56XZPeZusXaoLoVNIoz3TMhA0WPfrg4P2gqWHQKtB2j/x88ebLN5Fz9AJbifOPrrOTpm4dawqll/QLeGegjQWI1icTeDKPzsApO6w4y4v/XlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=USjaqHUB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IikLgTFn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="USjaqHUB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IikLgTFn"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BD68E1151A97;
	Mon, 19 Aug 2024 11:39:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 19 Aug 2024 11:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724081999; x=1724168399; bh=YXxSjlMxy5
	/jGhfWX5XSGF3IrlQRUzt/l4rWWfGGeH0=; b=USjaqHUBNjhts1CXgy7O90rj9p
	Wd9E83iJMMQyBF4SUIOroP+gCuuCXb0qtxTu4qIo+bA5wC/DjAaoHGZ22rGRgN98
	oMrKEBzTH2jmyf6ze5KbxhwKjrmsZwFqR5ztIlChu5+S5d91IBKos128N+yvA3hH
	Yao/nE2d67wkjlgMH0Z00h0bFwyauCCDcBSH3NqSWWdrqwSKRcxdQ7z0n6T4QIUZ
	/y2Np072KrnLRzHj8SCmJUY5uzrjEDt+f1FNAIf9JA4y6cSZpF4IJbJFgPGFsSb2
	Hg+EJlBJnkXOuH2uaLc2LM4lF5xFv8qmMGPOBK5vUOszdZP05eGvTg/kiBFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724081999; x=1724168399; bh=YXxSjlMxy5/jGhfWX5XSGF3IrlQR
	Uzt/l4rWWfGGeH0=; b=IikLgTFn+kgC7WoBduRwnmdy4RK8EguiW8wSKgFb3wp7
	McOJQpdWP4kZyFvnqJ1rop/QuPhHyMC2J0uV19OmBSkB8ckA8khRin0Z1U4fP8jc
	C55vrIfo28bS/JUeX5UaR5Yp5L5KHfwa6EyFTuKzTOvJn7Te1no1qEkRF+h/ckey
	a2NXpsOZna1HoPoU9BOX9V2E4TgW+XU5SEaK/ihaboh7USlr4uKycc/Y2Ej/utG5
	gyQhcZsWlpcj9VFaf1yJLmymO/5qCGpSFcBaIAxCX9Vlj/HWDShxxSaIeU8TYCLo
	kQ2+yyr4N71mpkO+ReBYe/PyXihlbAKrKDhz0l7xag==
X-ME-Sender: <xms:T2fDZkPjJFQISUQceo-gSzuTE8EoetrE-lAI4uozcXFexaQ1vLwvXg>
    <xme:T2fDZq8RndvIQ_g8zCGdobFa9PdwVCrzik1vJ_jWv6y8-8vABSe5tzJhw2_yPjxSp
    TNdV8Fnke-Weh84Yg>
X-ME-Received: <xmr:T2fDZrQZeKZzn90aSm6dpTJBkQSqEdprk0KO8QztxeTTbxXLNzgxOly5CGuunJUWgh_ebirY35_9u5l0OPkxn_3Ira9NZ8TJVv57Gm3WenWHo7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:T2fDZssVDtc8ShYpcqoRlt6y_uzzlJxCDbibnD3BV8mxmnHI4ZsFaA>
    <xmx:T2fDZsdt-5W2tGSzAzEM9V4OAsnwfVlIlEFGjhIU5KJ--uyzgB-UVw>
    <xmx:T2fDZg0kCQfDNuilVjvSLpT48CecvTl044mu_iM4PKuTkfOQQGj4sA>
    <xmx:T2fDZg-Z4Sm7Nc8fe4RmJif8snXG_hSB2qwLmG_gDCJYumHSG_X_nw>
    <xmx:T2fDZtrMJbKVgQyTzq95DfTu3wO5Ucn4crYIe5OTv2hFoEOzeB9x--Kb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:39:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8db3ba2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:29 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:39:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 05/10] reftable/reader: inline `reader_close()`
Message-ID: <4a9fe15042795f5b2bd4d4e17cf771d86e4eea47.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

Same as with the preceding commit, we also provide a `reader_close()`
function that allows the caller to close a reader without freeing it.
This is unnecessary now that all users will have an allocated version of
the reader.

Inline it into `reftable_reader_free()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 9 ++-------
 reftable/reader.h | 1 -
 reftable/stack.c  | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 9239679ad9..037417fcf6 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -579,12 +579,6 @@ void reftable_reader_init_log_iterator(struct reftable_reader *r,
 	reader_init_iter(r, it, BLOCK_TYPE_LOG);
 }
 
-void reader_close(struct reftable_reader *r)
-{
-	block_source_close(&r->source);
-	FREE_AND_NULL(r->name);
-}
-
 int reftable_reader_new(struct reftable_reader **out,
 			struct reftable_block_source *source, char const *name)
 {
@@ -655,7 +649,8 @@ void reftable_reader_free(struct reftable_reader *r)
 {
 	if (!r)
 		return;
-	reader_close(r);
+	block_source_close(&r->source);
+	FREE_AND_NULL(r->name);
 	reftable_free(r);
 }
 
diff --git a/reftable/reader.h b/reftable/reader.h
index 762cd6de66..88b4f3b421 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -52,7 +52,6 @@ struct reftable_reader {
 	struct reftable_reader_offsets log_offsets;
 };
 
-void reader_close(struct reftable_reader *r);
 const char *reader_name(struct reftable_reader *r);
 
 void reader_init_iter(struct reftable_reader *r,
diff --git a/reftable/stack.c b/reftable/stack.c
index c72435b059..0ac9cdf8de 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -290,7 +290,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 			const char *name = reader_name(cur[i]);
 			stack_filename(&table_path, st, name);
 
-			reader_close(cur[i]);
 			reftable_reader_free(cur[i]);
 
 			/* On Windows, can only unlink after closing. */
@@ -299,10 +298,8 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	}
 
 done:
-	for (i = 0; i < new_readers_len; i++) {
-		reader_close(new_readers[i]);
+	for (i = 0; i < new_readers_len; i++)
 		reftable_reader_free(new_readers[i]);
-	}
 	reftable_free(new_readers);
 	reftable_free(cur);
 	strbuf_release(&table_path);
-- 
2.46.0.164.g477ce5ccd6.dirty

