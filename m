Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC212D75F
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175598; cv=none; b=Q+U9XEs5/rW9wjpomebH7PP5GRwdsbDGDdOY0l8Jk1his+Q8Kv5hJHWjbRzEDY8kDid+zT/an1Zo/lX7q3RNebHmVAkWLx2B1zRgyOaTQYREVEZKIXd/D6Vi+FoB6YWsNQN9YSbXbu6OH/NdpPd2lHgNoOSBJfSxB+YUahFnogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175598; c=relaxed/simple;
	bh=pk9cHkxz9EtSixGn96NS1QlKUh3QsnZO956SZBqXz+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAfkVwMygsxoblE0wNWG68OMObj1VIr95UbmmDQyV53E1rSoqpe6o8UH/B0HaWEzMtpxrjxc0l3tBPXGCjz4xI09S9dMKLs9x/Caug2J7n4yuWp9XprrENQiMVtOp+0JhnBfMRLvzCv1tLaplF9oLZb3KyG4R2bgPk91YDVf7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YXoqeRnC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZsstveSE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YXoqeRnC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZsstveSE"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 19D7D11401B2;
	Wed, 12 Jun 2024 02:59:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 02:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718175595; x=1718261995; bh=+TF7ur3bXV
	bE/LB+gZ+wW4rkKTtGq55by4D2hOZQfA0=; b=YXoqeRnC+Iv3/zMHX4f6ubp0Rw
	QQGL9m8CQLTOIuf006tVDPn8knKF9+hTP+1x0pEQhBymVIbvVfujus7m3W2qYeFN
	BXsDyeBQ849ZWFktyoeQvu9exPa6a+wEkUOCgTDLRgp57MmdMRvfxH4VYobSRLqD
	lQGVITDOhsJlyKOabUVRH9xJJRWC0epZmi+25H6P2mZ/bAl/pfZXorEx4M2kLSsu
	40XOImjYQkALJWqgFKakS4IPIJDmi/Ah++RnfuoG9fNXAtgvITNbi72jmkDwHtTR
	LlwTPLmc09B7bKzNIGzTeviv9r7QLnucnsg2/V7l6b5VeqcA0zd5PI5n0q4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718175595; x=1718261995; bh=+TF7ur3bXVbE/LB+gZ+wW4rkKTtG
	q55by4D2hOZQfA0=; b=ZsstveSEGYKqta5MxKbXh6Fo6WpdDDHcfB3Emxu229hf
	1q3TuSj0BNKSYClEXcjMIAyJl+Bl2XFLXcShrXLXk0lbrKhcRwA5xLpnc3cFtE0w
	MwQwpBTlrpR2kTSCp5K/HuFRpte3sb61ALTIuuzAdKDoGm4nudIUr1DQptB0P/tG
	ten6Ip+8QmY7fy7NvQFCHu6TrUdElN9xImvARggyUUa4NtUQ3XGPN1XiA4n7A4Hz
	l0VeddYzVP+3c8OYmmOVwnviDh3k4bV6Dzc82/Gsr/mkubILpL4PheQKFk975PHU
	QMN1cG2mahkDYDGxlNFVz/hp/wlvuvUQr7GL3M6fPA==
X-ME-Sender: <xms:akdpZs_5tCvg2EPPXB-nTInE0Q-CreYgtQzOPVkcGCYOCqv4TU2SLw>
    <xme:akdpZktzSEldL3aczt0Q9YlpuWVkqM_J4m243b57vK3HunYxfdF-dZZVmk4_95mtc
    VjFjtempSpc0C1jBw>
X-ME-Received: <xmr:akdpZiDR8pXQOTusoQILP7zKDZtXqQKvWh392rFmOb_FJogfQAgVLArqkS2CBLP7njwBrM6Pe--Dhks2bq7u6_1V1xHHuLJ8tHgMgU0Yte6D-F3TI28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:akdpZsc2qc7O8i3LqwFqKpSBNRkxiXkoOPMcY4Pw1INN4z5SUxQGQA>
    <xmx:akdpZhPh-lIMbrupNxGvtjN3gHE6LmQQYoG3BNrFEwaHSEw-UPWJcQ>
    <xmx:akdpZmmDczPmuel5UyUrvrHN4NWXaGDDAIA24hpCjEfes-NprAG02w>
    <xmx:akdpZjvbqFVJyishyB_zC9urJl44wpa3gHHuqnov0hEAGA7JG0JfSg>
    <xmx:a0dpZiqNV3vpkOO-KqEguATJIUNbnqxZuvQeiroYuNkaWbADtVCnIthh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 02:59:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5bd7cf64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 06:59:41 +0000 (UTC)
