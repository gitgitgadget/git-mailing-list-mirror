Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFC45944
	for <git@vger.kernel.org>; Mon,  6 May 2024 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974341; cv=none; b=EpER212VbMJGZS7Nap+fMEbMWc3IInxBPS3NMrbCyg9Bw8kx9yZ4IwIB2waL/iJhPm48hrmaMvIYIN/gIrzBlnkImw9/ITIjECQhhGLu38PslmPnsJ4x7J+z+12c/1hJwEDfVmsK0hvH2Y+hukaQW6fxFQAH3mQyQoytu5ON+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974341; c=relaxed/simple;
	bh=Y7huqqCrZXk2XTQU+SIfUFv52DVhUwkQAVVBQ/Z9CFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxGuXJ50VvtpyoI+P2d/fOI35HKjkDSRMyFTGBHKXvKcPKjXJi8zoVhd3rat3Mxp1A8FyJjmAdVgXTtDpWtjMAciV8y9p9aZ0aIWNWOUJTJbWI/JLGRmpvVJ0efb/IKrOtuHaIAE2OIZPIRdSxJRHl0MOVdfobzZCgIeTKo1zws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RduSlyS1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOtVcXEp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RduSlyS1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOtVcXEp"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 04B2A138027E;
	Mon,  6 May 2024 01:45:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 May 2024 01:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714974338; x=1715060738; bh=L6Xns062a0
	TGIrfIT4FN4NTeCKT+H+XgSWm7boAex8E=; b=RduSlyS1dQhIsz/5/v3GD6u1PE
	Y3EWvlHaXKUA0H9nFQr0en9QuhcreCXcuVBhIwv8qphmeC0JkAl1Ainu6HGfaXz0
	mNgW2Gqka247E3OiJYkFRI+4GFM9qPO4VJ1ZR/XUeHxWemt1p0ilE5jwl0X8+Zkp
	XAHfNppXfnFWC+gfuImsJtbkQUAP5dP5g3T+XbGqmssiDdSHkNGBmIYbJHAYonbt
	Aaz6LdMkgLapxXNR8DiC/tgGRtu0PMid8M7lFrWZTw46lJNCa3hY9ih7AsztNIkd
	glY5uKKjnbHRrPbZYzb/HmMb49m3Ky3y17cBXxAgUIJdYdrCqdMpWNvIsJ5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714974338; x=1715060738; bh=L6Xns062a0TGIrfIT4FN4NTeCKT+
	H+XgSWm7boAex8E=; b=cOtVcXEpTEOo6zkBtfpDDtiy4T4tl8yeXjPnMciNOUXD
	R4OaJlf9O3PvX2fOGMQdYjohNYrvJTc5PA9+49/Osc7HA+5lr82ikYrezTqC1PLG
	bi807TgzIRuTNcoNTQ//K7fHmPYid8pYxSLrFRC4H2H5Gi1sVNMjyIAQtQdUhnYx
	7A41Gm4Lx2Ru2hyf732ewo7i1j+o5mLMu0SANDt1EnZkNa87HRMo5PpsPtVSR7wU
	ZWhQ+ZMWiBtf0cHH+MqDVLyES4Y6/arBGt2vpmvnYGhzNf45cTrP/RtgevVph+dB
	xFqCRU19S9AU1ZLd4A2jqdSTw6LZMh9gS3iBo8tvCw==
X-ME-Sender: <xms:gm44ZoBYjsfxNTstqgNcK3uicwi3obkIBFDUVZ0HqrCzY4TiyN2MKg>
    <xme:gm44ZqjKFLnBq52cBQuKlbf6MZ6AH3l_Vl-02hlvCVc-ADcpzx1breKO77f6NWXkN
    mhzPH45S0mhoroxCw>
X-ME-Received: <xmr:gm44ZrmRLfbTVIdwNEVJE55suA_ZrX5JQSJhCtAH2Fl7OvOpEMa8_hbesVg3yqORzndOO5U020hKAPy0pRrZH7Mf6mkw-J2WibpdOzOmliNIqDSu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:gm44ZuytwsvVumuuV5hPcEctJMJ-KQDKrFm2-EePP6eaS1hdD7BrvA>
    <xmx:gm44ZtTZ-eNdWXswW1dkzw2m_n5EX0y6iljkfCpwW-Dp3ifUPundDA>
    <xmx:gm44ZpbTbLN4R475gvAQXrbbPY7BSQu51DapC7Vak5QpG0dd4NfOBg>
    <xmx:gm44ZmRsVMCEZ0wBFw0p0J_em_rClH1oT4xAGc7n8Z6qGAKBJxyJzw>
    <xmx:gm44ZvfVx1wqQUgsZhv3aNQflUNeNkfHlEo_WWstMZaI0pzGRKD5D8_a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 01:45:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a254ade5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 05:45:31 +0000 (UTC)
