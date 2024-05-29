Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791A17F365
	for <git@vger.kernel.org>; Wed, 29 May 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981911; cv=none; b=NBKK4Akmd5RfMv9B6ym1T9OiVTZaR/w5p01zzdAOwl+wbIbnWOFq4KokrLjk+vKEpSd+cahT/5b3cA/eHkmmG8/jj/7M8gSOv8q5U0OLD+1ps9XiRZKvby4QqJsCPiCFGSYSihhbu+S+adu7kk1GjnFOFthdDktO0r/+Uea0TG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981911; c=relaxed/simple;
	bh=ZhE+BAVJiHSGwPAkmsTykMklNqzVbtkk5AwULRr80hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLWYtR0OmYNhNEfe8cFPeFkCjmDZUsxr0NjDUr5P+CYLdttYE9Kn8Tf2AW+W4GoDBBuMXvOmSYzkm17UIyAMO5yaJZ02ELbDL6tiJfbUB6PZepmUrOezg/3Q2XORZqE9GN/hRu0ceAEspAu6342XpgA0ijZ9h88IXmVZFUlBt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N1Qd36ov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g3bDYrXu; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N1Qd36ov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g3bDYrXu"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8B4E0180011B;
	Wed, 29 May 2024 07:25:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 07:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716981908; x=1717068308; bh=u4/bk9OO4R
	QJOEsStUBvDmektt3e3zOK6+3upsK32ss=; b=N1Qd36ovHWDSOBAXx26uxwbdwm
	YAR/x+/bDNrp8znXfPtLFCPE2a2lcQ1hIwivf2fsztKzXTnmupVatvcqE2UZsz1I
	6jIs1moIF7ZwsTGM4jVb8Z/XrNqe2G6enKnTN38riAll5EEhYbE/syJUTU0TYZ1a
	gxQG4x7/r+MBmVaNqCRhnPKyddrul6XVFlRX1OPFlKbTB40z71VgSbOMOUCeI4W3
	I4sWB0IXV5nKbkpyNXfhmgyf5Mxv8a+2PdQ4AWkiNeFMoDmhzmMFRQqE08iF2JCz
	I00XvmEZEoLYP24yEAZkVBpEzzU9iHqRrDpAwNCJEzJM+Z/NU337JSErA3aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716981908; x=1717068308; bh=u4/bk9OO4RQJOEsStUBvDmektt3e
	3zOK6+3upsK32ss=; b=g3bDYrXuaDQ4YUOREie8ERBZ7tQgT/l8DrQGGQqooJnV
	Qp6vieRCq//5b/FvgpUxh8nsoxJJXt+flBI5yNFTp+iKI/xHNuEeaPMOrs1XAIHZ
	ncIOTKlgnh6s53A39xq2SkzeJ2wUfIKgqB2nhJcrZBnZzSxXdwvMkOnQkLn/WvfS
	OGSPL8VYzKdlDq/OLudtg/WeMqyrZdfbvGQlhyqU3JM4i6TwY7tW9Eig0p/jZK8f
	N69ZDwNSmfTFgMWgZZMichn7fSVht6eYD758xF8KN6N2oJAJuloeizv8WiaPbyjR
	JgUuKKMxYayafkCcSOpW9pJEZrOpvnGuyY0WuLAPpQ==
X-ME-Sender: <xms:kxBXZrmQpIx15F0GKsfKwFHqMpStcHmABitgGNXaef2xUNZExr3xUA>
    <xme:kxBXZu3wmdx3m_rl2YJDI8_RqJvurMm4gOctTIIMEcWgURrO5DMdSiySf2CuaKxkM
    g6ptuc4d5fLkwTU9w>
X-ME-Received: <xmr:kxBXZhrb3NM_YyxjTWghyweTClM9YeqFSP7AKt0WDyFy9irYHbaDuV-U6xL0pWZg8FESKEhWyS7S2ERLULKfzjEAuKeaa3aEdA2alsx9jdq-eu8V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kxBXZjkSvm4tpz9UJxlYAGZPov6taYZXnebGTSrnv16JJvmRrGTt4Q>
    <xmx:kxBXZp28HGIgeu5v9tRexxSrs-Afsjjsz-97ofmuT6Ap2fyaStQagQ>
    <xmx:kxBXZiv5Ux8ufRBA5vq2CT8Sow58Jh2wRmMzwycnwRMpyMdx5q0yPg>
    <xmx:kxBXZtVK3zjyY49UBH0cP6w1sxwwbPfnsSGEAlx2GtXC1MQuADVXWg>
    <xmx:lBBXZkR__XQqzC-mzNJilUF-BEo5-G0pzoQDad1UjBraNaXGYP3GlRAG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 07:25:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0bf95dfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 11:24:50 +0000 (UTC)
Date: Wed, 29 May 2024 13:25:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/21] strbuf: fix leak when `appendwholeline()` fails
 with EOF
Message-ID: <ZlcQjvAS-27S-mjw@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <9dd8709d1b3b350008218133986befdb2ae74bae.1716541556.git.ps@pks.im>
 <20240525044635.GB1895047@coredump.intra.peff.net>
 <ZlQr3tsDTSOGvFUQ@tanuki>
 <20240529091633.GB1098944@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="byUSjI6SdTXlwINd"
Content-Disposition: inline
In-Reply-To: <20240529091633.GB1098944@coredump.intra.peff.net>


