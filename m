Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7499B1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeHOLVi (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 07:21:38 -0400
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:2496
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbeHOLVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 07:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ova2GozrI3/iL2Nx8hYdalguYVRBQJBHCBCVh1T1WTU=;
 b=yB6hP7Kfd5XY+q3EJMTksPtTV/6PJDljH4nn35DbVuCb6mZzy25zJ7M5d7FDp1NvSDoax/WSfF+ni1Ne1S1Z9wqQAW0VgAoAzhnzrk0/U2O6t6aR6fTKRk+AEOqnRhBS6qOKzYt/npuCbjI+EcZPhSTsuabMsAAnVzqkR51TNw4=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0526.namprd10.prod.outlook.com (10.163.134.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Wed, 15 Aug 2018 08:28:42 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::488b:a298:2f2c:9855]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::488b:a298:2f2c:9855%4]) with mapi id 15.20.1038.025; Wed, 15 Aug 2018
 08:28:42 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gitster@pobox.com" <gitster@pobox.com>,
        "sbeller@google.com" <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
Subject: Re: [PATCH 1/2] store submodule in common dir
Thread-Topic: [PATCH 1/2] store submodule in common dir
Thread-Index: AQHUNB+F28APmVvAWkyTFldzDSujH6S/3iE+gAAEbD6AAJkfAA==
Date:   Wed, 15 Aug 2018 08:28:42 +0000
Message-ID: <676a61f0e87742fe591eb91fcf3509b75645e030.camel@infinera.com>
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
         <20180814223820.123723-1-sbeller@google.com>
         <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
         <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR10MB0526;6:b4FjvLY2pHTTQJ/Hgupsos5vQ6IcCKvILsGTgaV2TRvZX3w/eI/MTcFPP9ut+a/m7MCFuwObDdAlXCmiPIFef3rpmppSL/3i7YO6dSIGHSyv/bYof8ZMFscCIxc3STVfphyt+pOrIFZd7B7vNOOIcXhfTzSvRajOnVSNuF88j9xth2Q9/QtbvDbjagzNEIIUlu31CMUlHVy5a8CTx9T7yQsoEue0iXt4oElB8K/pygLQmjs8/ZQKNOMuyALxo2P2TBVBzAam1SY0LRTKJoj1vLluCrYxTRPdMaGT0TLkoNj1fNmUGFONlHuT4w7m15N2xWEo41tJi4b8XtcpO2kxGRhmE58n/vW5A+AvTTxyk7eIfcPWUijJzuhmEyMMQTYgaYvqzW7gY9Fhjovi5XpxKO3ZXqswqRqJjK2RrASXmYuy0M1+Q+j95R8xiZjVevGg/sjiygJJVW5MXuMlG9qFMw==;5:5xE1q4g6uqoAU7H9llzjOgW/W+s/EYPAB9rrZDKFGYyTDIH01FOvnt9Nb9cMl5k6z7WccA09dfKThcfn/4n0PH5PM7iLzH2FEcWh9loivtuOxuwXj5TnCsli2G/s3PjlEqQ9rI3+31MUinXjhHDuYOO+m9fnIQUi2cLLL1CQl8k=;7:zfpz+IFBtaTLI55ceh4uxSnwFNSMUioe5dC8Js0ZUKjfKTE25zJhBDKQy/OhDeha5jc1MutZuIleXOrkcrBNJKkiV4EZS9XlpgXE9p2TlbBmeWZClLsYz0IOPcG7mP7QMo3B3p3xiLRJdZiC8LtpYLj5bzfUiGBjHKVcPJLLMZbETZP6zOH7wQI1SAL+//ZHEoPnPdQHbtpYXdrnToag6Y60PEUndq9JZP4bKe7YFcKse5khVDqINKuXg41vMdjF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 981c4a5f-3fbe-4ca3-2017-08d602891c39
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR10MB0526;
x-ms-traffictypediagnostic: SN1PR10MB0526:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-microsoft-antispam-prvs: <SN1PR10MB0526115FD37AA9F9BC2750D7F43F0@SN1PR10MB0526.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(100324003535756);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR10MB0526;BCL:0;PCL:0;RULEID:;SRVR:SN1PR10MB0526;
x-forefront-prvs: 07658B8EA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(25786009)(256004)(97736004)(6246003)(39060400002)(6512007)(68736007)(305945005)(99286004)(4326008)(7736002)(14454004)(81166006)(81156014)(6506007)(53936002)(8936002)(118296001)(6486002)(8676002)(229853002)(66066001)(6436002)(476003)(36756003)(105586002)(446003)(2616005)(106356001)(72206003)(478600001)(5024004)(2501003)(486006)(2900100001)(5660300001)(186003)(76176011)(93886005)(2906002)(5250100002)(54906003)(110136005)(3846002)(86362001)(102836004)(6116002)(316002)(26005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR10MB0526;H:SN1PR10MB0736.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WALUu8FdK/P/80ksLK5cPyuv0QP/rG7VmlCE/B9PY5kyXYCWoY8ZIZNstyU0Mi3JODaXT1NpSqeDNZvr4J42DU/KZ8SVdNkYYzSUw3sidGgzCj9Rvp+sEr0S1a5eHY+Zxi0l0y2EEACjk5ZIYANonP7M41JUFjiE1Bg+5Vw/idgsUTw10HdcP+1GyX2OBBPEYvgQlgl46Azp7s/KMESu6xsrA/GgPRMyCddeI8zl0W2VXtr6nsPtDBDqtTK+Vaosmj0VcB2QJ2bTlFVfaKtHaXAIin1wEwXIWjAwRBgTht8fK7RGdqWji+1eMntMxgvkHbGv6h6nnMetQFeHu6xmkTSAjrPK59mFB61hvbiSOJA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEA6A08A78710546A71A9FF4AB8EB7B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981c4a5f-3fbe-4ca3-2017-08d602891c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2018 08:28:42.6472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0526
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTE0IGF0IDE2OjIwIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3Jn
YW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+
IA0KPiANCj4gSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cml0ZXM6DQo+IA0K
PiA+IE15IHVuZGVyc3RhbmRpbmcgb2Ygd2hhdCBKb2FraW0gd2FudHMgdG8gZG8gaXMgdG8gaGF2
ZSBhIHRvcC1sZXZlbA0KPiA+IHByb2plY3QgdGhhdCBoYXMgdGhyZWUgc3ViZGlyZWN0b3JpZXMs
IGUuZy4ga2VybmVsL3YyLjIsIGtlcm5lbC92Mi40DQo+ID4gYW5kIGtlcm5lbC92Mi42LCBlYWNo
IG9mIHdoaWNoIGlzIGEgc3VibW9kdWxlIHRoYXQgaG91c2VzIHRoZXNlDQo+ID4gdmVyc2lvbnMg
b2YgTGludXgga2VybmVsIHNvdXJjZSwgYnV0IG9ubHkgY2xvbmUgTGludXMncyByZXBvc2l0b3J5
DQo+ID4gKGFzIHRoZSB1cC10by1sYXRlIHRyZWUgaGFzIGFsbCB0aGUgbmVjZXNzYXJ5IGhpc3Rv
cnkgdG8gY2hlY2sgb3V0DQo+ID4gdGhlc2UgcGFzdCBkZXZlbG9wbWVudCB0cmFja3MpLiAgQW5k
IHRoYXQgc2hvdWxkIGJlIGRvYWJsZSB3aXRoDQo+ID4ganVzdCB0aGUgbWFpbiBjaGVja291dCwg
d2l0aG91dCBhbnkgYWRkaXRpb25hbCB3b3JrdHJlZSAoaXQncyBqdXN0DQo+ID4gdGhlIG1hdHRl
ciBvZiBoYXZpbmcgLmdpdC9tb2R1bGVzL2tlcm5lbCUyZnYyLjYvIGRpcmVjdG9yeSBwb2ludGVk
DQo+ID4gYnkgdHdvIHN5bWxpbmtzIGZyb20gLmdpdC9tb2R1bGVzL2tlcm5lbCUyZnYyLlsyNF0s
IG9yIHNvbWV0aGluZw0KPiA+IGxpa2UgdGhhdCkuDQo+IA0KPiBBY3R1YWxseSBJIHRha2UgdGhl
IGxhc3QgcGFydCBvZiB0aGF0IGJhY2suICBXaGVuIHRob3VnaHQgbmFpdmVseQ0KPiBhYm91dCwg
aXQgbWF5IGFwcGVhciB0aGF0IGl0IHNob3VsZCBiZSBkb2FibGUsIGJ1dCBiZWNhdXNlIGVhY2gg
b2YNCj4gdGhlIG1vZHVsZXMvKiBkaXJlY3RvcnkgaW4gdGhlIHRvcC1sZXZlbCBwcm9qZWN0IGhh
cyB0byBzZXJ2ZSBhcyB0aGUNCj4gJEdJVF9ESVIgZm9yIGVhY2ggc3VibW9kdWxlIGNoZWNrb3V0
LCBhbmQgdGhlIGRlc2lyZSBpcyB0byBoYXZlDQo+IHRoZXNlIHRocmVlIGRpcmVjdG9yaWVzIHRv
IGhhdmUgY2hlY2tvdXQgb2YgdGhyZWUgZGlmZmVyZW50DQo+IGJyYW5jaGVzLCBhIHNpbmdsZSBk
aXJlY3RvcnkgdW5kZXIgbW9kdWxlcy8uIHRoYXQgaXMgc2hhcmVkIGFtb25nDQo+IHRocmVlIHN1
Ym1vZHVsZXMgd291bGQgKm5vdCogd29yay0tLXRoZXkgbXVzdCBoYXZlIHNlcGFyYXRlIGluZGV4
LA0KPiBIRUFELCBldGMuDQo+IA0KPiBUaGVvcmV0aWNhbGx5IHdlIHNob3VsZCBiZSBhYmxlIHRv
IG1ha2UgbW9kdWxlcy9rZXJuZWwlMmZ2Mi5bMjRdDQo+IGFkZGl0aW9uYWwgIndvcmt0cmVlInMg
b2YgbW9kdWxlcy9rZXJuZWwlMmZ2Mi42LCBidXQgZ2l2ZW4gdGhhdA0KPiB0aGVzZSBhcmUgYWxs
ICJiYXJlIiByZXBvc2l0b3JpZXMgd2l0aG91dCBhbiBhdHRhY2hlZCB3b3JraW5nIHRyZWUsDQo+
IEkgYW0gbm90IHN1cmUgaG93IHRoYXQgd291bGQgc3VwcG9zZWQgdG8gd29yay4gIFRoaW5raW5n
IGFib3V0DQo+IGhhdmluZyBtdWx0aXBsZSB3b3JrdHJlZXMgb24gYSBzaW5nbGUgYmFyZSByZXBv
c2l0b3J5IG1ha2VzIG1lIGhlYWQNCj4gc3BpbiBhbmQgYWNoZSBYLTw7LSkNCg0KWW91IG5haWxl
ZCBpdCAhIDopDQpNeSBoZWFkIHNwaW5zIGp1c3QgcmVhZGluZyB0aGlzIHNvIEkgdGhpbmsgSSBn
b3QgbXkgYW5zd2VyLiBJIGNhbiBiZSBkb25lDQpidXQgd2lsbCBiZSB0cmlja3kgdG8gaW1wbC4g
DQpJIHdpbGwga2VlcCBhbiBleWUgb24gaG93IHN1Ym1vZHVsZXMgZGV2ZWxvcHMsIHN1cmUgd291
bGQgYmUgYSB3ZWxjb21lIGZlYXR1cmUuDQoNCiBKb2NrZQ0K
