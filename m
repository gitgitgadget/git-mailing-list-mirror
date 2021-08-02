Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC99C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A117F610CC
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhHBJiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:38:18 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39141 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233019AbhHBJiS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Aug 2021 05:38:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3CBBB320076F;
        Mon,  2 Aug 2021 05:38:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 02 Aug 2021 05:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=4OkOwHhyuo+V7p2B1+ug3B3qy9o
        IoU3D8G7Z1KaLKd8=; b=m7udK9bHVnwAi0XHE5/1vvlXkzPwUJvYyccwX+ouaWk
        NhLM++D1rG2Yua0MnTunQDtB9pSgBkSHmMV1H/qH9GynMT+412dXGBM2m1+pgvov
        ZW9/NHnEjon5SnHQbhWC2RsZEf4BeHwHaeFSGDkwor05FKrAENiDuwYRQQ0+mp7y
        d7t+ZmIFAAOwqc+G41dWiI/NbWubB9B9P/gbdkgDn24UEA+5awzPOKE8lP9jilCh
        og9Y4yR38jA2P2Pnlcd2kSFjS8eicBGWuguLPZwJiiMxn2rxlnRaYBlihBHHLVBb
        /11SeMv9woTHfuXPnFPIAMWIrL1AUEeJvysw2xWIz7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4OkOwH
        hyuo+V7p2B1+ug3B3qy9oIoU3D8G7Z1KaLKd8=; b=pxSisSRnv8CogCimXYi87a
        KYNkDyWwBV16JW3/Psqsk1gaVdOClfgyF5h7l0jR5sTFS/7vUiWz5x5RyuePMNxH
        /PIRNm3WisjIpMaQYysVmvKG6pRUQ4xMuDXJHfe65LkAspnLYW4KGoEeFMl7v7VA
        Yyy8B5k7cQCjDgubieKhbCOW01SV2MPGtsVgOp+ZG/jojCs2o47AaiBLTeRpV73X
        NsYj1WxxRk9Yienfju7cWXpFKE0OQKZyRsAnD0P1Lkvbed1FdgodvcjMYkeuPZiS
        pLEg94NhNclynwtVb6LpiEuvHe6dmFP9gAm2fXqjE4KG+gJJ9nUR93FQdOjAnbiw
        ==
X-ME-Sender: <xms:_7wHYcDSCfMfz3UKJ2F--V9qO5D-xzvBjeXbWUh5vt_bfXLrG1yq5A>
    <xme:_7wHYehXfV_LcQplo7ED_Chb2TZcGFtsvNZpu9Yf38lJSzbg2n0AA8O5yW5VnqOYq
    Z2xlujSQNPDmJDLgQ>
X-ME-Received: <xmr:_7wHYfk1mXZ9o92xRdoN0kKDVNW4i1lQVd9F9SBKijdPI-_tK4_byGS0SGFLcVllxt4eHoICwUGDg4km76SN_xPKfor81KajqqdVec0DrK7WQX3TZ0whtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddriedvgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeejtdeigfegkefgjeehveevjeejveeuvddtieekffevleeglefhgffgjeejfeefnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_7wHYSwdKRqnYFlrTgGmWVusXJndct4f_ORksKqHS2xQks_SfvdAOg>
    <xmx:_7wHYRS4ilwqSBgAuHeNX89fAYtBHwlCRdhcYwkqpKpLWfjQE2Hd6Q>
    <xmx:_7wHYdb0yJNxIFgWPYw8VGlDKiTEQdl4LHNzeuFp2UrxsARVURh4Ew>
    <xmx:_7wHYQFokfOS2AgtWJ7SY8VJrnSFLb9eWvpPazjevX-SEHiZ5JJWvw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 05:38:06 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a452048e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 2 Aug 2021 09:37:58 +0000 (UTC)
Date:   Mon, 2 Aug 2021 11:37:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 0/4] Speed up connectivity checks
Message-ID: <cover.1627896460.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="piLXAAWlwKQRlOXt"
Content-Disposition: inline
In-Reply-To: <cover.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--piLXAAWlwKQRlOXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I finally found some time again to have another look at my old problem
of slow connectivity checks. After my previous two approaches of using
the quarantine directory and using bitmaps proved to not really be
viable, I've taken a step back yet again. The result is this series,
which speeds up the connectivity checks by optimizing "revison.c". More
specifically, I'm mostly tweaking how we're queueing up references,
which is the most pressing issue we've observed at GitLab when doing
connectivity checks in repos with many references.

