Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618213054C7
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985511; cv=none; b=rZFX6XNYuzuFIPRH9TxwM30wEucwWLgv5ZG66MHhVefW6Oh+lHNP+CdapAOFY4zWq61SrB15Ybqf2KaMhMbwWY6uVSH6hSrmQ0BIh9sWkV0UHW1eOYN1FxnzwAp8cHJwSXtARciEiNqQlRhEc5JFQ999SL1g3QU2DvFJ5EHSfdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985511; c=relaxed/simple;
	bh=3zHE6EB44RAfhujFIY2Hv2qGukqOcCRb3sihtYuZ0BY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IsPGsuYbenvWe2fgt8fYpOh2tJgqwuQ0JNHp0vgs0iEDStfnIRJIt37eCQOlacHjXRg6C9EQneTNiULwK/HiIEXqtiXxdOBmLYLmFMwohIBjCZt7dXgjg63GrjkgHrcjCJ0lsFAGGVt5iT+TpK/gUjhastvMl/6KvnjdcFa7ySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YE0rjDmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zyaRIfeR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YE0rjDmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zyaRIfeR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 786B6EC010A;
	Fri, 20 Mar 2026 01:45:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 20 Mar 2026 01:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773985506; x=1774071906; bh=SUJk2IwCJR
	yiV9Y+EiAHWY0wroyIPxK2K4smC6zNXys=; b=YE0rjDmJ4pjIFrn/C5BQF/kV7/
	9SF0QkEth/rNVpXsiMiZzLwar3ZOzY6AyH0J2W7jQ4REDTaYfIISjwKHvyuNlmJs
	iHaDWGvML8eV1bIazp9gr5kNSUvZQYx/hlOu14pt3BA9I/BozZ1EuVAJzG764QcO
	wTqVJ/XSYp6KYcT3kk50VL/St4Gj9/CoK7aJXbRzwfYz7Yt5ZPHYrBaz5pT6Tnun
	A4AeKB/8VbUuiRxHtxyw5BeRfM2dILtNL03ZTOahF9GHYP7qQ0lDra4Tr45VqWzN
	ZTkfjd+1pXQpjtHoWvreWA5YZN+HKW39MigepCsyoUbW87Pm2ecyPXD53pNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773985506; x=1774071906; bh=SUJk2IwCJRyiV9Y+EiAHWY0wroyIPxK2K4s
	mC6zNXys=; b=zyaRIfeRZcW7E8MXzb1P3WY1UjhYRNyZl8lqoBC6Afg9Y36dmD6
	qgsVUoulog/2prVsatvUARAavcYm5ZfwfN+Coh5Bd+4yxI7+q2DULkqj9RIb6MYx
	ilass20+3DaSdSXvhghAESQ/jUgcUH7K7e2CmhZ+ulkZ6PWV2BNdq5XV2/9eLDm6
	MqqgTi06bMut/mtEoWALdNJtj4d129RPQ16FAz4dLhWO39BM/2kFyWKdeTIxPa/y
	fcuCjTDKB+nLNmFaKdiRYYC8xxmWWsOtFTBq5GEllsUqf6IhDhG4/ldOxxV3qp2T
	NbsZ7H+x8hFRN3JNV8RIx9azbjSoojwwxLQ==
X-ME-Sender: <xms:4t68afhb6J_3uEaN9ERoAobzFtEOSod20DHhotlSGSpdg7v5XyVlgQ>
    <xme:4t68aTfwAWNNaT1opb2u3Yar9qFY7GvQ9fU6h4aRhWTcuLtQU3iQ7kZ60Kdes5El0
    -NS1vhzE_6Dhg8AmmOGg-fAiB-kK7VN-lAV39xfs0N5OWcav60Ysu4>
