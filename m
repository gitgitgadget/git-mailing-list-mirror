Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B658C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiCAJel (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiCAJej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:34:39 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9725E762
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:33:44 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 82B535C0190;
        Tue,  1 Mar 2022 04:33:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Mar 2022 04:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=vslqMORETYS6jZFtVovXeqJAYt9FVSZguAjzMH
        Qo+RI=; b=rDaby9OAFrq6IIiXNFW0sxnhtlxAAOYrKI4yHO/CsruRzYGHOc4GzG
        aovEN3vFTFYgv9Xvi3HgkXTm5OrLdJjRrmiW9xVl8I3v7MP4216lcCuYvGad95CL
        E8hll7Rl8tPc2xIG94e27C6Gze95TVPm0UXkeZSW5J6H14pZtKAzjF3+CM9dAPJH
        VR3YP7TuLQhksJyESPQXb2JfgsIpwuKNvZvoJS7kJ7CV9JYZcoGLdDJCtn3cP2Db
        3LmZXBpvDpCRkDkFsOcG6KfI8RtAldrEy7EUsvGhYM5UeO+HHqPsul096rURCYWA
        FnBaxZF7raCTUWsglrxg0N8mCEApcM+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vslqMORETYS6jZFtV
        ovXeqJAYt9FVSZguAjzMHQo+RI=; b=ceX89niOHPUgdNA5/Ov48B5hWA53N0Lvg
        tianleiBwxcBTdMzcRtJ+Pw0WCCMccsRxvDwHpJh4pP5Sxgg5FMp94r2tmfwH01J
        kAQMO7Fjdb198BIA0YPEO22JjCZU1HS5Jl9SOlx+OFZQ4HHl8b4qzyeSdl0ehJoO
        nK9jtve7mUQucX1zIp8O6W4zcUZoX7VTE0ka0tZK178cJQtqhy+pqXCIPqhTYPfv
        /cGehu6bQoCIC1Iph6CsgWW+FneFOCfKxZl1X2wDvbfr18GwprkWm69C2hmWI4S6
        AM6V3rWLzlB7zavNFqzSEpDuLELZvq28Fy81YT6sqtSTIIQROrPzw==
X-ME-Sender: <xms:cugdYk9GRg2TDE5w4ywXqdhy_ZpceUhQo_binaWwbteUwxt3yVJPug>
    <xme:cugdYssF4WRqB29qLhBnWXDqkLMxZJn7ZrqExU1M173Ur4r1lIplnqFDA-njDl6lr
    tNLvmUCWm4UMF4n7g>
X-ME-Received: <xmr:cugdYqAxiHcPVXgJO9VCZtcQQHOG4cmGAzwb6n6QVxp6YFi30uEbdn8SjtVtNaLziS6CircP75bIAJjOWeGG_qtOdOG1mr7_x1epuy3juHvO607j_ml25BUr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:cugdYkdN9gXHRPqi99bUyO3q2dlW06gIbJIimIqvHuuRazNCfBz3rw>
    <xmx:cugdYpN1BN9D5TPVmk-PXvI3FBwZ8UaCtf3KXAKP-aVJA80PVfEY7Q>
    <xmx:cugdYum98lSTCvWqfCCyhcLVEtyNxw6eqM2Hc8SA21mA1QOZUcS-Aw>
    <xmx:cugdYrXizbO0hh5c74u2r8pHLtmhB95YQrYUDyf1pneW4qzfeHlWoQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 04:33:37 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8f983b86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 09:33:34 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:33:33 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 0/5] fetch: more optimizations for mirror fetches
Message-ID: <cover.1646127015.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VcXUPscmPKaD3Mwz"
Content-Disposition: inline
In-Reply-To: <cover.1645619224.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VcXUPscmPKaD3Mwz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is another patch series with the aim to speed up mirror fetches. It
applies on top of e6ebfd0e8c (The sixth batch, 2022-02-18) with
3824153b23 (Merge branch 'ps/fetch-atomic' into next, 2022-02-18) merged
into it to fix a conflict.

