Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F172FB0B4
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968368; cv=none; b=fEhnF+hbbz6Jy+elJOHCHGmeTvikP39iMTxjxJuv8a5TjCenxuXdeRXTMb8U4GxcofA1/1yYeuc8EwzA4C0AqbdKO/ezBFvzLNVrIIdM1/UAv3E43txXVyvM91QHr/x35OeATDxIi6O/fgj9Wr3TdSx6ZYpzIXFWoVuOWjS/QrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968368; c=relaxed/simple;
	bh=/22zXI9n9ITwqjewDI1MQ1VRAQnxeVHJjAMUmvamHnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKcGBO0wEnvR9870SxmCJNepw3QCd91fPDfIN+Bq49OwZCOQPASslyXSYqj1xhoVKamcA0yW5BSwAFFpvMrkeR66FKLEsj2EZHo6MXfinm+lPbMVcOXverRyLprr0C9rvapgfW/NaRFpROLf97QhdVcarlwDpWWGPqs1kEg9MGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cbUei+t7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fhTjl865; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cbUei+t7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fhTjl865"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C573F7A013D;
	Fri,  9 Jan 2026 09:19:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 09:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767968365;
	 x=1768054765; bh=tS5PsQOShUtnQFivyP9yydUs+wMOi7epJjG+dkY7Fq0=; b=
	cbUei+t7upOjJvHYELomtMwf24+a8xAZc4oZQM+z70FZB3t3jU1pi9/a7h2eavta
	9gz3KAvg2CVK6O7dFOo1PESUacuEogDDu2HqI+E06sV7CDSluNCV6MIT3FX9pcwS
	ORQBhnm10Q8cjYEaxTukIe3onmM4yVdUyuE9PREQxeSLvYcUudVdQsSLkPaS6Mpq
	0auHUUsouNd6ngtT2howRO4KN4jZu0aJXUUIbQYLhQioKPREdO15KohNqSI4XJAS
	9HMnW1gCS7khqnPqAMB9ePMVlsnSBa+SkcBJoOlp0iQNOd0hTcQ6VSXAeU1bo//y
	Y1V04IqP6MEcwPWXfuUgCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767968365; x=
	1768054765; bh=tS5PsQOShUtnQFivyP9yydUs+wMOi7epJjG+dkY7Fq0=; b=f
	hTjl865f5jZOETagpFxwQe4OJ36AK/ZXd49oZYbqn0P4hIKP0WtwOGm5kTkaAnse
	Bkene0AwAuiAoxVg9GX2m/WXPhuc/XULeer32DjI/yym7pT2NO8mZSCo/fnR3PTe
	f9YqkKf0sB98Kec1KUMVWKM6CHbu2daNUGwAKoFns2qzqpK1xuesnHGBiQAVMH9h
	6P529Jt/VK6HkcdaUKKRPpAmwPSUFn3ib/fzPbEOlvK9mh/tLC8qm0I4uLOP4Qw8
	zWU6kuGape/bQC2647ujN5m6ma/bISsWn75T33ThXOW+USh63wER3lA1asaPde7X
	pdxPOul9czzSbfE5SEfQA==
X-ME-Sender: <xms:bQ5haa8D5WBbfDQbRJDOOokyOL3dbUVmhOhjTCotGfDXvmzOJ3AssQ>
    <xme:bQ5haQtruQKpTQFIvzVMBUV5k1kNdXYt0oEE4DZERokP-aKc-O_vEe5Q4H7eZ0dai
    geoenysJfW7g6QO3vkj07fbBkGANzkSfORurzlieJGaglSbYHSEQQ>
X-ME-Received: <xmr:bQ5hadpriyvJl5x2K9zkPr5T4FSEcNWFyti6hVHZxozTXltGbT-hhguLYvWmUUXiKmB50URMIhs8InQ346mhUI3MgpnWqo6FCntXek9OeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeevuddvfeffvdejvdelueelveevffeuvdeuueevteehffduheeuvdefvdeujeelueen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhsrghhihdrvghlkhgrhigrmhesphhrohhtohhn
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bQ5hadkQFW6H1nD5f-U3oFuCN1TGITiZZ0tvKPMO4BlPI3Wup-8PRQ>
    <xmx:bQ5haRyg7WsKLEEaFW1AE1nFI1Ovn7FFM0Y96O5JpjcECQkfrN2YGg>
    <xmx:bQ5haVk_bvFyy9SAz5l_fbli42fwpo_UzEOT0oYJq9r3XpGD1HEKJw>
    <xmx:bQ5haaehe0iyMENA-JUFve5B4OLvhpcokUaBWzuN8hI8HBExtek9Xw>
    <xmx:bQ5haWWVCN2uypiLr6GZKu-Cx2YSmOBdzm5rSO82XJ8pMs1mmjDhvoqc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:19:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d24bff5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 14:19:23 +0000 (UTC)
