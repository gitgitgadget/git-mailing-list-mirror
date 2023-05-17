Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884EC77B7F
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjEQLss (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQLsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:48:47 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9806110F7
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:48:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0A1EC32002E2
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:48:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 17 May 2023 07:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324125; x=1684410525; bh=qx
        VQkp3JR+uYHDSqYll7CZyeq5skhRQVrOjiNidwb54=; b=ReCoM2UR2xJOXVEdNK
        tzufnTauxhO7/bHBYOomnIKV3EujjUsSQQ22q7/8nVUorb48mmBXq2alvageqI+a
        BYVoLCI/q26cT6WBa9+90mYzcFk8PfAUJZiTXGZrKx/anrWm2rFe5No/xTqI01fH
        gHYUAM6cmJIXsrFWETKQaGD21BiT02tBzkpn1j64jsS3hll4mGUf5FNju9kQfJrs
        DePoMyR7ygz+BvCOrIISNPygjEv+WpWPbnocyMef7b3MKVbS1Ys/xyAnOdlmH3sy
        o590ILdKI89KbgOcRrBXd+r2Tsk4VUTFOPmB4mURX+YW8e1b1+ImdbtDLe7dGd3D
        32EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324125; x=1684410525; bh=qxVQkp3JR+uYH
        DSqYll7CZyeq5skhRQVrOjiNidwb54=; b=ecOYEdUNIoKMUiFv4m4kAKDGS/FbB
        axhkPuvgS40fqn0wi8uuTTIFYuzSntY/6fzK8OUCxP9y/R5H3rS78glLBQUgLVuA
        coF/BWkVk4mIulvUa4huDZB/bty1JEvt6Zo/5fCodFLrQ2zv0OrzdrgtuEKyvPJK
        BLmI1zz6oMDmnrJek+P3kTkh62Ui0xKevU4mCO8W3jWMA/qvelK/LprcsuxQERbI
        E4CB1tUkNxN+7+o43kAHatQqyF4+02u3fZxr1nH0mVEDRE4sQUesLhtv0lQfPur3
        oxTkfng3gncqclkWe7LDWL1z4QEzHvPib1ldWzJgCcRgce0bOZyvoeK3g==
X-ME-Sender: <xms:Hb9kZN7lU0xLA3TnGfc0pJxoaTh_qPRlaF3lfx6Wj5KfST0Q9cYoKQ>
    <xme:Hb9kZK5v3JQaW4HsyplvF9XqGIF11TMjbz1_jblvBzSv5GF-_y_jS885gSt_FwXzg
    mBBhqqBuvY6QWWHlw>
X-ME-Received: <xmr:Hb9kZEc5-j1UOsBepfYjsKB_LsFASO_f_eK84_OmhQse00V8Sbn_xUvO4h-48u5uyV75jYUcdWxaveCxxXzi9U1WLrVKLEAbNKRftQgXoqP4Opac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Hb9kZGKZV9cBfXDz9XRTko3m_1u9M3oX34EJ7QdNFsdScE9nsOIQ3g>
    <xmx:Hb9kZBIftgLomWmMaaFp5ZyBkyQzePoR3-0Bz-d-y3eJNwgu8gebNA>
    <xmx:Hb9kZPwC9Igl3AtKdPnxu0JlxNtrj7k4eezhozEBanAEg9GKdeHpqQ>
    <xmx:Hb9kZEmqsb8MGFcoM5Dm-azIU5wviS9j4fjh1U74E4s751CaXXZOkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:48:44 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 34b74922 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:21 +0000 (UTC)
Date:   Wed, 17 May 2023 13:48:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/9] fetch: drop unused DISPLAY_FORMAT_UNKNOWN enum value
Message-ID: <9417a62e9bbd30d9350b65e5396a31f9cb7c60b6.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eN/HRfIvYlD6DM3"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0eN/HRfIvYlD6DM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With 50957937f9 (fetch: introduce `display_format` enum, 2023-05-10), a
new enumeration was introduced to determine the display format that is
to be used by git-fetch(1). The `DISPLAY_FORMAT_UNKNOWN` value isn't
ever used though, and neither do we rely on the explicit `0` value for
initialization anywhere.

Remove the enum value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 849a9be421..9147b700e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -58,7 +58,6 @@ enum {
 };
=20
 enum display_format {
-	DISPLAY_FORMAT_UNKNOWN =3D 0,
 	DISPLAY_FORMAT_FULL,
 	DISPLAY_FORMAT_COMPACT,
 	DISPLAY_FORMAT_PORCELAIN,
--=20
2.40.1


--0eN/HRfIvYlD6DM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvxkACgkQVbJhu7ck
PpQicw/7BoVUlsrnq7d/4+5xS3R2c61o2tP23xHaG8s5veh3p/4ECNVo22wys4HW
A24C2Sv9dTCsEfl2VNoOLvRNIgC+0ht2gBhcy+IjLJ8Cn6rZG0GIMichpfUTlDTO
d/dEkE4GwCPY4cinRvAw641dZi+jbCmlu3g9KEDJjkiHTpJzlKjBA7CIEewq0852
LTmPwBQChmbBlHs09VBMGJR26Q3RMmzz0Pnmn9doVxTkjnJ7U0m3N+5YJz+c9PwU
Aa+wi8QR57yN61MyFDuk9JlVxZsFTGQ6jZhV1nYmwnfOf/tAZxp5fd5GpF2Sal9W
HmqNg9iztfmC6pBaXoy2kwSvUE0x8gWFaI3Sqikq8hAYs64PqsCv3DTU3uIKc6WU
KPW2GIapuHBqZvDElwptfOPMeL3aov18Exhu1k7VQJ6kK2SdmTtGOPLlbNccMLaZ
sFl27ZcDDpO2uRkojqdnuC9g3pWns/6GOHMUvpA3n0b2SSm2RLH2g5KzQSCkWQAy
HCahPn9191014aYloyYULRu3Ho40dlUyyHG9N5sOWzoLadTC1kC3h2f5aUq35JE4
o1GXeyYiD95iEx1HdrlZjoZojvAmPZw50sLTN5Ar/SaoBFxvmU6hOEfwFK/LScna
4f5gFn96TNuebIqVXRqf40XFuzbYlfnUTgnvkYSSD2yQLV/OmmY=
=G9lE
-----END PGP SIGNATURE-----

--0eN/HRfIvYlD6DM3--
