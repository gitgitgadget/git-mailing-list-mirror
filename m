Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44C620B27
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544719; cv=none; b=LyFvSGUgxHMtNRnE0R5MlKpabUJMqFL0FJZJkkr1PHw63+wnfpD2GjlaFAHPt2/HJFiF7lc6r89cZLmz/3BSHP+uS+bXSwRK5iMCsf9d6G7Ll8zsqCNE+EYpzQwsFJLhwAU+kdoDtFzJMrJGJ1I956AyQJkpTUGdz///HSf3GFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544719; c=relaxed/simple;
	bh=z84MC+j7xoufltCyQn4dN/fhqtC0r7mYvzRuXzWMOGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXplD8J3pel6oqpj9BoMm5j6+6FrWrlExZkfKqMypbPFwcpt06Bf4W+WWYtebff3BYq3Cs64ESa1R1/f1wwpzr42TDYsBQ8/9So72/oGhPccjot77xhWNKPUcbMKnzwgOuX+lgM19p41fVPCc797csf8/zWYBG0obx804ZeKOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V21Uri8Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeqVHc3q; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V21Uri8Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeqVHc3q"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id BED1C1C0007B;
	Mon,  4 Mar 2024 04:31:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 04:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709544715; x=1709631115; bh=a6KdT0j80P
	T9jQhXebsj8D8afGYITl5C3xQtEqh9VsQ=; b=V21Uri8YZILtyljTy9iWMdGm03
	KrmL93pVEQJeXSJeSWsGwR5GJ8ro4OAdRmYHYxhrCYflQ65E0+TzRSG62s/gVIEd
	PisgRYtuRUbAeVNciW89F0qFlXNlQFBRwoxkFVJ7raGhcMEEWmDN1aLEKtn++ojC
	AOspsvu571eHLs6fsOeIxgpKOsccAfp0asgzaq6uQzTVXSxnyFn8Nk05luwTNS9A
	FUW4xhtKwFj7RvOqKGwmCKOj+qqQSF5ApL/vKv+1y5PiwiDXI8cDzqTp3l0gmfJQ
	ckT7WGyRA72lVu6y15UksRztdxK6gYKlex3gKYeudydfto/dP+LCzFdbhxXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709544715; x=1709631115; bh=a6KdT0j80PT9jQhXebsj8D8afGYI
	Tl5C3xQtEqh9VsQ=; b=ZeqVHc3q4IvoBifQebaqrBJVXYcOuBHFvC+N0P4z2ya/
	87qWkRJx0+SbLJ67UyYCpA5dHH917c9YfGJC4XKBZlReeZRLNQB03WagYdR+X6V3
	UUp/tCv3333VIZ6jLvmYccZfEyo4JCzf1Oz9pBbZ1PMd15nr/pxBO39PKylsK3zZ
	t5CsSFWbLdAoV93pyIo0Gcav/sTLjdsUT7wwjyUWu5sRcSEXBDCnGt4A4lN/Z4Ds
	UVv8FN/cDnW3AwAwMviu9ewUmMKNZNRsp97j3+tyY3GdsEUCvulhvHfUjU+9EtmG
	nXy7uvp8UK3sJWSEE4fyYlzOh6VR5tj50fWunsxjNw==
X-ME-Sender: <xms:C5XlZU1ALa7cYWXYyniaicvpWpyhpkobzq_t7UjtAlwoShRm-YkYtg>
    <xme:C5XlZfGq-yWA7pIr7CEoXxmiRo8FvjBrP-wNfPRVNnJoeOn4v4MYaR3drzNeLGyAb
    PEUN5JuAxSSWRIm2Q>
X-ME-Received: <xmr:C5XlZc6mSNPGDpwOuyDqultXpsUyyvtJ9t5nkk2Z5xT6obremIJrASbZYgRDNIdz8ebShP_vwSS0YbUG-UzTzaK_dsVsdDWS_sBWkcN__vK-KCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:C5XlZd2Fl-pCLBWQHTAmBg-eYtVoAP_rPmgEQegi5Kz16U0VlqJ7Kw>
    <xmx:C5XlZXFRyE4SUAs33zkNSWmvX6AaYbOOwn5YiLYOk-TpyaG_OxK8TQ>
    <xmx:C5XlZW_PiBeIK9B_b5bGwFYewPPy08yZc1USUy82ea7_CcfwJiraaA>
    <xmx:C5XlZcS7h0MLNIO--elnKJF4DMPskyKxOHd7rx3AxSry51ZfmdI1KPrDdb8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 04:31:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 455015d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 09:27:28 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:31:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC][PATCH v2 1/1] t7301: use test_path_is_(missing|file)
