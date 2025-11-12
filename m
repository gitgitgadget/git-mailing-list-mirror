Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2430DD05
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946775; cv=none; b=nOx2HADiocFxJMZwasW4Xbt+ghlb7xhM7mOYu3p3MX6ugQ0xumZdEehNJUocCCUolqyt9l6O6qRV3AAtNGmlgwSKoSZPk3xiqpStP5t8EymkGEQfU+VYV3Ou3LBl/BXlNcAAeL/6Rb131V5bdhWl4iXWKAXb33EOSNsPwFRyWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946775; c=relaxed/simple;
	bh=42oKNqpfnBM+NDZBlW6lXxPXJEqrYy0jkurnyJPAh7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/wvMDDiqRoC8KHW8l/zWLj6up4PhuhaQ3tuIZVnzqAJp2F998hVUYKduNOUVBTcxOqErHXJCKmOrrXNQpaHwCKRndWrLPj2wEddKgxw4ZPaWygvhs7v6G4OJXpoQuUClVtEsbp3VQRJTMQAGoJrfqIYbAtqCXP9FstBhlUMp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UCpqvgw7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/+XnX/f; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UCpqvgw7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/+XnX/f"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92BB37A002F;
	Wed, 12 Nov 2025 06:26:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 12 Nov 2025 06:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762946771; x=1763033171; bh=cOgfwJ3RHw
	bRe1JZzLRrSag1ABtEV86DJz81o6WtznM=; b=UCpqvgw7vkWlbxk6TcNjzAXcEx
	GF0Yjmgdhj3ky3yoe3VZSY1JPaG7GL0wImT1Zljj3RvIBXbmUFX7Mnb9WCm1uKdp
	I9Ig6s26SQdnzG75XnPM/W3VCj5FCe7VMTZOxgh59v6AJ4T3xmsei0KMFQ7l/2MI
	2us7hrnzPpbltZgbQ47VQREmA4QLTylNZCjk1Sw3VUVoDDCJ5Yso62mJWhddaaO3
	w24hX56Yz0A3eq3eEJj+g5Eofq/6Brn655WjzDFAaXHZ/Gj2GiXIhnL7YqawbWEe
	W8+iVehBviX29375nsQ/0GV4uPOlUM6J+vLMQpUILi0OuxBVL7ZYWXt/WJBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762946771; x=1763033171; bh=cOgfwJ3RHwbRe1JZzLRrSag1ABtEV86DJz8
	1o6WtznM=; b=b/+XnX/fZ/2n1cFVBLVa0BM0TMk2PyyJSG8K9+dkIu7DGvoP+U3
	poH0V6rHAWX+LwQvJeF1ql4acH3MhePfu0DS2TVEZti07hnvHETZqEmHFJnUd9uz
	XjlkifQDoZE4wK9qbzMT3I7dwGmhOgxAfcY9MJkvcboJwfEpYUq54Z324sg1EpQA
	TajdXFE/dUDZgLhu00vpD4TdYfKCOmqlOPJcehCKzVVfHYSBQ7GNSUKzOg3gEDAH
	uuIwK23QrhqI/mY7OCTxARi7Uo3E/gJvbsG+E21X1UKtY2ND7x2Ec8SsFUFiiHEA
	l9kE1XF3eYsitm7OdjWzBOq6PC+nmreR+uA==
X-ME-Sender: <xms:024UaTKZLn6OcQU0e0KftKMBJbKG9hkZtWO4vepuJCOANMqLy-Czvg>
    <xme:024UaeLmwJAcZGWW6OypclVmVHHi7D0COhPKv4liosEnn1AzGcYkV_IjH7rcz8NlX
    N58O44CWaWO_zXmxuiJ0B0KELEHls3KepAEY1adv3XVgdqwpvIR>
