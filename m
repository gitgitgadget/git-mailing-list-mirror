Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A54C4332B
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E5864EED
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCONOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:14:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54417 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhCONOj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 09:14:39 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C9CAB5C012C;
        Mon, 15 Mar 2021 09:14:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 09:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=RZFw8wKBrgJe4hFnO8el6flbQJx
        MCGMGQRH4bKbMLkI=; b=ej5HVMsjaLUEpVp8zipFnB6fy8+wgkCok9RNWFJ3vES
        RQuGWnmoHyFCuWrHxa+RV9U8JAC0FEzEW20wxKwiTUpODgE/GvS/8xoKWJDPPT61
        kHod+d5BU0/quQhgx1GtIZ+tYE285TMQ/b3EteMCP33E0Aie/4PSHMsgiQzqyOUu
        RKJulT94WbAYPmDn8mlecWRRdSsUdGDjDld8XnyKCVlvTo/fk4Zr25NR9KNMZo0P
        sQL8VaxbkQSl5+75swv27WxXhGGHeR4QL5U18AM71We5i/46xIwm/RrP784NKsnz
        rcYMCLgTem9mK+nX02fN40X5ShvM9DKquHD/zUZ/XpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RZFw8w
        KBrgJe4hFnO8el6flbQJxMCGMGQRH4bKbMLkI=; b=HxBVgR/LNvHzLhCzMiO96h
        20ynzSzPozIIrUyKvRHfGriKbnNNdE41cczk4jKbtL6h/qLtbxVGdkIs8ytSWDM+
        cKTFPT0Ea5CBaxtKS44jeQNp8aGwDNej+HMOelmaCl0hgjcg922xK2VyEy9Ak5oM
        D70eCZ66FpxDXbLw9HNVeUAp9XRPbndCw9aKbd41UQpBx7hwQbL9fn/XyJ0zQk8n
        vjoPRSs3RTYA2fglVvU0cWA2OiyKPaqLYa9POAAW4XDKGYVKmFY/EqZ/2E/aOq/W
        LBHFkLWfXDf/6nbxeGUhBK/ulXc3StFctXjQN/C4J6reCDWiEGy1tzoykXSTFgjg
        ==
X-ME-Sender: <xms:vl1PYN5sY1-NbRfEZXOqyeawruozwVT39q79qGSnQg1eelnrt903SA>
    <xme:vl1PYK7qwhlqjihXVBgM4ENuCpkfMjWTFDB4V5zZ1uDYur4R7QYmbo3R7GVof30pH
    JI-M1a3D3v3oFCMvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrleeirddvgedunecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:vl1PYEeYnkoGXUyUibf-yd8rIx3fIEOBhi4Gsx9SoUKvLkWXurr-IA>
    <xmx:vl1PYGIMrnqGOiBJiEeMy8Rmw6baCHXeivje7tc9JjjkuaAtDeaQqg>
    <xmx:vl1PYBIW1z0f2oTnTG6BJn7sQ0hAn_FzuwjSiWn-8BBn9gYPxfl4sg>
    <xmx:vl1PYPiBoa2hsfCWUZjugFW9xtU-KdA5EH-5a6iDl7wfGMVPLs6dHQ>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1642F1080054;
        Mon, 15 Mar 2021 09:14:37 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3a1e248a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 13:14:37 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:14:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/8] revision: mark commit parents as NOT_USER_GIVEN
Message-ID: <ddbec7598664bceee50213a41fefa248d249435e.1615813673.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0rYhK58IpsuHuIFv"
Content-Disposition: inline
In-Reply-To: <cover.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0rYhK58IpsuHuIFv
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
index b78733f508..26f422f50d 100644
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
index e6be3c845e..f1f324a19b 100644
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
2.30.2


--0rYhK58IpsuHuIFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBPXbsACgkQVbJhu7ck
PpQUBw//aDVetm2tYwuNkzXTNae6hJ276VcNUfbVYMclsVnrUD0UuOayHOFRHfdr
m1VKPmu0N0YgQaGgSKS5BoepCiC0wGlCdOUF5b7L2RRsXaycqy56lGmpAnKRGCts
1t7CzajhntponhJRgrSidL4SHwjzIh6faTTJI9rDlhboHXItTfmZHg+FEayCoWgK
NRIn4zJgSx0SPQnqkwa9Ms5NApMmTa8epMtOaa/Nw19qZDE9zFI3GtgOMQsOrdsW
H2ckIlJ0j5XlOSCaXKgspD+BqC3KHyJqgP+LcShcOilIzZVKbmNF+PXd65eXqTGK
HVu0MMSlCjd1KP9/gedAy/9/7Q8W/E0KDr3X8OvtJIa8bsUDTATduKSI+eZD9rmm
MTskHw+1z8vD27LHsuZnyoClIeXW2/JzUzcLtLtG6K5NU3S8W2rPHNUJUAZ2JYWz
NMrR2TmvSUYj6hzDIqnxSLsHrEBAnkrJHnG09ioGZ0gYxQGWdAeRbe6wsvqV42WK
mSel6xSGPwsnFsTxmVu7jrOcVfTD7AVq3rG1XnvqqAQLlt7X758wTZs2FD2ScNQe
QA/9PwZZYzN5wyt+UQr9kgTACZqjwq8EVBKDfOtk8Kb2pItDCHvvrZ5GQuU+Wakt
iADaFmB+oA9pxLHnxg1H4o9XfkHqZHaaPNpqJzaRkvtlZ00Wl+c=
=tmaK
-----END PGP SIGNATURE-----

--0rYhK58IpsuHuIFv--
