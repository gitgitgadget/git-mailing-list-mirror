Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D6EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 14:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjFOOZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbjFOOZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 10:25:26 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C011FE5
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 07:25:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 319605C011C;
        Thu, 15 Jun 2023 10:25:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Jun 2023 10:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686839123; x=1686925523; bh=Ru
        610nXNPMtZXsWqGLyx/X0Dbeub4ZUk8mpntHhMioA=; b=WQ8hdciJYOG+QQ6fdp
        M+dlIXyADHaOTge0qLEWHA+cvUTWUMk+QrGVW5EmzOOAAXVm424r3EzApnvUmJ2R
        SHpKB6jIXPy7m+VMaR0WQoaYMlqFVExFRNy7pBXLiZInJXj4SYgH0ixlgB82dYeL
        Nv+T+aCGku02ikBLvFYhILRT9DEHnQIsfSoUxEBPH8wIITSZkCyXcZH5M1a1h4mV
        DE6soxFk3twxFNRysdb8W3WFHHHdYDfQ62zxjnFIWXRAvnWGirg10FY92Z6EJ2cf
        x85E4nbccfpZ0G7gQeVoJaHTkPQ4I/PG4ewZLo6A5AANndIWlFgYgtvoR3EJyTZZ
        dluw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686839123; x=1686925523; bh=Ru610nXNPMtZX
        sWqGLyx/X0Dbeub4ZUk8mpntHhMioA=; b=oOhYgLd7faSdZXTfVAA0crD9XhGv2
        Uyv/7vrgmvhyxPXpyuOls0a8Qv3QxH/Nh1wMoaNXsJdexa7pJUS9gy3592r1UCTn
        vH8ZGyyOfAJrL2flcbtOatIgG6YHqkBu+6hwwmtONh6y0ocJPxGB70jgFU2+QRsm
        zeZI40qm50bhoEQqx8lILwkfYNWWfnw7OJMXr599n5rkmkpA0o3SA/5rROWgjGty
        U+gYpIyHDWhJSt32nAqGGkybRX6jszKqcltue2QcwO9q9Mn4njCOIgEOC/jsjxHi
        CVpQ8sJyRm+hiW5BZty/DAAxqkFdWpI/KxFJtMT8eW4gG9G/0mR/OqYOQ==
X-ME-Sender: <xms:Uh-LZD81OU4Sn1CQzGbBRlY_-kkUNYJyoszZrkmtazdzuMBeYT8bJA>
    <xme:Uh-LZPthPLT_lbKRAIWBbHSSvXHI2BRulo5nypnTER4llug48Ppg-Yw9k_PHvSVRz
    qppeVbsPV3LpGYzPw>
X-ME-Received: <xmr:Uh-LZBCSgfIo4pjDCRhpGW9_l88Mcq31_mFP8EiQCGvtpbsFZ5ad-Pf0w_qrjsUSV9_TyhJB0WpNpCPCaYKuiA2I097X_a8tBWqR74DEku25pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    fsredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeejgffgjeevvedvleehveekheetueduud
    fgffevueelteejhedufeevtddvudffgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Uh-LZPf8CHYZ1WKgRr49-EJV7oKAGI8elnfAru_IYRZnbYEhxYxvxQ>
    <xmx:Uh-LZINjEffsnqG-aefut_RvIw6Ku-lKLiTqb5vvhV8PUWELygDSrg>
    <xmx:Uh-LZBmteanvX-8mwp5yZWK2fTti9nDS1dZ0OFASMT3g20fEdAMvLg>
    <xmx:Ux-LZCXhCPHcs_hBv38Jr87qoqGp-Y91DHc5nYjJ8JgTFpzGeCwG-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 10:25:22 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 2d97ff94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 15 Jun 2023 14:25:14 +0000 (UTC)
