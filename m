Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B532047F
	for <e@80x24.org>; Tue, 19 Sep 2017 22:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdISWoX (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 18:44:23 -0400
Received: from mail-sn1nam02on0099.outbound.protection.outlook.com ([104.47.36.99]:28483
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751599AbdISWoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 18:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dNdqYvl0kj9q2LvvVIpJXZYv6vGeRndfjd2hau18uLM=;
 b=JD65O224VPtrx/BXDb/S3X7oHA3QVC83V25OdbXtaenwpQ6DNgJQE5GxRJ0dnOwCNG+dAiggUylm22c1L3AWQ6efmapy40T8ZFKBcJH+ieX6unfJtVQnLA6s2Q+Sybp6jqMGL6TrVb0wX3sVzmnaFXxZDQq83dTAIjSD1Slf55E=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0128.namprd21.prod.outlook.com (10.173.52.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Tue, 19 Sep 2017 22:44:20 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0098.001; Tue, 19 Sep 2017 22:44:20 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     David Turner <David.Turner@twosigma.com>,
        'Ben Peart' <peartben@gmail.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v7 06/12] ls-files: Add support in ls-files to display the
 fsmonitor valid bit
Thread-Topic: [PATCH v7 06/12] ls-files: Add support in ls-files to display
 the fsmonitor valid bit
Thread-Index: AQHTMX18A0sjk/8IpEGw2oMqiZU8rKK8nO+AgAAQRACAAAvhgIAAFCuw
Date:   Tue, 19 Sep 2017 22:44:19 +0000
Message-ID: <MWHPR21MB0478B3F5367538567A5C20EEF4600@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-7-benpeart@microsoft.com>
 <37b2e5b4ca1d490b9f50d430b3b420f0@exmbdft7.ad.twosigma.com>
 <f1213833-be5e-4850-0ffa-d063e2d1deb8@gmail.com>
 <34effd8a881e497d8f5bdd56acc2285d@exmbdft7.ad.twosigma.com>
In-Reply-To: <34effd8a881e497d8f5bdd56acc2285d@exmbdft7.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-19T18:44:18.4589717-04:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [65.222.173.206]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0128;6:Qo5nY8Lr+I0k/XSs43jrnUtsd58VNUxF0Wuv6y9FfEo/YYEe58kB23FuNdf0dQRExcSVAqr+EwTj/tpDIzAjZ1RsDCXKsz+wwxa7Zz+FQHgSqAjfkG77RPHM+7aCguIWkscztdXVJ98cNHUGtcUGzrsqXtaXQkm39aNs1kWEeTwbCRse9M/tmRdWoEpgPc+Jc/PLYscxoWMX4ZGabuzB2khDFiFI0q04lHTgku5oVEOpwGoVt6Sj+jeha5imF3CMwuqhN4qQ1aH5z2XIjGyhMTQq8sJwpmMdsAisWnFG/T0XTvAtUd4j09O0XwShzKZvCL/g1gpW/l+2QFOHVcg0DQ==;5:u/bqip8F6a/Tu4O6exvmkKE4ETLXv78LTFuEqPmMJFgiR9OrHDptAzknVWyJ00q10Q5rP46r1x9FeQkvJwExjSVXdA1/T3thwBW8OTj0Nle/zpE1m428giOtXEtrW8RHua/jTID6EC1QIA0wOovbgQ==;24:KQU2A1U8v7rrjGzjkLFmiLto4bIgj4fZFlXjhlC9b9vv7PlygxwJurKu5fob6ajP4kn2OX1EOTCxNb01UQYer6EDT8hOoz79P8rHKAj2qZ4=;7:fDEEoAD6PNOmP2YK1450Ll3YjfDBUx3RiEIL0O/GWYvaxArMLTLvcLkFQFoDxXQuconzQseAyT/3WOWsIK1fdE448zxIh4FOHbPaE90WNwRhMiaUqAAhOZrZ8W2bXBhaqn9Wpt3AJ1q14qeJHFUhDCHG9hCaBcitkye13zFAqkoE+EfFy5WfTBTbbNQSqCnRvdC4tHwEUo+7Iz0d0ag3CynrX9ZVPMTSh4vXSZJHM+U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4ad9db51-3e13-4457-5c5b-08d4ffaff769
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR21MB0128;
x-ms-traffictypediagnostic: MWHPR21MB0128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(26323138287068)(89211679590171)(9452136761055)(100324003535756)(17755550239193);
x-microsoft-antispam-prvs: <MWHPR21MB01287684410FA889173CC6C6F4600@MWHPR21MB0128.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0128;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0128;
x-forefront-prvs: 04359FAD81
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(13464003)(377454003)(189002)(24454002)(199003)(99286003)(55016002)(66066001)(10090500001)(7696004)(68736007)(97736004)(4326008)(6436002)(39060400002)(316002)(8666007)(53936002)(54906003)(7736002)(77096006)(6246003)(6506006)(305945005)(9686003)(74316002)(14454004)(110136005)(22452003)(86362001)(86612001)(229853002)(189998001)(81166006)(81156014)(53546010)(33656002)(3660700001)(2906002)(2900100001)(478600001)(10290500003)(25786009)(5660300001)(8676002)(72206003)(8656003)(3846002)(102836003)(6116002)(93886005)(8990500004)(105586002)(8936002)(2950100002)(3280700002)(54356999)(50986999)(76176999)(101416001)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0128;H:MWHPR21MB0478.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2017 22:44:20.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0128
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBUdXJuZXIgW21haWx0
bzpEYXZpZC5UdXJuZXJAdHdvc2lnbWEuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIg
MTksIDIwMTcgNToyNyBQTQ0KPiBUbzogJ0JlbiBQZWFydCcgPHBlYXJ0YmVuQGdtYWlsLmNvbT47
IEJlbiBQZWFydA0KPiA8QmVuLlBlYXJ0QG1pY3Jvc29mdC5jb20+DQo+IENjOiBhdmFyYWJAZ21h
aWwuY29tOyBjaHJpc3RpYW4uY291ZGVyQGdtYWlsLmNvbTsgZ2l0QHZnZXIua2VybmVsLm9yZzsN
Cj4gZ2l0c3RlckBwb2JveC5jb207IGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRlOyBwY2xvdWRz
QGdtYWlsLmNvbTsNCj4gcGVmZkBwZWZmLm5ldA0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY3IDA2
LzEyXSBscy1maWxlczogQWRkIHN1cHBvcnQgaW4gbHMtZmlsZXMgdG8gZGlzcGxheSB0aGUNCj4g
ZnNtb25pdG9yIHZhbGlkIGJpdA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiBGcm9tOiBCZW4gUGVhcnQgW21haWx0bzpwZWFydGJlbkBnbWFpbC5jb21dDQo+ID4g
U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE5LCAyMDE3IDQ6NDUgUE0NCj4gPiBUbzogRGF2aWQg
VHVybmVyIDxEYXZpZC5UdXJuZXJAdHdvc2lnbWEuY29tPjsgJ0JlbiBQZWFydCcNCj4gPiA8YmVu
cGVhcnRAbWljcm9zb2Z0LmNvbT4NCj4gPiBDYzogYXZhcmFiQGdtYWlsLmNvbTsgY2hyaXN0aWFu
LmNvdWRlckBnbWFpbC5jb207IGdpdEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gZ2l0c3RlckBwb2Jv
eC5jb207IGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRlOyBwY2xvdWRzQGdtYWlsLmNvbTsNCj4g
PiBwZWZmQHBlZmYubmV0DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwNi8xMl0gbHMtZmls
ZXM6IEFkZCBzdXBwb3J0IGluIGxzLWZpbGVzIHRvDQo+ID4gZGlzcGxheSB0aGUgZnNtb25pdG9y
IHZhbGlkIGJpdA0KPiA+DQo+ID4NCj4gPg0KPiA+IE9uIDkvMTkvMjAxNyAzOjQ2IFBNLCBEYXZp
ZCBUdXJuZXIgd3JvdGU6DQo+ID4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
PiBGcm9tOiBCZW4gUGVhcnQgW21haWx0bzpiZW5wZWFydEBtaWNyb3NvZnQuY29tXQ0KPiA+ID4+
IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxOSwgMjAxNyAzOjI4IFBNDQo+ID4gPj4gVG86IGJl
bnBlYXJ0QG1pY3Jvc29mdC5jb20NCj4gPiA+PiBDYzogRGF2aWQgVHVybmVyIDxEYXZpZC5UdXJu
ZXJAdHdvc2lnbWEuY29tPjsgYXZhcmFiQGdtYWlsLmNvbTsNCj4gPiA+PiBjaHJpc3RpYW4uY291
ZGVyQGdtYWlsLmNvbTsgZ2l0QHZnZXIua2VybmVsLm9yZzsgZ2l0c3RlckBwb2JveC5jb207DQo+
ID4gPj4gam9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU7IHBjbG91ZHNAZ21haWwuY29tOyBwZWZm
QHBlZmYubmV0DQo+ID4gPj4gU3ViamVjdDogW1BBVENIIHY3IDA2LzEyXSBscy1maWxlczogQWRk
IHN1cHBvcnQgaW4gbHMtZmlsZXMgdG8NCj4gPiA+PiBkaXNwbGF5IHRoZSBmc21vbml0b3IgdmFs
aWQgYml0DQo+ID4gPj4NCj4gPiA+PiBBZGQgYSBuZXcgY29tbWFuZCBsaW5lIG9wdGlvbiAoLWYp
IHRvIGxzLWZpbGVzIHRvIGhhdmUgaXQgdXNlDQo+ID4gPj4gbG93ZXJjYXNlIGxldHRlcnMgZm9y
ICdmc21vbml0b3IgdmFsaWQnIGZpbGVzDQo+ID4gPj4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBC
ZW4gUGVhcnQgPGJlbnBlYXJ0QG1pY3Jvc29mdC5jb20+DQo+ID4gPj4gLS0tDQo+ID4gPj4gICBi
dWlsdGluL2xzLWZpbGVzLmMgfCA4ICsrKysrKy0tDQo+ID4gPj4gICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgc3Rp
bGwgbWlzc2luZyB0aGUgY29ycmVzcG9uZGluZyBkb2N1bWVudGF0aW9uIHBhdGNoLg0KPiA+DQo+
ID4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24uDQo+IA0KPiBUaGFua3MgZm9yIGZvbGxvd2luZyB1
cC4NCj4gDQo+ID4gPiAxMC8xMiAobm8gcmVwbHksIGhhdmVuJ3QgY2hlY2tlZCB3aGV0aGVyIHNh
bWUgaXNzdWUgYnV0IEkgYXNzdW1lDQo+ID4gPiBzYW1lIGlzc3VlIHNpbmNlIHRoZSBuZXcgY2Fz
ZSBJIG1lbnRpb25lZCBpc24ndCBhZGRlZCkNCj4gPg0KPiA+IEl0IHdhc24ndCBhIGJ1ZyBzbyBJ
IGRpZG4ndCAiZml4IiBpdC4gIEkganVzdCBzZW50IGFuIGV4cGxhbmF0aW9uIGFuZA0KPiA+IHBh
dGNoIGRlbW9uc3RyYXRpbmcgd2h5LiBZb3UgY2FuIGZpbmQgaXQgaGVyZToNCj4gDQo+IEkgd2Fz
IGNvbmNlcm5lZCBhYm91dCB0aGUgY2FzZSBvZiBhbiB1bnRyYWNrZWQgZmlsZSBpbnNpZGUgYSBk
aXJlY3RvcnkgdGhhdA0KPiBjb250YWlucyBubyB0cmFja2VkIGZpbGVzLiAgWW91ciBwYXRjaCBp
biB0aGlzIG1haWwgdHJlYXRzIGRpcjMganVzdCBsaWtlIGRpcjEgYW5kDQo+IGRpcjIuICBJIHRo
aW5rIHlvdSBvdWdodCB0byB0ZXN0IHRoZSBjYXNlIG9mIGEgZGlyIHdpdGggbm8gdHJhY2tlZCBm
aWxlcy4NCj4gDQoNCkluIHRoZSBjYXNlIHdoZXJlIHRoZXJlIGlzIGFuIHVudHJhY2tlZCBmaWxl
IGluc2lkZSBhIGRpcmVjdG9yeSB0aGF0IGNvbnRhaW5zIG5vIHRyYWNrZWQgZmlsZXMsIGdpdCB3
aWxsIChhcyBzaG93biBieSB0aGUgImZhaWxpbmciIHRlc3QpIGFjdHVhbGx5IGZpbmQgdGhlIHVu
dHJhY2tlZCBmaWxlLiAgVGhpcyBpcyB0aGUgY29ycmVjdC9leHBlY3RlZCBiZWhhdmlvci4gIFRo
ZSB0ZXN0IGZhaWx1cmUgaXMganVzdCBpbmRpY2F0aW5nIHRoYXQgdGhlIG9wdGltaXphdGlvbiBv
ZiBub3Qgc2VhcmNoaW5nIHRoYXQgZGlyZWN0b3J5IGZvciB1bnRyYWNrZWQgZmlsZXMgd2FzIG5v
dCBhYmxlIHRvIG9jY3VyIChiZWNhdXNlIHRoZXJlIHdhcyBubyBlbnRyeSBpbiB0aGUgdW50cmFj
a2VkIGNhY2hlIGZvciB0aGF0IGRpcmVjdG9yeSkuDQoNCj4gQWZ0ZXIgbW9yZSBjYXJlZnVsIGNo
ZWNraW5nLCBpdCBsb29rcyBsaWtlIHRoaXMgY2FzZSBkb2VzIHdvcmssIGJ1dCBpdCdzIHN0aWxs
DQo+IHdvcnRoIHRlc3RpbmcuDQoNCg==