X-ME-Received: <xmr:4t68ace51j4auVj7zh8zXUrIoAIg0SDeGTrpQ2ZxQCpIybnpQuUMfIFZ4zzx_lYdFf4_7eT5lisznAn6GTWhxIvPRWS5Gc4TSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeltdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetvdeljedujeetgfefkeeugfdvfe
    ehiedvvdehhfejtdfgkeejleekhfdtgfegudenucffohhmrghinhepshhtrhgsuhhfrdgt
    fienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:4t68aV9nlGq3DAoaBLR5JvystHEkgvNFs_tE8g19vAd-ZXF2kkWkMw>
    <xmx:4t68aQnZBM51veCdoqYl3jj15bWBXBB7nx86nw3toPQ2-PNH1vJWHw>
    <xmx:4t68af__6_-0KezhXOEfvlMmh1uNooZmzb82amCKdtz9JWPsSal0Iw>
    <xmx:4t68aWkjYo4QIapG-Al3CzZhRsOFIh-gHFpDosuPBh7pN6JQz0AnIw>
    <xmx:4t68aeO3uCxnN6T6u4s0F_UfidZ3jq3Uq0KeRGukanSx_Xdl1lSmxyV6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 01:45:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
In-Reply-To: <20260320041803.GA18125@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Mar 2026 00:18:03 -0400")
References: <xmqq341wnvbk.fsf@gitster.g> <xmqqcy0zii0s.fsf@gitster.g>
	<20260319233546.GA3632561@coredump.intra.peff.net>
	<xmqqcy0zgtmu.fsf@gitster.g>
	<20260320041803.GA18125@coredump.intra.peff.net>
Date: Thu, 19 Mar 2026 22:45:04 -0700
Message-ID: <xmqq341vgilb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I'm not quite sure what you mean. The function right now looks like:
> ...
> But it's not quite enough to just do:
>
>   free(buf);
>
> Because "buf" is a copy of sb->buf,...

I may have phrased the idea very poorly.  In short, the core of the
idea is that we do not have to use the original content of the
strbuf at all.  I.e., "buf" does not have to be anything related to
sb->buf.

In the following patch, I am _removing_ strbuf_reset() near the
beginning, but replacing it with strbuf_release() may illustrate the
idea more clearly.  I didn't do so primarily because the first thing
strbuf_attach() does is to call strbuf_release(), so the call would
be redundant in the normal code flow.

When getdelim() did not return anything positive, after asserting
the return value is -1 (i.e., EOF), we only need to return EOF while
emptying the caller-supplied strbuf.  As the "char *buf" we have and
passed to getdelim() never had anything to do with caller-supplied
strbuf *sb, there is no need to worry about slopbuf or anything
associated with it.

 strbuf.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git c/strbuf.c w/strbuf.c
index 3939863cf3..ef61bd5b14 100644
--- c/strbuf.c
+++ w/strbuf.c
@@ -631,21 +631,20 @@ int strbuf_getcwd(struct strbuf *sb)
 #ifdef HAVE_GETDELIM
 int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
+	size_t alloc;
+	char *buf;
 	ssize_t r;
 
 	if (feof(fp))
 		return EOF;
 
-	strbuf_reset(sb);
-
-	/* Translate slopbuf to NULL, as we cannot call realloc on it */
-	if (!sb->alloc)
-		sb->buf = NULL;
+	buf = NULL;
+	alloc = 0;
 	errno = 0;
-	r = getdelim(&sb->buf, &sb->alloc, term, fp);
+	r = getdelim(&buf, &alloc, term, fp);
 
 	if (r > 0) {
-		sb->len = r;
+		strbuf_attach(sb, buf, (size_t) r, alloc);
 		return 0;
 	}
 	assert(r == -1);
@@ -664,15 +663,14 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	if (errno == ENOMEM)
 		die("Out of memory, getdelim failed");
 
-	/*
-	 * Restore strbuf invariants; if getdelim left us with a NULL pointer,
-	 * we can just re-init, but otherwise we should make sure that our
-	 * length is empty, and that the result is NUL-terminated.
+	/* 
+	 * We got an EOF.  If getdelim() allocated any memory, we
+	 * would return that to the system.
 	 */
-	if (!sb->buf)
-		strbuf_init(sb, 0);
-	else
-		strbuf_reset(sb);
+	free(buf);
+
+	/* And empty the strbuf */
+	strbuf_release(sb);
 	return EOF;
 }
 #else
