Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB6AC6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjCOLW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjCOLWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:22:36 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12798A3AF
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:21:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C224F5C04E4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 Mar 2023 07:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1678879269; x=1678965669; bh=TYGMlJmuU0/soQDaI30mFxDGL
        zQ0yq3gxGl834DmRYI=; b=Sk1bIRfvscbbi7PRqoaQlhE4p5kaZEHCsmex+Aj86
        8bRSfdb6fanwvSPW14qMdwbk05RB5Age+6gVwjiPwdjByTPs/EeUu96I4OhmqSme
        XWYD5QipwBuOJfw1ApjQV2oBJAqADF/q2O/xoRimsWE27OmcL46sr7QZXZf4P0XI
        8m/1Y6XkcMDcMUPD7F6QXUqc/xEkztTouDnq8XvuOoXplwEGaJRAGN/izG7iyPf9
        ZZZSIrvJK8RDNNZo1mCn/icPjjuE0DZpy+xz+55PqrQ4gHtEBbtKwLKhTZF48IMN
        2UJr9Eo5zo++ZsII3/zPbcgxxcBPYnE6dSg5WfObIcorg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1678879269; x=1678965669; bh=TYGMlJmuU0/soQDaI30mFxDGLzQ0yq3gxGl
        834DmRYI=; b=R0XWevbhgwszuHnWlRN5SpGFFH3NThrLGLSic8HbcAhD4pDcG9O
        kyBKKCatuF/X0NdWD5ZirHDP6XtrMxtQPx0mriRWKYlDL332wryyUIW36f6TIcay
        FLz/aI+RHfqkjschvYhqBgysZ3rJSchCIvBdW8lVT0rgxxF//p16QCpKhNyEEEUv
        nAxTdTRdbUC73evLsTZZ/MW/jZxHekDnVVk9YAVY2pSoroxDV+MwTlgBRMKuEQIP
        Vaa3WevEuMsJ8i0kRyZtaeQfa7R4syAYH2a3WNAiPz/1Qw205DyClygkdAJ4K9cR
        XDIY9QbYo9DYG7ugATZspc8M6FP50s1jx5g==
X-ME-Sender: <xms:JaoRZGyKaXH5JYx0wYBhRz-I4xzpkk9BSgEHPh5kHYeh8kimh0H-hg>
    <xme:JaoRZCQU06fxk3a9itV-MHPwazMsElCk7LQqcP88vav8lVMvOR9LmjjLrpnSUpFFN
    nb3l92tg-Qt0fEoHg>
X-ME-Received: <xmr:JaoRZIVDiNmWxKLSz8tzmAYlCLzzb0Alg2I9kiy78tTU7x_KOO1Fo5lCDhWX9j8PsMy_di_JZkguejValBivSaK2aUSQZB6gT6uZ7YMAVuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JaoRZMipLeX4zb0_xSAdjjKtB4dE4tBqI3QAFdyitRkLopJfhW30-w>
    <xmx:JaoRZIC-nstWaJfw7phCkRKMA__mNOl6SA7PiJ50YiNBOFdPzCYyCw>
    <xmx:JaoRZNK4pHDfF4gPzzX-Aq9IWIVpU04Pq7iYvnZDy1XKzKB4_nSMOA>
    <xmx:JaoRZH8nsHA0iiWB5YNgfEEMlTkvLcZIzK-eypVwaee8OAS1mLGB0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:08 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 90343b69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:20:41 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/8] fetch: refactor code that prints reference updates
Message-ID: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMIC0HWLKYU+yMvP"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gMIC0HWLKYU+yMvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

at GitLab, we want to gain more control over fetches to achieve two
different things:

    1. We want to take control of the reference updates so that we can
       atomically update all or a subset of references that git-fetch
       would have updated.

    2. We want to be able to quarantine objects in a fetch so that we
       can e.g. perform consistency checks for them before they land in
       the main repository.

To do this, we aim to use git-fetch(1)'s `--dry-run` mode with a
manually set up quarantine directory. One issue we currently face though
is that git-fetch(1), to the best of my knowledge, has no mode in which
it would print all reference updates in a machine-parseable format.

I thus set out to implement a "porcelain"-style mode for git-fetch(1)
that surfaces this information:

    - The reference that would be updated.

    - The remote reference this is coming from.

    - The old and new object IDs of the reference.

    - Whether there's any error, like a D/F conflict.

I had a hard time understanding the current implementation of how ref
updates are printed though. So as a first step towards such a porcelain
mode this patch series refactors said code. It sets out to achieve two
major goals:

    - There should be as few global state as possible. This is to reduce
      confusion and having to repeat the same incantations in multiple
      different locations.

    - The logic should be as self-contained as possible. This is so that
      it can easily be changed in a subsequent patch series.

This patch series does exactly that, but does not yet introduce the new
machine-parsebale porcelain mode.

Patrick

Patrick Steinhardt (8):
  fetch: rename `display` buffer to avoid name conflict
  fetch: move reference width calculation into `display_state`
  fetch: move output format into `display_state`
  fetch: pass the full local reference name to `format_display`
  fetch: deduplicate handling of per-reference format
  fetch: deduplicate logic to print remote URL
  fetch: fix inconsistent summary width for pruned and updated refs
  fetch: centralize printing of reference updates

 builtin/fetch.c | 270 ++++++++++++++++++++++++------------------------
 1 file changed, 134 insertions(+), 136 deletions(-)

--=20
2.40.0


--gMIC0HWLKYU+yMvP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqhwACgkQVbJhu7ck
PpTl+A//UxCPkI+UCcGGcdDfjjryunw2u5VF3rinsSeF/5bvm2pLps3z1w+Te+F4
IOZfiaIC41ms5jrKDGR7dOzHCFZZBfXLpxZKXXozO3TZjAVrNRlwj+tPRZQ8K1OA
ayUkUi6xQD2rNtmfs33ruWymUCtfkPHgyl8Y5Hf8T8hylQBr0rT+f0WQTX80g/hK
qkGwbFqlxevXb2WuGt3MEoCQlmOJKriI8555F3ICHDObFTqlgflhnnStDvchppvq
FubviWCelk/b0XHx3OmOXjPtKriuhl8mJZZGx44UUHd/GosU19XGGJXplY6EoKuL
WnbXkQw+uoIaVx2jS2je9TRXuJb8l7bcpKMEZjA1LjwuSQzRAP89SQ6nbjerlnRo
kjqRdXlMKJm86K3OoXqJW8bVxYnLJvPwk2mBlcoFPJGoNcB5t5Coot1xFjhrSEm/
wqvC0fhDarUjqgmwPqi1cSDuMpE/+hN/uIxoF1VyKw6OxTtAu+/T0x7kD09J5Aem
kckkkTRi59lB6zRaxjYqBlvRqaMSR8Z+sJS+DK7UNMKZsrymMdV0EHBgMZiPLPIf
w1YpECegqpodKqtVbeA/aDY/1u4lKSEISXGFb8FI8ZH7N8KQadtOCAth2oaAEn6M
f59RIQl8rN/UECKekmG6i2BV9E0GtNpwL5ILRH1gNDxM8snMxb0=
=qe70
-----END PGP SIGNATURE-----

--gMIC0HWLKYU+yMvP--
