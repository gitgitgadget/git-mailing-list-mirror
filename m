Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8D2F84F
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907083; cv=none; b=p7SMNSilUPwVQFaqIgZjWL/ktTUmzPPdQjzzBE9CByQYmGzSrq9lKH9oVkhglFD3bvCXBjvK7wOY9VSzqL22JHZumvIYQZSjA4Zs15ek3k9rbKyy3uudzGC2/xwh0Yl4FLdbLpo8rGq4MZHuuJzJWV8LqmSJQ4xRzhdwDYoYObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907083; c=relaxed/simple;
	bh=QAk/Pzr/jlQHBBzf3c+nNhWALwuizIouXn+0NKY/8Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2lzaLFkmZwW2vojHSayWT3IDF/Fa50+K7AUseUoo6JSxswgeaejjx/Vvo84MhyDIsexPHh/JahMpaI4IJ5+oetqo5Wym1UqZM0ngFgjSQSiZsdW/8GmHpJhLcNABse+vNp9KM2Kc2roY5NjZXmB6HQlx98lQKKUQ808K8mM028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NpxfI2bx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2Bd73X8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NpxfI2bx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2Bd73X8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A56781400220;
	Thu, 19 Mar 2026 03:58:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 03:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773907080; x=1773993480; bh=wPyNFbMzRQ
	JME4PNMhDXkVNwrC9c7S3Ce62Uee11Lto=; b=NpxfI2bxKu8ggjktAH2q1UTEY1
	2TGFZpwRJNF4k6g/8yOqt3U7ddAlQZKRAAS0Ga7XMTFVCt2uyQ12644CYrUM3V1L
	UdfQ2wuOvs0l0TnQh9b16WNzcBnutPZITBEzta66i+Mmwax8qtplkPCHFqrz/Gvh
	Lw8/lsfk9IxqPwf6nbFaCet080icsP9gd8TqWlZp/OG2Fu9u3YxTTkwv4zwIOD4C
	VXLvS6ovoMnfH0ejF+FMeDHye836BupIuk42WufvBT1IfR+wPKrM8iNWe8bGOrjL
	JDuqgaWUvZEtpU3jZwgkpiypK71GmyhmY4OFe+1KK3Ca1wGKZvNCZoR6NvMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773907080; x=1773993480; bh=wPyNFbMzRQJME4PNMhDXkVNwrC9c7S3Ce62
	Uee11Lto=; b=l2Bd73X8H4w2pGsVU9eD2Wwc7Kbfb+EAwFghpmqKhL7bJ65FIF1
	h9S+/QiU/SoTrJYsZG9G2y0quV5uFH3gYKO2wt14wEhFo/7mh8F5bwzS6pr+YBOl
	IBTl7tk4t3jZHJwYzX7keyzXqkq5PbMZuf6UViqt0lK+fEl/2vvsCe//9rrR6hD3
	lTYc3NWa7NcJwmijzWMO8p5rQhD0XG6AUJXT9OSYYP02ESzpdD9XcDzM8qNf/qSl
	1VjcdwLhCqGmRcrpTANmXVf3xApLSAejIa/S7DJfmc1bD3VONiYQ1Z8W8ueWcwzA
	yKoXesGwwAVaLvlwqwYQKZ2m6IU9e/EXFLA==
X-ME-Sender: <xms:iKy7aWV-2QG_m61dClAt3Vixup1kdqEKlI9nPUfR6l1YcM9BUIYqvg>
    <xme:iKy7aYku2ST9l5Co6CFttJ28B2xqUFjep8qhde_OsrepDOuKG8u1DTY9NmNeq6HCq
    briXI7i064HZ0z8G2wmMoKYbjwqaHnZzhRJkn4NZ5FxlkNy2DJGkA>
X-ME-Received: <xmr:iKy7aYDc3LgYerlmQVx29azmZW11HGxdiyvsNnjYkqnC4MHTF03nQ2AfGKQ7PKm1MgVDR-Jlo44RNRPU8Jg3EWOfgGc5GmWXSojCxSsl-X_7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iKy7aYcr_5F7pkmgK5QMRjVQ5aLxcwT_SBG72LqdZZQ8sHLcUcctRg>
    <xmx:iKy7aTJQ-4bMiXvFxK6stYCbObrcfnrqU5xrU0TD-X6JkOjR-eZsGQ>
    <xmx:iKy7abf8vSrsfPdrVka_neZorkRNeOgJ7ySEORzLHLZDfPvHPcAc7w>
    <xmx:iKy7aa22OWrHgrx1cPDRv2QW5DGK0GmcZYbjxhb2CYk6yIWctYUY9g>
    <xmx:iKy7aRujTkgHNeL_EjppHXDcjAUFJXIZS6NieI_wn6Om0v32S8BdNFZc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 03:57:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c93ad547 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 07:57:58 +0000 (UTC)
Date: Thu, 19 Mar 2026 08:57:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rerere: update to modern representation of empty strbufs
Message-ID: <abusg-X1vtd48UpZ@pks.im>
References: <xmqq341wnvbk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq341wnvbk.fsf@gitster.g>

On Thu, Mar 19, 2026 at 12:15:59AM -0700, Junio C Hamano wrote:
> Back when b4833a2c (rerere: Fix use of an empty strbuf.buf,
> 2007-09-26) was written, a freshly initialized empty strbuf
> had NULL in its .buf member, with .len set to 0.  The code this
> patch touches in rerere.c was written to _fix_ the original code
> that assumed that the .buf member is always pointing at a NUL-terminated
> string, even for an empty string, which did not hold back then.
> 
> That changed in b315c5c0 (strbuf change: be sure ->buf is never ever
> NULL., 2007-09-27), and it has again become safe to assume that .buf
> is never NULL, and .buf[0] has '\0' for an empty string (i.e., a
> strbuf with its .len member set to 0).

Right. We always require strbufs to be initialized, and that will always
cause us to set the `.buf` member.

> diff --git a/rerere.c b/rerere.c
> index 6ec55964e2..0296700f9f 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -403,12 +403,8 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
>  			strbuf_addbuf(out, &two);
>  			rerere_strbuf_putconflict(out, '>', marker_size);
>  			if (ctx) {
> -				git_hash_update(ctx, one.buf ?
> -						one.buf : "",
> -						one.len + 1);
> -				git_hash_update(ctx, two.buf ?
> -						two.buf : "",
> -						two.len + 1);
> +				git_hash_update(ctx, one.buf, one.len + 1);
> +				git_hash_update(ctx, two.buf, two.len + 1);
>  			}

Yup, this should be indeed equivalent given that we declare the `.buf`
thing as `char strbuf_slopbuf[1]`. So we'll get a single NUL byte here,
which is the same as the empty string.

So this looks good to me, thanks!

Patrick
