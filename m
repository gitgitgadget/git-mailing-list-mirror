Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D006C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 12:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiBQMGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:06:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiBQMGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 07:06:43 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC95F7E
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 04:06:29 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 91B233201487;
        Thu, 17 Feb 2022 07:06:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Feb 2022 07:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=6Sh9Vt/UpsqiRcGy1WxIDNTjr5UozXlZOhqPLJ
        ocFT0=; b=ZxRwiPBVPALwPI/xvjxpJdgSJZUM4X9GqcVayf1eK02f3Gv0afojws
        HcGD6TeGys+xz1AS6RLr+7amjtdSv3QNP0KU1nZHp8JVFWGXhRj/G1FWsCNvrtLD
        sa83F+Ju6Xiir32pLots+PJcHSdcuf0PRY++ysXZWMpgENDkZD2hX01fRqX3Cz0C
        eQ4wORiMnCAWUCBMiGafXIukjEj7QXHAgF8hjhpXznCvIoEAVtWxzft1LpVUeDgu
        /1RBHAKwTHYz1+E//Io+dOOGE4ByknJjn6kOOoslvjxOMU9nDR4xNL20Jemkca4D
        6HUpkVZCHLwwuV1utJCoPhoqHW/0UwEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6Sh9Vt/UpsqiRcGy1
        WxIDNTjr5UozXlZOhqPLJocFT0=; b=Obh6xld7nY2dZzPtpDTseTM7gviZwry8j
        DYN+YCXFkOtyJqiXZuZp/l9Sn0ca6uZ3o10QYbSAY/4Hc70wmNBXun+1vtWifhAP
        sf3RQFyrAPSM4XBbeXyrnBP7CDdbQpaujyQmEBX2WisWNmYYzTfopTlSauJmQ/Fg
        OjNHhPxBHW67NhLgBJRrRUYi1hd4BJpwKSTNWBSe3KjCvkCjrFqey0rvxNcTsBF0
        j1PQWaw5X9N+OvHi19JhtvHKQH5HQDO+EhHkBVYbNK2LxHaVUshqcud99+HDRlRx
        L/1rl9y7ZqCO1sN3QaZSSBjYFQ1osCgf8P33KbtIQZGlrBv+080IA==
X-ME-Sender: <xms:RDoOYhCTToj3uYyaB0QpKq9_gNFEnBtCSlI-0uDZW79gVq1nB5U_4Q>
    <xme:RDoOYvgZS1wn7u8bCoetxBTZw3bGyoDFq8z6orX1PEy1FdJ5Ve23gcK6ZFJkQthww
    outRFyC9HdFXaoUyw>
X-ME-Received: <xmr:RDoOYsk2T70nCS49hbmFloUAU3xU2CgpR1yVLCQODWh0fukd3NP5pN_NyI1KVJoqJj-0YT6CXdE8Mpp8dQCg2_jgqvlLfqhdPnQzL7Fqa-zuI8fCwr86Zhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:RDoOYrxVItrzrs4xdg533HO35B9aIjyu9qy3Bcz6uY2nUHxOJtfMqA>
    <xmx:RDoOYmQtOQdWyMFFYfOG48v95ovnKZU0vbNL2_E2dU4FJv4oGTEG5w>
    <xmx:RDoOYubHNoPEB7GQgUOYjj1szdGcuz4wFjtGm2I9YQ3dw3z5buudWQ>
    <xmx:RDoOYv4Dl4Q0fcUNUeYYxOEX0GIvoceSQ7rLklIOn12Buj4kzPYkfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 07:06:27 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 553026c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 12:06:26 +0000 (UTC)
Date:   Thu, 17 Feb 2022 13:06:24 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] fetch: make `--atomic` flag cover pruning of refs
Message-ID: <Yg46QLSB5VFnK/M5@ncase>
References: <cover.1644565025.git.ps@pks.im>
 <682f16117b743bec59c533e15ae5a88d39250222.1644565025.git.ps@pks.im>
 <CABPp-BE9_RVu28C-6QuY2qDYaEExeqCqph0e37DgiFtPZRHY2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dBzaMLJtBr7lXq6Q"
