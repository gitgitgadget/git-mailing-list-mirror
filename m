Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381869317
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378135; cv=none; b=bKgYlWkewB/QtIp/rTBS35nGtfmQiv8p0uX6qP4A+mA4/QW0Mq7l0vLvmN9XWmx2WR4wtwn+fvrCBSwctH96kDw6T3aIznq7Be2YNergj7T/EjNF8DL31j4dze0J+i/Fnc2jQCf1GbUxDJ1g0L5r6uIIMCMD7OGDBzBCnX25wHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378135; c=relaxed/simple;
	bh=rS2phSJVvghJwnEGNQhfOenq/VxYEDH1Lpl70BH2ECk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eM1MKL7PMRlllgkL6jkxQDgSwC/EQ6J32Mo4ouBHLA8poob/jbVYU3JHMUIyRzZKWItj4PYF/m+ZtXH8bq/ybT5revehTZCnpu9eaU2DvarSd8Is2cmpXkDiFssnqVfqlAyazyFzBYKF6y6JODufUGU6jM0kOAhWwyahhLaDZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b1SOTSCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vywgbdg/; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b1SOTSCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vywgbdg/"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 1B6D53200A7A;
	Thu,  8 Feb 2024 02:42:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 08 Feb 2024 02:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707378131; x=1707464531; bh=t0tEey2B3+
	7HH1Q8sGE7e341sHyaTYBoT0XGZ8gjBDE=; b=b1SOTSCwvg0fQHf7EVx9HTWwEb
	VJRkijSks0Fkx1kW0k1QIHtJNX+BQfxjXXfkCy8FOpmbGgt2a8lUWHTf05Dj3WwE
	6JU18W8YkLAMpzrAAdnBcoYThr3l/mQraHOkGUF5+PGbFFHQaADKToQtShTBcNty
	RfJxlvyOfm0YSe1sIeUA8CIjnzPT5tjFQMqJVlgJyhbNgtLa8wuTAI6Q0m12unmN
	RPUV9P7yFR4Ojzy42DtWJB1H2IqvFc1klOA3e8mdVfa0cuewN4eo0xnSlAlQkpVh
	pZcuP4janqV85jrdUQiJhXinlHJiFShmMREvWkdOdk2Su1NecWjAVaU96Q6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707378131; x=1707464531; bh=t0tEey2B3+7HH1Q8sGE7e341sHya
	TYBoT0XGZ8gjBDE=; b=vywgbdg/XOj+6NT9Fhxq+H0bDxPbGQ4INN+rR17QhYt3
	igsq5L6E33OBkMZXjpnNyq6Y/0kSOykyJxuCL+iiKSdy1RDJLA1Ej6T19K0Vi7/y
	DukbPYmItrQbl6vG4R5PBDsTkh+q5UAZIn7s/spYi2eNbWe+yrvZymRKyaAwCXJg
	6GZpxDjG3Feh2ZTlciIWqXzNZPh/wfAgYMFuUgftzjh/vndM8YNeKjUIn4I5JSG6
	OXYk6Y/tRWleRiLvbHzsnpi9HdU+j3QeQuMb2Y1PtHtVymhdNKECJx2tm6QIm1AV
	bY0TSjmF6zX3snrlnFjidRLj9n2UTp7nKHardn/JwQ==
X-ME-Sender: <xms:04XEZcFWuOtCTm7Cfi7DFd8RuaUZ-f1aeVQc-nMUIvuHRvlYzjd2gA>
    <xme:04XEZVVyUJtXMakxDvw7Vn-xu4kjC0uGTpDVEOs1DGSjWOOk1-vjImYzoCUaxvJWm
    0pmhfaYO0tapI4-QQ>
X-ME-Received: <xmr:04XEZWJktXuQ2kgo1dwkUWVpM4u2M0g2JFpGLL-FkLM6fFU6aaUelxo1CZGIqmgJY3YZ6We-fFksjx7Gqv1-GhUY7nZnJAoyIkjX6Cvf0eii_RCd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:04XEZeE1p2_gh53Kh0DPWC1NM4oPPm6FUT1FEqABlZB3_vgKfJkjdg>
    <xmx:04XEZSXbScrCS2CRnJ9INuEWzszSHBI_-EuVzUQhH89n5KrU9nLbHQ>
    <xmx:04XEZRMpWBmzcHzuUHy0ueelx-T5lxVknpYIrGbLuQtZdYMDbtsqXw>
    <xmx:04XEZfhHxVZR-wliiuBud-_-2zwIfx51-C7wN8u9pjOB-fdplfpkPw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 02:42:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94aeb809 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 07:38:37 +0000 (UTC)
