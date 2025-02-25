Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F2267B0D
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483753; cv=none; b=eqUi+inI+Y5K/l5DYoyFH1uSvtuoe4M0Peo84oOMiLsMyqFuaj5cqVxMiMHU6SGPRoc2YSMk+yL8UcIhEnuMmhaxlLKQB2sB9PDT5bzM5akOdxUD6olLvQ2n6M76iAb0+amUPNnNkgv1Wtvk0oZd1XpgrfyFM9+UPuI7lfsIOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483753; c=relaxed/simple;
	bh=VaCWNUi5y/wh8wiVnZo0h7bxXRyr6V+GiUdiI3NUhnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEqy9xr/q/KH62bP7hPhQ3BVebdRaKjjijIRQrDym/18k5quAwXwv2sLp4x7Fm7qIumqDrhc9A01nYYPAKz9/zkn5ICDU9zWCcWKufv0lnVbqRziRLr0dW7BEdxp8s8ufg9VRDTqUL0za1aAQmQUPrcQRQ6XCd/rVBmrcRWF8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F4AgQNSV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wCUYueNc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F4AgQNSV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wCUYueNc"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8552511400E2;
	Tue, 25 Feb 2025 06:42:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 06:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740483750; x=1740570150; bh=/YWlloh47U
	siuIgCVjXuv0nO+GDhDT6sFxjB2qAK0Ys=; b=F4AgQNSVXOS309m6widu9B8Icp
	DxOkY+oUfpsLcj0EP08YzwFz64fOHqxoW7lFEQ+3V03E0XVxzjxY5TEq1X2HoEHq
	uK4EeLIRE3XHqJjiQlqIgkLJ3EzUowhiLNgWUmqmEz9WoBsNKMGfL48aTY9/Ys8T
	5UGkwHIShU5HXAdGEGFpfYBc0FWrVbwNaRyACjnINBeDlY1V0CEOmAdvQXvj/gx0
	zNV+TBJTjufPOBHhbwkO2rAfDgp7oVuZqZerDxjugZMih9n6MFULca7GFtk01Idn
	TA+CY3zDlWGnETi+WULZM8y1bJCkhmQCeDeZUuBpl/0jV6QAeZZzluSYt4yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740483750; x=1740570150; bh=/YWlloh47UsiuIgCVjXuv0nO+GDhDT6sFxj
	B2qAK0Ys=; b=wCUYueNcuCpf0UcLbVdjSqBcRYbm0nolsrBv/cfvJ8Bru8zrUIK
	jsGU6pVedBEmLt04YqAVXze3m4dqZgfxbskt/dzQUh38fguoUIkLGWyT2Npsyd69
	2krDQ5Lv9rTqPKs12FlRTy4Wr0ZE4r2fAVx5VM/De8vqnIciw1748UgawZltHJEe
	3GXtFDF+AKhq1CnbPSmthHz7YN/FcUjZEM1gxRv6THAI1zxSpOzWATs0aWmx84L7
	AZYxEis+ZjQrDAcJJkWbBnYGFKrumooQnnujRYDxz13ewUxdJQ62BqXcXUGzCfI5
	Sr3T8N9yLFLZV3yxHj6G0RiI0Ke14TXhp0w==
X-ME-Sender: <xms:pqy9Z5bBCf-QIfgwBobuNMmS_JcjJ5RdBV7p8CMlq-fG7DxYDKgtJQ>
    <xme:pqy9ZwZNUi2imU8coOO4o6v2JRKiROe2nFz9Px2e0TjALSqGc7LAYaYb2w9gHaVPl
    Q4l9R83zD9SqgrGkw>
X-ME-Received: <xmr:pqy9Z7-HJmoYjfbT967cGcz0KxOvsg-BVK9ICSt5xJ4RlfDI1U6upeTHQdwDGOaDzsys8a9Us8Ey_-0DEPbx1AUf0r8CxCN_P6rNwX66sgm0Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pqy9Z3rSVNtDtYOJxpkCXDvW8uBttRWKgv1hnaqWUYJGZfaj6VGI_g>
    <xmx:pqy9Z0r-8qhQkALdIAxuGhL6xam9F4MNDG-kHUs1CD3AdG_ttHnfTA>
    <xmx:pqy9Z9RdC1mgb71C_8NDaDm8hfBu3eS7pi4pxuta9MCB9XCSIoUT4A>
    <xmx:pqy9Z8r8MOqg1I4NMAZRK86o0PBGMKPUEVwYBTkbL4SGxFQtS51Dxg>
    <xmx:pqy9Z_UpCqvoPTXez87dUNt78yDHjBtqed7J-YTM3rVJe91hkr12Ym8o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 06:42:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e899b1da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 11:42:27 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:42:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 01/10] loose_object_info(): BUG() on inflating content
 with unknown type
Message-ID: <Z72sns9I-zq_KoNr@pks.im>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225062824.GA1293961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225062824.GA1293961@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:28:24AM -0500, Jeff King wrote:
> After unpack_loose_header() returns, it will have inflated not only the
> object header, but possibly some bytes of the object content. When we
> call unpack_loose_rest() to extract the actual content, it finds those
> extra bytes by skipping past the header's terminating NUL in the buffer.
> Like this:
> 
>   int bytes = strlen(buffer) + 1;
>   n = stream->total_out - bytes;
>   ...
>   memcpy(buf, (char *) buffer + bytes, n);
> 
> This won't work with the OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag, as there
> we allow a header of arbitrary size. We put into a strbuf, but feed only

s/into/it &/

> the final 32-byte chunk we read to unpack_loose_rest(). In that case
> stream->total_out may unexpectedly large, and thus our "n" will be

s/may/& be/

> large, causing an out-of-bounds read (we do check it against our
> allocated buffer size, which prevents an out-of-bounds write).
> 
> Probably this could be made to work by feeding the strbuf to
> unpack_loose_rest(), along with adjusting some types (e.g., "bytes"
> would need to be a size_t, since it is no longer operating on a 32-byte
> buffer).

I was a bit confused initially as I was thinking in terms of `size_t`
and `uint32_t` as I misread 32-byte for 32-bit, which is an immediate
shortcut that my brain took because 32 bit is something you read all the
time. I don't really have a great idea for how to introduce the byte
chunk better though to avoid this.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I found this because I was tracing the code path after
> unpack_loose_header() returns to verify some assumptions in the other
> patches.
> 
> It really makes me wonder if this "unknown type" stuff has any value
> at all. You can create an object with any type using "hash-object
> --literally -t". And you can ask about its type and size. But you can
> never retrieve the object content! Nor can you pack it or transfer it,
> since packs use a numeric type field.
> 
> This code was added ~2015, but I don't think anybody built more on top
> of it. I wonder if we should just consider it a failed experiment and
> rip out the support.

I certainly do not know and cannot think of any usecase for this. I also
expect that a repository with unknown object types is a recipe for weird
edge cases in case they are being read somehow.

I guess we'll know a bit more when this patch series lands? In case
nobody complains it is another indicator that unknown object types
aren't being used out there in the wild.

>  object-file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/object-file.c b/object-file.c
> index 00c3a4b910..45b251ba04 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1580,6 +1580,8 @@ static int loose_object_info(struct repository *r,
>  
>  		if (!oi->contentp)
>  			break;
> +		if (hdrbuf.len)
> +			BUG("unpacking content with unknown types not yet supported");
>  		*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
>  		if (*oi->contentp)
>  			goto cleanup;

Okay. I was wondering whether we still need `hdrbuf`, but we of course
do in order to continue reading the type and length itself. The only
thing we restrict is reading the contents of such objects.

Patrick
