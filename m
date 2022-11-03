Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9B3C43217
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 03:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKCDfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 23:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKCDfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 23:35:20 -0400
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 20:35:05 PDT
Received: from mail4.tencent.com (mail12.tencent.com [61.241.47.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599AF1408F
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 20:35:05 -0700 (PDT)
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail4.tencent.com (Postfix) with ESMTP id 0EE326544B
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 11:28:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1667446130;
        bh=bwGmzkMkF8VFkr0t6HCShlkH26uURzdSb19J/sV+6KM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=BsgNw27sTHiztwWA5VhAcq/ggHuU7rKCgguHLBjBVRrU772L63gGSaYLQYlkQ1qoi
         SdvzcqDK1X7DKyJ9S4NOXeuuFf+YY5xNP/bgauYj7bP/ov41atVv+uk/4iSM6g9esn
         bSbyVxOK4b7+gV71wz8jqep/t6gRBXBzVPA2EIlM=
Received: from EX-SZ093.tencent.com (10.28.6.65) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Nov 2022
 11:28:49 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ093.tencent.com
 (10.28.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Nov 2022
 11:28:49 +0800
Received: from EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571]) by
 EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571%6]) with mapi id
 15.01.2242.008; Thu, 3 Nov 2022 11:28:49 +0800
From:   =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
To:     Elijah Newren <newren@gmail.com>,
        Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Internet]Re: [PATCH v4 2/2] merge-tree.c: support --merge-base
 in conjunction with --stdin
Thread-Topic: [Internet]Re: [PATCH v4 2/2] merge-tree.c: support --merge-base
 in conjunction with --stdin
Thread-Index: AQHY7yGBCoae12g7ZUigMi4BxFomb64shoNg
Date:   Thu, 3 Nov 2022 03:28:49 +0000
Message-ID: <3cb3cd03860349b5b38b3ca3b3ce4a0b@tencent.com>
References: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
 <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
 <db47fbc663eb0f3a1fc9a063dfb1051bc64601af.1667292904.git.gitgitgadget@gmail.com>
 <CABPp-BG4in6hPnniHoE+au0XyVXwgs9pNUJdpLDTmP=dxvKjqw@mail.gmail.com>
