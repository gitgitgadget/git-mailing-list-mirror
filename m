Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD76C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiDMPvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiDMPvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:51:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115B266229
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:49:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1434513wml.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p1sec-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:autocrypt:organization:in-reply-to;
        bh=LTcTqcIXyI0vzkvVeQyyCGUAnqbaWSxRbZ6zsXW8o3k=;
        b=dkZPs28OIMNxlGp7eqUgjRwvLC0PplLXLxVWirzDp8dqFqs40ugX8jg+ZSKj65kwie
         SmS8p1iksWGoAVgbZTZgSpEz9Kgs8s4hWJoOkyWZzxdfX3/6kI2cuq9B2qLPKqOJ+BsS
         oMa/07shHYzfxc3z9n1Oi/FrM9cPmrZ32ymE0Jig6c4d/T4MgEjhyKN8OR98izF2LC1t
         HGOFnyK+1BdbudZE0v1eentyItS04kVcQujZeRpR/VrC9F0OXDrpXfVABIfNlLdPZZcK
         c8r6kqbkM+0odLoZY4ZnVGPlHMwxRyvkYYOP0cVjESdcZD0eSHF/OW8NVCJm0RibXP14
         Kotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:autocrypt:organization
         :in-reply-to;
        bh=LTcTqcIXyI0vzkvVeQyyCGUAnqbaWSxRbZ6zsXW8o3k=;
        b=pHOtSqK2vqnPXSUVP5066Qp8/QNebhZXHGTwDpiZK5iv3C88mmdDTN6z4Zji5pcvq7
         h5WeU4MRaVJQVBcPTDQJ0ovYPTRvWX7qqYGAbHeeyFGEvx59CJ4blt50A6oFfQ/NjErl
         v893ugw1BCF4Y0XxVZ7XQ0uI8rdx2cKZkwifRb/VcKDDwMm0qD8JoAdHS8tAm2zTNy9k
         CHBQcQhbpjr6f92HvMk+4UPo2dfQsCrGlVohNJ6IchatGyf1J7gVwIXmD/k5YtKnNyKk
         52+VeYJFE1HhJf6lVi2uv4icHYbFniw8BMwh4Wbg9DzMWUYQC+VIxZRajwjL1ANMphBi
         cLVw==
X-Gm-Message-State: AOAM532hiQu+hhgY1RIsf+/z6zDwFOGLjsC994q4fG2bTdkNDIHtvqW/
        l+UqvhdBrE3/d2w08qO1yKoi5cFPMBannw==
X-Google-Smtp-Source: ABdhPJzA1yhzbWmXmdR36a+A2VD224uJ6w/KKROEFOluGKRi/JBqHbWfIw6T9IiOyolNhIU0znX76g==
X-Received: by 2002:a05:600c:1c97:b0:38e:d363:3847 with SMTP id k23-20020a05600c1c9700b0038ed3633847mr4496443wms.82.1649864938594;
        Wed, 13 Apr 2022 08:48:58 -0700 (PDT)
Received: from [172.27.32.86] (lputeaux-656-1-154-186.w217-128.abo.wanadoo.fr. [217.128.61.186])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c414a00b0038ebb6884d8sm2806078wmm.0.2022.04.13.08.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 08:48:58 -0700 (PDT)
Message-ID: <6d510d78-9b0b-c463-889b-cd3855ccdd1b@p1sec.com>
Date:   Wed, 13 Apr 2022 15:48:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
 <220413.864k2xgk51.gmgdl@evledraar.gmail.com>
From:   Gregory David <gregory.david@p1sec.com>
Autocrypt: addr=gregory.david@p1sec.com; keydata=
 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
 v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=
Organization: P1 security
In-Reply-To: <220413.864k2xgk51.gmgdl@evledraar.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZR9c03EM2x80coylbw65ixVd"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZR9c03EM2x80coylbw65ixVd
Content-Type: multipart/mixed; boundary="------------2y0VZVfmOnQx4KxTR0PkUPbz";
 protected-headers="v1"
From: Gregory David <gregory.david@p1sec.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <6d510d78-9b0b-c463-889b-cd3855ccdd1b@p1sec.com>
Subject: Re: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
References: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
 <220413.864k2xgk51.gmgdl@evledraar.gmail.com>
In-Reply-To: <220413.864k2xgk51.gmgdl@evledraar.gmail.com>

--------------2y0VZVfmOnQx4KxTR0PkUPbz
Content-Type: multipart/mixed; boundary="------------eXbwUvYEynGGVWEO1IGpm6mR"

--------------eXbwUvYEynGGVWEO1IGpm6mR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks a lot Aevar!

