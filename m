Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D64DC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 11:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349688AbiFULsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiFULsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 07:48:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742E2657C
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 04:48:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso9175203wms.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=Lxbj3HugFNO4o+GG5U/QmBn5GKKQyhdV6BHHKOLHo0s=;
        b=Ey5GMhUvGz+Z57w2/L4Yu9AaqDuvkTyiJa4rWZnxFXyumyPcTc8cuEgDWy/Z34feg1
         vm+pTQmKPb/PQjoG2Mmf+9Q0HZlc88rxabps9kIauO2GLj+Kae+ftR14NFfJ9QTySWJ1
         wP9R/S2CIBVwUIPPgyvWK1os9wB8n5B/kDP9+vLQYOAWDsc2VwzWgcqoiE+wW7BAr4my
         gy2e43UIhFVrMDxlYyWr2OIaJb0wD7mw/WfNXrN/3R3Bg9PWeaB1j6EcsbBpxOK6Igd8
         25681PhPXmT5VGyOGLMId56hih2WerI3AneOHw4rU0gwmQ9XyAM+Xc4FIhviMBq6JB93
         yDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=Lxbj3HugFNO4o+GG5U/QmBn5GKKQyhdV6BHHKOLHo0s=;
        b=wwVkYS2Vn0Vc3gn9x+LE41ie2kKFYbhaRgYSfT+UCpFxuhrlBH3WtVPBy2AA1GWl48
         5e/t9m4/pBgDqCrsKH8FioBDoS4sH4EVHskrY0boJ1SFKRooHxOwV2LmLsFXEG6Mo9MM
         kB9NXyAtNnzdctXawPdu/bD3NgVDsEpaEwubjE3HSHz5HYi5FcR5nR7HNc50T7LgrMCU
         ardeJVM8LFXjI2rtSO9WP9837ly34kdJPXLhzVNuL0mMuADyAnu3slV0IkqMizcR2C44
         BE2/NWehaA0Zji6aHFzqEQimqs0EtLnQ9oDq0cvsg5GhAZjKg6NoMTaSGpTQZx+TMSlf
         /xbg==
X-Gm-Message-State: AJIora85qWsPjWMq+6XiZfIcV7HdjUp6f41g4Opp4PsLvUWyyEOC26C1
        MTqVrxmllALMJQjNLwoKIjs=
X-Google-Smtp-Source: AGRyM1srBsliGRgVuYlT94EUuyJePdsW/CVlHA8Ib8vqx87B66Zv8rGj+IHOq6jIjK+mohBEy0IDEQ==
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id a5-20020a05600c348500b0039c7db5f0f7mr29837545wmq.8.1655812083194;
        Tue, 21 Jun 2022 04:48:03 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c1c8600b0039c84c05d88sm23730535wms.23.2022.06.21.04.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 04:48:02 -0700 (PDT)
Message-ID: <dd666e99-b0f6-a05a-532d-13bb3428e8b6@gmail.com>
Date:   Tue, 21 Jun 2022 13:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: send PGP signed commits/patches with git-send-email(1)
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Fabian Stelzer <fs@gigacodes.de>,
        Git Mailing List <git@vger.kernel.org>
References: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
 <20220617120016.txjksectzdugqiod@fs>
 <20220617121212.g7w7v3v4ynw6wlq7@meerkat.local> <YrGoqEi3shil7pkM@kroah.com>
 <03af9a8e-cf2c-8a32-330d-debad956683d@gmail.com> <YrGvQi8kiFf4a/Tk@kroah.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YrGvQi8kiFf4a/Tk@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YqjoaLWAFLfGOBxjfq04igGn"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YqjoaLWAFLfGOBxjfq04igGn
Content-Type: multipart/mixed; boundary="------------r2F290zxFOE3Vb25FvZzk5jU";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Fabian Stelzer <fs@gigacodes.de>, Git Mailing List <git@vger.kernel.org>
Message-ID: <dd666e99-b0f6-a05a-532d-13bb3428e8b6@gmail.com>
Subject: Re: send PGP signed commits/patches with git-send-email(1)
References: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
 <20220617120016.txjksectzdugqiod@fs>
 <20220617121212.g7w7v3v4ynw6wlq7@meerkat.local> <YrGoqEi3shil7pkM@kroah.com>
 <03af9a8e-cf2c-8a32-330d-debad956683d@gmail.com> <YrGvQi8kiFf4a/Tk@kroah.com>
