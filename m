Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D52F9D82
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774110262; cv=none; b=Sqhl7boY6meN6igUjvgkgl3KEpSJS8faBNCbyLivS/6tDa9f7CsJlxm0HoKyDcGO2S5LqxibkC8omGyZfyTi0IXPou5M6N07P0v1lN1AKhRrDRyKhfjK8yE8vz4R3q2Hxwn/M5qNDnXsRosD4lsdtCE2wu4ekyUrkLgdedjMC3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774110262; c=relaxed/simple;
	bh=SGV7EqGa1pC4p9JEur3qYPLulHFx/KKBjC/vZoY6tUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FBbLKAFoZy1zym6ldJfIcUTGdCb7QqA7waC+DmOO6o+ZRjbJB4vMSw2Eb7zhSQ4nSqv7qz87M/2uMKQ7D6xNGi/r8PU3aQnrUBY8rEm8ve85+Cdjba2L7A3w2v5k0C9dZxdVbftK4YwWlu99RwxZVl9mjf1Y8DZ1MHDZHUKCuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=guPF90fG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ny92GqtF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="guPF90fG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ny92GqtF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F5981D000EA;
	Sat, 21 Mar 2026 12:24:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 21 Mar 2026 12:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774110259; x=1774196659; bh=7GA0HYZKjh
	tjhI9HDxt42t+0xNy5VlDO+CnNT9dTp4A=; b=guPF90fGDFA17IwH+aCxLzgjym
	23HbduvdeIvl00AvkHEbiFfPCg43yAApbW0xLIy9mr/maLKtROMyWhJY3wZmWzhs
	II2W3hgLCSmXY7giDB4hLQ9SOdFCLlFrkmQHtorXFtsvAP1sEPmbdi2cUK9im3D3
	7Q5c2nySx9PZeG/f6lEgKSYS8otPB1QGVuFDbZwZBe1XcWAplmZDpShYpkyCnNjy
	z9VFPeBsiO+PzAD+UOjq8i7WE+lpSqcdlkZMmPhFxQ2Uoo6Iv9LzansNJ52B2/sW
	IifaNa4upEsRvFzN2svYtASdUaLMmc0FiY//rf92Qs+DnsJr9l8GpS9bNtuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774110259; x=1774196659; bh=7GA0HYZKjhtjhI9HDxt42t+0xNy5VlDO+Cn
	NT9dTp4A=; b=ny92GqtFV+yLoa6/bYUTEYmfDVkoBocRQ+zl+Z1SdHF/8FSG52s
	1ZliVNGOOJkr9/yQdDRBfvWeVdzMe9qdSz2uGf1ryXpUoSoThbfVwOAFc4Rvujmy
	vqMEmeAS/xMks4PhgjCBIqlib3tZ0jSXnevzJCnj0w56crl1bwTmpCWBqnAyzf5j
	/QaNTHjThiVJFDmSQIEM7YvEbv08eWUmNHJIM6Z3QmZJ+EzBuJVIHijlwPtq8Qsx
	6XDraYc2hdtj/P/sjy030sLB32QvaNmWtswgS2M0sm7n6MowuSQLVDBpY1Hwqti6
	MGcVuB7rWRgzdSxwR9JI/a3bbeHBCTBzVaA==
X-ME-Sender: <xms:M8a-aUFJiWd5jKFypWSdO08fkUFCeuXBfrGa8dT1flRyb4A00O7ohA>
    <xme:M8a-aUVXX7Y66RLgAM9XFIaFMHIRBuS36ZJf1I1ghKbmIPQbOgQBQLpOpBFrT-gwR
    iarC5jzxR-OzOtce6Cp6kL3mg7O5VmoRkdZ5mXULjcj7yvY0Y75F40>
