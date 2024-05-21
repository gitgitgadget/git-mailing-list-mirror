Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DA40879
	for <git@vger.kernel.org>; Tue, 21 May 2024 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716270274; cv=none; b=GCc8/gHD8uoIZXTyMqEmRpBwslVhi4awfdql+HBpC12vxrAy9D2BZ3FB+kVT2ecBjv6lc80x/0S3rtPTDeKvTzulMWaBWCGQI8u5HLQbTLF1HNwru7wdA3saOfrQIjwJ5O5gcjgwuFnudxhbjH+7LOH4xvhL7eeu/DUOZZccZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716270274; c=relaxed/simple;
	bh=80gwrHcVaAJyscjkamOz93EAqp85Nm0TigtzPS10bwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NysNZh8H/6rzqFPSLZQ4PSgUPJbH719OSTna9lAtcoBZjD3XXXjAOThZ1LYDL5IBGdDByH22jtwmKb3dli/XDRi87B9YvGdNHE3wZRCI+bwfaF1BBfVIU5lkK0fh6pYkKomJsAxPJCS5H5JTTU/HyLIS+ljsIQt7VGIPWJz1YMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Buuv5/yU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTYS9W2s; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Buuv5/yU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTYS9W2s"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id AD18B1C001A5;
	Tue, 21 May 2024 01:44:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 21 May 2024 01:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716270269; x=1716356669; bh=WXn/tago6Y
	m3YE+3e/VImho70VmpX6Yb+OsNqxOa3eo=; b=Buuv5/yUhAUUMLJruxhxu7TD0u
	0BlbIYLpwqIT8lmlmByH8UCZqYdsr7VMe9rKLF1YMlj960f/OqNnMNz9IbhLueJs
	AQMevm1CHN8PmpALB9aQjxtGfFxP4ctjwSOd80Xn8qf67AI1jxFYBTxuArbH9jbe
	5JK/3MOt5Za9Wh4dIreC+bqbsULelEMYjOdRDyE74SRV0NM1At82hKSaVzgJqnSZ
	xWMEc6oG1/gKAc6FbmuS8iCLnb4JB63r+pkWMGGht5vDO6Y8NJ7zRfwAB49ZGJK5
	c/BNYkH168lSB1NbGMwyHA8Dm9QwIjDsGy+CGjnLdaxCGAzI0lnZ1zyvrmQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716270269; x=1716356669; bh=WXn/tago6Ym3YE+3e/VImho70Vmp
	X6Yb+OsNqxOa3eo=; b=lTYS9W2srktWDApqmW8yyB78Xst19PrVITQq7JDDRfuU
	hsh0U8gCLtzTypg5noHpiGLuvY8bh0+Nn7+/T820udJmT4PU6EMWk64brwThkPUB
	4UDFdQ6leQAk6+3RsbH4LQrVGXkRr3vsYVsmVX0moVCcgL4P6Qxa++NIQwVMKHCk
	1EaD3DoNEK82Y96eaar+SUlPND/SJk6cwOr6FWspJq5tKfjEPTubzSxIQgp21vyw
	pVEr6zWUDCTphOW4V9sBLY2BNsQFWGgxbZsuKIPtsQo9z7DYeC3YpzxsbcMbzfAn
	OE6WGkB5aXOhyZIiYzXYNPp+hVrlAsi3bWEFXLfo8w==
X-ME-Sender: <xms:vTRMZiwM5QM67MGfbLrtL4j6qkKcdoBuQWfOnLUYtYVLnMUFR1VdvQ>
    <xme:vTRMZuTS-xkUPNtq4VlNVq1TNbTgo5DQAlDyGEwQGO64MP1oOuQ2Cy9Ggyelt458z
    3KMpA0SH7QWKPRKMg>
X-ME-Received: <xmr:vTRMZkX7QWluF8RCeIJWSuKvNnptsLjYe1aa5QS-upE-5FTGWNAkFa0Xb9f3BUIXkCMnmSgrpI69JMh5LsaEqW442QfjyIZPe0fePecyjFEjx-mj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:vTRMZohmV9dmwc6ECBZF8QLomsMg22KWBDE7WULrphkZG8G_I_GYtQ>
    <xmx:vTRMZkCc-Of5zd6bHCPAHpqaDjTtuuLZS2-q-MgEw2rkc0iICs6EXQ>
    <xmx:vTRMZpKjIi0DOXZKfgo1D6cbBcsvKgXJE-sNWW_sjrcdVmRUyt47Qw>
    <xmx:vTRMZrBi6i-4hhF5-zpLH9UAWEH9Ui1Neqmx_YyedwYvvNpPFnDXTw>
    <xmx:vTRMZnPxImLmd_8RtyutdNy2apHq3qoz8Lx1ALz_fwZk_fWxYbSYUk9T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 01:44:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 919e97af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 05:44:24 +0000 (UTC)