In-Reply-To: <YrGvQi8kiFf4a/Tk@kroah.com>

--------------r2F290zxFOE3Vb25FvZzk5jU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR3JlZywNCg0KT24gNi8yMS8yMiAxMzo0NSwgR3JlZyBLSCB3cm90ZToNCj4gT24gVHVl
LCBKdW4gMjEsIDIwMjIgYXQgMDE6MzQ6MDFQTSArMDIwMCwgQWxlamFuZHJvIENvbG9tYXIg
d3JvdGU6DQo+PiBIaSENCj4+DQo+PiBPbiA2LzIxLzIyIDEzOjE2LCBHcmVnIEtIIHdyb3Rl
Og0KPj4+IE9uIEZyaSwgSnVuIDE3LCAyMDIyIGF0IDA4OjEyOjEyQU0gLTA0MDAsIEtvbnN0
YW50aW4gUnlhYml0c2V2IHdyb3RlOg0KPj4+PiBPbiBGcmksIEp1biAxNywgMjAyMiBhdCAw
MjowMDoxNlBNICswMjAwLCBGYWJpYW4gU3RlbHplciB3cm90ZToNCj4+Pj4+IEtvbnN0YW50
aW4gUnlhYml0c2V2IGhhcyBkb25lIHNvbWUgd29yayBpbiB0aGlzIGFyZWEgZXNwZWNpYWxs
eSBmb3Iga2VybmVsDQo+Pj4+PiBkZXZlbG9wbWVudCBieSB1c2luZyBlbWFpbCBoZWFkZXJz
Og0KPj4+Pj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy9tb25zaWV1cmljb24vZW5kLXRv
LWVuZC1wYXRjaC1hdHRlc3RhdGlvbi13aXRoLXBhdGF0dC1hbmQtYjQNCj4+Pj4+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9tcmljb24vcGF0YXR0DQo+Pj4+DQo+Pj4+IEdyZWcgcmVmZXJzIHNw
ZWNpZmljYWxseSB0byBwYXRhdHQgc2lnbmF0dXJlcy4gVGhleSBhcmVuJ3QgcmVhbGx5IHNw
ZWNpZmljIHRvDQo+Pj4+IGtlcm5lbCBkZXZlbG9wbWVudCBhdCBhbGwgLS0gdGhleSBjYW4g
YmUgdXNlZCBmb3IgYW55IHBhdGNoZXMgc2VudCB2aWEgbWFpbC4NCj4+Pj4NCj4+Pj4gYjQg
KHRoZSB0b29sIHVzZWQgYnkgbWFueSBtYWludGFpbmVycyB0byByZXRyaWV2ZSBwYXRjaGVz
IGZyb20gbGlzdHMpIHdpbGwNCj4+Pj4gY2hlY2sgcGF0YXR0LXN0eWxlIHNpZ25hdHVyZXMg
KGluIGFkZGl0aW9uIHRvIERLSU0gc2lnbmF0dXJlcykgdG8gaGVscCB2ZXJpZnkNCj4+Pj4g
dGhhdCB0aGUgcGF0Y2hlcyBjb21lIGZyb20gdHJ1c3RlZCBzb3VyY2VzIGFuZCBhcmVuJ3Qg
c29tZW9uZSBwcmV0ZW5kaW5nIHRvIGJlDQo+Pj4+IHNvbWVvbmUgZWxzZS4NCj4+Pg0KPj4+
IFllcywgSSB3YXMgcmVmZXJyaW5nIHRvIHBhdGF0dCBoZXJlLCBhcyBsaW5rZWQgYnkgS29u
c3RhbnRpbidzIGJsb2cgcG9zdA0KPj4+IGFib3ZlLiAgSXQncyBwYXJ0IG9mIHRoZSBiNCB0
b29sICh3ZWxsLCBhIGdpdCBzdWJwcm9qZWN0IGluIGl0KSwgcmVhbA0KPj4+IGxpbmsgaXMg
YXQ6DQo+Pj4gCWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS91dGlscy9wYXRhdHQv
cGF0YXR0LmdpdA0KPj4NCj4+IFRoYW5rIHlvdSBhbGwgZm9yIHRoZSBpbmZvLg0KPj4gSXQg
d29ya3MgbGlrZSBjaGFybSAoSSBzdGlsbCBuZWVkIHRvIGxlYXJuIGI0KDEpLCBidXQgcGF0
YXR0KDEpIGlzIGVub3VnaA0KPj4gZm9yIG1lIHJpZ2h0IG5vdykuIDopDQo+IA0KPiBUaGV5
IGFyZSBpbmRlcGVuZGVudCwgcGF0YXR0IEkgdXNlIHdoZW4gc2VuZGluZyBwYXRjaGVzLCBi
NCBJIHVzZSB3aGVuDQo+IGFjY2VwdGluZyBwYXRjaGVzLiAgSWYgeW91IG5ldmVyIGhhdmUg
dG8gYWNjZXB0IHBhdGNoZXMsIGFuZCByZWFkIHRoZQ0KPiBtYWlsaW5nIGxpc3RzIHVzaW5n
IHRoZSBub3JtYWwgd2F5LCBubyBuZWVkIHRvIHVzZSBiNC4NCg0KT2gsIEkgZG8gbmVlZCB0
byBhY2NlcHQgcGF0Y2hlcywgZm9yIHRoZSBtYW4tcGFnZXMgOikNCkJ1dCBmb3Igbm93LCB0
aGUgdHJhZmZpYyBpc24ndCBzbyBoaWdoIGFzIHRvIG5lZWQgdG8gbGVhcm4gYjQoMSkuDQpC
dXQgeWVzLCBJIHdvdWxkIGxpa2UgdG8gbGVhcm4gYSBiaXQgbW9yZSBhYm91dCBpdCB0byBz
aW1wbGlmeSBzb21lIHRoaW5ncy4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCg0KLS0gDQpBbGVq
YW5kcm8gQ29sb21hcg0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------r2F290zxFOE3Vb25FvZzk5jU--

