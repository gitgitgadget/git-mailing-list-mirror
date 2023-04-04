Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52FFC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjDDU0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjDDU0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 16:26:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C473A90
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 13:26:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so34083995wra.9
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639995; x=1683231995;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SDcQbehf+ycXQTx402yL23sGITATfHsIjIZb1HLmn3M=;
        b=DXU024FuF7pvUmCkerxvkoYD4ktAaxYppjmNWV66KqFFmHzkdNLWiRk3h/kxbKp2Hs
         kATIgoMU1dT6dxNOV1aWYa0y6Be2/mmuYrXtL25yrQMEZW/TSFxN+rlftDOPP9H6jpY7
         qpYaRqZECHRUNV/KON8r/I/5hOC9NJUseNEll/jKw8Ike0tu+6OH/nOHEiTxOl/izr5U
         BxrXOdXoAOfVSJK8j5GrcjMxKHnyDWcb0qFtRtU3JCRnu8Ni9eOcDYqQaCKtlZdNWWG/
         9ev9Bg3cbeBPXxEe5LC6VJyo5l5fMvRcgHQHj9fuPKW0TFcKS8clH3aJHJqxBSIDeaqv
         tvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639995; x=1683231995;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDcQbehf+ycXQTx402yL23sGITATfHsIjIZb1HLmn3M=;
        b=3dkEX4cQyBlVq5+ADUvfM89jvllbY7P+Tz25T2pf5RA6zu4o2Kh18QHOAPM5ETkxPv
         GOVHdhihXMXW3HowiYnvaMpOyNNx6S3EPE53JSDBUzShuMPbGwloaySCXpN8h1+T8wIV
         LjqkAEcG5zD5KzzzVhsh6Xwi/LCPY1nhImWJZQByu6PqVGh8Ms5LfxvFpderJVH7UgXr
         JiUiF90rZobgUZxmo2Lspd/VfjbXnkNfIy9ERS/KfpF6k2T0OZz+pluHwZIOqL4OM5Dq
         1XAdRG/ooXrsX21WLmqyboTfWqYv492Eo7XXo7iy5ofFu135Ysdsow76W5EMW4pFgPbY
         1yHw==
X-Gm-Message-State: AAQBX9eD64BaSnoMjV0o/iNT6RWaxvC3LS++8iRB4lXPVTJhTGTKdEN1
        oZvZNuRn/B6H2OvnvFmgAnFmCO4+xsY=
X-Google-Smtp-Source: AKy350aYbezFAWv0qaKLRWse2gHHRGAw7HrOe4FMNLlHD1aDVtDPYSPOS/yabArm8L4IKCPYhCnjbg==
X-Received: by 2002:adf:f74d:0:b0:2dd:def:58fb with SMTP id z13-20020adff74d000000b002dd0def58fbmr2408167wrp.43.1680639995041;
        Tue, 04 Apr 2023 13:26:35 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b002c794495f6fsm13013699wrr.117.2023.04.04.13.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 13:26:34 -0700 (PDT)
Message-ID: <27551992-99d0-e0e4-a9c6-bebca729d78e@gmail.com>
Date:   Tue, 4 Apr 2023 22:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alejandro Colomar <alx@nginx.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: diff -w when removing nested braces (thus unindenting)
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aMEiJ0ms26OZNGzixYxZ0ul5"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aMEiJ0ms26OZNGzixYxZ0ul5
Content-Type: multipart/mixed; boundary="------------WV0lvXmlpMOTcW3YqGgszhBg";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Alejandro Colomar <alx@nginx.com>
Message-ID: <27551992-99d0-e0e4-a9c6-bebca729d78e@gmail.com>
Subject: diff -w when removing nested braces (thus unindenting)

--------------WV0lvXmlpMOTcW3YqGgszhBg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

When removing nested braces, it would be nice if the diff algorithm
could try to remove the brace in a way that it fits semantically.
Considering the following diff:

> diff --git a/src/nxt_http_parse.c b/src/nxt_http_parse.c
> index 9f3233c8..0e8de7c5 100644
> --- a/src/nxt_http_parse.c
> +++ b/src/nxt_http_parse.c
> @@ -351,29 +351,30 @@ nxt_http_parse_request_line(nxt_http_request_pars=
e_t *rp, u_char **pos,
> =20
>          } while (*p =3D=3D ' ');
> =20
> -        if (memcmp(p, "HTTP/", nxt_min(end - p, 5)) =3D=3D 0) {
> +        if (memcmp(p, "HTTP/", nxt_min(end - p, 5)) !=3D 0) {
> +            return NXT_HTTP_PARSE_INVALID;
> +        }
> =20
>          switch (end - p) {
>          case 8:
>              if (p[7] < '0' || p[7] > '9') {
> -                    break;
> +                return NXT_HTTP_PARSE_INVALID;
>              }
>              /* Fall through. */
>          case 7:
>              if (p[6] !=3D '.') {
> -                    break;
> +                return NXT_HTTP_PARSE_INVALID;
>              }
>              /* Fall through. */
>          case 6:
>              if (p[5] < '0' || p[5] > '9') {
> -                    break;
> +                return NXT_HTTP_PARSE_INVALID;
>              }
>              /* Fall through. */
>          default:
>              return NXT_AGAIN;
>          }
>      }
> -    }

This brace removal looks like it would be an unmatching brace.
It would be nicer if the diff showed this:


          }
 -    }
      }

Although I'm conscious that this might be a wild wish impossible
to implement; so I'd just like you to know this little itch of
mine in case you consider it doable.

Cheers,

Alex

> =20
>      /* " HTTP/1.1\r\n" or " HTTP/1.1\n" */
> =20



--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------WV0lvXmlpMOTcW3YqGgszhBg--

--------------aMEiJ0ms26OZNGzixYxZ0ul5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQsh/MACgkQnowa+77/
2zKolQ//Z8XTbTAylDSJur1G5tAiaBRIXr+BxSfzy/TX83snvt/jjdNxI4mk129g
e2+Y8LhqhkkSfPY/jXrxgaiOd5WqBhVfoZ6iTjdeBAn6aCIFM8i+jbIvqVufx4MD
BbjLo88bdFbg+rBut6On18pqGFkfIz4p19w6yjzkEQOwtYxHK3eogYHenHAOFBiG
IqDDfmITthR6/fl7w9CRTUS8z4Nn7mgqkT1GqkgmMdcBNTfJTESAr0JqcIAJpQHm
7HkYs3SVEGhY7nevPfQ3UBhEE14IXagTH80lBPLAezcjREcLYhvNrv+GLDiSTJKh
au2dy/7FXV+4BsGuj6Ey9RlXCJK6QpEExHnKmkTEsw76AZGPBpPqF8oYrmHXNVeJ
woo+bGvtOKuqBKrZplJYZKsgrBQapAF0xcFx03gHDe5YfE7ljro1N8gf4t5mvjBV
ryjasFCS1YJAlzkGzXpcTGrz+K06VnzZDjlxfAog6N+jWnPb11tpHWRAKGYUn8Xj
7x+G85vZreKALv+m46pm5WLVvNNBNC4lezYYhrNMpy6vno7EYAESevDy0pGMwuur
vHHCdKDq4dK1ghuckCNvOn182/5j0nvBo3amNHOpdR8pJKV80Umo648B5injG4/g
vUYi0m7PoiZGauNpk25Mwb7iRklgWFkPU1dvschYKyD5f6aOAAw=
=y1S2
-----END PGP SIGNATURE-----

--------------aMEiJ0ms26OZNGzixYxZ0ul5--
