Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329C7C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 09:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbiCJJzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiCJJys (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 04:54:48 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92978A76E5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 01:53:29 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 583185C02E9;
        Thu, 10 Mar 2022 04:53:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 10 Mar 2022 04:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=q18b+5VSi1MV8KTGfDFCwWYFCf+Tbx8lhi4pLq
        neqXY=; b=YmNjlIjRTsPx0BfZjZHL3lkjd7GizQup6WcqlWrUTjpfYqSpAzYvNW
        Xhrsxr2y4wqwls+YVH5jVP6qNw/OjGQ5kd99LRYUVPUtYmD4XEbDm0BW2iYKpm4Y
        sWMFEqztaINI+jtnt8yNQtW48WOMnP9KsnL0wU0A8iqRSHIq7pBtcfyK27Z8j+2u
        MsoBI4bGsFim/By+CGIn9lm62J/RadBwDcd7W0P+uEOuYrtV/FaOJzbCRzl0MgK1
        7akmsh5JbEqf2Z5YRK2NWoTDE21Rvhnrov6AKTxg57rx6EYeWlhtBNiqtvwzV8gs
        nGUdE4haWXCxJzNyqtpU6Ty+/KDLwF1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=q18b+5VSi1MV8KTGf
        DFCwWYFCf+Tbx8lhi4pLqneqXY=; b=XVEEdSmYO4WVUuxjaSGa0KDijPzk04LJg
        pBoH7wD6pc1B5wCtnvMZo/5FZbjyb7pQ4fIZPBywCDNxV9Mso3optR9w7P3WvfNo
        tU/tsfzQAjJ87rpEANSSLL+FmAq98ohS214qFoZXMmuumHrwSDJsLw7y3kIgf/jJ
        WhIOweh2RbdLMvzg8zXQO69yheKimuZBrqA0T087NSDCBpPZSX4WDjV3XH5iB39M
        2v2MPM+DL8nSqjCx/Dw0cWK3m5fqAf90lp5Hf16v/7yxvfACQYQNmNH1LwE33ZOX
        AZaW22ozl0A40Hv0cBA/xbav4LbG8w99tYMHfpHCJm6yQ+P6y09mg==
X-ME-Sender: <xms:mMopYvSxsrKckxuTxZbcHD_zd73FGswNS752K4cxT_lCn4UBrGAC0Q>
    <xme:mMopYgwZ3Y5wWPYpu_KSXws85TYtbVTuo08AZSlZRYJOgKo3MZ-rTmCJqTCfHtuen
    oVXSnZpBVWzmGb85A>
X-ME-Received: <xmr:mMopYk3KFO_xdyCRA1PAxjaW1rK9bZy7gLkOmPqQ-u1K8aFSnalVFPv_7HR59-7NFsZagumzS5zzG-A7ej3p3wvrfbMKZwuYR1783OrR3pQx2VRlp4S143tuGws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvtddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:mMopYvC8egPxV_S0O94BAI3jLkm0a_o16PXMCeOewikDRAi89oQQ0w>
    <xmx:mMopYojWhUq5ixX7ed0GIoiSFEipKLMuN9W0xGwkL4yRGSgjAeTyrA>
    <xmx:mMopYjokATDGYrSguzKKzEJ9vmndaD66mpYz08rWrqX-0_EW0cCFOg>
    <xmx:mMopYkj-LszFb3LzV7ZEExSlj6jamZ5zvjvEF4wZxtmLEKh4V4hDLQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 04:53:26 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 50703f50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Mar 2022 09:53:26 +0000 (UTC)
Date:   Thu, 10 Mar 2022 10:53:25 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] core.fsync: new option to harden packed references
Message-ID: <3b81d8f5aeffb73a32b0bff0da947f023a3df517.1646905589.git.ps@pks.im>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QufyjLqliReDEgba"
Content-Disposition: inline
In-Reply-To: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QufyjLqliReDEgba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar to the preceding commit, this commit adds a new option to harden
packed references so that users and admins can avoid data loss when we
commit a new packed-refs file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/core.txt | 3 ++-
 cache.h                       | 7 +++++--
 config.c                      | 1 +
 refs/packed-backend.c         | 3 ++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index b67d3c340e..3fd466f955 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -565,9 +565,10 @@ core.fsync::
 * `commit-graph` hardens the commit graph file.
 * `index` hardens the index when it is modified.
 * `loose-ref` hardens references modified in the repo in loose-ref form.
+* `packed-refs` hardens references modified in the repo in packed-refs for=
m.
 * `objects` is an aggregate option that is equivalent to
   `loose-object,pack`.
-* `refs` is an aggregate option that is equivalent to `loose-ref`.
+* `refs` is an aggregate option that is equivalent to `loose-ref,packed-re=
fs`.
 * `derived-metadata` is an aggregate option that is equivalent to
   `pack-metadata,commit-graph`.
 * `default` is an aggregate option that is equivalent to
