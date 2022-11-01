Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661D9C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 11:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKALyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 07:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiKALyU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 07:54:20 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA613D6C
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 04:53:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FB395C02D9;
        Tue,  1 Nov 2022 07:53:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Nov 2022 07:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667303625; x=1667390025; bh=qeMlNkzFeF
        RhtJCBM+JlUtVW+Ywz6YMCaCRNtacbo2I=; b=pZDQ3O4KMUNM6B9t6SXz65eONQ
        tAcn/AqPxH0XONcMa7Q2JYbnOxysLyHZPF0vzuqzgfcsyptJmfEa2mgbwszDpiOj
        OAy+NZjLv/scrkrDTVqOv0rMAR0IplahSsvJUzX0tpUBiFcD7FpLJd9Np8W8UlkR
        cJ322SQ5lxZF4MugfTF/SUU0ExTKTcDtLXm+t1SeSnqRIV6BgHQ5yfWJadHy+S9b
        yjhwcynIduUFW7+pyRO/QtbobV33LcweWdiond6xaMDKbdfn20sX7oM8MZrAUwtt
        HvINWbrujwvQ7kiY1FCCIlshxCr+VYRIzrZVLmM035sew6Sjgy4nGUSJMaKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667303625; x=1667390025; bh=qeMlNkzFeFRhtJCBM+JlUtVW+Ywz
        6YMCaCRNtacbo2I=; b=ke1xVVqYuQYU3WaZLI4yvcSbFO8uwf+tjMLEjAJa3lz+
        mwQAf5XSOb4gZCDorg4YM5HEORS3+13gYYgtgP7x1AKidGs3xP6h/Jx5tHFKHly8
        hd3oHNtOpWzGLYO4dGl4bkA9tMGYltdD4A3yukLLt72JjkjDAXUzqqDPCTESLtO5
        93nBQcKEBE/bEsT9fz0xJkckl/Gx6D06F6gDjz6iHZhz4X5cN2UMPwQUVrU4DRod
        7YwO3nRnobLgC5maw4laAWa1h8lNhi97sJ10NnKukhU2WuD5BAax7Mmr9cnZGLx+
        sg911fpJ1pTBtOhW6OhBbnytqMcFHpYHj61mC3/jhA==
X-ME-Sender: <xms:yQhhY3BHMZ78L9wySgQVMa3bkrYtP4q1qL8aFc6cB7Yj9Wx2R-mJqw>
    <xme:yQhhY9gmYORbZ3is7ExaUVYMAAy_MJ3XHblKJfHqDzS-TICYdsn8VSgeZ4Ph-eLU0
    WHd4UBrDINQMOX6rw>
X-ME-Received: <xmr:yQhhYynyVrbjaT4LSN7HkvAgk4BNisIoHWMwqrdmQZa36Jd9ZjkggksxkzshdpkqqEI1MBk57XmJ9d4-JlIoPTJjwJcEP2C-aDfN1ITL7s4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudehgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yQhhY5xdRdGdHynviqMXw5r5gLnXQOoC--Mwz8wJxsfK6IcwjncjjA>
    <xmx:yQhhY8THtjzeWaSlFeDt8ZBjr5Iqyowdlx-GLmGzGJjxubH936o7lQ>
    <xmx:yQhhY8bC47KB94i1LZAx7IkNO5r1BdgV-S1jBjvTtjgwp0YPY_JYMA>
    <xmx:yQhhY17L1iBv_1La09ZxzVk19p4vh1VUhYOV0NwEB4q10nldhsdGsw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Nov 2022 07:53:44 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 93a63b12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Nov 2022 11:53:29 +0000 (UTC)
Date:   Tue, 1 Nov 2022 12:53:42 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y2EIxp+YM0Bee79v@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
 <Y17L0IjELU5QlOPL@nand.local>
 <Y1/fm1prlAs3U1NE@ncase>
 <Y2B2KeYX5X9vp+cf@nand.local>
 <Y2DI0OL1bXhPS/JD@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DgKHLkr8seXDHof7"
Content-Disposition: inline
In-Reply-To: <Y2DI0OL1bXhPS/JD@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DgKHLkr8seXDHof7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 08:20:48AM +0100, Patrick Steinhardt wrote:
> On Mon, Oct 31, 2022 at 09:28:09PM -0400, Taylor Blau wrote:
> > On Mon, Oct 31, 2022 at 03:45:47PM +0100, Patrick Steinhardt wrote:
> > > On Sun, Oct 30, 2022 at 03:09:04PM -0400, Taylor Blau wrote:
> > > > On Fri, Oct 28, 2022 at 04:42:27PM +0200, Patrick Steinhardt wrote:
> > > > > This strategy has the major downside that it will not require any=
 object
> > > > > to be sent by the client that is reachable by any of the reposito=
ries'
> > > > > references. While that sounds like it would be indeed what we are=
 after
