Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B62F7EFF
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938329; cv=none; b=kX3Ck1t6AuEj8JteKvyxHQFfX0pBCTyWIUQFoBQRJRD4HlE3+PeIcz3Fui+oiMbtwrOFsYRxZab4BCGwBp2tqXnmJ88W2EtSQR57nl4QExlkrNyvlBzKQqtiS1v9J1yW/umg6iQTJskfrgGY1MD2uQYcmorRIsgXOWfhPV6cvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938329; c=relaxed/simple;
	bh=R2km7RvGGvs+/QjeKjQ+LHO4G8pzwrX/vDNnh/1W3J0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j4iZWjJ0BHzU4AIR6bxY837HZ33d2qdNVtqL17wKM0ctqtfWFaBUk8J74krzDCbMPpWhwfMSedD+rDMwzSLXDxRRUBxV7M0dlXbNXMOwvTqdGKpHZxqa8wFdcockTGbloPwloCIOKSnz7LuHy0tdvbr9vl9EgJVoGrD0ci914bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=KuPi0v/r; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="KuPi0v/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785938324; x=1786543124;
	i=johannes.schindelin@gmx.de;
	bh=wGLajVlfWzKIH8DWTzX4ZyOJ7zg4EC/urpLAux6HGF4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KuPi0v/r0ZPwhFh+XaMHSnyGVBjnRqE3huLwQt2v+0wjWiyT4QWu5I2MTcPnGkP7
	 yWSLzLz+RgK3zLHPwobf2vspfMgCMqbKj9TImSWrwm5GXTZrej/rwD3KZfome35tR
	 lHJowqHAHQHkeCCKbYxIaSHIR5eQIyqmLnmoaTTbWhmOO3OlD4z/aL3lfgU10ih97
	 OgjzBYQCsLosm+B0ASGbvHBaOPdMQ8fhyQ5UF+BZfcdqesgJzZgGTNIXHuiicQ4V9
	 qbqNJ4WDZSz2eW1PgItTwhYadA/M/wGzKicRMCGFFqv6nLa4kaCkVzSsrjbIBTKYe
	 IVV5G1mciSiaJKvuQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1xCJmz29qX-0147NO; Wed, 05
 Aug 2026 15:58:44 +0200
Date: Wed, 5 Aug 2026 15:58:43 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 12/12] git-zlib: widen `git_deflate_bound()` to
 `size_t`
In-Reply-To: <anMBBW_arzuri4Qo@pks.im>
Message-ID: <7fe7ca44-f3c4-7e99-b7fe-81e8467e294e@gmx.de>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com> <ab911cf55647ed335042f5ac3a6490c36c3ef1d7.1783615780.git.gitgitgadget@gmail.com> <anMBBW_arzuri4Qo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:m7UksF0JqSIUgmZ+F/psuxiTFWt963USmGic51n695kQ4baISff
 oaXfjzOc60Ty4NPQuWzqw9R9ddTAdkOosXBgVRISwgTwfWSSRW027+z4IDpJ6LdOm9c6owp
 amlvdWBF9PubFDLkXfoxqsRvpfT3Aindylw2yxqOiZqfOKhcar7TfGtKKxbDRZo4Nj0+lQa
 DtKI5aIdVc8n82Zfze57A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OIh1IeS792s=;RdqoeeptAhNxPP92qAk3w0peSpJ
 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
 ipxIINe0a1w5DHwZ5oA=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 5 Aug 2026, Patrick Steinhardt wrote:

> On Thu, Jul 09, 2026 at 04:49:39PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > All four `unsigned long`/`int`/`ssize_t` receivers across archive-zip,
> > diff, http-push and t/helper/test-pack-deltas were widened to `size_t`
> > in the prior commits, and remote-curl and fast-import were already
> > there. With every caller prepared, both the parameter and the return
> > type can now move without introducing any silent narrowing.
>=20
> Nit, feel free to ignore: I feel like all of these patches could've been
> squashed into a single one, as they're trivial enough.

I like them trivial and small ;-)

> > For inputs above zlib's `uLong` range (i.e. >4 GiB on platforms where
> > `uLong` is 32-bit, notably 64-bit Windows), defer to zlib's stored-blo=
ck
> > formula (the same fallback it would itself use for an unknown stream
> > state) plus the worst-case wrapper overhead. The existing path through
> > `deflateBound()` is unchanged for inputs that fit.
>=20
> A link or something like that to the formula would've helped here, as
> I'm not familiar with this mechanism.

Right. I added two references to the commit message.

>=20
> > diff --git a/git-zlib.c b/git-zlib.c
> > index d21adb3bf5..ebbbcc6d1a 100644
> > --- a/git-zlib.c
> > +++ b/git-zlib.c
> > @@ -167,9 +167,21 @@ int git_inflate(git_zstream *strm, int flush)
> >  	return status;
> >  }
> > =20
> > -unsigned long git_deflate_bound(git_zstream *strm, unsigned long size=
)
> > +size_t git_deflate_bound(git_zstream *strm, size_t size)
> >  {
> > -	return deflateBound(&strm->z, size);
> > +#if SIZE_MAX > ULONG_MAX
> > +	if (size > maximum_unsigned_value_of_type(uLong))
> > +		/*
> > +		 * deflateBound() takes uLong, which is 32-bit on
> > +		 * Windows. For inputs above that range, return zlib's
> > +		 * stored-block formula (the conservative path it would
> > +		 * itself use for an unknown stream state) plus the
> > +		 * worst-case wrapper overhead.
> > +		 */
> > +		return size + (size >> 5) + (size >> 7) + (size >> 11)
> > +			+ 7 + 18;
> > +#endif
>=20
> So is the idea here that we estimate the highest number of bytes that
> the deflated size could end up with?

Precisely. And the formula in zlib is a bit complex, it calculates a
"fixedlen" and a "storelen" for two different ways to represent the worst
case size. But for large values, only `storelen` matters, therefore we can
get away with a much simpler logic here.

FWIW zlib v1.3.2 added `deflateBound_z()`, which accepts `size_t` (or more
precisely: `z_size_t`). However, v1.3.2 is only 7 months old, so I'll be
retired by the time Debian stable gets it :-P

Ciao,
Johannes

>=20
> Patrick
>=20
