Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879674E03
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707202308; cv=none; b=MBrkvUO+FaFdFfK/CFvHZZbJSEHiHvsGqtXSIN/+PeiuR5+hDq8qaTBweNNap+f7FMWZ41xgFdTgwmALiKocBVvYoAu7ecBrU2Ocag0t9aHREImKHV4flFeMCDY5RNv6ehQOss9TgO6my6/vcZyAzNwhRWuIWIdifc52K2qiGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707202308; c=relaxed/simple;
	bh=OZad+BQQPLKl3TElFLkJoq/ZVM9pn6GaxI2e7Jw/9Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u60q/bObGmx8NJ61ym0f1dhdsBPgyEaoqE6P22ckLgXanV0CmmUjeQI74j2untA1U1xGWEpQa35fCgbj5L1oIpP4h8Z+b9PbnGemG995pK2HVqkKGVc/8mCTPeHSq57ZmfNWsoJlJJSddcd6t1IF3WRGbv0IIZB+Hn2gkTyeBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nyvrQeCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YTBMO7zV; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nyvrQeCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YTBMO7zV"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4AB043200A51;
	Tue,  6 Feb 2024 01:51:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 01:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707202304; x=1707288704; bh=8mlvdJxv6e
	HgWeLkAdGM96/OdVVi1zfkqAhieXwE2bk=; b=nyvrQeCC13QncdSPRtcvnSk2UI
	wAfSq0MD6j61yeJK2mdoCKnM52o2o8nFnT60pcIf+yQWNfdZ5DzztMGaIuKz+Bpg
	0FPJQPxOVY8CTzWIRHtU8pwozEGGFHc2W4o04RTxIDvtT+Fdf7IN47UfMxjrDbB5
	+OYGlcXocFgUvl0+vFJQ9BbPKoQtFQPMTyXez9kFb7GuiWAB6udOhFFE821e9xF0
	ofdzilj8yiitRSivmftzO8Xu0LJsE7fg4NanHfjJ0uXnUXRX5T/rWBU71MQGeXwD
	+x46mndfEhOC3jD9oWfMbSXWunUhD7Xj4OtC8HCL+lxL53y8xV11A3TS0cSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707202304; x=1707288704; bh=8mlvdJxv6eHgWeLkAdGM96/OdVVi
	1zfkqAhieXwE2bk=; b=YTBMO7zVDTWz7zV1/kjFZDmOBEohqAuEHFYq4IWk3rOV
	ntXLfsMjAUMNwWTa8HCcjOuAE24Sez6EaYfQ29sUys9NGEOZw82k8HBSVWopb8UU
	ERaom+Arw/ZMXZnki1s8QlTZA1Q2K+wyAObcLGqBoKrLVDVk0kXing84h1hUFUh2
	vkEdIIIzcn1Hfq2HIUi+fm04je4z24UBPpCL8hl9GOCW18kzon9CDVxeDhEqC9wY
	bpOixQOnfdJwn8Osd1DdJvS7mikEg6OnqLpJv1zHtvy/jbmpzkGc9wYW7pnI/zL7
	5PR/xp/iriYzZqj+DQWvNcu4C7ov0OMELzQJ86p71A==
X-ME-Sender: <xms:ANfBZe_2kwKyhrZSvUG9UIIVrCssZBdTw7dhCWO2EBg7MCEb3VpoLQ>
    <xme:ANfBZev5JDc-0AKT3-_wb7dTobfLG6RtFf5UEaDp46f1_ndnaauaC7RlOOhWukGmt
    TOtg9ZDUxXd6UhEhg>
X-ME-Received: <xmr:ANfBZUDjS9kZTHbfgesc6dCyM1W6fQgiIj4iI34zyO4Cc6-jUheBmmmSmFLF6iEjSUtjmft_BZDZAG830zntHpnYtrdUgGls-VNwUp-HB-fQmJgS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ANfBZWeuXvd23U_2ePnCydkeutxTLC0A4WXZ42x48OxOQVgCAKHaSQ>
    <xmx:ANfBZTOQOLk0cTNws_QxaxOJcNzZWgHxqVFYY2AsqvXz947O7AuzWQ>
    <xmx:ANfBZQnUjVhJxcdPMeh7b61nFYIOcuCayENY3QXGLfRJ_gQabGEP3g>
    <xmx:ANfBZcZQBEOZRxsIIWYWc06e5X_epUsp9X1vgv8n_eJqkUlwVqCnRA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:51:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d76a50d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:48:13 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:51:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Always check the return value of
 `repo_read_object_file()`
Message-ID: <ZcHW_bc6N5umk2G4@tanuki>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pHGabHdFWVtrBeBy"
Content-Disposition: inline
In-Reply-To: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>


--pHGabHdFWVtrBeBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 02:35:53PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
[snip]
> diff --git a/rerere.c b/rerere.c
> index ca7e77ba68c..13c94ded037 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -973,6 +973,9 @@ static int handle_cache(struct index_state *istate,
>  			mmfile[i].ptr = repo_read_object_file(the_repository,
>  							      &ce->oid, &type,
>  							      &size);
> +			if (!mmfile[i].ptr)
> +				die(_("unable to read %s"),
> +				    oid_to_hex(&ce->oid));
>  			mmfile[i].size = size;
>  		}
>  	}

A few lines below this we check whether `mmfile[i].ptr` is `NULL` and
replace it with the empty string if so. So this patch here is basically
a change in behaviour where we now die instead of falling back to the
empty value.

I'm not familiar enough with the code to say whether the old behaviour
is intended or not -- it certainly feels somewhat weird to me. But it
did leave me wondering and could maybe use some explanation.

Patrick

--pHGabHdFWVtrBeBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB1vwACgkQVbJhu7ck
PpTb4g//Sgxbh5+CC4mKxYA303w0VEcGwqDtBCjKo4zNC6MZ4gx7Wcu3mlInUjSJ
I9I4DIk0N/1KAfb8rX3y2bUbmxRrKBHSeedWLeLtXcCz9LgVWElqLqAyHopuLLgf
M4ljIPRGuleZWlbB/ZLPVggJ2fvfg95OlATNk2UT6vo/O/h3ewt7UbsdvXTqPJEw
2vqeRkiWSzclI8aaE9SRkoIuN3JjNSIltae3IAmiZTeOt+LkL2VIq5sq6001i1mO
PbFD5sy0lqQMRerVagxPPzogjK1QsJRzrF5MPodBPSWK+UUSobhWpUe1VPkYVZhD
CK5raw6xrA/ozq3BochAj6QNWI1jW3cFU4fa23EJQ4mlrTHIQq6efZJTYRXlvSbt
r7YBao23DiRHlgsbwm/E+W1tW2nV1k1R36Af2BSoaljSrvz6QtkELYzLRGvIARwU
z7vNiPYr5aNYcj0cYQg4iEJPAYlEGWl82JQ2iH9uHdhHQDBtiEu/399j9FmTafjd
ygZHjIsxbu3Yn+sK0i33BuklXQ0trcKIlJuDr7LEJKfTu9IiNwENAuaAwNwMTcV4
5wH3/ddUb2iR5ZyZX8aOMP3rfp/0QLtcJjkqmMwTQfV18YO7hi0HWOfJUq0lsoAM
sSq5yDIN7EH32Ykx89ue/kRT+amOHVX68RdJaRhq5RhaesopeQ8=
=fuLi
-----END PGP SIGNATURE-----

--pHGabHdFWVtrBeBy--
