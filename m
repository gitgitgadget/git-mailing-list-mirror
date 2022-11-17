Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E2FC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 05:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiKQFqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 00:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKQFqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 00:46:40 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C437464A28
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 21:46:39 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 07F033201B5C;
        Thu, 17 Nov 2022 00:46:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Nov 2022 00:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668663998; x=1668750398; bh=6AKGgbHFX0
        yYWdVgamcjbk8CBVoBrKEoVzBeOZSJ8+A=; b=WfP+pJRJAyu9N2SZNGMmaRLNbx
        OmZdzb37MPWRqu3z5jnt2opqQgSOLHbfDQ6mkYC9O9wk86VTfZFhzXL60k/mYMn9
        fH3DeAf704fLzNK1j6a+V/Qff/blcbuLRVTx6QMqpMsOb0LFMfKE8t9B5zfVrf2g
        h4gd0Pw6wD0yTQmGaQg7ldPYYhwjfFf5syZBm7zA4T9m2LAe3tbUJt2T88xVs/R0
        dllQIE1x1NTdX/DvP2+dMvRhgdjOfAf51cQGWbk6PV+iWPFNRlB5srJpqMT9t3oq
        K8h71aQxhcp++5SoexA81KcMaaUr3m2DrkmB8zURiaPmataZCIP+QjKKRR1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668663998; x=1668750398; bh=6AKGgbHFX0yYWdVgamcjbk8CBVoB
        rKEoVzBeOZSJ8+A=; b=YparPj8oExMAJwvpaPmK+9BpDcy1QroxSYK3hg0WExUb
        TITJ5tfAaNTiAsnaz0zwo6aXCsVbPwAr63ClggdIp417UsruKbIDhJIaB8n+Oyxb
        NeQZRoQMD2c5jqx/vPjW9aAZ4Q6C+AW8DE9w2KdjtKPnMJKkQJbT/dDU+W4Sb2nI
        aWa8FUJEMSBOvYygGLa7EZZomL1oSM1vA0X3oUWuq8lduPLDu17zL30xkrhU2kG6
        r5eM0MwfjKtLXMrhNqUnDudiLJRAnG2b/BSgxjuBFYAh0Vbb/olpanx7Er92doXN
        u9yLOUTu6rgpSaMqwoiV7ThaAnhCAJtG4aEa8jHz1w==
X-ME-Sender: <xms:vsp1YxIJBbzy0Q2ELsBz3hTaI3sRBqcTo9QiFjs2aneZWzbuIx4oaw>
    <xme:vsp1Y9Ik2dQdk0GLb20HmSKhCZwI2NqWyryfwnxqE1qZTcdxRC9Pd9vjhH9kPyr4s
    GYw1GZ61AzUhZQK0w>
X-ME-Received: <xmr:vsp1Y5uxgbyrnPqWoEp0185OJJJQfG08naiAi8RekqxlSxfCjb9vSRu__bGTimXKkg9pzgLBG8PaD6SSihwPgo5ojfZLSOS0iYPLkXGDdvKcLx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:vsp1YyZNkTLTMYqaXaJTB-aeLfOTd2A6JY3JV94qvOdcOzhdLQzhNg>
    <xmx:vsp1Y4bBeWIk1jRd_RMk8eUPt2yMof_xcJcqXpjwrwYlsPSHFA7Z9A>
    <xmx:vsp1Y2BmJG6sUqlgJKeaiYePixW3RUKeWNPe9HTGfEKWxSiADJXGkA>
    <xmx:vsp1YwE4zx9ROMbPTb2VAamn3JTsyUJNhKcx0a4TEET0xtOa6mIVHQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 00:46:37 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 1b6e1745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 05:46:22 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:46:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 0/7] receive-pack: only use visible refs for connectivity
 check
Message-ID: <cover.1668663795.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JGwMM4Mzkt76fuul"
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JGwMM4Mzkt76fuul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the sixth version of my patch series that tries to improve
performance of the connectivity check by only considering preexisting
refs as uninteresting that could actually have been advertised to the
client.

There are only two changes in this version compared to v5:

    - A fix to the test setup in commit 5/7 so that tests pass when
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain.

    - A typo fix in the commit message of patch 6/7.

Patrick

