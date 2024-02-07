Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FF1CD21
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707283599; cv=none; b=tlbp69LKUQp94/IqKArw1991RzdeDsZx7/aIQhYZwWrO9Nb2m7ZvB2NlczKhSSBeVFJaRXdhhWu0Szivqo1/Tlya2XhLvWy9SoG1EsxxlCk8oQ67TrLM7Vb1p7xRQO4fPk5uyiGTWyL7GY0+Bir/PD4Wt1fNoak5Mo3OViGtu6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707283599; c=relaxed/simple;
	bh=kyQaSjQgBiRk5yKMBW+Rrm8CxUTEkm/aEmB9SDeYOyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgNwj+gUBRaPYeCaY0ZbDeG+vnV2OeDEV40VCPl1rbxC5GqYikS8jG4skdmvBaVASUbewGAXWlpsF8jfHvCuDWf8yoKPlwRRBXMtc1p/r1PTjXOkVBl5X+yJy/tuSn1uSbpyJ2cJb/0AAZ09P4CpzJIJl2OyNh4BKTNQq1XR8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k2dUqK+C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h7PnWOLi; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k2dUqK+C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7PnWOLi"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id D84D05C00D3;
	Wed,  7 Feb 2024 00:26:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Feb 2024 00:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707283594; x=1707369994; bh=oNPDOLrgf/
	+nx6edv/JIwMDThsUO8IuWn1ebSNE8BgI=; b=k2dUqK+CSmiXApz8T2F/NziBrS
	zmIGAwq61g3rbM6RmzLIj3SRqkUx0M6KmmHXtPzVtkl9fZb9/nyUR7gUNl+bK/rT
	V+q6JdPfiXyDI1Z5s232w7WVje+wyrHxjB22mCZnik9rIk9YCYGLOOeLZiG24AGj
	d/AER6zJiE7tR/qPq2l8/RaLJZsrrfmaBhhA7/brPXz/mV4m03NRLnvx/2FqMjDJ
	LVy8kg9gy89rO6PmH+xsGwlIMwj35EVYOIDa3cd6Eum2sgBB0isYFNDHG2uX2xdb
	ER/TLDwe0CCjUTwo3khcz7d3O499x45r0qCVejT4P5Z82n49xz4TGYUYt9+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707283594; x=1707369994; bh=oNPDOLrgf/+nx6edv/JIwMDThsUO
	8IuWn1ebSNE8BgI=; b=h7PnWOLidapYOJGDpfstoR8PyTzopPzjMGbBGTYXl0eO
	3fRxVdaGXIetPsJuOn26hiZ9km2K0larGq9tHoj746UK5s5PIi+z/3h7tWZuxbIv
	YDuDKmsYeIGL59q4fipi7G68A6VRA+M9xb4yhvPffdeS4b64cA256T9UF+MwqNZU
	GHDY0VSDkYt23+kE/VqZ5lswgU/gCy/Cm21uV0Dg73E0+/gBl6deyFvQbi5CM4kT
	JxKdgD8HCa/r+XNAwJRCpdOK9Dbtf553bITxG/xhQn9kMAj5qKDcUKxbqLxakOfg
	YEmAJHSLQk8ZWirvk0C5ScgR3KDhq++QosrGL0LEdQ==
X-ME-Sender: <xms:ihTDZc57m6Z5LLfPg524ckDuI7oMpsTv4Y0-397VPCdpmV7mwhP_Iw>
    <xme:ihTDZd7mTK_GUQOxeK_pXebfwMZMLj-dwCMbTGB4EE-jCxpnxUDAmygKI0lBex5K_
    v6i34KtAl_B1qPXRA>
X-ME-Received: <xmr:ihTDZbcYMgttpWmqyJ6hSGaqh0-f-9r4vnZ5_Mv5qoK2yHRjnIQnLEJTennNiaQC3cribjzxblHKE-OHKNqtrFXT5cqKFmheFYfPPucrdIXQlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ihTDZRJcIIbOlS_WYq9qmpiTx5hUoRPThLmPCVcoIKNbk_yKPWKSxg>
    <xmx:ihTDZQIkW-dpFMEbOheHvhmPDSMBdr69iVwd5q5nbbYXt5gpc2vX0g>
    <xmx:ihTDZSy95tK-ecGDE9YVjJbaCWQE3IJz5Z7l-VgNM73lqT8mxYd1MQ>
    <xmx:ihTDZXXvMZ1amxzadBg8MWs_DHbUbF2LUWwnWydBtxZg14KNz-a0vg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 00:26:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe8641f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 05:22:59 +0000 (UTC)
Date: Wed, 7 Feb 2024 06:26:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Britton Leo Kerin <britton.kerin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 0/7] completion: improvements for git-bisect
Message-ID: <ZcMUhO6nvml7PATy@tanuki>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206215048.488344-1-britton.kerin@gmail.com>
 <xmqq8r3xfbep.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xL+oeMrojW38MIO"
Content-Disposition: inline
In-Reply-To: <xmqq8r3xfbep.fsf@gitster.g>


--2xL+oeMrojW38MIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:58:06PM -0800, Junio C Hamano wrote:
> Britton Leo Kerin <britton.kerin@gmail.com> writes:
>=20
> > Relative to v5 this makes the following actual changes:
> >
> >   * Treat COMPREPLY as an array on assignment and test, rather than
> >     relying on the bash mechanism of implicitly acting on the first
> >     element of the array.
> >
> >   * Whitespace fixes.
> >
> > The commit message about __git_complete_log_opts has also been changed
> > to indicate that COMPREPLY is emptied and why, and a broken
> > Signed-off-by line fixed.
>=20
> Thanks.  Let's queue this version and mark it for 'next' by -rc0.

The range-diff looks good to me indeed, so I agree that this can be
queued. Thanks!

Patrick

--2xL+oeMrojW38MIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDFH8ACgkQVbJhu7ck
PpSAag/9EOf0ZHiDgkgAK0eIOfm9XZ21VirGY903wTXfU6Nmd8mrGMpmmEnxSxtN
jOWcmFfStCfaDufsO7s9zQRItASOCL9vyx3E86i6AfFfmKkdiK5fIMZ2FoDgZkn/
14KyBEFHblAtwEdyyLLST09fVqwxj/QP6c72lut+Gnym1OLeQloSy8KMb07ZUdXI
YV/gNSxlq6BYdxkgrVjsVM0KegqScZL0YGzqIsyVXZtIAIbBxrxSZUEzwTeSnRDO
yHp6vT6lLVxORQWFbfTrJPlJkOoVG1I52abgsTw04sNW/LLaXcn01MC8bwjHwFu/
Zwo4TWMzgu47aMir3fcDmRy0GmtLzlBf6SE2z9H/JyLUQfjpw3O8NNsxGKMB4qdE
f07+71Z2kIZPv4Bob12IEFWCgJ0IqxxF4LQXCY6IU34tfPTHOeZAHEVaLX1oSpft
446YMoReWk4kvTAFtZQjVuU1Owt1B9o7htjXo1lGC5pVhAYdI/wzbEhxIGvUoWs7
z8hNkKZionVFERCiqx0zlvI0FZYVpoOn1Od7mUH1ILeENNHH+s0cBtHlyTYP7Rja
X/RciqtNxf4ZxYCO0/pHl+fe176I+mUGmk0o59BYlp7EYuNlY7VOEmK4kYNKxvdz
hGUxCKCyv5Z6XW4jiVTmcv9Oc7bu6GRCJ5qZ7Qrb9R310LfyGUk=
=CnIJ
-----END PGP SIGNATURE-----

--2xL+oeMrojW38MIO--
