Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0448DC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE716108D
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhESTOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:14:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40839 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhESTOp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:14:45 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D27F5C0040
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 19 May 2021 15:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm1;
         bh=XUl/bTxpA01fv3FCeZWdDD5230KcV1CCuwiOmhkURMg=; b=PO/5e7N2Pimq
        E/ZcPuJq2se9CjXNLCaz1b7OjA6wmLFuXGQ8uDB7nIm6YAiI19zF2N63I8leG88R
        +XqstiF6KHg7CwlBIKa5FxqCC3PdG4o2+s/0acu2mUWGfF3/36oOZzpiVjkUEeFt
        Utlo+Hz2O568YPVji1QKShG6xpT3+1O480aakQtEahvWp7/dpfT58BrTkSenIIPl
        LIbqxzvq+ACVqE5yuJKppvCKOjLa/ZOLurHd80fF6LLdKhUyonsbNgXIxk/M31Sf
        qckcMN/yBdW9g2sG60H5tzEsbT6A3UNSffwLUQqgxchoQlr8lJQHFBSX6rsLGI6R
        Dct8wAwbWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=XUl/bTxpA01fv3FCeZWdDD5230KcV
        1CCuwiOmhkURMg=; b=bwCLyfWs65CNk6pi9Lr8P3sLpkk+0vxfEpiTTuALf9gvs
        55+g2qivFKfqlty7rX8pP1IdyuWh64OX9u+A0pbhQfVvbey4rzJfFjBG9eZPlvfl
        3wEb85tTDuWGWZH/EeKY19HamNd5wx+fYjLV1g4P6VLtpZ7pmADODjzPGL0gOn3R
        aZfWtXcVe3T//sOFmnN4B9Xg7HTDqv5QdlHxJNtZBiOhsaXK14EQXO43YV3gupZE
        PkMB21GCIMZeMTVaTYIqvPwI6gS5cXpcvsfD+9aiU1xsq6qtB0HeeONyNQiWVVSF
        0MKVCSaK/AU8q9ybaqSIG0e+A0O7issSPs1MbRC4A==
X-ME-Sender: <xms:VWOlYKsTvbNe9sFwPevsijSpqIJcAnnRE6OSJc0DSbrALnLuvyp-SQ>
    <xme:VWOlYPcdxxoH7aJmbSPxKI3IyIdgw-4M89lIeGfAF8wU6c8lTxdvCdN6h6E3CH4GT
    CRB2btvnhUvPvRbKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgf
    dvvdefudevffefveffhffgkeeiffenucfkphepjeejrddukeefrdefjedrudehieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:VWOlYFwEyBSsA7CnkPy6YRHBxXNOQSiEMz1jv5A-6kWLFmaF1tsokQ>
    <xmx:VWOlYFPvx56qOJH3s8ZydrDCAPQidqRgQ0rU4iJold5rfC5-9Rsm4g>
    <xmx:VWOlYK887RKqCnE0ix3OUphh01g_HwE8OVS8XRrv6kQ-dzb2Im3mvw>
    <xmx:VWOlYNIonjOh89tAT116Yahe2iIHYRg97E5tsErkstYm0jEiyuMIHQ>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:24 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3edfda03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:19 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/8] Speed up connectivity checks via quarantine dir
Message-ID: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2u8Sv8/nWfPHBi0I"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2u8Sv8/nWfPHBi0I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

While analyzing push performance on gitlab.com, I've been at times
wondering what git-receive-pack(1) is doing for so long. For some repos
which have loads of references (~880k), even tiny pushes of less than 10
objects took dozens of seconds to get accepted.

One of the issues I've found is the object connectivity check, which may
run for a significant amount of time. The root cause here is that we're
computing connectivity via `git rev-list --not --all`: if we've got many
refs in the repository, computing `--not --all` is hugely expensive.

This commit series thus implements an alternative way of computing
reachability, which reuses information from the object quarantine
environment. Instead of doing a refwalk, we just look iterate over all
packed and loose quarantined objects any for each of them, we determine
whether their immediate references are all satisfied.

This reimplementation is paying out quite well for repos which have many
refs. The following benchmarks for git-receive-pack(1) (added in patch
2/8) have been performed in linux-stable.git:

