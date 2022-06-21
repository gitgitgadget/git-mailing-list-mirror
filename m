Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C391C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 11:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349398AbiFULeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348826AbiFULeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 07:34:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D824193F6
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 04:34:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w17so18479504wrg.7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 04:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=NJKGTOJuNd9Uu0CoW/UX5mhmqkxfky2368sikipu1Y4=;
        b=mh00v5Am0vUW2/SahVTD3pFL7nFChn1Rtf29SmwkWsbEZS3eufprC0GZpZ4+VFSN0z
         noMkLN1s5EyCcvBlvh/xOjlORI5WUYzXza4Yq4CRtyTy2Hd0ZhqcAG7eELiqQq9lXfra
         ekd0MrKPPNkJwmGVQvmLDfKutWWDOIPlGXYvb/Qjlhzg9rl5tfqImbQlVWSVEKMdPYgb
         pIYpNYRodxesnzTfoRndWnGMP0NM4/wNbwhX4pK97kvTctF9Xi+iHUl7+WPwiwkcYuxx
         x7DAXmddpNArMJL5CFxzfk971nwAtapPsNtcQRrawcgSonW7URZpEvHy0gMaiceLLuRq
         eobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=NJKGTOJuNd9Uu0CoW/UX5mhmqkxfky2368sikipu1Y4=;
        b=FkBX7gEQrnjUp3drDAXzfe0SG4eSbVpOqJRrxYJZ1eV/F9DdU1WWqB66eWOs1UiY3r
         zjZWd65vX1sETLo+in91p42mUSzjjK+l8sMbTd0a9x5DlKQBOa/2ToIvyirWODblxCbu
         v/aSvD4P0LiRPr+24qGLZj6M2L2NWzAjELPCyOQmEZLRjt4oUkZJcx63O5zGUADFyyzP
         702awiOcRViq18B7rNOhkdDvX2F9D+mUWGpAURLg9Ff1D4lr3heZN3PUvqHhw2sHjB83
         O5x5YYw8Y0kH3lhyl1JewpwkRVSCcrjmuu18SLHToIWQ93l4phh5+unnkcNpofQamIhx
         QUZw==
X-Gm-Message-State: AJIora9ZasDpXGe4pS83LssB/l5aGF/N8j3hUlwk0ZL6SsYrB/xCEjsp
        /tx2uFdCGCfBZ9ffVv1lHVY=
X-Google-Smtp-Source: AGRyM1ti27ym+6RbtjuqTGDb1zmR4/t59gUreohReRJ3+q0B1Su9f9WbvYnmjGaGGWBH/sfzK18MFw==
X-Received: by 2002:a5d:6c62:0:b0:218:3e13:4b17 with SMTP id r2-20020a5d6c62000000b002183e134b17mr27363782wrz.673.1655811250975;
        Tue, 21 Jun 2022 04:34:10 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d6308000000b0021b8a0d680esm7939070wru.86.2022.06.21.04.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 04:34:10 -0700 (PDT)
Message-ID: <03af9a8e-cf2c-8a32-330d-debad956683d@gmail.com>
Date:   Tue, 21 Jun 2022 13:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: send PGP signed commits/patches with git-send-email(1)
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Fabian Stelzer <fs@gigacodes.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
 <20220617120016.txjksectzdugqiod@fs>
 <20220617121212.g7w7v3v4ynw6wlq7@meerkat.local> <YrGoqEi3shil7pkM@kroah.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YrGoqEi3shil7pkM@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Tv1u9R00Z0s6SVF0v3LUmfqs"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Tv1u9R00Z0s6SVF0v3LUmfqs
Content-Type: multipart/mixed; boundary="------------zqhJ7sy809orQGB221fDFf1V";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Fabian Stelzer <fs@gigacodes.de>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <03af9a8e-cf2c-8a32-330d-debad956683d@gmail.com>
Subject: Re: send PGP signed commits/patches with git-send-email(1)
References: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
 <20220617120016.txjksectzdugqiod@fs>
 <20220617121212.g7w7v3v4ynw6wlq7@meerkat.local> <YrGoqEi3shil7pkM@kroah.com>
In-Reply-To: <YrGoqEi3shil7pkM@kroah.com>

