Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06D8C7EE2A
	for <git@archiver.kernel.org>; Mon, 22 May 2023 09:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjEVJAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjEVI70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 04:59:26 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A527CCE
        for <git@vger.kernel.org>; Mon, 22 May 2023 01:59:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3CCC63200944;
        Mon, 22 May 2023 04:58:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 22 May 2023 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684745937; x=1684832337; bh=ws
        a7UkyJPaJlZQWBzo9GP9qyuBA7keYmdGtY+Tw++ns=; b=myIwNRx/9uYzpz7eyC
        H2rUVOaAcAte5XylOPDY+SW2QpldYFd5bSVYovM8punXPxF2L/FIEB46B4o8bT9c
        usR2ssdo3UIequkZpRqVizNPTsT36IUfuqr8I++j9NjBdJRXxdpxi7sb/Z9yF0i7
        DGl5p7Z3YDOBI5mOwE2Y3T6ilgjGQmvbjhzFh+Pe3PPUwFJ/B591HlYF16uQvS90
        gzp4qDHe6rovlfZ4FIUfdyWE0RMoLXpwDy3iN20Ga53tuvILATH9Tr9VviRNjJuC
        gfQuly/uudnMHh02NRPVI8u+rPaTh8oWAuOYNTTpWMDy8d2j8rOvyqTOQ/J5F2Dk
        o3NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684745937; x=1684832337; bh=wsa7UkyJPaJlZ
        QWBzo9GP9qyuBA7keYmdGtY+Tw++ns=; b=CWt2V3Xqr18pghgQFyWvDU4VbtEOC
        Z3G1mR5EyEXMospzhf/4sr9KQaSFLJSDjC7NyC+lRBBDkclexqdz9KACl6j+VXhA
        1gtGQbz5oLcKGPQ5LEmt9uSwdkETT6hI/RW9glWuau8U09XcphmkJgdQMMk6RezF
        RD0471iYe2+CIgQgt1bOZW43v6tcCXmsvELMtW9BuNHjZxTeyPBZDNVRoRbV8ztW
        B6gsqiwZhZGHiPPXRsEno5C6rgtt3/etgSOKC4vEbrqguxC2nOvA+BNnvmKyT48W
        up3/O9kYzrIc+68wB2YjdVpLe/Q9YC1e82UgYuq+tXUbN5UBk5AdFotjQ==
X-ME-Sender: <xms:0S5rZOWjG9WWepEWQUBQCPWNqPfm4wb7I9INk2nmhEkGa4Om_OeogA>
    <xme:0S5rZKmiFocxrIv4ckEs9A78rpf-ebVAjH_2Wt90VGwion5wvCn4ik6iKoZj0yU6z
    m32gZtK7UW79cZWVQ>
X-ME-Received: <xmr:0S5rZCZw81MAzTdJjIb2Ec3vpdKqu4IXYc_zCVtFJpFrJOruBUkX1NnHaQl-t2uindxzzmOXZsuUg-KNyQInM7MkySwpJADMA60sknxmwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:0S5rZFVQVBE-thUaK70kiNgKf1H1jYWD66BKBH2gVymivYkvUaYg_w>
    <xmx:0S5rZIlWsiFpEhpH-_gNbQS3uht9s4v9kdhVNQhJosS7lsBbjnFCJQ>
    <xmx:0S5rZKeK4KcD06ec0r0TTDZeLWZkD1bQ6sRjFIY8s0x4fY4bZDzlwQ>
    <xmx:0S5rZPsr1Py9bo3s7Tl58eqdWwegj90l447UyBxMa0G97ym70BDTeQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 04:58:56 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f06f4899 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 22 May 2023 08:58:20 +0000 (UTC)
Date:   Mon, 22 May 2023 10:58:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] fetch: pass through `fetch_config` directly
Message-ID: <ZGsuy6T_yiK4qxxJ@ncase>
References: <cover.1684324059.git.ps@pks.im>
 <b09f21dff786780dfb0ae71efd9a0cabe31c1e0b.1684324059.git.ps@pks.im>
 <20230519001803.GC2442034@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pTlbHrJtaHgIa02g"