> > > > > with the connectivity check, it is arguably not. The administrato=
r that
> > > > > manages the server-side Git repository may have configured certai=
n refs
> > > > > to be hidden during the reference advertisement via `transfer.hid=
eRefs`
> > > > > or `receivepack.hideRefs`. Whatever the reason, the result is tha=
t the
> > > > > client shouldn't expect that any of those hidden references exist=
s on
> > > > > the remote side, and neither should they assume any of the pointe=
d-to
> > > > > objects to exist except if referenced by any visible reference. B=
ut
> > > > > because we treat _all_ local refs as uninteresting in the connect=
ivity
> > > > > check, a client is free to send a packfile that references object=
s that
> > > > > are only reachable via a hidden reference on the server-side, and=
 we
> > > > > will gladly accept it.
> > > >
> > > > You mention below that this is a correctness issue, but I am not su=
re
> > > > that I agree.
> > > >
> > > > The existing behavior is a little strange, I agree, but your argume=
nt
> > > > relies on an assumption that the history on hidden refs is not part=
 of
> > > > the reachable set, which is not the case. Any part of the repository
> > > > that is reachable from _any_ reference, hidden or not, is reachable=
 by
> > > > definition.
> > > >
> > > > So it's perfectly fine to consider objects on hidden refs to be in =
the
> > > > uninteresting set, because they are reachable. It's odd from the
> > > > client's perspective, but I do not see a path to repository corrupt=
ion
> > > > with thee existing behavior.
> > >
> > > Indeed, I'm not trying to say that this can lead to repository
> > > corruption.
> >=20
> > I definitely agree with that. I have thought about this on-and-off since
> > you sent the topic, and I am pretty certain that there is no path to
> > repository corruption with the existing behavior. It would be worth
> > updating the commit message to make this clearer.
>=20
> Fair enough, I can try to do that.
>=20
> > > But security-related or not, I think it is safe to say that any packf=
ile
> > > sent by a client that does not contain objects required for the updat=
ed
> > > reference that the client cannot know to exist on the server-side must
> > > be generated by buggy code.
> >=20
> > Maybe, though I think it's fine to let clients send us smaller packfiles
> > if they have some a-priori knowledge that the server has objects that it
> > isn't advertising. And that can all happen without buggy code. So it's
> > weird, but there isn't anything wrong with letting it happen.
>=20
> Well, I don't see how to achieve both at the same time though: we can
> either limit the set of uninteresting tips to what we have announced to
> the client, or we allow clients to omit objects that have not been
> announced. These are mutually exclusive.
>=20
> So if we take the stance that it was fine to send packfiles that omit
> hidden objects and that this is something we want to continue to support
> then this patch series probably becomes moot. Doing the proposed
> optimization means that we also tighten the rules here.

I'm wrong and you're right: we can do the optimization to limit the refs
we use but still let clients send objects that are hidden. I didn't take
into account that this is merely an optimization that we stop walking at
reachable tips. I'll reword the commit message when having another go
and will likely do something along the lines of your proposed new
`--visible-refs` option in v2 of this series.

Patrick

--DgKHLkr8seXDHof7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNhCMUACgkQVbJhu7ck
PpSIZw//bTDvobOB82DvYdolLOuNEWUAkOBK/Wj3sE78DtNfcpU1BidiUjoPeeTc
WJhPchjWfHy+R+cAr6QpKJypkpmj1nuosm/kV6jq8Nj6+TijsV+l325qjkgPtjam
e8LiTFQ0mBq0txsKEJUX+bHzaDqidPqn/FonIoIjmPZ5qyw5mj8NZYI0h+zo48B7
+KR2CJFCG4WARG2j3CkWy8cms4fSVEnhI+1CaNbv08LGrjMt+lB1A7nmQDXKEGxg
aw+5ZNf6uGV9MJOjMKtGmDW7OYzCgBzkZA1OFv3xRaGWij69+mlYO6pmkXMwtu7u
h7eVVUsNTOO6fJEeyOaymP/xVixKq5DkeUQIpRRPCiq4koit61ColVYtAMPqMUTD
1+uzjHlRKx6XvQfJj0189V3M1emgNPCbuPWzfS2t9WBBvFNsraSkIzgjbs5MdU2Y
wb0WcOY6TnO8fBaXGEXwUkwzo0D6vTm2+uIqd/dSLkLF3b6i9TxScivu/yvIBVmq
+EHo2a2sYo/tafNwaaLZWneLJjIGZDMOBjlaRhu8AFZYNirz1O1i9DEimhHl+GdO
Dl5RKyrxApLUJoQlr55mNXixjShZlybooUqORHesSE73LtPKqpQ5coT3v0AXIMRi
TddxouJafj2x3yUakv8MI/iSfhNWIZ4fW1hTL6qRBChdV8z4mWI=
=TGN2
-----END PGP SIGNATURE-----

--DgKHLkr8seXDHof7--
