Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E958C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0605F22240
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z9aqs2gD";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgdKYy+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgKMMQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:16:22 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39519 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbgKMMQV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 07:16:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5ADCDBDC
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:16:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 07:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=ruH50YMW6iPk9Ubh0rCgYbZphJKUcFDssaHXu+IY
        BJA=; b=Z9aqs2gD0p/gOvOM1h/ZdZ36DfZkP3qkHPWss8Pt8QoUulhcPiShOJAr
        6lRKMH2eFWXuQ8eWSLU2GAS93tw4qKwaku392K4A6kr+y4i5cmiNF8o2MNWyAW+1
        bMQLSCPr1fg8/dMSfud7yQooEHBEN2zRN4mWtNXX0o0S8JdX7Z6D7pN5l+MmZYIn
        mg9l4ijRkeiZOed7CuzC/qGcytmaeehUPaeEqfOIDXIemZ+mKDxqag3mFG9n2vKC
        fK1vu3nfPaC3pimCkb0Tkxka5RLIhIJtHKKukYkEF7QeTLKBOtpqLriAO/6AFe4V
        6ZbPGi8dQ5z/4vHhn1Aqy0mrlkMDVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ruH50Y
        MW6iPk9Ubh0rCgYbZphJKUcFDssaHXu+IYBJA=; b=LgdKYy+869REsfntxDnAiy
        3uCQRY4aOd51BC+cOMSJnG4oVxcuN2UT0mp/LPj6WMBaChLkf1dhpKy9pMdT3yWv
        lm02VQ9ZvN2nvs8SsD1JI7WvWVILjP1UJRr6DwEcy6D+VAD41hF8kbGuZTZia/kX
        W8Avda3BGvRNeF5GLPwtK69CtE2w1+3ynoK45bAip5vkuiuSMsBwCFHMJmJ75j1U
        8G+E3DMjrxb73qVuVGTMSkUy8cqsmbSl47zrgWo6p4axXeHll+IeWlry4TExxh5+
        hx0ZWDjohfgXlNNNBim8fApDbIFUsPGtHmEJj4MBJ//3YI9wdw7AjikwN6+X8DCg
        ==
X-ME-Sender: <xms:E3muXx1O_UT6tbFdOMHCFCcEffrsUiBu4_ekJFSqSfWH1g06DUtSHw>
    <xme:E3muX4FsumQRu4UQ3XdVjObZ36VmyGJaDv3EVwpW3kqu5-q-QeI86jNTol0YGfIZO
    Q_7u-XGUAOhPbgVqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdefuddrvdefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:E3muXx5xKD0urXg7Ki2iyaHyWdg2-gDlh31uu6zafQ_qnQhsSOCfxA>
    <xmx:E3muX-2JZPDV3q7HzpGPZrWG0-fKhxVp48XNod2DpAfTs8suZ2nt7Q>
    <xmx:E3muX0FseZfCj4vdis2DjGe8X1oeIaNToeezmN6YjaDFZnmT-NSilA>
    <xmx:FHmuX4R_rBFItR_I4VKkxPH_iYRhYSNuCIOPHYqbfCxK01aZm_oTGg>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 922603064AAA
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:16:19 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 44826035 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 13 Nov 2020 12:16:17 +0000 (UTC)
Date:   Fri, 13 Nov 2020 13:16:18 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] config: extract function to parse config pairs
Message-ID: <6ced4b2ddd21828a21e935942e2c3da4deb34705.1605269465.git.ps@pks.im>
References: <cover.1605269465.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ef2LyWXiw9aWieyP"
Content-Disposition: inline
In-Reply-To: <cover.1605269465.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ef2LyWXiw9aWieyP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `git_config_parse_parameter` is responsible for parsing a
`foo.bar=3Dbaz`-formatted configuration key, sanitizing the key and then
processing it via the given callback function. Given that we're about to
add a second user which is going to process keys in such which already
has keys and values separated, this commit extracts a function
`config_parse_pair` which only does the sanitization and processing
part.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 2bdff4457b..3281b1374e 100644
--- a/config.c
+++ b/config.c
@@ -437,11 +437,26 @@ int git_config_key_is_valid(const char *key)
 	return !git_config_parse_key_1(key, NULL, NULL, 1);
 }
=20
+static int config_parse_pair(const char *key, const char *value,
+			  config_fn_t fn, void *data)
+{
+	char *canonical_name;
+	int ret;
+
+	if (!strlen(key))
+		return error(_("empty config key"));
+	if (git_config_parse_key(key, &canonical_name, NULL))
+		return -1;
+
+	ret =3D (fn(canonical_name, value, data) < 0) ? -1 : 0;
+	free(canonical_name);
+	return ret;
+}
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
-	char *canonical_name;
 	struct strbuf **pair;
 	int ret;
=20
@@ -462,12 +477,7 @@ int git_config_parse_parameter(const char *text,
 		return error(_("bogus config parameter: %s"), text);
 	}
=20
-	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL)) {
-		ret =3D -1;
-	} else {
-		ret =3D (fn(canonical_name, value, data) < 0) ? -1 : 0;
-		free(canonical_name);
-	}
+	ret =3D config_parse_pair(pair[0]->buf, value, fn, data);
 	strbuf_list_free(pair);
 	return ret;
 }
--=20
2.29.2


--Ef2LyWXiw9aWieyP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ueREACgkQVbJhu7ck
PpQbIQ//XaoEx6YQY6LArXpTo5/23C2+lzmmjEBBObObKG0xW7fhKVlU7q2FYhh/
iUk+d5pRI/YtJr91mw30PggnK4GqL+bRCqHCFWXA2faXWoE/b+3RVhubqTRnVIko
XFI8dcZuoPuLofcj5i/U5g89aLVu1kHUX1OMoIo1OpS/BsAQNAbFaF6b/uOiXMID
Q+tmZDD1wpizGSqeVm3LywGCc4tCXOi/ewDcajxY3VlxYN9xWspl4CA8LywPxgmp
EqD1aJfWFtLUXH3vT/cIxNtxq/zX+qmCJkJVRaIA8KvTfn4neEC1Fun/Zo5SZiuR
B4yYkKvLwP90c9a0Xt2yqe17Wiag/cMhfMMdM1sYVuudxUhwl1qnFuaGOxjWbXd2
VLsjjkDccAkQTi5Rs3buKSRvd828/rqgr3/6dD3oRo2STTH32ymTgxNG3+cRbMzk
BR7q5qjs9mb1KNJHZkMfdulTXOzcYUaCHdOmAVFCNPRyx9I67zx32HFEaqemubub
LcvdVE7mDlNdChnJ8fz/rxiz5iOFpdkF4pc2J2Q8TYSmXYw4gcMbUl7RwLlAxdTV
jRs46UCBomeEIY1c5fB0oDiMjx0lYoZc+qexwH8EgQcrVv1qwIqV9PKVfsc4nOZG
6+fXm6T1n8UGLA95860QwKay1MC0ZRYVOBQImNSOF3lvNc4mgaU=
=JDXX
-----END PGP SIGNATURE-----

--Ef2LyWXiw9aWieyP--
