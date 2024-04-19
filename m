Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BD42AAF
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519627; cv=none; b=MemFvEMreMObuW58xMJLfeLk0YXT6dYD72dFioe7WFqL7hXgDLSkHelFA7wwMaj1nD1YldDuJ06TS1LPdxf35+ykJQmWurQd0vRFFPaCpH+4jMvrjuCgWRedrGcTxQDxTEREK4/pAQPWkdfzF5IlN9w6AYoVLR4Wl7+K+09ACoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519627; c=relaxed/simple;
	bh=F+W09lQ8f3CBJk5RJ01fCd0oID3qqnDDNNLPraGQa9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxw9jlrLI5EJXtXvMcqK3wA6wuRDA0eX5EegcTkbGzTtYTKujkurcHbF3+vr9J3xEt+4AqIrsdSYligZejhTr3MVuZ9gTJcg/WRY0e6RZVCiR3hJBJZeXuacB1Ngho85n0ZnDniHqZh758pwoQtrQlxAxShFYpGBlxBcxrkSsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MkOKtbCm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FuLBS6qz; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MkOKtbCm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FuLBS6qz"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 910821800107;
	Fri, 19 Apr 2024 05:40:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Apr 2024 05:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713519624; x=1713606024; bh=A8w1jSHzIF
	93Yw6aq5SvODPIFbAuyXaE7IaWEROE060=; b=MkOKtbCmvteZRT7Qv31NbOH8P2
	6uJezVrmz19VTWPn0eXfR4fPf5tfTz8YdipxQMdtVzQrsjfZS+wmG2dHuN+w+n2h
	lBBXnmna+6SxrxSc7lXw+MCn1iBmJX15FpespyV1pKiky/rDIxOZmIikxyP3CXBW
	mNGQaSY4hsuXRL1OqhIDVn8z41TvLJMh4kyt3rzqKUx6cVCK0WOmBMfk2jNvMHqZ
	cempisfYhd0b6y/eXJsh1qifpKK3SB1e7YJ463Jyc+f2hCZMJZ9lhRVBePpkKkBI
	xbLQfw+oAsE9eKjVSyd32R/VoxG8KP7yzV1VbFIwsxpDtuwW7ISIKO3oMG+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713519624; x=1713606024; bh=A8w1jSHzIF93Yw6aq5SvODPIFbAu
	yXaE7IaWEROE060=; b=FuLBS6qzvbRFjFE9AC7b2JDvtPMMpKH82vzHThPyBB+K
	ZNp8v/ek44VNQnmqRWLRRgyENcAtxcTsk9F7S0xnV6uGipuplTtB+oEvw6sZNhuS
	jdK0zJ1D7otNzxQ5W+hD9rwbvA9yD/5ZUx97ag/thnpjVOzkwWRyby3sXuObybr/
	bdiHo5vvU5l5JcmTD0b9doXR9uEnp0m20kcYynPHASXMv1xPfoZ4GnW50JkG/TU4
	vdSz+R51locYYfTk+l1y3GXwvPMTc9hM5gjCq+BdjhW8xYXq086LGIcZYHZcn5Ao
	A2VAxJcXIIOy1fSF+087AYEvoqCt6/+hISqPv24ZuQ==
X-ME-Sender: <xms:BzwiZpy5g2DwXuoZ1g1sCQc43LsoBy-kWcTFXgAC-OgdfDZwko0pdA>
    <xme:BzwiZpRLnhyP53mAHzuELhadgtgGmWM8UKbGgY8XrRbFwMdHLZRm3vN3zkWpTS-vL
    27X_VmqBTWOsUDbIA>
