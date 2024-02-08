Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C869DE4
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379056; cv=none; b=bgxt+4bPyJ9tCbzoR2E/ebDQJ2C45+8EHUENCmwF8x/JpyDgnu5s80njVeK0FxKUJ9Ui7835S7voN6odJYUhyp3SIlokbAbFUqKupduEEKXdqocFYMTo9dWQQQXeOQbGcCRqD98owAGqPWE5pkzFYQTMFIYNv8SMrbET7N9CE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379056; c=relaxed/simple;
	bh=p+htWYrlx4ElOU2tJogmYwRwxydEj1ZHVvrDGINsKiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3qAHTlyUpQlwjmoJrPamU5iiXdY5WSHUghhkfO/g+fyNiYhlSdES08JNWtsDh1u8EG+/MmcJqVASufeBSePfItumU9XqQpgd8h5YuBZgBrRcU3kqLr0TCNglJHNyhyNMD34GUnQYtnPehIXWXTwmUhL5Migm0lq334qGsqTyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jo+obKma; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OpcAMbT2; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jo+obKma";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OpcAMbT2"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6F292180007C;
	Thu,  8 Feb 2024 02:57:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 08 Feb 2024 02:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707379052; x=1707465452; bh=ymT5TB3SXn
	xDtKOBYN7HJUK66zIINmifhFIoxyDcj4g=; b=Jo+obKmaNdzcPAg5aZqvf6tS9a
	WboKL2uo/9irzP9JiZd1Uf5NeTWeEGUZe9dziU+wfca6Fx+caiCYCjA+YIwWcOgb
	UaWWsVEeg3K/Xj0rI0ynbcxa7ntdEIbUzW19nJHLycV0PSr7WZleO2wRma3paaH3
	mqviCw6qFNDM9jq41V0Zcw1yjyIsrJrSfvU12GYF20Leuexshz6+FRI1nl3ldvj1
	0+TGmcvsk2EYIXnME/3AGa/RknUf2k7q5OMdqbwFSpY7zTls+CaPlOpXvAn/DxSw
	/oaY59Gw6acgDvw4NdXMmgMFqbSBcQndW5Ckv2Rwt4SPfuZjhWzmsfPh7nFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707379052; x=1707465452; bh=ymT5TB3SXnxDtKOBYN7HJUK66zII
	NmifhFIoxyDcj4g=; b=OpcAMbT2tRapP25M8sfFOKK9mKug9hw87JW76hm9C9nR
	xAKUb+DCxXB2j/Au8pJ1+D9owWnMD1I8OI0U+KJYpMNfPrAI8bVa14cBVdizWkIF
	Carq2KPzg0dI2DXX12/mKWEtEwCPbvWqDzUFE0qPsxich30d+ixkl1ywbzlAtWRC
	ug4QHD3fo7Xq5kV4ZcWToG9zsFjfOUTgbd9Uhn6QF1kSzPmF6TD0sVI40ChXvkQC
	HNRMZpGLtpWFGfQC9/d/gqLK37nh75O9cZBkrihu02LdR76Zm3+fgh3bcXA64vfH
	GPVtWCPgf1crq8fp0YI3soFC98yDEhIkgTk4IbVJIA==
X-ME-Sender: <xms:bInEZbxNcWzfZaej9BhV8cMmhtuWtDIFKm8658SZXQqA7HSHSO-M8Q>
    <xme:bInEZTQdW_FtxSShFKpPOznKxS7OSWUb_Vx5mg8E5LwnDrLjg2hXQMi5Lpv01jR_h
    b3R_jQY__dy1UHu6g>
X-ME-Received: <xmr:bInEZVV_WJsqFdBnt9-MIVbyLgXDOiEEmfBXwHUgRFvJZBidGYuomPMngHSuG-Eg_mhKevr-M2KAaQNGTTkBpXeNmMeUh5FSKGW0FIKs75nbLRnt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bInEZVgBVASyHsKbTFjPtpX8BeXddbwQyaEgMsZ2GXH-EPScDXbYbg>
    <xmx:bInEZdBmXRqI0603QlpLqGE9omSJdJUQDBGmH-Hk07k6eD0UaHfaaQ>
    <xmx:bInEZeJCyszlRYmsVMFsyP7O4JQO558Q0cnbt1hfF9BzSuTR2W8P2w>
    <xmx:bInEZQN-wDEyeKpEmSONv65zkdsmInSJarbmMamqw9qF9MEQMZ0nKqct2PY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 02:57:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cf1cd9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 07:53:57 +0000 (UTC)