Message-ID: <ZeWVB5uKLONfp6cO@tanuki>
References: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
 <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
 <20240227161734.52830-2-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="50hmUNwy62p0cYTO"
Content-Disposition: inline
In-Reply-To: <20240227161734.52830-2-vincenzo.mezzela@gmail.com>


--50hmUNwy62p0cYTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 05:17:34PM +0100, Vincenzo Mezzela wrote:
> Refactor test -(f|e) to utilize the corresponding helper functions from

Nit: you didn't convert any instances of `test -e`, so I'd simplify the
message to just say `test -f` here.

> test-lib-functions.sh. These functions perform indentical operations
> while enhancing debugging capabilities in case of test failures.
>  =20
> In the context of this file, 'test ! -f' is meant to check if the file
> has been correctly cleaned, thus its usage is replaced with
> 'test_path_is_missing' instead of '! test_path_is_file'.
> =20
>=20

Another nit: There should only be a single empty line between body and
trailer lines.

Other than that this patch looks good to me, thanks!

Patrick

> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
>  t/t7301-clean-interactive.sh | 490 +++++++++++++++++------------------
>  1 file changed, 245 insertions(+), 245 deletions()
>=20
> diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
> index d82a3210a1..4afe53c66a 100755
> --- a/t/t7301-clean-interactive.sh
> +++ b/t/t7301-clean-interactive.sh
> @@ -25,18 +25,18 @@ test_expect_success 'git clean -i (c: clean hotkey)' '
>  	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
>  	docs/manual.txt obj.o build/lib.so &&
>  	echo c | git clean -i &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test ! -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_missing src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -46,18 +46,18 @@ test_expect_success 'git clean -i (cl: clean prefix)'=
 '
>  	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
>  	docs/manual.txt obj.o build/lib.so &&
>  	echo cl | git clean -i &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test ! -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_missing src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -67,18 +67,18 @@ test_expect_success 'git clean -i (quit)' '
>  	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
>  	docs/manual.txt obj.o build/lib.so &&
>  	echo quit | git clean -i &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -88,18 +88,18 @@ test_expect_success 'git clean -i (Ctrl+D)' '
>  	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
>  	docs/manual.txt obj.o build/lib.so &&
>  	echo "\04" | git clean -i &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -110,18 +110,18 @@ test_expect_success 'git clean -id (filter all)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines f "*" "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -132,18 +132,18 @@ test_expect_success 'git clean -id (filter patterns=
)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines f "part3.* *.out" "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test ! -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test ! -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_missing docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_missing src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -154,18 +154,18 @@ test_expect_success 'git clean -id (filter patterns=
 2)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines f "* !*.out" "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -176,18 +176,18 @@ test_expect_success 'git clean -id (select - all)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines s "*" "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test ! -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_missing src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -198,18 +198,18 @@ test_expect_success 'git clean -id (select - none)'=
 '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines s "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -220,18 +220,18 @@ test_expect_success 'git clean -id (select - number=
)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines s 3 "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -242,18 +242,18 @@ test_expect_success 'git clean -id (select - number=
 2)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines s "2 3" 5 "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test ! -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_missing docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -264,18 +264,18 @@ test_expect_success 'git clean -id (select - number=
 3)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines s "3,4 5" "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -285,11 +285,11 @@ test_expect_success 'git clean -id (select - filena=
