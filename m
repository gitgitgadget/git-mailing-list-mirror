Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB81CAA1
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811406; cv=none; b=a0PTWRLF4NvQy0aVxMc/F2m5OmBXuyeXz4PlduTKQOwTev7yrsPxhtt1USFdIEH85eED/uw5y5BDzdf69zwxQwojSXhcAU8qjSmmykv+CnsQzGxhWlRF5fu5t8fVShDUh/N5CM9TuKQz/RoTfIojMnOliso1cJ5W4KFprjhieec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811406; c=relaxed/simple;
	bh=jtBhTLgVBMUTFOBh4SYvLY1mdrNOay75ua/mq2w3hXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDZ6bJNK50SiME5iPivo3aK0chBcZk6oRyiN7INs7RLJ44bB20jn/RA/HRqoAlIlRXJM6JS+3usW/E4+21AT2tmP8yfIxxM8tffi9SY6ZjjyrCEUxmISszWkjk5bb5RIhi9DW93G+c8Bt3MJQBmKxgAnAm05C08j6wpQ4mWn1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kUvGGKEz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfSTdo9O; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kUvGGKEz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfSTdo9O"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 171911380522;
	Wed, 24 Jul 2024 04:56:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jul 2024 04:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721811403; x=1721897803; bh=vx+yV7YWBG
	Db42xraa08SghiWuiHwUSyWfsObamO5PA=; b=kUvGGKEzdlDlLzRzC8PzO4TEq6
	eBeXANq8ykdmPBk1cIBaRXPcyL3BRoVfobCyNhCnYvm2YupnqWQrqweugnE6ldal
	3o6qQfNR7eM9GpJc3T+XgjzXYVj1uHBOWP5bL36Au/opp5ryI0SaUFRgbJMd+80N
	1rig4tFSJYViFeaq0hXXa7smW1pyFwrcf1G6ssltSq510XMLWrMKqo8mJZvIwzRz
	HZEkroTiRJ6lr9PDWBw0wPLPw6KJ0useiF1EVslyhjcT0Xpg9WD04mG/TBY6mwQe
	pdXj+qTnZerlZ8o84PJ7BTSIgzhiTPsgenR5YuGD2gKRVkb5Ij5oAWrctsdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721811403; x=1721897803; bh=vx+yV7YWBGDb42xraa08SghiWuiH
	wUSyWfsObamO5PA=; b=YfSTdo9OBJfy4MUpX+46PojxJdksUxK1V/BiC4X1X9/K
	sXd8axbuL1yTqPdEQJQFZfipAgXVZN0YfayjkJ1U6Uv2Qx9JkFORdn6FJe330Pyg
	ENiLEUsdDr+ihIJXATtNIxw0Lj5jYSebMSxtZ/YyNlUvw13t8KopCZjNG253nq95
	+HQDDBje5jS8hHB4ao1SH2/zlE+7BYBLeYHNYfd0WXzN9OjOfWd1phFUx2dSElUh
	r+Rfo4kxZBK3EFktGKDXgyk/4vjgrapQYoLutPnCqT+N+Y3gJlkyjiMQt+KwnE+V
	K9yjOy/GTlgpThFsMRLqEMPfqJRuyHVoSA0gKvig0Q==
X-ME-Sender: <xms:ysGgZmre_wDz3S9w-DED5H8MiOMOhC3L3ZCOPany2Hz2hkzpvMHX8g>
    <xme:ysGgZkoLc4y4PQFnG9uflU0PNdKSTallZtTOW7s3rfgti1lzLPeIlluL7x2dBsNaf
    zj_B7Cs_pkjYYEYpw>
X-ME-Received: <xmr:ysGgZrOiuLRFO54MAnXnSbHLdyFjrCgRX0rUFf-gq_Ks7P2-T80TRgNveZKy6bpvCTXGXZDlLypiaPhPHwBZTMRN3QZXU9zDV35NV2ONZGQ-fy6p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ysGgZl6EsVAsDthoR1h04ZbYzc5ZHmhhm1JQk80nRMOTWvrozGZZdw>
    <xmx:ysGgZl6UbZ8WdS9Ha0rK6zrF2MF1IIJt_V1NHwAOXUMEqsNJ-CG2Rg>
    <xmx:ysGgZlg8gyDSqCG8kg0oBmQ3ZVREPBciGflSpwt-yFzg7WVm3hTa8Q>
    <xmx:ysGgZv5S1SNbLN1DErQ8utmWq52deU1iKb74t5yHGbYH_y4GO6P7HQ>
    <xmx:y8GgZjQnriuZef8kw6fLRM4jVQSknEvG2AeOLl9Yje4fwIVHZyyeiFSN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 04:56:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7b4efe03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 08:55:23 +0000 (UTC)
Date: Wed, 24 Jul 2024 10:56:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v5 0/7] t: port reftable/pq_test.c to the unit
 testing framework
Message-ID: <ZqDBxUC34pV2TLGz@tanuki>
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <xmqq5xsw2fyd.fsf@gitster.g>
 <CA+J6zkRKzQGvwhiQdgRqcctDP76y5_v582rRTzEXJyx7=+WRqw@mail.gmail.com>
 <CAP8UFD12Cqorr7oPS+JfOTYY6LaNUgPEJaEscf-jwLUOur+xqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FgXkZx3T9CYlQViu"
