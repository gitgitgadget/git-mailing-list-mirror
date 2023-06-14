Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5853EB64DB
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 12:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbjFNMSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjFNMSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 08:18:43 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F81FD6
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 05:18:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E5C0032009AC
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:18:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 14 Jun 2023 08:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1686745115; x=1686831515; bh=Gne67QcL/lk3HKB6AggUU/Ide
        WrelXXj/aiafdRCtcY=; b=na/qY9voYT/rTXoM+1xxrCaouO6+IdJAOAk+Gbev+
        htD/ltkCNxdj9Tba3AP6vp7lidlgYRM39r5+z3Gmx9/BhRotNB8WNjPj+JwfU17V
        +zIV5hqNOTfVkDPxIeUy2765BAUdAO5PFMXn2JcNITwItAMuvSM4jVUCaYb24HJN
        n6ilwoXQHgSVV9+W9UUHl4uQDJGbDRzairvOlKuGzKx5AMMh+DUyT1UFz4m4UHo5
        krff7wehh8oHTDBbei8z8H2o3uZJTboN4pPlHj7yn8e6q826fIC1fIqY+anm5lp7
        5/JPqddsJXd98iXU0ynv2+F51VP7SSI+X826yrAu/xuKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686745115; x=1686831515; bh=Gne67QcL/lk3HKB6AggUU/IdeWrelXXj/ai
        afdRCtcY=; b=YvPzBnigwk1l6101zvvzdayfJz7dtG4k2+NmYdVCI/HfQN4fGwq
        lJ0YmZpc8mZsNEV++PssHXdMbLoW3dWziI+WdKgSEh7CaQOjGruAvlJNYHyhNfIF
        mxe9qDek9RmN4WSdJrYYGcM9FV8ROd0VXmkKFV7RrcQYWEMGo2kPaxm6iBGxALkY
        qgXMZTTMhxKwllXhWcuEJbwfC+0DpyX/dXugmN7dlSeBNtO2btumuSY2ZebjqTFT
        5l+8PCFAuRnLdGdS7kJNcUWhBqIJ+dJt5GMaWgi3Tk/h5E8P5Ve5+lgComK9tltS
        dBtYRd99nGKyynyQm99rIh3Ap8b8YCcluqQ==
X-ME-Sender: <xms:G7CJZCy9cuCFCTA9aI7dAM_pH_o4vvZmamOt_cPDQtbH3bGvCiPWuQ>
    <xme:G7CJZOQvVnvyf9ndw8GMZCUOMu6gKWvU6ybHGMhoFP-4eMVqWF4TSfAYTooeQdgBT
    uQG2JUY7vM9KrlAxg>
X-ME-Received: <xmr:G7CJZEWUScg_zauLchaKDWv_M4vWKTvENdslHJpHcPGaUrNELsuDM0jRvTwpNTd31RBH0s2d5bEAcXRfU_Z3Xq35v7V9Q1P39GNmpFGkOiP4Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:G7CJZIiLCS1_-vpEf0j6hAGtANUOImZi-F10W43pz3p7Prttq1n3Iw>
    <xmx:G7CJZEBdEI5cRXs6XdlFpUkhs4juLn9PT3VAJR7eFM-EmJaZ7sp0kA>
    <xmx:G7CJZJLQpSg_NMNThGZV_y26YMBl1cDonNQReAYnBMD_FAhBf7JhJg>
    <xmx:G7CJZD_7kmUZtSXLoBmFlEMvaBDAaAc4JjNn80xl_ZPZC2ce0W9-Fw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Jun 2023 08:18:34 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 865175ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 14 Jun 2023 12:18:27 +0000 (UTC)
Date:   Wed, 14 Jun 2023 14:18:28 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] revision: handle pseudo-opts in `--stdin` mode
Message-ID: <cover.1686744685.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkk3z7pqkxa4hyfc"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kkk3z7pqkxa4hyfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

both git-rev-list(1) and git-log(1) provide a `--stdin` mode that will
cause these commands to read additional commits from standard input. The
primary usecase will typically be scripts that potentially process a
long list of commits which might otherwise bust command line length
limits.

One notable omission though is that this mode does not allow us to pass
pseudo-options like `--all`, `--branch`, `--glob=3D` or `--not`. And while
it is possible to mix command line arguments and `--stdin` in order to
mix both pseudo-options and a potentially large set of commits, the end
result is arguably more complex for the user.

This patch series thus implements support for handling pseudo-options in
`--stdin` mode for both git-rev-list(1) and git-log(1).

Patrick

Patrick Steinhardt (3):
  revision: reorder `read_revisions_from_stdin()`
  revision: small readability improvement for reading from stdin
  revision: handle pseudo-opts in `--stdin` mode

 Documentation/rev-list-options.txt |  9 ++--
 revision.c                         | 76 +++++++++++++++++-------------
 t/t6017-rev-list-stdin.sh          | 32 +++++++++++++
 3 files changed, 79 insertions(+), 38 deletions(-)

--=20
2.41.0


--kkk3z7pqkxa4hyfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSJsBMACgkQVbJhu7ck
PpTTwhAAjEQCwAls9zppFLbcJTDlyI//w6SPBnVTabr9NOez9N1Iu7e0annd2cr7
ybp+A4uGkysjR8e75aF3bblDGAvSsfJoDYMfsEng4fxXg7tYMN1dQFepRcFRE1jT
5cv2zdAbwqN4OJA9bB3n8copT1Ol+9/IQi1qrGrP0y4DQLg6KBXzqv5BybCfoop8
NfeVDyCa2iOyrOM//R91a5LMjaFCVRhmLnVyjgy+y4d6nuFlkCijmJeeR7GkKdaT
ZtRuhrTEorRYTuKEr+3KpmnDbxiAgOQYGLkRFCQBiCu2qiEtdkn/kOK0E2ecK3I9
zZUP6zmG6A/NOipWxK+YSHXx2jzMZY9xC8HeQoX6PquwVrtJ8HSBSs/h7gp5lfzR
DT+kvVWd/UZhFVDDBYmJPdcMjWxorV/MhQoVuvLftC8SHL5Z+uGUunni7UXmEWWZ
eL+jgGDKi6GqQie+f34k9rR+gUUgAyUArereCVi/Dquj6Zdrdb+tVxQQd6IxgOki
G7KIqU//H/+6amIj5PoeM88TzVRwDtyKJHDRv0hAKZRBBSK7P6U2AhkepcPL9RoW
CQ0NWi2Quc56qmWmrA6Ay4xUfvAGWKdwxOsm1v1E2OBKrreHnunZo1WnMFjLAYS4
HXayH0EI0ZNKkUFqy4vX/tnfX/0HsAQkJzAgEDG+zKVWMjRGVvs=
=s0Yk
-----END PGP SIGNATURE-----

--kkk3z7pqkxa4hyfc--