Date: Fri, 9 Jan 2026 15:19:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] reftable/iter: fix UB in indexed_table_ref_iter_next
Message-ID: <aWEOaFpjj5DhFBlC@pks.im>
References: <iaPdageDbUKEIQVlnOugIRhoojxnFo3j-WJFWY0eC5el1Epu3sxEnto6Lrd3bhAYL0Ry8T3czP5UPhLHX_gfWCDiCoLuMofdRkqfOSYP-Jk=@protonmail.com>
 <aVvR6U6EJ9wfKk8l@pks.im>
 <f4gLTILYbAvRqE-aKM3PTyIajeuZBM2Vgo5V66Q8gI6gpI0niPpz8w_lMa29V4Rou2TJ95SKwm2B16KitVrt47KtCzY-eRBm7kemh0iw82s=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4gLTILYbAvRqE-aKM3PTyIajeuZBM2Vgo5V66Q8gI6gpI0niPpz8w_lMa29V4Rou2TJ95SKwm2B16KitVrt47KtCzY-eRBm7kemh0iw82s=@protonmail.com>

On Thu, Jan 08, 2026 at 04:52:05PM +0000, Tsahi Elkayam wrote:
> The indexed_table_ref_iter_next() function provides reverse mappings from
> object IDs to references. It currently accesses ref->value.val2 without
> checking the reference's value_type, leading to undefined behavior when
> encountering unpeeled references (REFTABLE_REF_VAL1).
> 
> While the current "obj" table implementation is suboptimal—it yields all
> reference records within a block and relies on manual filtering—this
> manual comparison is necessary to ensure the yielded record actually
> matches the target OID prefix requested by the caller.

It's correct to yield all ref records of an indexed ref block, as any of
its refs may point to the object ID. What's incorrect is that we:

  - Don't seek to the correct obj index block when creating the
    iterator. This means that we'll also seek into ref blocks that won't
    even contain any ref with the desired object ID.

  - Don't abort iterating over the obj index blocks once we see that its
    object IDs no longer match.

So this needs a bit of rephrasing. Please feel free to copy these two
bullet points as-is.

> Fix the undefined behavior by checking the value_type before performing
> the memory comparison. Additionally, replace the "/* BUG */" comment
> with a TODO explaining the current implementation's inefficiency, as
> suggested by the maintainer.

I wouldn't refer to myself as maintainer, I'm very happy to let Junio
have that role :) You can for example simply add a "Helped-by:" trailer
that refers to me.

> diff --git a/reftable/iter.c b/reftable/iter.c
> index 2ecc52b336..2eee65bb1e 100644
> --- a/reftable/iter.c
> +++ b/reftable/iter.c
> @@ -171,12 +171,19 @@ static int indexed_table_ref_iter_next(void *p, struct reftable_record rec)
>  			}
>  			continue;
>  		}
> -		/* BUG */
> -		if (!memcmp(it->oid.buf, ref->value.val2.target_value,
> -			    it->oid.len) ||
> -		    !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)) {
> +
> +		/*
> +		 * TODO: The current implementation is suboptimal as it yields
> +		 * all ref records in the block rather than filtering by the
> +		 * OID prefix. This manual comparison is still necessary.
> +		 */

And this needs a bit of rephrasing to represent the above. For example:

    /*
     * TODO: The current implementation is suboptimal as:
     *
     *  - We don't seek to the first obj record that matches our OID
     *    prefix.
     *
     *  - We don't abort iteration once the OID prefix doesn't match
     *    anymore.
     *
     * We don't have any users of this interface in-tree, but once we
     * add any we should probably try to fix this interface.
     */

Thanks!

Patrick
