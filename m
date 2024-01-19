Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C16186F
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647893; cv=none; b=GjLQp7/wa0N5yu3/SAJt00BwFnXDSxwuaqVDUfke3a21mol+/vKX49MYh7RAcfpLe/0auKwvcy89PPE9+Lsqi0IKJFga+8REXpQ6rXm2VPrMFC1aWVolwPRigGjz+qj5pzZ1CI8wEAUCSu3RZrIEH4M7J1WnlppduhqNLO77Yj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647893; c=relaxed/simple;
	bh=7OvRuVFaIfhqZ9nhrlwjJf5T/5EJ/XeDeIvhdwuda84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyF6ZDic+qCI1TaNpXyBlYwct1n8NSqMLuQ4HxfJkyMtxxLhnNiluf+TxRyvRPa+taT5Pv9MFw/xGZ/lhmGnkMsDnXtJIXJ1uC7f6Faf6ZJeIxdl4xoAePq4y/+u7LyObh4b4/NQ2h2uVHMJPOpXrHU41d1TcPGhgeT4uvhV+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N3PwUeWh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wHokMcqb; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N3PwUeWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wHokMcqb"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 3EAFA3200A10;
	Fri, 19 Jan 2024 02:04:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Jan 2024 02:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705647889; x=1705734289; bh=ByIb2JXOvm
	iuSn3fcHnuVOG1pqqc+eiSe+SEC6Fup2w=; b=N3PwUeWhINTzonlW6iKwp5TdOU
	BaeW95ZRrtBFVAeOM5bitPyXC0K1OdPQ6OfsitCVF+yYNqsamda4jwMYOs8n7qbX
	ohZxi2vwmdQ6yLD56mrO3TsFMY6L3aClcK+tmz8A9mSaBCQMYmE/0WZXLb+xU+oC
	OISKS2X9F2L8EmTpK41d/3yTXXGZuXUc8gTG1ugTulIHnLqcgyNAI8VafHvwuVkK
	lPWzNvgQxVYcztFre3e2XnMWZfVIggbMzlaGVdK70WHqOWYcF83KsQj6HkkDZ8rh
	cvXkXDN6jY8BYAsm4Hh2pTUoXYBn94MUywKvBXvgYrlvsgBJV/kCmvEfZy6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705647889; x=1705734289; bh=ByIb2JXOvmiuSn3fcHnuVOG1pqqc
	+eiSe+SEC6Fup2w=; b=wHokMcqbtfFXafqoer5+//4RoF3+BbaEFW3cFrIh9W4j
	Vbov0m4t+/pxEsB/RPYf6amulDsGzkFyMBouc+TAiEzVJWBpry/VSgzFgq0JiAUe
	t9bDfUYxw/bVioNJmzWVnnkQcs2guf7++4wnFD+YTVUj3jAEpYoNkeMx7Wxey0Wf
	czOc6uHu9DwN1hAgwx1t8MC8NTfV/rsHh/JaNUzT+BaafqSuX8EvR7XIS3xHlGtm
	JLhkx2odNadJhf+IPx7hheL1mln4B0H9X8wHmazqHylHsejHhPXuxt0iBYa3I4B8
	ZNky7DANm5oJo44ESeWsmnmAfMi42AFJt6XT5FO04w==
X-ME-Sender: <xms:ER-qZaQaJNrjZ_ulLXDHOWYsLWB5sqg7yKnSDqm6S1VQDjKJAOKgJQ>
    <xme:ER-qZfzLdGBHnmYCqbJal_zxcnjXqTdqTst8eUqTkagpLcEhYeK-aTnxxXP-RjgFC
    nLQoKlMvw9f_AhTEw>
X-ME-Received: <xmr:ER-qZX2ar4zFb__p71ube9dfVw0hskHqd99wD-RxHybz_4mZxuPbLJG5efJ1u9cUQq1zEw2zsOr6sp7MdldPV4MkfyDIS5xJUOiepNGDXCxCM8Qd4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ER-qZWCBsMEk1aWmrS-6GucHOQ4UMlRzDBXkt8IZfPp0Op6Oiry2EA>
    <xmx:ER-qZTgaJ81je5s9g4xSBjOAmYF1BavZQHpZ81Q4ORvoI7trccTGcQ>
    <xmx:ER-qZSoWu7d8ddjSwCVjdZjaYVwGMfCahmi6wEQK4s2IVn6_PqQPDw>
    <xmx:ER-qZbZYUgbf4bTo1dzQ2btmw2dHNfbv4lZOXwweX-WyWz09Z3pYpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 02:04:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93b1605a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 07:01:50 +0000 (UTC)
