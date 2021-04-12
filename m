Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B67C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F33A6128B
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbhDLNhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:37:47 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47185 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238958AbhDLNhr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:37:47 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1B2AD16C4;
        Mon, 12 Apr 2021 09:37:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=VFpuqbz3Zw59ClajNNjnme+eE/S
        U2XVEgl2fT1fpl1Y=; b=r+ad1dvzKJtARd40kbo3hzbj98lUWrwSRLcgsYt8+BM
        qMWHqCKcS/U1Cyi5zuCpSvvrou/bWQqfmBmIUMffDJKgRnMsMrBOx53hewDeC4/u
        8mwDEj3ffQvqLi4YUHTd7bwaP+0bDtVSUqj9Id18ZXaS7OcPVLqVa4uz7G57xH3X
        TdPKoPA0+fNxUcMdUgV/Qt3kIHc9I6wpA0R+qY5mXQT61azBinJx5p6lyHaKQspn
        tlhmx22rZ3+N5KrMqMHpahP9lzppVIOEO4odl4PP+39Tr5suYTuhHmN0YxZzRuD+
        gaJXHYpywVB/ucL2fcIWtVaFC9f/ZXEDAk0D7vejiCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VFpuqb
        z3Zw59ClajNNjnme+eE/SU2XVEgl2fT1fpl1Y=; b=LBd/UHyXyFh1DXC34lxfZo
        BjLCLxZKPg2p2QW0tNJodpiXsIgaLevGI9U3zZKSauxBbH65/SJEUAErmUYGtW4c
        oU6iKxET2vGssjPypmx9oY/Auub3/0/v/kzSsdmwOeCxm9lHpsBkE7ONtZ54Nxpw
        WM4T7TN0FATMaGcFPR5Zc3AfvSbNi/IdD0ySvlYR1EnNOWkY3/QG+y40ZdIdahfK
        9T/AOyMSHiM7df0fcfC/hZ4mi2rTbB2doL7ni6b1/QpJUTNVtKeq2Jl3KTB7Ath7
        L7cjIQ7ZbmLyXwr9VzPaCmDjCty/I40SD91i6COVSCcrk0deRjz/VKzQByz4YIAg
        ==
X-ME-Sender: <xms:GE10YO72GEnDUMWuiPovEyhgVw8GkQQNuOr6soS1JzrsrhW2yLRv6Q>
    <xme:GE10YH4T2dwm6Yz_VZXY8AyOpLb_ZAAXLTxMkbGROwCaBOvXPhitLZ3rgq0UpF4nt
    Mqsid8VX-7O8vdE-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GE10YNfYeEOAxuvMs6cq8AERa0vTkE_DXeK0rd0J4aazQHOw-8pkTA>
    <xmx:GE10YLLpXOpNqf0GZbpal6ZVcttdoL6q2WP2Vku5Nu-CnLLZ5r4DLg>
    <xmx:GE10YCIx4Uspj290yI6FTHifbsP_2C_fJYKUfmlBdRDydTtJLwFuVw>
    <xmx:GE10YJWAQJpEIwd9ZR3FWXylfHua7awFbh11HLBscKd8K8dV5Dd3ng>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5477240054;
        Mon, 12 Apr 2021 09:37:27 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b2fc9031 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:27 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 2/8] revision: mark commit parents as NOT_USER_GIVEN
Message-ID: <46c1952405173eca40706ed7be3b939b210ad2d5.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GwFSN0uGdlxY+Bzq"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GwFSN0uGdlxY+Bzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The NOT_USER_GIVEN flag of an object marks whether a flag was explicitly
provided by the user or not. The most important use case for this is
when filtering objects: only objects that were not explicitly requested
will get filtered.

The flag is currently only set for blobs and trees, which has been fine
given that there are no filters for tags or commits currently. We're
about to extend filtering capabilities to add object type filter though,
which requires us to set up the NOT_USER_GIVEN flag correctly -- if it's
not set, the object wouldn't get filtered at all.

Mark unseen commit parents as NOT_USER_GIVEN when processing parents.
Like this, explicitly provided parents stay user-given and thus
unfiltered, while parents which get loaded as part of the graph walk
can be filtered.

This commit shouldn't have any user-visible impact yet as there is no
logic to filter commits yet.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 4 ++--
 revision.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 553c0faa9b..fd34c75e23 100644
--- a/revision.c
+++ b/revision.c
@@ -1123,7 +1123,7 @@ static int process_parents(struct rev_info *revs, str=
uct commit *commit,
 				mark_parents_uninteresting(p);
 			if (p->object.flags & SEEN)
 				continue;
-			p->object.flags |=3D SEEN;
+			p->object.flags |=3D (SEEN | NOT_USER_GIVEN);
 			if (list)
 				commit_list_insert_by_date(p, list);
 			if (queue)
@@ -1165,7 +1165,7 @@ static int process_parents(struct rev_info *revs, str=
uct commit *commit,
 		}
 		p->object.flags |=3D left_flag;
 		if (!(p->object.flags & SEEN)) {
-			p->object.flags |=3D SEEN;
+			p->object.flags |=3D (SEEN | NOT_USER_GIVEN);
 			if (list)
 				commit_list_insert_by_date(p, list);
 			if (queue)
diff --git a/revision.h b/revision.h
index a24f72dcd1..93aa012f51 100644
--- a/revision.h
+++ b/revision.h
@@ -44,9 +44,6 @@
 /*
  * Indicates object was reached by traversal. i.e. not given by user on
  * command-line or stdin.
- * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only supp=
ort
- * filtering trees and blobs, but it may be useful to support filtering co=
mmits
- * in the future.
  */
 #define NOT_USER_GIVEN	(1u<<25)
 #define TRACK_LINEAR	(1u<<26)
--=20
2.31.1


--GwFSN0uGdlxY+Bzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TRUACgkQVbJhu7ck
PpQjJhAAjKB0l7Rjr2hRz3rNRbAYQFSwMsAQHG15b6B1zUynpFo0WsDOz4ulq/Uw
NYTD37psSmJ61ivWD/mTuGT9Ei7WvSpZ+4+tXeLlU9VNRslfyDoQKJvwqUrDz9oP
l7KSQBgG9s4G9vSqDoRBTqECLykogxROdhiX1RR4RtS6QtZd+mQFYgqCSzm1ru9N
rgkLfeYQBG9jon6+dVxKlw0SC8hLQyh2wOzHZdi7I95UGsBvAnm1btsPehyN6Zpq
JNmonXfh/60EbwMBIRc5raU/W0LFMRPptq2LbKOtVPppsT6u/djhahj6bLodP9tB
0IiLebubO7RgzEzYT+QEtN8dJWcvRRO9EMSw89YRZMhhoqNRI2SH6LEtl5zcJ8NK
hdAR4MVHhH6ehjB4eRiHO7pRVsTY3JRFciPJg/40Kjt+PV/mmNYV2I90hX7d6FHQ
xt0rqFZPp27exuPhZ2juIShWAWx86o7k0/B60uWdqt4pmtzQJIuMNdbqc7oa9T9b
YJ5piD3mspVLQWAWwQjGGjrzr2uop0dsrxPJacM27UL6b4f4i4ZhxJkXDsFNA5W3
IJqzGos2hYFpoK6wRjZgepAeYm2MMb+r4IqDSrFFB/v8NpT3NvQ8yAu/Sq9dVtec
DlTf7ryloKZgjs8ZvMhGXxBX5WkPKD/dCYXwItxP5eUDQPQJleg=
=TVtf
-----END PGP SIGNATURE-----

--GwFSN0uGdlxY+Bzq--