Date: Mon, 6 May 2024 07:45:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] scalar: avoid segfault in reconfigure --all
Message-ID: <Zjhufiq2DmBlVpIx@tanuki>
References: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>
 <pull.1724.v2.git.1714874298859.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C04xUQgmk6qNHa3g"
Content-Disposition: inline
In-Reply-To: <pull.1724.v2.git.1714874298859.gitgitgadget@gmail.com>


--C04xUQgmk6qNHa3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2024 at 01:58:18AM +0000, Derrick Stolee via GitGitGadget w=
rote:
> From: Derrick Stolee <stolee@gmail.com>
>=20
> During the latest v2.45.0 update, 'scalar reconfigure --all' started to
> segfault on my machine. Breaking it down via the debugger, it was
> faulting on a NULL reference to the_hash_algo, which is a macro pointing
> to the_repository->hash_algo.
>=20
> This NULL reference appears to be due to the way the loop is abusing the
> the_repository pointer, pointing it to a local repository struct after
> discovering that the current directory is a valid Git repository. This
> repo-swapping bit was in the original implementation from 4582676075
> (scalar: teach 'reconfigure' to optionally handle all registered
> enlistments, 2021-12-03), but only recently started segfaulting while
> trying to parse the HEAD reference. This also only happens on the
> _second_ repository in the list, so does not reproduce if there is only
> one registered repo.

I think this explanation could use an update now that we have figured
out the root cause likely being a detached HEAD, where `get_oid_hex()`
will then access a NULL pointer.

> My first inclination was to try to refactor cmd_reconfigure() to execute
> 'git for-each-repo' instead of this loop. In addition to the difficulty
> of executing 'scalar reconfigure' within 'git for-each-repo', it would
> be difficult to perform the clean-up logic for non-existent repos if we
> relied on that child process.
>=20
> Instead, I chose to move the temporary repo to be within the loop and
> reinstate the_repository to its old value after we are done performing
> logic on the current array item.
>=20
> Add tests to t9210-scalar.sh to test 'scalar reconfigure --all' with
> multiple registered repos. There are two different ways that the old
> use of the_repository could trigger bugs. These issues are being solved
> independently to be more careful about the_repository being
> uninitialized, but the change in this patch around the use of
> the_repository is still a good safety precaution.
>=20
> Co-authored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>     scalar: avoid segfault in reconfigure --all
>    =20
>     Update 'scalar reconfigure --all' to be more careful with the_reposit=
ory
>     pointer, avoiding sudden halts in some scenarios.
>    =20
>     ---------------------------------------------------------------------=
---
>    =20
>     I noticed this while validating the v2.45.0 release (specifically the
>     microsoft/git fork, but this applies to the core project).
>    =20
>     Thanks, Patrick, for digging in and finding the critical reasons why
>     this issue can happen. I've included Patrick's test cases and given h=
im
>     co-authorship. I forged his sign-off, so could you please ACK that
>     sign-off, Patrick?
>    =20
>     -Stolee

Other than the above nit regarding the root cause analysis this patch
looks good to me, and I'm fine with the forged SOB. Thanks!

Patrick

--C04xUQgmk6qNHa3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4bn0ACgkQVbJhu7ck
PpTvyQ//cu0lxBUZT0tAW55yxwCLtNCyqnK59qm3rJq4AkwSys5K+nbLI5oHMDJp
J2iXtqRVscFj+26qHLJJ+GP22cNzInFhuLpYgfVJFri73ICBOgcytWop9srhqtfR
47IBJur/UlhkVYvzJhJqwcmxO/3q4u8fFXERIKgAPvq6Gd45BVjLExkt2uNjezcP
akOllnmLfiY4dI1gx5S71NyQuWfBmVlEOY0MgeReAuTqH5mKiBTmBgiY07+Rgy2H
hbpJfOXrVDhud2KGMaOHr3kaioIq9rUBdBv7R/1qNX7QZGeZLb2vKRH5nGSY8yiL
E/JfKgEkIhLcBm0Yi2jAuwcMf+dZNeVYUCEISIIWqUVOrCq/lF/cBAac4RrOY4F4
49mkwzXttV1TRPU1YoH3qSPWRKi0KwyCfifgWF84j3z6NbvypPFTNnMqLFkHKwFY
LC3a7KLDECt7u0mSkhciyq8C5ckuj5xtFYNxfCQZ/LDADlgb7kIQrTtEypPB0P3l
XUytgzb46EPI+tETpKZBdHCqm6x2pynAcvn52wtBG0919l3S8HP4UScp0j8ETMSS
Ul8drHvk3/Hkv4qw1Ou5cOq1Ta/KQIBd8bt1e9OmvuO5Axnnfa3ZsW+Wc8xWI50R
c6hqsCUfjmM1b27PtY2UYmO5y9fk3Ao8uAlgXwJoM25KQ1qALZg=
=nnXl
-----END PGP SIGNATURE-----

--C04xUQgmk6qNHa3g--