Date: Wed, 12 Jun 2024 08:59:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/5] t-reftable-tree: improve the test for infix_walk()
Message-ID: <ZmlHZXN8_7rKLTYk@tanuki>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
 <20240612055031.3607-1-chandrapratap3519@gmail.com>
 <20240612055031.3607-6-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eU6P+Sfo+cHLeW/Y"
Content-Disposition: inline
In-Reply-To: <20240612055031.3607-6-chandrapratap3519@gmail.com>


--eU6P+Sfo+cHLeW/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:08:14AM +0530, Chandra Pratap wrote:
> In the current testing setup for infix_walk(), the following
> properties of an infix traversal of a tree remain untested:
> - every node of the tree must be visited
> - every node must be visited exactly only

s/only/once

> and only the property 'traversal in increasing order' is tested.

Nit: this reads a bit awkward. How about "In fact, we only verify that
the traversal happens in increasing order."

> @@ -51,6 +50,7 @@ static void test_infix_walk(void)
>  {
>  	struct tree_node *root =3D NULL;
>  	void *values[11] =3D { 0 };
> +	void *out[20] =3D { 0 };

=46rom the test below it looks like we only expect 11 values to be added
to `out`. Why does this array have length 20?

We could of course also use something like `ALLOC_GROW()` to grow the
array dynamically. But that'd likely be overkill.

>  	struct curry c =3D { 0 };
>  	size_t i =3D 1;
> =20
> @@ -59,7 +59,11 @@ static void test_infix_walk(void)
>  		i =3D (i * 7) % 11;
>  	} while (i !=3D 1);
> =20
> -	infix_walk(root, &check_increasing, &c);
> +	c.arr =3D (void **) &out;

We can initialize this variable directly when declaring `c`:

    struct curry c =3D {
        .arr =3D &out;
    };

Also, is the cast necessary? This is the only site where we use `struct
curry` if I'm not mistaken, so I'd expect that the type of `arr` should
match our expectations.

> +	infix_walk(root, &store, &c);
> +	for (i =3D 1; i < ARRAY_SIZE(values); i++)
> +		check_pointer_eq(values + i, out[i - 1]);

Let's also verify that `c.len` matches the expected number of nodes
visited.

Patrick

> +	check(!out[i]);
>  	tree_free(root);
>  }

--eU6P+Sfo+cHLeW/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpR2QACgkQVbJhu7ck
PpSLMw/+NkJQongjlzUJ1mUPiIUVsqbhjvC5IRlxvmcIOeRqo+rEdc7WdWU19vi7
yYyHLzSstJSreWVmbBiWWwCUXRBLrfAGY6w8r/BeIHmP/NtBSejG5/iZMd5Prrh7
7fQxj6ilUaRjUNXmKNpckhVeZh/Dyb9/mnKHnu9kRXX1sy84JKFTorxgAZi4Tms4
YoHMd/SpOyxzk+8ayEcw1SjBps81wAsK229ba1mBrPhVA51RDt1d7HH69MpSnpLQ
aLtCuhPuO82pvjyaYY2X4LNkanm21wxEKmzyEvFCYr48+Y5L7hHjgq1acm5563p3
e3is4M4huInig1gYAt/Eob5zxQh9ejGVoTBjFGovVcd0dRPpf2oBDxdIhNoSlBGv
az7iJamT26WkmAU4AdsBUIsrQfDhPLKpqS9O/KpPr6/17Z8vFi9p2fd2piZ0OvaZ
ylQ2rw3P+X8ThvCGp03Brq9BIIHpOH2gXIV350xopgJ27IWADCq02lMBsO7pgoJl
rxz9oRqWfV8nMYDd3NnjlQXX3SOKwcPZfd7N556gSNKlKJyD64+jmaGvbzPjgk1H
X26LS+FFDcoIIa/B564ykk7tL8G+Ly00IqiiVNOi4tr9NH00KmeDU/K48u0TC80j
TGa4TvhDjCMgh9qwoKSxx5C6aa5HDukrJS9AIZk73n3aTIU7f1Y=
=bZxY
-----END PGP SIGNATURE-----

--eU6P+Sfo+cHLeW/Y--