Date: Tue, 21 May 2024 07:44:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] Switch grep from non-portable BRE to portable ERE
Message-ID: <Zkw0ty8gOMS3Opzk@tanuki>
References: <ZkepnZhGEhSveN00@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z++hATqTO7JEYwSy"
Content-Disposition: inline
In-Reply-To: <ZkepnZhGEhSveN00@telcontar>


--Z++hATqTO7JEYwSy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 09:01:49PM +0200, Marcel Telka wrote:
> This makes the grep usage fully POSIX compliant.  The ability to

Nit: we typically don't say "This commit", of which "This" is another
version. Instead, we use imperative style as if instructing the code to
change. Also, we typically first explain what the problem is before we
say how we fix it.

I don't think this is worth a reroll though, it's only a hint for the
next patch you may be sending :)

> enable ERE features in BRE using backslash is a GNU extension.
>=20
> Signed-off-by: Marcel Telka <marcel@telka.sk>

It would have been nice if this thread was connected to the thread of
your first version so that it's easier to follow the discussion, e.g. by
using `--in-reply-to=3D` in git-send-email(1) or git-format-patch(1).

But other than that the changes look good to me, thanks!

Patrick

> ---
>  mergetools/vimdiff           | 2 +-
>  t/t1404-update-ref-errors.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 734d15a03b..f8ad6b35d4 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -325,7 +325,7 @@ gen_cmd () {
>  		fi
> =20
>  		# If this is a single window diff with all the buffers
> -		if ! echo "$tab" | grep ",\|/" >/dev/null
> +		if ! echo "$tab" | grep -E ",|/" >/dev/null
>  		then
>  			CMD=3D"$CMD | silent execute 'bufdo diffthis'"
>  		fi
> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> index 98e9158bd2..67ebd81a4c 100755
> --- a/t/t1404-update-ref-errors.sh
> +++ b/t/t1404-update-ref-errors.sh
> @@ -100,7 +100,7 @@ df_test() {
>  		printf "%s\n" "delete $delname" "create $addname $D"
>  	fi >commands &&
>  	test_must_fail git update-ref --stdin <commands 2>output.err &&
> -	grep "fatal:\( cannot lock ref $SQ$addname$SQ:\)\? $SQ$delref$SQ exists=
; cannot create $SQ$addref$SQ" output.err &&
> +	grep -E "fatal:( cannot lock ref $SQ$addname$SQ:)? $SQ$delref$SQ exists=
; cannot create $SQ$addref$SQ" output.err &&
>  	printf "%s\n" "$C $delref" >expected-refs &&
>  	git for-each-ref --format=3D"%(objectname) %(refname)" $prefix/r >actua=
l-refs &&
>  	test_cmp expected-refs actual-refs
>=20

--Z++hATqTO7JEYwSy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMNLIACgkQVbJhu7ck
PpReFA/+OIUNrJoTe3rPa4oxQyDxCtHyXqAjp6gczwo2xdacqThtKacVrpGYyXIw
R48L1jbewNOV9YyTSlLVzrqvE3+e4fkDCgW011Id8/XXWeJsGMVqU1+hc6ArtrIc
G8otTTnTnvlvhxkk2v9aN9Uf8Xs3kKb+EH+6EiDfk01u5xYrwNMKc5qXxoJtlW4+
+rnoxalKspO5402HHpZ+2OdRRTqNR6Z6zMdJivT5KTVg/y8bQSyI19vWESWmty1Y
uVqpNQUc2VPN3KHYesRb28UXjE3wMGBXEg25zjmpr3tnpLXv4lU8+Ir8M73/o+F2
FFJ85TPwM0Dfl1rjNSPfuZ8mtyPyZfGD1LMAV8R8eoXwAGrrt6kDfKpRcjNoCdDe
HRgqaXGujtfWPkrB/xTgNN4Kmk7qt6CMo397xlbYexvxd/gS6D9hnOninFYWMGix
FNmbCIosdN6DRhQ4pcgY8k1gNqyAl4wJf/tuz2I9mYF8dccszdNcZVljeoX+k3im
pabgPP1MjaiUZ6dh7hCs3trQHXfhb4IZKyaDZ620AHqvdAlck0pMS2KX+xOiaYbP
UEUrwaiijTe8p8sPJHZQhpFfd9gmLaK6p9fq2/5SyIdnZhQCC3PLTRIKz1YhIwDv
T0YiXUjIi2y0PXrj/QnNhDNOm11dK1FSV9XExKjHIyRw9Wgk5Gg=
=/IgD
-----END PGP SIGNATURE-----

--Z++hATqTO7JEYwSy--
