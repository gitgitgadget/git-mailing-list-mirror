Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877BC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 19:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjDDTxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 15:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjDDTxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 15:53:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7AF4ED7
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 12:53:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m2so34012799wrh.6
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680637987; x=1683229987;
        h=in-reply-to:references:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emtwFo3RuQuDTBDh17RfUPAyuaSUxjRjJfTdGuzO+iQ=;
        b=FE2gLFb5VotKZIS9oAXNDnvQg8yUHm4r6Gxy03VJytgXCZvyVJvngBk7f5a1M+/6V9
         kltUGZZEYZdhYqmMXgNzVpYETrwO90faptm8rmt+yMd177wL+ZOEcr1EKf+WhYLMfVmb
         BVh5UtqGRK6Z3GRmn+DrgkxWoLhzPPypgb9hCz7Jh8KZPJ/dek1mocJ8Y8nzy4A6nZUU
         k24wquGGxcN3dJ8mjqXH1PwLcTSmRKuTw3SwvhErWqUvIwdpZoU0h9vcJKWvWMxzeeAQ
         J445dLXTxiAeWNUJ6kThWBbzZNmg4vRWzRsjqbhpSrhyHpu7x2D8u4tENr2sg8nUeN1k
         UUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637987; x=1683229987;
        h=in-reply-to:references:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=emtwFo3RuQuDTBDh17RfUPAyuaSUxjRjJfTdGuzO+iQ=;
        b=0GCBXOv4exVzXI/a65H3xJy0HNUGMDhUyM/zccsWLyaGTEpUfUZxupSy6WZz2+EjSZ
         +bZLyzjyb1eZpL/JfXj1WLEZynzRTUi+QVIPp/+VgZWPknzw7n4u0blvftWkjvf5FSk+
         CGTh0Zo6qxdwdQQ0rSfLJhL9LfMnUvY1x7ekJiPk8Rs80ZNJJEcdPjyjHNqggp3kO2RB
         rA5KkZOlQW0aPUfblZXqeCvPZbscwhy7wBcJgdM5+C7gFJjHwVcBhCw/r87DGYnvt34p
         DY4QnQX3hUcgJJGpWEi/N8o04IfhJattFgeMABpVviBewSOx6nZ+I3f/KeV24EFFhwGv
         qAxg==
X-Gm-Message-State: AAQBX9czViggJDN70tGtmVb9pPP0FfEV9NUsbci+alM2+I8TyLWDf9ot
        fmLXtCjkpneZ0y0q6sFw27jsSXnrrn4=
X-Google-Smtp-Source: AKy350a4a4UOi+5I1nz8qbUhiwIcO+m/mSpAml9Sd4RSJidBAbxln/UIFY9EXo+VaaR0ci9dMtxSoQ==
X-Received: by 2002:adf:eb0e:0:b0:2de:79b6:63ef with SMTP id s14-20020adfeb0e000000b002de79b663efmr2498010wrn.63.1680637986867;
        Tue, 04 Apr 2023 12:53:06 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id r16-20020adfdc90000000b002cff06039d7sm13054519wrj.39.2023.04.04.12.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 12:53:06 -0700 (PDT)
Message-ID: <0f90f1a0-56bc-7ca4-e276-9c163ec8ec2c@gmail.com>
Date:   Tue, 4 Apr 2023 21:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Dubious diff using --diff-algorithm=histogram
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Alejandro Colomar <alx@nginx.com>
References: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>
In-Reply-To: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MVdobDtuJegCZwbDZGMKJ8SH"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------MVdobDtuJegCZwbDZGMKJ8SH
Content-Type: multipart/mixed; boundary="------------G07WiAq0GGwL0lE0lEZpN0kz";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git Mailing List <git@vger.kernel.org>, Alejandro Colomar <alx@nginx.com>
Message-ID: <0f90f1a0-56bc-7ca4-e276-9c163ec8ec2c@gmail.com>
Subject: Re: Dubious diff using --diff-algorithm=histogram
References: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>
In-Reply-To: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>

