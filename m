Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0081C286
	for <git@vger.kernel.org>; Thu, 30 May 2024 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068675; cv=none; b=u8rWRYEM9ZGg1FBUvxFmB/Lac3sJ1b2PtiHnGJgHWR2mYOfrwWIGXBTTyhZyN3H3K6p6zqj4pCUY3/ToE6wBB0dN5bYABghQWMToK1yuPR+SMS6pvs40S0X4iiiiDqXutk4BQs2IHamnR1Kqiu1rCEK9bKRXwr81sZGwuZQSKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068675; c=relaxed/simple;
	bh=/hPIPML4U25cV8T8lU2RCQFfT5lvkGT2gVe8HHuGdRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds9KQxFU/BD30E8ntCRPWyXfg5f2qGzMyiof51nsScnlRbE/w2YdfM6ojhEClgz0ScLZfFsoYOcA2MqsQIaemO1vjx54DkWnCZFIPzm1QmkWP39/1xKqWG6sagYdLPpsOtWfnSsbVux44+Rj8F5L7K+weYoOy75PdyZ+I2fibaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NF8QMbrj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mIzzflFN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NF8QMbrj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mIzzflFN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9422E138011F;
	Thu, 30 May 2024 07:31:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 30 May 2024 07:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717068673; x=1717155073; bh=RECx0UIp1l
	jc9otEEi6/Y9m/epQKMAqG1BOmByuI+Ek=; b=NF8QMbrjc3mz2wtqI8dvBqzx+e
	b4SkT2J7cb1uNL06NYH0sXqRTB4TJKyTvtaRc/1VV35i4O5AbcHrE+lT4hVBWTEb
	/JmbOGNaSJgw62lKcXldrbDpLH++fOW2+SWwOi/4NSEc8Z3We1wHXXkbafduW3PT
	Znfru3SSz0J8D+lkygvY/jE1wsuapf72cht99C3gSnA7fAk0TVIvGikwHQopAl7e
	iGnQP7qK/s5fI9QaWOgZvkB36Kb30Quek0c/vjBSK5YSMqmnVHZ2dxmYXWIUji3U
	yJ9K/LMLu2dXsHjHJQdLODZtD2R2YPwuTwESXGBUlt6uMfPgJGNGNCKavrcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717068673; x=1717155073; bh=RECx0UIp1ljc9otEEi6/Y9m/epQK
	MAqG1BOmByuI+Ek=; b=mIzzflFNHF62lGjhjl6RAlxI1I030VZ78IWH2etBMuZv
	VO37MKnnWPo0ZW1k3FDIZtPZ71JpZyJCbyiCG2TPFNkpCbUffgk3z08mHJvVMy4I
	NjaQMbuKf7GobiMs/4Q1GjYLo61C9+s9W5z982QlbSJcPXS5EvX7kq3pFsxJbUqR
	IqR7iGp18g+6xjNIPXrlFEKAZJ8w0fHGL+EDFoteY6sNMUpxYq5jJ+5giq1Oy4hp
	nRLevBORQoOM+Cbb7gfWLcBQy+n0fPPbwEY8rVIIjh4ESa+CSipC7Lgby/Wytr6W
	LHmva5PTB/OMw23OBdwLGaBYGQousGgfiPPHEF/7/g==
X-ME-Sender: <xms:gWNYZlHw7xnoIEvb5waODHIkQqyI0GPwmEKWqAL6ztqR2KWeUgq0Rw>
    <xme:gWNYZqU0tK1drTfhLCeVshFRmLlh4OHL2audZj4qmeqgHciOtaQUyZC0FH1cDLEJ8
    d4_dQwxqkYIB9VSEA>