Date: Fri, 19 Jan 2024 08:04:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/5] completion: complete new old actions, start opts
Message-ID: <ZaofDZIwMkmII174@tanuki>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240118204323.1113859-2-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JzSTmjaldDd0/4Hh"
Content-Disposition: inline
In-Reply-To: <20240118204323.1113859-2-britton.kerin@gmail.com>


--JzSTmjaldDd0/4Hh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:43:19AM -0900, Britton Leo Kerin wrote:

I feel like the commit message can be improved. First, you don't mention
that you're adding completion for git-bisect(1), which one needs to
infer from the patch. Second, the message is missing an explanation what
is wrong about the current code and how you're fixing it.

> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 185b47d802..15d22ff7d9 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1449,7 +1449,7 @@ _git_bisect ()
>  {
>  	__git_has_doubledash && return
> =20
> -	local subcommands=3D"start bad good skip reset visualize replay log run"
> +	local subcommands=3D"start bad new good old terms skip reset visualize =
replay log run help"

I'd propose to move the addition of subcommands into one or more
additional commits. "bad", "old" and "help" all already work perfectly
fine, so these can easily go into a single commit. But I think that it
would make sense to introduce "terms" in a standalone commit and then
extend the below case statement to handle its argumens "--term-good" and
"--term-bad".

>  	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
>  	if [ -z "$subcommand" ]; then
>  		__git_find_repo_path
> @@ -1462,7 +1462,20 @@ _git_bisect ()
>  	fi
> =20
>  	case "$subcommand" in
> -	bad|good|reset|skip|start)
> +	start)
> +		case "$cur" in
> +		--*)
> +			__gitcomp "--term-new --term-bad --term-old --term-good --first-paren=
t --no-checkout"
> +			return
> +			;;
> +		*)
> +			;;

If you also called `__git_complete_refs here` then you could merge the
two case statements for "$subcommand". It's a bit of duplicate code, but
I think the end result would be easier to read.

Patrick

> +		esac
> +		;;
> +	esac
> +
> +	case "$subcommand" in
> +	bad|new|good|old|reset|skip|start)
>  		__git_complete_refs
>  		;;
>  	*)
> --=20
> 2.43.0
>=20

--JzSTmjaldDd0/4Hh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqHwwACgkQVbJhu7ck
PpTK7A//b+LNhbkKg4vFi6lBsGTw5NtLp03gyszCugEXyrfhKwWmzWHt5ehLO2Al
Rwu9hSGr/F0zCWdpG6U672Ru8tlUbd+pNg2PJMEK+CMMAdK9sMV+MmJnNVANPjAj
LgYk5sWbW5ITmh1LPCelLcPkL+cOfD2S7/Ld7q058IW3zIGezG2NMEYGgMpFW1DU
zEoNcvevWcTGhIwZBT/lwVY+Mp0atZWASUO0Tw/0dQ4ACSN2oKhPOLrvrM+wEbQA
9qr5mj1NRMY74xDysZZIBY6kPrhLEmHwK2FhTwkbIA5Rn90/0tBG4MqN+X4uaYKL
kY3USBbsQvKouavvDLRDlj+ayHHn5pxE9EB+icsX62iPcLnJdPEFcTfpAK2R0pg2
kodrYZcXK+zQlPJqYV8WDJfbfUK86PpSjLJO6HtnQKL4QMm4N1qOae/Uu2OzRNn0
3IQsrjCYuSjzfPLn3bFPspWQB4MWbIRQpUvApW75IsSoltY1OClAyv9YNLB3kJ/h
2Nk0dK0vCX75N+ESwUloUWVuC1Ua88/4DI+cAjXfHHCrz7h61/xyN86Yqm4htrRt
ApttbR3O29ailORTg+/1r+3emrf/XyUhPO0UweAQiN4ndA+VbnHg4pJKZqUFC9/B
2cXIOOEA5f9Cp0mi7ckAatfAjdaFRleSNR0QWiGNkK3k8raMJrg=
=yMG2
-----END PGP SIGNATURE-----

--JzSTmjaldDd0/4Hh--
