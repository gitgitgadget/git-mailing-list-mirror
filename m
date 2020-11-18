Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5EEC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CED2078D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 13:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YZCdJF+E";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RyLRJhZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgKRN46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 08:56:58 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42679 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgKRN45 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Nov 2020 08:56:57 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 375865C01E2;
        Wed, 18 Nov 2020 08:56:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 18 Nov 2020 08:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=SZMvOcs73O2HXPRr4hkmygyijcC
        LT+i0SkO0x0Xdk9A=; b=YZCdJF+Ez3j2EFZspRT87pXzzCYkSUU4Oti/EY3Lcgg
        JBJasOKitYJYNeTeEIi7ZQJKaBQzjI57+2XBLQs9E/13jerczQ9GJtjY8exzK6I7
        5MkdXwijVjhIITNwCXOTOes9Tt4FF6MLvApvZXXemxMk+vmmv7TpAtbOFhnID8lP
        a883j/puyodUMT6Y3GU+aOHeNYmZu/BVG5LLiNbrj3S2gkXds/s1q+lWEeFG6Oj6
        wC6Ld3zi0T8NpwM/WOJhn4gFLImgkDSy1JRzfz+lZkhcsKFhQiLr2YBi1V/WJT+G
        473Ag750CmenjLWhnAVmlSI7GvQRo4vFvdV8pm7gkjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SZMvOc
        s73O2HXPRr4hkmygyijcCLT+i0SkO0x0Xdk9A=; b=RyLRJhZeMxffAZXpNB59WR
        aCtQPxhcahUZjWGe/kp9V6HDb9z4CC8S/+WG8VEVAKAmUHrCGFZU3haCnodGru85
        T2a0CVF5X6HIqfg2KGJCyQmhp1adkB9T1hY73+T/HE0+ntuP90rNaE87PBXIT+WG
        DG8Kj/OrrAs9hVd5j2F27Oik7nJpSBfbnTCX9bBjBosgwT8SVDGOxJiLWKxTYd3d
        hjGJj5UvNXotL0zd+162QIi/V68fkDQxSW9V/tKjyEgaLKHTB9ACbHaTjm2VJnP3
        A7uHCw3k3hS8MaEOUjhL/FeGYsKhP5/6uHAuvjzpI0w4hUEdDlZLRJP8D4GAiV6w
        ==
X-ME-Sender: <xms:Jyi1X5KW82M7xPfZ8vo9FEatAXyOzwRfci6t5_eQ9VsLbNLRAYFfOQ>
    <xme:Jyi1X1JkjBo4ON6xjgMmcEAlPEGVkbqjfWzaEisqgFdQuLLEjxptHRgVMGy6rjtgj
    A94vUMgTEeF2v2QcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefhedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdffjeeiudduleehvdfgteeifeelheejte
    dvteduiedttedvtdffffefhfdvgffgnecukfhppeejjedrudekfedrjedrvdefjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:Jyi1Xxu74P6vBuspZTx1HqKA3IrnvmbOn8IsDO542ZSxVKkHEMfEmw>
    <xmx:Jyi1X6ZYkZkFicgDDKAurhr_khKZMuHI6LHgCuExmcKUIDZvQSFxgA>
    <xmx:Jyi1Xwan0-H1YS03T9eJ5gjjrd29e87Asq_SWEtG_8vqPCZfaAVUxQ>
    <xmx:KCi1X5AAYmeTg59FC1pMOHeN3PrO9n-7RezVLh82d-1fCJDqvbUvfA>
Received: from vm-mail.pks.im (x4db707ed.dyn.telefonica.de [77.183.7.237])
        by mail.messagingengine.com (Postfix) with ESMTPA id 519FA3280064;
        Wed, 18 Nov 2020 08:56:55 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a03475d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 18 Nov 2020 13:56:51 +0000 (UTC)
Date:   Wed, 18 Nov 2020 14:56:50 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <X7UoIjflsJe7xOx8@ncase>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <X7NtovvfE7IjWzie@ncase>
 <xmqq4klo7992.fsf@gitster.c.googlers.com>
 <87d00arczw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QhhaqC5+/5sP7k6M"