X-ME-Received: <xmr:M8a-aTI0hgZ3YxxmJU7lAW1xbXzAB-_lg3tetyWbrPZeBrtJFP9SgNsW2sfKMTSMn7E0ccJD54tEgG1TnWDjE1Pk2lTwQC5pow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetvdeljedujeetgfefkeeugfdvfe
    ehiedvvdehhfejtdfgkeejleekhfdtgfegudenucffohhmrghinhepshhtrhgsuhhfrdgt
    fienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M8a-aU8zQa2s-ekpZQOR8qEUtlkrT7qkQ8qmiel-SfbGvwgj2AgzoQ>
    <xmx:M8a-aWII8dS82LSP_ZsUBG7coBRSiN287CzepVMz19sYyCCdYcyHPQ>
    <xmx:M8a-aZnrFj3tzAWNlPzWlLT8jokEde1qe8Z1MHDTLSBYEBmAhL82Hw>
    <xmx:M8a-aaPZZAEVuE75AHPblMIapcCcXXqViRQdtM87WCGL7sq4qqpfKQ>
    <xmx:M8a-aUemZ-hXNCzlBbHjfnKYOlMQ3NJkr3_0f2pz4hjyLlX42CDybKxf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 12:24:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
    =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
In-Reply-To: <xmqqcy0zii0s.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Mar 2026 15:14:27 -0700")
References: <xmqq341wnvbk.fsf@gitster.g> <xmqqcy0zii0s.fsf@gitster.g>
Date: Sat, 21 Mar 2026 09:24:17 -0700
Message-ID: <xmqqqzpdb172.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> diff --git c/contrib/coccinelle/strbuf.cocci w/contrib/coccinelle/strbuf.cocci
> index 5f06105df6..3dc5cd02a3 100644
> --- c/contrib/coccinelle/strbuf.cocci
> +++ w/contrib/coccinelle/strbuf.cocci
> ...
> +@@
> +identifier funcname != { strbuf_getwholeline, parse_list_objects_filter };
> +struct strbuf SB;
> +@@
> +  funcname(...) {<...
> +- !SB.buf
> ++ 0
> +  ...>}

Here is my second try.  strbuf_getwholeline() does not have to break
strbuf invariants even tentatively.  We just grab the guts of sb,
let getdelim() possibly reallocate, and then return it in the normal
case.

In the EOF code path, the only special thing we need is when we
started with slopbuf[] and getdelim() allocated some bytes yet
returned EOF.  We are expected to free it before returning.

By the way, the big comment about xrealloc() in the middle, most of
which is outside the post-context of the first hunk, should be
updated, as our xrealloc() do not aggressively try to recover these
days, if I understand correctly.  I left it outside the scope of
this patch, whose sole focus is to reduce the number of places in
the codebase that check if sb->buf is NULL.


 strbuf.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git c/strbuf.c w/strbuf.c
index 3939863cf3..89933c3814 100644
--- c/strbuf.c
+++ w/strbuf.c
@@ -632,24 +632,26 @@ int strbuf_getcwd(struct strbuf *sb)
 int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	ssize_t r;
+	char *buf = sb->buf;
+	size_t alloc = sb->alloc;
 
 	if (feof(fp))
 		return EOF;
 
-	strbuf_reset(sb);
-
 	/* Translate slopbuf to NULL, as we cannot call realloc on it */
-	if (!sb->alloc)
-		sb->buf = NULL;
+	if (!alloc)
+		buf = NULL;
 	errno = 0;
-	r = getdelim(&sb->buf, &sb->alloc, term, fp);
+	r = getdelim(&buf, &alloc, term, fp);
 
 	if (r > 0) {
+		sb->buf = buf;
+		sb->alloc = alloc;
 		sb->len = r;
 		return 0;
 	}
-	assert(r == -1);
 
+	assert(r == -1);
 	/*
 	 * Normally we would have called xrealloc, which will try to free
 	 * memory and recover. But we have no way to tell getdelim() to do so.
@@ -664,15 +666,16 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	if (errno == ENOMEM)
 		die("Out of memory, getdelim failed");
 
-	/*
-	 * Restore strbuf invariants; if getdelim left us with a NULL pointer,
-	 * we can just re-init, but otherwise we should make sure that our
-	 * length is empty, and that the result is NUL-terminated.
+	/* 
+	 * If getdelim() allocated when we had no allocation, free it.
+	 */
+	if (!alloc)
+		free(buf);
+
+	/* 
+	 * We haven't touched sb at all; as with the initial "were we
+	 * already at EOF?" case, return EOF without touching sb.
 	 */
-	if (!sb->buf)
-		strbuf_init(sb, 0);
-	else
-		strbuf_reset(sb);
 	return EOF;
 }
 #else