Content-Disposition: inline
In-Reply-To: <20230519001803.GC2442034@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pTlbHrJtaHgIa02g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 08:18:03PM -0400, Jeff King wrote:
> On Wed, May 17, 2023 at 01:48:51PM +0200, Patrick Steinhardt wrote:
>=20
> > The `fetch_config` structure currently only has a single member, which
> > is the `display_format`. We're about extend it to contain all parsed
> > config values and will thus need it available in most of the code.
> >=20
> > Prepare for this change by passing through the `fetch_config` directly
> > instead of only passing its single member.
>=20
> Makes sense.
>=20
> One small nit:
>=20
> >  static int do_fetch(struct transport *transport,
> >  		    struct refspec *rs,
> > -		    enum display_format display_format)
> > +		    const struct fetch_config *config)
> >  {
> >  	struct ref_transaction *transaction =3D NULL;
> >  	struct ref *ref_map =3D NULL;
> > @@ -1639,7 +1639,8 @@ static int do_fetch(struct transport *transport,
> >  	if (retcode)
> >  		goto cleanup;
> > =20
> > -	display_state_init(&display_state, ref_map, transport->url, display_f=
ormat);
> > +	display_state_init(&display_state, ref_map, transport->url,
> > +			   config->display_format);
>=20
> If the point is that fetch_config may start carrying new information,
> wouldn't we want to pass it as a whole down to display_state_init()? It
> might eventually want to see some of that other config, too.
>=20
> It's presumably academic for now, and it would not be too hard to change
> later if needed, so I don't know that it's worth a re-roll. I just found
> it especially funny here since the purpose of the patch is to treat the
> config struct as a single unit.

Well, I decided against passing in the full configuration as it feels a
bit like a layering violation: the other code really is about the fetch
itself, while this code here is only about display logic. So passing in
the `fetch_config` felt weird to me, even more so because we continue to
only need that single value at the end of this series. I do see your
point though.

Given that none of your other comments require a reroll I'll leave this
as-is for now. Thanks for your review!

Patrick

--pTlbHrJtaHgIa02g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRrLsoACgkQVbJhu7ck
PpStnQ//elGR2GD07GSePLjCcMXcCkupTSqCA7zAyaTJTFuNQvVS5tAa00c3zp13
v3BOi8Olvqyk+AoVWA1gNtxFbBWompXhX68KBg5kSDU10O36Y7+9QAD+dcoUco2Y
AD4bYItkZpr/b4jwHlc443ENbJt0Cc58GFL0GFUoBYyFTuC/9q6e1fBIXET9UAqj
Cgn4J9krTiyCgfqiEkHqorXRxLyBTOCSCkt9JCsi9bzcpN7CDDhRVvWrvs0mNT7l
1924fTZGH5mQ/LrMFw0GgDDBZbwJ9rMlXOzxUvEgy3O1yaj6ZRhMoMEqaZ4G7onb
35YtM0qh2k1HsK4gPh1D4fa+qAh7Oe6VuN6YCaBKBfiCY50GgD0Q5Mqg69+uJra2
ZHQ43p5Se7df815UHW3195Qx2n16j2IWNPbM2hgtTRMPU9WADpeurUE3cqZKRiso
k4Bk/TGvU/R7KUPuGmKiYDZVhmD3O3KUkBQTro6pjAcMWWPhabeXGac7DbjWw3mg
b69odLsQF+2MW3M8hU7zrhRoBM/PCISdFipUKzmnjPtgY58a0I/l0oEueTYHdYoX
nC0dR7gghp4mnHpJ2vXjfsbDFg9SyCWA7LKMcvNgKnnO+KFSv5Q4PbmA5iL7fFLZ
HEbx5h1+YYpC3wFoiYbVjS8KFSwF31NsTR8yyeyyRzGV5fza+sM=
=n3/c
-----END PGP SIGNATURE-----

--pTlbHrJtaHgIa02g--