The following optimizations are part of this series. All benchmarks were
done on [1], which is a repository with about 2.2 million references
(even though most of them are hidden to public users) with `git rev-list
--objects --quiet --unsorted-input --not --all --not $newrev`.

    1. We used to sort the input references in git-rev-list(1). This is
       moot in the context of connectivity checks, so a new flag
       suppresses this sorting. This improves the command by ~30% from
       7.6s to 4.9s.

    2. We did some busy-work, loading each reference twice via
       `get_reference()`. We now don't anymore, resulting in a ~8%
       speedup from 5.0s to 4.6s.

    3. An optimization was done to how we load objects. Previously, we
       always called `oid_object_info()`, even if we had already loaded
       the object. This was tweaked to use `lookup_unknown_object()`,
       which is a performance-memory tradeoff. This saves us another 7%,
       going from 4.7s to 4.4s, but it's a prereq for (4).

    4. We now make better use of the commit-graph in that we first try
       loading from there before we load it from the ODB. This is a 40%
       speedup, going from 4.4s to 2.8s.

The result is a speedup of about 65%. The nice thing compared to
previous versions is that this should also be visible when directly
executing git-rev-list(1) or doing a revwalk.

Patch #1 still needs some polishing if we agree that this patch series
makes sense, given that it's still missing documentation.

Patrick

[1]: https://gitlab.com/gitlab-org/gitlab.git

Patrick Steinhardt (4):
  connected: do not sort input revisions
  revision: stop retrieving reference twice
  revision: avoid loading object headers multiple times
  revision: avoid hitting packfiles when commits are in commit-graph

 commit-graph.c | 55 +++++++++++++++++++++++++++++++++++++++-----------
 commit-graph.h |  2 ++
 connected.c    |  1 +
 revision.c     | 23 ++++++++++++++++-----
 revision.h     |  1 +
 5 files changed, 65 insertions(+), 17 deletions(-)

--=20
2.32.0


--piLXAAWlwKQRlOXt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEHvPQACgkQVbJhu7ck
PpSwbw//WMBmKBAg23Btbc7RyOgEi4fetwgBtG5rejkxmxeHA0mG9Hc6/+b4lUgh
zF2CCOzH6lP9rkQEyhB/beZ+GvpKt+UQvRbBBIJIicRb21ByQOOm2onvc7Qo5mO/
8ksLvCVW/tHf1rPf+051CICjC8Tfv+TjWD5KsZoWcZUd9HDu9bm+6AyiSdmK2Tdv
PYlGXgmsdW+pxwpWVdwvw1fs/cGWx0N7HBQ/BdHTtIv0Y7eZqKOrtD9gK1erqEWv
pS99W4dPMhnq5W7l7M1rB5D5Hl8wIXk6boCMhA6VQl1sE1aYQAxV734YZNq/L9Ws
JS2jNsMWCNxpK3nszOI67rcuoHMvus77B07g0kaGWQwvxgTK2GGe/nryNar/jRz+
pYn8zylLLgqwOIsBCh4/aY4IQAOmv59sy/fUKYAXZi7wo5CF/pWFZk2iEA5ou9lQ
CzdS3tcIcPTd+djtpw9irdj41bDPswr4/Hs0sQSicfWCuZfbZcqLMCacZ65ib4P9
jwOQU/KvxhYa+OcxKOhjmHh7vHmwuLfWBAkkEL3ihwJOr1ioh5+D8UMDLNIyU0zD
DXrzEdVN16jg++lIf3/ByEPI7K4pqAWJ6eKMjMNpHT05pDcNSc+PkjNN/6Q45Hbw
AYaf/b0YWU7hNW1JA/x3B5pvqHcumCSd5hBJffCsg8g/rM4Wvhk=
=+QAJ
-----END PGP SIGNATURE-----

--piLXAAWlwKQRlOXt--
