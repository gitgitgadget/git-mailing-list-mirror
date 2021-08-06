Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B57C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 06:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1F660F01
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 06:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhHFGBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:01:22 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33445 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhHFGBV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Aug 2021 02:01:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 140C63200929;
        Fri,  6 Aug 2021 02:01:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 06 Aug 2021 02:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=opzHEmM7cVV2xFVvVk8ckOs4rwY
        nacRnTxiR6LT4lBA=; b=T2ArSl0bZbZIfs1mOwlsiG+53SPeVgQ+Yec4pXSIg1f
        iz5J9G8jDQ2nY65OCVKPwdXJxnM8N5w4SaDnhc7KYaE8sQ6tucOzHaBMGI5DujVR
        bc+LiHmXuuFDh0AKHNtnyhplzl1mteMunjtsWWpQmMO9VKoFUjGmRWUgawJ3BEon
        kRfkvrrB+c9Z2PRvLedsi1ECDp7yZt89GAULOZN9yUSmKepuuYpiyeHjqS9zgsbS
        row9il6e6dIK89AjtDJMUTmd+N3ga6MS+ufASWEJmRiaqTIyTXO3aa470D5joeyK
        3i0svrx2+uNoik2+FDT2gUubqDiMWjBLIT+lCkqd37A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=opzHEm
        M7cVV2xFVvVk8ckOs4rwYnacRnTxiR6LT4lBA=; b=I5CW9ZbGlIyLx7z5pF/57e
        YEvJNt2nn2cnLxT/akIFiakM8pPdDf3FiU6giKw5lJumpvc2fiqr9O29GmGGeT/b
        Gm9apigdIbO53eFaS8SNjs+w/Sd1ly8l8CFzuE1M2AgnGRMjhBoHwVlUWYJ+IwoP
        HaYtVErj+Y5YQtpyA8jHZUiuCAgbCijlzW13GKqrknw08xR59Q4nwn7OBxPDCekk
        CVvC/Lxknq2tD8dIV0ym5kgmKBAqQ+1nrEeqnIxclQvFQrwNgGR6icYYOHVpkqI9
        KYPAqIHg6HIlRx9dhIVDwDmGcFbIOdW7KVV17ssUCZ9n2fCkD3IMHhNEWfJL0w2A
        ==
X-ME-Sender: <xms:INAMYQ3ybH1aksMekrUP31gpjg007oC0fRMxQCvsj6EZz_yB0WZGpA>
    <xme:INAMYbHZzPqQykfbcCMhywGwVoZul4aTR3fUmji_s1lP94vNMc8iyJkXPMeBf4RJG
    Lv7mYh2oa_Kuv2zJw>
X-ME-Received: <xmr:INAMYY4OWvkQ8AA68Ot0FTFUac-JJUT0mm4H_H-o_qbfYujE_UxLVVXE1FWFhB5ZCkgh6lkyAKAgbIzwN7vNxoeA0ly2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedtgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:INAMYZ0yN-gbc6lJzGXuyZ9iRpYTdICzjfdTMBzf9jHTat8KCxz9Hw>
    <xmx:INAMYTFf-YFb7mjUwd-WUsXKhWTxvZRggJcnMTak7bu23nQlc1_8sw>
    <xmx:INAMYS8qxiLUuQqzufERzHaUsRnt4uFm2Lhe1Ku9hAe5WixPDKooDA>
    <xmx:INAMYY703us-47yRlohIbcaZSJYhW7qCmYwsrZNw2J0cXkiRYsHA9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 02:01:02 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8623dd07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 6 Aug 2021 06:00:58 +0000 (UTC)
Date:   Fri, 6 Aug 2021 08:00:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 2/6] connected: do not sort input revisions
Message-ID: <YQzQGVQdh4t0uZ3N@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628162156.git.ps@pks.im>
 <9d7f484907e2bd2492e6676238579e9f0c6ed374.1628162156.git.ps@pks.im>
 <xmqqfsvnloju.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v0pxknTkWhXXJnVV"
