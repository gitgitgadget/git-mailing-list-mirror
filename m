Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E31FC77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDMLQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDMLQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2601BF
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B4DC5C0143;
        Thu, 13 Apr 2023 07:16:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 13 Apr 2023 07:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384570; x=1681470970; bh=gd
        9KpwTyqqu1to0OfxFuskUgZclLgXDuX5CdVRAHRqQ=; b=aqjOL5LFXBZqAC1caO
        hI4tK+VuanOQxuvP/Vwv5gWdgaV0v2U6kLxm/sSvUTx8dPKz52VxO8oiSUjMLRaZ
        fnXbtlYo0cJ6ksQqYBsQbrcqaqxoUsHX9n0RFP/l4GrDAb5/9+Oxg55e4uOs9aB8
        DVdo1uEpVaIPZjmIh7qBr1HP62hvt5Gwi0bVWGEBHYAmPklvJkSE5xAS1QXASlo3
        rselXBV6g1JrJRHGMFc/epw8cwlGfk4eEj3kGZoN6thMi1e8al9/ZjGJ1edfYBIl
        kk01JFYDNgG98XYmpd1SQhEpgCaQ6SZbzilTc9D0lrYz1WqtQOVYS7yOs2dSffGW
        A0lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384570; x=1681470970; bh=gd9KpwTyqqu1t
        o0OfxFuskUgZclLgXDuX5CdVRAHRqQ=; b=ZDBHYtmjG4OmV8rHcbBy+wngNhGB6
        DRDpKwtcy8e1KmkUp7wC7e2/GIOuE7z9YkDGfgJvt0LNKsFpJUGSIQl/vwv3AdzG
        oW7wuq8Lz/CVsuKnY3cvK2r83orGFvHLPDqw87/0u/WX2k/UunGEvAfkcbkmovbL
        G5WYD612jKACINJNkgPMk22liDHKJgoUCAXh21enTzMFXo/Y/3XGmEk/MipAeMQF
        gvatefArG7HtJUkb37IEh2/IhKfxa17Tf4rSbouwGOoxr3eH9+FiUnBvlSTfIZaZ
        +QJMHMAB5ex7wyOidyGlTGWXLot9LWrG3SgQlKW7DBe+u5YpyXITfqYtA==
X-ME-Sender: <xms:euQ3ZB_4kj6GiusDwqZm6pSJBPzk_4ovEFKalQCpO4_DlcVg5xCmqQ>
    <xme:euQ3ZFubCZZHEJi6SkX7MhlKATMZtRdlj9o62_b0tZRs9NUy1pFx0koamRZJtg9ik
    BD8SEtE9nhfDhN0hQ>
X-ME-Received: <xmr:euQ3ZPA_75z525IbfTKGemoUVUAmgZwkGzvqB3IUtsx9bm-gerpLOPy61XMou7JM24fNUDlMfq-I6Jo6FF8QbEPjYfrwKdFYh4MALPHlf_TDCOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:euQ3ZFdFcxuFAHMZe_v5RVL49Iu-X6vHoX0yKFK9mQ_dpRq29y1MBA>
    <xmx:euQ3ZGN02NrATu3WuAsLfIe0N_N_7ej1APgmJznj4B2c603BFhvNDg>
    <xmx:euQ3ZHkc5Uy-UsGk0ciVEEB6UeHM7prKnlA6DIFbMOOPEbxQfdETbQ>
    <xmx:euQ3ZPaKSrJsLgR944irXvel6zynaTqQh4A4LP-C0UHGiymGmHk0Mg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:08 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 3ea7c0d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:15:45 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:06 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 01/10] midx: fix segfault with no packs and invalid
 preferred pack
Message-ID: <dd8145beade440e5444130d3a3189b2c5d15a911.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4vNzRKJbQEkxDjOe"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4vNzRKJbQEkxDjOe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When asked to write a multi-pack-index the user can specify a preferred
pack that is used as a tie breaker when multiple packs contain the same
objects. When this packfile cannot be found, we just pick the first pack
that is getting tracked by the newly written multi-pack-index as a
fallback.

