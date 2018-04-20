Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E901F404
	for <e@80x24.org>; Fri, 20 Apr 2018 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeDTS5g (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 14:57:36 -0400
Received: from prvmx02.microfocus.com ([130.57.1.217]:19926 "EHLO
        prvmx02.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeDTS5f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 14:57:35 -0400
Received: from prvxcaht03.microfocus.com (Not Verified[137.65.248.137]) by prvmx02.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5ada38250000>; Fri, 20 Apr 2018 12:57:41 -0600
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (137.65.224.20)
 by mail.microfocus.com (137.65.248.137) with Microsoft SMTP Server (TLS) id
 14.3.339.0; Fri, 20 Apr 2018 12:57:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicroFocusInternational.onmicrosoft.com; s=selector1-microfocus-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ba1Csgvb4vB0Hz4afhHR/kpJMpzp1PN2otdSAEvMbtQ=;
 b=m40u86nvTBHKhq0WnZQjtzN8kdokUZOUPt4Q1izgs69MAz2rL6Lhbx12L/Qw04MtKDRBqeeG1qENQu5SeotG1T4UqZSIw0O16/0i3rOYcSAQdIn/ibhe5As8xBWu9I+BDQLRIdJmu/46LT6BBjMi58xkpxmauRzNNJ+hV1bT99w=
Received: from MW2PR18MB2284.namprd18.prod.outlook.com (52.132.183.149) by
 MW2PR18MB2252.namprd18.prod.outlook.com (52.132.183.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.12; Fri, 20 Apr 2018 18:57:33 +0000
Received: from MW2PR18MB2284.namprd18.prod.outlook.com
 ([fe80::1953:6149:ff4d:80b3]) by MW2PR18MB2284.namprd18.prod.outlook.com
 ([fe80::1953:6149:ff4d:80b3%13]) with mapi id 15.20.0675.015; Fri, 20 Apr
 2018 18:57:32 +0000
From:   Isaac Chou <Isaac.Chou@microfocus.com>
To:     =?utf-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: RE: [PATCH] fast-export: fix regression skipping some merge-commits
Thread-Topic: [PATCH] fast-export: fix regression skipping some merge-commits
Thread-Index: AQHT2NNXwtD8cfALHkqS6+JA1CU0FaQJ/mkA
Date:   Fri, 20 Apr 2018 18:57:32 +0000
Message-ID: <MW2PR18MB22841823133D9C96D4428CDDE5B40@MW2PR18MB2284.namprd18.prod.outlook.com>
References: <MW2PR18MB228432C95C18DE786957DE70E5B40@MW2PR18MB2284.namprd18.prod.outlook.com>
 <20180420181248.2015922-1-martin.agren@gmail.com>
In-Reply-To: <20180420181248.2015922-1-martin.agren@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Isaac.Chou@microfocus.com; 
x-originating-ip: [73.253.66.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR18MB2252;7:t8Jr8IGUDypRIqdWwj/P54gO4tzafyI+Chi3AgACE/W43ffqkp3/HAwfQumQujdtsUMaUe0mJxz4iq2YJ0EMcGwiLc86uTgi5k1rKivILTz4q2I/cDs1cAcTxT5VAUMolTmy9yXYj6gN9ZPUx9fGLJJRFNekWp7iJ3b4dtIXT+7Z9cSvVl0gKx/9CijJ2PDS7vSaClHLo383aLyTwWoYtjXh/EUCG83QNSKzRCWAfd3l72uJZXXp3jjcDtzLhH78
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:MW2PR18MB2252;
x-ms-traffictypediagnostic: MW2PR18MB2252:
x-microsoft-antispam-prvs: <MW2PR18MB2252F9E42B02E9F210D96E88E5B40@MW2PR18MB2252.namprd18.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(166708455590820)(9452136761055)(85827821059158)(211936372134217)(153496737603132)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501397)(52105095)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR18MB2252;BCL:0;PCL:0;RULEID:;SRVR:MW2PR18MB2252;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(39380400002)(51914003)(377424004)(13464003)(25786009)(2900100001)(2501003)(446003)(72206003)(966005)(102836004)(316002)(53546011)(6506007)(59450400001)(5250100002)(74316002)(14454004)(305945005)(11346002)(478600001)(7736002)(186003)(476003)(26005)(3846002)(6116002)(86362001)(4326008)(53936002)(8666007)(229853002)(66066001)(6306002)(55016002)(9686003)(5660300001)(6246003)(6436002)(39060400002)(33656002)(99286004)(7696005)(81166006)(8676002)(8936002)(76176011)(2906002)(110136005)(3280700002)(54906003)(8656006)(3660700001)(14547495005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR18MB2252;H:MW2PR18MB2284.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microfocus.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c5dd4lH0nwPoUrQQqgqBhD3RKwJjXhlooEUDlBMgNOel3HK+3tDEsD0/UFNTe/6onC5+bQhqW8uQ6hCkNSyhdMQ5jgvoP3sVtTTvJ1f7SbKHLbeaIJ37aqmFgb30KOsLCAaAOe1r3MtLa6T1LcZNrJj8uX+2n51WEBBlpIX4c/2cEZtBl0Cnx+pOb9Rza1M5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3f09c0e5-7dcf-4603-0f7d-08d5a6f092e3
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f09c0e5-7dcf-4603-0f7d-08d5a6f092e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 18:57:32.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR18MB2252
X-OriginatorOrg: microfocus.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgTWFydGluLA0KDQpObyBwcm9ibGVtIGF0IGFsbC4gIFRoYW5rcyBmb3IgdGhlIHN1cGVyIHF1
aWNrIHR1cm5hcm91bmQuICA6LSkNCg0KSXNhYWMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IE1hcnRpbiDDhWdyZW4gW21haWx0bzptYXJ0aW4uYWdyZW5AZ21haWwuY29tXSAN
ClNlbnQ6IEZyaWRheSwgQXByaWwgMjAsIDIwMTggMjoxMyBQTQ0KVG86IGdpdEB2Z2VyLmtlcm5l
bC5vcmc7IElzYWFjIENob3UgPElzYWFjLkNob3VAbWljcm9mb2N1cy5jb20+DQpDYzogSnVuaW8g
QyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPjsgSm9oYW5uZXMgU2NoaW5kZWxpbiA8am9oYW5u
ZXMuc2NoaW5kZWxpbkBnbXguZGU+OyBKb25hdGhhbiBUYW4gPGpvbmF0aGFudGFubXlAZ29vZ2xl
LmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZmFzdC1leHBvcnQ6IGZpeCByZWdyZXNzaW9uIHNraXBw
aW5nIHNvbWUgbWVyZ2UtY29tbWl0cw0KDQo3MTk5MjAzOTM3IChvYmplY3RfYXJyYXk6IGFkZCBh
bmQgdXNlIGBvYmplY3RfYXJyYXlfcG9wKClgLCAyMDE3LTA5LTIzKSBub3RlZCB0aGF0IHRoZSBw
YXR0ZXJuIGBvYmplY3QgPSBhcnJheS5vYmplY3RzWy0tYXJyYXkubnJdLml0ZW1gIGNvdWxkIGJl
IGFic3RyYWN0ZWQgYXMgYG9iamVjdCA9IG9iamVjdF9hcnJheV9wb3AoJmFycmF5KWAuDQoNClVu
Zm9ydHVuYXRlbHksIG9uZSBvZiB0aGUgY29udmVyc2lvbnMgd2FzIGhvcnJpYmx5IHdyb25nLiBC
ZXR3ZWVuIGdyYWJiaW5nIHRoZSBsYXN0IG9iamVjdCAoaS5lLiwgcGVla2luZyBhdCBpdCkgYW5k
IGRlY3JlYXNpbmcgdGhlIG9iamVjdCBjb3VudCwgdGhlIG9yaWdpbmFsIGNvZGUgd291bGQgc29t
ZXRpbWVzIHJldHVybiBlYXJseS4gVGhlIHVwZGF0ZWQgY29kZSBvbiB0aGUgb3RoZXIgaGFuZCwg
d2lsbCBhbHdheXMgcG9wIHRoZSBsYXN0IGVsZW1lbnQsIHRoZW4gbWF5YmUgZG8gdGhlIGVhcmx5
IHJldHVybiBiZWZvcmUgZG9pbmcgYW55dGhpbmcgd2l0aCB0aGUgb2JqZWN0Lg0KDQpUaGUgZW5k
IHJlc3VsdCBpcyB0aGF0IG1lcmdlIGNvbW1pdHMgd2hlcmUgYWxsIHRoZSBwYXJlbnRzIGhhdmUg
c3RpbGwgbm90IGJlZW4gZXhwb3J0ZWQgd2lsbCBzaW1wbHkgYmUgZHJvcHBlZCwgbWVhbmluZyB0
aGF0IHRoZXkgd2lsbCBiZSBjb21wbGV0ZWx5IG1pc3NpbmcgZnJvbSB0aGUgZXhwb3J0ZWQgZGF0
YS4NCg0KUmVpbnRyb2R1Y2UgdGhlIHBhdHRlcm4gb2YgZmlyc3QgZ3JhYmJpbmcgdGhlIGxhc3Qg
b2JqZWN0ICh1c2luZyBhIG5ldyBmdW5jdGlvbiBgb2JqZWN0X2FycmF5X3BlZWsoKWApLCB0aGVu
IGxhdGVyIHBvcGluZyBpdC4gVXNpbmcgYC4uLl9wZWVrKClgIGFuZCBgLi4uX3BvcCgpYCBtYWtl
cyBpdCBjbGVhciB0aGF0IHdlIGFyZSByZWZlcnJpbmcgdG8gdGhlIHNhbWUgaXRlbSwgaS5lLiwg
d2UgZG8gbm90IGdyYWIgb25lIGVsZW1lbnQsIHRoZW4gcmVtb3ZlIGFub3RoZXIgb25lLg0KDQpB
ZGQgYSB0ZXN0IHRoYXQgd291bGQgaGF2ZSBjYXVnaHQgdGhpcy4NCg0KUmVwb3J0ZWQtYnk6IElz
YWFjIENob3UgPElzYWFjLkNob3VAbWljcm9mb2N1cy5jb20+DQpBbmFseXplZC1ieTogSXNhYWMg
Q2hvdSA8SXNhYWMuQ2hvdUBtaWNyb2ZvY3VzLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1hcnRpbiDD
hWdyZW4gPG1hcnRpbi5hZ3JlbkBnbWFpbC5jb20+DQotLS0NCkJhc2VkIG9uIG1haW50LCBidXQg
YXBwbGllcyBlcXVhbGx5IHdlbGwgb24gbWFzdGVyLg0KDQpNeSBzaW5jZXJlc3QgYXBvbG9naWVz
IGZvciB0aGUgc3R1cGlkIHRyYWluLXdyZWNrIHRoYXQgdGhlIG9yaWdpbmFsIGNvbnZlcnNpb24g
d2FzLiBXZWlyZCBpbnRlcmFjdGlvbnMgYmV0d2VlbiBkaWZmZXJlbnQgY29tcG9uZW50cyBjYW4g
bWFrZSBmb3IgZnVuIGJ1Z3MsIGJ1dCB0aGlzIG9uZSBpcyBqdXN0IGVtYmFyYXNzaW5nLg0KDQpJ
c2FhYywgdGhpcyBzaG91bGQgc29sdmUgdGhlIHByb2JsZW0geW91IGFyZSBzZWVpbmcuIFVuZm9y
dHVuYXRlbHksIEkgZG8gbm90IGhhdmUgYW55IGV4cGVyaWVuY2Ugd2l0aCBidWlsZGluZyBHaXQg
Zm9yIFdpbmRvd3MgWzFdLiBJIHJlYWxseSBob3BlIHRoYXQgdGhpcyBidWcgZGlkIG5vdCB0YWtl
IHVwIHRvbyBtdWNoIG9mIHlvdXIgdGltZS4gT3IgZWF0IHlvdXIgZGF0YSENCg0KTWFydGluDQoN
ClsxXSBUaGUgbGVhc3QgSSBjYW4gZG8gaXMgcHJvdmlkZSBhIGxpbms6DQpodHRwczovL2dpdGh1
Yi5jb20vZ2l0LWZvci13aW5kb3dzL2dpdC93aWtpL0J1aWxkaW5nLUdpdA0KDQogdC90OTM1MC1m
YXN0LWV4cG9ydC5zaCB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCiBvYmplY3QuaCAgICAg
ICAgICAgICAgIHwgIDkgKysrKysrKysrDQogYnVpbHRpbi9mYXN0LWV4cG9ydC5jICB8ICAzICsr
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvdC90OTM1MC1mYXN0LWV4cG9ydC5zaCBiL3QvdDkzNTAtZmFzdC1leHBvcnQu
c2ggaW5kZXggODY2ZGRmNjA1OC4uMmI0NmE4M2E0OSAxMDA3NTUNCi0tLSBhL3QvdDkzNTAtZmFz
dC1leHBvcnQuc2gNCisrKyBiL3QvdDkzNTAtZmFzdC1leHBvcnQuc2gNCkBAIC01NDAsNCArNTQw
LDI2IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ3doZW4gdXNpbmcgLUMsIGRvIG5vdCBkZWNsYXJl
IGNvcHkgd2hlbiBzb3VyY2Ugb2YgY29weSBpcyBhDQogCXRlc3RfY21wIGV4cGVjdGVkIGFjdHVh
bA0KICcNCiANCit0ZXN0X2V4cGVjdF9zdWNjZXNzICd0b2RvJyAnDQorCXRlc3RfY3JlYXRlX3Jl
cG8gbWVyZ2luZyAmJg0KKwlnaXQgLUMgbWVyZ2luZyBjb21taXQgLS1hbGxvdy1lbXB0eSAtbSBp
bml0aWFsICYmDQorDQorCWdpdCAtQyBtZXJnaW5nIGNoZWNrb3V0IC1iIHRvcGljICYmDQorCT5t
ZXJnaW5nL3RvcGljLWZpbGUgJiYNCisJZ2l0IC1DIG1lcmdpbmcgYWRkIHRvcGljLWZpbGUgJiYN
CisJZ2l0IC1DIG1lcmdpbmcgY29tbWl0IC1tIHRvcGljLWZpbGUgJiYNCisNCisJZ2l0IC1DIG1l
cmdpbmcgY2hlY2tvdXQgbWFzdGVyICYmDQorCT5tZXJnaW5nL21hc3Rlci1maWxlICYmDQorCWdp
dCAtQyBtZXJnaW5nIGFkZCBtYXN0ZXItZmlsZSAmJg0KKwlnaXQgLUMgbWVyZ2luZyBjb21taXQg
LW0gbWFzdGVyLWZpbGUgJiYNCisNCisJZ2l0IC1DIG1lcmdpbmcgbWVyZ2UgLS1uby1mZiB0b3Bp
YyAtbSAibWVyZ2UgdGhlIHRvcGljIiAmJg0KKw0KKwlvaWQ9JChnaXQgLUMgbWVyZ2luZyByZXYt
cGFyc2UgSEVBRF5eKSAmJg0KKwllY2hvIDoxICRvaWQgPm1lcmdpbmcvZ2l0LW1hcmtzICYmDQor
CWdpdCAtQyBtZXJnaW5nIGZhc3QtZXhwb3J0IC0taW1wb3J0LW1hcmtzPWdpdC1tYXJrcyByZWZz
L2hlYWRzL21hc3RlciA+b3V0ICYmDQorCWdyZXAgIm1lcmdlIHRoZSB0b3BpYyIgb3V0DQorJw0K
Kw0KIHRlc3RfZG9uZQ0KZGlmZiAtLWdpdCBhL29iamVjdC5oIGIvb2JqZWN0LmgNCmluZGV4IGYx
M2Y4NWIyYTkuLjRkOGNlMjgwZDkgMTAwNjQ0DQotLS0gYS9vYmplY3QuaA0KKysrIGIvb2JqZWN0
LmgNCkBAIC0xMjksNiArMTI5LDE1IEBAIHZvaWQgYWRkX29iamVjdF9hcnJheV93aXRoX3BhdGgo
c3RydWN0IG9iamVjdCAqb2JqLCBjb25zdCBjaGFyICpuYW1lLCBzdHJ1Y3Qgb2JqDQogICovDQog
c3RydWN0IG9iamVjdCAqb2JqZWN0X2FycmF5X3BvcChzdHJ1Y3Qgb2JqZWN0X2FycmF5ICphcnJh
eSk7DQogDQorLyoNCisgKiBSZXR1cm5zIE5VTEwgaWYgdGhlIGFycmF5IGlzIGVtcHR5LiBPdGhl
cndpc2UsIHJldHVybnMgdGhlIGxhc3Qgb2JqZWN0Lg0KKyAqIFRoYXQgaXMsIHRoZSByZXR1cm5l
ZCB2YWx1ZSBpcyB3aGF0IGBvYmplY3RfYXJyYXlfcG9wKClgIHdvdWxkIGhhdmUgcmV0dXJuZWQu
DQorICovDQoraW5saW5lIHN0cnVjdCBvYmplY3QgKm9iamVjdF9hcnJheV9wZWVrKGNvbnN0IHN0
cnVjdCBvYmplY3RfYXJyYXkgDQorKmFycmF5KSB7DQorCXJldHVybiBhcnJheS0+bnIgPyBhcnJh
eS0+b2JqZWN0c1thcnJheS0+bnIgLSAxXS5pdGVtIDogTlVMTDsgfQ0KKw0KIHR5cGVkZWYgaW50
ICgqb2JqZWN0X2FycmF5X2VhY2hfZnVuY190KShzdHJ1Y3Qgb2JqZWN0X2FycmF5X2VudHJ5ICos
IHZvaWQgKik7DQogDQogLyoNCmRpZmYgLS1naXQgYS9idWlsdGluL2Zhc3QtZXhwb3J0LmMgYi9i
dWlsdGluL2Zhc3QtZXhwb3J0LmMgaW5kZXggMjdiMmNjMTM4ZS4uODM3N2QyN2I0NiAxMDA2NDQN
Ci0tLSBhL2J1aWx0aW4vZmFzdC1leHBvcnQuYw0KKysrIGIvYnVpbHRpbi9mYXN0LWV4cG9ydC5j
DQpAQCAtNjUwLDkgKzY1MCwxMCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdGFpbChzdHJ1Y3Qgb2Jq
ZWN0X2FycmF5ICpjb21taXRzLCBzdHJ1Y3QgcmV2X2luZm8gKnJldnMsICB7DQogCXN0cnVjdCBj
b21taXQgKmNvbW1pdDsNCiAJd2hpbGUgKGNvbW1pdHMtPm5yKSB7DQotCQljb21taXQgPSAoc3Ry
dWN0IGNvbW1pdCAqKW9iamVjdF9hcnJheV9wb3AoY29tbWl0cyk7DQorCQljb21taXQgPSAoc3Ry
dWN0IGNvbW1pdCAqKW9iamVjdF9hcnJheV9wZWVrKGNvbW1pdHMpOw0KIAkJaWYgKGhhc191bnNo
b3duX3BhcmVudChjb21taXQpKQ0KIAkJCXJldHVybjsNCisJCSh2b2lkKW9iamVjdF9hcnJheV9w
b3AoY29tbWl0cyk7DQogCQloYW5kbGVfY29tbWl0KGNvbW1pdCwgcmV2cywgcGF0aHNfb2ZfY2hh
bmdlZF9vYmplY3RzKTsNCiAJfQ0KIH0NCi0tDQoyLjE3LjANCg0K
