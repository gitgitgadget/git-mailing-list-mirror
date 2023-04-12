Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F5C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjDLKWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjDLKWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:22:45 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5DC6EBD
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:22:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DD8DD3200981;
        Wed, 12 Apr 2023 06:22:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Apr 2023 06:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294963; x=1681381363; bh=yp
        c49vVdqlAZMXiFXzWnvH1mbc2r5EThPDLy6Wx/pxE=; b=Bwbotga8iDyaUzmWz5
        H/v10PGUdr3X+vrn6ZxNLKX67NW/mdREfo59N4JGSyNFzc3CjPGmBcFJqa7ZVQaH
        NRxEy1MX+9AlgAb+noAaDZNCTqHZ7wVb+YCuEitLDu+G6fICYXjByPSQQ7ZJLmA1
        QmDZCuuzRY9w1OwondgJ8yzygipOnQvJknZWfWwFvyB/GjDXR1sGlof/R20Vq/Ji
        PkSP78cTk3pzrqp9G8qyqGw6NUCCunod5H1gdMqyl5jHiG33/rvXcQdvF7D56J1k
        CHD4LvSDRffILc4EsCkFzmUi9uBoh22yUTfEFxUpxlksNSEOk+9KYzwA69p4gUWC
        3jQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294963; x=1681381363; bh=ypc49vVdqlAZM
        XiFXzWnvH1mbc2r5EThPDLy6Wx/pxE=; b=fKEXZrBMCGAza3BYI6C47q1iHykX1
        JFdw/8tASemOIBoynIhLDqpYzHNOOPr9B+WMonUEAi+V/o7TkFw15Dg9bjJRyAHD
        HHdItTKLLavWHwQYzhpOuGJ7wY6B1wN91Ldcbwntsq8IVg1fXEtCZeLzdAx+9TXl
        kSwmhO3ZuLgY48u2Gnz9z4MBVlP/4Ddi+a66IHFbZS2w3Fg3WbwIYDnEumRZHWqM
        Snv+zHopdQAHYCxfn0e+xAQl/WmZ24xgqRI52qSGxK2MRn0K4ATAqfaHH6eG4FpP
        dSpKoP8DmsodfksnsoD1HxyAMNSaYrpudV7Nl4WEMRSfshaNtaFmz1qfw==
X-ME-Sender: <xms:c4Y2ZCtzzUvwZlw5FIVJfGqvuHo9HGg2_msT1ZI7F6zb3Hya0YTjBQ>
    <xme:c4Y2ZHfHjJnOaKEiMSCP7IwvCmW2eQ7mAqfvQw1hsSab05kI_Zrb_H6yBNVG0oOhb
    rI64FwgzmcavLevPQ>
X-ME-Received: <xmr:c4Y2ZNwvOufWiMhPSfXOU2woXHgjMHBhxuV7c9m_1WWUJPmuI_0ILksHpTVKPTNiaKMDtQbQXFBB2WM79rjs9xz1DGyETlWsnnML4SicR94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:c4Y2ZNN0eebvZOlAOmNUBcNNHgj4aaN2Hms_w-9KYqBXodszZloGsA>
    <xmx:c4Y2ZC8UdCmbJgugeLTmPMVWHobFHOc0i_5VfcS1lMSeXYC0JOU7pQ>
    <xmx:c4Y2ZFVuyc5EksR-uopX1qp2icFwE3UTVHFI03hf_foHagCVo4ysXg>
    <xmx:c4Y2ZELYFUnP9nM5UGIdv4nFlJ15C9wQmd5V8Ub33WSuCcYvxwvX6A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:22:42 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 2bbc1714 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:21 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:22:39 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 3/8] repack: fix generating multi-pack-index with only
 non-local packs
Message-ID: <f82e44f1da47890b7ef6ee2f5c1cdbbe20fa6684.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PThte7CiDoE/kR5c"
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PThte7CiDoE/kR5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When writing the multi-pack-index with geometric repacking we will add
all packfiles to the index that are part of the geometric sequence. This
can potentially also include packfiles borrowed from an alternate object
directory. But given that a multi-pack-index can only ever include packs
that are part of the main object database this does not make much sense
whatsoever.