X-ME-Received: <xmr:gWNYZnIAg3Io0iZ5fbfc3dpmIYnde0YjBU3Qt2u35N7OssbUQS55v1FE59D6Sffq7m1NVUKqjIY9iyNRIH-Sl20Nwqv2p5eJkIPHfptGpyu-CxcCEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:gWNYZrEIKf5yWOgqOWYMfRRh5-rqWuv4q-FCoDvKP9ldgcxANM-iYA>
    <xmx:gWNYZrV9t9LkRJuWgLyOBkJ0-WqNlVfi_pUhLzEQzVWySLam1rAsXA>
    <xmx:gWNYZmPA0-z9FdnxmhzASFnqlW0XNYjlWZkJSC7UuhaeLj0TbTvKKg>
    <xmx:gWNYZq1t47zy__4E5zKLmPR6OPAPByZuB0Ye8C-bb7Dj1RI1jiczLg>
    <xmx:gWNYZmSvwDxdT0PhNlsiTAnQmD_T0ZJaDTpwWD5e3ua6Fy8nMhDjjOQc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 07:31:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8028e25e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 11:30:56 +0000 (UTC)
Date: Thu, 30 May 2024 13:31:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 17/19] builtin/rebase: adapt code to not assign string
 constants to non-const
Message-ID: <ZlhjfmZ89nO14jUv@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <16d3d28243a0480c929ae3740db92ade238dd325.1716983704.git.ps@pks.im>
 <xmqqh6eguycr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YM3lqbsKvH5sbgqW"
Content-Disposition: inline
In-Reply-To: <xmqqh6eguycr.fsf@gitster.g>


--YM3lqbsKvH5sbgqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 02:01:08PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When computing the rebase strategy we temporarily assign a string
> > constant to `options.strategy` before we call `xstrdup()` on it.
> > Furthermore, the default backend is being assigned a string constant via
> > `REBASE_OPTIONS_INIT`. Both of these will cause warnings once we enable
> > `-Wwrite-strings`.
> >
> > Adapt the code such that we only store allocated strings in those
> > variables.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/rebase.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> One gripe I have in this change is that it used to be crystal clear
> what the hardcoded default was (i.e. written in the initialization
> data), but now you have to follow the program flow to see what the
> hardcoded default is.

True. We could adapt the macro to instead `xstrdup()` the default
backend. But that feels a bit hidden, so I don't think this is a
partiuclarly great option.

An alternative would be to wrap initialization into a function
`rebase_options_init()` that instead allocates the default backend
string. We can then also create a `rebase_options_release()` counter
part that releases its resources such that this whole thing becomes a
bit more self contained.

Patrick

--YM3lqbsKvH5sbgqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYY30ACgkQVbJhu7ck
PpRQMxAAndcarEGRwBLQ8sXvSPVp6dazW1Nl/UacXMcJ3xU6LkKgH0jQIV+VpOyR
oBt2s8xTt11lz/6HQhjxOkM6pB9AETlXcDAn3n1NPD8p6AAfQQbEQJgDBOV6iN/Y
dvGj9NL6xVEq71TgO281P5fLG2zoBrM+8Lesj1Wnra0x4Y/o5flSmvbqfxgTPCXy
Gz7No1LGbZNyrx1TATa29u3beb1vkzIrsQM+UHA2w7aUSVBHDmCvC5/Xpr/+mBkB
jtA+9l7kDUsnSaCRLwCc5TvlClnWzlGUKpz4YugjOsD9TKS6+NkrkHQxOkH4Stxs
QDDK4qDzWnuB0OJyEB+MD8TdXKQh/8xUWT8hizJvJHJpOkqy0sqWppLlDd0dTdrb
74fTWBTgibmbDqZLuam8lHH7PqlIjBjWr868Cjgip+FkppP5H0WbcRtx2qZs858x
x6Y/sFfgK5CSD4nFNut0vpbvyB1zaAVI0XnhkqnF9xLEF/argR9atQLLSEx/RQUi
q61yo3WCGJjgTRV9lHB9Tx4oAbQ2rd26wklbvjD1OQX88rw66j7qDoTTrLEQFiSG
KLvWs24mVJoPEV9uG5Vqvrpo7Mk7RYJelWf+QBKKTRvsxtDNvd+kFQxdzwFliN99
7d99IGSAQyp9E7w/VXtNuCT4c/fvSNRGlZs56N7wsavO7zCnKQk=
=3G0p
-----END PGP SIGNATURE-----

--YM3lqbsKvH5sbgqW--
