Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039925D20C
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736896; cv=none; b=OUaLlP7W5lMhk9lHPBAufqLWDylkrH63Sz41Aj6eQmyg7tzfv8J24Co7jqw1Nx17s4WpzaOqNkIQ4zEmb6dDgRhNEIhZ7OyQtmzEtOZNycFKhQBqA2fIEL8ja3DKsKv48BPxXW2EuECXNctExEUav+qFdqca08WSAwd9Uzim6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736896; c=relaxed/simple;
	bh=NAaeK5m/r9YH7OGVoJmPI6iCG8wJre0ywW1kBaegPBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR+gqyEhAIo5FISYjZ3iWwi4Pl+R749qq5kdWoqJI9r4wCc/u5LJUQhkkSo/JpDQs/z4iNMtawY5RzzM1oR0uyA7LuUYPQwwC8Dz2lrNbU4+9PQbFNctU3hGu1+5T68fpIAS+C6RMyg9cPW7wLIBWZBYQOZTA4Yzu+KzTRm09vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TGtajAAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMQ0D7Dj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TGtajAAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMQ0D7Dj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8D6611401EC;
	Fri, 28 Feb 2025 05:01:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 05:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736893; x=1740823293; bh=7Ccsdk2UqA
	NFZl5PQA1jxXxrWv5Ol+NW/ItJNhW3OXI=; b=TGtajAAmRgIIUsrfh9DaQPOpc/
	zyX+0rvDigRk2XAkAeeP3sARQymicIMRPZa6Vm2sjq5+YIl6UKGRtx1zHFRj8y7S
	FXjc9w84GT2/+eDppKseS/bPtruvm/uXerCK820a5UrNMZfvfsKwbPlo+dZCI6CJ
	DB1yv3fAX6gvHbFo0hF6TVJVtZBec0Ssu+jAqK02pSAXfA8Fem4u2uIYJIBnd3G3
	3NbGb2Ja4xBQ1sljmWGgULEyo/1291nZj4JpLj3XvDcT3yhK+GOABn10bDRKxg0k
	OAVLHXl9DWTY8V5PJxIy3WS5ponnQA5bDki9hPbptmbM6SbVoGkza81LsQvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736893; x=1740823293; bh=7Ccsdk2UqANFZl5PQA1jxXxrWv5Ol+NW/It
	JNhW3OXI=; b=uMQ0D7DjtVxNoOp3vOtEjP0YehRa/8UMChuwQRMxw3rRIZvEDmC
	UoeDzeugeNSVBUpDwUBtpPJ3b8tEZ+mjDgciH/zUUkaZtNBRGjqWkKiqkPAvGrTY
	3RGIfoyJXFtYxc6MsjEof/59ss+irGRI7C0OV5J/WPIIpgA+RAIdiXNn0+l81COO
	0ySHCx0WQKKfhJhK4rjkGVyyGvjvkkIaj76F8OIZOD3A7EeQjCfjOa59LN4jVZ0Q
	QkpcyAwIVXJ2YjjCTKyd2aSMp3wjdhQZNPbcY9uya90H0w/hdFUPhOhYnPIiJWJF
	QxdXFJ8Vw/+EXIDWL0oZZf3quSBqQbgurEA==
X-ME-Sender: <xms:fYnBZ3xxLwht-SOqy1eprYyV2gDePz1FDONG8a9onUZ2layIhMe_TQ>
    <xme:fYnBZ_TVboqOvXIuvNB7ysV3r6VJ1sDwrpCBJdLXDHbHllftFxOjXWd0H6bLkBCN8
    kOaODzMG6gndevyJw>
X-ME-Received: <xmr:fYnBZxWpulHMX2qoO8qTnCeRCo5CxYL85BxuFoizxCT6dX5WHpby-12rAgp3zWIo_OjykNx8_-bbCtArQIAKXmBOwn-EClop1eyQU82uOy-amrCL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fYnBZxhIotq8R7TY_hgfESJLbYPOOs8JI7DQRX5vOTgGYlkiLb1waA>
    <xmx:fYnBZ5AGQma6sOlCLqO8pqoA0qCzeoesfuBE1y9Y1WJzbtEdhnhSJA>
    <xmx:fYnBZ6LHqEl3NB7TS6Rnn2b4LS5tWKnG3MZHAP1_uqah29rFQYomjA>
    <xmx:fYnBZ4AdLvj5X7zx46jGz_B81iKWvzKSc-lDyuH3HjPsAzEbC34lcw>
    <xmx:fYnBZ869erJZFNrP9rfcRv1DujuEUGeaw11v6dWMElH4U3s7BVdxWyrK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa633ecb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:31 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/13] ewah: implement `struct ewah_or_iterator`
Message-ID: <Z8GJemN4K99BVT2J@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <e1b5f6181e38a526cee4bd1f08a397d88b776661.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b5f6181e38a526cee4bd1f08a397d88b776661.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:47PM -0500, Taylor Blau wrote:
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index 8785cbc54a8..b3a7ada0714 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -372,6 +372,39 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
>  		read_new_rlw(it);
>  }
>  
> +void ewah_or_iterator_init(struct ewah_or_iterator *it,
> +			   struct ewah_bitmap **parents, size_t nr)
> +{
> +	size_t i;
> +
> +	memset(it, 0, sizeof(*it));
> +
> +	ALLOC_ARRAY(it->its, nr);
> +	for (i = 0; i < nr; i++)
> +		ewah_iterator_init(&it->its[it->nr++], parents[i]);
> +}
> +
> +int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
> +{
> +	eword_t buf, out = 0;
> +	size_t i;
> +	int ret = 0;
> +
> +	for (i = 0; i < it->nr; i++)
> +		if (ewah_iterator_next(&buf, &it->its[i])) {
> +			out |= buf;
> +			ret = 1;
> +		}
> +
> +	*next = out;
> +	return ret;
> +}

Yup, this looks rather straight-forward: we advance each of our
subiterators and or their respective results into the accumulated result
that we end up returning to the user.

One thing that surprised me though is that we don't seem to be able to
tell whether all of the iterators could be moved on to the next result
or not. But I guess that makes sense: iterators of lower levels will
cover less objects and will thus eventually be exhausted before the
iterators on the higher levels.

> +void ewah_or_iterator_free(struct ewah_or_iterator *it)
> +{
> +	free(it->its);
> +}
> +

This should be called `ewar_or_iterator_release()` because we don't
releate `it`, as documented by our style guide.

Patrick
