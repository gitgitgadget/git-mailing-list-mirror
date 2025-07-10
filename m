Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F52E36F1
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129856; cv=none; b=U6f54Jo4XO62FLMWgqaVB2680GvGrvwrxn8Qtuz12Xcufmbn0v237PrA+nZp99XQ9+Gh1bn/4CrZlJune5B/7Wq/gom5oj+Ifs+l4uE42BM2b8lIzbjcXLIX4Bhix1o3Rb59PrIZaqGq57yvskKzW+8P9hIgwceQHjmOBSIxSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129856; c=relaxed/simple;
	bh=pwz+vnNeE2PFkdthlHnRyf2OrsTfWIKpjOP03nY/2hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSZoC9YgfNb6rudpLFG3zl1TjjD8vGVEHW8Mv94m7BjVsOlljcjJP7WphR+Ka6gzaELzwsS/XQ/ihHZrhTQNFFh4xCn/Wj/BLgVwGoBzhpsI1UjUAYZc4A5v6zNPfaat9JtV9RMe3F7SAzEv6I7Dn3bfaVFLZl6gnIOo4ZErH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UOJPs486; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLQqXL1h; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UOJPs486";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLQqXL1h"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D7719EC025A;
	Thu, 10 Jul 2025 02:44:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 10 Jul 2025 02:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752129851; x=1752216251; bh=3/sTnoReWH
	TcJlsMNsnIxEis38E2/adU6sJXAWqsh8k=; b=UOJPs486Dl5mIIwJ+fZm3YrT2Y
	aOxYcl/wAR1SXFY1RYPbOz33kYsNvWJH9LLBx7cW7+M8c24uaswxzy3C2mzr7cF1
	6RWbNkkxC1ju3mYwxMbWg5OrSrP/OzbsvJWOR55mzsHAMc9OyC1iOATN1WUl7Ki7
	U+9xX/ozRYeXexiBpvu3814x4Hyl0uB6bwSbA4WzhvBwIdW3gpu5dyl+/zEG7+Tu
	dq7uXWfPL7PW6QyOFTwejy1JlFcm7ITanJaiP6Xv6hC7zIxNPfEOq5EzuUOVl+BC
	7dSp//5nO5oRq3CIQMpAVzXXWehveoBvqxJjXj1HuzLjQkMZpXONgRVsEf2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752129851; x=1752216251; bh=3/sTnoReWHTcJlsMNsnIxEis38E2/adU6sJ
	XAWqsh8k=; b=mLQqXL1hwtwpAEccBmnl9tFk8yIWY9mWBBHHVs8qlciIekLEEDa
	7zdVXPnorT5OCo2LlPsUrBkzqSTikz3a6dTQx/iv+yUR7vHcmeFnNw6+eNJEC5VG
	TlX+8zP/KAGBPPwTbO48QqncVCE7mLYat2wFeklk5DxsVpyXY00PXLyrGxzc4v8w
	+aO/0TrKp05U007hCn+Ylzvt02n1jwXyNuR/i6fr+zf3qitDWvGHvSRoa28OfwF6
	0vEUEO2dnFsFZXfw1l9zXhP+BxTxuZoN8fGhQ492KmJysQBCy5xPouuUNPXlPeM8
	4oHUsbuUeO4Quj5YDUrJo9CmKMzVWInzA/g==
X-ME-Sender: <xms:O2FvaNvq4OboCz2I46n5frFE_smsmJNXwrAnYYMmh467MGnC1bSYbw>
    <xme:O2FvaB9Uu28NHnAep-pZ-j-kTx4ROh_vCq2SHMxcCPTfTZHFiTbNVhdDi1gJOOejk
    Kjuoe-513cDXoeSeQ>