Date: Thu, 8 Feb 2024 08:42:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 2/5] completion: complete 'submodule.*' config
 variables
Message-ID: <ZcSF0Uw0xxlJXRlH@tanuki>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <426374ff9b3820512f73ef094f9533e6a1ea5cad.1706534882.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HicYOLTCCO/rGr/5"
Content-Disposition: inline
In-Reply-To: <426374ff9b3820512f73ef094f9533e6a1ea5cad.1706534882.git.gitgitgadget@gmail.com>


--HicYOLTCCO/rGr/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 01:27:58PM +0000, Philippe Blain via GitGitGadget w=
rote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>=20
> In the Bash completion script, function
> __git_complete_config_variable_name completes config variables and has
> special logic to deal with config variables involving user-defined
> names, like branch.<name>.* and remote.<name>.*.
>=20
> This special logic is missing for submodule-related config variables.
> Add the appropriate branches to the case statement, making use of the
> in-tree '.gitmodules' to list relevant submodules.
>=20
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 159a4fd8add..8af9bc3f4e1 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2803,6 +2803,19 @@ __git_complete_config_variable_name ()
>  		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
>  		return
>  		;;
> +	submodule.*.*)
> +		local pfx=3D"${cur_%.*}."
> +		cur_=3D"${cur_##*.}"
> +		__gitcomp "url update branch fetchRecurseSubmodules ignore active" "$p=
fx" "$cur_" "$sfx"
> +		return
> +		;;
> +	submodule.*)
> +		local pfx=3D"${cur_%.*}."
> +		cur_=3D"${cur_#*.}"
> +		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.g=
itmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" =
"$cur_" "."
> +		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalter=
nateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
> +		return
> +		;;

Hm, it feels quite awkward that we have to manually massage the
gitmodules config like this. But the closest tool I could find is
`git submodule status`, which would also end up describing commits in
each of the submodules and thus do needless work. And second, it prints
submodule paths and not submodule names, so it surfaces the wrong info
in the first place.

Ideally, we would create such a tool that makes the information more
accessible to us. But that certainly seems out of scope of this patch
series.

In any case though it would be nice to add some tests for these new
completions.

Patrick

>  	url.*.*)
>  		local pfx=3D"${cur_%.*}."
>  		cur_=3D"${cur_##*.}"
> --=20
> gitgitgadget
>=20
>=20

--HicYOLTCCO/rGr/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEhdAACgkQVbJhu7ck
PpSPhw//dXWAGo37t3xTBsI17sFORFROxg0QBMGq7kVj4ndXwKZyEODZ67fNZdpo
ZO2tXy7TCXaNwS15rPaBs/f5UmdAvb2SyLJx9754n08X9gGgFxVHJW0bFgzQRIrT
QdfGfpWlrqa0xPpLXZhSwnw+G17tOF0pg1wwNFnYHVIIAnZ+beLLOIMEqfRmFQJt
yvjXI1Peehd2/++uxHDGk6dtjcAFJTa+KmaVE7PorN0SR8nlkOJ6NKy77sCQgA1w
/xIXMLf23G/VNWNqsAhOu+SQWI9QJ12eLIT6/ogcmBPKYcWXUFXLlrlABiIYPU5g
QmQZ/TRHBXrUWhZfu+KHrp6GGdX6qcO+SOR4LJaF+XhpM1mQoY8b2qtV7SiFCCX1
cEOMOd8djMQsl4MwXcwx6rHfd54A+reBrOIBmBRGUjZmMvPidEhVxMYVHLLOC8GO
PSC7p2EZioW1B5zFdPGrosPhgPY8v7WinsRHHIOWwBxxVjKnK0+/D6aWgX4c9CPB
q5nC2q0SGBvUUyAseoMTQcNG5Ia9BUWgeFWprpT25GZVDfdVNY/0kjew84fSBUrd
eaq8W7DZhyE/EwJndebLqHUcbhRHW+2KmYt07T6RPiBWj8643rPtMTVJUkDwl1W9
ae3Ps/KxjsJO62TnXCBWBVbwQRSAZa52nqLEBqHLG0SchIjVuAY=
=bexC
-----END PGP SIGNATURE-----

--HicYOLTCCO/rGr/5--
