Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163733E348
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674306; cv=none; b=L2wnl7IPrAdSg3dZG/N34+XkndDm5yJdMLznv6qA0Q22z6Srczlm3IHefGgzhGMGoLtIDycTZ3HqZREncSa2UkrINF1Fs/IT7C6FVyQKYKKpuvUWH9PqjQTvjzgZEv+m++dZosaVBtxIofyUjG7O6TQpWwA5XIbDTQ6cq79jLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674306; c=relaxed/simple;
	bh=klN1ZKdBxzLoWmTgxVeM2w2aO/lD1lpkiVraD+pSmpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHDVVJcZkkt6AZ0pdxxSlPK+8TLRqtx+qkLV5w534NCm16ivpWRyxL1pUlBwt5DxJWk0qdaxJ4zzZxTvKgd73wSxkn0ezIK4NAwdm5LJvRdIAxtFMehWCoTy4zfLgILdpvxNUtwu9Tsf5wez0zhwJUB7GYI/boTQDiKbZFonDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b07MPrTh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dljYMPox; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b07MPrTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dljYMPox"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 28EFA7A0071;
	Tue, 25 Aug 2026 12:11:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 25 Aug 2026 12:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787674304; x=1787760704; bh=sqUUm7ZAAj
	fS8/6+sR9fF44+yzKLtK6970X+v9QBqO8=; b=b07MPrThQh0SYgJ3VgoYemwb0Y
	hOFd0YPmmPAvq0ZiohEN51mLxBY3onpiSAFj5w5hsqGWC4VFPn8BGklkcuf5AhNu
	Y5wZ0MA4KCn0M2RBIXYNFPiJuBYsycGcC+TYYcXOSc/Zyk0kZ6FVQutuKo0kZ4sP
	We/O4P7DuCrwRT8Wwbi1d1uHPMVafncNTGj5CJDq+0ovoH9owaFFDXVuUQzi9fUp
	C6IOYhXJ/JX8lU8poR0HQda2DLapN6fdnaRcyCvLgC+L1BhpH4J32fR3ya7oLt9z
	gG4Fq63oRCJQLlMfV5plDooVYGEvP1yFPai5DRsCwGydasjIIezQd48HqzGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787674304; x=1787760704; bh=sqUUm7ZAAjfS8/6+sR9fF44+yzKLtK6970X
	+v9QBqO8=; b=dljYMPoxkcsw9kV1AKksWm/4cGIJikMk7+ub0GuEfGZmWRE91Gj
	fsbiH3udMp45levHvPc4IdV5MxpGO4dAclDDXWKM0jgtW26hwolomei8TMRowRTd
	KiqzEniMP0hgJIRvLGviaJ1aInvRVdHDhEDdY2NPKtbGlJd+25qUsKZYR4srBSUW
	p9CohCaG/to4Q41xg1YUqGi7qQTchNw4T0NSeY7lRfMmTetjb00Nt4gb934X6tgB
	97NZccG0Z7v1XRjlA0ALGu5h1FgWwRUcLTNMr4gkoMX3e1+5Euq7XrR6ZqhNHY1S
	TwFcqXkhP+Vni9fvwFIbb59U3eXQySrZvgw==
X-ME-Sender: <xms:v76Nap8jazJe1gd7CqqA2bA_mM3RBnMAA7ZyznfiK4BCql21YJfu6w>
    <xme:v76NalL8BCRFqO8uXv7r1d1hhpsWfhFUGh5ytzf5zA6g6RDRl6_6gTkz1QntQUoK6
    ub6Znu3yC32bLKVqgspjKwl32pUUKj2p56Kn4_cm5jyYwWife6A>