Content-Disposition: inline
In-Reply-To: <CAP8UFD12Cqorr7oPS+JfOTYY6LaNUgPEJaEscf-jwLUOur+xqA@mail.gmail.com>


--FgXkZx3T9CYlQViu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:17:55AM +0200, Christian Couder wrote:
> On Wed, Jul 24, 2024 at 7:12=E2=80=AFAM Chandra Pratap
> <chandrapratap3519@gmail.com> wrote:
> > On Tue, 23 Jul 2024 at 22:39, Junio C Hamano <gitster@pobox.com> wrote:
> > I did talk about this with Patrick and Christian on a private slack cha=
nnel
> > a few weeks ago and here is how that conversation went:
> >
> > Me: Hey, I wanted to talk about the message from Junio the other day.
> > It is true that through this project, we are modifying the reftable dir=
ectory
> > to a point that it is no longer easily usable by someone from outside. =
If
> > that is the direction we want to take, wouldn't it make more sense to g=
et
> > rid of reftable/pq.{c, h} altogether and use Git's prio-queue instead?
> >
> > Christian: Yeah, I think the direction the Git project wants to take is=
 to
> > integrate the reftable code more and more with the Git code. On the oth=
er
> > hand, there are libification projects which are trying to split parts o=
f the
> > Git code into libraries usable by other projects. But I don't think eac=
h of
> > these libraries should have their own test framework, their own prio-qu=
eue
> > implementation, their own string implementation, etc. So, even if I am =
not
> > sure about the end result, I think it would be ok to modify the reftabl=
e code
> > so that it uses the Git's prio queue and maybe other Git data structure=
s.
> > But I'd like Patrick to confirm, and the list to agree to this. So I'd
> > rather wait
> > until Patrick is back from his vacation before doing things like replac=
ing
> > reftable/pq.{c, h} with Git's prio-queue.
>=20
> Yeah, if it had been discussed and agreed on earlier, I think
> replacing the pq implementation would have made sense. Now I think
> it's a bit late at this stage in Chandra's GSoC to go in this
> direction though. I think it's better if he can focus on finishing to
> replace the unit test framework.

Replacing the priority queue with the one we already have will create
additional work in the future when we want to get the reftable library
back into a state where it can be used as a standalone library again. I
know that it's currently a mess anyway, but I've heard from multiple
folks already who are interested in using the reftable library in their
own C projects (most importantly libgit2).

If we want Git to be the reftable upstream for such projects, then we
should play nice and not make their lifes harder. I plan to work on
portability work as soon as somebody properly commits to integrating
reftables into their project. This will probably come in the form of:

  - Removing all Git-specific includes in the "reftable/" directory.

  - Declaring a list of "shim" functions and types that users of the
    reftable library need to use.

  - Implementing those shim functions for Git.

Of course, those shims will closely follow the interfaces that we have
in Git. E.g. there will shims for "strbuf", the tempfile interface, and
everything else that we currently use in the reftable library. So
ultimately, I expect that the shim implementations will simply look like
the following:

```
typedef struct strbuf reftable_buf;

static inline void reftable_buf_add(struct strbuf reftable_buf *buf,
                                    const void *data, size_t len)
{
    strbuf_add(buf, data, len);
}
```

While we could also shim out the priority queue, I don't really think
that it is worth it.

Patrick

--FgXkZx3T9CYlQViu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagwcQACgkQVbJhu7ck
PpRqyw//VwQRWDcuB9532Xr+HLS0nCw0QpbrUi+3LqzaCXyaE330KZr+RFbqIf0I
vwkbLuvR1gaRs24StAME/4emGbUzXGiOom2SsOe1vGP0V6XAuOMl0E67SjAaGJbI
zVDn+sCpf6vat4LTjKvNsDTsGc+JtQnoEe0QyLOCZyUZGtAnPbreAPhQWo6dqLFd
vCoicYz+v6GMuYHWlB6zTy29j/eXby1G2Zoi99xXy4p1u48UzI0ppE3cPiy1uwnD
chYod+alSJsryQQnOFsgXcafFZu0Mi03cERxrhR7E5ItvQHMTAlTqlxl+FI4MQt+
O9/XiDP8TTY5jO732WCGCERzsA0r0ucGXsiffyZPWDNhf/IoTuhhvDMWolrPXjlW
Y5U7L8eIlfSTQVfn5TeHKb0sxBJyLL/yYfqBOSlm4l+bRq/A9F9f0FT52VCYt8TW
WqFT8JoDsXO8SRFhqY32Oy5oM02nzhvx6g3WxuaSAQ+VOOswMzYli7FQXgzAlBZ0
aD6aOxYUxJg18SV3ePcdeIr7/ltMpPEsfpUp1f093wlzJNQkKfkXXf55H7eVKLdd
FJ0ZmdBjkFYxFYHXR5wyQ/atsp+rzWUOZGr+otqrXcRRIHkNLm2X39Vh6AmEtsmE
FNGXKqcPN88y6AvGhphrbhLvsumL67GiDZ1PSaF82PGDWGTwaaE=
=clk/
-----END PGP SIGNATURE-----

--FgXkZx3T9CYlQViu--