mes)' '
>  	touch a.out foo.txt bar.txt baz.txt &&
>  	test_write_lines s "a.out fo ba bar" "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test ! -f a.out &&
> -	test ! -f foo.txt &&
> -	test ! -f bar.txt &&
> -	test -f baz.txt &&
> +	test_path_is_file Makefile &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing foo.txt &&
> +	test_path_is_missing bar.txt &&
> +	test_path_is_file baz.txt &&
>  	rm baz.txt
> =20
>  '
> @@ -301,18 +301,18 @@ test_expect_success 'git clean -id (select - range)=
' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines s "1,3-4" 2 "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test ! -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_missing docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -323,18 +323,18 @@ test_expect_success 'git clean -id (select - range =
2)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines s "4- 1" "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test ! -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_missing src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -345,18 +345,18 @@ test_expect_success 'git clean -id (inverse select)=
' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines s "*" "-5- 1 -2" "" c |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -367,18 +367,18 @@ test_expect_success 'git clean -id (ask)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines a Y y no yes bad "" |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -389,18 +389,18 @@ test_expect_success 'git clean -id (ask - Ctrl+D)' '
>  	docs/manual.txt obj.o build/lib.so &&
>  	test_write_lines a Y no yes "\04" |
>  	git clean -id &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -412,18 +412,18 @@ test_expect_success 'git clean -id with prefix and =
path (filter)' '
>  	(cd build/ &&
>  	 test_write_lines f docs "*.h" "" c |
>  	 git clean -id ..) &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -435,18 +435,18 @@ test_expect_success 'git clean -id with prefix and =
path (select by name)' '
>  	(cd build/ &&
>  	 test_write_lines s ../docs/ ../src/part3.c ../src/part4.c "" c |
>  	 git clean -id ..) &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test ! -f docs/manual.txt &&
> -	test ! -f src/part3.c &&
> -	test -f src/part3.h &&
> -	test ! -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_missing docs/manual.txt &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file src/part3.h &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> @@ -458,18 +458,18 @@ test_expect_success 'git clean -id with prefix and =
path (ask)' '
>  	(cd build/ &&
>  	 test_write_lines a Y y no yes bad "" |
>  	 git clean -id ..) &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f docs/manual.txt &&
> -	test -f src/part3.c &&
> -	test ! -f src/part3.h &&
> -	test -f src/part4.c &&
> -	test -f src/part4.h &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing docs/manual.txt &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_missing src/part3.h &&
> +	test_path_is_file src/part4.c &&
> +	test_path_is_file src/part4.h &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
> =20
>  '
> =20
> --=20
> 2.34.1
>=20
>=20

--50hmUNwy62p0cYTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXllQYACgkQVbJhu7ck
PpS4kQ/+Mr1Fe92RIgt0aIxVwtUqiWpanbUmiH4g+/huzs/xG4qa3SleEcNyug1P
bFIk3jJyh/K/8O7ejLDx2Q88xs0KpxKaNecMp41EKWtJuY7tFELVmWKih4QouNwA
YxzqcVEKPuzjmqqkBjsE/41TK85IHFuvGiBlssIXLGUThL4XbZqFtStmlxsyVvtO
Viwa4kjkc1tCAGppgI389hJHxpEkB76BLLt7uu1TCpMCvO91T082MrU5DZ++bv8k
7wrx+QQimOq8iwmJ/1p4gC595W8MpbuheOgom/0e4Unbw7TOgcQuNlGtNYy/KmIE
V2XK2LxfyuhjtFEw/JFztQQuIGhP82xjrHH6eLjrpeqMpltMyCYOWPYhM6getAMo
z9wbpNVgLFwtc4y+DX8Q1uEB01NtAdCzxFC8HVsP38hkqeL+MomwHGPSKW3cyyYk
FEDe4mg7M9p7t5M/yDINOnuesG1dAx5GVusNKD7VO08NhnnnOPD/20p5WzGfg6hz
ieGdD75GG9lpZ+CujLxmAm3CZ8VU7F8NF/EFAcwp1SeNBD7tS0n5K9IhkpGIdmki
Vh38JJ/LiU07hMSGaUUn5krnPBrIAd52KCeUWpC1edfTHEe0dE+OmqciGB/+dkWz
6+e6gKecRWx6RiZeuAG6KBIJ/OqSJjFW8Ut9xB2vf45ofUrW+rY=
=JyIX
-----END PGP SIGNATURE-----

--50hmUNwy62p0cYTO--
