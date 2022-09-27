Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCFDC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 19:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiI0TdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI0TdS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 15:33:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4070851434;
        Tue, 27 Sep 2022 12:33:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t14so16506502wrx.8;
        Tue, 27 Sep 2022 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date;
        bh=vTIAuy/pa4XjJdvf82pbunRZKX6pu4mEiYP8cYonrLI=;
        b=hqg68fZrvHLo+tfFRvVBRtWoAjXTxh6E1rTsgoXDe/qvuW8j5VG2cjWsEN5AqtrxMp
         qCxB5X0mjYuSHEZgysQICLlTYWYWTriTBjs3eB5WpG9q36meUnjAxE3cqCESH810/jB9
         o31iO0edwiym6fxZO58fImat3DK/zkvyBmJ/qKSX2KVMnMPUKfeOqTQLOBWvEmCSRxIF
         FA2rIoPAfCtgE37yl7OzeiUheRR6RlRqYzSaajGAqAmph+fRmHNMX390XKLUc7l+iyjj
         XFhTC9N2mZFAs5fMXQ3MnM51j3fQxf+xapcGI6tv5oLybkVgVXua3ZTYo0MUi9gm1WD/
         dwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date;
        bh=vTIAuy/pa4XjJdvf82pbunRZKX6pu4mEiYP8cYonrLI=;
        b=W4FpouVKCamMBSaiZTEWCfRWB/YpeWwD/1CoH19uoo6YsD3sHexsCSnytWGGcdfKK8
         e8gc+jk46z5SuqlwOPKmFAFICD/lDSoaE0sUPHFGR86bUedittUpOd+hAn1vc0TOWl54
         Qn7icAm/94djOStxIf6itmgzxv515HhTuBpJ8bhcUYHy6+t62+nOpFR7nSlyNlYcKD9I
         jkfV+RZiggSHFSGkVc0MLcF367Ek3PyI73ju3Y2S+/dGPBjJhBGviK2E36Ka8YvpgdWv
         ruhXzmEfmVvj8Uyan72Umeks9n2BDiROBCZg+vVlwsLVsReAMcX3mrU4ez6zWhK9B3xH
         ZEKw==
X-Gm-Message-State: ACrzQf3kRwJMJk2YU6BvNsh0H4gwb8ohfGDaDERFYfptkoqaD+QtSUc3
        FuGpEIXXGHi2MR2H7fWDgVM=
X-Google-Smtp-Source: AMsMyM4PmknA24pz3sYkZy7ykN3et3CnAo4X3II9wI5OrnwJdIPQ5KVZA8vi3K4J7fmW7f0l7kTmkg==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr17621940wrz.465.1664307195680;
        Tue, 27 Sep 2022 12:33:15 -0700 (PDT)
Received: from [192.168.43.80] ([31.221.140.113])
        by smtp.gmail.com with ESMTPSA id ba11-20020a0560001c0b00b0022a9246c853sm2509351wrb.41.2022.09.27.12.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 12:33:15 -0700 (PDT)
Message-ID: <242f444d-9846-1a13-d901-9ad503dce605@gmail.com>
Date:   Tue, 27 Sep 2022 21:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: readpassphrase(3) in glibc, and agetpass() (Was: Is getpass(3)
 really obsolete?)
Content-Language: en-US
From:   Alex Colomar <alx.manpages@gmail.com>
To:     Zack Weinberg <zack@owlfolio.org>,
        Theo de Raadt <deraadt@openbsd.org>, rsbecker@nexbridge.com,
        'linux-man' <linux-man@vger.kernel.org>, tech@openbsd.org,
        Florian Weimer <libc-alpha@sourceware.org>, git@vger.kernel.org
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
 <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com>
 <63238.1635515736@cvs.openbsd.org>
 <6d8642e9-71f7-4a83-9791-880d04f67d17@www.fastmail.com>
 <c8287618-30c4-f14b-8ad7-898fee99d944@gmail.com>
In-Reply-To: <c8287618-30c4-f14b-8ad7-898fee99d944@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AXFuaZZQ7EVxwY5joCy9kNgO"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AXFuaZZQ7EVxwY5joCy9kNgO
Content-Type: multipart/mixed; boundary="------------jqR07irMUADwmW0E4W0rIOr8";
 protected-headers="v1"
