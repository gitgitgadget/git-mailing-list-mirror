Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E665CC77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 21:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjD1VgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 17:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjD1VgX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 17:36:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA0211E
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 14:36:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f315712406so75777025e9.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682717781; x=1685309781;
        h=in-reply-to:content-language:references:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDLoKSFk8qrSuLpJCWE0NzLEqvjMyyCVcWtuDPzrixE=;
        b=TIlDRD8K2LipyW8R7f9e9iYx0w8JRpqluMO/8vkzEqfYPA5AGTjf2Q0nuAf2y3/adO
         4LfXfu0IM9q7CJ5CTF1zyfEpBMp1FBTQwuAaotGsqFVwHBfXgJkqFZAOa0pFdBGbQkE0
         Pv/IQqTGzRhmnTN/uSpBfG51VHTOBCnc6b1JW7as6y2UM0SHUT77xCD2nfsdAbEHkkJC
         dAr4n+gQDFfBPIE9v+T3QVVstsst1DkOjyz+UzRtuCF+eMA1S+Lm+GfqhR4vDZP1J0RT
         tXPTqierkD9VIGFhysSIlbSe+kOb65I4JOxSVzXZsbcHVXEM70iKeCufiy7Lw2dw18AR
         Fi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682717781; x=1685309781;
        h=in-reply-to:content-language:references:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GDLoKSFk8qrSuLpJCWE0NzLEqvjMyyCVcWtuDPzrixE=;
        b=N1qfr+cIXnSF1Wp40DNTIyq/EtUwEGyBUHoanpGHwcoLtxWnRX94AH795pbScKONSh
         e58xnbZRuKuvvzxdiRDn2N69fuSeEQLlVfTT6ymDdt7G3sJAM4Ehzp/BP7WugclpE414
         nN0tSRDSrj4VYJxLyLIjXJwNU3nMl3yQFij+KcQya1uD9GVk+v+FaQotbbw5TgDh47np
         ltpOkZxLzB+isOqy5LmYunitcOzkIagiO9e3zGBL5hJ4XUk5MiSrazMlg89upExRbH0N
         bcksWP0l3ZPG+yblpDNuePcyK6lcbplej3z/es9KOo5chFrG8a1ILcxC/4R0wf9EQZwz
         nizw==
X-Gm-Message-State: AC+VfDxBLj5A5A51H7jYxmB5/vvipP38Pm8o/x4xE/e59xWkTKCp20dO
        mckwDQbDVVZLEhAnxAVyGJu/358Wab4=
X-Google-Smtp-Source: ACHHUZ5AgFmEykoMAvwS3HDpxk/bKIrNxXyPAIVF0gyj3hbPe0ddnpFZftEdkJ3bHNFfY56m2pNiSA==
X-Received: by 2002:a5d:45c5:0:b0:2ff:3605:e1e9 with SMTP id b5-20020a5d45c5000000b002ff3605e1e9mr5344471wrs.17.1682717780586;
        Fri, 28 Apr 2023 14:36:20 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4f01000000b002fc0de07930sm21983429wru.13.2023.04.28.14.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 14:36:19 -0700 (PDT)
Message-ID: <cb3a07d6-8441-b7fb-4994-3b22e3b974de@gmail.com>
Date:   Fri, 28 Apr 2023 23:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Dubious diff using --diff-algorithm=histogram
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Alejandro Colomar <alx@nginx.com>
References: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>
Content-Language: en-US
In-Reply-To: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EkEJSQBY3Z1HHi7LmcOY58tK"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EkEJSQBY3Z1HHi7LmcOY58tK
Content-Type: multipart/mixed; boundary="------------0LqKYMqOt0lzFX6dpupPR1rP";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git Mailing List <git@vger.kernel.org>, Alejandro Colomar <alx@nginx.com>
Message-ID: <cb3a07d6-8441-b7fb-4994-3b22e3b974de@gmail.com>
Subject: Re: Dubious diff using --diff-algorithm=histogram
References: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>
In-Reply-To: <a0b6d751-25fd-a132-f8a5-9844e5d9b8a6@gmail.com>

--------------0LqKYMqOt0lzFX6dpupPR1rP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Here's another example of a dubious diff using histogram:

@@ -50,8 +65,11 @@ .SH Examples
     nxt_unit_ctx_t   *ctx;
     nxt_unit_init_t  init;
=20
-    bzero(&init, sizeof(nxt_unit_init_t));
+    if (argc =3D=3D 3 && strcmp(argv[1], "-t") =3D=3D 0) {
+        nthreads =3D atoi(argv[2]);
+    }
=20
+    bzero(&init, sizeof(nxt_unit_init_t));
     init.callbacks.request_handler =3D &request_handler;
     init.callbacks.ready_handler =3D &ready_handler;
=20


That call to bzero(3) is the only one in the entire file.
patience shows this instead:


@@ -50,8 +65,11 @@ .SH Examples
     nxt_unit_ctx_t   *ctx;
     nxt_unit_init_t  init;
=20
+    if (argc =3D=3D 3 && strcmp(argv[1], "-t") =3D=3D 0) {
+        nthreads =3D atoi(argv[2]);
+    }
+
     bzero(&init, sizeof(nxt_unit_init_t));
-
     init.callbacks.request_handler =3D &request_handler;
     init.callbacks.ready_handler =3D &ready_handler;
=20


--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------0LqKYMqOt0lzFX6dpupPR1rP--

--------------EkEJSQBY3Z1HHi7LmcOY58tK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmRMPEsACgkQnowa+77/
2zJughAAjFuRcUYCaPKpE2F4GS0jEYzhZFRH0XCBP5uiFT1FgnvJNuZ4N0s7KLIs
gW+wc08EQUJkUlsMMGslZrkjQd6xkf32gvuUmNXSIMNNORdjk9/Uocm1uuDaGQvC
KTZtby+OgiwNvjrGe1kUOAWO3SaFxZ1W1j9N3Cwj8VJpMQ++8H61VrjHMkltJQwA
BuMkdIPDt9zv9636Te/Fdy0yS4A/lm1l8a7jWvP3N6Ye5rfDwv1rte38DYf28ees
exaBgpvUhoxmKdDSdmKueFbpQ5MzURoHIB+Jh57jn0OrBEWzab6UOzOV11Mpu9P9
AADPNA0tt7s4cbR/CdE7HUwQ6tBSWy7zFIJ4TkWk8MotBbMZbrTxy54wCBhnO4mI
l8WurnB0GzDRK1KP59DpAj53T3p5aPQEPnMlbnk7DYaT3b1Sp5Zra1eimMYfmmfB
UyI2HRhQHYlOMa3Ud+N1yf2gycDnFQmcu0aBWHXw68XRavhJEfj5UqzO4TuBCv4z
/3GWHx1Mkl4kLFLmwyOKNNCEr6SB3OWnbD+D56egFjYR4dqUo2QReJyN+hHGjakY
M5JDLlqFrsRvWzaUJ6/QciqoDhGMtJYvqg4WBIdQGt/rzpNsJImHi9mpz8rq+aib
lNZ6MdrCr/T5VY4FCfmu7OdV7+uz2Lmh2Id//uelYjhHwCvvXkc=
=4GG9
-----END PGP SIGNATURE-----

--------------EkEJSQBY3Z1HHi7LmcOY58tK--
