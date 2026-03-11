Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379B3DCDBF
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246506; cv=none; b=SsfGnVFrLfPfaI0Pu5Di0YF6Zg56qyvfdinxEtM5sBEGqKiMC3bilILn9jwQmADs4A7BReS+Yh8RqpQBB3Evu8lssoCBybsiie2YAKRFMlPxTeYzAFIQlgwy6nfEqzwGL6lZagur0FmM8ilydZzY5YPJzAjxqqam6yNKgis3Sk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246506; c=relaxed/simple;
	bh=7GU1cH+Ze3P9iiz7ZOnqhWtTl1UfzCMyfOgRP9xY21M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=trWNSMS7SShektoDFZwFZh/b6oou60Cam9+4+4dNvBFvw+pQgJfMRsVkFZnpIAUWpzXk8ipTc0ZStFSFsFl8Dds1bt9kgZaqVfaIVIabFN5WxaToxjHWp0D3h+XhiuYY73AkHdRqx7JqeAGdc3geCaPgQuTGSfjNOdyE30SToXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PaplmyKF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9A9WVuy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PaplmyKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9A9WVuy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 558091400192;
	Wed, 11 Mar 2026 12:28:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 11 Mar 2026 12:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773246503; x=1773332903; bh=N0zhxvCMan
	l6VRkHdjg1TGkYUOYBkEp7wjkKPO688kU=; b=PaplmyKFN6heMvIZENPcNDIsjK
	8bIuIC3RYWDy6o6NUe8Mt51Ga/nmxNZuuhFFpRrqZrQFnv4Qsb1tFL2p32k1o1t0
	S04TMqRm3ClcGwnFXNKqtsFNJ91OPg74IXI2jf3Uz69IU9cnNg4dFUOAV6cz3kvb
	VbrPrVrG4muLN2swIDjnLSQ3t24LUfWY/Wzv3O4RlkVskCpG7wpQekwmSo5JpnKR
	ztNgzLo5IUXbxec0ajPm36QAUG+FFwf/D3AIPccPXcg6fSNDdbjMQYusacjwGRSi
	fInitllZnqnnatlZk8e7aOtGB8kZCKRi/MdhqHQJVvGn+vA7JaaXRiG2vfuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773246503; x=1773332903; bh=N0zhxvCManl6VRkHdjg1TGkYUOYBkEp7wjk
	KPO688kU=; b=p9A9WVuy60dqmBtW6Rk8MpdSigWvbNrw/6OQW1Ed/qVY51BDGLr
	slSEUY1vVbzOyVXa4JuKAVbiZE4cFWUTPU5d9g/QV0UJOPvAe+fKPkHXgEmpmI+x
	C7p14ysvtT0VQqCw3nz+vnteKllactsd+L3L2f1T05iLu/L3qIJv/vF1mzO9yGvR
	iyhXzNoIkqhwyYkBXThQ+Fp9KJBPkcTLeZB/6LwJhRjfT9F07nLLR3kqlMko456V
	ibOyGakIDp9ZLgf5AIp8Fe5hpEOHXMGJieZ+3oanbfptrEfuqr1ez+/bDPV0S92H
	uk8MhK1AebOf/azTS1FoIoOMMm3KQwLy6QQ==
X-ME-Sender: <xms:J5ixaeM4X82KEwPtE6efTB8Tk619ciV_FFrnQ-NnOftR7tODiF4ZwA>
    <xme:J5ixaT_rGa3IPg7_52WVN-_GMPv3NVy4l84Swsu1zBx1-qEDKTlR5h5FcTyNUiusQ
    YZP3njl9Hu6xVYkU123baprJjK5T0Km9V6aPjFJaJdVU8q9pZ_F>
X-ME-Received: <xmr:J5ixaaTRYeut6YFgflWOngohKDEY2Q9xfG_lNMn6uzJhuG5rPuVT3clIJO1nOtlfveWYzG-odDKqEcPEgKGGhwvttnhHu7jwwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvvghs
    hhhighhurhhgrghonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:J5ixadmoT29-ThjcS-w1S8EHFoctQYbPjng9kNwcdMghqISZbWZysw>
    <xmx:J5ixaSQQ63kasOSvC3kK8GDoEjaXl-cMF_oDhniAErECwT38VE_Dlw>
    <xmx:J5ixaTOFXIH8XBPwE5OkhnvqsPj9en3CXMACOBOY-EgKPlgyPE30Hw>
    <xmx:J5ixaTWc_8BS3sY6SZZDEwSVRPcbiMcgeqcuWhHmYnhJBOZUhJhUuQ>
    <xmx:J5ixaWOePppBz0XvcgpeAb5B2nV9Moe3tLRuYLLe64WLo5uU3RiuNhVo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 12:28:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2 2/2] list-objects-filter-options: avoid
 strbuf_split_str()
