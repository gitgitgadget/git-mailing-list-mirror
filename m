Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B0C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjCOLYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjCOLYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:24:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511ED7A91B
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:23:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D8BF65C0778
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 Mar 2023 07:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678879286; x=1678965686; bh=6P
        sezHLbaOahrxeDzZ7Bbr16bCQWUSGeE2hAekhrP8Y=; b=caZaVAU2lEtb+OolZm
        kGY9MZXsH6w7vKVDjoRiNUs0Oq9vZfpWt7wCmfKDChIIYa7JZpwrtjxLFyD3uP1F
        at7Rdb5b0XBK7HumLDgtTRgpTaUY6lBxlVMROv8Sa5cQxbhR06KG853liJOIOXHd
        kbEfEwGry6O/J2TOaELri4cKyQav7HdfC0McuZ85nI/pZaI8CAEikwFwm0+EymPT
        T8L0PxlErLCN92Yb2EWoKYjO5sL8kN/cmwGjnreRAenvWs5Gy8TCiDW79mrxbFw9
        wpqjAjT+iPz6C7/5Z0U132VzWA3RMvYebnyTaeSwzdTCh0OarGp32Lm7vdmUGYw0
        1pAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678879286; x=1678965686; bh=6PsezHLbaOahr
        xeDzZ7Bbr16bCQWUSGeE2hAekhrP8Y=; b=PZkDVJe20uZxG59Pvip7K9GEdwb65
        Ugb6kajDk6vfQcyoyfeGeiaCyCalBth9gWQyU5/9FRTAzA9SRuc1SCfkrmWPIyCa
        y2/Ue11JCAHp/U267R0t2JANEONEevO+4zcKVc1O0nVJGtuJ7EY/7SJiQAZil8Nq
        qhXpBmbD3Xua+z5E2QR0+NNdAZO1oqjebgoA7vaLVSE2fZpH4S/9bwRQjMwgvikj
        bJfv4hliNaJ1UQ/uoVpd/1nTyNJTS5YkO34tXJ562Z0W3SB9DPVO/2O6lU+LP4fJ
        7HirZYf5duMeqBO+Cq4jZrK347njul03+sWNu0Wr2wswmUnkH//Ocm+ZQ==
X-ME-Sender: <xms:NqoRZOdMqsl59yTeEiGCdvOddQFPRUNDOFj1uyz_W4GW4SFFn8Hz9g>
    <xme:NqoRZINkhF3NESfnJwH7BlU18ZvQnGdJ9-IBaDo4UVgGJtvpCSaL6DV0P3xzGdLxi
    Sm5vO_-_KYkNiJ_-w>
X-ME-Received: <xmr:NqoRZPjV0P1LVdnjilkv5tiV12qKJ1_x5NzDIyOd07QwP3oPcYZkEGCW1SfRiJoxNFTqKbGP_DdWoXFRFL5WvYT80Ictz2t9FK6NKeBFHT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:NqoRZL9Wq0fmg36E96QB_qIWnCzyOKyvERFUgOqJukRCmIlV7Zm5Lw>
    <xmx:NqoRZKtNO0rOU6_CDSk7XnPimArOBr4sdPruaPLJ_22wT8Yn30hYug>
    <xmx:NqoRZCFQkkeuo2zhNFN-8lzRGpolWIA9wo_E3MzO2z1pgKwQX0g1-A>
    <xmx:NqoRZL6EMZyAiq4ObNNVCmvTxZL74VH1zufTiLhjwPXCfXTtviyGZw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:26 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 52eca9bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:21:03 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:23 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 5/8] fetch: deduplicate handling of per-reference format
Message-ID: <d45ec31eeaf42ee042bad04efd69668144df3138.1678878623.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="44ljmHrwiEl4/HYy"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--44ljmHrwiEl4/HYy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both callsites that call `format_display()` and then print the result to
standard error use the same formatting directive " %s\n" to print the
reference to disk, thus duplicating a small part of the logic.

Refactor the code to handle this in `format_display()` itself. This
paves the way for handling the printing logic in that function
completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bf2f01245a..6fc2fd0d46 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -885,13 +885,14 @@ static void format_display(struct display_state *disp=
lay,
=20
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
-	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
+	strbuf_addf(display_buffer, " %c %-*s ", code, width, summary);
 	if (!display->compact_format)
 		print_remote_to_local(display, display_buffer, remote, prettify_refname(=
local));
 	else
 		print_compact(display, display_buffer, remote, prettify_refname(local));
 	if (error)
 		strbuf_addf(display_buffer, "  (%s)", error);
+	strbuf_addch(display_buffer, '\n');
 }
=20
 static int update_local_ref(struct ref *ref,
@@ -1271,7 +1272,7 @@ static int store_updated_refs(struct display_state *d=
isplay,
 							url_len, url);
 					shown_url =3D 1;
 				}
-				fprintf(stderr, " %s\n", note.buf);
+				fputs(note.buf, stderr);
 			}
 		}
 	}
@@ -1432,7 +1433,7 @@ static int prune_refs(struct display_state *display,
 			format_display(display, &sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), ref->name,
 				       summary_width);
-			fprintf(stderr, " %s\n",sb.buf);
+			fputs(sb.buf, stderr);
 			strbuf_release(&sb);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
--=20
2.40.0


--44ljmHrwiEl4/HYy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqjMACgkQVbJhu7ck
PpQRpQ/7BWAmJM/YRJlYXn7HZ13SByUpnNcPXJ2FpKpAnWDkCyE0Nt76jOacC1Lf
9kBrtq49nN4tcOvSEnGI8my/80LuAbW9f1W8k1x/IN4V3tRF2XMFIi0tL9qXoyyt
ovt0jBFNt0Yl/fPETer/u2KJv8uQwn1KKhd7Y4OM7LIr5BKhj484umsCl0d9HgWv
QBvKDpZLrc9bCq1RbRK+DXyUMREmi1Hjz8fSf6NMvguP6PGPdxmK1djY8Uv/d8PT
P1vXa09o1whREvLVXftQYO2QTrdyml3TkRpX9/RBs2Ghyc1iUSg2DktcJndt2Vup
aKIBS8rdVo1iMK7iVtDQ2dHvFJFaV/CtoNEciE3rLGV2RMMz6EAV/krlecwP7BcA
c8UXf0iPgKUC3HQPxYACZ83d0j+CBJGCtUEKHYlOAv5LvThxjdNMjAoGokUCc9dJ
+6fn9An3gBls0jh2AMn77BO6eor0AvyKf/dhKr0Nhp27SRTd845kXuhGuX/ykBkp
yCN2mSoPo+7cl/r9VRIKbYTAcl69LgwUmAy9jMmBGwDOHwqeD8yoS36I4Re5dKeK
hySSEVV1GwC2clEvwefCc7V1OBu6OGPF79VViF9S/Eo6tgH6dfpbJuiRn9inntIC
3bqgkF3GlbFqlO5gjq/kndJi2aRj4huAQFTB3UZ08lakSNLViTA=
=M4b2
-----END PGP SIGNATURE-----

--44ljmHrwiEl4/HYy--
