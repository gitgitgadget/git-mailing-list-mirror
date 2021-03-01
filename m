Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5E9C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CDE64E31
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhCAMWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:22:00 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43071 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234226AbhCAMVn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 07:21:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B32EB9E9;
        Mon,  1 Mar 2021 07:20:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Mar 2021 07:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=y7RmNu1d50ZRYBgivBIE9DBHaMX
        B5XxatWykHv2UTiw=; b=wevnjtzbE++ytMAvcHMdfrVyMMwyOPz7/JznsmEf7N5
        G94EY8ry+lfbfdxN7meR0c8i9nE6GyqoHR7Z/EX8yschOMBAZw3JnJL32o8aeqho
        y4ydB7Pu/ZrnDPD/omIQCIatGsjWJ3U8H+xs46Zh4YAWG7F2tp7RN2JRiaXFq2Dz
        RwTWrYLc6UluGt1IOnhKAjEOqtjS5g62PtLLoGy3pnu7cr8idGD9qe8UiQWK+MI/
        VEwAhmwdTySaYHdiMjQPD5KhVgYemo3+WOlDsSU7gkBOCqBJV+xhOICG+9iHbvEJ
        hrjKZEZ4vH5xRAcxXIw//UOnMwgbODwmx2vdncIuePQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=y7RmNu
        1d50ZRYBgivBIE9DBHaMXB5XxatWykHv2UTiw=; b=HslmJg93khwVeCjW2F2qWb
        WGJx8Z3wGeBCdQL5JpNRLy/9eQYWEh68ulnML1R8BkVzAzfnYeKn4NXBWXH15UkN
        HxoDBoIoUi5ATyaY/mIaqARMNAA8kyUznRd7OvVzA9J5K6g1qBkSgfX3n47MX0LM
        ey7dEvHSyQFbcLEUO54CHeC6IBa1HqmphmXYZNBy1oeJg2AINBwpBDsxErKFIOmI
        3UU/4ayk2Zu42hFao15Bys0LKRqJktsaWKNQ4KowiaX6LxoO8RF94gDoD5ItEE92
        3xQKEuS2TY/w5MZ8bTp5PEWwKmu0T1A3lxpoAfFXTZyDvMwFZyQWKqFcBccGdTfg
        ==
X-ME-Sender: <xms:Fdw8YMI_7C129d-pqTD33_gQwDhwAJLq_6cUwsU2y-DT3brmlcFbJg>
    <xme:Fdw8YMKNrRnAh9uzf203vMRjbg3qohsD3gHOtn2tmV4s7QAXmBZFalFiyCDZlVUXC
    b8fU_6yzWdViQuu_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Fdw8YMv_eb7igS05B3GCNMvOU5KLIgqHieYebtJR6wlUtpZ8X5CHOA>
    <xmx:Fdw8YJa3ydM5Nf4iPhndqplEFJoiZnZA2kY6nrymRNQ_ivqOxxmAcQ>
    <xmx:Fdw8YDazX_ZbpoEAZ8LARvg-TllMSaNitzV5sWq7ROOBr2ZQvr8vWQ>
    <xmx:Fdw8YN32OIVJvBVOcDSwP5otDrkKBq3hel54u0tHIJrkGMr-79xOqw>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3D70240064;
        Mon,  1 Mar 2021 07:20:36 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7afba069 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 12:20:35 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:20:33 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/7] revision: mark commit parents as NOT_USER_GIVEN
Message-ID: <f2ce5dac8965ab3ccb13d7600ea29310cbb5b863.1614600555.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X7RdegxiNFdEp6pQ"
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X7RdegxiNFdEp6pQ
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
2.30.1


--X7RdegxiNFdEp6pQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA83BAACgkQVbJhu7ck
PpQgDw//WGQmZAcgqXIdSxCn3/mBhs8WEZzJ5HaifYMty5UyGqKAOCIZHotrqA6I
a+ywieQbRKqY4uJR+cMf/lwriwDsMGi8lZ93K5eFPxYMpJKp40EZFnSp+WirtsRx
99WkZ1BCBnaxtkutnIiCVTvxYtOfEsXrnCQPV7rgEaTQQGgL0yrylXRw/EvwXX4j
25JLom1WNSmf3YBCRhri/SeodIGwdXJb0pWTK80g9QnbcHHxsq9hrhzNG5u+K1kA
8zkcquz7QYSndTpn0nk8GtXlObuIc84RTxmgSiNkSVUJZ/7jeAubWYklflVaZJEc
MtPzzApMTP/t6a9/ex03H+suKp5U9h6Oo1ZoH6jG5Tq7S8fWtq0sR1WfSDJLKh9q
AOp50fKNFRtMzM0cYpPB3UAoaxHGvNb8Z05QOa/RKenDZcRMxesX7p4A4RayMS+j
FThlMUIGZZo8rhpcNdim/XUkNnDwlN8qNBij/G8Ixyqh+fMjHkMU46vDAjoFRljD
aprlFWrEDkqGsqUhge3VN41IKWfbRt7E4mbejBdhj2EhllpBBG7g2ybpUsB1aZkQ
fpB9xm4+hy07eH4s69N/rRiXJnLSk1P9O5J5jfd3YIA3TwD6Uowm2dfmKEmfntKB
wxnKx0Lyo3G6R6mXl4A9lur7u++08dbOYz9BHrjfGtVtXL+K9TY=
=qlE8
-----END PGP SIGNATURE-----

--X7RdegxiNFdEp6pQ--
