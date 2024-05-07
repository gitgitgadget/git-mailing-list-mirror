Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A8381C4
	for <git@vger.kernel.org>; Tue,  7 May 2024 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061417; cv=none; b=R5wm1G2zcWNy1TPWhGxa26CwHJFPd0Q+Oaptdb+/tHy4XQ+HfABXyxoz0R++JuUxVPy/7x7VrE1lJp2mTP1ms881UQ6Ptc/5WydYuVgIoECrLcEoiIp4T6jnq/kj9SeOY9/2j0wUm6cJXBxAoyibZrH+BnJxKDfKTdN9PO15qvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061417; c=relaxed/simple;
	bh=bLkfC/Ln9InxV+I5IHgdxwKG+irLCNTSFgQhjCrDH6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geGMPDwNYgQHW4M6WHVTMOoGQsTedXyH/kLqJeZcT6ROcQdcWuLqHngdxupajVAKbMgnlylQVU5LLmSYIHlcvdd7dyAJpIn+neRQNL8jHg4u9D7WxYrFQ946G41SdBtPc6KehRXR4f6CrFMdINj+/VyP5OXVc2rOEiqzkPPS3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BPmacOaI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKl+lkxc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BPmacOaI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKl+lkxc"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C3BA9138018E;
	Tue,  7 May 2024 01:56:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 May 2024 01:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715061414; x=1715147814; bh=+JXtDaDSr/
	grXo6WbR2abmgtFDxoQrfxWAeL808cd2A=; b=BPmacOaI6m7khfB9JvzA7jwha9
	9J4CfRCfj2gdni8M1bo44oM2Lp2TxyidCbFboxEQ2DUjuKhHM7LpyJ4srX8AO1KO
	Ii5Orp7r4MEpITR7zOWON/bRFFn3+W/hn/KJ2brpnCL4waSt4KgcIllTWRWO+GR3
	Wslk/UO3TUs8gzrzWO1V7NKngoVpCHwmC0HEOMO7HbAjYZl8GEZtr4yFX2bLT+hr
	Bw8tj1mrXbz2p92R5qEX9+ab6WoqrcRxrk7razlw7RE+DwvNZCvmEPeiXjDw6g7b
	QJVILEiA9Wsuoucu+zb9clvLL00+GrWgaLZ8n3klSv5TdK+ceI+0+mVdwZNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715061414; x=1715147814; bh=+JXtDaDSr/grXo6WbR2abmgtFDxo
	QrfxWAeL808cd2A=; b=OKl+lkxc2kuLmp7XhMAA4+HslhbGlXU+abWfhy/H2FY1
	5NAY66tuVy/LqxKLC/T3FXSNqZjwDwHea/7l5QfZCCBk+J9jMdo3G0yCCTd8Nxw2
	9qcALkN0ic2jTl6/tNmB+k6CaF60XGBUuv/Bl47+g3S1btZKKVRw/25/qq3NaW5E
	h7CBiVJwT3qhEGC9UXR3dDVDWBtn8d4wHUnsKZxpsZbaAmYSSTRuAl/XaWYYM99q
	+wpo5Q4EwaX+4mFLxGLimFFql7seskVw6Y+jWcDsilGjhQDf592nwYWuShNBKVfM
	TiOVxtJ9BgTxr3MI13to2byky0wV04Oj6iE9MFE2kQ==
X-ME-Sender: <xms:psI5Zv0BwqmL6QBuk2x-eLvejnYYPNowUpCteelSKrR2NnA5CEHIrQ>
    <xme:psI5ZuFClhhXjhsr6ZSuxo6OyxcHqlYewc_df_3sarBuFPlxWVXGBPdYYzuM2tKEL
    noo9iCLPXcLQnoSAw>
X-ME-Received: <xmr:psI5Zv733DSCgD0OXnuyLEDpiCk_jrq_9tynSTTgyyx5R02RmoiFzB0huTTsze64GEozcNXt6sc_TVa7GDIeRPl_RHZM7YlOR-xcjHRIHeMmCQPx0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:psI5Zk037y9EJw8r9_Hds6IU7WFIbt1QMzt42mddSnBn8yxKTlFbDw>
    <xmx:psI5ZiF-yVH3HYKmtW3v91Y6GNVdlNFsFywtLitgCwqek_GN9mTGgw>
    <xmx:psI5Zl_2bj9n2nsDC9fKGYsvRE3Rmx7H3-5GA9_xcpT3vTcoIVdFLw>
    <xmx:psI5ZvnRyacxcdG2lhvjyH226-awqhrli0WOORoJ5L47S7xLHJ6kjw>
    <xmx:psI5ZuAotprstt4T8TxIomIqJ1WIppM4CsbjNg5OFXkFrJpOvjTaq-Qe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 01:56:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 96d7f15d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 05:56:44 +0000 (UTC)
