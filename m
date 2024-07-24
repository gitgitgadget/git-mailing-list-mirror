Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFA1C6B4
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811795; cv=none; b=X2VXqD8NaIrW0RL4BR1EBcBU/wHA8/BYtl0PtTk3/HY2X9t9t60GuCy3HeQX1cFy61rRamYQ1eNUxAJCaFMeTSQKV1RNlKi2Is1x8FLcJT4He6nz7FeNj933QmKy5rYXjcIQ5EWV+LV7Xa6HzGaYxdl2uqa35NeZE0Q9e1H7TWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811795; c=relaxed/simple;
	bh=xTG3Gkaqy71YSctHQfOF0dbDhcq6fhgOcbtAKVS3oUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgBCZttRqC5QS3vW2BnbIcX4nytGiK6n+85yP8mkiclWQcNpWOD4dXcqO6RPZ9EBqW2uADoNLDUM/nhdGvyS5JlD7kEM9hfYRDFuVNinEe+epbjADk6Xf9Eyr8ZP1HaWhuS5369CZppCA5znk6gn5XvLCceL2Ka7/fKRjIboJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UFQi8BNP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nAiK5MZ5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UFQi8BNP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nAiK5MZ5"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5678411400CC;
	Wed, 24 Jul 2024 05:03:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jul 2024 05:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721811792; x=1721898192; bh=ebMkqUqMu1
	raIgcXtgFBIuY+BMoEBEHFMzNDp8XPBhQ=; b=UFQi8BNP6bBsVMz8PkfKpOpn8h
	FZIKxXTtF10QcNEe6tzypdmeUvv8pRvLcsIe74yY2wrOBpLh7BoyU8m6j754ZYs6
	mrwgFFOA++AZYLM5ydq4yZqtB+s0sS2QUAoyEvU/7JTqx0J+EhGsXJajqDDaiasH
	jOzy47ej6AxVwsCvW12IORlY7IHJu7I3N807P+i04OZ9YKWO4qEFqymeN2BKg9IL
	sZT0tc2dyjfY1jj4/p34yBABXE/Ld5Dn0NXUWNUkcfVUPt3U0MJQtL4KUU2J+p9P
	auU2H97EEeoGsseAikmOTytiAVdj2iOnUsKBVARBjLa4TqIZq34gMMoDyT9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721811792; x=1721898192; bh=ebMkqUqMu1raIgcXtgFBIuY+BMoE
	BEHFMzNDp8XPBhQ=; b=nAiK5MZ5lQa1mURW20smPjhBHDUv6LjhVjNmK1GhiHBr
	nJxvYQakkZ7/WCRsYssswDb++rGMZDF3PExaEaT8DME4yQJw40K7PCQP9CdrJVqE
	cMEbAu+Dj7rd88UUN6R49nvhZ3k4TWKGOeqUsaX6Mts5DRljw5awd54pI5unr3w0
	2/rGRREBiXeEEbhV0/RAaPGD/T3IutoLecnsO7KlmUKnIxp691LsbdYerVc2GY61
	HJ+vbpENPWLCLFM8GLRry6DgVEXyT1al/nE/CT0kN8lsB0u92NDqb+NzLr5leyoq
	SYAkKCA+MpxxpzCGxgcGZNt6W1lsA16yiyNZ430fvw==
X-ME-Sender: <xms:UMOgZjReseMOmX5z6KsWPzWQA_bIbgwQ_yCXKX_UfuOeJlzWiiQAYQ>
    <xme:UMOgZkzwDYWVcPic8tuxhL8EYRWuZTBsMYrCr0PO7w7o9gvO_aWyOn5-7lYAVJRKY
    pqcVwN2w4_2EpnIgQ>
X-ME-Received: <xmr:UMOgZo3wQ5ITE7S3uacVs8F_AmRLI_slBwQStLoh82mrNSbj1MdLrzhoYaYSDzjhdsnwL2r4NFdKPoX0J671x_1xNdcnmZXQPumDYs5eDYyNttoi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:UMOgZjCG651_ARcaXQ_rGuNZyNj1-UESJ1bgOR6IM-MfsPteCgMhKw>
    <xmx:UMOgZsgGW2gVTM1BnD1cyKgmQmjI7iYkOWCaZF4pxaI8BaI9DSqMkA>
    <xmx:UMOgZnovIGh_sI-UVuXw0oSCFY0jQcrNBm-0PAQHbRYh6Cvg7bLKYQ>
    <xmx:UMOgZnhkcUOfpsELQqkFuRv015IiGCBrtFz505roTbiEzjDGwrS6Iw>
    <xmx:UMOgZltK7fFlsHx-2H78ZvpKsXt-wKqj8DiD66pVloPNQESeAOyYKHyc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 05:03:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a66ba74b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 09:01:53 +0000 (UTC)
