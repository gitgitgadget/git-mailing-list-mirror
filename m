Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9793C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 08:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D0561029
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 08:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhHCIua (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:50:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59875 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234900AbhHCIu1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Aug 2021 04:50:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E0D25C012A;
        Tue,  3 Aug 2021 04:50:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 03 Aug 2021 04:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=t+w8gnjUhkjl1n27/8+QcN7ZyyV
        qaYnVZc15JeHbX70=; b=SwW85T2w/OjtP82RJic0UZ1wcm2TU8cOfjvNoFatuLT
        DxjNwc65N+4l5XOGKTGgZssFrLxdz6FiTGUBH2wzEQ0y/bhNY7ESzT5kz++eigvp
        gUYI/gZwlKId5V4hru2ddwbRDC9ffWV+deheXYbquYv6Jk1aIHa8b5tA/Crwa2gx
        ffgMjOD7jjQTTNSNAWdCxlqEOX+PQaNGASdzqS1SaBc2ulfNi6wyxnkVR3+gb7/s
        VpZPEEOdzKEcjLEbbX6guCwJBl9Ikhmnxn682IbYfA1jWMA9Cmsn1/YGwH5+LHzP
        jhenhkZ1n7vojszLGoHrLXjOFON7YzE7EPD3KaNfkTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=t+w8gn
        jUhkjl1n27/8+QcN7ZyyVqaYnVZc15JeHbX70=; b=AGZ/VgAdTz8wGWVasSjpaM
        Pss4EuzzplDFX5U2LG009+AIe7ooM2cJcbWPQz03Isoz5E5kFRPo+nhsF/LMF+6O
        R8P4OtAQkKHtKNzKqK9WXDmC9iz6zpSvnKM7kbkm9kTbVi5U1lg+vdAhQI7FOjvH
        +RfK2aKKVqLFmmy7hZU/FCIt9AeJSXvNd5i+h6gF+pRPAx0ifY+dt+WSBZvmHaQL
        lqn3bHaiCcyH3ZB6EAVENFibmIspASHtXd5luhqt+tYN2WglRwgWx+ZQOoAUL/5Q
        OagWg5pYBrkzdFf0UUPL7CzInb4YSFZ9I4N0zi+sw4/4nSAeFWGK8sKyqKqEaQiQ
        ==
X-ME-Sender: <xms:SAMJYY7GAHGJ8tzntwNuA9qVK2qJ90HZ9dhC7eJPdHI8iK6OlWrvdw>
    <xme:SAMJYZ46lkYFw4OIJL_xa2VubQeHUrPqnU4Pv3lSJeYcEj1565UpsrPnQzj4YyQl6
    bmNIkUZbecLv23Gxw>
X-ME-Received: <xmr:SAMJYXdBqQvQeDcPS0a390MAkZAFkCgc3Ypa2XXLi_v_WI89Gzj_KsozL7wVsPidRJHXeon5LC5eRNF-lQmSUZvX3IdISKoeuzKr0neAC72uNMsoJMDlEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:SAMJYdI1edhrti8ZYLA6gd2jWM6PQlICXIRG3bfzKjo9tG9_aCsxIw>
    <xmx:SAMJYcJa0gcjDT9H0CbOmmP8iz-LebFgbc9qU-d4NzDPoCs5s3hWQA>
    <xmx:SAMJYeyM2bmGAcPPvK-1Yw_LfN0x4nunYAPAEgulqXSoZ0oYgo3mnw>
    <xmx:SAMJYU_rhJasFwXPgQqmKbOWgSNOUJv63-usBOdI8VwCECEYXdkL_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:50:14 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2944a943 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Aug 2021 08:50:11 +0000 (UTC)
Date:   Tue, 3 Aug 2021 10:50:09 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/4] connected: do not sort input revisions
Message-ID: <YQkDQY9Qyqi7FCg6@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
 <871r7covsa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xzs82xqou7QbhK16"
