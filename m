Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F0C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 07:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiDNHnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiDNHnI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 03:43:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76A553723
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:40:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so5697726wrr.9
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p1sec-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:autocrypt:organization:in-reply-to;
        bh=yEklcjyGWchEhVA7HbrOADs/j/Deks4JagMjcxjM4m8=;
        b=oqY7/n0x0Cfv/i/LbzwkY9cAwXujPYBye12S/7XvDmU3mZtbcYIm2C+iRWfuJUIOEr
         U2KiK6fEbmKYDnN/0X5fFidBpP+H3/5aXTjsDaffNZrjJ78UGlJOHFvhq8PeXwyP1DoS
         NQ71PK2Q0/ZxYfK00uRIS9ag7SxttEVgx2Bagqs3ZJFSk+wFWIyWz84cdSS2GC2UYveJ
         L6i+1Chf0Yq0Lx0NEOyhj7H5h3A1ueRC/0ZqsRhYE+gNbMO3oId6QR+TDnyQ5u/6k10W
         gElMcH+LuSNxd3VQQp4mx+cPVIaH/tCtvWFe2YtpOQzNahmRmCqskp9FYUJtE154Qp3T
         3C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:autocrypt:organization
         :in-reply-to;
        bh=yEklcjyGWchEhVA7HbrOADs/j/Deks4JagMjcxjM4m8=;
        b=jUaYHAm6denFRL0ppjJwYqPaV+WPGWDMSFjJWb+6vtZLbEKqFsAugl9FiNO90kzjy5
         pwmPWPb1v7r/fBfKhJnFd8LYErHfuefBTcPKzqZuLrcJ52rd8kQOoEnN3vs35vYHdTDb
         tizVvvkuR+TzFOtzfjiVOCESmAN9dXSCDyIWRD52UCvmTtptZMUSf0FB/ZIMygYjrhJz
         V2lLNrdLR6cSfMry65oefTJ3a59xmJU1cf+iQwecy1EBZpv3qncuSxgSlr3vEUjbysSB
         Clgh2HVtF9cShwM5XjqS9T+ekvR8AK184c9x0piU2g81QFQsxUqENUPJV04CHGERFfIu
         YvMA==
X-Gm-Message-State: AOAM5334LFtL3PYvnRL/rKwVQA5bex5szP9UrvP6PWTz3McyMd1CSWJ7
        9HctFkDeZi9bJX1dN1MBj2muKZJMHDU7Jw==
X-Google-Smtp-Source: ABdhPJwZC3LMLz22S1Dg12r4LUVESNDXKMCpkQwvzq7FQxo4zRB2DdBeg4yjGPURqz1i7cd5dlMIxQ==
X-Received: by 2002:adf:c14d:0:b0:207:a28f:f5dd with SMTP id w13-20020adfc14d000000b00207a28ff5ddmr1036605wre.679.1649922043300;
        Thu, 14 Apr 2022 00:40:43 -0700 (PDT)
Received: from [10.0.95.166] (lmontsouris-655-1-76-245.w90-63.abo.wanadoo.fr. [90.63.128.245])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b0038cc29bb0e1sm5547210wmq.4.2022.04.14.00.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:40:42 -0700 (PDT)
Message-ID: <1e5d4562-8fa2-431f-fc8b-ecdddff640cd@p1sec.com>
Date:   Thu, 14 Apr 2022 07:40:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
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
In-Reply-To: <220413.86wnfses7c.gmgdl@evledraar.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ThXKAhlH3XRFBI4vgwigERBa"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ThXKAhlH3XRFBI4vgwigERBa
Content-Type: multipart/mixed; boundary="------------wJUCY7lk8NtK4wApVjZuxoDK";
 protected-headers="v1"
From: Gregory David <gregory.david@p1sec.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <1e5d4562-8fa2-431f-fc8b-ecdddff640cd@p1sec.com>
Subject: Re: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
References: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
 <220413.864k2xgk51.gmgdl@evledraar.gmail.com>
 <6d510d78-9b0b-c463-889b-cd3855ccdd1b@p1sec.com>
 <220413.86wnfses7c.gmgdl@evledraar.gmail.com>
In-Reply-To: <220413.86wnfses7c.gmgdl@evledraar.gmail.com>

--------------wJUCY7lk8NtK4wApVjZuxoDK
Content-Type: multipart/mixed; boundary="------------s0VkT5LxtyC04SUiKVuGO4qz"

--------------s0VkT5LxtyC04SUiKVuGO4qz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sorry, my last answer is totally garbage.

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
--------------s0VkT5LxtyC04SUiKVuGO4qz
Content-Type: application/pgp-keys; name="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=3D
=3Du6yb
-----END PGP PUBLIC KEY BLOCK-----

--------------s0VkT5LxtyC04SUiKVuGO4qz--

--------------wJUCY7lk8NtK4wApVjZuxoDK--

--------------ThXKAhlH3XRFBI4vgwigERBa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEgTMgz/uZophfcP0Opt83aS5d4vcFAmJXz/gFAwAAAAAACgkQpt83aS5d4vfm
pQv/UQF5B7yzcIvClEF3krEYXEotaReiQHFkwn7fR40kAH55C8aE+in4R1CirRxEfJHRWAO3AFZU
kcka3SHBkXrB25JE6gEgKw84iquS3sHpyp8TK6GJN6UHnWpLemGQZyXYcc9vT6w3ETC4z+Gf4Kc5
gzoYgCaD/FndaZbm19/m8HgKgJcngIz2Uy6IkOMGCQj03RiLAnlFUKWaecbu67AaBc931U7Zk0Xa
HgU2gLUlBLkER2Q32epghlfkCfmlXEW8C9aVkXBYzcI1hzEYtQAKgUWKqgw78ha/fRlWwUszmo1p
IECvvyQQ53kpsTY9yoWgIs2ZeZgmv5nH21nvrf4PXrKUJpO704gxSPdj1gcWemHYP1M/i1sntFtr
WZA/1qxpWz6H+5laJsObGmMMMVqQtA32M3cTIpYAck/imYzY7d6zCdiClF0m1xV3G1koTXB0BPma
9YYUZsKBfgGzlbaxcTQGQ6H3XtqRp05kN0g42YZKIU1fVaMGdCDVP35TmQZ1
=rExI
-----END PGP SIGNATURE-----

--------------ThXKAhlH3XRFBI4vgwigERBa--