X-ME-Received: <xmr:024UaQto0zOisKLsTe7JKNHtUZTicC9fnmKvnX9H4PtF5GofuhIQA9FBN4HVGTBCuLZE_Q0T_I-ZTIGsDrP6O1uzooZlWBzlpmhqC8EkXRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:024UabQ8wU2kYJdiGYDzj_0qSqR7Ro1bvMslZbRDM2n-_kZHVZ44dA>
    <xmx:024UaWPGAXP2Jk4_5QkQwpCewn7_arb9DwB6B-DCuiZp_FYQuZwJLg>
    <xmx:024UaQa42Jt5-IGj6Ha06xbf70_UmEWsSqKEzWx-MStmCXbVuuFcSQ>
    <xmx:024UaQzSDnJ3KaH2HefxgOw2PSRVsmKwBe3Xfak3KH3_xxURHpNabw>
    <xmx:024UaQPq2axd-Tple5j9haVRwzTzNTFeGwFraDyNICFyKTpWefLfeUgG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 06:26:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9fb8aa5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 12 Nov 2025 11:26:09 +0000 (UTC)
Date: Wed, 12 Nov 2025 12:26:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 4/9] cache-tree: avoid strtol() on non-string buffer
Message-ID: <aRRuzrmbJBW8q4Dd@pks.im>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080537.GD979063@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112080537.GD979063@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 03:05:37AM -0500, Jeff King wrote:
> A cache-tree extension entry in the index looks like this:
> 
>   <name> NUL <entry_nr> SPACE <subtree_nr> NEWLINE <binary_oid>
> 
> where the "_nr" items are human-readable base-10 ASCII. We parse them
> with strtol(), even though we do not have a NUL-terminated string (we'd
> generally have an mmap() of the on-disk index file). For a well-formed
> entry, this is not a problem; strtol() will stop when it sees the
> newline. But there are two problems:
> 
>   1. A corrupted entry could omit the newline, causing us to read
>      further. You'd mostly get stopped by seeing non-digits in the oid
>      field (and if it is likewise truncated, there will still be 20 or
>      more bytes of the index checksum). So it's possible, though
>      unlikely, to see read off the end of the mmap'd buffer. Of course a

s/see read/read/

>      malicious index file can fake the oid and the index checksum to all
>      (ASCII) 0's.
> 
>      This is further complicated by the fact that mmap'd buffers tend to
>      be zero-padded up to the page boundary. So to run off the end, the
>      index size also has to be a multiple of the page size. This is also
>      unlikely, though you can construct a malicious index file that
>      matches this.
> 
>      The security implications aren't too interesting. The index file is
>      a local file anyway (so you can't attack somebody by cloning, but
>      only if you convince them to operate in a .git directory you made,
>      at which point attacking .git/config is much easier). And it's just
>      a read overflow via strtol(), which is unlikely to buy you much
>      beyond a crash.

Agreed. Good to fix it regardless.

> diff --git a/cache-tree.c b/cache-tree.c
> index 2aba47060e..ab20ffe863 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -548,12 +548,36 @@ void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
>  	trace2_region_leave("cache_tree", "write", the_repository);
>  }
>  
> +static long parse_long(const char **ptr, unsigned long *len_p)
> +{
> +	const char *s = *ptr;
> +	unsigned long len = *len_p;
> +	long ret = 0;
> +	int sign = 1;
> +
> +	while (len && *s == '-') {
> +		sign *= -1;
> +		s++;
> +		len--;
> +	}
> +
> +	while (len) {
> +		if (!isdigit(*s))
> +			break;
> +		ret *= 10;
> +		ret += *s - '0';
> +		s++;
> +		len--;
> +	}
> +	*ptr = s;
> +	*len_p = len;
> +	return sign * ret;
> +}

Hm. I'm not a huge fan of not having any error handling at all. It just
feels way too fragile for my taste:

  - As you mention we don't detect overflows, as we would detect them at
    a later point in time when trying to access index entries at invalid
    offsets. But if the input is crafted in a way that the overflow ends
    up with a reasonable index entry we might just as well _not_ detect
    that an overflow has happened and end up using the wrong index
    entry.

  - We don't verify that we even have a number in the first place. We'd
    simply return "0" in that case and not advance the pointer. This is
    fine though as we verify that the returned size is non-zero, so we'd
    detect this case.

I'd much rather prefer to have an interface similar to `git_parse_int()`
and related functions, which are way easier to use compared to the likes
of `stroi()`.

Otherwise, the next time we want to have something similar like you
introduce here we might not be aware of this existing helper and may not
know to generalize it, so we'd introduce another ad-hoc helper.

Anyway. I won't object if you want to go with your version anyway, as it
at least fixes one class of errors.

Thanks!

Patrick