Date: Thu, 8 Feb 2024 08:57:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] completion: don't complete revs when
 --no-format-patch
Message-ID: <ZcSJaRczdHApmnVi@tanuki>
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
 <20240109010830.458775-1-britton.kerin@gmail.com>
 <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4YU01qYLrGqMnQaK"
Content-Disposition: inline
In-Reply-To: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


--4YU01qYLrGqMnQaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:08:30PM -0900, Britton Leo Kerin wrote:
> In this case the user has specifically said they don't want send-email
> to run format-patch so revs aren't valid argument completions (and it's
> likely revs and dirs do have some same names or prefixes as in
> Documentation/MyFirstContribution.txt 'psuh').
>=20
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 185b47d802..c983f3b2ab 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1242,10 +1242,12 @@ __git_find_last_on_cmdline ()
>  	while test $# -gt 1; do
>  		case "$1" in
>  		--show-idx)	show_idx=3Dy ;;
> +		--)		shift && break ;;
>  		*)		return 1 ;;
>  		esac
>  		shift
>  	done
> +	[ $# -eq 1 ] || return 1   # return 1 if we got wrong # of non-opts
>  	local wordlist=3D"$1"
> =20
>  	while [ $c -gt "$__git_cmd_idx" ]; do
> @@ -2429,7 +2431,9 @@ _git_send_email ()
>  		return
>  		;;
>  	esac
> -	__git_complete_revlist
> +	if [ "$(__git_find_last_on_cmdline -- "--format-patch --no-format-patch=
")" !=3D "--no-format-patch" ]; then
> +		__git_complete_revlist
> +	fi
>  }

While this second hunk here makes perfect sense to me, there is no
explanation why we need to change `__git_find_last_on_cmdline ()`. It's
already used with "--guess --no-guess" in another place, so I would
think that it ought to work alright for this usecase, too. Or is it that
the existing callsite of this function is buggy, too? If so, we should
likely fix that in a separate patch together with a test.

Also, adding a test for git-send-email that exercises this new behaviour
would be very much welcome, too.

Patrick

--4YU01qYLrGqMnQaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEiWgACgkQVbJhu7ck
PpTZew//WyWv58gjEeeA1CHX3K49Y3JEVIxisf30iUV5I74R+AjwoDe06nsru9vj
0p1wCQuQ4ooNOza5FNw2UtLPDENgDBLxjgdsjvGrtvsKStzkdy/xKtp81YZxmKWs
fil47aIu1qBAT5rLESpNBWXOwJ1Htxxgdi5xIqHiBgXjMwQ27Lu5lL0ezhy6eYoh
K7/5cw2HUlPXNPowMtXSVHn8NjvwWuFZQCoOMIgHMn2l/t/SY/cWs8/vHWuDKJWt
yPts3cpatj/hSA12ChgwTxhrth5Itopv6ehJrkBBKN8pYZkBjG1d4x56UKgWrHhG
j4bSgv8Vsb1T87DgLQrUKnmeCJTX4Jw/EJhBuR1D3l3xCIjMptIqw96ltetW3iPD
14wayELkWuzD7AJo648pavZKjtbyyNJIyOtmZfsjH+A9GvTo8QNL09f3sZHPnbmJ
6qMvyFYyNSO3NsY9rNDSrHoB4jzxWTYts/j1iasqbJO/B6wc8bXJBDf7wrxmMg82
UZvbc6x1d5wW84k9FMcSarERxQ7OpRDP6iaisA1fZmDwNRaC1i1R/KwQjhSdRGFV
rVy/6o6OVanTLIT/DX0CQCmttCgwBdoLOukPSWspkyOlkdl5yakClu9+I3ICEq5B
gsjASFvWVzllCWQ0ja89kvg+QNrjSNSNQq/E0uYbHBJdeT6tHtY=
=BM92
-----END PGP SIGNATURE-----

--4YU01qYLrGqMnQaK--