Patrick Steinhardt (7):
  refs: fix memory leak when parsing hideRefs config
  refs: get rid of global list of hidden refs
  revision: move together exclusion-related functions
  revision: introduce struct to handle exclusions
  revision: add new parameter to exclude hidden refs
  rev-parse: add `--exclude-hidden=3D` option
  receive-pack: only use visible refs for connectivity check

 Documentation/git-rev-parse.txt    |   7 ++
 Documentation/rev-list-options.txt |   7 ++
 builtin/receive-pack.c             |  10 +-
 builtin/rev-list.c                 |   1 +
 builtin/rev-parse.c                |  18 +++-
 connected.c                        |   3 +
 connected.h                        |   7 ++
 ls-refs.c                          |  13 ++-
 refs.c                             |  16 +--
 refs.h                             |   5 +-
 revision.c                         | 131 +++++++++++++++--------
 revision.h                         |  43 ++++++--
 t/t6018-rev-list-glob.sh           |  40 +++++++
 t/t6021-rev-list-exclude-hidden.sh | 163 +++++++++++++++++++++++++++++
 upload-pack.c                      |  30 +++---
 15 files changed, 411 insertions(+), 83 deletions(-)
 create mode 100755 t/t6021-rev-list-exclude-hidden.sh

Range-diff against v5:
1:  cfab8ba1a2 =3D 1:  ef182e4330 refs: fix memory leak when parsing hideRe=
fs config
2:  d8118c6dd8 =3D 2:  48913c1493 refs: get rid of global list of hidden re=
fs
3:  93a627fb7f =3D 3:  3827d6a2fc revision: move together exclusion-related=
 functions
4:  ad41ade332 =3D 4:  805de80e64 revision: introduce struct to handle excl=
usions
5:  b5a4ce432a ! 5:  d86a3342f6 revision: add new parameter to exclude hidd=
en refs
    @@ t/t6021-rev-list-exclude-hidden.sh (new)
     +. ./test-lib.sh
     +
     +test_expect_success 'setup' '
    -+	test_commit_bulk --id=3Dcommit --ref=3Drefs/heads/main 1 &&
    -+	COMMIT=3D$(git rev-parse refs/heads/main) &&
    ++	test_commit_bulk --id=3Dcommit --ref=3Drefs/heads/branch 1 &&
    ++	COMMIT=3D$(git rev-parse refs/heads/branch) &&
     +	test_commit_bulk --id=3Dtag --ref=3Drefs/tags/lightweight 1 &&
     +	TAG=3D$(git rev-parse refs/tags/lightweight) &&
     +	test_commit_bulk --id=3Dhidden --ref=3Drefs/hidden/commit 1 &&
6:  2eeb25eef0 ! 6:  f8b5eb5a7e rev-parse: add `--exclude-hidden=3D` option
    @@ Commit message
         rev-parse: add `--exclude-hidden=3D` option
    =20
         Add a new `--exclude-hidden=3D` option that is similar to the one =
we just
    -    added to git-rev-list(1). Given a seciton name `uploadpack` or `re=
ceive`
    +    added to git-rev-list(1). Given a section name `uploadpack` or `re=
ceive`
         as argument, it causes us to exclude all references that would be =
hidden
         by the respective `$section.hideRefs` configuration.
    =20
7:  f5f18f3939 =3D 7:  a7eae80ff3 receive-pack: only use visible refs for c=
onnectivity check
--=20
2.38.1


--JGwMM4Mzkt76fuul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmN1yroACgkQVbJhu7ck
PpT0rRAAgQMxJyZ3EcQQiaonjGDiQV70ak84PVcHzOekecp7S6o/GmlqWly4K5fR
bFY2Iv6GSt9PU158aF+hFl7JyQdWQLgMEgrC3Ge+f5mZrSptI215JsapOivjgjwL
FKni7hywJddebiBnSNTVy+QX0lNUwFio5ZCtTDcOZSjqt9T6z0U9Fn+9FDwG6sT9
ajOQH1bXstCjV656wwBCek8p86TpfqRocaA/vXAFyU79ZSAOPj7jeS1S4LVcP/G1
tM5oXFb/rtoasfZdoMqraI1qwesqInGzgKrmyJPxX71UCW10xxrOj7NnFxE54Wi/
Ct8kHWQ+0Vlnor8OT46pjhKO0lLyLUJxQN0uger+Wyf9C83WnpTQ2nrdhhoopiYZ
k3fwsEOzIftzrSw+UEAzAyUsHpsTXm5RpXqwguUcSmOgLPULvPKVlHDUQujr7szt
G3nsBweqDqqIFr4OUsjblNB/NtIm+BPUYAqKK28qdzI2bvKIxg4gxgK7KQLeoslS
IhcQ5xszrrRsqYpbcXkBYIxQLCv5U2/ejDegtuLd3d8HbdvZfDuqPEeOWqjK5i2t
mSCFjdNnfALqJUTQiPZWCtFAeg0AjlB0GDf5IgqMbHTZe507cwnFhUky+VTyO+O/
7s6onyQDQ5cO8BykeLI5jm/ZCtgUK/sSaZGPHMuHJs84Im8ZfcM=
=TEfU
-----END PGP SIGNATURE-----

--JGwMM4Mzkt76fuul--