The only change compared to v2 is an update to the benchmarks so that
they're less verbose, as proposed by Derrick. I also had a look at
introducing a new helper `parse_object_probably_commit()`, but I didn't
find the end result to be much of an improvement compared to the ad-hoc
`lookup_commit_in_graph() || parse_object()` dance we do right now.

Thanks!

Patrick

Patrick Steinhardt (5):
  upload-pack: look up "want" lines via commit-graph
  fetch: avoid lookup of commits when not appending to FETCH_HEAD
  refs: add ability for backends to special-case reading of symbolic
    refs
  remote: read symbolic refs via `refs_read_symbolic_ref()`
  refs/files-backend: optimize reading of symbolic refs

 builtin/fetch.c       | 42 +++++++++++++++++++++++++++---------------
 builtin/remote.c      |  8 +++++---
 refs.c                | 17 +++++++++++++++++
 refs.h                |  3 +++
 refs/debug.c          |  1 +
 refs/files-backend.c  | 33 ++++++++++++++++++++++++++++-----
 refs/packed-backend.c |  1 +
 refs/refs-internal.h  | 16 ++++++++++++++++
 remote.c              | 14 +++++++-------
 upload-pack.c         | 20 +++++++++++++++++---
 10 files changed, 122 insertions(+), 33 deletions(-)

Range-diff against v1:
1:  ca5e136cca ! 1:  b5c696bd8e upload-pack: look up "want" lines via commi=
t-graph
    @@ Commit message
         Refactor parsing of both "want" and "want-ref" lines to do so.
    =20
         The following benchmark is executed in a repository with a huge nu=
mber
    -    of references. It uses cached request from git-fetch(1) as input a=
nd
    -    contains about 876,000 "want" lines:
    +    of references. It uses cached request from git-fetch(1) as input to
    +    git-upload-pack(1) that contains about 876,000 "want" lines:
    =20
    -        Benchmark 1: git-upload-pack (HEAD~)
    +        Benchmark 1: HEAD~
               Time (mean =C2=B1 =CF=83):      7.113 s =C2=B1  0.028 s    [=
User: 6.900 s, System: 0.662 s]
               Range (min =E2=80=A6 max):    7.072 s =E2=80=A6  7.168 s    =
10 runs
    =20
    -        Benchmark 2: git-upload-pack (HEAD)
    +        Benchmark 2: HEAD
               Time (mean =C2=B1 =CF=83):      6.622 s =C2=B1  0.061 s    [=
User: 6.452 s, System: 0.650 s]
               Range (min =E2=80=A6 max):    6.535 s =E2=80=A6  6.727 s    =
10 runs
    =20
             Summary
    -          'git-upload-pack (HEAD)' ran
    -            1.07 =C2=B1 0.01 times faster than 'git-upload-pack (HEAD~=
)'
    +          'HEAD' ran
    +            1.07 =C2=B1 0.01 times faster than 'HEAD~'
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
2:  80f993dddd ! 2:  fbe76b78c3 fetch: avoid lookup of commits when not app=
ending to FETCH_HEAD
    @@ Commit message
    =20
         Skip this busywork in case we're not writing to FETCH_HEAD. The
         following benchmark performs a mirror-fetch in a repository with a=