Content-Disposition: inline
In-Reply-To: <xmqqfsvnloju.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v0pxknTkWhXXJnVV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 05, 2021 at 11:44:05AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >  			revs->unsorted_input =3D 0;
> > -		else if (!strcmp(optarg, "unsorted"))
> > +		} else if (!strcmp(optarg, "unsorted"))
> >  			revs->unsorted_input =3D 1;
>=20
> This is --no-walk=3Dunsorted; could it have been given after --no-walk
> or --no-walk=3Dunsorted?
>=20
> The application of the incompatibility rules seems a bit uneven.  An
> earlier piece of code will reject "--no-walk=3Dunsorted --no-walk" given
> in this order (see "And likewise" above).  But here, this part of
> the code will happily take "--no-walk --no-walk=3Dunsorted".
>=20
> Of course these details can be fixed with more careful code design,
> but I wonder if it may be result in the code and behaviour that is
> far simpler to explain (and probably implement) if we declare that
>=20
>  * --no-walk is not a synonym to --no-walk=3Dsorted; it just flips
>    .no_walk member on.
>=20
>  * --no-walk=3Dsorted and --no-walk=3Dunsorted flip .no_walk member on,
>    and then flips .unsorted_input member off or on, respectively.
>=20
> and define that the usual last-one-wins rule would apply?
>=20
> Thanks.

Wouldn't that effectively change semantics though? If the user passes
`git rev-list --no-walk=3Dunsorted --no-walk`, then the result is a sorted
revwalk right now. One may argue that most likely, nobody is doing that,
but you never really know.

An easier approach which keeps existing semantics is to just make
`--no-walk` and `--unsorted-input` mutually exclusive:

    - If the `unsorted_input` bit is set and `no_walk` isn't, and we
      observe any `--no-walk` option, then we bail.

    - Likewise, if the `no_walk` bit is set, then we bail when we see
      `--unsorted-input` regardless of the value of `unsorted_input`.
      This would keep current semantics of `--no-walk`, but prohobit
      using it together with the new option.

Patrick

--v0pxknTkWhXXJnVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEM0BgACgkQVbJhu7ck
PpTgWw//Tys1FUcXenCKtB/8gBsjHrZiWdlsnh28XIAdQU13zByBYp9v/C5rWtPt
aWQ+cOSDi+RD7FIEV7Vsma5d72jKedH5OEvMbqoioy8CGCBsySHgQnEUlf8nzyOA
RdFAaDWElzNoVPgJa/jn6DBfSrnwa0Ir+QWAJvHhlYM9HDaNckXp3LvsFWfeyaLZ
/0/MoFrABdeZRMo0AQ6SXSbsWMiw5DQKV8RNSR1zbxHKhLPF/AZkU+uPHG/uQ97m
kP9b+prcxQ7FN2Iq30n1H7KyshCEADUPRrcdxfDuoZ2vNZeQd60nE/EMXZkw0Mji
ZmGcQHLn31rzrcZDobX8mXeuGzeXDlu0uOrWXSEMfFlUuQCtFYK/a+DQ2Pyt044W
JeNyqyMgyiMIasXOebq1h/1sJ4XkLRehZ52VGbMo8qMwcI09APSTbN3sI2e++TBL
XleWbXt8veTiPF2KkBc4ADs0pIdyGpZiV+QebQNxrJZYc6tUyO8H+wjWpCDTx6R7
HLoGmLwwTqk6t86AIrYgCYgfZ4jVsjkEbRbBlEjPnvcRzZo9NvbJ9igraEWsB/s8
JAas+IY7rbXWtjdqeUQX0wmhq3SQHRO2pVAE40o1ZV439FB4vf/ZZk/2C2okSCju
mRh7sgQvuwIVZqm8lwwyVOlf7JBkxE+2/V2hccYJfoROUTbnQ8I=
=0jX2
-----END PGP SIGNATURE-----

--v0pxknTkWhXXJnVV--
