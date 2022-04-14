Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49221C4332F
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 07:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiDNHWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbiDNHWs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 03:22:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B7193DF
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:20:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p18so4828079wru.5
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p1sec-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:autocrypt:organization:subject:in-reply-to;
        bh=HHRTGEHRmv7BcyxGO3Dri1Q103p0+Ax4WoimuLgdvs4=;
        b=J0K+6OfmT/vEM0heIQ2vf5OQztVI5AyHRbV/WuxC5jTuDecRm6XUBca2v8jvw42LIn
         wBzRcGKRCU48qOO0OVxGntjiuUEXv7bqKmuSDaIr7hF1AqGCrm7Mblu6DfUgVDpMJlxr
         SzpiC7ciMRRc4dOLpLqs8HR18uMOilDJpUfjbfCJc2Ha2LSUC6MnV1TJxgci3NzwCMuO
         jef2cpenp1gcHOua2DjqwC8zu7IJIZ9QVoyGvoyvMwi6HgFMG0XRJNgPZ4Hlawct2yFJ
         kRaVO2QUJVRY1bSDEM+JKJLauZv3Yaky0hYMBHLHsd/PyhGeNaVQINNcXGxzz2On5M25
         y5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:autocrypt:organization
         :subject:in-reply-to;
        bh=HHRTGEHRmv7BcyxGO3Dri1Q103p0+Ax4WoimuLgdvs4=;
        b=syKNjm+uGqkcjdjzx+L2PuIuQFpHmDF1VvD2g0b11v26cP67gMumfh1FjwaCQILYyR
         2ybUV7AAD2n1aAq484XgjQhVG54fx28CgTibvkfFGK5TsN7aNlRZGGvOrZCjFw789XK9
         cy3ocVUfTg1RsLCD1c9lYXbCkeLVd/353nk8uq6pf48QHSxqKHa0In76Qj+XB3amGiNH
         YLoMfu/d6LIYZhFEVIzYIUWzyALsV7NLA6ZUfB9D9m5VHswkI4EhqQZr8ffglVcHYhmY
         imR5o0P9H9yPGWXsV6cN+NS5cAlroWNA4karyJE3Lk09C7GbPRbtVZAmMSYbFjmCk/Q7
         PLjg==
X-Gm-Message-State: AOAM530C8LjI6LkTDhyILczvCT0d76THvzOPIK4fUbmmXhrDcYNd3rCi
        o/iLAED+M7SPsmzv5Hm7m4PYwg==
X-Google-Smtp-Source: ABdhPJwD+1obIlZX4Rmw8HPNMBG2glXdd5fGcykMawQqREBmxhxCV1mxtUCBKp9UvLT3FAlNBV23Gg==
X-Received: by 2002:a05:6000:1f17:b0:207:a6f4:7c44 with SMTP id bv23-20020a0560001f1700b00207a6f47c44mr971744wrb.81.1649920822759;
        Thu, 14 Apr 2022 00:20:22 -0700 (PDT)
Received: from [10.0.95.166] (lmontsouris-655-1-76-245.w90-63.abo.wanadoo.fr. [90.63.128.245])
        by smtp.gmail.com with ESMTPSA id v15-20020a056000144f00b002079acb2349sm1138009wrx.1.2022.04.14.00.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:20:22 -0700 (PDT)
Message-ID: <d72ac546-7c0d-6b05-5b8b-0c4b96192135@p1sec.com>
Date:   Thu, 14 Apr 2022 07:20:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
 <220413.864k2xgk51.gmgdl@evledraar.gmail.com>
 <6d510d78-9b0b-c463-889b-cd3855ccdd1b@p1sec.com>
 <220413.86wnfses7c.gmgdl@evledraar.gmail.com>
From:   Gregory David <gregory.david@p1sec.com>
Autocrypt: addr=gregory.david@p1sec.com; keydata=
 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
 v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=
Organization: P1 security
Subject: Re: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
In-Reply-To: <220413.86wnfses7c.gmgdl@evledraar.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QFs2Uu8fLdKfBPpL2gtk0Shw"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QFs2Uu8fLdKfBPpL2gtk0Shw
Content-Type: multipart/mixed; boundary="------------wY01qvkmM0jj70UVs2X8hSIl";
 protected-headers="v1"