From: Alex Colomar <alx.manpages@gmail.com>
To: Zack Weinberg <zack@owlfolio.org>, Theo de Raadt <deraadt@openbsd.org>,
 rsbecker@nexbridge.com, 'linux-man' <linux-man@vger.kernel.org>,
 tech@openbsd.org, Florian Weimer <libc-alpha@sourceware.org>,
 git@vger.kernel.org
Message-ID: <242f444d-9846-1a13-d901-9ad503dce605@gmail.com>
Subject: Re: readpassphrase(3) in glibc, and agetpass() (Was: Is getpass(3)
 really obsolete?)
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
 <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com>
 <63238.1635515736@cvs.openbsd.org>
 <6d8642e9-71f7-4a83-9791-880d04f67d17@www.fastmail.com>
 <c8287618-30c4-f14b-8ad7-898fee99d944@gmail.com>
In-Reply-To: <c8287618-30c4-f14b-8ad7-898fee99d944@gmail.com>

--------------jqR07irMUADwmW0E4W0rIOr8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS8yNy8yMiAyMToxOSwgQWxlamFuZHJvIENvbG9tYXIgd3JvdGU6DQouLi4NCj4gDQo+
IFRoZSBwcm90b3R5cGVzIGZvciB0aGUgZnVuY3Rpb24gYW5kIHRoZSBjbGVhbi11cCBhcmU6
DQo+IA0KPiBgYGANCj4gdm9pZCBlcmFzZV9wYXNzKGNoYXIgKnApOw0KPiBbW2dudTo6bWFs
bG9jKGVyYXNlX3Bhc3MpXV0gY2hhciAqc2hkd19nZXRwYXNzKGNvbnN0IGNoYXIgKnByb21w
dCk7DQoNCkkgZWRpdGVkIHRoZSBmdW5jdGlvbiBuYW1lIGZvciB0aGUgZW1haWwsIGFuZCBm
b3Jnb3QgdG8gZml4IGl0IGhlcmUgOikNCg0Kcy9zaGR3Xy9hLw0KDQpDaGVlcnMsDQoNCkFs
ZXgNCg0KDQotLSANCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg0K

--------------jqR07irMUADwmW0E4W0rIOr8--

--------------AXFuaZZQ7EVxwY5joCy9kNgO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMzT/EACgkQnowa+77/
2zI6bA//eo4H4zX8a5arnmgXLjbH9MjSPq2XWgm/+cNr3ZVhujIbZstVygo3C81X
8Fdu2QG18725kurn14ljIzPgACnrVQEGf07I9ql8PjXAsjPs9eSMuXEj+vaqf/Of
XjzPf3ymAaaDl5wzLWP5h4USYt4iLK2KFCRAwcj5HJ6sc3M+y15/p+b1YKvlvCHR
AwzgE0GfoPT7DVu/snMJuRPA6N01B1on/VeU9T8xHHCAs+TMuZPe8n/3GerQn0U0
mp4UG88p5uwhC8Vn7CqiW2EPvmtUcTaRkvb3uH4Lmy+kq8MVLmGm+PPmGfaQ0o2G
d9fR+sjTJxS4/9xp94CoEqWxEGJ62QNGhLg0MW3khE982TgAvbQKI4tmRhRz5kuk
6tcc62gy2LwI5gL2PNUeog1TnUErgzHwUl6fSCq0AYj8VYt0zEDNgWMjoKGNYszD
2qEZiQYZtPJ/hx4sr11IfDjsDt/LmMtmITvPtNZBaQ610ST3kdx8MiOPw7zPzpIe
8TqC3IRGCx521kpVUrCH1UsWWbPTxhdp/cTFGluOnUEq6+mAQreOfB9hMxr09OF6
ZckpT48UGQbZlossWxRNIp8TNb/L85g2SPqetrS/DldblzG9N30wQ+H+Ids6vF15
sSINxhJROOZXzQehy9uHPZmuscRKwVbpaD1rnruNaXOlq2w3IiE=
=y+Oz
-----END PGP SIGNATURE-----

--------------AXFuaZZQ7EVxwY5joCy9kNgO--
