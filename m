Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C461F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 19:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbeGKTMx (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 15:12:53 -0400
Received: from mail-by2nam03on0138.outbound.protection.outlook.com ([104.47.42.138]:11717
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeGKTMx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 15:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3nnA3hYpRFJhF/gdsSJ963mdfyQ859rrbfDeyivmcw=;
 b=F3Jt3nVAoVIIGK7Rbp0Cywplfh5oJYdcB+QU8zI1vdnlWjuMme26gbeDSVM4aalL1a1rAEzWWVmOcilKWRPPQEbIPOdLltuSUPt4CyVBLhd4CyQhLhW1zVyMjE+7cUEZXn+o9OrSK7Gn3uSyESkT3MewB6DCV4Z0Q59VdmnOo94=
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) by
 BL0PR2101MB0932.namprd21.prod.outlook.com (52.132.20.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Wed, 11 Jul 2018 19:07:09 +0000
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724]) by BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724%3]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 19:07:09 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Stefan Beller <sbeller@google.com>
CC:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH v1] handle lower case drive letters on Windows
Thread-Topic: [PATCH v1] handle lower case drive letters on Windows
Thread-Index: AQHUGUA9WUpXPhD60kqwA1StNOsHQqSKT0oAgAAROHA=
Date:   Wed, 11 Jul 2018 19:07:09 +0000
Message-ID: <BL0PR2101MB1012D2CC0BEA20AB35CBE967F45A0@BL0PR2101MB1012.namprd21.prod.outlook.com>
References: <20180711175420.16940-1-benpeart@microsoft.com>
 <CAGZ79ka=HfzKprETBJ=+sdQsUZPXgHsgoqNWkbHprUGgLMggUA@mail.gmail.com>
