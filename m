Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985232047F
	for <e@80x24.org>; Sat, 23 Sep 2017 23:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750959AbdIWXby (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 19:31:54 -0400
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:47968
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750839AbdIWXbx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 19:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2YDD6w2GLBGXdwsI2kKkxeoe7TYMROD9LlMSutFkYYw=;
 b=EgEThky8NLtkZ5D0WERWZDtpU/+gHtSM/ZteFVZ0KzhnGxco1HVS0sxLiarc2WE4oxSEzCxqfHaSf30LTdnjBNCV9dJIdfiz+qZPWbKSoquT5z/u2TK5EsU6ALfLgx+XjhgGNEXkrB4Y4o5MyvnLCeoDUdwhDTifHO30DUlHaCE=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0126.namprd21.prod.outlook.com (10.173.52.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.3; Sat, 23 Sep 2017 23:31:50 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0098.003; Sat, 23 Sep 2017 23:31:50 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     =?utf-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
CC:     David Turner <David.Turner@twosigma.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, "Jeff King" <peff@peff.net>
Subject: RE: [PATCH v8 01/12] bswap: add 64 bit endianness helper get_be64
Thread-Topic: [PATCH v8 01/12] bswap: add 64 bit endianness helper get_be64
Thread-Index: AQHTM8Dl9o3iUYFv6kiI0QV1v7Jcy6LBj+QAgAGQhuA=
Date:   Sat, 23 Sep 2017 23:31:50 +0000
Message-ID: <MWHPR21MB047887A575D5DFFB213092A1F4640@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20170922163548.11288-2-benpeart@microsoft.com>
 <20170922233707.25414-1-martin.agren@gmail.com>
In-Reply-To: <20170922233707.25414-1-martin.agren@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-23T19:31:48.6582160-04:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [65.222.173.206]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0126;6:FFrS9p2HDp1Xc5uCGYts1GkTP51+oZvYJZa1v1Xfqj8lGftuotOyzQwTUA9Slla4SWUa/s0O+lFIqWdwYazdYeojQpzSld1WsWVDy86hnzaSOWOHQbrEo6zP4V4aDFoOy5CBJpTzszWXk5vHrVnafIgdH+CqwGCdnNtilysKjiJHpsrUIfMTnjHEFxJeplwmVJ6zjWljAlPaZxCBJqev12BC2QokQ9DzZrM4qt9L+6mSotJGJus0GZtU8pFL7rVA/JQn/SLxFKuvOLZBk7GMiZ8Mx3m0spUcgaFkfEReJUTW9/RtaC1hJQgw2anbvG0i81gKGQO00FUAKWA2i/yPjw==;5:/uRleQtQxPfnijcv8rNLkRFbqbvlv+ukOYNBNpPXZ23JbOneEVbRrKVHjjdHjnRrhQmaXlg0RgG6aHRQzS1EodYH0o2hHKNP+BUbJbirBI4d03OQs3k2ZCI3s+/ozJ2ZzHslql/meyXTEQ3apkIAvg==;24:13Yl5XAPBOO3yNZor14QvR4suwtyfaEHcLAYJhST6mmyun4MN6n29mu8JlEUEct0ENzjLeT8AuixVmUjexivRuNiyD+qoNtSBevemYMs/RE=;7:NL+vr+hJ02UIPd090tgwiB/voO2Hpw21DK7J49BNmT+5/ZCyMc/gVIp+yFCurEhPrqyVrazx1jqHqopy6tL6V2gpRFS3n3qgMsaEaMWkR4JLSGv/xzW39co7+xR09MhP2dkTU877IWrOeaUXOvebfrU7XBD78MZVC3Jj6FhPju+8xqPnhhtITJaCPpZMJRC37Oco1f8gP7kS3K9e6IwYrNGvMRCvmYKhfZeW/YFTWVg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cd138fde-db9f-4c52-eb17-08d502db444f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR21MB0126;
x-ms-traffictypediagnostic: MWHPR21MB0126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(26323138287068)(89211679590171)(9452136761055)(100324003535756);
x-microsoft-antispam-prvs: <MWHPR21MB012619BC8C7C999B91828653F4640@MWHPR21MB0126.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123564025)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0126;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0126;
x-forefront-prvs: 0439571D1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(24454002)(199003)(377454003)(13464003)(189002)(2900100001)(9686003)(2906002)(53936002)(106356001)(105586002)(22452003)(8666007)(33656002)(6916009)(2950100002)(25786009)(6116002)(4326008)(99286003)(101416001)(8990500004)(55016002)(39060400002)(77096006)(6506006)(10290500003)(102836003)(8656003)(3846002)(6436002)(72206003)(54906003)(3280700002)(68736007)(97736004)(66066001)(316002)(8936002)(478600001)(229853002)(3660700001)(8676002)(6246003)(81156014)(81166006)(7736002)(5660300001)(86612001)(189998001)(10090500001)(53546010)(86362001)(305945005)(7696004)(54356999)(76176999)(50986999)(14454004)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0126;H:MWHPR21MB0478.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2017 23:31:50.8881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0126
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNClRoYW5rcywNCg0KQmVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogTWFydGluIMOFZ3JlbiBbbWFpbHRvOm1hcnRpbi5hZ3JlbkBnbWFpbC5jb21dDQo+IFNlbnQ6
IEZyaWRheSwgU2VwdGVtYmVyIDIyLCAyMDE3IDc6MzcgUE0NCj4gVG86IEJlbiBQZWFydCA8QmVu
LlBlYXJ0QG1pY3Jvc29mdC5jb20+DQo+IENjOiBEYXZpZCBUdXJuZXIgPERhdmlkLlR1cm5lckB0
d29zaWdtYS5jb20+OyDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbg0KPiA8YXZhcmFiQGdtYWls
LmNvbT47IENocmlzdGlhbiBDb3VkZXIgPGNocmlzdGlhbi5jb3VkZXJAZ21haWwuY29tPjsNCj4g
Z2l0QHZnZXIua2VybmVsLm9yZzsgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPjsg
Sm9oYW5uZXMNCj4gU2NoaW5kZWxpbiA8am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+OyBOZ3V5
4buFbiBUaMOhaSBOZ+G7jWMgRHV5DQo+IDxwY2xvdWRzQGdtYWlsLmNvbT47IEplZmYgS2luZyA8
cGVmZkBwZWZmLm5ldD4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAwMS8xMl0gYnN3YXA6IGFk
ZCA2NCBiaXQgZW5kaWFubmVzcyBoZWxwZXIgZ2V0X2JlNjQNCj4gDQo+IE9uIDIyIFNlcHRlbWJl
ciAyMDE3IGF0IDE4OjM1LCBCZW4gUGVhcnQgPGJlbnBlYXJ0QG1pY3Jvc29mdC5jb20+DQo+IHdy
b3RlOg0KPiA+IEFkZCBhIG5ldyBnZXRfYmU2NCBtYWNybyB0byBlbmFibGUgNjQgYml0IGVuZGlh
biBjb252ZXJzaW9ucyBvbiBtZW1vcnkNCj4gPiB0aGF0IG1heSBvciBtYXkgbm90IGJlIGFsaWdu
ZWQuDQo+IA0KPiBJIG5lZWRlZCB0aGlzIHRvIGNvbXBpbGUgYW5kIHBhc3MgdGhlIHRlc3RzIHdp
dGggTk9fVU5BTElHTkVEX0xPQURTLg0KPiANCj4gTWFydGluDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
Y29tcGF0L2Jzd2FwLmggYi9jb21wYXQvYnN3YXAuaCBpbmRleCA2YjIyYzQ2MjEuLjlkYzc5YmRm
NQ0KPiAxMDA2NDQNCj4gLS0tIGEvY29tcGF0L2Jzd2FwLmgNCj4gKysrIGIvY29tcGF0L2Jzd2Fw
LmgNCj4gQEAgLTE4Myw4ICsxODMsOCBAQCBzdGF0aWMgaW5saW5lIHVpbnQzMl90IGdldF9iZTMy
KGNvbnN0IHZvaWQgKnB0cikgIHN0YXRpYw0KPiBpbmxpbmUgdWludDY0X3QgZ2V0X2JlNjQoY29u
c3Qgdm9pZCAqcHRyKSAgew0KPiAgCWNvbnN0IHVuc2lnbmVkIGNoYXIgKnAgPSBwdHI7DQo+IC0J
cmV0dXJuCSh1aW50NjRfdClnZXRfYmUzMihwWzBdKSA8PCAzMiB8DQo+IC0JCSh1aW50NjRfdCln
ZXRfYmUzMihwWzRdKSA8PCAgMDsNCj4gKwlyZXR1cm4JKHVpbnQ2NF90KWdldF9iZTMyKHAgKyAw
KSA8PCAzMiB8DQo+ICsJCSh1aW50NjRfdClnZXRfYmUzMihwICsgNCkgPDwgIDA7DQoNClRoaXMg
aXMgc3VycHJpc2luZy4gIEV2ZXJ5IG90aGVyIGZ1bmN0aW9uIGluIHRoZSBmaWxlIHVzZXMgdGhl
IHBbeF0gc3ludGF4LiAgSnVzdCBmb3INCmNvbnNpc3RlbmN5LCBpcyB0aGVyZSBhIHdheSB0byBz
dGljayB0byB0aGF0IHN5bnRheCBidXQgc3RpbGwgbWFrZSBpdCB3b3JrIGNvcnJlY3RseT8NCklz
IHRoZXJlIGEgdHlwZWNhc3QgdGhhdCBjYW4gbWFrZSBpdCB3b3JrPw0KDQo+ICB9DQo+IA0KPiAg
c3RhdGljIGlubGluZSB2b2lkIHB1dF9iZTMyKHZvaWQgKnB0ciwgdWludDMyX3QgdmFsdWUpDQo+
IC0tDQo+IDIuMTQuMS43MjcuZzlkZGFmODYNCg0K
