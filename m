Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58FFC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 09:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiFTJFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiFTJFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 05:05:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E79DFC
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 02:05:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A988F5C0174;
        Mon, 20 Jun 2022 05:05:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 20 Jun 2022 05:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655715932; x=1655802332; bh=Jl3z/8ZALC
        HXFWzO8rGjo2C34GpQNmTJwtXbGD80lwE=; b=e7cHdZ/ztBRWo8KCqT5h7NStrw
        7xPdhtm56q0sBKwC0VoyZVGpStiwWUP3n04xO2rltQCF0flRJbgJxY6bKx9V5CXk
        JeCUvfdE8o96+J5yD39tE5Z1N8T3B3tM+FDnS+Ro52GvN3xBHkBDY8KP8B2ihVcR
        77zjGlMb0Z3Gg8mYQZK3ADTDq7LuQWBhNJvv1s/R/s+I45HzfnvoVdXlMJYhh8aF
        VdhmqRF1RvFoxa73zeAc4G4s4ejoZaf08BV9YV3xNktExQcyf7AscKRRECAgCHox
        V8fs+ls+FtF3ChxeDPeGQlzI7IqU0e8JeN6ZynrcH28de5tH5rLeqqZSUKUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655715932; x=1655802332; bh=Jl3z/8ZALCHXFWzO8rGjo2C34GpQ
        NmTJwtXbGD80lwE=; b=HeWeLGUb/XkNEJ4zMcQCpUWRy/sPWfMScKx7S4ByE7iY
        H0jBao5jqovqpE4d800IkhAsfT/Wvvtt1icniXVRon1IUSbwxg/o83sozXfFtACE
        ZPHX5Uop/uTtf0ovm/8Bbgl6AM5E+GkepY2KZQ9BakOsQ8zmSr9db65ERTjYpBrh
        9JNZb6g2LRc4IX8DqSjaIDtzgUk+YQbnQ05OR4faooC7NOAqQuXfMujiaUD4OS+R
        LPu5mGUeH5VSNqdiiaP0YNhxWudH2ar+dI2+bDi17jB76iHgqr/owBtEcVyQjakp
        7YR/Whwv9nRsAUiUpyZvxW7RYnwN7vIKgyTUbJ4ecw==
X-ME-Sender: <xms:XDiwYmI550cciuPa-XyBJITdea-bp5HCaG7mIea8wadRi6PAPS5_Bw>
    <xme:XDiwYuKWT4XzAUXmWrJjtzhd5HN_guFn1SUGOTHsZzZS8lWSJcayASppUNLDnxWN8
    FWCMSsREauSQBV6zw>
X-ME-Received: <xmr:XDiwYmuiKlBerL_u4ZU0w3z51EzWODBJNjsb6xB9usdyfRvFkBezblvvKnT7G0p8bBESvbNcH85PRxXm3hS-ALvpv8VHT-nRqLOVN8ES2YTvjXCHk0r9jHuJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetfeetleeiffdvveffgfehhfduleelff
    eujeevvdehfeffiefhhefhleffieejjeenucffohhmrghinhepghhithhhuhgsrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XDiwYra1mjkT2_uHMYMps5VsI5H3mqiRfwtGobqSPIuyE3ajAMN4BA>
    <xmx:XDiwYtamLBqnBs5IM_Sj-P0BmT3RPrQ_JaDubG425T6bZ3NOOZpIBQ>
    <xmx:XDiwYnDpFSV2nx8kbp2Y-Qc82Lb97ygbuEQBnXL46D4Va5q7lw1Xdg>
    <xmx:XDiwYgwZqENMDJPOqFGcluiEn3m3Set7kzNNnHQizqxXQg_60qJ3VA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 05:05:31 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a5c73e3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Jun 2022 09:05:30 +0000 (UTC)
Date:   Mon, 20 Jun 2022 11:05:29 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?utf-8?B?5qyj6Z+p?= <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com
Subject: Re: [External] Re: [PATCH v1] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
Message-ID: <YrA4WdvmN4jrXe/m@ncase>
References: <cover.1655350442.git.hanxin.hx@bytedance.com>
 <20220618030130.36419-1-hanxin.hx@bytedance.com>
 <YrAcrNApaZDngLL+@ncase>
 <CAKgqsWVfjOw-b4hbz1WDH5sevUab_bQVLb703apew3fX7B60rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KPUuNX6o9V2mnBq4"
