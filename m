Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3691BC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 14:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJ1Om4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJ1Omc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 10:42:32 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBCA1F0422
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:42:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CAAAB5C0143
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 10:42:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 28 Oct 2022 10:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666968145; x=1667054545; bh=HDH+Kl26Ub
        A69CFf2OAykFP3j8YNeMgBfHDHMGfWd74=; b=yAhZns35iF+bMjuD8Y1CJxiDyq
        ic4M7XKL7CdC2ZLnqG2JlJArrxRDN65fj2l3c2shFf1QRvCS3NAB0WRpD94yWag6
        ClOY2ZboQUZ+6ijwOvVSOe+rkd6jgEKxhb5BrYZgTfFnAR/fBRGIZ3uWb39MpK7L
        mYKN57jBuyi0aE8OuCS95QNCtE2jGJqr1uOZbUwA/ao+kHxu3u4T5aH5Rpjl5JwA
        WD09imDDTr/jPMSPWX6FmMcyi/hIztDCueqDmtY8yrnKm3ht5DkrOHXHt5H+eoDq
        pLNleiTE2+f4DK+3G7LgmMvKigcrwwqseY9LHK0YPfurCAFAOPhU7EOJ+CPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666968145; x=1667054545; bh=HDH+Kl26UbA69CFf2OAykFP3j8YN
        eMgBfHDHMGfWd74=; b=p9n3leHRoW7GRMI8fjBcnhs8o0Jt/pxEOe6j9rOq6VFz
        gorZ8A5d0k+bb2n8ZdfvGEjn44BM90yNzL4yP215f9Lo4C5okZW6tqR2mlnrHz9m
        VJOsuTAp9yWXBtJyB3WxDU6e4zruDzZGD4Z+5bKDMN7d/dPvM2z4Pl2pzqx1nRtJ
        uA9bgY4rOqy2NLKCEM4RtlqFNjyTpsGutyuSgabVIbxDkfVQm1DLzlekIRKrarYJ
        eMnwbDwBwtDpItFtCj2Xeu4uStCKejrHBkHqhLfzPgngA86Fry31G2Em9cSvF2Lv
        r5UOARntrUopnOWtUfjdXOJ2QtR06jeNKqeE7Kp3Ww==
X-ME-Sender: <xms:UepbY30rPRwCdApFIllHxsMjv5VXwPxhYRIX4wFQGyUHfBFSsOP_Qw>
    <xme:UepbY2HuT8C1C271X7bXHzo4RkjQUYmeGZQ89kKZ6qhvq44f6iza66DIz5I0r3KqC
    kSP6ZgB4l7quHpnew>
X-ME-Received: <xmr:UepbY379_4jGv7lxB-Gg-vqBcG_MjqtylzcfjY_WAG9omq37zlCy0u_9vz07anm0pyAZE6WW226u_HA5FXj5O3OaaAPx_AQWnOejPYX4mZ2BNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeigdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UepbY82OyYsFeeWvW7Vlvj8ESKyk5VT7NMhSVnmWZQokQoyGJF0p5g>
    <xmx:UepbY6G_XUKrzYK8uT2T8sfj_pj6YHCIG8X64pJ_bzUMPqExCgtCyA>
    <xmx:UepbY9_ZZ0OyFta07ewOJlsz3mDCHCrAfP5q-wBgYj0_3LoO2_-vqg>
    <xmx:UepbY1wsJZK3yA5tpWxyA49ZvESBI0gPd-hQcywaFZEtdhc6D9SlLA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 28 Oct 2022 10:42:25 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 50911e7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 28 Oct 2022 14:42:17 +0000 (UTC)
Date:   Fri, 28 Oct 2022 16:42:23 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] connected: allow supplying different view of reachable
 objects
Message-ID: <a32e3d6146dd41af36f525a744d6cc099b42d6fb.1666967670.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9DiQ+um+eoVd8iCe"
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9DiQ+um+eoVd8iCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The connectivity check is executed via git-receive-pack(1) to verify
that a client has provided all references that are required to satisfy a
set of reference updates. What the connectivity check does is to walk
the object graph with all reference tips as starting points while all
preexisting reference tips are marked as uninteresting.

