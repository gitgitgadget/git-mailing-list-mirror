Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250D376F3
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592577; cv=none; b=eCdoqBs7T9umxz8IBKQeUwXqyC18y+MxHeBg9F9RI5qyDvnqZhVQsFdLErR7+EReZWjA87V3Pm5UPPLnOSnrv+V9So61Siokx/gbXbDpsWQFfNbieKGZSSKGZpJAOuizR7ARkj2YZ+Mi36fJ3kSANIbcuFR5Edn/YNCMOJgiqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592577; c=relaxed/simple;
	bh=eFJL3Y2VAu2Z3/5udZljibh+dAcOAn89TkJMLQYmm/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUdKDXUyniFSXrDK9KOxo0MAp+ktDEwdoscLLcbEEWlYBkuyJ3M+HtUCrhRtKtlqYHzY6XPU0Bk/MZ5AFF8TX1nYDkJsU4/T/0nFnarcgcM8wKmPpaiKq+TZypNhq+WNAzubnDw9qSnHRs9XkvYfyyE9mRvPui4rjtDaVxYCNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P5y4bVrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J3jnWGc8; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P5y4bVrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J3jnWGc8"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 9C5425C007A;
	Thu, 22 Feb 2024 04:02:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Feb 2024 04:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708592573; x=1708678973; bh=XICQowuLaO
	x7PosF4zWcjS9Ct60MK253MPb2KPW6AGo=; b=P5y4bVrFIUvg3PFJ027h3ygDjg
	uMm3iTC1WoNFR4ldRt5rzWNYZplVTSkHo6tyi4D5d7zOLsKk5UydpVe3LxIyM/HB
	fKicFe6rHhkV8HwROyjAHnkJB2+bBjSHBEm7ZiRW+N5+noebx+XL7j1KviqZQK7V
	8sV9KqUvzaPUhV24dvxeol0SyR8X8yQeejgfoFqmGtFHBEEnc4XKSuJRrsqJ+TwC
	AByog8RO6DC+wHDx+zY5yTRlx4RJv6+em5s3xvJZ69F1WQ9LTE2ztyLqzTukvkl4
	b0chDaXlZlq7xVAHcwJLjiFHiIJNzVXolaUeBU80wNbQZehOa+Fdu1oTJ8BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708592573; x=1708678973; bh=XICQowuLaOx7PosF4zWcjS9Ct60M
	K253MPb2KPW6AGo=; b=J3jnWGc83J9EhP4GNNeKJV+5bp8FTt2aXQrn+rCnOYZW
	SzeXqUyemMxA61QvxIodna90LE9PYLjg6OUmmkWDWtAYmQjHoNuMwP/3WVi7YsNr
	LZitrj+c4dkv0ezFtC5TNtNBJUoler9S9esheVgElWBLRCosrtcK6G+4bxDkHrip
	f1PjRSkJbylbkxzVe2UlEL+YVHTnRex418hHUCczZXaJix8vk3uJc6sN+gbfTP40
	OetNCJZoFWzM8ZY0IAHJkaQLkn0sTVWMeGPo8Yw/GKWpuacRT3YztpcWNW42zqId
	Ngu011RDKacFB5/dBr2EDHXiLeN14tm2geoERPOr2Q==
X-ME-Sender: <xms:vQ3XZWaCUnGnOCwo8S54LecfyxXZqwSRXmRAMCV2lACSBJT27mzL2g>
    <xme:vQ3XZZZFR1MDGJ1FZ13utAItTHpwqYWCn8l_oMk5dPNrMWY4oT0ZI989iNQmAVH2o
    kGrBSV7IO_82AvsKQ>
X-ME-Received: <xmr:vQ3XZQ-9ha9DbAbKL9GVbZwfFoq3VFj-TwrgoqLbb29U4QBOYYSQEFj7j5EGaNEjiGrYmvz1QcP4XbwQaFK43TD-fApxJqIXXCX4Kv1uy9T6b_dk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:vQ3XZYplhHQqjFCHsgPQ9IHekNEoeYijW7CnrRvoqS0DdXvIvFUI2g>
    <xmx:vQ3XZRr8FBO5f-IwSh5MLH3skfkQ0GblqKmY-qFZV1_snaTRNf-XZw>
    <xmx:vQ3XZWRPTW8xid2dOp17ua4UCoueG55kbU7Xte2yw02XCK9BPjLOhw>
    <xmx:vQ3XZSnPf71B-pv4wtsQkFofdu6suBs4C6weqPKWRBoOsQAnMU5fAA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 04:02:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bdc4fee6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Feb 2024 08:58:43 +0000 (UTC)