Test                                     v2.32.0-rc0             HEAD
---------------------------------------------------------------------------=
-----------------
5400.3: receive-pack clone create        1.27(1.11+0.16)         0.02(0.01+=
0.01) -98.4%
5400.5: receive-pack clone update        1.27(1.13+0.13)         0.02(0.02+=
0.00) -98.4%
5400.7: receive-pack clone reset         0.13(0.11+0.02)         0.02(0.01+=
0.01) -84.6%
5400.9: receive-pack clone delete        0.02(0.01+0.01)         0.03(0.02+=
0.01) +50.0%
5400.11: receive-pack extrarefs create   33.01(18.80+14.43)      9.00(4.30+=
4.65) -72.7%
5400.13: receive-pack extrarefs update   33.13(18.85+14.50)      9.01(4.28+=
4.67) -72.8%
5400.15: receive-pack extrarefs reset    32.90(18.82+14.32)      9.04(4.26+=
4.77) -72.5%
5400.17: receive-pack extrarefs delete   9.13(4.35+4.77)         8.94(4.29+=
4.64) -2.1%
5400.19: receive-pack empty create       223.35(640.63+127.74)   227.55(651=
=2E75+130.94) +1.9%

These rather clearly show that the previous rev-walk has been a major
bottleneck in the implementation.

Patrick

Patrick Steinhardt (8):
  perf: fix when running with TEST_OUTPUT_DIRECTORY
  p5400: add perf tests for git-receive-pack(1)
  tmp-objdir: expose function to retrieve path
  packfile: have `for_each_file_in_pack_dir()` return error codes
  object-file: allow reading loose objects without reading their
    contents
  connected: implement connectivity check via temporary object dirs
  receive-pack: skip connectivity checks on delete-only commands
  receive-pack: check connectivity via quarantined objects

 builtin/receive-pack.c       |  57 +++++++----
 connected.c                  | 192 +++++++++++++++++++++++++++++++++++
 connected.h                  |  19 ++++
 midx.c                       |  22 ++--
 object-file.c                |   9 +-
 packfile.c                   |  26 +++--
 packfile.h                   |  10 +-
 t/perf/aggregate.perl        |   8 +-
 t/perf/p5400-receive-pack.sh |  74 ++++++++++++++
 t/perf/perf-lib.sh           |   4 +-
 t/perf/run                   |  25 +++--
 tmp-objdir.c                 |   7 ++
 tmp-objdir.h                 |   5 +
 13 files changed, 401 insertions(+), 57 deletions(-)
 create mode 100755 t/perf/p5400-receive-pack.sh

--=20
2.31.1


--2u8Sv8/nWfPHBi0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY00ACgkQVbJhu7ck
PpTxjA//U98RpbUZKp7kMYkyTljAEG/BFIZSz51naktUHH6kngKVjPZge0P0B4x1
PLK+MqcY++s+MQwiG3Kz77lfp1KUwagROvDJgbPJucj1eDZyYcZLMbXvMmRC3FOu
3rCKdKnREmHVFpm6SWNnYs9XkBGAURZrW6gK9kTSc4+lWexPr1L6R1I5bpBLkYuo
+E10LPtlGYPxeLNS5dJ56JyLMyiD56Ezj5icYX8H9fQTtyAvAAwImkF2jxpqkwOR
hgnbwFm1iTXpPNdMDkxvKEJw/oIKxGeyOu1DsLu4LgBCJyM8vGXcWxnz0SldBvxc
7nS+Nix3BS1O7HsZ3TqCrWLvieY9s0EtZZyzb18EMFlRydOUKfZREpFIdI3JX6qj
/Pr3yUpu3zz+DZZNmo+dZJOxemyGZjdn6zXlFI3Stmjo5Rw9sO4jn/pakU7CzG1F
8P/+BntAUMf2ZiF8yoDDdMTEQirewuWd1ORMGqUSKTI1qlobi2teFjJaQUQvqvSE
pn5DA6nM58YDWA7FtyyPi7qibJV5VHoXnALMGeubZmqCwPoaYQsvHIBSeceLkBkz
FZqh6PmCtJJbGcTlq5Pi8XNOXkzNqxN9PPqnmX0U2u8ae+cbFCfrQj83tti+Q0sE
X9YcJWWbMAYUb+mfccIoc9EMID58CI13xv9ZkPdd/8OmfnvoMmw=
=JWzx
-----END PGP SIGNATURE-----

--2u8Sv8/nWfPHBi0I--