--------------zqhJ7sy809orQGB221fDFf1V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkhDQoNCk9uIDYvMjEvMjIgMTM6MTYsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIEZyaSwgSnVu
IDE3LCAyMDIyIGF0IDA4OjEyOjEyQU0gLTA0MDAsIEtvbnN0YW50aW4gUnlhYml0c2V2IHdy
b3RlOg0KPj4gT24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgMDI6MDA6MTZQTSArMDIwMCwgRmFi
aWFuIFN0ZWx6ZXIgd3JvdGU6DQo+Pj4gS29uc3RhbnRpbiBSeWFiaXRzZXYgaGFzIGRvbmUg
c29tZSB3b3JrIGluIHRoaXMgYXJlYSBlc3BlY2lhbGx5IGZvciBrZXJuZWwNCj4+PiBkZXZl
bG9wbWVudCBieSB1c2luZyBlbWFpbCBoZWFkZXJzOg0KPj4+IGh0dHBzOi8vcGVvcGxlLmtl
cm5lbC5vcmcvbW9uc2lldXJpY29uL2VuZC10by1lbmQtcGF0Y2gtYXR0ZXN0YXRpb24td2l0
aC1wYXRhdHQtYW5kLWI0DQo+Pj4gaHR0cHM6Ly9naXRodWIuY29tL21yaWNvbi9wYXRhdHQN
Cj4+DQo+PiBHcmVnIHJlZmVycyBzcGVjaWZpY2FsbHkgdG8gcGF0YXR0IHNpZ25hdHVyZXMu
IFRoZXkgYXJlbid0IHJlYWxseSBzcGVjaWZpYyB0bw0KPj4ga2VybmVsIGRldmVsb3BtZW50
IGF0IGFsbCAtLSB0aGV5IGNhbiBiZSB1c2VkIGZvciBhbnkgcGF0Y2hlcyBzZW50IHZpYSBt
YWlsLg0KPj4NCj4+IGI0ICh0aGUgdG9vbCB1c2VkIGJ5IG1hbnkgbWFpbnRhaW5lcnMgdG8g
cmV0cmlldmUgcGF0Y2hlcyBmcm9tIGxpc3RzKSB3aWxsDQo+PiBjaGVjayBwYXRhdHQtc3R5
bGUgc2lnbmF0dXJlcyAoaW4gYWRkaXRpb24gdG8gREtJTSBzaWduYXR1cmVzKSB0byBoZWxw
IHZlcmlmeQ0KPj4gdGhhdCB0aGUgcGF0Y2hlcyBjb21lIGZyb20gdHJ1c3RlZCBzb3VyY2Vz
IGFuZCBhcmVuJ3Qgc29tZW9uZSBwcmV0ZW5kaW5nIHRvIGJlDQo+PiBzb21lb25lIGVsc2Uu
DQo+IA0KPiBZZXMsIEkgd2FzIHJlZmVycmluZyB0byBwYXRhdHQgaGVyZSwgYXMgbGlua2Vk
IGJ5IEtvbnN0YW50aW4ncyBibG9nIHBvc3QNCj4gYWJvdmUuICBJdCdzIHBhcnQgb2YgdGhl
IGI0IHRvb2wgKHdlbGwsIGEgZ2l0IHN1YnByb2plY3QgaW4gaXQpLCByZWFsDQo+IGxpbmsg
aXMgYXQ6DQo+IAlodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vdXRpbHMvcGF0YXR0
L3BhdGF0dC5naXQNCg0KVGhhbmsgeW91IGFsbCBmb3IgdGhlIGluZm8uDQpJdCB3b3JrcyBs
aWtlIGNoYXJtIChJIHN0aWxsIG5lZWQgdG8gbGVhcm4gYjQoMSksIGJ1dCBwYXRhdHQoMSkg
aXMgDQplbm91Z2ggZm9yIG1lIHJpZ2h0IG5vdykuIDopDQoNCkNoZWVycywNCg0KQWxleA0K
DQotLSANCkFsZWphbmRybyBDb2xvbWFyDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21h
ci5lcy8+DQo=

--------------zqhJ7sy809orQGB221fDFf1V--

--------------Tv1u9R00Z0s6SVF0v3LUmfqs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmKxrKoACgkQnowa+77/
2zI3UQ//bBuehZ+iWlur0LQKkSxnh/AIAbbsU6fHboNNagLQP39GgWSKm9Voy7tw
3r0DHOy9p3i5tzBhjUnWZN2Db2iwWuAMOPl4wEwuTbm13KjIySr/x/k2HWSJWr+G
qWis2kG1mLgUdJQqbSHrKAuGbiZ/UUuZfVLkvL6NXUnUMT7bTKEr+cEhIAkPQTE+
ITmWr2XBfzeX3uzB9QCmDGNZbSrVE2K8wkW03xX5nMUxkLE+I8IqQfyv2yOqDhRy
kFS2ikx9j7KUMLN23b5zNom3opXHajEacHPDxFmXzCj35Ok81g/NPInqwme0/vMU
BVin/NXsaMXiqIwL6O35Xj28TCeZ3oukLjTbMICi5AuOPJ9JqnlMfyMmWCuWq6o4
XuvEH5xXufy/Z9GT/pJIv+4sza/YbwyfJc23caw4cvu2g2iKqu5u/hlMmCbAWseV
5lU7a3gkLavkUojteZt2+19lcSk4nRwCNP6fvwUgfexSdFcSoD01CJhsX39662fO
ruGnjkZMympaVp8O8ZsjfMZZV3lRUEy370ytmLHunDZ+qKD2VQramfTtNsHNKXb/
m01M9R8fEQeDaSrgyJhQOXPiqg53ZH1vBB6CJysz3a9fNWVLXASdD+op9fgbgyeY
Ymd4V9PA2a02xaruBnHlQG97QLjW+Z3/o9by1dXfyhisq4Qc8fw=
=wqfr
-----END PGP SIGNATURE-----

--------------Tv1u9R00Z0s6SVF0v3LUmfqs--