diff --git a/cache.h b/cache.h
index b56a56f539..9b7c282fa5 100644
--- a/cache.h
+++ b/cache.h
@@ -1006,12 +1006,14 @@ enum fsync_component {
 	FSYNC_COMPONENT_COMMIT_GRAPH		=3D 1 << 3,
 	FSYNC_COMPONENT_INDEX			=3D 1 << 4,
 	FSYNC_COMPONENT_LOOSE_REF		=3D 1 << 5,
+	FSYNC_COMPONENT_PACKED_REFS		=3D 1 << 6,
 };
=20
 #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
 				  FSYNC_COMPONENT_PACK)
=20
-#define FSYNC_COMPONENTS_REFS (FSYNC_COMPONENT_LOOSE_REF)
+#define FSYNC_COMPONENTS_REFS (FSYNC_COMPONENT_LOOSE_REF | \
+			       FSYNC_COMPONENT_PACKED_REFS)
=20
 #define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA |=
 \
 					   FSYNC_COMPONENT_COMMIT_GRAPH)
@@ -1030,7 +1032,8 @@ enum fsync_component {
 			      FSYNC_COMPONENT_PACK_METADATA | \
 			      FSYNC_COMPONENT_COMMIT_GRAPH | \
 			      FSYNC_COMPONENT_INDEX | \
-			      FSYNC_COMPONENT_LOOSE_REF)
+			      FSYNC_COMPONENT_LOOSE_REF | \
+			      FSYNC_COMPONENT_PACKED_REFS)
=20
 /*
  * A bitmask indicating which components of the repo should be fsynced.
diff --git a/config.c b/config.c
index b5d3e6e404..b4a2ee3a8c 100644
--- a/config.c
+++ b/config.c
@@ -1333,6 +1333,7 @@ static const struct fsync_component_entry {
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
 	{ "index", FSYNC_COMPONENT_INDEX },
 	{ "loose-ref", FSYNC_COMPONENT_LOOSE_REF },
+	{ "packed-refs", FSYNC_COMPONENT_PACKED_REFS },
 	{ "objects", FSYNC_COMPONENTS_OBJECTS },
 	{ "refs", FSYNC_COMPONENTS_REFS },
 	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 27dd8c3922..32d6635969 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1262,7 +1262,8 @@ static int write_with_updates(struct packed_ref_store=
 *refs,
 		goto error;
 	}
=20
-	if (close_tempfile_gently(refs->tempfile)) {
+	if (fsync_component(FSYNC_COMPONENT_PACKED_REFS, get_tempfile_fd(refs->te=
mpfile)) ||
+	    close_tempfile_gently(refs->tempfile)) {
 		strbuf_addf(err, "error closing file %s: %s",
 			    get_tempfile_path(refs->tempfile),
 			    strerror(errno));
--=20
2.35.1


--QufyjLqliReDEgba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIpypQACgkQVbJhu7ck
PpQ02w/+Lnyt9Iw4K/MWFqsDoPZX2+I46/jqtwcVb5bsbPZLzIkdBpTZ2lu/Emnl
twarMVVfLRmEK/lfObfd0UrNGTdCmnEVxFEA4bhxXw7gTi7cl5ZB42uBzcFqV8N3
j0xNpUwwy0nFfpqp5fcazugK8TxESobKcyilzuwjCXKKrsWOMkfiX7uR72i393Ih
hlvi8YzIx0Hy4/pm+h1VFMu4ME4fRJphfQsLEooBHvk66x8X5gtBkBURGDR8IpZM
vrocd8I+0FJFLIlAGuZKju+tw5H4Vyw8BHEJwnIsmuSvYdLSmfhZJkMdn34csiQ0
1m4dZ/IxSRBXnmDj+C9Roq8sryU4ZOGZx9yMh4QrUMPGh8lChQYaTJLj719m4OxB
b+Wn13Xj+yjikeRIE/YAM43FGbfXqyFjU6Q9ddrN9JRQ6vtTO4iNdK25Jh5cJVCj
S22jzftRL3uyIZ3AGdWkPhuJsIn3bWzxVfY3MLZz7ERGOaRWfKeL5Xtx3UunsJ+l
CKnZBq4wO1wJyPKG6p7xoEGSqe2nnwfYR5I4eEihKhO7FcHiscnYrmhmBATTXcRI
Qf9xlOnMqMd6mMJaRiH5GWOxdLBvw1iZhVhOyDtCJBSq5tSOuzkxlxZxi2oKKG/Q
1vJjf4+RjpJ7Gely2Ienn2+2Roc7cwaceTQjafbPjYex/6Hr0v4=
=Wr+X
-----END PGP SIGNATURE-----

--QufyjLqliReDEgba--
