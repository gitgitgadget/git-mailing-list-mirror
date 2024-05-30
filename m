Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5C174EC3
	for <git@vger.kernel.org>; Thu, 30 May 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068584; cv=none; b=Z0kDrcI03UCsL0OF2Pj9DQpVqyvCqz8nMGB+VKlDAVck2tLSjWKy5TW+jeFnFfgh9vj2u3kciBOktvPJsWtW9v2lPyLdYCsuvhBizrvhH6vW2ljQYwfvti+mJuuczyR0LhkuTzc7VCxtPuqOpQ/YQ7i4tjuPVvBOnb13Epg6bXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068584; c=relaxed/simple;
	bh=1Bq/U3nu+no/XJAg9PkjzyWbzlFD4/6lP82Uwg957Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIjSYWF3Znm8fMmtf1O6HC4TpNv1345kWKaJ/cN8g88jQcvGs+gEHCN9jM5NJVLZPWRKDb7b2MON+lp9dHbExlf0sCcIsZAL96WI7ERseCRYu9f9aZ5snXB+nd68wWQ01uTh33jeS8BzeJFwMDPQCgkO9PjT8IVl/2ALuzidfKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N1fWPn0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FTJAJpel; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N1fWPn0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FTJAJpel"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2DFA4114024A;
	Thu, 30 May 2024 07:29:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 07:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717068580; x=1717154980; bh=TjjHapVYbw
	t7Y6acX4CegdV9vp893ujNq58EYumqVwE=; b=N1fWPn0evgLGAzAC/S+Lbq8inf
	4Y/jWljGlAzsTT2BIgVq8Cwli6+1MjGwF9jGdbQ40WWMa4LBuAo1rGJ/Z0fF7IQp
	h9jhwU+Zf2AX+1x/0ireNk7XLUYBfzg2vhLjheZvxYKa6LYHd2iLI3Hv9balSaWR
	qAfFeQWuySw96Q00+9w8YqArFTLysRWXI5kr45WpEaSsFGPookrikwXWRT5Ffn00
	UCzWwKzo3D7O8RgXsEhLQrKYy8JEd572v8P7S39kQSb/arPu+2hkOKAEBdvS6xmN
	HiW4Dy1W/JhtxygfsZfoZqj2YX1HuE4SOxYA5uM/Ar9eBZr3LtNdIwg9YS7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717068580; x=1717154980; bh=TjjHapVYbwt7Y6acX4CegdV9vp89
	3ujNq58EYumqVwE=; b=FTJAJpelzNzVu+1A6z8vWO3IezIkrcB3tREx4x0fszIb
	nqJzoIdgxiYRWQ/zf0YVyFasdxQh1iotM38Ckpcfd2CELGuJnGfBm+BZy3as+0dX
	5xYfd1748U2zyFnPTJLDLzi2W0xYD17s38Jgqj4kn50YqSwZYvqoLsg03/EsMYui
	S4lIsBUAJohGfkpVTFsmRH1djI5TM3W0R3YXrXNRWTbt+skx7wcgQAgJx4VguyIs
	+fFdgJRmReqUjIfwb0duMqAUf7QUvgwi2cwgG+YU772149pOXwNdrR85VKz2NSMe
	FOJlLImW9uJ9nnzrArlLLQZi4vX/7QVLeC4Lid4PHw==
X-ME-Sender: <xms:I2NYZuJSjyvIQJHaJ6Zy860Pc6k2R2ex2I_hcZuYd81T1kTiPpilqg>
    <xme:I2NYZmJyy_xLzD-KaWe0pYPEVgU2YvdhQKXKyzN8tYR7xCoPE95hH1ncndUCi9-sn
    3ZzLSDnhTuAHc12Zw>