Don't you mean this:

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 330b0553b9..2a5c31729d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -881,7 +881,7 @@ int cmd_show_branch(int ac, const char **av, const
char *prefix)
                                       get_color_reset_code(), ref_name[i=
]);
                        }

-                       if (!reflog) {
+                       if (!reflog || !rev[i]) {
                                /* header lines never need name */
                                show_one_commit(rev[i], 1);
                        }

Best regards.

On 13/04/2022 13:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Apr 13 2022, Gregory David wrote:
>=20
>> [[PGP Signed Part:Undecided]]
>> Hi, this bugreport is about a SEGFAULT on git binary when running in
>> this repository (for example, as it also segfault on other private
>> repositories): https://framagit.org/groolot-association/osc_looper.git=

>>
>>
>> What did you do before the bug happened? (Steps to reproduce your
>> issue) I just wanted to list branches, and so playing with 'git
>> show-branch --current --reflog=3D3' in the repository
>> https://framagit.org/groolot-association/osc_looper.git
>>
>> What did you expect to happen? (Expected behavior)
>> Not to segfault
>>
>> What happened instead? (Actual behavior)
>> This command fails with a SEGFAULT on version 2.35.1, 2.20.1 and 2.17.=
1
>> It also SEGFAULT on branch 'next' of github git repository.
>>
>> What's different between what you expected and what actually happened?=

>> Segfault
>>
>> Anything else you want to add:
>> Segfaut happened when '--current' AND '--reflog=3D3' are provided toge=
ther
>>
>> Please review the rest of the bug report below.
>> You can delete any lines you don't wish to share.
>>
>>
>> [System Info]
>> git version:
>> git version 2.35.1
>> cpu: x86_64
>> no commit associated with this build
>> sizeof-long: 8
>> sizeof-size_t: 8
>> shell-path: /bin/sh
>> uname: Linux 5.16.0-4-amd64 #1 SMP PREEMPT Debian 5.16.12-1 (2022-03-0=
8)
>> x86_64
>> compiler info: gnuc: 11.2
>> libc info: glibc: 2.33
>> $SHELL (typically, interactive shell): /usr/bin/zsh
>=20
> This appears to fix it, but I didn't have time to further validate it,
> come up with a test etc:
>=20
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 330b0553b9d..be3890b2dd6 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -881,10 +881,9 @@ int cmd_show_branch(int ac, const char **av, const=
 char *prefix)
>  				       get_color_reset_code(), ref_name[i]);
>  			}
> =20
> -			if (!reflog) {
> +			if (!reflog || !reflog_msg[i])
>  				/* header lines never need name */
>  				show_one_commit(rev[i], 1);
> -			}
>  			else
>  				puts(reflog_msg[i]);
> =20
>=20

--=20
Gregory David
Security Engineer
https://www.p1sec.com
--------------eXbwUvYEynGGVWEO1IGpm6mR
Content-Type: application/pgp-keys; name="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=3D
=3Du6yb
-----END PGP PUBLIC KEY BLOCK-----

--------------eXbwUvYEynGGVWEO1IGpm6mR--

--------------2y0VZVfmOnQx4KxTR0PkUPbz--

--------------ZR9c03EM2x80coylbw65ixVd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEgTMgz/uZophfcP0Opt83aS5d4vcFAmJW8OkFAwAAAAAACgkQpt83aS5d4vet
pQv/UwUmcT6D0X8HBDmN2Cef8QK/PwnyeDGzUxAeqhs3ATCnJ8bjvF/xJbkQXOSGdWyiqW/JBRNZ
s23eVl93QQKzrqxMvEnGgPcIrDRWjQkH4szi1k77xC/QSn3XjR64sX6hOVKmz7RyTYq9LqOvmZr9
OqyYqhb8fdB1Squ6y1zxB68A4sZdcnGdbnS8WWDH2ryDnjuzsnG4y/lmdGgPNyvNl94XYXxGcq4P
nDFgnaIRPcNstPEjx6rIlQrLGrC3lvTCSFdKqpYxbaCoMGnAreq2xCJ6GLiDa/bW9svStbGMOHrS
1CwyolIJXji0aL4rx+1c7jo/RvYDSb0m58w+dWgfC+RKTyqLr7NTlhbLmgSCfVCi9DcdqOPmkkGh
B3Y2Shppso0Uaz2oXLLAxTnkk3ecGImHvPb2SCG3kfmMUok+UaRHcLdlaEyBXoGgSRnCiG6pR8QN
219DWNHJP7UZBpc/NyZkdGGpLLUMbiSz5H0NRhQeIkCHoblk5/FqkUFtd2Y5
=crTa
-----END PGP SIGNATURE-----

--------------ZR9c03EM2x80coylbw65ixVd--
