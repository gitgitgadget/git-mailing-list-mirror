Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40695C77B71
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjDLKXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjDLKXI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:23:08 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF27D89
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:23:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A8A1D3200984;
        Wed, 12 Apr 2023 06:23:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 06:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294984; x=1681381384; bh=br
        9prARjMcDuS9r+1lDr24rpMi1ZT2vNvswKW1/UsUU=; b=H70dU9eGWrcKnBXkWi
        FnejIh7WTDQVa1zg8uxfFbcypvAQ/Y2cyI80ovsoRlh7q0/mONPZQf2tu6e3uJ06
        73tNx4WKQ8Xl7BsYl83jB36RF8o+QHSBJIz+5HHnNGlKecmED3Am2jQRs3Ktg9YB
        YygwE1D0pjqbxsSfKcYbbGYKxpUBN0BZJiBNb26nRdUdI6XwH/G2xR6SomuvH66t
        f9I2Ln8YRcTlkvOX8C1k3GpDvqdEBL5/CgGb1JqwnILhB7uet8YFsWzL6IipJCX+
        Gq0dSm7tlmM+eS4VLS3ulpQPVz7R1AMhxaP2t6dnlgG5aFneJ+N7hGBYLvH/yTjm
        YzEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294984; x=1681381384; bh=br9prARjMcDuS
        9r+1lDr24rpMi1ZT2vNvswKW1/UsUU=; b=AlbL334gC6HzJ/iq5vpZetb6Wd0CE
        IwGNfZy5QNpDFPQ2xMeQ9jptGTZwjv4q+w72nmE9Nm02qBdX0TW3MwIkFuymESNq
        xW7Cu+zIq/bCr+nM2fg+UTHbgcIXClPEzi6pLbmXQtpTXpy29LHzbHSIheFOeNjd
        Nlb3Cqszow1Hna2w4ism2mrHGL7dkSbnipTaXlNBw1w3jJHiX8SlgTa6rUKUpZhu
        2/jqlytI5HzbLkw+TOcU+SNV796FrgzdINNPmR1WR0t6R1eoc1CkDxtTNP9UBPb4
        6VgHugx7fBxgZXyBbin7F/RmJOy/0vIOUWAX9yBU5TnWcctQI7qjLd4PQ==
X-ME-Sender: <xms:iIY2ZNCpJTXNYuGwaTNqhNkJw_9paBbK92uHdvaK4UyeanxQplnLTA>
    <xme:iIY2ZLhJUKsA9wrIA9LdQO2vl308mGSXkZ8W_VhYGy3Zd2N7jl9ChAzjYPaU4RO8v
    Pf89syA582bRsJKSw>
X-ME-Received: <xmr:iIY2ZIkLa5C1FRKEIEwausr_v7VDMGImJLOt4MQAGzRa_ZZcCNXf3kvUY1ne34imdL_v4uY_gCqA1Si4FARg9y7sJHoth7zQwqck2yxUoaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:iIY2ZHxrIF_8FQdDr_SVBO4M1cKNnpshjfleH9kZfpFJQS9JfR3hBQ>
    <xmx:iIY2ZCTw8nvqTZfx7MROsZZPadqa23tYNcPYnU7HkD5dy6d6IgAbVw>
    <xmx:iIY2ZKYzRyQeYpE0igJj-JY6VCWye2bouYFGKpgRdaHKtfO1VhvDDA>
    <xmx:iIY2ZNdddqvVSX4R7BY4_H9DB3DJ5ews8JSq6fyxDn_yXPJUrcOXQg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:23:02 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a4cc6bbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:42 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:23:01 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 8/8] repack: disable writing bitmaps when doing a local
 geometric repack
Message-ID: <b74d0a037b07706d07fad7b438fa0cb211726575.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="soGiN+iHKjbWApds"
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--soGiN+iHKjbWApds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to write a bitmap, we need to have full coverage of all objects
that are about to be packed. In the traditional non-multi-pack-index
world this meant we need to do a full repack of all objects into a
single packfile. But in the new multi-pack-index world we can get away
with writing bitmaps when we have multiple packfiles as long as the
multi-pack-index covers all objects.

This is not always the case though. When writing multi-pack-indices in a
repository that is connected to an alternate object directory we may end
up writing a multi-pack-index that only has partial coverage of objects.
The end result is that writing the bitmap will fail:

    $ git multi-pack-index write --stdin-packs --bitmap <packfiles
    warning: Failed to write bitmap index. Packfile doesn't have full closu=
re (object 1529341d78cf45377407369acb0f4ff2b5cdae42 is missing)
    error: could not write multi-pack bitmap

Now there are two different ways to fix this. The first one would be to
amend git-multi-pack-index(1) to disable writing bitmaps when we notice
that we don't have full object coverage. But we ain't really got enough
information there, and seeing that it is a low-level plumbing command it
does not feel like the right place to fix this.

