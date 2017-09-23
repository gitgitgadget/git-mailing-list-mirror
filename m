Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF1820281
	for <e@80x24.org>; Sat, 23 Sep 2017 23:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdIWXdK (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 19:33:10 -0400
Received: from mail-co1nam03on0135.outbound.protection.outlook.com ([104.47.40.135]:40911
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751495AbdIWXdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 19:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+xyybQRUo3xsUe0Zg4YQHmhMTAcmFMhaFtay7r24x4E=;
 b=CLjBHvN3n60CHrr7Va4oSoMMJCGnAczK5m3qtZz7BxwWWr980rg5vuEQ1TFINvQJYxRml3epKRuLYq2JNDt+SAyYeAmoJBO0FuWgnpwesZ3OkOQBv07hOy2VFAVL9idY4ge30Mqlpe2spfgIBon5vThdDmHFpdHHh6ux6NLyGfs=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0126.namprd21.prod.outlook.com (10.173.52.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.3; Sat, 23 Sep 2017 23:33:00 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0098.003; Sat, 23 Sep 2017 23:33:00 +0000
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
Subject: RE: [PATCH v8 08/12] fsmonitor: add a test tool to dump the index
 extension
Thread-Topic: [PATCH v8 08/12] fsmonitor: add a test tool to dump the index
 extension
Thread-Index: AQHTM8Dq7dYQ4u5WJkanAcOCuLc23aLBj+WAgAGRA9A=
Date:   Sat, 23 Sep 2017 23:33:00 +0000
Message-ID: <MWHPR21MB0478265059A957CFB8785CEFF4640@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20170922163548.11288-9-benpeart@microsoft.com>
 <20170922233707.25414-2-martin.agren@gmail.com>
In-Reply-To: <20170922233707.25414-2-martin.agren@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-23T19:33:00.2634403-04:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [65.222.173.206]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0126;6:KlVWuWpCBPSkA5szkSvmgWK8CU2jij9HAJzVQVAC2HxSCVC4nuI5akbgZYMLbCR0+MziDpnOMV5sospGwWrovo5aNCpkb/42srj2DfacuPCYThoHYTImUyLLfctmSp0kmR+fwv3eiTji9rM0SxRJGBBzkE63IR4Xl9WriSfXC9KxrG09ZTKUJQW1vrcDDOOIp4THQIxaJcgF/ClhO8hfcXH5kDnaSa8bv7Ht2+z1oclCKgHCQjy76rHo8tqY5pJcMZFeLBdRzFtEWNY84f/aAlgw+FYNoBa06w0LPiDJZOb5weljqk+HrD+2XLwOAMnaV9sJhhl78t0BBSivIfC4tQ==;5:edw3V+/xzwqKsIssRFo6V7sCR40kLuJWcYF/eOJXfqt2ceIMrqSHn6nW/wYb30APigSDwIrpb06JtP6xYS6w5ZeppKY7QuBA7JK0nCrV3XU7NK9ATEKBoh/bqQsj6Yvlb2lxQKIL8508mZA0jeeTWw==;24:4VcEnm87gNCGNf6vBw5UkoSMU8KmXkzWSqJpmVxfTFOcqwGA23zMAOv6zAlLFapQJUQrzvKqC1BxyV92ZFoDGPmagPf9MAeu+XqaYYf6E5I=;7:AmbVB5HE2laKmhwWfjv5kAahkh/t1qp1f9xBmRE1/MxPcYrqB6/0aA4hFDgh47JMgmFuMRU/NoE1VEVe+U/jmh31ovQRNTeBbhe0MHxA3tsFE0RZ33zAHk6MLVCNiS0Ys0n7cnG3atB8uKy/KjhOo5gvUowBxo232EbRlGXK7cqZnZh6L97GBTwLG6rPCi7P6WrYlazgTsVctQ7wWd9tsjoRJKizrWUm/pGKzuH/NIw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c79f7f79-f620-4ef2-25f6-08d502db6e09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR21MB0126;
x-ms-traffictypediagnostic: MWHPR21MB0126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(26323138287068)(89211679590171)(9452136761055)(100324003535756);
x-microsoft-antispam-prvs: <MWHPR21MB0126CB595B22F30106E80C81F4640@MWHPR21MB0126.namprd21.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2017 23:33:00.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0126
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJ0aW4gw4VncmVuIFttYWls
dG86bWFydGluLmFncmVuQGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjIs
IDIwMTcgNzozNyBQTQ0KPiBUbzogQmVuIFBlYXJ0IDxCZW4uUGVhcnRAbWljcm9zb2Z0LmNvbT4N
Cj4gQ2M6IERhdmlkIFR1cm5lciA8RGF2aWQuVHVybmVyQHR3b3NpZ21hLmNvbT47IMOGdmFyIEFy
bmZqw7Zyw7AgQmphcm1hc29uDQo+IDxhdmFyYWJAZ21haWwuY29tPjsgQ2hyaXN0aWFuIENvdWRl
ciA8Y2hyaXN0aWFuLmNvdWRlckBnbWFpbC5jb20+Ow0KPiBnaXRAdmdlci5rZXJuZWwub3JnOyBK
dW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+OyBKb2hhbm5lcw0KPiBTY2hpbmRlbGlu
IDxqb2hhbm5lcy5zY2hpbmRlbGluQGdteC5kZT47IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkN
Cj4gPHBjbG91ZHNAZ21haWwuY29tPjsgSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0Pg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY4IDA4LzEyXSBmc21vbml0b3I6IGFkZCBhIHRlc3QgdG9vbCB0byBk
dW1wIHRoZSBpbmRleA0KPiBleHRlbnNpb24NCj4gDQo+IE9uIDIyIFNlcHRlbWJlciAyMDE3IGF0
IDE4OjM1LCBCZW4gUGVhcnQgPGJlbnBlYXJ0QG1pY3Jvc29mdC5jb20+DQo+IHdyb3RlOg0KPiA+
IEFkZCBhIHRlc3QgdXRpbGl0eSAodGVzdC1kdW1wLWZzbW9uaXRvcikgdGhhdCB3aWxsIGR1bXAg
dGhlIGZzbW9uaXRvcg0KPiA+IGluZGV4IGV4dGVuc2lvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEJlbiBQZWFydCA8YmVucGVhcnRAbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgTWFr
ZWZpbGUgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPiA+ICB0L2hlbHBlci90ZXN0LWR1
bXAtZnNtb25pdG9yLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0L2hlbHBl
ci90ZXN0LWR1bXAtZnNtb25pdG9yLmMNCj4gDQo+IFlvdSBmb3JnZXQgdG8gYWRkIHRoZSBuZXcg
YmluYXJ5IHRvIC5naXRpZ25vcmUuIChJbiBwYXRjaCAxMi8xMiwgeW91IGludHJvZHVjZQ0KPiB0
ZXN0LWRyb3AtY2FjaGVzLCB3aGljaCB5b3UgX2RvXyBhZGQgdG8gLmdpdGlnbm9yZS4pDQo+IA0K
DQpPb3BzLiAgVGhhbmtzISAgSG9wZWZ1bGx5IEp1bmlvIGNhbiBzcXVhc2ggdGhpcyBpbi4uLg0K
DQo+IE1hcnRpbg0KPiANCj4gZGlmZiAtLWdpdCBhL3QvaGVscGVyLy5naXRpZ25vcmUgYi90L2hl
bHBlci8uZ2l0aWdub3JlIGluZGV4DQo+IDZmMDdkZTYyZC4uMGZlMmUwNDQwIDEwMDY0NA0KPiAt
LS0gYS90L2hlbHBlci8uZ2l0aWdub3JlDQo+ICsrKyBiL3QvaGVscGVyLy5naXRpZ25vcmUNCj4g
QEAgLTYsNiArNiw3IEBADQo+ICAvdGVzdC1kZWx0YQ0KPiAgL3Rlc3QtZHJvcC1jYWNoZXMNCj4g
IC90ZXN0LWR1bXAtY2FjaGUtdHJlZQ0KPiArL3Rlc3QtZHVtcC1mc21vbml0b3INCj4gIC90ZXN0
LWR1bXAtc3BsaXQtaW5kZXgNCj4gIC90ZXN0LWR1bXAtdW50cmFja2VkLWNhY2hlDQo+ICAvdGVz
dC1mYWtlLXNzaA0KPiAtLQ0KPiAyLjE0LjEuNzI3Lmc5ZGRhZjg2DQoNCg==