Date: Thu, 22 Feb 2024 10:02:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Segfault: git show-branch --reflog refs/pullreqs/1
Message-ID: <ZdcNtxw04MtybTWZ@tanuki>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <20240221084250.GA25385@coredump.intra.peff.net>
 <xmqqv86hogpi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tAFO0BlEcmcjvG2+"
Content-Disposition: inline
In-Reply-To: <xmqqv86hogpi.fsf@gitster.g>


--tAFO0BlEcmcjvG2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 09:44:09AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > with an empty reflog file (added by that same commit). The code in
> > get_oid_basic() to parse reflogs doesn't suffer from the same bugs: it
> > checks up front that the reflog file exists, it preloads the output oid
> > with the current ref value, and it doesn't look at other fields (like
> > the reflog message).
>=20
> It is a usability hack to allow foo@{0} to resolve successfully,
> instead of causing a failure, when there is no reflog entries for
> foo, I would think.  As to the "show-branch -g", the intent is to
> see the recent evolution of the branch, so I am fine if we do not
> give any output when no reflog entries exist (i.e. "no evolution
> behind the current state---it just is"), or just one entry output
> for "foo@{0}" to say "there is only one recent state".
>=20
> Even though it may feel wrong to successfully resolve foo@{0} when
> reflog for foo does not exist at the mechanical level (read: the
> implementors of reflog mechanism may find the usability hack a bad
> idea), I suspect at the end-user level it may be closer to what
> people expect out of foo@{0} (i.e. "give me the latest").

Hum, I dunno. I don't really understand what the benefit of this
fallback is. If a user wants to know the latest object ID of the ref
they shouldn't ask for `foo@{0}`, they should ask for `foo`. On the
other hand, if I want to know "What is the latest entry in the ref's
log", I want to ask for `foo@{0}`.

For one, I think that this is adding complexity to the user interface.
If you were to explain this feature to a user who has never encountered
it, you need to now also explain special cases: "It gives you the latest
reflog entry, except when the reflog doesn't exist or is missing, then
we return the object ID of the corresponding ref." This is a lot more
mental overhead than "It gives you the latest reflog entry."

We also have to consider a potential future where we stop deleting
reflogs together with their ref in the "reftable" backend. What do we
return when the reflog is empty and the ref is missing? "It gives you
the latest reflog entry, except when the reflog doesn't exist or is
missing, then we give you the ref except if that is missing, too". It's
getting even harder to explain now.

Another angle to me is scripting. If I really want to get the latest
reflog entry, then I now have to execute two commands. First I have to
check whether the reflog is non-empty, and only then can I ask for the
latest reflog entry. Otherwise, I might not get a reflog entry but the
resolved ref instead. And I wouldn't even know how to check whether the
reflog is non-empty.

So overall, I think the interface is a lot easier to understand and use
correctly if we didn't have this fallback.

Patrick

--tAFO0BlEcmcjvG2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXXDbYACgkQVbJhu7ck
PpRlUhAAjJc3QUBQhfXouN/s16UqTD9Xo5cHDT0Mw/0qhjEAz16BcarcRcRD6hUu
eGj6HgDfltOPU0ReHrSpSVsypjK1hm6j8u7HT3ZpbJVkp1n9UbPzbpZNtKsa3Tcr
3gxIVlJYGsmAESAmFkLHSnyaW6RAVxi6N7VN0bbeejiYfpWsQAcccb1AGsXE7/T/
UJaDgiY+1sAGHhiyXmqvCQqd+A6SWK2CSWetGENl7lEOmeBDJV5AOqFConQFYslw
8YSH5M74zeUvTEl048rFPXqbQtyJ9+ZzqU4Z2S2o9wcpCJ77hke+HK2CDQhlw8cR
SNMIoQGtTT+4AhqnfgHm/mf62EX29WW/MBVR5Ht7T7T5MpTPTbxp5LlzGT8gIXWY
Lw5GUnrnCc9YYYtyCMFchhRiBVjpA+e1UqN3CYjf+SFjOwmXAtOQZKeVmEZPJcql
2QxAhoamXp0jA4Tbzwe/cev1D5XdOkEEhqbnFdRRtfISYX+bBAO5NondFMXr5h4C
fmjo8yTFWufuKGPmW08YVHytTO1TDhtMRuMQSdJtqyAmTXOaDLT0f60cVYXmbkC+
e0lIevrk0o9GdF+vk5Hmji+oSXFZYCZRqb9kAcjOvzjt2B3l1Ta+uLmx2FUNUayw
JRg6S6YYXnPe8hS75P/rId/QAXfqIPEUCxLLkMCEIkVVDjqSvTI=
=Hvfg
-----END PGP SIGNATURE-----

--tAFO0BlEcmcjvG2+--
