Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A16D536
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647910; cv=none; b=jS0Rfr/SwpGYDb7XBDywmeba8UJVyyWr0FkV7It97G2ldQoeGwnUT8eHBSx6/nuaBTKblz/USHQ8uDPljf+p7INeRjrAlfC8jHrRfOPmY+c/lZz7VNriRR9F5kJzRtYIL2ZfbPfRuZddHHSyV/qFkQxsaPrSGciP0RTuwT+xk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647910; c=relaxed/simple;
	bh=ho/rwiAPeheJBzEKuwrBzAP3VuMksvy9JBo4ONX9YxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejsAcNt5AVOa5WJUyv2N3/ttPDFeLDXigF3NdFbEwuTSvJvY0r0zXCJJyBuUoAgbpZvk+FcvOCfB8X19cRdCSq79Wodic5H6TM7m97kkbA+jRQ2KuOf+xgoqJUiHqWzs/kwksLHiz8m4do62rHwRdrwNW2aFzdlqEUoPPwxW6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fKCzgNMz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DkQIDjLb; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fKCzgNMz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DkQIDjLb"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 2F2E23200A5B;
	Fri, 19 Jan 2024 02:05:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Jan 2024 02:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705647907; x=1705734307; bh=JLnnA2tzin
	SEC823V4bUN9mP2FnvZmxZz/d3UmsDFww=; b=fKCzgNMzb8cP7pLT4xKUJc0Fc4
	g6THNG+f7vprV+/U0lsm2sH0J+mQuaELCzmGzBGOb0imepfJ5xWvbY22KJZ+3O5m
	UI6I1tCcjW71V0tVUXiwa5ao02AkkfTxrn37zGGisNHAEipD5ZU6/EXbR+MBCkOw
	nnhNcmxHXDLz3nUmOMYe0vNS9SFKsGgIFTI8NZXtbw/T7zZPodTig1waWrF6zCe3
	4rjNFzT4qYrEwt81XBlC9fa0FkcNPQesVnqjtCT2z1YbD3dXuEA6rjXz5/Cr68C3
	VV+5KoX60klDoms8OKTbUy/pb3jgnUK7/ZRZuOLZeSbmNHychTvgTqYJ4lkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705647907; x=1705734307; bh=JLnnA2tzinSEC823V4bUN9mP2Fnv
	ZmxZz/d3UmsDFww=; b=DkQIDjLb9Q8PlkO4Zz8rmXAgeh34jhoBsjfTl3zu3QPq
	z0GZ2YhN8sfUrX7v1GqryWQxgTcIxuDmAN7nXd90WzqGvajOypWTNHdf4P4hk3CB
	O+8bWMPMyICYf5Mm1DR8yxSzknE3pp8ceq5jMt4B+CAtytdPJ/53CK0J+f+6W9eV
	2KOsxmFAX5FN1NtSmdJl4AZ9Irvh6BKeKenxhaAXEgQoYlAG22xbgM+phaTYouwD
	bL+XUPVKQQ6niBwM4GL3Oavuh25bJVbGyXSVjXxB6dFUP5FnkDYK3/9n3KF7q1WU
	+4dA0vZsL/1VMBTRMCOOkgXZFUfclIjAZndWyMwzJA==
X-ME-Sender: <xms:Ix-qZRulvhHZx1yzdth8HvwJ4FxYI3ln6ADLKPXuBNZVKPscytiv-A>
    <xme:Ix-qZaeqXL3WD9s0_23-yX2tG84GV1VuBoESzn3Tzm4QQil4v0O6s5JTHrlvkGEjI
    YY3xI9tAAc-M9xHlA>
X-ME-Received: <xmr:Ix-qZUwLG_29o8sRIpUDf-jV8VBZt5pBjLCPn7N9-yCX0r6bLcCUUuV4YM9fzyFIgkGAZVTybY0xYA_4Xtx1ZJjWNDnmxaZ3g_l_1-0L2sOKGw8GBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Ix-qZYODnaf1vPnXM8cD-RYM1jaZOGvfp0qzXAr8ruICp_-TPl2lVQ>
    <xmx:Ix-qZR91QPWUPGgteyfaYqhzrsrzxneg6j0AtQOnN6I-1m4BQNIMqw>
    <xmx:Ix-qZYVUJrFCV19xoNV5Dq5S3Wuul2hIN1X-TJvVrMj6y6KLxVgnbA>
    <xmx:Ix-qZTlcQuqfEteB3OSws5gQihlnb-TF-Vum7d-WMvQji0ryjdiHKw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 02:05:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd81cc97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 07:02:09 +0000 (UTC)