In-Reply-To: <20260311132041.12044-3-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Wed, 11 Mar 2026 13:20:41 +0000")
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
	<20260311132041.12044-3-deveshigurgaon@gmail.com>
Date: Wed, 11 Mar 2026 09:28:21 -0700
Message-ID: <xmqqo6kuqqje.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> Walk the input string directly with strchrnul() to find each '+'.
> strchrnul() returns a pointer to the terminating '\0' when the
> delimiter is not found, so no separate "found separator?" branch is
> needed.  Copy each sub-spec into a temporary buffer using end - p,
> which naturally excludes the '+', so the separator is always stripped
> cleanly.  A trailing '+' causes the outer while (*p) test to fail on
> the next iteration rather than passing an empty string to the parser.

OK.  The above description is a bit more excessively focused on the
implementation (which readers can find in the patch text) than the
level of detail we usually aim for, but let's let it pass.

> +	if (!*p) {
>  		strbuf_addstr(errbuf, _("expected something after combine:"));
>  		result = 1;
>  		goto cleanup;
>  	}

This complains when "combine:" is not followed by anything.

> +	while (*p && !result) {
> +		const char *end = strchrnul(p, '+');
> +		char *sub = xmemdupz(p, end - p);
> +
> +		result = parse_combine_subfilter(filter_options, sub, errbuf);
> +		free(sub);
> +		if (!*end)
> +			break;
> +		p = end + 1;
>  	}

The usual "process up to the next '+' and skip over that '+' to find the
next piece" pattern is here.  There is nothing surprising.  Good.

The "trailing '+' problem" the proposed log message talks about
happens when the input is "combine:foo+" (this loop starts scanning
from 'f').  We find the '+' at the end of the string in "end", make
a temporary copy of 'foo' and feed it to parse_combine_subfilter(),
and move on to the NUL after '+', at which the loop control notices
that we are at the end.

It is curious what would happen when the input were "combine:foo++",
though.  What happens is that the loop begins with p pointing at 'f'
in the initial iteration, "end" points at the first '+', and a
temporary copy of 'foo' is fed to parse_combine_subfilter(), and we
move on to the second '+'.  Then the second iteration finds NUL
after that '+' in "end", and we end up calling the helper function
with a temporary copy of '+'; gently_parse_list_objects_fiter() will
reject it as an invalid filter-spec.

Logically, "foo+" would be a combination of "foo" and "" (an empty
string) and we ignore the empty string, and "foo++" would be a
combination of "foo", "" and "" (two empty strings), but we barf at
the empty string if it appears in the middle.  And recall that "" we
saw earlier at the beginning of this function was also triggered an
error.

Admittedly the original wasn't much better.  It ignored an empty
string in the middle (e.g., "foo++bar" would have fed 'foo', '', and
'bar' to parse_combine_subfilter() and an empty string would have
become a no-op) but barfed at the trailing one "foo+".  This new
implementation swaps where it barfs, complaining an empty string in
the middle and ignoring an empty string at the end.

In any case, the error behaviour against an empty filter-spec feels
a bit uneven.

Tightening to reject empty string in the middle may appear to
existing users as a regression if they are using "combine:foo++bar"
as they are forced to update it to lose the extra '+'.

By the way, instead of making a temporary copy and discarding it
repeatedly in a loop, it might be cheaper to reuse an allocated
temporary with the common pattern:

	struct strbuf temp = STRBUF_INIT;
	while (... loop ...) {
		const char *end = ...;
		strbuf_reset(&temp);
		strbuf_add(&temp, p, end - p);
		... use temp.buf ...
	}
	strbuf_release(&temp);

because _reset() only resets the len member of the strbuf without
releasing the resource, if the next piece of memory you need a
temporary copy for is shorter than the pieces you have ever used the
strbuf for, you can make the copy without a new allocation.

> -test_expect_success 'validate err msg for "combine:<valid-filter>+"' '
> -	expect_invalid_filter_spec combine:tree:2+ "expected .tree:<depth>."
> -'