Content-Disposition: inline
In-Reply-To: <87d00arczw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QhhaqC5+/5sP7k6M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 02:49:39PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Tue, Nov 17 2020, Junio C Hamano wrote:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >>> I especially do not think we want to read from unbounded number of
> >>> GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
> >>> script cleanse its environment to protect itself from stray such
> >>> environment variable pair?  Count up from 1 to forever?  Run "env"
> >>> and grep for "GIT_CONFIG_KEY_[0-9]*=3D" (the answer is No.  What if
> >>> some environment variables have newline in its values?)
> >>
> >> You only have to unset `GIT_CONFIG_KEY_1` as the parser will stop
> >> iterating on the first missing key. More generally, if you set `n` key=
s,
> >> it's sufficient to unset key `n+1`.
> >
> > Yes, but those who want to set N keys would likely to be content
> > with setting 1..N and happily forget unsetting N+1, and that is
> > where "how would one cleanse the environment to give a clean slate?"
> > comes from.
>=20
> Not as an argument from whataboutism, but just to note a bug/existing
> prior art:
>=20
> Nobody in this thread has mentioned GIT_PUSH_OPTION_* which works pretty
> much like Patrick's suggestion, and it looks like --local-env-vars
> misses those:
>=20
>     $ GIT_PUSH_OPTION_0=3Dfoo GIT_PUSH_OPTION_COUNT=3D20 git rev-parse --=
local-env-vars | grep GIT_PUSH
>     $
>=20
> I haven't tested this, but I expect there's a bug where a push hook
> itself does a local push to another repo and that repo has a hook, that
> the push options are erroneously carried forward to the sub-process.
>=20
> That might also be a feature, depending on your point of view.

I didn't actually know about it, thanks for pointing it out!

If we're going to use the same `_COUNT` approach, then I think the
issues which were discussed would mostly go away. No gaps needed, no
requirement to unset `$n+1`. Any properly behaving user would know to
set it as otherwise the written code/script cannot work. Also,
git-rev-parse(1) wouldn't have to dynamically adjust based on whether a
previously existing gap was filled with new keys or not.

I'd be happy to pursue that road, but I'll wait for some feedback first.

Patrick

--QhhaqC5+/5sP7k6M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+1KCEACgkQVbJhu7ck
PpRboBAAgDgxLOY3tfFJgPAodwnRtBihq9uD/NEKg8e2qOugxd43qmouOKNOge0o
2FJmYVXafuFbD+4HdOR9JhhmYKQiSn/lMXo6Ir9lWqfLoCEV7/aJtQsPHxZUquaw
sJmQyb47k2x4ne9HoPejTPmAoWJiq94sYEn9npiU4Jp7IptMf6RnK7garcMVbMNx
HGqzhem7UHDBvHIUqQ5MKMWhd2NB0mf+sHOBP2swXZZYUSv+wLrede5bkMVwLEwI
y0Rx0ZvBJ5F9e6U5y6UZ2sDDBhpJbUQUtbldi/j334AXmhH78Ko7HIqobb0m0MTN
qL829NL5OPpP1b+GBcznfnj/KeqNS9WE9VgCDD/OLtvWexQLVqkNYcs0mD1eQjEM
XvDLh0eL5ciUg3dEdlxsoKmDP1openlGla+ZCfRvz8YAaIfKDDQDwpelAQlrHeI+
FN+5fRCJfOHgg4ysPMgSYxWeTRGC+FrKhLUc8S/hXNUDFipKIiTjaGR6NmMoDHFX
tte2WbgujFiw3EYMxrblWanJj4H8Qc96Wgc9nGo4fi63e9yqs4GwGS8Z2kCwnaEp
2/yU+0+4P/XCnBKkP0TzlnktLafICTX+DUJ/l697lx4LeQFpBsrqNbQhTtq8vejs
mrCLoLz3/qcNQo5VY5/Fw4MM2G0NS8MXMERPFk/+KZDUsLTW/50=
=SOJi
-----END PGP SIGNATURE-----

--QhhaqC5+/5sP7k6M--