In-Reply-To: <CAGZ79ka=HfzKprETBJ=+sdQsUZPXgHsgoqNWkbHprUGgLMggUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-11T19:07:07.8478908Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0932;7:U2vRqzowFSZW108aGGHimAzOLTkGsFC/QKvdhYK74t0bhR2xTxZ/eWcjknb7JwurR0SbV3Y/ARiQpxPYQnu5mqIDQ75dZfwmxHvKN1Zv08vNag21U5KXxcgBnA/h6v2WDHm8CtNgdIKqCUBPJQjgIfdBMsN9vR64ktRLdB/2mxR9yFjjxms6+h61uI4sFPa8ksyIqiXsPM8Xcd7lCFdynBKvPXcP57IxgNv49wBnNdwKpefF1nmgSzHxnBZplrr4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 77eed842-868d-4dd4-f215-08d5e7618074
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0932;
x-ms-traffictypediagnostic: BL0PR2101MB0932:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0932514355CFC0FF14C4ACCFF45A0@BL0PR2101MB0932.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(153496737603132)(100324003535756);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0932;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0932;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(13464003)(25786009)(99286004)(86362001)(6246003)(316002)(6916009)(256004)(22452003)(4326008)(54906003)(2906002)(9686003)(8676002)(81156014)(55016002)(476003)(26005)(8990500004)(11346002)(229853002)(486006)(6436002)(5660300001)(186003)(76176011)(53546011)(102836004)(81166006)(6116002)(74316002)(3846002)(86612001)(7736002)(446003)(7696005)(6506007)(2900100001)(68736007)(66066001)(105586002)(106356001)(10290500003)(10090500001)(305945005)(8936002)(53936002)(97736004)(5250100002)(72206003)(33656002)(478600001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0932;H:BL0PR2101MB1012.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tL3wBeh+87cntaXoFAkNOSATBfHsITlvUo5e7gUuF4Tr/PmPHaWURExlgmxQMJ0wtRpf1Hi8MDoN9DmlpIXc4knCGTEDEOqHzyD8aLYWfm9sYQ6fyxsUtkP72XTtFrqHn1znWBWKCtXcI57SlgalPRRP8itd4lPB+i7SYg1cGcxUsEF1wGj8ZfvX2gx9M4m18lV4XCn2bmJFfrmcmz9rVhe+oyK6bs8y9P+09YKVgp7CkJlT7j4+UTeNCMPAVe0Y2EylL3lh/TnVgPcOFcQC/lximFt54YAYeRH4CoiKPQidm170x55FjOdXSma2+KOO/7HreVLg6nQhT9WTuJtwh4jABnHAW7KQdz7qiHi2E8M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77eed842-868d-4dd4-f215-08d5e7618074
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 19:07:09.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0932
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gQmVsbGVyIDxzYmVs
bGVyQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxMSwgMjAxOCAxOjU5IFBN
DQo+IFRvOiBCZW4gUGVhcnQgPEJlbi5QZWFydEBtaWNyb3NvZnQuY29tPg0KPiBDYzogZ2l0IDxn
aXRAdmdlci5rZXJuZWwub3JnPjsgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBoYW5kbGUgbG93ZXIgY2FzZSBkcml2ZSBsZXR0ZXJz
IG9uIFdpbmRvd3MNCj4gDQo+IE9uIFdlZCwgSnVsIDExLCAyMDE4IGF0IDEwOjU0IEFNIEJlbiBQ
ZWFydCA8QmVuLlBlYXJ0QG1pY3Jvc29mdC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGVhY2gg
dGVzdC1kcm9wLWNhY2hlcyB0byBoYW5kbGUgbG93ZXIgY2FzZSBkcml2ZSBsZXR0ZXJzIG9uIFdp
bmRvd3MuDQo+IA0KPiBBcyBzb21lb25lIG5vdCBxdWl0ZSBmYW1pbGlhciB3aXRoIFdpbmRvd3Mg
KGFuZCB1c2luZyBHaXQgdGhlcmUpLA0KPiBpcyB0aGlzIGFkZHJlc3NpbmcgYSB1c2VyIHZpc2li
bGUgaXNzdWUsIG9yIGEgZGV2ZWxvcGVyIHZpc2libGUgaXNzdWU/DQo+IChJdCBsb29rcyB0byBt
ZSBhcyB0aGUgbGF0dGVyIGFzIGl0IHRvdWNoZXMgdGVzdCBjb2RlKS4gSW4gd2hpY2ggd2F5DQo+
IGRvZXMgaXQgaW1wcm92ZSB0aGUgbGlmZSBvZiBhIGRldmVsb3Blcj8NCj4gDQoNCkl0IGlzIGEg
ZGV2ZWxvcGVyIHZpc2libGUgaXNzdWUuICBPbiBXaW5kb3dzLCBmaWxlIG5hbWVzIChpbmNsdWRp
bmcgZHJpdmUNCmxldHRlcnMpIGFyZSBjYXNlIGluc2Vuc2l0aXZlLiAgVGhpcyBwYXRjaCBpbXBy
b3ZlcyB0aGUgbGlmZSBvZiBhIFdpbmRvd3MNCmRldmVsb3BlciBieSBtYWtpbmcgZHJpdmUgbGV0
dGVycyBjYXNlIGluc2Vuc2l0aXZlIGZvciB0aGUgdGVzdC1kcm9wLWNhY2hlcw0KdGVzdCBhcHBs
aWNhdGlvbiBhcyB3ZWxsLiAgV2l0aG91dCB0aGlzIHBhdGNoICJ0ZXN0LWRyb3AtY2FjaGVzIGUi
IHdpbGwgZmFpbA0Kd2l0aCBhbiBlcnJvciAiSW52YWxpZCBkcml2ZSBsZXR0ZXIgJ2UnIiBpbnN0
ZWFkIG9mIHN1Y2NlZWRpbmcgYXMgZXhwZWN0ZWQuDQoNCj4gVGhhbmtzLA0KPiBTdGVmYW4NCg==