Date: Tue, 7 May 2024 07:56:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
Message-ID: <ZjnCoaVP9_wuYiHh@tanuki>
References: <cover.1714717057.git.ps@pks.im>
 <xmqqikzu95cf.fsf@gitster.g>
 <20240503173553.GC3631237@coredump.intra.peff.net>
 <xmqq7cga7nzo.fsf@gitster.g>
 <Zjh8XWwJKp_I1dwE@tanuki>
 <xmqqseyu3ojk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="69eHQ6s8ngK9EsSw"
Content-Disposition: inline
In-Reply-To: <xmqqseyu3ojk.fsf@gitster.g>


--69eHQ6s8ngK9EsSw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 09:14:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > ... But honestly, I doubt
> > that it would be faster for any author of a patch series to figure out
> > that they now need to a define something compared to just adding the
> > `refs_` prefix to their functions.
>=20
> The authors would not bother figuring that out while your series is
> not yet in 'master'.  The alternative they have is to base their
> series on top of yours.  You may have "what changes are needed on
> the callers side" in your head, but they don't.

Yeah, that is fair indeed. Theoretically one could re-run Coccinelle
whenever merging a new topic. But that would of course put the burden on
you, which is something we definitely want to avoid.

> Somebody brought up the approach used in <banned.h> to move the
> problem to link time, but in the context the only message we are
> giving is "it is banned - do not use it", which is sufficient over
> there, but probably not in this context.  "it was removed - use this
> instead by adding this suffix and add that as the first parameter"
> is the message I want whoever needs to deal with the fallout to see.

Unfortunately we cannot quite get there at compile time because it is
not possible to expand a macro into an error macro with an arbitrary
message. The best I could come up with is the following:

    #define REPLACED_REFS_FUNC(func) func ## was_replaced_by_refs_### func

Which results in compiler errors like this:

    bisect.c:712:6: error: use of undeclared identifier 'read_ref_was_repla=
ced_by_refs_read_ref'
      712 |         if (read_ref("BISECT_EXPECTED_REV", &expected_oid))

What is still missing is the bit of informatino that you need to pass in
`get_main_ref_store()`. But maybe this is good enough?

Patrick

--69eHQ6s8ngK9EsSw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5wqAACgkQVbJhu7ck
PpT0HxAAhqtA1KHFaCXNd8ArXvtRyBGMcJ+MUC/ZdISdc0Vc8tHTdJr6s4aC/YH1
9tEbvThIXnDTbAdFxJtCZF5FFYAkEdozN5ahRzAOiYnzR16k6kvIp3ntZspR1YFw
/hRMRTj6o6LEoF17c9N8juhX8sEDE//i3hKMoJL6eiHHJhdxyEHlyye/PH9Tg9Ml
oPoGNpPZLtuhhzqxgYY9msrwOmM8ITfwSn7yQL474rnyM9p4QYIt1YWKNHyQjyzj
OoxDzq6tJbFrOKo4lxdpyaNpJLelRnDjKISj6HIzF2bBTuzaR/5VYFNZgxrFvjRU
pGmJDdb8YxFZqxTiBJztjA33j0o0mVvi+Kkri8nsXlmr5HcX9q8ojqHmyBJKYuYH
ltyyulW3DvJk9HACze4b1ZlexnUfqkMIMoIBctdH4OZlKNQRPhA35JGrIyqc7esN
ZEERVrC9mPOVnl6ZfL8UWApr4oAbZR/39kFpJTEOZGCS991mHTOWORBHEGASvxgr
8yCIoy6kogMURRt6ERf/TK3ZfHMybaJhuvwiaEqiWCcAtH0/dS1YkwV5rAInCRAl
9s6/v86gK77HgOS1DQQ4UZi8G76vDx2wItDcOf8LmqIDuMCjVOOvKYBaeqRpE6l3
bwJzwy6Y7m3dNOEy+la3dUv2xpl42atTMEV+NuK5KTWyPgdm/zE=
=juqS
-----END PGP SIGNATURE-----

--69eHQ6s8ngK9EsSw--
