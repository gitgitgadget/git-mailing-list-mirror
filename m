Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE556C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DE26108B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbhDSLrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:47:17 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:45009 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238870AbhDSLrP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D06E3E1B;
        Mon, 19 Apr 2021 07:46:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=eIi1YD+80dWcV6ejewL8Hpbj5EU
        wA9aIPMo/vh1KK4E=; b=HVDWJhFJD75m8v7hAXjGE6KYQCTXGMK62yYo7ojktWP
        DyLQi5mTkxPFJbcjttej7B3tVzukh+O0hBZYzFufhGBADZL3FNTb0i375IeNyHKi
        kD+r3Tc1JP4uv7NvGL91hfUkhrP4CeXVvtn51lgBU1XSr5HovKlV6LwFYI9niwgl
        8VyhPkyotSTchOJrn1AfasXeWQxp4gxBM7CWCJ0G0PF13ZSwOZcHynO1HZSn0o14
        I523OmtZ8f++vXKDNRi+GeeMlSWV71PPEQADRwSe4SAta9QSCZgNU/EZq/hicr46
        4ioiUndoAbY62JVLOv2Y9wtp6s6ho9qkWzfMPPM9Y6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eIi1YD
        +80dWcV6ejewL8Hpbj5EUwA9aIPMo/vh1KK4E=; b=Hq0NTXIwD6qoibfANCFCVM
        fTq0tAmnnHeTYP9hQRy4TOg4cFTj1kz5Fo2R+CQ+ASWfoDjeFvJ5B10d6+TwxUgn
        O8170dZK406MLTvhhqx3zT2d17BpXniP6fOr9TCNdC07j733hCp9yo42dLu42FAV
        Ok30PDsdZvTsx+AdIoIygqOks4Au0aKgA8ycNvnTi/QGs28SF9GJn8DuUgBDmwwc
        74gphc4Z0Fbe4tJU2bFZI8ILlkeFpKlpDxPrTcZ9Av/vhT2Hq+1+AYBcgND+gQWd
        ebTu9xLCMZLY5U/Go0Vey/e/R9ALtgFqatUrDH3oe1xI3Bd45Qjnc+5So+1GhW/g
        ==
X-ME-Sender: <xms:pG19YGssAFgiyJ-W9tE3avZXpc0A8-WdYcLTEU-iRjivbZsl7ksN2w>
    <xme:pG19YLcnlaTKnzt-qQIYyFldP07fWNMwQQaf6LtB8cKn_vzD5qvaqJqqCd9DMiLy2
    p3A8TTRTAxVfFCmTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pG19YByrRFuv2DSqAqJbLnTDFQPHtTgHkIC2Co5LJ1FPoiMjgXu6Hg>
    <xmx:pG19YBNvq9gSpzBExV4VlfW5k20fEIDO-FtsL30PdhwAeeUKLb-ofg>
    <xmx:pG19YG8hkWLBbwuTfa0n_cS1v2sDj_rqncjOeSIvKpn_5dHIsFkIqQ>
    <xmx:pG19YKbvTammWNHQqS1ORbli-gjiYBVDJunAImzatT1Vq1TO6dxzog>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 650F11080064;
        Mon, 19 Apr 2021 07:46:43 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 900dae38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:46:42 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:46:41 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 2/8] revision: mark commit parents as NOT_USER_GIVEN
Message-ID: <ffe8e2bf733dcfbe3847e172f6a397a205531cc9.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+ae7HN2tjs650dET"
Content-Disposition: inline
In-Reply-To: <cover.1618832437.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+ae7HN2tjs650dET
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


--+ae7HN2tjs650dET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9baAACgkQVbJhu7ck
PpS96g//WW1shALfYLs0Oo2s++waRLRuQ1VNHqqCuyeluQ/0YxEm7r/EcjmKyGJ1
eNlmVUik3kEZEWwwqrbIx3nEGJR8zSZhG7p/cebDrp6UrFhgWGrNLZDAdHIrhulz
4aBLOQU+33C+WmJIsfLLEtJuU1gvq+VKZepdZxlsxGWvSeVf3jd8xnucMckIpj9d
l00ZJkEsi37Heeh+3K4ZkvBXN2WQC2mEMx+YdMw73TlkC9H8OclFUiuA6hDPW2SF
1EYpV9Rdk7/Dz88Ul8xUpfFv+aMQtZTBIozhkcpXtCQsXU/me6ZatUz6c+/iM+rS
aJiuXWNC2HWJ2eZQTgR2qJB+yMkUErBeicQdtS5OpcNbAIUooqg2yQO0VxvzsiXn
b03n18pzTlT4ZgelAqYNqk9Klel0HUmuGO3COqIFINqNqkh+O9EF95UrphnfHGmY
uQd0qCbXeF4yDPIJxDlXsH3tPEory3M0rrOcjpDYmNe+++Cvubw5XtOfS1dxR5og
Jb6eUDoIMhO2PDOGJ/l7udyAJlJ/ALlJH4P/NiG12t5Eyg7OXSU5EtaEXGB0f6AE
rYylkB5lC6GvgM32MsWZLtvDC38MKuu+2ptyd89gRyJIlDb5uQdC5+zxhPvmwWPX
p/9TS+yJgHJ6xosi0cDkMtWuQZpz9MH4Mk3cPstcgcmVQO96P+w=
=CQrc
-----END PGP SIGNATURE-----

--+ae7HN2tjs650dET--