X-ME-Received: <xmr:BzwiZjV-HWNRumY_t6RMgixlHile8jBpgzdGICPt3dPDNLPBauEF2VcF0Jvl3G0tWP3Pluc4G6RM_3mBR256JgSzLcsgrDoU7e9sowYhW_e2xJy9gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:BzwiZrjGsUaMsIOAa0DXdbLKaq4pNiHdU4UcibDDYZOXZBQ3SEMTkQ>
    <xmx:BzwiZrCwHtDemWecp58WIHu-6FnytNWyYVWY71vzU35H_okEhXHOaQ>
    <xmx:BzwiZkL39TIJXhoDO-cXEac1mUcO1hK1vZZIl0GQHkYgjR-kaiLIIw>
    <xmx:BzwiZqAkVU4Gul0qDsEVNQg1r1Ii-ZUM-3Wu5YEhYYKFEIPKhUo2sA>
    <xmx:CDwiZm-nyvpf_3T1UfrZjlgrm254X2TlCTPDjX0udiO7mmdziKnv2jE3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 05:40:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d54ecfa4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 09:39:52 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:40:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
Message-ID: <ZiI8AfkJL4O3K7Xk@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jOhOTtMIrQ/0OAeQ"
Content-Disposition: inline
In-Reply-To: <20240412095908.1134387-2-knayak@gitlab.com>


--jOhOTtMIrQ/0OAeQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59:02AM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The `ref_transaction[_add]_update` functions obtain ref information and
> flags to create a `ref_update` and add it to the transaction at hand.
>=20
> To extend symref support in transactions, we need to also accept the
> old and new ref values and process it. In this commit, let's add the
> required paramaters to the function and modify all call sites.
>=20
> The two paramaters added are `new_ref` and `old_ref`. The `new_ref` is

Would `new_target` and `old_target` be easier to understand? `new_ref`
and `old_ref` to me sound as if they might also apply to the ref itself,
for example when doing a rename.

[snip]
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 56641aa57a..4c5fe02687 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -124,6 +124,19 @@ struct ref_update {
>  	 */
>  	struct object_id old_oid;
> =20
> +	/*
> +	 * If (flags & REF_SYMREF_UPDATE), set the reference to this
> +	 * value (or delete it, if `new_ref` is an empty string).
> +	 */
> +	const char *new_ref;
> +
> +	/*
> +	 * If (type & REF_SYMREF_UPDATE), check that the reference
> +	 * previously had this value (or didn't previously exist,
> +	 * if `old_ref` is an empty string).
> +	 */
> +	const char *old_ref;

I think one important bit of information here would be how to handle the
update from a plain ref to a symref or vice versa. Would I set both
`REF_SYMREF_UPDATE` and `REF_HAVE_NEW`/`REF_HAVE_OLD`?

Patrick

--jOhOTtMIrQ/0OAeQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPAAACgkQVbJhu7ck
PpQAzxAAjoafZQaM4hh3v52emXfgSbAxfkk8ePEH/co95aerP1Dw1Gp3cr/cO0zc
szgJsJHV1eGbNMKa2kRPMtWG+91YKiDnScYghz7wYryOFsqI2HUXnCpxGapqPXK3
y0IZHqaJJJK7S2it/4f8K/IC69kB6dnIPJ5wwVD1dqjNQWRbVRD6XmxQjc6VDesX
r2XV7Eg2UudCDK+m1ygU8G3l3GVkwVr8CGO/PBGm5Vreqsn2SGiOLBEBUgpDc1py
XenAyQ2Tsc85SqVQLInXX88lTqCixJal6DB1JWAHO6nt/kV/sB+urf4ao+pCkWi0
fdSxV8F2G8YYF01jWFk+vX7c/4IxA4tFAEWf5uUbnx+1hMHuZHvl+OMiCmoKUlKG
iEZwyanOCRUF39en8pKFtn0kAQX//ur0Pdb8Gq4O8SU+G37aXF/+IbpTsglmLUd/
DCPxXWGGqY750WDXrlwriRbl9iEdVcg7vOmziFP/DBrJnFdSfHoaGbfwN3TXb6JZ
/Toou2FgWiOyfhxWmNPzEOv57ktiOBfaUZP+x2eH4HYPK0h3v6Q5pi2NRMEOadRF
AEri6DeiXT+Pv+Irmh2eMtfYcsf5d3ejYWuspjCwSoIxsttOvavQMsYJCjerJMzB
Nh2p/vSfvruBr1U8tVAeTeV87ckAXsw2HMmyKl+Jyzdok9+G7y4=
=l8/U
-----END PGP SIGNATURE-----

--jOhOTtMIrQ/0OAeQ--