Date: Fri, 19 Jan 2024 08:05:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] completion: git-bisect view recognized but not
 completed
Message-ID: <ZaofIHEx9frnw5ig@tanuki>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240118204323.1113859-6-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UUYwvYVY2DPQG9BZ"
Content-Disposition: inline
In-Reply-To: <20240118204323.1113859-6-britton.kerin@gmail.com>


--UUYwvYVY2DPQG9BZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:43:23AM -0900, Britton Leo Kerin wrote:

The commit subject is a bit weird in that it does not contain any verb,
it only postulates what happens after the change you do here. How about
"completion: complete options for git-bisect view"? You can then explain
why we only complete options, but not the actual subcommand itself in
the commit message a bit more in depth.

> This allows the git-log options to be completed but avoids completion
> ambiguity between visualize and view.
>=20
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index ad80df6630..87cf7b2561 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1591,13 +1591,22 @@ _git_bisect ()
>  		term_good=3D`__git bisect terms --term-good`
>  	fi
> =20
> -	local subcommands=3D"start bad new $term_bad good old $term_good terms =
skip reset visualize replay log run help"
> +	# We will complete any custom terms, but still always complete the
> +	# more usual bad/new/good/old because git bisect gives a good error
> +	# message if these are given when not in use and that's better than
> +	# silent refusal to complete if the user is confused.

This part doesn't have a lot to do with the changes you're doing in this
commit. So it might've been better to add this explanation in the patch
where you introduced completion for "$term_good" and "$term_bad".

Patrick

> +	# We want to recognize 'view' but not complete it, because it overlaps
> +	# with 'visualize' too much and is just an alias for it.
> +	#
> +	local completable_subcommands=3D"start bad new $term_bad good old $term=
_good terms skip reset visualize replay log run help"
> +	local all_subcommands=3D"$completable_subcommands view"
> =20
> -	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> +	local subcommand=3D"$(__git_find_on_cmdline "$all_subcommands")"
> =20
>  	if [ -z "$subcommand" ]; then
>  		if [ -f "$__git_repo_path"/BISECT_START ]; then
> -			__gitcomp "$subcommands"
> +			__gitcomp "$completable_subcommands"
>  		else
>  			__gitcomp "replay start"
>  		fi
> @@ -1615,7 +1624,7 @@ _git_bisect ()
>  			;;
>  		esac
>  		;;
> -	visualize)
> +	visualize|view)
>  		case "$cur" in
>  		-*)
>  			__git_complete_log_opts
> --=20
> 2.43.0
>=20

--UUYwvYVY2DPQG9BZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqHx8ACgkQVbJhu7ck
PpQj1A/+IWRW+rDu8j1Hd9nVqATqT90y/OCcCv3OlIBARjhvtRiRCiktrZF3cc4k
Wmi88OxdEqeHIMZsgtQL/rZMohj5qewrbW43cHiyoRMDXSNov2qI8QOy5X8uO4tI
mISbmTvkhTnf5qLvRrhpHfVYDXguIQdsPwgGnh0Kp8+kuFK/tP0Pn81mJxVL9MPD
11BhGGdiC9VuhsVdLgciTzkJag9BSpuR1T51ica5vksfqVGtBpqCbESS3grAJjyt
eZ0hW9PJ2M0lYBK3WTiAjMr4ZHseVzjwM9PVGZyzJPvMbf7GRpZ6wsDgF5GgUl4E
/yFn+icv5O3OJ+pwtdsnP+mX/HW31siD7sqnYk5SJdfaMr/XD9Sy6kG1qbsOl8Gy
DQuZ4YeBIRz0ybqTLa9WjVqib0NB5GCfwZGHCIEMs/+Iw4t48++wfFiY2e4gu3t4
ojYxeUw4LPtTXYqWDI1l2RhkBomNfTo5956vSRJCN3cGjc9jhqnRoQvV3qlfUB6i
+JGyrdlppcI9JjbtVNt1YphNI7dEofEqge6QMc9cGVTn5LTdKKXAf/ytOomrGUdx
Ss/JSx0nrmD6s2JSNtMNp6B+xEgOU8g9F7wkeKJCB8H9Gjxq+j1pTSP3dIwGHXyV
1U8/u9cVhH7KbWcaHz3N6RM0wE12mBqD3MZL+X2tnjlIUWmcCt0=
=0dBq
-----END PGP SIGNATURE-----

--UUYwvYVY2DPQG9BZ--
