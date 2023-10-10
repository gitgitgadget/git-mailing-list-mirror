Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD30CD80A4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 11:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJJLBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjJJLBi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 07:01:38 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F194
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 04:01:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5B3175C0266;
        Tue, 10 Oct 2023 07:01:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 10 Oct 2023 07:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1696935693; x=1697022093; bh=8VgQhYRSrWg2F+BjQoc6Xn9wp
        b7HDIey92WmXZoA8Ks=; b=rKOnpZXAGxepm+h0L2cMIABskRDNL+R7KkFEapGQM
        VGOQpwtfFoOOTzVSTqXRLvfeYZPidGttBh7tU9of1S5f5tkv9JqBg/mIGSxO1Xka
        SBQvxxcemw6hwIRpNv6DFAaRTJf/G9KekpteWK6VTuT6mKH8e7aewxs6xb1eL1Aq
        R0yYLz+dOsQoEqNYqul+CUoQS76LLzwtOTMGxhxAkliygf80YBZWk6NVrJVimlPD
        3ifVLT6MuHA0YV3A7PdBJvxuYGA2nZyvngk6LPvxmoBEwalbtd5RAXXMVlZ2dAKh
        fTQYgpyt9RgLJ+3v+w8tudT1Qz9rZrjwyKVyy4jUU/KQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696935693; x=1697022093; bh=8VgQhYRSrWg2F+BjQoc6Xn9wpb7HDIey92W
        mXZoA8Ks=; b=V3L058wwpIMdAdqdNJ6LS0k2RJwzjiiQwDKF4hW6RIW10DKLrwa
        Ps+mJKCZM4nM+FFv8mHW476dwfRhTRyNIHwRvcy0etn8bFVnusRx377vl80FTTo+
        xnFMm62r0xKF3zTqZFR+Uz1tn7tUzTrrttjxiya02Q0G/OWTK3jWC6ghZlcRuvy6
        1szNK2gElXclKjQY1DHPe/rGP4jsbZAgctgb8fTwL8KPrHSyBLs9rNtX+J5J2Btg
        gfyef81dN/rPSjBS1wpLcQJb03S3us5ba6tNwIY6vmw/a4XjDMrP64q4lbgpiJ++
        Os+7yvhoadwtEAjxVYB0E2MM06nRiZm9M7g==
X-ME-Sender: <xms:DC8lZUZfSxf7byspqBpEHM5tbJwQ8Gv4bmFGlkh28fglb-FrC5ptew>
    <xme:DC8lZfaQLnPrzhTAolvrhfrZPpqlc6lErhSfpgOwm_Vlg9_W4oYXdQwENr_XvhNfF
    C43LCe8p4vxpsMBNQ>
X-ME-Received: <xmr:DC8lZe8UOc-Dj2GRoxxWaE54je72sswjik0P3id5gYu7aVANngW85vfGhifQnCTfKCDQQihuoVnNABjI8niR1bQVJyTxPOffnuV_9J3bRPnXDOPZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eugfeutdeuieehteelveegudejkeejheeljeejhffhgffhvefgkeeukeejtdeijeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:DC8lZeoPVFexmv6SjKXdnD5D5CHB8VkfOPlB7XfGC_oy7HlewCeTVQ>
    <xmx:DC8lZfrGEonyK3ncjxmKVSGePfBlADw6H4WJpBHgjCZlcjv3x2ejRg>
    <xmx:DC8lZcTwIfcWF9AzA5rQcM4aahjDaVIbhcyFCObbJ2Fib0KVfwUR8g>
    <xmx:DS8lZeRANMqnWk0cy6BVgvn9iNhyPmFNKjzCYAeuLROUS3vRN1dMeQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 07:01:31 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id e90df579 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 10 Oct 2023 11:01:28 +0000 (UTC)
Date:   Tue, 10 Oct 2023 13:01:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] doc/git-worktree: mention "refs/rewritten" as per-worktree
 refs