Date: Wed, 24 Jul 2024 11:03:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 6/7] t-reftable-pq: add test for index based comparison
Message-ID: <ZqDDS3EhXwDittDr@tanuki>
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-7-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ecr04/6WCBBntZDl"
Content-Disposition: inline
In-Reply-To: <20240723143032.4261-7-chandrapratap3519@gmail.com>


--Ecr04/6WCBBntZDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 07:47:16PM +0530, Chandra Pratap wrote:
> diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
> index 9230dd9b9e..23c3f6888b 100644
> --- a/t/unit-tests/t-reftable-pq.c
> +++ b/t/unit-tests/t-reftable-pq.c
> @@ -18,7 +18,7 @@ static void merged_iter_pqueue_check(const struct merge=
d_iter_pqueue *pq)
>  	}
>  }
> =20
> -static void t_pq(void)
> +static void t_pq_record(void)
>  {
>  	struct merged_iter_pqueue pq =3D { 0 };
>  	struct reftable_record recs[54];
> @@ -59,9 +59,48 @@ static void t_pq(void)
>  	merged_iter_pqueue_release(&pq);
>  }
> =20
> +static void t_pq_index(void)
> +{
> +	struct merged_iter_pqueue pq =3D { 0 };
> +	struct reftable_record recs[14];
> +	char *last =3D NULL;
> +	size_t N =3D ARRAY_SIZE(recs), i;
> +
> +	for (i =3D 0; i < N; i++) {
> +		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
> +		recs[i].u.ref.refname =3D xstrdup("refs/heads/master");
> +	}
> +
> +	for (i =3D 0; i < N; i++) {
> +		struct pq_entry e =3D {
> +			.rec =3D &recs[i],
> +			.index =3D i,
> +		};
> +
> +		merged_iter_pqueue_add(&pq, &e);
> +		merged_iter_pqueue_check(&pq);
> +	}

One of those reasons that we use the modulo-loops in the other tests is
so that the order in which entries are added is mixed. Here we add them
in priority order already, so that makes the test less interesting. We
might thus want to do the same here and scramble the order a bit.

Patrick

--Ecr04/6WCBBntZDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagw0oACgkQVbJhu7ck
PpQ2lA/9GxoMT5/2Xok20aRTdliO7K10wzGLudo6CL+i8iiUqi0cRnd58ra6+E3s
b4fXeJQ1QCJyRKyMN3HFvNgkMlEYXmT0cjyfGYjga1kg6vDe8dJ/4PZcBBM2JDYz
HsRv9evhvVu7zXAuvq2DJXeF/uA8ikcqthpOq6+dQe/l5hQjq6GQ1yfq3S5bU0NR
H8OlS25lpFCtFeSHHYvaa+5RpsLpky7kQGYXj8msjr52s/tLPtpD5hGy1YvnT6fR
f3LWSPABmGCoaPCGnZ6g9Mu56ytjSQMlSUrQcRN3Az5g2gzuZ+Z3qqFfJhQLwlbw
MQWES6U6S3A76qHEuLVWeMIQZb/ESN1nECJcL00fExvQ979250inrjx3z6zT7jyg
FSWmj8d3kZw/aTphlFO/6A1iyqebGKVQ+2pqm4D+VChAI+Efon9bQ48efHQ7e6Nd
wgxANRgW7txSalD1pK1+sqrqZ2SntND5f37v4nSSBB1vGyR9LqgkLU3gzr7IYlSW
c/aM1UmKvzBi+wlRLSjwEaUTQL+6En+UCe7fTxZGuEUk2e+Fjj7axrmMgPDeLU14
ZFioHOX3Y7usRgYpHm3L+o++dfSFuJJ/52XPRu1vDY3XDvlrHbVCInN7zppuJXjr
8x1gm/iemKuww0XT4C9xo1i/4m6VamHoY71aX5cjSyWC0EHht4I=
=CH/4
-----END PGP SIGNATURE-----

--Ecr04/6WCBBntZDl--