X-ME-Received: <xmr:v76NakYj57xSVBAR58W30BXbLdYndnGJPFd9s91Cb8KaJy_ZaLwTpF7y6dC8EkI3vG9O7lcO5G8OkqHBmiMgIhxmgFBWTujcFQ>
X-ME-Proxy-Cause: dmFkZTF48VxPOd4a2xgMiAclGpRYNBHUnYihZY/1uHCxYn2NenOmJ2GKkb+TF6Q8cuNtDI
    9RgekwSNLsq/88A5leKzFT8CBfc2PBPZv4Y2/Zran11iaUwjapfwKT6NCWIzinjrrQMrV/
    c6R+5W2HBnJleMzmHE9Jvf0FDJIdsTAtk82BIAwkXmSd8gDD9DIUhV/r8413g5GNvSuQrL
    0/0vUBcfkAar2oyrwbeZvHOwVDDCm8gbvzUWPitv8q5bLPqghpHi7X9sjA+2miHIKhCP7U
    tuCbBnrgqAr3nny5Pcx2aym8IX33I5dGyK/rrCNFu8BpBKU4eEGS9E3twGuh9x20b1b8AR
    XbyvC19yEzh8mdU6Akd74DbCCUQAallkGAWtqrpeL6uGBPb1p8DdHHdyZyyh0MNHgWrKpS
    68jGxueL+J3yPGA5y76rhwV9HkU8va+5/2UwO4wAyhZOcl+vmL9yIFmPKh2D6dnmGxDao4
    2v+QQABgW5BDcatKaV9uCsEyZ2UaDpbcByGE4ByLexQKw0pmrhMlpNEzJtsN4ffa9ShlWL
    zdUjatHPNS1uQRBprNLcOkNuJgzCUQoZPBpr9+lfiWHoNiNj38Z5KOcewtbXo7j0ZqzzZH
    u5/l24ue/DrtZx3iaMB2EJCFdRPYw62PCLmXi89ODXAP75TrTcp/VrzLRbwA
X-ME-Proxy: <xmx:v76NanJsbTnZauvkSBRPQpV1qXHmE0V4X0qhHwd5C_aLadt4CjeIsg>
    <xmx:v76NaiAUfwJkWRsSMHO_nSvx2eP6E3NxWtQ30642H7O5v0ZAOh6NyA>
    <xmx:v76NasrSQZScV0Uyq8TMfRuXztnXSDHO1MoCp6KdBK6rFkJxF5ahew>
    <xmx:v76NathFcy-go8RFlQyltDSnzb5s-9R__aZEpx9clzD1i35dvoFL5g>
    <xmx:wL6Nan1C2-P3AbKYT6B1ybCAbpnW7qKweEtx_MUoboCT4AtRTO9Y6-jC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 12:11:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 4/6] hex: label usages of hex parsing for object IDs
In-Reply-To: <20260729233215.398654-5-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:13 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-5-sandals@crustytoothpaste.net>
Date: Tue, 25 Aug 2026 09:11:42 -0700
Message-ID: <xmqqh5kinps1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In preparation for a future change, label the hex parsing we're doing
> for object IDs by defining a constant called HEX_KIND_OID.  This is
> currently the same as HEX_KIND_MIXED, so there is no functional change
> here.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  diagnose.c    | 2 +-
>  hex-ll.h      | 2 ++
>  hex.c         | 2 +-
>  http-push.c   | 4 ++--
>  notes.c       | 2 +-
>  object-file.c | 2 +-
>  6 files changed, 8 insertions(+), 6 deletions(-)

This is a hard-to-review patch in the sense that what we see in the
patch may be perfectly good, but we cannot see what is left out,
either by mistake or by misdesign.  So I checked out the state with
this patch (and no later ones) applied, and eyeballed the output of

    $ git grep -n -e HEX_KIND_MIXED

At this step, a few explicit uses of HEX_KIND_MIXED remain that I
think should have been converted to HEX_KIND_OID.

 * builtin/index-pack.c:repack_local_links() spawns a pack-objects
   process and reads its output.  As we are reading from a known
   version of Git (i.e., pack-objects that came with the index-pack
   that runs this code), we do not need to be lenient and can use
   HEX_KIND_OID here.

 * notes.c:load_subtree() has two calls to hex_to_bytes() to read
   paths in a notes tree, and this patch updates only one to use
   HEX_KIND_OID, leaving the other one HEX_KIND_MIXED, which we
   probably should change at the same time (if there is a valid
   reason, it deserves an in-code comment to explain it).


The remaining uses of HEX_KIND_MIXED look mostly OK.

 - color.c uses MIXED to decode things like #AAFF00, which will be
   correct forever.

 - mailinfo.c uses MIXED to decode Q encoding, and we have no power
   or business to forbid uppercase hex there.

 - pkt-line.c:packet_length() uses MIXED to decode the packet length
   expressed in the four hex digits at the beginning.  We could
   forbid uppercase hex there (our length bytes have always been
   lowercase) if we wanted to, but HEX_KIND_OID is not the enum to
   use to do so.

 - ref-filter.c:append_literal() is similar to the next one.

 - strbuf.c:strbuf_expand_literal() uses MIXED to decode %0A into line
   feed, etc.  We could forbid uppercase hex there if we wanted to,
   but HEX_KIND_OID is not the enum to use to do so.

 - url.c:url_decode_internal() uses MIXED to decode %2F into '/',
   etc., and we have no power or business to forbid uppercase hex
   there.

 - urlmatch.c:append_normalized_escapes() uses MIXED to decode %2F
   into '/' before escaping it back with %02X.