Content-Disposition: inline
In-Reply-To: <CABPp-BE9_RVu28C-6QuY2qDYaEExeqCqph0e37DgiFtPZRHY2A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dBzaMLJtBr7lXq6Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 05:40:19PM -0800, Elijah Newren wrote:
> On Fri, Feb 11, 2022 at 12:25 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > When fetching with the `--prune` flag we will delete any local
> > references matching the fetch refspec which have disappeared on the
> > remote. This step is not currently covered by the `--atomic` flag: we
> > delete branches even though updating of local references has failed,
> > which means that the fetch is not an all-or-nothing operation.
> >
> > Fix this bug by passing in the global transaction into `prune_refs()`:
> > if one is given, then we'll only queue up deletions and not commit them
> > right away.
> >
> > This change also improves performance when pruning many branches in a
> > repository with a big packed-refs file: every references is pruned in
> > its own transaction, which means that we potentially have to rewrite
> > the packed-refs files for every single reference we're about to prune.
> >
> > The following benchmark demonstrates this: it performs a pruning fetch
> > from a repository with a single reference into a repository with 100k
> > references, which causes us to prune all but one reference. This is of
> > course a very artificial setup, but serves to demonstrate the impact of
> > only having to write the packed-refs file once:
> >
> >     Benchmark 1: git fetch --prune --atomic +refs/*:refs/* (HEAD~)
> >       Time (mean =C2=B1 =CF=83):      2.366 s =C2=B1  0.021 s    [User:=
 0.858 s, System: 1.508 s]
> >       Range (min =E2=80=A6 max):    2.328 s =E2=80=A6  2.407 s    10 ru=
ns
> >
> >     Benchmark 2: git fetch --prune --atomic +refs/*:refs/* (HEAD)
> >       Time (mean =C2=B1 =CF=83):      1.369 s =C2=B1  0.017 s    [User:=
 0.715 s, System: 0.641 s]
> >       Range (min =E2=80=A6 max):    1.346 s =E2=80=A6  1.400 s    10 ru=
ns
> >
> >     Summary
> >       'git fetch --prune --atomic +refs/*:refs/* (HEAD)' ran
> >         1.73 =C2=B1 0.03 times faster than 'git fetch --prune --atomic =
+refs/*:refs/* (HEAD~)'
>=20
> Very nice!
>=20
> [...]
> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index 93a0db3c68..afa6bf9f7d 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -349,11 +349,9 @@ test_expect_success 'fetch --atomic --prune execut=
es a single reference transact
> >         cat >expected <<-EOF &&
> >                 prepared
> >                 $ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-d=
eletion
> > -               committed
> > -               $ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-d=
eletion
> > -               prepared
> >                 $ZERO_OID $head_oid refs/remotes/origin/new-branch
> >                 committed
>=20
> Up to here this is just what I expected.
>=20
> > +               $ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-d=
eletion
> >                 $ZERO_OID $head_oid refs/remotes/origin/new-branch
>=20
> But now scheduled-for-deletion and new-branch are both listed again
> even with your fixes?  Is this some peculiarity of the reference
> transaction hook that it lists the refs again after the
> prepared...committed block?  (It may well be; I'm not that familiar
> with this area of the code.)

Yes, the reference-transaction hook is executed for each of the
"prepared", "committed" and "aborted" phases and gets as input all the
refs that have been queued for that phase.

Patrick

--dBzaMLJtBr7lXq6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOOkAACgkQVbJhu7ck
PpQo4g/8DPwv3wH3LdGZMXMyMFYj8opqR0s4qE9rJ4bdDgO1iN1qydSsjWW12lhp
rcMDUZhToUpAXLEtNEpnbKnm2EKMO21FYZV6JlNA3ykkjzp3Ysrh5FvlMf7gfvQx
ZdIcqPHdVBkCsZpxs67fykHTQRL4jUMEmbO4o0oV8waMyghvzcIcJIrCIChUiNuA
wiARJX5uZfHMDs9H1bLoYOjWrmQn/sQ9LE5ZIQAZXcW+yiRT31L/H5DSCG3VX1TR
FdPyQ03GvEf+rHTmGyEK/Biq+se48DX7bAG2QPqO4fULMUvYIUzZgAd8BEMuWHhW
uortDgCpkLlXn83MWWrQFngEo4AaX9z7A5Hkx4Pz+lxBcBJIbOkUUOvQu5y+3G0F
0MEJpyPPGYaBaCMkGR6KNZpkMgxsLzr95Ab2oYVb3LeXpR/hZvhvHQfp80yuqbm5
ohPoGiSwF4Yp8G29Xe+TADYQDxZxjSjhQI33E8M9cmS0KBKxzHly8DRUmkZEhert
blP6TCp1gAyWIVxmnfLMyMHfOdcjNqjAv2OXgVnOy8DcGBVFUseDC1t87k8A2yfb
0LdZBj9d/zyx8f3YrwUiEObBwGIWNS9T0jMRV9rJpDDztKFTj3OHp5x3emB1go/5
Z6298atyhwy8QMzWHZtEIe+b3T2Y8EQMKXwAfcIR4ErJUzsHaao=
=O9/+
-----END PGP SIGNATURE-----

--dBzaMLJtBr7lXq6Q--
