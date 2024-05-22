Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73BF2233A
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362626; cv=none; b=g/lIHWZTn22FisLqP3v7OeTRTnjxARA2Psf0j/oSKppC/OhP1ZWBHyyV78yG7xAO9kP77xvlae3bxSh33o3ieyKg3ZJGwjuo3r2p6vdQI3HZT7odny6TtnVje39OpRBwqhkiVvsbeWcDXdh7avURJ/WejNM0oYPaLuPz75HMQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362626; c=relaxed/simple;
	bh=azT414xNlWffB8nuUDIGIoRtb0ykwCWXepC9x3CYqiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/CP2xFu0BvrFUW35rUr2TE4IeKmInLV72FkEU50rBMvo4BNR5UmX5Dp8gHEnHJN9yDeJ1TzmF4k0I9isIg9C1q+ia4YUYYxdWQ83gw9zV1BJwliW4+NjDvPMJG/qsmKsf9s7OX2ucRg8s5+Uez90UEAgQKG88pxc4gLDEOaRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Exfs2hPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IV5MOTGv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Exfs2hPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IV5MOTGv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AED4913800FA;
	Wed, 22 May 2024 03:23:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 May 2024 03:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716362623; x=1716449023; bh=azT414xNlW
	ffB8nuUDIGIoRtb0ykwCWXepC9x3CYqiA=; b=Exfs2hPJgcVnGM5VRTkpZ4aKQp
	UE8h1nN7DHhqOvCUmssdRM3ygOh/ETmMXFAb8Qym3OVMFJGYgYtgLVkkJ4Bv41r+
	8xVaokxNcWw7H8OnokeNuOnE3cyTkKc1527lOqvcJw8Jqdxoteg+vfl0YpxdIdep
	+xD3JJwNKirz22Jf2SgBHMAKOYlbs6P4R5xRHS8YQ09cLpUiJSZXWFgEElHjyjsJ
	0OB8W4a3oMwkY7B4B5EIRgkqX0uT7ePC04UFQ8WtB3306jtde+eHnOv2fziv0CiG
	LdaU3s+6eeVKh6f3bOowPyzSQbopM9DCqD882Rmwk2qCH8zOYTiYCzxLWU6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716362623; x=1716449023; bh=azT414xNlWffB8nuUDIGIoRtb0yk
	wCWXepC9x3CYqiA=; b=IV5MOTGvBX9REYnSQOLdTyWKuoVaT7PEDHRFvrcRRU0B
	JoCuF8QCo9xmWamwh4VKVCcopi71vGBgqezsOzjlk8MiQxvKkBb0PnYfIYrOJYss
	y6ioNy0HxBKBmOGffNi5jItRE4mp8eDA2k2RznHDpByrAXcXV3l0sf8CaZso3zWP
	2bMCP0qOYV8Yg9n2PFI5CaYJPZS9+Tcl9db4EdabywyQw+UJM+L0HIW24IZ3jsQ3
	Sy224ah5aTnhinHBx1HMOQA7Ax6ZOaa9qJ2HoWIcYsO3cvk/SD2712FaR6Y+GFcj
	G9KQZKO5lE5HCtN1HJuedBqf2ne83vWrFMZfV8aPmg==
X-ME-Sender: <xms:f51NZgmL8LcuphDmbpklz-P3It3TuKWSEkPiwCj6-b9H-lz7vFNnzg>
    <xme:f51NZv1kl7D-KTlI2PAqwh3hlK-4P06G_DSI12otBAV8pwPuJYswcTkgb01y7k4Za
    wgFVVcPBU95YRG-XA>
X-ME-Received: <xmr:f51NZuqlzauzDMuklZewHIsRbluI3r4_ci0gh311vw7kUM567PWrZ9_OuNnTU4PFfLCQgOm-CW9y7R8GD6TC_Y4JHmWYY8xSK4IAXBPxiqtbwp73>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:f51NZslMOw6GHAoR4hiWXVNf_YciEG6xml2qFwK4CcTrhZc1G9o5aA>
    <xmx:f51NZu0LzKndGZf-2Z_bZQSrq8WxLojpTPRmV1mjUUFniVeYEFm-fw>
    <xmx:f51NZjue-qPXjUaeydoOYYix2D3QrpqVsdKte-edqHwzDaqilwbUbw>
    <xmx:f51NZqXy33bALcI3v6MTBmF3Np7Elp_HrZuKONH-LRJ4YR25NWvrVw>
    <xmx:f51NZhRRXUyyuz_bdKz38MorMnqIArO-5t2AuXwBN5X2qaKw0OQnVnTa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 03:23:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b2dead66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 07:23:39 +0000 (UTC)
Date: Wed, 22 May 2024 09:23:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 03/13] reftable/reader: unify indexed and linear
 seeking
Message-ID: <Zk2de9lNrNJRuwUp@tanuki>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
 <716863a580f9e1ef8ea796c25c97e50c63585a7b.1715589670.git.ps@pks.im>
 <CAOLa=ZSC4OF9b1STzEZfPjrJDbee04A-piNZ86kDS_GDij_3Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rAL7QZun0Ad7Gl89"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSC4OF9b1STzEZfPjrJDbee04A-piNZ86kDS_GDij_3Jw@mail.gmail.com>


--rAL7QZun0Ad7Gl89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 02:41:27PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In `reader_seek_internal()` we either end up doing an indexed seek when
> > there is one or a linear seek otherwise. These two code paths are
>=20
> Are we missing the subject here?

Hm. "one" refers back to "indexed" and is supposed to mean "index" here.
I agree that this is easy to misread though and may not even be proper
English.

It doesn't really feel worth it to rebase this series just for this
issue, but if I did it would be 's/one/an index/'. Let me know in case
you disagree though.

Patrick

--rAL7QZun0Ad7Gl89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNnXsACgkQVbJhu7ck
PpRocA//WnbfwcAOs4IfVfF3g8ZQkcvnjMsO62s9a1+u9YiSdOerm4izT1RQkUrz
L9VFkUXniZ8Mf+j2gIdRK0vsrZQsxlouXXm08ZYJbBIRRv7k9F6Fi/uBBhHdFBmq
FvcPbXOIRHXEXXOwZXghXeF8QYzRZp4fV5bBba8LK7q5wfDKZbHEX8J1vZYxDACo
XuSxrX4Emn3Qpz+pzKGNe1mQFjp/ovo46SSJKL1BxbdpAuxY0K/mmFQHrKI+gpku
V/XLO156LhzVKRf/ndkyCKZCAUcWOk48BEIeKX/g9ap+/vfw6KyIkKv3peqX8wrD
EWNUoKtFpEAg1Y5QSVcKwI6+esizZ+yfO5PagBZumn7CJBy+qusFvNYZjiEQ6Fua
RNREbvB3tSbgoSF8bNeDMXF11o7cJa3ETue/HQt4F0DtIN372E4Pu5tcG5BkdEWL
KV+BzAnIvssYaCp56k/sUo0eM1j27sCxYdB1/MbGWOc2rv8mgvRXoQpG8dlo7n/w
QlrydEdnDALeRCQEZpkoXJ+3NkoF0WBwWEpDFpBXuTNqnmLA1nvcVHxJzJwcadIc
CGuDr9YGLfJo+ibrjSPQersck4jDLldvTLL7B+0dx3LZgkAQAU4JpI15C45ECBuM
/JqlHM/R+YoV+PXsbjPf/oHs2Cn/s+EV9/bnfZnt7i4DamW4zwU=
=CFMZ
-----END PGP SIGNATURE-----

--rAL7QZun0Ad7Gl89--