Message-ID: <985ac850eb6e60ae76601acc8bfbcd56f99348b4.1696935657.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UGaUHjYvw7qi7lVn"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UGaUHjYvw7qi7lVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some references are special in the context of worktrees as they are
considered to be per-worktree instead of shared across all of the
worktrees. Most importantly, this includes "refs/worktree/" that have
explicitly been designed such that users can create per-woorktree refs.
But there are also special references that have an associated meaning
like "refs/bisect/", which is used to track state of git-bisect(1).

These special per-worktree references are documented in git-worktree(1),
but one instance is missing. In a9be29c9817 (sequencer: make refs
generated by the `label` command worktree-local, 2018-04-25), we have
converted "refs/rewritten/" to be a per-worktree reference as well.
These references are used by our sequencer infrastructure to generate
labels for rebased commits. So in order to allow for multiple concurrent
rebases to happen in different worktrees, these references need to be
tracked per worktree.

We forgot to update our documentation to mention these new per-worktree
references, which is fixed by this patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-worktree.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index a4fbf5e838..93d76f5d66 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -286,7 +286,8 @@ rules and how to access refs of one worktree from anoth=
er.
 In general, all pseudo refs are per-worktree and all refs starting with
 `refs/` are shared. Pseudo refs are ones like `HEAD` which are directly
 under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are exceptions,
-however: refs inside `refs/bisect` and `refs/worktree` are not shared.
+however: refs inside `refs/bisect`, `refs/worktree` and `refs/rewritten` a=
re
+not shared.
=20
 Refs that are per-worktree can still be accessed from another worktree via
 two special paths, `main-worktree` and `worktrees`. The former gives
@@ -363,8 +364,8 @@ linked worktree `git rev-parse --git-path HEAD` returns
 `/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
 rev-parse --git-path refs/heads/master` uses
 `$GIT_COMMON_DIR` and returns `/path/main/.git/refs/heads/master`,
-since refs are shared across all worktrees, except `refs/bisect` and
-`refs/worktree`.
+since refs are shared across all worktrees, except `refs/bisect`,
+`refs/worktree` and `refs/rewritten`.
=20
 See linkgit:gitrepository-layout[5] for more information. The rule of
 thumb is do not make any assumption about whether a path belongs to
--=20
2.42.0


--UGaUHjYvw7qi7lVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUlLwYACgkQVbJhu7ck
PpSzsBAAkWmyFwNiQgoCKNZptMWpny3YZj3MUShjPuaj2kHmfzOFIM4i6y5Mvjus
fsKuFGsHmdACzZqlnhodBurFef7QWUNUHnu0oWGpj0WCwfPEeVsBPERfIbHXMPub
kAh1SUxACRbYK7ng0jG5n/LbolqhQ8rexDcVCfZNPMmW3pPxlATt9+41NY7MVl8v
BCq0EWDJ1MeN9Vmh/LIyzeyfsJrd9mbPd/Q7Nzpx3hYMRfjFAmyLofqigdolekvC
gX2dbGLDSR0qIeCXWggQKfTeM1OWXPA0OKjgRjA9v6ACXP96b/QQrwxEUEdMN/8m
e+2aLz5uNPrsGyB47mpMEv8bd4rxcH/cZsbgGYEdQ/58F4hJ5luj6MId/G1nqMD+
ania4yXprY96x/9HQ9kil/uk1iom8XyP+KKBhjWC2f3YbjoAF4SMl2VhEcob1Pbq
6Y1xAA0cXfTSYUP1ZNMUMfEjyPz4AzKEYUp/at5BoeQ47emNvntwfTSMXPO/2k6f
AHbdCD+9/ZRNJPIlBRa4bVDmmm2QUCwEHSuuc+tB60bz5aH7yrW0AMALRRk70XX5
dYFQz84XX2DBPC+I3KMNMk05lzh1/OnNJHXqWu9WpCPsnhFG+37o574iYGOPjX4h
Ix6Nt1Q5AlJIq/FUpjX5xg9v95Fy3vOdqTIK24UfYV1wfpwEv/U=
=xIyC
-----END PGP SIGNATURE-----

--UGaUHjYvw7qi7lVn--