bout
    -    two million references:
    +    two million references via `git fetch --prune --no-write-fetch-head
    +    +refs/*:refs/*`:
    =20
    -        Benchmark 1: git fetch --prune --no-write-fetch-head +refs/*:r=
efs/* (HEAD~)
    +        Benchmark 1: HEAD~
               Time (mean =C2=B1 =CF=83):     75.388 s =C2=B1  1.942 s    [=
User: 71.103 s, System: 8.953 s]
               Range (min =E2=80=A6 max):   73.184 s =E2=80=A6 76.845 s    =
3 runs
    =20
    -        Benchmark 2: git fetch --prune --no-write-fetch-head +refs/*:r=
efs/* (HEAD)
    +        Benchmark 2: HEAD
               Time (mean =C2=B1 =CF=83):     69.486 s =C2=B1  1.016 s    [=
User: 65.941 s, System: 8.806 s]
               Range (min =E2=80=A6 max):   68.864 s =E2=80=A6 70.659 s    =
3 runs
    =20
             Summary
    -          'git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEA=
D)' ran
    -            1.08 =C2=B1 0.03 times faster than 'git fetch --prune --no=
-write-fetch-head +refs/*:refs/* (HEAD~)'
    +          'HEAD' ran
    +            1.08 =C2=B1 0.03 times faster than 'HEAD~'
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
3:  28cacbdbe2 =3D 3:  29eb81d37c refs: add ability for backends to special=
-case reading of symbolic refs
4:  1d24101fe4 =3D 4:  0489380e00 remote: read symbolic refs via `refs_read=
_symbolic_ref()`
5:  7213ffdbdd ! 5:  b6eca63d3b refs/files-backend: optimize reading of sym=
bolic refs
    @@ Commit message
         need to skip updating local symbolic references during a fetch, wh=
ich is
         why the change results in a significant speedup when doing fetches=
 in
         repositories with huge numbers of references. The following benchm=
ark
    -    executes a mirror-fetch in a repository with about 2 million refer=
ences:
    +    executes a mirror-fetch in a repository with about 2 million refer=
ences
    +    via `git fetch --prune --no-write-fetch-head +refs/*:refs/*`:
    =20
    -        Benchmark 1: git fetch --prune --no-write-fetch-head +refs/*:r=
efs/* (HEAD~)
    +        Benchmark 1: HEAD~
               Time (mean =C2=B1 =CF=83):     68.372 s =C2=B1  2.344 s    [=
User: 65.629 s, System: 8.786 s]
               Range (min =E2=80=A6 max):   65.745 s =E2=80=A6 70.246 s    =
3 runs
    =20
    -        Benchmark 2: git fetch --prune --no-write-fetch-head +refs/*:r=
efs/* (HEAD)
    +        Benchmark 2: HEAD
               Time (mean =C2=B1 =CF=83):     60.259 s =C2=B1  0.343 s    [=
User: 61.019 s, System: 7.245 s]
               Range (min =E2=80=A6 max):   60.003 s =E2=80=A6 60.649 s    =
3 runs
    =20
             Summary
    -          'git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEA=
D)' ran
    -            1.13 =C2=B1 0.04 times faster than 'git fetch --prune --no=
-write-fetch-head +refs/*:refs/* (HEAD~)'
    +          'HEAD' ran
    +            1.13 =C2=B1 0.04 times faster than 'HEAD~'
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
--=20
2.35.1


--VcXUPscmPKaD3Mwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId6GwACgkQVbJhu7ck
PpQtdg/9GgpTN4yQJ7KukwgHHMeuwTFUGwpkiCzOghZIJGZYv740vC9U8dvNQB4A
b2xOcfxfegG4uGG7pZhH99OjY8b2lVZyH5Ra+9RzY/8IU9iveBNmIWvGTBB5hCYn
HFGw8nYAC/v0QI5vuU497x/dR1Q0jlUjM+UYE/D1GPM+AWHl5+Pgj43BYCqzzLUw
ycEMvc9IS/uTjMoL9AnLd0SdlM7Ff6Hmydm3YikZNqOcPUwYADhcDJWaRTw/HOSs
CcZiGAbXq3Y/sY11FPyays46/2JRFCEpv5iMckCp5+FFBfbwF6vx6UfSGFw1g5C/
IVVThcRZJwDA0RagqtogHc0nB2vlCQF2y2H161BJ/ZTrAJr7ZOZPgTlZaDijm4Ww
3Vvj4kZ6bTkCQYmgT8udRKj2DUSGvZ3M6qciJOkfk7B1hHN8JuFqwF4JBiO96xZg
iTVRZFfRdaDNwyeR/pM8D3fSVqv2H8mvxnrz/8Wmo45vyb9f6YSGXwJKicmL9rG3
nSsJkRA0hKi74ZwElZ0Q98vmjyDx6tNEJgtc2/3dr4iOIrw0lso4btmdgOTnd8UN
tdVXBXA3eQ7O5a51iWcUn8+//WZAMSYFaLjVJe5CYZHMGDZLvgN7FIiJzjhBwNQp
1tZZvV1p1BSqcrtTDUQybBpNVv2hRJmtB0i6plaCcFgR7tS755s=
=S2bF
-----END PGP SIGNATURE-----

--VcXUPscmPKaD3Mwz--