X-ME-Received: <xmr:I2NYZusXHNFz9tCLKOcK5xasmEfcRjvq3Cpm4EJRv3Wq7o-qQqUvwe7N6cb1sNbKC77Un4kad1FSfuP0K7TtwmzAJHkQVtP3fMhtxIcQF-7V9RUkkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:I2NYZja9-mENlrRDOzglQvvGXWwu9r_Ei2lsepB7TiZT9L0xbb6gkA>
    <xmx:I2NYZlbYzHv22gc_cTu-l9JDDFMFNkDt4hIqG5k2tthvOFSolobQnA>
    <xmx:I2NYZvD8w0TGEbb0t2z1KkuXH_Nb56-y_DEoNu2vTd0NUuYEY26l3g>
    <xmx:I2NYZrbjjxxGkCpS79nAksgav6IuTQJ6HjCq-6vFP9KdwFIsRR5rvg>
    <xmx:JGNYZpEQtRttU_ESJY_vfZV0YZcbeAcwxGyWGs7aPJ7ONxF9JBnJgLW8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 07:29:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b4813d0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 11:29:21 +0000 (UTC)
Date: Thu, 30 May 2024 13:29:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/19] global: improve const correctness when assigning
 string constants
Message-ID: <ZlhjE744pNJiyv-k@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <25c31e550fcecdda7510b259b271cd45d036f5d7.1716983704.git.ps@pks.im>
 <xmqqzfs8y2pb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1w4Hz/UZOuG026x8"
Content-Disposition: inline
In-Reply-To: <xmqqzfs8y2pb.fsf@gitster.g>


--1w4Hz/UZOuG026x8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 09:58:56AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We're about to enable `-Wwrite-strings`, which changes the type of
> > string constants to `const char[]`. Fix various sites where we assign
> > such constants to non-const variables.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
>=20
> This is a noisy change, and it is kind of surprising that ...
>=20
> > diff --git a/builtin/bisect.c b/builtin/bisect.c
> > index a58432b9d9..dabce9b542 100644
> > --- a/builtin/bisect.c
> > +++ b/builtin/bisect.c
> > @@ -262,7 +262,8 @@ static int bisect_reset(const char *commit)
> >  	return bisect_clean_state();
> >  }
> > =20
> > -static void log_commit(FILE *fp, char *fmt, const char *state,
> > +static void log_commit(FILE *fp,
> > +		       const char *fmt, const char *state,
> >  		       struct commit *commit)
> >  {
> >  	struct pretty_print_context pp =3D {0};
>=20
> ... a change like this does not require any other change to the
> code inside the function (e.g., by making further cascading changes
> to what the function calls).
>=20
> But applying this step alone and building would not give us any
> constness warning/error from the compiler, so the result looks good
> to the compiler, I guess?

Yup, any intermediate commit builds with DEVELOPER=3D1.

Patrick

--1w4Hz/UZOuG026x8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYYx0ACgkQVbJhu7ck
PpSevBAAk3aivyomeqioyaBwAd0pgRCinn7YyE/bS9SU2JUhn5Euw/KcGW4niDgL
s3kt3Rt4zXNRlIgskeIjWQRdg4HAXyzi66gUkX+dBUftKSz3+CtY6Upwtg7CtTGy
N6ntbzEoT6VDLBG7UMrB4/awUuF39uE9fqyonVVTgNXQ/N28SHUPvcrvXutL3RyM
WeyOAmRd8mkyq4zaJdYJhTf3mLyGYXDDAOplqrIphIquC42cmJ88CtBCA87I8SiS
gS7ZewSWppWrCGui9dUyL9vywk/gxIRbAtTnybpGcBTlx89ylksazcKgmEDeXXwg
XXen2ivtqUGIK45v+6IKzIkAAApri4uUXoEnQjlf72ZYEHiJadxm6TdBsm5t/CRZ
4/K4hKt2JRgfaG5ze+/Dwhamy2tg2QbkfAcwl4CPDA+kQNOT2iDBe8F8fUJehpu+
Bi5owX6Q+NmfyCjlidsEnw5UM2/mqoWBKH2Pwuher41xtoEFIcwf/CTP28fsRBFq
Hd3XdsqAbF9zPyOWQeczlZtoaEk4eejllEtK4lJ85nd3WQbr+17Fdo6VoFgAexLE
LuJqfKhrG/FL79byCTJ8bcwnYXs2aa8TfBsxIIH6DBKvcwehuVguYMapx2ygHUFp
RsoSM7BQTP76wAMiUm8D+wLp/rQzWnMMEqye6GITLWcipLj0W0M=
=cdcX
-----END PGP SIGNATURE-----

--1w4Hz/UZOuG026x8--
