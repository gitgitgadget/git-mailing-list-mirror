Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F238C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjDLKWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjDLKWi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:22:38 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C146E86
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:22:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1A9283200979;
        Wed, 12 Apr 2023 06:22:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Apr 2023 06:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294955; x=1681381355; bh=ZO
        ulI9eTvPJ9mLVAQ9N04IyJwCVTvNCP0mGWIoNXvNk=; b=HRewMT62A3UEACzJPh
        9T+IRuZLATbZfbY8DITDeOyv5LlQwhDDNh118jn/PbFrRv+5SufebCuDgpdKCqiA
        1cnFNwa2iEw/zSFvEtDCyH2Wt3RqbqkFM+kHiLzRuZWDNlNdpwFMcZo9xBVuFour
        q13C/fCSDLk2vxKkMq0l9J3kwncOdyHcd2G3qoGO1YMuHBbHhk1wMhHHi2soS0Ms
        V4mqu0stW9lFhMtaSB5BUoajazUDtGi/5ZfNYH9ZncQ3DC8NoPm2D7bvgjOu2lXG
        ldcrtVZ+7gKh/0xcDswqB7YG0hp0iq0jqy0Y6l83gUSAXbcmDPuXdTLaacWPFesh
        PWTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294955; x=1681381355; bh=ZOulI9eTvPJ9m
        LVAQ9N04IyJwCVTvNCP0mGWIoNXvNk=; b=MtZDz8Wxw/rZhqwpnXq4e31PFELPJ
        QGV1H0DgdQX2Y4vmvhss/pHXvLWBRZZGBoFGg8xIY8vQd+4zjVTPM7FlzOlL2SmZ
        2ynWDKYwApKaWuu/oZLtcZmzsxVhSw0CxyNDyw/nA6+BzBwh/+QQDEPTSnpQhmwr
        soBYXZ/bo0iMPR3wYZEeNBOpXn2zW8rJqvstvRG6C+iqDpSGALXVzE3lbeaqYUaL
        QT8vr2XnXsKpBNKNmhR9lBuWUp+bC/S1SEEGdVU7IPNFHMVFpyDrPR/Yn0jVFJHm
        wD6HqelzyxofDe75P2yvgXdo5CFs8v3cZCYd9whWXVjSwoGcMD0g7GT/A==
X-ME-Sender: <xms:a4Y2ZMKfUPXGqSC-DEyhE5a_TpjG0IlgnUHEvRPvLejUlK1Wqb0cJQ>
    <xme:a4Y2ZMJtqq16duJZ_WGtMBAlk8QMgqZX2NcU0Tt6CEfEStjf3kt0XMnwcwHtnWidp
    hdhTctseG0K86pTPQ>
X-ME-Received: <xmr:a4Y2ZMtfZXK88BDFwJS-UUF5cTgHG_B2klLe9gEY9XUzdndBaRTqaeKTCfMG4CCh_9kpopH0CPcxVzCj7HuHb0A70heTfw36e5unwcic10A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:a4Y2ZJaXQWc7CJ5XV_SemoxZerQZ45c7ANjo7TAW_NLcTLQDvUfHwg>
    <xmx:a4Y2ZDYTqvPnkisC9TaeXtNNSsZKhtyXDTiDlujncybe4WU3OffBhg>
    <xmx:a4Y2ZFBOW5dBuOlnIMkLEtsR188CyWiYrTBm2zCgsglDeqBTS0jsuw>
    <xmx:a4Y2ZCkRdBjwDYZewyNqVDi1n3lcuECkRfAG5t8ZOaEXqYf5ZYoi_w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:22:34 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f124c3ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:12 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:22:31 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 1/8] midx: fix segfault with no packs and invalid
 preferred pack
Message-ID: <5ecad306b42441fa7d4f50bdfb9c09ccce22b6c9.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rZVfsRdiY3OuqvyW"
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rZVfsRdiY3OuqvyW
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

Fix this bug by exiting early in case we have determined that the MIDX
wouldn't have any packfiles to index. While the request itself does not
make much sense anyway, it is still preferable to exit gracefully than
to abort.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c                      |  6 ++++++
 t/t5319-multi-pack-index.sh | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/midx.c b/midx.c
index 9af3e5de88..22ea7ffb75 100644
--- a/midx.c
+++ b/midx.c
@@ -1307,6 +1307,12 @@ static int write_midx_internal(const char *object_di=
r,
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
=20
+	if (!ctx.nr) {
+		error(_("no pack files to index."));
+		result =3D 1;
+		goto cleanup;
+	}
+
 	if ((ctx.m && ctx.nr =3D=3D ctx.m->num_packs) &&
 	    !(packs_to_include || packs_to_drop)) {
 		struct bitmap_index *bitmap_git;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 499d5d4c78..be7f3c1e1f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -183,6 +183,17 @@ test_expect_success 'write midx with --stdin-packs' '
=20
 compare_results_with_midx "mixed mode (one pack + extra)"
=20
+test_expect_success 'write with no objects and preferred pack' '
+	test_when_finished "rm -rf empty" &&
+	git init empty &&
+	test_must_fail git -C empty multi-pack-index write \
+		--stdin-packs --preferred-pack=3Ddoes-not-exist </dev/null 2>err &&
+	cat >expect <<-EOF &&
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


--rZVfsRdiY3OuqvyW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hmYACgkQVbJhu7ck
PpQZ+xAAn1aKA7n1HDMgirkQL3nFEricVlihLt030maqo4auh6M6c4Wwms1ljCdm
Q/7U+ZqJesgRCYCisxdEV9y5ts9kkXGggG5+HsIBXuL5MeoSFP08oCkO+6g0S2ux
gArRFuTOlgXxv+HT4bt/MbBhiQ6jGFNd1oj7wxyeAMei/dnNgNo5RwUCeQmSh0nF
IJtSGJ7Csig2vUaLDv5LBNNlshT2W7wMnuwKlE1QfIb2LYLQKfNOnbrtoGky4EpJ
hxLjD6gcQgL3HDN/QkuNvfl72QTwGy2f47gn1SkzVcm/5T4r+3m8sCWZUmqCDIR7
ZZnwWhPG1l12rYyTcrJrIk00ki8AVMkle6UmkwF9PtzR8kbOvEcC4Vm7SY2lwBmC
tC32BcShACNHRwnHP5VfWzvn8trHBCrN5Lrb11Ue7leOlVebpS+RZ9mlYxq+oJBD
AtfhTgD0uCgmui/6IQyxz1xEWT+7imgMaKmO22P0J6L5iZEcZVXroU/ewCVWbEEy
of1nZTgxEb8XDGPJwn7EYhUikiZ/uDPC/47OyT3K4YFqp9dwClWMkVeWZ8gZqvjG
XQCuf72ziGqCaNTvXmS+dA1KsDsCxXaSObE1opUoB81v+NusrmG5tQoV5dNlpoDC
nZvy8zB4XdoKLgVadyxNZHCUCdeztGGsROd60P7ZrGd/ZeumVOc=
=EnT6
-----END PGP SIGNATURE-----

--rZVfsRdiY3OuqvyW--