In-Reply-To: <CABPp-BG4in6hPnniHoE+au0XyVXwgs9pNUJdpLDTmP=dxvKjqw@mail.gmail.com>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.16.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KPj4NCj4+IFRoZSBwcmV2aW91cyBjaGFuZ2UgYWRk
ICItLW1lcmdlLWJhc2UiIG9wdGlvbiBpbiBvcmRlciB0byBhbGxvdyB1c2VycyANCj4+IHRvDQo+
DQo+IHMvYWRkL2FkZGVkLyA/DQoNCkRvbmUuDQoNCg0KPiBQZXJoYXBzIHNvbWV0aGluZyBsaWtl
Og0KPiANCj4gIiIiDQo+IFRoZSBwcmV2aW91cyBjb21taXQgYWRkZWQgYSBgLS1tZXJnZS1iYXNl
YCBvcHRpb24gaW4gb3JkZXIgdG8gYWxsb3cgdXNpbmcgYSBzcGVjaWZpZWQgbWVyZ2UtYmFzZSBm
b3IgdGhlIG1lcmdlLiAgRXh0ZW5kIHRoZSBpbnB1dCBhY2NlcHRlZCBieSBgLS1zdGRpbmAgdG8g
YWxzbyBhbGxvdyBhIHNwZWNpZmllZCBtZXJnZS1iYXNlIHdpdGggZWFjaCBtZXJnZSByZXF1ZXN0
ZWQuICBGb3IgZXhhbXBsZToNCj4gDQogPiAgICBwcmludGYgIi0tbWVyZ2UtYmFzZT08YjM+IDxi
MT4gPGIyPiIgfCBnaXQgbWVyZ2UtdHJlZSAtLXN0ZGluDQo+DQoNCkRvbmUuDQoNCg0KPiBIb3dl
dmVyLCBJJ20gYSBiaXQgY3VyaW91cyBhYm91dCB1c2luZyBgLS1tZXJnZS1iYXNlPWAgb24gdGhl
IGlucHV0IGxpbmUgYXMgb3Bwb3NlZCB0byBqdXN0IHVzaW5nIGEgc2ltcGxlciBtYXJrZXI7IHNv
bWV0aGluZyBsaWtlDQo+IA0KPiAgICAgcHJpbnRmICI8YjM+IC0tIDxiMT4gPGIyPiIgfCBnaXQg
bWVyZ2UtdHJlZSAtLXN0ZGluDQo+IA0KPiAod2hpY2ggZm9sbG93cyBhIHByZWNlZGVudCBzZXQg
YnkgZ2l0LW1lcmdlLXJlY3Vyc2l2ZSkuICBZb3VyIHZlcnNpb24gaXMgYSBiaXQgbW9yZSBzZWxm
LWRvY3VtZW50aW5nLCBidXQgd2hhdCBpZiB3ZSB3YW50IHRvIGFsbG93IHVzZXJzIHRvIHNwZWNp
ZnkgbXVsdGlwbGUgbWVyZ2UgYmFzZXMgaW4gdGhlIGZ1dHVyZSAoZm9yIHVzZSBpbiBwYXNzaW5n
IHRvIG1lcmdlX2luY29yZV9yZWN1cnNpdmUoKSk/ICBJcyBpdCBhbm5veWluZyB0byBuZWVkIHRv
IHByZWZpeCBlYWNoIG9uZT8NCg0KQWN0dWFsbHksIEkgdGhvdWdodCBhYm91dCBpdCBhdCB0aGUg
dGltZSwgYnV0IGRpZG4ndCB0aGluayBvZiBhbnkgZ29vZCBpbnB1dCBmb3JtYXQuIFlvdXIgaWRl
YSBpcyBncmVhdCwgSSB0aGluayBJJ2xsIHVzZSBpdC4NCg0KPiBJJ20gbm90IHN1cmUgInBhc3Nl
ZCBpbnRvIHRoZSBpbnB1dCBsaW5lIiB3aWxsIGJlIGNsZWFyIHRvIHJlYWRlcnMuDQo+IFBlcmhh
cHMgd2Ugd2FudCB0byBoYXZlIC0tc3RkaW4gZG9jdW1lbnRlZCAobG9va3MgbGlrZSBJIGZvcmdv
dCB0byBkbyB0aGF0IGluIG15IHNlcmllczsgb29wcyksIG1lbnRpb25pbmcgdGhlIGlucHV0IGZv
cm1hdC4NCg0KSSBqdXN0IGFkZGVkIHRoZSBkb2N1bWVudGF0aW9uIGZvciAtLWlucHV0LCBwbGVh
c2Ugc2VlIHdoYXQgZWxzZSBuZWVkcyB0byBiZSBpbXByb3ZlZC4NCg0KPiA+ICsgICAgICAgcHJp
bnRmICIxXDAiID4+ZXhwZWN0ICYmDQo+ID4gKyAgICAgICBnaXQgbWVyZ2UtdHJlZSAtLXdyaXRl
LXRyZWUgLXogLS1tZXJnZS1iYXNlPWMyIGMxIGMzID4+ZXhwZWN0ICYmDQo+ID4gKyAgICAgICBw
cmludGYgIlwwIiA+PmV4cGVjdCAmJg0KPiA+ICsgICAgICAgdGVzdF9jbXAgZXhwZWN0IGFjdHVh
bA0KPiA+ICsnDQo+DQo+IFRoaXMgbGFzdCB0ZXN0IHNlZW1zIG9kZC4gIFlvdSBhcmUgbWVyZWx5
IHRlc3RpbmcgdGhhdCB0aGUgb3V0cHV0IG9mICJnaXQgbWVyZ2UtdHJlZSAtLXN0ZGluIiBtYXRj
aGVzIHRoZSBvdXRwdXQgb2YgcmVwZWF0ZWQgY2FsbHMgdG8gImdpdCBtZXJnZS10cmVlIiwgbm90
IHRoYXQgdGhlIG1lcmdlcyBpbnZvbHZlZCBwcm9kdWNlIGNvcnJlY3QgcmVzdWx0cz8NCj4gTWF5
YmUgdGhhdCdzIGZpbmUgc2luY2UgZWFybGllciB0ZXN0cyB2ZXJpZnkgdGhhdCBpbmRpdmlkdWFs
IG1lcmdlLXRyZWUgY2FsbHMgYXJlIGRvaW5nIHRoZSByaWdodCB0aGluZywgSSB3YXMganVzdCBh
IGJpdCBzdXJwcmlzZWQuICBNYXliZSBhIGNvbW1lbnQgaW4gdGhlIGNvZGUgdGhhdCB0aGlzIHdh
cyB5b3VyIGludGVudCB3b3VsZCBiZSBoZWxwZnVsPw0KDQpZZWFoLCBJIGhhdmUgYWRkZWQgdGhl
IGNvbW1lbnQuDQo=
