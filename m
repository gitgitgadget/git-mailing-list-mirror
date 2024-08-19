Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A25136663
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082015; cv=none; b=ZJsQHUfmGsNYH05oyveG46oVTZSuRt8jPq9nL10PFOCalC487nrJP5kJk9tqwS20Km17UmXcR91LlOoQcSUvgHyaCuFMCKhigHkAdubhVw3DRnvIY7maTaYTQZ7Ikzu0whLXvK5XNRZS3CeiFN13511Jv0WvVJ396eEiciWS5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082015; c=relaxed/simple;
	bh=C0osimSr/2u8oyDAF3s0d+73XIFHSMXlilEYb44AXco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMEACzRpxYO8183G0MKqd/dFF4JLSjWaz8N9WTdxEWDunNaWxeaydnNjemQcXV9H+kLlJZrENhh8nJmCcRSq5QFE5F1r47Ltb8opix+eFbzYZ/eSSz5xBRGoOvn85hEA2VucWrK+FwJ/L49Qvkq7XntSefGb5C6Zs9k3N8Dgfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nMsLOcYM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbKcDTqH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nMsLOcYM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbKcDTqH"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 082051151A97;
	Mon, 19 Aug 2024 11:40:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 19 Aug 2024 11:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724082013; x=1724168413; bh=xrKgS1KWJv
	KfEF0tpQAiFTm+IwM7edflzQ8GpaeTiRc=; b=nMsLOcYMTOz5bCgJe8MpxOmm1q
	nfyTQw8lBirbWQC1VP6NfDgBEayNZYznZpEO2yCA6huZGa5Ac6H0s1zhbF5bMFle
	qxQnRmw09OUxdKKRwfLbNGggi8c2hhxZTCrbtp/fFQnnl19CLafDCxwucwSUUF+3
	VgRd27qSoHqQEqbWVqHiHb4FJgivlvLHIRcx+9ATDB3vcKylJCo3kgN5IgjEno98
	7e8H2IOhrbOIClaRAuNpFNCUplUFO6X/BcKrVlLcIbkCPyv3VXg5t7uCFSYJd4RN
	qYamRXJRTMIqrcw73K2rd40mlKb7gD0Tas178YAOFDmCg2tR7YhYyyKJgJcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724082013; x=1724168413; bh=xrKgS1KWJvKfEF0tpQAiFTm+IwM7
	edflzQ8GpaeTiRc=; b=VbKcDTqHPpHNQWdRmoxe+8NlytKjzvg8QsXBGfFMwkeI
	Nl4gua/RQ4vDi2nw0uJQXyger4Uok+NLlXKJksIqEw5OnyyiOqT/Vqi3Bv7AiH5x
	R/hFG8X35Dyg752t0KdZW+W+eUl/n1n7EHMDHyTrKaXE1LSThjH2RfkX2Rn23stH
	IXZ6Q2+Dd5HEl8z/SM9r4gDSbmsMIgcMP46dfCnqMKQaQPoGNkI4GyjlTewV1kY0
	/cZ0xJTDVfCRkqadYmgOfE5JCZ/7vTojLTKtd8Z6yzW4QqNToKlpa7Gx25RD1p2t
	MdnMuXCGgyu75YxJELY0jwhsxZl1wl+WhGgaY59sKw==
X-ME-Sender: <xms:XGfDZsqCai4NGfl16iBLFQ9OKNSD5thXR2smYNMGq0oY6iFMvuSjPw>
    <xme:XGfDZipICXvgF5a6ot1SwF5byUaPB9597tpVXDMd_a46es5Iv1FnzvFi4j9w-2gmc
    pxexVDX3kdoL8omXw>
X-ME-Received: <xmr:XGfDZhPO4aPo75jE-uGR6OXo6QCYu9lDgfS5wsXomYIPWId0LN7_MggFckz6DEgpfSlCGrsLHZVcIYmOyfeZB4d3T5OgjPSlm2EXk3b9WPxXoes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:XGfDZj48sV5nB7YAdrJCVIA4f5pcNm13WCzIb7CrUjjoPwH49KLq9g>
    <xmx:XGfDZr4eAhdL6TLnvnF3nSdIqtdGLU3l06KUGaABD1epO4ARSjyUSg>
    <xmx:XGfDZjhnlE9swTSmTJ3_xHKYqHnJgn2T1reA-aZyEbwFtFl6ET6q9A>
    <xmx:XGfDZl7UKWH9OEaz3iPXeQn4roKkGPsngT1HVasdnefSgaT-3rX3jA>
    <xmx:XGfDZrEFn3ipvqtlJvL4rP9wMhGfIYM9FDHswAJpZL0yOxUkUTk6ePW9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:40:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e2df5c57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:42 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:40:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 09/10] reftable/stack: reorder swapping in the reloaded stack
 contents
Message-ID: <d98316fbf4c440609462475d823abd2ba29eed41.1724080006.git.ps@pks.im>
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

The code flow of how we swap in the reloaded stack contents is somewhat
convoluted because we switch back and forth between swapping in
different parts of the stack.

Reorder the code to simplify it. We now first close and unlink the old
tables which do not get reused before we update the stack to point to
the new stack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 8e85f8b4d9..0247222258 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -273,30 +273,34 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	if (err < 0)
 		goto done;
 
-	st->readers_len = new_readers_len;
-	if (st->merged)
-		reftable_merged_table_free(st->merged);
-	if (st->readers) {
-		reftable_free(st->readers);
-	}
-	st->readers = new_readers;
-	new_readers = NULL;
-	new_readers_len = 0;
-
-	new_merged->suppress_deletions = 1;
-	st->merged = new_merged;
+	/*
+	 * Close the old, non-reused readers and proactively try to unlink
+	 * them. This is done for systems like Windows, where the underlying
+	 * file of such an open reader wouldn't have been possible to be
+	 * unlinked by the compacting process.
+	 */
 	for (i = 0; i < cur_len; i++) {
 		if (cur[i]) {
 			const char *name = reader_name(cur[i]);
 			stack_filename(&table_path, st, name);
-
 			reftable_reader_decref(cur[i]);
-
-			/* On Windows, can only unlink after closing. */
 			unlink(table_path.buf);
 		}
 	}
 
+	/* Update the stack to point to the new tables. */
+	if (st->merged)
+		reftable_merged_table_free(st->merged);
+	new_merged->suppress_deletions = 1;
+	st->merged = new_merged;
+
+	if (st->readers)
+		reftable_free(st->readers);
+	st->readers = new_readers;
+	st->readers_len = new_readers_len;
+	new_readers = NULL;
+	new_readers_len = 0;
+
 done:
 	for (i = 0; i < new_readers_len; i++)
 		reftable_reader_decref(new_readers[i]);
-- 
2.46.0.164.g477ce5ccd6.dirty

