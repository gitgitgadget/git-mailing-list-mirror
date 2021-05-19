Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA45DC43460
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF4B6135A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhESTPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:15:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45657 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhESTPB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:15:01 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BB3555C00E4
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 May 2021 15:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=8syEP58N1OpoHFUpudab6VLfAK4BVvwzE8lkgyNe
        anA=; b=MvfCSjDTRqQxmVxIWdHFDk+7Bka9VKrhvhz+4+xEurmeXDAWS4O9+kLH
        Wj12swrzyZS3wI+cZ0v40vA/Ka4eicKV8ZWEm6s+LLq5Qo7HSX8j6NZymXFwXooF
        DiG+DlkBTfy/aAkWBK7TW6SfgR0rFGf7yAhzvQ5MTDwzr7Ra7YRtXhCSlcCEL15s
        X9Tbkr4NOuWk0+qx3DUKE3x+VZ9qVVVhv2aC8PV17r4elss7jBNDivG9e8JQSGd7
        gt3vdR1hIszglnj+vjppfIyDNb3ayaF4TfB/mablMhgR7lvpLop8jyqhGWVy+XcQ
        1NMHmQf7OF9S3wcm3sdx8Pl4V9PdqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8syEP5
        8N1OpoHFUpudab6VLfAK4BVvwzE8lkgyNeanA=; b=pbsL4Gq/YXyYKZEIXbYoQK
        a2941sUTF8Qq3Mn5Zd53kmfhZwkWvK0qZIPCeN/EqxbShKj5KY6WofBW5QqYGhCd
        B09GQFplmUAUagRy2owyW+rolyUpwsPWJ3838/mOYz+ziKp1jHCLeuPbJNrHVNFb
        VnVJBnb9va9/r7FZx8eEIQMCxnd7ZbTRldNG5nndtGvwSGNdkzQ2CXQ6Kl74mhfp
        7xCrhM8xPqx85xbT1CZ9dyC6DPU6tv9c88VY56PiB008KNz2hU9HkDejIlRGjA+j
        QKDzD7I1ZMt9rNJlDVfJTt2g+ExU1yeFOePO4+LGWfmUV7Z0XSJx/9xkFuzGa6PQ
        ==
X-ME-Sender: <xms:ZWOlYFXBRPtMXesNrvUVGh6JO7HMOvW6h-wzWC0vnRQIQ1IceMVAiQ>
    <xme:ZWOlYFnLSvrtY2QLxnREXF2eSFKC3BD-53sBz7l1oi5JYn_nUlzY5xQqYqm-O8cdU
    nJpoCExUm5k1mPF_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdefjedrudehieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ZWOlYBbj9l8_mxvKQaXvwEC3ZUlEN6PN8H61La7JmTEym8yZCt9YBQ>
    <xmx:ZWOlYIXgT12DDuzEvOaFWqFrMNQ5oWtUnYMoWHBB0UGIBlE1180Wwg>
    <xmx:ZWOlYPnamQu9CLK7TCxLUZZyxhLB5J85YUa2rS3kS1eB1DIMiM32OA>
    <xmx:ZWOlYLwhimDSrnzY1pweCppMjg0VUAHQqdhnL3STgcFXeojky47KaA>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:41 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a6964163 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:40 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:39 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 5/8] object-file: allow reading loose objects without reading
 their contents
Message-ID: <e26ff58e926dfc6aec15794a68981d6e455cb305.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dIbtYnkcf+scgVlX"
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dIbtYnkcf+scgVlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to add a new implementation of the connectivity check via
the object quarantine directory, which will directly iterate over any
loose object via their paths. For optimization purposes, we'll want to
skip over any loose blobs, but right now there's no easy way to read a
loose object without also slurping in all its contents.

Fix this shortcoming by modifying `read_loose_object()` such that it can
handle the case where no pointer for `contents` was passed in. If so,
then we'll simply skip reading the loose object.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 884855b9df..ab695823fd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2552,7 +2552,8 @@ int read_loose_object(const char *path,
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
=20
-	*contents =3D NULL;
+	if (contents)
+		*contents =3D NULL;
=20
 	map =3D map_loose_object_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
@@ -2572,6 +2573,12 @@ int read_loose_object(const char *path,
 		goto out;
 	}
=20
+	if (!contents) {
+		git_inflate_end(&stream);
+		ret =3D 0;
+		goto out;
+	}
+
 	if (*type =3D=3D OBJ_BLOB && *size > big_file_threshold) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
 			goto out;
--=20
2.31.1


--dIbtYnkcf+scgVlX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY2IACgkQVbJhu7ck
PpSBJQ//Sb4VAn6p/3JdmNgRBg8mObPIHCEzSKdm2RiNkVhx3L7yzXNbhT5/7uxD
ahxAXMOG8EC0qT3+uhvWRytxIsPvEG/MgkzMJlEeCONtOxfcZQaKR544TuN+WRSa
Gz9LWqkJxN1N9WMnhL54mtAk0Om/QQvv+ZwTaeDLudJ/tZqwf1+u+olDBj5iD1Bi
TF7oArq29cnKh1Y59YnDwA/PKm/5P0hTfXxS7TmBdBvWsVI3SQS5AbVfr2aC8+nd
E0BasClJHiEaI63oFjUlIKyZN4b92AlfYcPXgSLIKTb6fkvxc6B9SvwxwO4m4ilZ
ASn6A2m+PGXN5FkWbiCwsh7c2yFvcvZgUeiI2pFq7WSWnTT+W2kYsjA0qUCKbmOz
ptTnrhUg/7uX/U6WQ9pm+f8JaFiapTeih02a3LwN0vWazKDnW8vawgrh2ztJuwyA
Zp6u7IxP7DB8OfLk0o2VtnaQ9UKqEHMhPa+h6wNJFYBO0J7SO+Q4/IiDXxZPed7W
wU362wX5FJfP22m9uTlF4Kt3VruO9Wd9fGhpQ7UohenUvwZ49WSV4g/8pV57v5fx
BdKkbFJV0LPKePljlf2bthNDVapD1ohwH3aCnxUpZbQ4M/0hfDJk6wrckd+2rdmB
FtVXCGzPP5PSlPv3q+Ot8Pli6JfyCxnp6JkcmjSbO525ZJ1C+jw=
=nD3I
-----END PGP SIGNATURE-----

--dIbtYnkcf+scgVlX--