Picking the fallback can fail in the case where we're asked to write a
multi-pack-index with no packfiles at all: picking the fallback value
will cause a segfault as we blindly index into the array of packfiles,
which would be empty.

Fix this bug by resetting the preferred packfile index to `-1` before
searching for the preferred pack. This fixes the segfault as we already
check for whether the index is `> - 1`. If it is not, we simply don't
pick a preferred packfile at all.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c                      |  6 +++---
 t/t5319-multi-pack-index.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 47989f7ea7..67eb617591 100644
--- a/midx.c
+++ b/midx.c
@@ -1328,17 +1328,17 @@ static int write_midx_internal(const char *object_d=
ir,
 	}
=20
 	if (preferred_pack_name) {
-		int found =3D 0;
+		ctx.preferred_pack_idx =3D -1;
+
 		for (i =3D 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
 						  ctx.info[i].pack_name)) {
 				ctx.preferred_pack_idx =3D i;
-				found =3D 1;
 				break;
 			}
 		}
=20
-		if (!found)
+		if (ctx.preferred_pack_idx =3D=3D -1)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
 	} else if (ctx.nr &&
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 499d5d4c78..0883c7c6bd 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -183,6 +183,18 @@ test_expect_success 'write midx with --stdin-packs' '
=20
 compare_results_with_midx "mixed mode (one pack + extra)"
=20
+test_expect_success 'write with no objects and preferred pack' '
+	test_when_finished "rm -rf empty" &&
+	git init empty &&
+	test_must_fail git -C empty multi-pack-index write \
+		--stdin-packs --preferred-pack=3Ddoes-not-exist </dev/null 2>err &&
+	cat >expect <<-EOF &&
+	warning: unknown preferred pack: ${SQ}does-not-exist${SQ}
+	error: no pack files to index.
+	EOF
+	test_cmp expect err
+'
+
 test_expect_success 'write progress off for redirected stderr' '
 	git multi-pack-index --object-dir=3D$objdir write 2>err &&
 	test_line_count =3D 0 err
--=20
2.40.0


--4vNzRKJbQEkxDjOe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35HUACgkQVbJhu7ck
PpRyAA/9HGSPklFXq+ny19x2BO8PAzQWkCeSJtQK0lwyWoBqpG+IOGGsLp/y9e1w
znBTFe/oKag4KhtqVGeffp1tpx4MbdRtLss2drRcqcr6E4oRCnjTtqTqMKzr352h
+15pxSXLPztjEoToXP692tnSYmmZKaAsoYHgUZrBKaioZypKK/NJD/r/KoPKvM+K
7xrH0qWhfoh+qKmPkHrip5t1DhpGrTMVslfADUxGmD90sMYqrBWpIzWScpnxTDLh
9f3zmlY2L+KjpRvhhzyg9uCEtLq5F+SU6CInXF2w6+4Pc22IAHTXceiweQYGsZkK
tqERgDzAtg8XxKvd6x2UpMR7F3xMkio0kToN7m1ifjvl//vU1HngbZau9CYaszAT
HnHo15dQuIVNO6S0pW6JmQXZCDY1oTyV7W7HAOGXN9MYw02M/0JrGO3YATYwHaRv
v6rtwXgfsYaTuw1KQuOZ9IyufvHQf9TZR0BuIyHFBk5im0xXBe81ptPdjiriFpmY
mB/3LStaVJ70Hy8MfpRDnRWxBdjEw/d58xLzSmOBg1OHk/goJEkrukRqwORFhxQK
a7cn6GAkSorwrc8Attv8p2DZRmVsteI/bY9Vd2+//Gr3G6L6hEvbTgwJSDk2HrP9
oFju/udtKqYec1h/tgqswbUHVGB1vE1U297gdo9MK4C8gf7E8z0=
=Vij1
-----END PGP SIGNATURE-----

--4vNzRKJbQEkxDjOe--