--------------G07WiAq0GGwL0lE0lEZpN0kz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/4/23 21:51, Alejandro Colomar wrote:
> Hi,
>=20
> I've met some strange diff with the histogram algorithm.  I know this
> has a lot of magic in it, and it's probably not so trivial to improve,
> and maybe my code base is so weird that it makes the histogram do crazy=

> stuff, but I wanted to show it to you in case there's anything that can=

> be improved.
>=20
> So, patience is showing a better diff than histogram, which shouldn't
> happen usually, and less in this case, where p++ is such a common thing=

> to do (although maybe this nxt_slow_path() macro is called a lot in the=

> file and confuses the histogram?).
>=20
> Code base: <https://github.com/nginx/unit.git>
>=20
> Cheers,
> Alex

Now this has surprised me even more:

alx@asus5775:~/src/nginx/unit/space$ git diff --diff-algorithm=3Dhistogra=
m=20
diff --git a/src/nxt_http_parse.c b/src/nxt_http_parse.c
index 8646a6ce..3559f2e2 100644
--- a/src/nxt_http_parse.c
+++ b/src/nxt_http_parse.c
@@ -340,9 +340,9 @@ nxt_http_parse_request_line(nxt_http_request_parse_t =
*rp, u_char **pos,
=20
 space_after_target:
=20
-    if (nxt_slow_path(end - p < 10)) {
+    p++;
=20
-        p++;
+    if (nxt_slow_path(end - p < 10)) {
=20
         if (p =3D=3D end) {
             return NXT_AGAIN;
alx@asus5775:~/src/nginx/unit/space$ git diff --diff-algorithm=3Dpatience=
=20
diff --git a/src/nxt_http_parse.c b/src/nxt_http_parse.c
index 8646a6ce..3559f2e2 100644
--- a/src/nxt_http_parse.c
+++ b/src/nxt_http_parse.c
@@ -340,10 +340,10 @@ nxt_http_parse_request_line(nxt_http_request_parse_=
t *rp, u_char **pos,
=20
 space_after_target:
=20
+    p++;
+
     if (nxt_slow_path(end - p < 10)) {
=20
-        p++;
-
         if (p =3D=3D end) {
             return NXT_AGAIN;
         }


--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------G07WiAq0GGwL0lE0lEZpN0kz--

--------------MVdobDtuJegCZwbDZGMKJ8SH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQsgCEACgkQnowa+77/
2zJC4Q/9Fk5r1CMEgnaGIaDSb4Fnm+9zy0rEUyRaQ47VSn/M2lDuInpJAwtEpVAv
SsAueTnLLg1r3ZOMkCXx1z130N3Jw0LFvO9yjpT3gKSSOXR1VrUptmeJ15N90WVH
bIsebg3TtVKlLrHOnk6fgL1hGrRmHjgE1UNHPWDIhDz6P3oT/1lc6lYRD3uZizas
unAZk0qbVAdwsk0m3k6eS3qEewP5LKT2YNOMuXr7Ln2whF9dLYdWeOYe6hbP2YVE
zfCipy4m93+JNrtHERdVciNdoKMPsHxJG+iZdiUMZMa8XvJkq2oH1JW+3/caTiZa
qHUkel9yzq0T4O871aHFm//pGSQhqwKx8ZDQ/m/US5vzu74XXaA9N6Ta26tooKTw
YLvCrlceGUe/aMMrTK5qev6qdNTuUF6AFOJVe2Tril70/WLe7APC2nePIrI2IcgQ
ZQAvyUvfyfThSFvxeC5cqy0kyeGxiTM4W4GylFBHGH+ATmemKNMQT2Cx1KU5Kz7B
jDAuErbuFHOPICVMDUC3B39Yp0AuycwFu7EiUM1tp5iM2FXy8Y6SqlkbVFXF4u46
YhywJ6ndVPO/5BWwHngYzNvgh6sxrSwU3I5jRilbTv+n0wXZ7TP+0UVNgP2mz5pH
CBFCnwCmw2ZO9Y1c4OKl8BseuTIDF+0eZTfR6FDs3KfMS/cam2M=
=gugN
-----END PGP SIGNATURE-----

--------------MVdobDtuJegCZwbDZGMKJ8SH--