Content-Disposition: inline
In-Reply-To: <871r7covsa.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Xzs82xqou7QbhK16
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:49:29PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Mon, Aug 02 2021, Patrick Steinhardt wrote:
[snip]
> > Introduce a new "--unsorted-input" flag to git-rev-list(1) which will
> > cause it to not sort the commits and adjust the connectivity check to
> > always pass the flag. This results in the following speedups, executed
> > in a clone of gitlab-org/gitlab [1]:
> >
> >     Benchmark #1: git rev-list  --objects --quiet --not --all --not $(c=
at newrev)
> >       Time (mean =C2=B1 =CF=83):      7.639 s =C2=B1  0.065 s    [User:=
 7.304 s, System: 0.335 s]
> >       Range (min =E2=80=A6 max):    7.543 s =E2=80=A6  7.742 s    10 ru=
ns
> >
> >     Benchmark #2: git rev-list --unsorted-input --objects --quiet --not=
 --all --not $newrev
> >       Time (mean =C2=B1 =CF=83):      4.995 s =C2=B1  0.044 s    [User:=
 4.657 s, System: 0.337 s]
> >       Range (min =E2=80=A6 max):    4.909 s =E2=80=A6  5.048 s    10 ru=
ns
> >
> >     Summary
> >       'git rev-list --unsorted-input --objects --quiet --not --all --no=
t $(cat newrev)' ran
> >         1.53 =C2=B1 0.02 times faster than 'git rev-list  --objects --q=
uiet --not --all --not $newrev'
>=20
> Just bikeshedding for a potential re-roll, perhaps --unordered-input, so
> that it matches/rhymes with the existing "git cat-file --unordered",
> which serves the same conceptual purpose (except this one's input, that
> one's output).

Yeah, I wasn't quite sure how to name it myself either. Internally, we
typically use "unsorted" instead of "unordered", and there's also the
preexisting "--no-walk=3D(sorted|unsorted)" flag for git-rev-list(1). With
the latter in mind, I think that "unsorted" fits a bit better given that
we already use it in the same command, but I don't particularly mind.

For now, I'll keep "--unsorted-input", but please feel free to give me
another shout if you disagree with my reasoning.

Patrick

--Xzs82xqou7QbhK16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEJA0AACgkQVbJhu7ck
PpQoOBAApAtjLcftJKAQmZQ3u1wCkxm4iEVsAH1iiSEqViJyPLf2JzI0bGxwyMlm
+6XkS5ZGKFVc1MyEny3VSaZEoGZ8n4+rd1UWd5jwEbwBxhkpVnQVacJiDiD9i/F0
x0r+93CthnSNlILXQvT5FPky2CDLOTVrL90SE6jp51Fsglmpv7eRDRk6HAxAgBp4
sAyqWOOa4xDlAaj4kFTzcJyLyeVgMCWmVd1Qvsu8DtuUUApX8hfpGZacZtyifZQP
thGzoCeOfHh6GCAEpPO3P77unuSaO9ixijXVaENAzjLABQuNOQd8ASIb+vD7tqIq
jpetK+y3VJ2TbS/S8MXBZBb7YweVkpO3FlnbQfgYQXNd1OezskFHvWB7fjl5mBf/
n4Mh6AgS5vdgNo+nyBDB9mr2GnaAEnUJizp7yY9WLI/0mj2pllU49/r0Hy7XpBjs
HETMI+bD1wRAfAhDjy2Y0PWxBsoxzR7YO3OW1OqA+ZVIQ8STtra6zBPGegd8SxFG
uwv+Gy0nHMdqrJTM0n2pXYMnBXSfdQngsah1AAAlht3E54wScVSvFmzcNRtFM3SW
YkoWljot6361tl5/qZmUZk2loPbCiw+r7PyqO4qSCvOKwSLddqA7krgWSF2KpA84
fPb9gqhS4s6VulX6rGk/sshVdeo5DACJDK0u4fFTYDW+GXysLS0=
=mOZM
-----END PGP SIGNATURE-----

--Xzs82xqou7QbhK16--