We can easily fix it at a higher level in git-repack(1) though. When all
of the following conditions are true:

    - We are asked to write a multi-pack index with bitmaps.

    - We are asked to only include local objects via `-l`.

    - We are connected to an alternate repository that has packfiles.

Then we will override the user's ask and disable writing bitmaps with a
warning. This is similar to what we do in git-pack-objects(1), where we
also disable writing bitmaps in case we omit an object from the pack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 20 ++++++++++++++++++++
 t/t7703-repack-geometric.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index f57869f14a..07d92fdf87 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -881,6 +881,26 @@ int cmd_repack(int argc, const char **argv, const char=
 *prefix)
 	if (pack_kept_objects < 0)
 		pack_kept_objects =3D write_bitmaps > 0 && !write_midx;
=20
+	if (write_midx && write_bitmaps && geometric_factor && po_args.local) {
+		struct packed_git *p;
+
+		for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
+			if (p->pack_local)
+				continue;
+
+			/*
+			 * When asked to do a local repack, but we have
+			 * packfiles that are inherited from an alternate, then
+			 * we cannot guarantee that the multi-pack-index would
+			 * have full coverage of all objects. We thus disable
+			 * writing bitmaps in that case.
+			 */
+			warning(_("disabling bitmap writing, as some objects are not being pack=
ed"));
+			write_bitmaps =3D 0;
+			break;
+		}
+	}
+
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
=20
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 96c8d4cdfa..0aaec9f853 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -420,4 +420,31 @@ test_expect_success '--geometric -l with non-intact ge=
ometric sequence across OD
 	test_cmp expected-objects actual-objects.sorted
 '
=20
+test_expect_success '--geometric -l disables writing bitmaps with non-loca=
l packfiles' '
+	test_when_finished "rm -fr shared member" &&
+
+	git init shared &&
+	test_commit_bulk -C shared --start=3D1 1 &&
+
+	git clone --shared shared member &&
+	test_commit_bulk -C member --start=3D2 1 &&
+
+	# When performing a geometric repack with `-l` while connecting to an
+	# alternate object database that has a packfile we do not have full
+	# coverage of objects. As a result, we expect that writing the bitmap
+	# will be disabled.
+	git -C member repack -l --geometric=3D2 --write-midx --write-bitmap-index=
 2>err &&
+	cat >expect <<-EOF &&
+	warning: disabling bitmap writing, as some objects are not being packed
+	EOF
+	test_cmp expect err &&
+	test ! -f member/.git/objects/pack/multi-pack-index-*.bitmap &&
+
+	# On the other hand, when we repack without `-l`, we should see that
+	# the bitmap gets created.
+	git -C member repack --geometric=3D2 --write-midx --write-bitmap-index 2>=
err &&
+	test_must_be_empty err &&
+	test -f member/.git/objects/pack/multi-pack-index-*.bitmap
+'
+
 test_done
--=20
2.40.0


--soGiN+iHKjbWApds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hoQACgkQVbJhu7ck
PpTYtRAAqE1dOr4cjyfZsVbVZG//+0duqdlaV71gD8K+V/NENoEeQjxLBlvtzvHb
hxISTdSkldWwzvBW0jOlEIcmIZWsfg2a+uuJ2mfVTh3ZD83RjUGctJWEHq+O1GtA
f8hTcfyT0fEel7gLCVGnOxt080bu0c4AoM0mdajjakSRqkhC87kFHHVdZ1nRGWDl
AB1efeOfrP7pyyyRDo5jLhSDQN7jmh1L+ngDKgHjnmSr3zQZuPUgPQaA/BnmZgYm
0a7Ur7M70DhNysSIbib4HUCo8sxE5sNQQf0vDedg2o1O+QuFBciiV8zuB13PoHOj
09OrqXioNGvROFfv0hhVJrGiTcJw0JfPJ9fpQs5xoq/mIqdxcQ5ralefKoF7OmuW
kHs4VbG/wEygvS4f93NbPq93Dvw6KVmImzFKF0KCFExBDc91qoFJCINku0kxfBvR
69AH8z4TZ18sOZwomvyY8EjzpcdCtBf1WjnMWN3HEvRPsXmQBvCCFr58wP/EerzQ
Mnrca+MpvQsx3HLhCyx+dxzxvcYhg+BiipSNz1qWUE5Sdb/bKv57cQ0qjyMIIp5f
GoJGzu65qX/kbsl7PfD0b3bj/uWybFryboqf1SRMySqwa2NkiOhCar2IFgeyQyaW
W8nLprRxk0CE/Z826fYwipcacZUykDNC9fYB5hhybWci0XqgtcU=
=sI07
-----END PGP SIGNATURE-----

--soGiN+iHKjbWApds--