--------------YqjoaLWAFLfGOBxjfq04igGn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmKxr90ACgkQnowa+77/
2zJimg/+NoPO73K65n04eZ1mJMZeiTE3NcL65U4yZtuCz1u1jmxZ9pJjOlSu2Bnb
t0pjxHH6eM0rb/+6zSDyo0N40J3xWreHvZghi5MmSs8XQDVbgsuHBkMNzzyLvs/f
cvo9EDV9YhWAkzIP0vudYe3g4p4sLYyPrqXrZ+F4Cdt8i7TvQ0h/X99RnaejvTCd
hcaPl3bCjWFwsOBn4bFmERXUF7i2LbxeBYBOraM3P+i3hn1SCQIbEqYdPDNki+U9
0Rcu3DcZ8jrw/8cQhEMzxK+EC2j+u6PnswD0Ad42ZFr6usUezr9BOtgzdkpHbqJ+
Rr0KlZSGmVsHVMPiw9HzbbuY+HhyKFh8MzkX0tgReG08LPfjG9JTQBe42OQG5KVq
PDgVYdkFUtVD5F8WmP/wzSctCoFYVGO/g77s0mFcD6tPxSIkdUIw0bmHqnxDlzzP
QTmvhUws7A8foIQDgiP+Cwkx39lwbzTHmJ0t6hoK+cBPO7p5Z6+h3hcJDwoNF05M
b+ndHaq2MBLGUhZYIFgD7dM9roMczz/Lqa++PI4Lt1rQ8Ag6VomMokGgxjAfl4CW
dACXsuQZpgHNrzk+1E/1GmYZ116HUrF1qvmob+fidcmDWhu/sffYQIi3pOZ6ZIlp
ffiL9KReU84PVNV+XsYjQNL8CP2S/ExThMTyAGR3wUQtOAjuBmU=
=Go5N
-----END PGP SIGNATURE-----

--------------YqjoaLWAFLfGOBxjfq04igGn--