X-ME-Received: <xmr:O2FvaHPVi9TKugd2fQWS_pLzd1X-8n9h2bogP4ARwjI2XtmIM6gkZEr6w3JJSB3ZN-sZdYDMWdKNuhvOdhACESf8un9wlcxnqqde94VQUYLc9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehstghhfigrsgeslhhinhhu
    gidqmheikehkrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:O2FvaPHwaNa5gvf08YQBVGfHF9vX6GgHga-q7jYcfhyG5AZ5isBkAA>
    <xmx:O2FvaFR2T7NLOIGv5R9Qkom6nkLCCxfMjbUTN-2iFgoPQxWnac9VPw>
    <xmx:O2FvaMshzgBHWqOBQOFeY8APf4siR6PLuN086g0U5hQn1-4iyV_xTw>
    <xmx:O2FvaNIGtrLKYWvvBPuh8jSe11VRqpxtC9O2jWK433sLe-1psv2pPQ>
    <xmx:O2FvaOh039w7BgiD9rUsKaMS96zCYcfTHSLnoajjNoWTKPBRPYSqrzu8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:44:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46eb47e7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 10 Jul 2025 06:44:08 +0000 (UTC)
Date: Thu, 10 Jul 2025 08:44:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, schwab@linux-m68k.org,
	phillip.wood123@gmail.com
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
Message-ID: <aG9hMP9gEFLhVgJL@pks.im>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
 <20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>

On Tue, Jul 08, 2025 at 03:47:48PM +0200, Karthik Nayak wrote:
> diff --git a/refs.h b/refs.h
> index 7c21aaef3d..7852ad36f3 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -1299,21 +1299,32 @@ struct ref_iterator *refs_ref_iterator_begin(
>   */
>  int ref_iterator_advance(struct ref_iterator *ref_iterator);
>  
> +enum ref_iterator_seek_flag {
> +	/*
> +	 * Also set the seek pattern as a prefix for iteration. This ensures
> +	 * that only references which match the prefix are yielded.
> +	 */
> +	REF_ITERATOR_SEEK_SET_PREFIX = (1 << 0),
> +};
> +

Nit: I think it's a tiny bit confusing that the documentation of this
enum is split up across here and the doc of `ref_iterator_seek()`. I
think it would be sensible to move the last paragraph of the function
over here so that the whole behaviour of the enum is explained in a
single place.

>  /*
> - * Seek the iterator to the first reference with the given prefix.
> - * The prefix is matched as a literal string, without regard for path
> - * separators. If prefix is NULL or the empty string, seek the iterator to the
> + * Seek the iterator to the first reference matching the given seek string.
> + * The seek string is matched as a literal string, without regard for path
> + * separators. If seek is NULL or the empty string, seek the iterator to the
>   * first reference again.
>   *
> - * This function is expected to behave as if a new ref iterator with the same
> - * prefix had been created, but allows reuse of iterators and thus may allow
> - * the backend to optimize. Parameters other than the prefix that have been
> - * passed when creating the iterator will remain unchanged.
> + * This function is expected to behave as if a new ref iterator has been
> + * created, but allows reuse of existing iterators for optimization.
> + *
> + * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
> + * updated to match the seek string, affecting all subsequent iterations. If
> + * not, the iterator seeks to the specified reference and clears any previously
> + * set prefix.
>   *
>   * Returns 0 on success, a negative error code otherwise.
>   */
> -int ref_iterator_seek(struct ref_iterator *ref_iterator,
> -		      const char *prefix);
> +int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
> +		      unsigned int flags);

Another tiny nit: instead of calling the variable `seek` we can just
call it `refname`. That might give a bit more of a hint what you're
actually seeking for.

But other than that I'm happy with the new behaviour, where we are now
consistently either setting or resetting the prefix depending on whether
or not the caller set the flag.

> diff --git a/refs/iterator.c b/refs/iterator.c
> index 766d96e795..f2364bd6e7 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -407,13 +408,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  }
>  
>  static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
> -				    const char *prefix)
> +				    const char *seek, unsigned int flags)
>  {
>  	struct prefix_ref_iterator *iter =
>  		(struct prefix_ref_iterator *)ref_iterator;
> -	free(iter->prefix);
> -	iter->prefix = xstrdup_or_null(prefix);
> -	return ref_iterator_seek(iter->iter0, prefix);
> +
> +	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
> +		free(iter->prefix);
> +		iter->prefix = xstrdup_or_null(seek);
> +	}
> +	return ref_iterator_se