Date:   Thu, 15 Jun 2023 16:25:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] revision: handle pseudo-opts in `--stdin` mode
Message-ID: <2ot3z23uzikdrgsl7wdqwzpxe4xihkpekqn2rg5y3vfq5yklv6@njx2gf3wwcab>
References: <cover.1686744685.git.ps@pks.im>
 <457591712799719f23fa47e59d5a3c1cd497e802.1686744685.git.ps@pks.im>
 <xmqq352uyr5b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4pzmbvwlnlai5yc4"
Content-Disposition: inline
In-Reply-To: <xmqq352uyr5b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4pzmbvwlnlai5yc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 08:56:00AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >  		if (sb.buf[0] =3D=3D '-') {
> > +			const char *argv[2] =3D { sb.buf, NULL };
> > +
> >  			if (!strcmp(sb.buf, "--")) {
> >  				seen_dashdash =3D 1;
> >  				break;
> >  			}
> > =20
> > -			die("options not supported in --stdin mode");
> > +			if (handle_revision_pseudo_opt(revs, argv, flags))
> > +				continue;
> > +
> > +			die(_("option '%s' not supported in --stdin mode"), sb.buf);
> >  		}
>=20
> The reason why we had the double-dash checking inside this block is
> because we rejected any dashed options other than double-dash, but
> with this step, that is no longer true, so it may make more sense to
> move the "seen_dashdash" code outside the block.  Also unlike the
> command line options that allows "--end-of-options" marker to allow
> tweaking how a failing handle_revision_arg() call is handled, this
> codepath does not seem to have any matching provision.  In the
> original code, which did not accept any options, it was perfectly
> understandable that it was unaware of "--end-of-options", but now we
> do allow dashed options, shouldn't we be supporting it here, too?
>=20
> Thanks.

Good point, we should. Most importantly, the code would currently refuse
to enumerate references with a leading dash, and there would be no way
to work around this issue.

E.g. this works:

$ git rev-list --end-of-options -branch

Whereas neither of these do in the current version:

$ printf "%s\n" -branch | git rev-list
$ printf "%s\n" --end-of-options -branch | git rev-list

Will send a v2 with `--end-of-options` handling, thanks!

Patrick

--4pzmbvwlnlai5yc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSLH0gACgkQVbJhu7ck
PpTLVBAAn9ql4k100PUT5GRlORfThYzJtVzkZhX5NFF4mT3m0IKTuzjjqLigk08x
lFS5kE1maF3WNbqPBaOfKQbgCWnJ5BqXkEFvSrtDN7lpwr9Jw6+Fugz0DQj/dLeU
zZMuql2fJriPEYJdjnki5r7OO++pRPVnYOY1EVGsQoaR+m9D5/WUzGTXSkoMCbRC
tMlK+eq3FbgAxSLblNnugNtUrAcKCgnzIDEfHrh8EC7mW1cb6+qOTpzbVt/xRKPV
yGydcaMcd+T99IADQwhtxaswxC9B5kwYanS3yM4Q3tx0fL74kuCBkGFKsqLxayES
QcYIfDlLNGE2wjrVaeShntyhtJPKC8XmbaBxzPSjJJDvkaABOGEiKMNcUp0tnILb
8LJ7+XIWe2yVJI0aKQNnVyI0iNB6TEfwVUtq/cHn2KKiX15YxZPdqtXWkXuTHTH8
YAgM7YcfpkEZpPK6uxP2QnrPHAEaDN32ENdRkKcDsd1lalXtrQZTnjDo35StQuEb
f4sSEHRRbRUbwXvMSvnXwG68BQT+UYNBVkh/JdI0N7pH8lk15tWKlbw8otnCAo+f
frzZqrLGsLNtU03GQPeY8imvvvlHWM3umyn4tPuVITdTQog+IKt+Eb6vahMJAP9g
Jh+0WOX+JmeLZiN+FFiOwrpdBJQOXlDhOojqKjb0nd6Y101jbsg=
=kYTT
-----END PGP SIGNATURE-----

--4pzmbvwlnlai5yc4--
