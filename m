Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E225A321
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904563; cv=none; b=GEGql1tPheFkv9frQhFuoXmK10mx+3/WpgiacIGXkDuaDwUlDiOePcCfYCxdpTCLDjteqDRqpC4/A3Rg2Cb639TD2oD7W64U+8RnMAqjARxCvy5g0fbQfBiVTLYEeKaj8bUSmgX46DG6qNdBheiTGCHrUDIe24zQeNEOX9JMgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904563; c=relaxed/simple;
	bh=T9I32ECCAmSPr+TfF5ppevQZVqix96R3bvNr9Vhhez4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nWnUm9d86tUYwBkRSSxJNnxxgfwTbBtK2R2X+QIVQEmL7aWa/VddunpbhrZiemhc3agdOPYRr3EUhVhwkJpd1/3JPX6ltZo7FBUJR02uBEqYyVA3KtmYM7tFxBh4txW0cdIn2PNIk6g45L763ZcR+ssHxaXdPhxMGxW5rF+SBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bEZaNS8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xSMuBIIQ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bEZaNS8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xSMuBIIQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AF7F7A0185;
	Thu, 19 Mar 2026 03:16:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 19 Mar 2026 03:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1773904561; x=1773990961; bh=by+7yY0OgH8R46AF9m95onZD87ivyl1k
	uOC4h5gBZWY=; b=bEZaNS8h8cU4UuIV4nC26JpCTMKLDpFyreRFPLZKwnDwJD0/
	IvuXPRNoB7o1cYJ9CnarPNa8+iMm1DW60pyz/TkMjNoutpyPvHi/hkVBERCg3SnL
	Q3PxnRiZwnbSHoC2jQG1Ike+J0L9rS3Wo8Mj2AYaYt9NGVZ/XkBJ/Qkbo3hCBiNQ
	CByJOJhTeA20SKDZmZWTqRdid53633irSxDRfBaHJ9ePY/qN6SuW+NcsgQx7ZcUP
	RNUO1F0EhXQ5752/FCm264e++lD4UtyzKO3ob0oMa286WE2VhUqF9rQYYauesNn2
	jW8qs50Aamu3tpiy8wHnJQoieuYPu6J2T9LF/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773904561; x=
	1773990961; bh=by+7yY0OgH8R46AF9m95onZD87ivyl1kuOC4h5gBZWY=; b=x
	SMuBIIQKMAEzCFGcDr8lixcHM16tEt2tOzv8F0xotZyhZECngVqOuNVO7ocCoRSV
	AqPz9LxnjsULnZGI/hCx7mmlJ5WyVtlgkVb2KovP58gxKicajR/ADZYPEG9vsLdU
	LOnYzqLjN2514UV+ZDBXczSDEc3jJZip57uzIws4KXlZ8NJ5SYN7Z3gBif7O4rFP
	yIWF395ltFW61UhM3RcRLvnI+1llWHySJbBXrjehPJbTu6+Rno53W28yfkaHM9ny
	GcqUG4Qf79s5E+u4gSrQpuBIYpu2UVy52rC2XBU10onQzRDVbJSOc5pnV7k+aQgM
	1tQfBoizr4A9pXGCTKgpA==
X-ME-Sender: <xms:saK7aVzy65BVDV6LbjlpWhgOs8PlJGMuohzQ3pUE8si4gxVr1mJXUQ>
    <xme:saK7abR4mL3b1b0cM5umqCjmjsWqfxENwYXTJ5oMzuW5Nn4hGF2HVkgxTaL3G5qYQ
    g8Ji5EFdn_cC2qkfk2K54Lc0glOiu5s_4AcCwiQg4561-MYRUBqNg>
X-ME-Received: <xmr:saK7ac8Slkhu8ggQei0uOTrA3o9djLDU4WrZWqU8TM4F-hkWL6x3xxg7KURF0q1Wrp2_Xqul1I8QqhD3pzpI-2Tz4VNlMaMckw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:saK7aSpFer0oibfaTx6xxNk3WbnDFsqJa9G_dZLNulTre-R-x6dftQ>
    <xmx:saK7aZmssZ9Ll-X0gy-cVLsFxb4De0shNLJk7gddtmwtTOk21s95sg>
    <xmx:saK7aZLeWwifc7sEvC4tNS338KUao9c-juNL_OAYhamXseFCK2kHsA>
    <xmx:saK7aeyiQb_E_CiVO2GorVDNxnlerhcGvW0vCok5akf-_eJOhElXZA>
    <xmx:saK7aZJeVRNfdlk9qoD1mfljNEV1kFac6q5wrORE9sFlq2NUQDGxqVCQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 03:16:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] rerere: update to modern representation of empty strbufs
Date: Thu, 19 Mar 2026 00:15:59 -0700
Message-ID: <xmqq341wnvbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Back when b4833a2c (rerere: Fix use of an empty strbuf.buf,
2007-09-26) was written, a freshly initialized empty strbuf
had NULL in its .buf member, with .len set to 0.  The code this
patch touches in rerere.c was written to _fix_ the original code
that assumed that the .buf member is always pointing at a NUL-terminated
string, even for an empty string, which did not hold back then.

That changed in b315c5c0 (strbuf change: be sure ->buf is never ever
NULL., 2007-09-27), and it has again become safe to assume that .buf
is never NULL, and .buf[0] has '\0' for an empty string (i.e., a
strbuf with its .len member set to 0).

A funny thing is, this piece of code has been moved around from
builtin-rerere.c to rerere.c and also adjusted for updates to the
hash function API over the years, but nobody bothered to question
if this special casing for an empty strbuf was still necessary:

    b4833a2c62 (rerere: Fix use of an empty strbuf.buf, 2007-09-26)
    5b2fd95606 (rerere: Separate libgit and builtin functions, 2008-07-09)
    9126f0091f (fix openssl headers conflicting with custom SHA1 implementations, 2008-10-01)
    c0f16f8e14 (rerere: factor out handle_conflict function, 2018-08-05)
    0d7c419a94 (rerere: convert to use the_hash_algo, 2018-10-15)
    0578f1e66a (global: adapt callers to use generic hash context helpers, 2025-01-31)

Finally get rid of the special casing that was unnecessary for the
last 19 years.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rerere.c b/rerere.c
index 6ec55964e2..0296700f9f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -403,12 +403,8 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 			strbuf_addbuf(out, &two);
 			rerere_strbuf_putconflict(out, '>', marker_size);
 			if (ctx) {
-				git_hash_update(ctx, one.buf ?
-						one.buf : "",
-						one.len + 1);
-				git_hash_update(ctx, two.buf ?
-						two.buf : "",
-						two.len + 1);
+				git_hash_update(ctx, one.buf, one.len + 1);
+				git_hash_update(ctx, two.buf, two.len + 1);
 			}
 			break;
 		} else if (hunk == RR_SIDE_1)
-- 
2.53.0-781-gf5b2cca52b

