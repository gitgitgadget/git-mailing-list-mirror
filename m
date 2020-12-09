Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC597C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8204623B77
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgLILxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:53:35 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33741 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731066AbgLILxX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2020 06:53:23 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AF5CBB59;
        Wed,  9 Dec 2020 06:52:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Dec 2020 06:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=0v8uJKr5K+51Uuj+eosH297hchp
        E+8VqZJPcxv7XLI0=; b=AsPxG+2BqW1Ii/aF4HZVI2Io2eQLAMQR7vpoR4ofQpn
        28sYA32YMLXN2W5OFdAgZ4wxhlFoHRxNdUlKoSGkCKkptDcqdY8Brh9n2pYEtSgP
        bzHlSB/Beabev/HTImcsrYCye3QOA962L/OIVjp4+4RtxEFpRxyBwZiTOOjricvx
        fq/BLw8GlUkLw2DrsNo+3aT2UUjsI5kafYkNNB7COjrhqkxr+Dbsxuc2KHbU+//x
        V4Jp81XWFc+M1ztzsPLdDXaVqZyFGKYrevBNPGCBh7+J89McgCHDpNx/4zqIQ4U4
        v5vMjeLVc1sgtj9pV8P44NdH/fY8sb6oO0/+Gdc6WeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0v8uJK
        r5K+51Uuj+eosH297hchpE+8VqZJPcxv7XLI0=; b=GPE6slzcoig0oGdbxgevcr
        ipGFV6YN4NAdmk4KMlwqWm/y2q/2u49FwyKsBLTt6jQxbwB96qUa0b2Bh1CzTlFV
        M6giosQ5xbYnWh48z7iq5DO+6WxILOJXvhKyYsTOWcO7wPO0GDzew3+Z5E64kWZW
        7+XdVuI+lMx8z+8MS4Amrb/u4ZDq762orKfFi3qoi92Du0o860+IJ68A7hz3zTMt
        BoqtjgCgvak1jJ3HJq+KN/VgZKLdM9vV6ZxZTMV3HSZaF3ziZHlQPoFMl02TO8pE
        j7PH6jzuLAAUnhwd883OJniUeTGvVTMVrGEaHkEszwdF5HuAG8jTGtVMgwDxzP+w
        ==
X-ME-Sender: <xms:hbrQX_WjJee_BL3YsLkcKLHlE77r7mmeVjS94VIWh30a930WuH8b-Q>
    <xme:hbrQX3kJJyAlILpQP6RxtYmNem6Cq-g_KsK9Lht0bTWN0mj7WLvAFM3gF_3XSZcxu
    uTubzBcL2zlesIPng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedriedurdduvdeknecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hbrQX7YWDmRlec5Fn1edYbNKVteyEmm2MjUdaqhPvaV58kJsCl6c3Q>
    <xmx:hbrQX6WbEkufFs_nAJqZ9MyLzl0En2K29-egyXSwx2jtqet4FUXGjA>
    <xmx:hbrQX5lHIn3OHf9mhaaDVLcS_9OzSh58pgQ8tC5PpSZJGs6scWWR9Q>
    <xmx:hbrQX_irB2AKmekZfjDoEpzps6wS9lBqSF8Z8HxRO0bvQl0N72rzrw>
Received: from vm-mail (dynamic-078-055-061-128.78.55.pool.telefonica.de [78.55.61.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6863C1080063;
        Wed,  9 Dec 2020 06:52:36 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id b512a87e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Dec 2020 11:52:35 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:52:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 4/6] config: extract function to parse config pairs
Message-ID: <63fb8ad99742d748dc00306be6d2e05bd0ed583d.1607514692.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qQ0XEB02XVmJNHQP"
Content-Disposition: inline
In-Reply-To: <cover.1607514692.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qQ0XEB02XVmJNHQP
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
index cde3511110..151980e5c9 100644
--- a/config.c
+++ b/config.c
@@ -458,11 +458,26 @@ int git_config_key_is_valid(const char *key)
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
@@ -483,12 +498,7 @@ int git_config_parse_parameter(const char *text,
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


--qQ0XEB02XVmJNHQP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/QuoEACgkQVbJhu7ck
PpQ1SRAAplD/jU5K/UesBqVrJCAl8On92LLHd7gItMHdB8aF2wbEOuVfvInNjmBQ
TSXuN076aEuTCfvoXiYZ8HEXFez+n/M8+2p6FFykeAKElz0Y/LnDC5elKPfFZZ+/
NXm7nluOtMrzhrMYg9UAqgZNNkddhDaWK146Zai7/eQzS/CCNxE/jk8Dig8Schbv
F2FzLMcxnVXaChxwEW9FQsYiU3Adblf8KhSRIWAYW+6XFpiDiizqUUSLNDrTcXAc
lvNR13UXmexXjGoSJc3T1qmLz/rARicmqfBd9q0oaEhiTbsq7ppAndyL9e7XaZTo
MXvFiHXc7/O1s9sb2pkq56XnN+0E6Yl7eSWZ6/k/rDj3tjRBRcmRCeZaW4mMtmh9
QDIpCAcwJsXRC3yFP6js9akCr1y2Ab2znCQ9zgblQUpFu8FsuZKMWeASBa9ONjTt
P7dvewoi4eSOFHCX1MciD6RcPm5ViuyzqB/9BkdsqtDNlIPwkeSB1w1PVN3+tM0N
E79zL+yal7K69KVQS/np3R162uxwIxhxUuNhzp7YzyWmGn6Z0O1Hct/yEH8Duhlq
V2K3RBkBiYcbApbZLZq9kfNRSbf+39RTP34jHO3K60ly8SVH3dddnR2bBZB6CbDN
14Ckev7wBTTXLshW122vkdAJGdFRiAVZfNks1oOKZAEzquR6JZA=
=AaU7
-----END PGP SIGNATURE-----

--qQ0XEB02XVmJNHQP--
