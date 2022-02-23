Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40999C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbiBWMgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiBWMgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:36:04 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC6D9D0F1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:35:33 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 581393201805
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 23 Feb 2022 07:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; bh=V
        lmi5hZBRdTxxLlwnr45dTNITrDRVXd18OVLPZqNV4s=; b=KCKnf26p25uJ+TnUS
        gG3hENGuNurfXFWjj2IZ0Qi3LU449vYhR/sXlzKjDWA27knE+5d2Ib+3kMfSpVKb
        q1W7aY73dqvHAmmSkptCUUjKhSy6TG0UeBDwGx7YEMuNQUJ1ySyB7ycYvp+PcHKJ
        cyT6fUMcyPlp8+vo/dN60zCgHzgPtlSEcIPE5mTKWNrPQWRMDLZKrgfUBdj9tvSC
        PGuuWmn60ulKl00h0ljstO5yQJmTrSATMguI3mQLgPawwj+qchASwiWibmhFkjEN
        PpmfixMBy/JbJ8XEXStdi/B604njpe453/dKgHkuok5RlyWu1eCI/THFiOM3/iXT
        kwspQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Vlmi5hZBRdTxxLlwnr45dTNITrDRVXd18OVLPZqNV
        4s=; b=QnlGtCipqm717Blj2j480yeVr2YnkoJj3ooU5dqic5GINAekrtwXwhdJD
        lSHZpx1l7VNvLfj7Tf+aOxI8WvLtzd580rH7DpkdmnCjZoeQOXlW/T0fFWWqu6Z8
        FwR89CNl2Np41tcQZWughiugW0BDhdsl/o/xEuvxgnd0fwMgbhgu1iwjfW4fJNNj
        Mxd0ZOYszIjrbAhhDSeh2mT4LleXKmG/oyCLLLJzS+cci+inMkK8lToXN0pdg74o
        f6kQkplM20mCMI02gghCnrhuVWsV68mxSH/iO7JgCf2uxL9CwNu8d8Vabz+fy9Kn
        cGtkVzPwHy41gL0d6gWoWJvF8CwdQ==
X-ME-Sender: <xms:ESoWYpdssHJTIgTjzP_8OCq1bQ7jwo3nqxG2Xe8tSa-Su3uW3SIKQw>
    <xme:ESoWYnMC2KtvO9oSekMP3yXEwwYEskLMSklav7ilF08nyJ_RyJxSA-70CRnfqM9MJ
    RC_AXp0o-kYZr72BA>
X-ME-Received: <xmr:ESoWYii1kDA5sDD14eriln6lTiIBOAUTM0U05pw5qpAZu7D1_RShaehrgUeWTv2rR2nuI7hH_EdBJMdD-i2waj0j5DiSI1uyFzd7sB15_-ZIygkdde15q1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ESoWYi9-IqaCCO_m2eswOk8xGRpLIGpzn13lYaeo84vBTFwARezPEA>
    <xmx:ESoWYlu4pQuihd4xRJVhjS8FFEztHF8mBAz-oJX8jN_EsJIyQGlfuA>
    <xmx:ESoWYhHd-zcYaNQ1ahdx13DDQwrCuZTONfw-k5-RrcQU4DVqt2qyww>
    <xmx:ESoWYq7wwIfA5q1H3Baz1Xkn6kfQVDkImVsYEzQxCivZrskyoV2AZw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:29 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e7193f91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 23 Feb 2022 12:35:24 +0000 (UTC)
Date:   Wed, 23 Feb 2022 13:35:23 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] fetch: more optimizations for mirror fetches
Message-ID: <cover.1645619224.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="edn9Ut/1aMA9sn3X"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--edn9Ut/1aMA9sn3X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is another patch series with the aim to speed up mirror fetches. It
applies on top of e6ebfd0e8c (The sixth batch, 2022-02-18) with
3824153b23 (Merge branch 'ps/fetch-atomic' into next, 2022-02-18) merged
into it to fix a conflict.

The patch series is structured as follows:

    - Patch 1: Another conversion to use the commit-graph, this time to
      look up "want" and "want-ref" lines in git-upload-pack(1).

    - Patch 2: This skips useless commit lookups when we don't write
      FETCH_HEAD. These were only used to compute the correct order in
      which we append to FETCH_HEAD.

    - Patch 3-5: This optimizes the way we look up symbolic refs in the
      files backend. Currently we always search the packed-refs file,
      which cannot ever contain symbolic references.

In total, this patch series brings down the time it takes to replicate
one of our biggest repos in numbers of references from 75 seconds to 60
seconds.

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

--=20
2.35.1


--edn9Ut/1aMA9sn3X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIWKgoACgkQVbJhu7ck
PpRWWQ/+OSExYlO9RUiCZ0jK94Z0yXSwWi7a+XXbzLgnCl9pwuu7yUfk4wI4FBqc
ItTBM0EXqcUGjlc9tSWZNjwtTd3P+7GeLJJxZ6AztM5cAdtNinwkvGymYBDnFdvX
UMOqUpKWmF9D2gA5+pCyhce5NaWPZna7pK+s/vIhgyjwtjNqb6kKPLO+e9lF90zf
eXuOpzh3JlqT3bms46O9Q1ReXw9424T5vLdr8P2XGG6Eq9bEtp9LK8OfGjE64pb3
b2Beiixc70VGBg8OaQMHYeq7JVYnbK8uH4tOM7pmkv5CiRDhnOpIrC6wB5g8BoWM
7BkWT23uRUHXXrfTl23TkNMBEq/bXcBFCOe6pVum3xt/hNaY8YwqgE8faz5AbgMl
inImmepac9nMT7sm4XBeOJYTDHoXSFdwRs+sMIbDLgiZxwaxcYDJa7M6AglstF98
JnZHAnx4ngg2l+RGAxvnSq0g6HU46d1Qpv1u0KnQazqjtPQRNsvpQVOXki45Hx7S
iahJWKV7yO6tLSy0d1r/t1XfXgvExQxHn8/JZpBPfwah2R8/oKJvW/u+0ox+J4mc
DroIlVc4Nb0K5oL6ZGdB/E14FGWffr3KVTNf6qnomLSORxCI3u/SXEQgKn7a8vDU
R7DxbaF7J2V1RHRwl4TCRhZE/2dc8BJIOR87xLNFORFtdSV+Ed8=
=qXXb
-----END PGP SIGNATURE-----

--edn9Ut/1aMA9sn3X--
