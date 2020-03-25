Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB55AC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180620772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o+PnE+gj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUlSsurU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCYJx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:53:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44937 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgCYJx0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:53:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B45B5C0300;
        Wed, 25 Mar 2020 05:53:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm3;
         bh=UmXbQyy2AD3tSZYbRI72I08IOagYL4VQfpRHpx3QOKI=; b=o+PnE+gj9Aqx
        msoXlTkUxfUMobFiIAcNo0+ec6nSS3o1v/gKWzWGqVX3f9d+A7VK4thhZrmFgI8D
        DItUk576gaOhfHKZmuHCd7fudZU2NzDdXSdcf3iRiZT0NugzyHMbldFiISXWv3fJ
        moVfwzxy/2hNd7ibT/bc8vhc5bEhvWhc2Lm2+dKwxz36v0BHaAMKKPbixd0NjM7j
        gFz7Czj/K2P7CRs4K6upQYp4E0gCEA94aycc8qs8bfmm/yKAdG69azYSRUOPkofK
        B7kVBFVArKip5PDnkYO6SVhpQCTeYE0M/d52iHszpQieoD8617m4iRfvYUXRtbKc
        gdDMfu1iNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=UmXbQyy2AD3tSZYbRI72I08IOagYL
        4VQfpRHpx3QOKI=; b=CUlSsurUQpZmghKw1uywUnc52af/vdv4O65KQ3DZtSK+o
        hXe+stIP6Mv08GqpVDAopoQaCxBJf1rYsYNXG7lan/649dHnA7ZbCGjuB+2Bwdf3
        vP1wd2jBLn18sXlPihUotyJQBN7JMrmxW4SpirUZCFq8S2hE7maAom7NJveW4Q8c
        DOy6v5SnU4uGfS7nt01ylWmEzIcXS/ctopQQL5gIbyAY0MV0tjY9tdbH0CNItLPA
        DCF2VZ52k7eTn3/+lMiZKw+7t96n0Lr69PJpI9Mzbu6+dgbmt+vGdMgk7l2NOLzL
        /QhqZa8GpPtjxnlH2qgDroLuwZJUtmlD4JMtC3Cog==
X-ME-Sender: <xms:Eyp7XikVZapVxl-HPwKwoHirZ5pzvOYPPton8aPaR1HzAN44UXJ2Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufedrud
    ekhedrjedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Eyp7XuHN_Q7XYTA2EU0Xz8H0e91rDH7TgdZ7M5ptinVtQ-6EGHB6iA>
    <xmx:Eyp7Xrq7HxRw55w0QvxA4YgkYX7MCl0TSptoqebOi_SFH4UIlrX-_w>
    <xmx:Eyp7Xq4To36zFZRfBbUiHuLSp1gvUL0L6cK3fjOWhPDJ_BoM-ur_xg>
    <xmx:FCp7XhxPviYX-ffbQMLIBNUkGQ9xrhWmRcCcaJHNsDS3yVYUwpXfJQ>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6ACBF3280063;
        Wed, 25 Mar 2020 05:53:23 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8b95ca36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:53:19 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:53:20 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/9] Support for transactions in `git-update-ref --stdin`
Message-ID: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

inspired by recent discussions about handling transactions in
git-update-refs(1), this series implements proper transaction support in
`git update-refs --stdin`. The goal is to have an all-or-nothing
transaction where a user can queue multiple updates, verify that they
can be committed, and then finally either commits or aborts the
transaction. A typical session would look like the following:

    # Start the transaction
    > start
    < start: ok
    # Queue updates
    > delete refs/heads/branch
    > create refs/heads/another $OID1
    # Prepare the transaction. git-update-ref will now try to allocate
    # all locks and verify that references are at their expected values.
    > prepare
    < prepare: ok
    # Commit the transaction. The user could also have said "abort" to
    # roll back everything.
    > commit
    < commit: ok

The series builds on the already existing transaction support in refs.c
and exposes it to the user. The most important change that was required
to support this was to convert `git-update-ref --stdin` to handle input
linewise instead of trying to read it in full and only acting after
stdin was closed.

The series is structured as follows:

    Patches 1-2: Preparatory patches which make sense as standalone
                 patches.

    Patches 3-7: Preparatory patches that make it easier to convert to
                 reading commands in a line-wise fashion. No functional
                 changes are expected.

    Patch 8: Conversion to read commands line-wise. No functional
             changes are expected, except that Git builds up the transaction
             while reading stdin instead of waiting for stdin to be closed
             first.

    Patch 9: Implementation of transactional commands.

All in all, the new transactional support will only be enabled if the
user invokes any the new commands "start", "prepare", "commit" or
"abort". In case he doesn't, no functional changes are expected.

Patrick

Patrick Steinhardt (9):
  refs: fix segfault when aborting empty transaction
  git-update-ref.txt: add missing word
  strbuf: provide function to append whole lines
  update-ref: organize commands in an array
  update-ref: drop unused argument for `parse_refname`
  update-ref: pass end pointer instead of strbuf
  update-ref: move transaction handling into `update_refs_stdin()`
  update-ref: read commands in a line-wise fashion
  update-ref: implement interactive transaction handling

 Documentation/git-update-ref.txt |  28 +++-
 builtin/update-ref.c             | 255 ++++++++++++++++++++++---------
 refs/files-backend.c             |  20 +--
 strbuf.c                         |  10 ++
 strbuf.h                         |   6 +
 t/t1400-update-ref.sh            | 131 ++++++++++++++++
 6 files changed, 370 insertions(+), 80 deletions(-)

--=20
2.26.0


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57Kg4ACgkQVbJhu7ck
PpRoSRAArH2/7z3jo25SYH9Kv3quKEJrizZQHuCHrwGZ8J8YzA1LOnjaE+XaxdwT
7hrPvC89x4igOaLJUe2UoiEB8hMvcDFLCF2bNccWjTg1lgBEjK5335qB2wdwztN5
8JXxyo9I10LpjrEPMhD3QCsHpSL2l3Uf23MI0rHQuSn50sL27oHor6e2vfSHCCoF
jgll1R9CFnIG0stb0HS1t7eL7iM7hvbf3wcE3+ZQnGxAnmyO7jn5QN38Qh2F+DCr
s1CVHpDL4H0GyE+3ko85Pgcgeqp/ywzC7h5Nhd7DeUCrZHvjlP+uCXFGgnC5xvtl
RAen7T5J8T5H/73zbeRBt1DEIYIt5uJdy4+Zwlu/X8t7VmBawTeNg8S1TNSxyueD
Q+gobJRP5b3oG+iHvg7JhpJUMJVDDWN9kc2Kxn+8eTdmncgr6X31WQTd0XfHhq6d
n9M4ga9cDtDNa8rT2RfUdW2MHQzLFWy4JM6Lt07XySaF4vGAiLSz6+6NlqmJ39XB
3kyjsf2AVJU3DBvxRkJlwkop7VRvpJCTJFSOp+ms6nwDAFSTXKfIs/w1QjiuLb6l
sxa7VW6JygCnyzC/F26j0Bieyep3/SeFNv7sUBE9iloJzHcVB121hRr9wqKyVRch
YU8v2fWBr/2sXwEdgozm21I4TXH8FWhweF/wpCroD+H4zL2oz7Q=
=cZi2
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