Content-Disposition: inline
In-Reply-To: <CAKgqsWVfjOw-b4hbz1WDH5sevUab_bQVLb703apew3fX7B60rQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KPUuNX6o9V2mnBq4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2022 at 04:53:47PM +0800, =E6=AC=A3=E9=9F=A9 wrote:
> On Mon, Jun 20, 2022 at 3:34 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Sat, Jun 18, 2022 at 11:01:30AM +0800, Han Xin wrote:
[snip]
> > > +test_expect_success 'prepare a repository with a commit-graph contai=
ns commit two' '
> > > +     git init source &&
> > > +     echo "$(pwd)/dest.git/objects" >source/.git/objects/info/altern=
ates &&
> > > +     git -C source remote add origin "$(pwd)/dest.git" &&
> > > +     git -C source config remote.origin.promisor true &&
> > > +     git -C source config remote.origin.partialclonefilter blob:none=
 &&
> > > +     # the source repository has the whole refs contains refs/heads/=
tmp
> > > +     git -C source fetch origin &&
> > > +     (
> > > +             cd source &&
> > > +             test_commit three &&
> > > +             git -c gc.writeCommitGraph=3Dtrue gc
> > > +     )
> > > +'
> > > +
> > > +test_expect_success 'change the alternates of source to that without=
 commit two' '
> > > +     # now we have a commit-graph in the source repository but witho=
ut the commit two
> > > +     echo "$(pwd)/alternates/objects" >source/.git/objects/info/alte=
rnates
> > > +'
> > > +
> > > +test_expect_success 'fetch the missing commit' '
> > > +     git -C source fetch origin $oid 2>fetch.out &&
> > > +     grep "$oid" fetch.out
> > > +'
> >
> > This test passes even without your fix, albeit a lot slower compared
> > to with it. Can we somehow cause it to fail reliably so that the test
> > becomes effective in catching a regression here?
> >
>=20
> Could you help me find the reason why this testcase passes even
> without the fix.
>=20
> From the execution of Github Action, it seems that the problem always exi=
st=EF=BC=9A
> https://github.com/chiyutianyi/git/actions/runs/2527421443.
>=20
> Thanks.
> -Han Xin

Hard to say, I'm not sure either. One thing I noticed though is that in
your CI run there's failure in e.g. linux-gcc, but the test run for
linux-musl succeeds. Personally I'm using musl libc on my system, as
well, so maybe it's a discrepancy between musl- and glibc-based systems?

Patrick

--KPUuNX6o9V2mnBq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmKwOFgACgkQVbJhu7ck
PpR6Dw/9FijUNL/f2mQ0WCwC+GaGZSrsRJTx8i1Fob5MTpqUP59ekINbMDtY8bMM
yquIDKEQPk9JuDJoUUiIwLjdiyw0YNbvSl2LiBKDnmSY/vqYB3Vurb7UOZq3Ovay
QxOqxB3XaJ9kGEGVuTGiIDFqsZDd5IG2/IHmCAzJ/W9Zoy6WmwQK/BScx+DFTJg4
jCJsOKG2rzskawZSM4lHi/L/eLg6RXZJ5cZl49xAJlUBJwmBDf6A5AnGwXYTZBgw
wznaSjRwRTi1ARBvtoMupvoQU6kFRAyr8TgTUg3mo3plDIu0GIZZsXYWNQOBtGTa
WulK6nzQF0I4YVcJ40lnFX+ARyVlrBJ9q+gL/3gCdWJHCTQLBYUMUWpeedAm4rj0
xBj0gpyMWk7bsFY9B9lXxOcjoiZ5nTLTCjn1ei9q2bOHYjPdl3oT+xwmbqX/5m43
LtxEMqbcqv2hNBwB67dXrjc4iIjn+KTLO30TcgeVVnpzqh8TMQuZIn91/z53QfIB
5Evz1uiwi1yLs+9o7R8+g+zZ91EHk3P0x0VxFJLKQt5E1iIOUPO6le2ErjsqoXUt
IBpIypqMIdDhuDllpaAAMUi5+wN2Asf63Hgp5Fp/Oq97S+TCDpko71VwVtlroNks
MHzzQ8bTPHQj/+qnygXM3qGnJ7bxoqM3Kdwm2SuMiFYzJXJGCW8=
=k9c/
-----END PGP SIGNATURE-----

--KPUuNX6o9V2mnBq4--
