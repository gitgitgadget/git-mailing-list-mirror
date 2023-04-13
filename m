Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3E8C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDMLRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDMLQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:52 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ABBA24E
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 809BD5C0076;
        Thu, 13 Apr 2023 07:16:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 13 Apr 2023 07:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384591; x=1681470991; bh=9s
        qLGlAbOJqQ1Q/dr20+KitMYFnrWMdZfkZS7V6pQJ4=; b=Xw31XP3jIfe0wxYuno
        pvK7GjfUwx4t8aTPpI5levuQJb80RKH25xBhYvMCm8qtUgirvHCYadKXCebQGiPm
        l0WxEgJdm98PG1JgZpgF4f/zitHfzmsQXehdilq2vMoMqcx/LOGMHeBn0+7BaACw
        AN/Dnl3+hCb8RwWid28XL8E4oV28zY3HJOdnlGKmPfjLzTBDHYAAXjonLx7h8Rbe
        /wW/UHxOmiQ7plf/x1COBFWz1ABEfcAvp0MqjJxLqC7MkBGjOfWLD4Hda4jjf1Uw
        2VEFH5vKzwD40vJ84rd4SgkG2IF8er1Wwp1u9U8KnUMDlYen122tQha+Xbyii1WG
        e56Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384591; x=1681470991; bh=9sqLGlAbOJqQ1
        Q/dr20+KitMYFnrWMdZfkZS7V6pQJ4=; b=a3freVCd7OKzRFiwHXFETe6borLQ+
        aA7ZYhKb8SCZ8sBYYTrqJ+IlnAaF+IW1w/30D/g30H/z7PbfCyzCjY3PaJXXhDtI
        YNiyq1FGGgdzk7hP+rbcD7OJsK4+nADoCak961dOENZxFA4UzcaR8l2Z3rK2Fm9g
        ylmR2a6cdXq0b8xZcUoVnRwlvcBSyXEEwbwRVBpUmVouuy/ovktMsYjhaKM6P/pd
        oKhctRuRTIFAVW8w8alJdJKf8L2M5KBNuF5DXPlJiT7EhC9cgAaymTwS5A27IL3u
        VlIoTCBhLmUlX1rOS3/KKkhX5K8e1aJLRQuqgyxUFyuEhW069d4CF7QYA==
X-ME-Sender: <xms:j-Q3ZBBjqdmfSoEOt3PJZzzxZCNuD-C3kL-s9sXpVh01IoZ4qpkGhw>
    <xme:j-Q3ZPip1VarzYb_rxT3wEvbmRXE_JLTcj4ZurMvq68C5B50UbDn2KKOdrJPbO7YJ
    O-7HsU_AJEwE3BVag>
X-ME-Received: <xmr:j-Q3ZMmGrqdBFACCcvlwxA4GwMmP1-wKe2B8CFSx6lbwRwK-9XMPc181_C40lvpzu7X_uaSFo9CjkBN2YMGLmszBLXYaOpUifJAeUF8BW5cHIhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:j-Q3ZLxllwZpi8HCdssEBRvD_H8ujRHST11tsN4vpJ6Oq7wwRuRGSw>
    <xmx:j-Q3ZGT9cOES-SMwNStNtC6Vgr2USDToVqakm8PZCSN75q5t2ezHqg>
    <xmx:j-Q3ZOZX2lEZoIumHvo01gubptzS5ecSAGOEuFSYbSne8PM5PADnkQ>
    <xmx:j-Q3ZBfTMLXUd0ZTSIGdarM_LtRvnNbIx-ikXRHUMgy3eV1LyopmDw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:29 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e97d63e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:16:07 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:28 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 06/10] pack-objects: fix error when same packfile is
 included and excluded
Message-ID: <afd7c7864d61c43292889c93495a28742dfa00ab.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2FXObb9nIx0MvvEw"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2FXObb9nIx0MvvEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing the same packfile both as included and excluded via the
`--stdin-packs` option, then we will return an error because the
excluded packfile cannot be found. This is because we will only set the
`util` pointer for the included packfile list if it was found, so that
we later die when we notice that it's in fact not set for the excluded
packfile list.

Fix this bug by always setting the `util` pointer for both the included
and excluded list entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        |  8 +++-----
 t/t5331-pack-objects-stdin.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7d0e864c35..c5147d392f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3355,11 +3355,9 @@ static void read_packs_list_from_stdin(void)
 	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		const char *pack_name =3D pack_basename(p);
=20
-		item =3D string_list_lookup(&include_packs, pack_name);
-		if (!item)
-			item =3D string_list_lookup(&exclude_packs, pack_name);
-
-		if (item)
+		if ((item =3D string_list_lookup(&include_packs, pack_name)))
+			item->util =3D p;
+		if ((item =3D string_list_lookup(&exclude_packs, pack_name)))
 			item->util =3D p;
 	}
=20
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index def7640c91..1e23cc2e61 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -169,4 +169,24 @@ test_expect_success 'pack-objects --stdin with duplica=
te packfile' '
 	)
 '
=20
+test_expect_success 'pack-objects --stdin with same packfile excluded and =
included' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		test_commit "commit" &&
+		git repack -ad &&
+
+		{
+			basename .git/objects/pack/pack-*.pack &&
+			printf "^%s\n" "$(basename .git/objects/pack/pack-*.pack)"
+		} >packfiles &&
+
+		git pack-objects --stdin-packs generated-pack <packfiles &&
+		packed_objects generated-pack-*.idx >packed-objects &&
+		test_must_be_empty packed-objects
+	)
+'
+
 test_done
--=20
2.40.0


--2FXObb9nIx0MvvEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35IsACgkQVbJhu7ck
PpQC1w//ZlTymfAR+ge5F59j9mkRYZgizUMHBGaYfLfOFB3gHJp+u8qnA2As2jnI
7/X5pA1jAZYdh5QnKKZaIK8snhR2UJwpSCp3zgcSV7PU67oCLj7U7MDHMmo7fypj
iClkOaiFZwtF9BirM+odZKz6U3hXIclSyGThSk9axWPqxqLQ6nF0it2CdquAtYa7
849v9uAAVsXF1sIFzJc6yyNoZ7FtHcFrMmWmn4/zxEw7vrdN8f5odObge2VdYqUk
mvWHTtBf5fe397+CuP/t5WFu0N0eWCUlBK5qbBoZS8jH1WG1K7WpN+A1qiirGcAi
dAfBMhjR8cRkdZLayGL4zbAvMHApSka96oJZjkAhgT9aMcqJTdQEXnA4onVzDKsh
ktiKVr8HWnhr/vIlclyVFGsMBq0aHbJbM8VgijR4b48OaMVS+ZupJnxGp6WTUSpp
ZB1FHxk6eWRVPtzbBf9OO+aleSQMGWlFQJDHHlu7usFDctvTehqRdgrNhbF8/Xak
z39rIda/nc7AkKac93ZUOg5/rJJRhJDlCPneScMGWYHZIquvy2cnNXN8j668qRFg
hnHqawoAQ0cY/wjNcd94hJUV0H6iVXus9OpDdmGkFazyFef2cUTkT6600wRaaDzO
gmyoP6ZEM7qmiMa31+kcLlXUR4NsagMxt8ErCVKHoP9xhF6B/Kw=
=guWV
-----END PGP SIGNATURE-----

--2FXObb9nIx0MvvEw--