--byUSjI6SdTXlwINd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 05:16:33AM -0400, Jeff King wrote:
> On Mon, May 27, 2024 at 08:44:46AM +0200, Patrick Steinhardt wrote:
> > > diff --git a/strbuf.c b/strbuf.c
> > > diff --git a/strbuf.c b/strbuf.c
> > > index e1076c9891..aed699c6bf 100644
> > > --- a/strbuf.c
> > > +++ b/strbuf.c
> > > @@ -656,10 +656,8 @@ int strbuf_getwholeline(struct strbuf *sb, FILE =
*fp, int term)
> > >  	 * we can just re-init, but otherwise we should make sure that our
> > >  	 * length is empty, and that the result is NUL-terminated.
> > >  	 */
> > > -	if (!sb->buf)
> > > -		strbuf_init(sb, 0);
> > > -	else
> > > -		strbuf_reset(sb);
> > > +	FREE_AND_NULL(sb->buf);
> > > +	strbuf_init(sb, 0);
> > >  	return EOF;
> > >  }
> > >  #else
> > >=20
> > > But I think either of those would solve your leak, _and_ would help w=
ith
> > > similar leaks of strbuf_getwholeline() and friends.
> >=20
> > I'm not quite convinced that `strbuf_getwholeline()` should deallocate
> > the buffer for the caller, I think that makes for quite a confusing
> > calling convention. The caller may want to reuse the buffer for other
> > operations, and it feels hostile to release the buffer under their feet.
> >=20
> > The only edge case where I think it would make sense to free allocated
> > data is when being passed a not-yet-allocated strbuf. But I wonder
> > whether the added complexity would be worth it.
>=20
> I'm not sure what they'd reuse it for. We necessarily have to reset it
> before reading, so the contents are now garbage. The allocated buffer
> could be reused, but since everybody has to call strbuf_grow() before
> assuming they can write, it's not a correctness issue, but only an
> optimization. But that optimization is pretty unlikely to matter. Since
> we hit this code only on EOF or error, it's generally going to happen
> once in a program, and not in a tight loop.
>=20
> If we really cared, though, I think you could check sb->alloc before the
> call to getdelim(), and then we'd know whether the original held an
> allocation or not (and we could restore its state). That's what other
> syscall-ish strbuf functions like strbuf_readlink() and strbuf_getcwd()
> do.

Ah, I didn't know that we did similar things in other strbuf functions.
With that precedence I think it's less ugly to do this dance.

> That said, I agree that leaks here are not going to be common. Most
> callers are going to call it in a loop and unconditionally release at
> the end, whether they get multiple lines or not. The "append" function
> is the odd man out by reading a single line into a new buffer[1].
>=20
> Looking through the results of:
>=20
>   git grep -P '(?<!while) \(!?strbuf_get(whole)?line'
>=20
> I saw only one questionable case. builtin/difftool.c does:
>=20
>   if (strbuf_getline_nul(&lpath, fp))
> 	break;
>=20
> without freeing lpath. But then...it does not free it in the case that
> we got a value, either! So I think it is leaking either way, and the
> solution, to strbuf_release(&lpath) outside of the loop, would fix both
> cases.

Indeed. We also didn't free `rpath` and `info`. I do have a follow up to
this series already, so let me add those leak fixes to it.

> > I've been going through all callsites and couldn't spot any that doesn't
> > free the buffer on EOF. So I'd propose to leave this as-is and revisit
> > if we eventually see that this is causing more memory leaks.
>=20
> OK. I don't feel too strongly about it, but mostly thought it seemed
> inconsistent with the philosophy of those other strbuf functions.

I get where you're coming from now with the additional info that other
syscall-ish functions do a similar dance. I'll refrain from rerolling
this series just to fix this in a different way, also because neither of
us did spot any additional leaks caused by this.

Patrick

--byUSjI6SdTXlwINd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXEI0ACgkQVbJhu7ck
PpR3TA/+LZ6qF0m2dht5qptuHdcxvaL91upECbH75JkC4VIWICROn1McisNYmLkV
aNPWaIccnhXe7zZJAjU1Ex1j4M+vWK2Au+nAf3j+X0vMhKZiiaogyItC64X/Fqqn
Yk0PblYsHTbd946em/YdEwNj3S3xNabx8jEmm3ZIT/Bn36wISQoMzkIfWSJSIfez
r3+XctrMiG0cejYSmbkuq+tqBCSsLhgssbXaHoRwTGFCBm+7yvhI/IsCwjI4MrDm
lorJTosoFx7wmiAQNOsgQpcuppeCP+j4NXoxRzVJPpjVfd1O/HNN8O8SvKCBUCTq
Cb07kaD/p6l6rtnh3BWnvj5TTmFho8enDhQbw13Ul2Bq4gACiCKoBMXv9ofS0FJ6
xyj3ru9hODSPZJpJT1lPnlM9nidH5O/dV7lIx0VS7Di85fBUbCZHkzYlKxXD8al2
8ymip3KUZfy2ZVxPpLbKIc/kSCJY+xUfcUXdKz61nQYGdnj8qXdOOu8V5Xe9X+ks
Y1gOddIqGoAR9z6mX8AjnQ1VSjWFoU61qLmPDM23kzT9KPlpVkO2KoFrC+8iC36G
g2ALR9DsOql/M1VKb+KOZn0e2zsi3jvxnjJqqh4voNeKoolCrRofal+UvuiGqg6g
pntla2y/shqIGcSVi8VbNabXkpzIu5ARHlvo9LEMRF8fm7UFK6k=
=Z9ru
-----END PGP SIGNATURE-----

--byUSjI6SdTXlwINd--
