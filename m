Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C79C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536106105A
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhDIL2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:28:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37711 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231599AbhDIL2N (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:28:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D73755C0093;
        Fri,  9 Apr 2021 07:28:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 07:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3HFQtrD5QIMa3ooX/VKrKiz7YJ1
        rk8ybu00BZsvO5Nk=; b=JMJS5uwqmz+wJDSBW7X0I04TNTdLD+4jbHTomvQNbpw
        CffkQ3xnrYo/YMSSNxZI5If89s/i67E/FUx7cxcXPT0H2IL4fzsfbcH4q1LeJCb2
        NFf7KuoLL3nLydLatpuiPyzzRP7Fi+9Lr8nJQ5KjN5/7TyOdf/1TXfkeSvDSScNY
        R3HQGFP0zsAsHrBemUYsoRIEuR9IRewwtdrmo92b9SDMEGtynBQlDa+iottcvaNo
        a/srVep3U0W876IHPX7umOn9Ydk9JwA6rMvWeOVwmpYYrzMH8ZNykkWIDdgeK73c
        w45NRnWzwdvqLXcGq5afKV+lo376btxcVZNzTrajynA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3HFQtr
        D5QIMa3ooX/VKrKiz7YJ1rk8ybu00BZsvO5Nk=; b=esi1r0aXa80k6KiL2DvJAn
        3WjWtSNYzTimovDJLE7+YOI/vvwrXKcZqmBv4dHG8ULTVJ4X7Ec4IrrRkwlGp4Pv
        qrnH5rBNaeD+40DwI4+YX4ddM43t48SHorJjE8XZqm2xmUKcJLVGgQLbDhJ0gFUI
        h5ZyXsZ/ZgnyppDRWKAu0pWLVEtN2FbozeIPEQAmYWEgJ33ZsDszXuIN+dVvTW+a
        1STMUL1mwnQ+LF+VW2Ka8cdf6yDb+9Urymv06ORBxvunqreVD8C1VadBR4qmO89B
        8U7YZ2w98CO4j72gxMQO+HPGPQwdbeYkFxhnsvCQqLNXqFbgrSjqga8maajqXH+w
        ==
X-ME-Sender: <xms:QDpwYFvQpIEnGKlK3kSKT0SujycWF-1rQdnOBERM4q9p7u9jkMhWdg>
    <xme:QDpwYOeUOIxmIzMbuOu-QzTcSqLDknkkLRXEtNqRpLpVqX5gp4vhxme3J020BMa3e
    4yFxkyqbjM8YwIlfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QDpwYIxIMxioegy2-Z9Rh8YknEmuoi6-IMpEl-PN3st_WmcVilOvmw>
    <xmx:QDpwYMMX9-7M0X_AunQQogvkOB67KIbl1sWBIEYXA8bSXYFa3iUBAg>
    <xmx:QDpwYF8UlvwALjSYjz1ZRnDBCZmcCmZCnD5niSiNWPLQRQP176lxuQ>
    <xmx:QDpwYHk4Iu28EOpo3kjQaFvqhFVCHHwZDj7CSAJfWtlDuZxQS_thqg>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 35247240065;
        Fri,  9 Apr 2021 07:28:00 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5ba95a97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:27:59 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:27:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 2/8] revision: mark commit parents as NOT_USER_GIVEN
Message-ID: <46c1952405173eca40706ed7be3b939b210ad2d5.1617967252.git.ps@pks.im>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GHNGnwHHvxGuFnd+"
Content-Disposition: inline
In-Reply-To: <cover.1617967252.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GHNGnwHHvxGuFnd+
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


--GHNGnwHHvxGuFnd+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwOj0ACgkQVbJhu7ck
PpRhTw//blVx0PagXnRPSJtNfQJkEwIhqNLo73IO+nxYrtrQ5IjmeLC+1bmikbAW
Hn3t4X49KJkzLsW+ukgwjzQ3mqHg9M0MIPR0Lkt57dF5ev468reEfHZzXkxzrShH
94MRZSiQTK8M007Xe7BiGtgUYw+JOKMLFFdzVvuo6BrYV9q22rC0ECn6ITfwQT9l
fZpI8ybHOe3nlyfhmeEEVbngpncoGn2kHxa0Tjv+xSVbtopZbpMLnZ2C2/LYOZqh
J5Spe9940IUBkOtvBBk7SLuOrkTqC9e8CI1p7yGnrav8YTbl0uDUC7CGsWR8BCyV
4pZIgR5F7XCh2mhcCScMaBz8oPPQ+kLIf3pqDdCYTPdx2Mgw2+yocPN7BCbn/ST1
g3fCvMQdymR6+FiZq/zJZCGwqUFtZRfo8XItvV4ljXk6CltX6Iy4DyRhD2d7jEel
2qwqFGToZSojnIwUONqyrRUoDQ2nc3XZOSkFswLsP3+ynH1K/I9gldd4uXcaQkTj
c3hQesHjtlCdFh68Jv1vngNsaQd++ZQ8yQA9BodchoBgxc5AQx2/SYQdxGHfQ7Zk
jRI9xijdyj7oLwmtuj1SeQ09WUppjVD+eBnSk0sZw4Vcu/vls05E8HuPPqup2ICi
duPPdIjc4NwWz/qGFJQc/2W3hMqtAOeFJpFS014NbZJ3SNOnGZQ=
=cgiQ
-----END PGP SIGNATURE-----

--GHNGnwHHvxGuFnd+--