In the edge case where all packfiles are contained in the alternate
object database and the local repository has none itself this bug can
cause us to invoke git-multi-pack-index(1) with only non-local packfiles
that it ultimately cannot find. This causes it to return an error and
thus causes the geometric repack to fail.

Fix the code to skip non-local packfiles.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 11 +++++++++++
 t/t7703-repack-geometric.sh | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 9d36dc8b84..80d4e813c8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -569,6 +569,17 @@ static void midx_included_packs(struct string_list *in=
clude,
 		for (i =3D geometry->split; i < geometry->pack_nr; i++) {
 			struct packed_git *p =3D geometry->pack[i];
=20
+			/*
+			 * The multi-pack index never refers to packfiles part
+			 * of an alternate object database, so we skip these.
+			 * While git-multi-pack-index(1) would silently ignore
+			 * them anyway, this allows us to skip executing the
+			 * command completely when we have only non-local
+			 * packfiles.
+			 */
+			if (!p->pack_local)
+				continue;
+
 			strbuf_addstr(&buf, pack_basename(p));
 			strbuf_strip_suffix(&buf, ".pack");
 			strbuf_addstr(&buf, ".idx");
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 92a1aaa754..9e95350cbf 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -312,4 +312,28 @@ test_expect_success '--geometric --write-midx with pac=
kfiles in main and alterna
 	git -C member multi-pack-index verify
 '
=20
+test_expect_success '--geometric --with-midx with no local objects' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Create a repository with a single packfile that acts as alternate
+	# object database.
+	git init shared &&
+	test_commit -C shared "shared-objects" &&
+	git -C shared repack -ad &&
+
+	# Create a second repository linked to the first one and perform a
+	# geometric repack on it.
+	git clone --shared shared member &&
+	git -C member repack --geometric 2 --write-midx 2>err &&
+	test_must_be_empty err &&
+
+	# Assert that we wrote neither a new packfile nor a multi-pack-index.
+	# We should not have a packfile because the single packfile in the
+	# alternate object database does not invalidate the geometric sequence.
+	# And we should not have a multi-pack-index because these only index
+	# local packfiles, and there are none.
+	find member/.git/objects/pack -type f >actual &&
+	test_must_be_empty actual
+'
+
 test_done
--=20
2.40.0


--PThte7CiDoE/kR5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hm4ACgkQVbJhu7ck
PpQTjg//Wf5z6yAFPN9OIy5zn9YufpNWOvCK+OAu//3jCI2Uwx6XH+3gCVPYSqYU
VEGU5vZCKnzI4OmwiXYJMn44wAzgUlWacgH9OqI2I4hzwrXKIQLJ/xkwQV6Pl4I7
cTnE0lhqv+1xN2g2NlBWje/vA3/P9MgbxzbOr0764l04tJENtpbpXAMxZdkqprRs
LRFjGf1Ck+NjI0CNW20tOXvtqyg5x5A07ko6qXARkhPRbv5TslcFvgqr1CHX4gkS
vqrhpHZY0GI0t+Ut7dTNJvwlJGxqA/2NREc7QFI/VSa1Nk7jDMKGYbeykAclI+sU
w4jmU3udf7fD0tH6W/sdQHTM4CmgT4sty0MmNpbwn+RNypMlJgw6UeS6p+7iQauU
TdUe9rpRzSMEZjq/1bPWd6AyvfamUyrgbVF9vtFgUxN16UJLa223HwNL8Ln9/UmG
9Rgc/+KDX4F19uKzFJnIb11rUu08zqSBa6vkb9x8uViAkou1l4KKBIhvA1QsGPIY
89+3C2VOF+VsiTonqxXAZJN2bL+Shb9I1Eeo+uN3swSBrpeM0HUG4ERpmiwSsek+
OyzFNB55aQ4qkoIxuUo1TU9UIcxQMqYf/BtRpPdRWwi35OraHxNHYPizWc9Rc4PS
po1jA7r75AwHMpSDzMnesF6SqbzhT/XLtXWXn9LyfRMHcid3Pn8=
=eewg
-----END PGP SIGNATURE-----

--PThte7CiDoE/kR5c--