Preexisting references are currently marked uninteresting by passing
`--not --all` to git-rev-list(1). Some users of the connectivity check
may have a better picture of which objects should be regarded as
uninteresting though, e.g. by reusing information from the reference
advertisement when serving a push.

Add a new field to `struct check_connected_options` that allows callers
to replace the `--not --all` logic with their own set of object IDs they
regard as uninteresting.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connected.c | 9 ++++++++-
 connected.h | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/connected.c b/connected.c
index 74a20cb32e..2a4c4e0025 100644
--- a/connected.c
+++ b/connected.c
@@ -98,7 +98,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	strvec_push(&rev_list.args, "--stdin");
 	if (has_promisor_remote())
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
-	if (!opt->is_deepening_fetch) {
+	if (!opt->is_deepening_fetch && !opt->reachable_oids_fn) {
 		strvec_push(&rev_list.args, "--not");
 		strvec_push(&rev_list.args, "--all");
 	}
@@ -125,6 +125,13 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
=20
 	rev_list_in =3D xfdopen(rev_list.in, "w");
=20
+	if (opt->reachable_oids_fn) {
+		const struct object_id *reachable_oid;
+		while ((reachable_oid =3D opt->reachable_oids_fn(opt->reachable_oids_dat=
a)) !=3D NULL)
+			if (fprintf(rev_list_in, "^%s\n", oid_to_hex(reachable_oid)) < 0)
+				break;
+	}
+
 	do {
 		/*
 		 * If index-pack already checked that:
diff --git a/connected.h b/connected.h
index 6e59c92aa3..f09c7d7884 100644
--- a/connected.h
+++ b/connected.h
@@ -46,6 +46,13 @@ struct check_connected_options {
 	 * during a fetch.
 	 */
 	unsigned is_deepening_fetch : 1;
+
+	/*
+	 * If non-NULL, use this iterator to determine the set of reachable
+	 * objects instead of marking all references as unreachable.
+	 */
+	oid_iterate_fn reachable_oids_fn;
+	void *reachable_oids_data;
 };
=20
 #define CHECK_CONNECTED_INIT { 0 }
--=20
2.38.1


--9DiQ+um+eoVd8iCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNb6k4ACgkQVbJhu7ck
PpRnsA//WBZZIMoFJI9eHwPeSjds0DlfFSSE6DRE16oMyYIthmB+4kGmmm3CnRxy
WBo91a+J4DW7LD91mVKgrgqSTnsfqgGRCQigjvkf8ilvdqOZzG/d9hbV2vp2VlOR
tbHXfZWep7OPGPWI+tTLs2768yQtib6W+cYIR1b+2FLhyxzHOnyUMzOY+57o3+hy
ji6wJKOIdULDta/biyYwxBhJAXrJAIyxBVTC8jtABdTfZ9Yl8oNBePiLRnMNopbJ
8vs6QpTgD1I0vnp00G/rsdn7fWVmCEPA7NhRHDd8gGRC37j0e10PPtF/JsnFa4ZU
dgdgFAnbIS/TZX3+si/S3+ZbsN6f97mYuHD3O6z6hRj8RVOVBUojQJ/nfVez2BS3
kmO1vH1jN4Ai0LinpnKpITy2mIq5n8ngUQJ9hgNmd8KTfvXMkH2+oQugXS3A08qi
K9Lx6LDs7hxPyrA/P+sWxf44O/HYQ3Py9Pgh+pWj+lSWXyzCmTy0+LAWk46ze7sr
ccDnzpLfUOOkag6n5dMt0w/SrHE0y38rLzH24/MSHXnux+gOott8MXkp+XtYLn9z
x3tjH3/WXY5NVQNyS8wPyfSyAyfsu0RPH+bytTQADt3K+fNEBvz3gY1Eb7lt0sUq
nWAPepgdYFdXLD2SzxVqjrAQlOR/fyUbBd6Iq0ryFjhgdJoQgD4=
=e9+M
-----END PGP SIGNATURE-----

--9DiQ+um+eoVd8iCe--