From: Gregory David <gregory.david@p1sec.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <d72ac546-7c0d-6b05-5b8b-0c4b96192135@p1sec.com>
Subject: Re: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
References: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
 <220413.864k2xgk51.gmgdl@evledraar.gmail.com>
 <6d510d78-9b0b-c463-889b-cd3855ccdd1b@p1sec.com>
 <220413.86wnfses7c.gmgdl@evledraar.gmail.com>
In-Reply-To: <220413.86wnfses7c.gmgdl@evledraar.gmail.com>

--------------wY01qvkmM0jj70UVs2X8hSIl
Content-Type: multipart/mixed; boundary="------------xxqf4YiyhccjbEeTQyeSS91x"

--------------xxqf4YiyhccjbEeTQyeSS91x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

By my side, your first suggestion didn't remove the segfault due to the
irrelevant check on 'reflog[i]' that is not use on next line, so unable
to segfault. The fact is you pointed the exact place where it happens
and my fix of your fix :) remove the segfault.

On 13/04/2022 18:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Apr 13 2022, Gregory David wrote:
>=20
>> [[PGP Signed Part:Undecided]]
>> Thanks a lot Aevar!
>>
>> Don't you mean this:
>>
>> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
>> index 330b0553b9..2a5c31729d 100644
>> --- a/builtin/show-branch.c
>> +++ b/builtin/show-branch.c
>> @@ -881,7 +881,7 @@ int cmd_show_branch(int ac, const char **av, const=

>> char *prefix)
>>                                        get_color_reset_code(), ref_nam=
e[i]);
>>                         }
>>
>> -                       if (!reflog) {
>> +                       if (!reflog || !rev[i]) {
>>                                 /* header lines never need name */
>>                                 show_one_commit(rev[i], 1);
>=20
> No, but my "suggested" fix was just enough to compile and get past the
> segfault, i.e. we don't reach the puts(reflog_msg[i]) branch, but of
> course rev[i] may be NULL too, I didn't check.
>=20
> For this one though: I haven't tried it, but reading show_one_commit()
> one of the first things we do is dereference the 1st argument, so surel=
y
> that will segfault too...

--=20
Gregory David
Security Engineer
https://www.p1sec.com
--------------xxqf4YiyhccjbEeTQyeSS91x
Content-Type: application/pgp-keys; name="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=3D
=3Du6yb
-----END PGP PUBLIC KEY BLOCK-----

--------------xxqf4YiyhccjbEeTQyeSS91x--

--------------wY01qvkmM0jj70UVs2X8hSIl--

--------------QFs2Uu8fLdKfBPpL2gtk0Shw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEgTMgz/uZophfcP0Opt83aS5d4vcFAmJXyzUFAwAAAAAACgkQpt83aS5d4vfd
dwv/ZM904Z+Ui5RjgsRIHY18AuFm/XZmEh6nuj3yoi6yZ0f08A0h/fBuiZ+2V0EQeR3e/CImjNY/
FEKCSEIkt1MgZEUZtMZ0iM0oe0B1iRA0wkKkdretrDGII7k8PqqE4a53GcREuIM5XiHPUX3e87nf
T/BDByAyXhulu1BI+d9uIA9cR7AHR91DRiAt+RBmkeWad/IeAMCLYh8Zdt2HSpRBX8XicF+pRHjp
uTmZym3+KvQhYgbFWtFDvveb6+cZ8bkxQ5VWCEibF6V+YTe4wpJlIHpu7Ia+LwbSanb9zKU1T10H
8jbrN+AG0E4C6mDH4E6Vbn4BjdEP/T37E+VIMsEJGwVvFDQIflRLWb5w0HTzszoZx2x0CghN7584
qynPOdcjr5HfysSQTsg2LWyMKeG6m5ztPz1/jxascHhtaidJ0i2jbznu3SEpVtWkePEDEC/x2jkL
QQw2xrIeITIWCadtekRdv8LMzY3y0Z4jM3lFJ6hyl+BNqvOxv+jnnAsuE/YS
=C74T
-----END PGP SIGNATURE-----

--------------QFs2Uu8fLdKfBPpL2gtk0Shw--
