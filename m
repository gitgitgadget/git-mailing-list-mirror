Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6529F1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 17:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfHNRDv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 13:03:51 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:64580 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfHNRDu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 13:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1738; q=dns/txt; s=iport;
  t=1565802228; x=1567011828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N4ZBeL9O4M271G4kP7/D9RWeqM6U+kt3AkUE0S7aTqs=;
  b=VwRPf1XDVrnn2HlDxWZAsi6bRQCfeboCZGwfjgr5bm0fwo2SCJ/rp/NN
   7ufIuedKRNIFL/fPthRhxmH2ZduWjJ6oazTKSXfXdiUBHXTnHv9lgCF6Z
   PreEVziBK0U3V8tA/TYjpSVf8/Sux+cwyhjywzeins0XSw7c7FPwhKNXT
   U=;
IronPort-PHdr: =?us-ascii?q?9a23=3AxsJvshK383dnqPiT19mcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeBvKd2lFGcW4Ld5roEkOfQv636EU04qZea+DFnEtRXUg?=
 =?us-ascii?q?Mdz8AfngguGsmAXFXjIeL2biozNM9DT1RiuXq8NBsdFQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D1AACFPlRd/40NJK1mGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBZ4FFUAOBQiAECyoKhBSDRwOKdoI2JZdjglIDVAkBAQEMAQE?=
 =?us-ascii?q?tAgEBhD8CF4J2IzgTAQQBAQQBAQQBCm2FJwyFSwEBAQMSEREMAQE3AQ8CAQg?=
 =?us-ascii?q?YAgImAgICMBUQAgQBDAEHAQEegwCBawMdAaARAoE4iGBzgTKCegEBBYJHgjs?=
 =?us-ascii?q?YghQJgQwoi0wdF4FAP4E4DIJfPoQdJxeCdIJYjxSOD44uCQKCHZQtBhuYPY1?=
 =?us-ascii?q?XlESDPwIEAgQFAg4BAQWBZyGBWHAVgydQEBSBToNyilNygSmLU4ExAYEgAQE?=
X-IronPort-AV: E=Sophos;i="5.64,386,1559520000"; 
   d="scan'208";a="319477391"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 14 Aug 2019 17:03:47 +0000
Received: from XCH-RCD-007.cisco.com (xch-rcd-007.cisco.com [173.37.102.17])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id x7EH3lRk017278
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 14 Aug 2019 17:03:47 GMT
Received: from xhs-aln-001.cisco.com (173.37.135.118) by XCH-RCD-007.cisco.com
 (173.37.102.17) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 12:03:46 -0500
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xhs-aln-001.cisco.com
 (173.37.135.118) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 12:03:46 -0500
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-002.cisco.com (64.101.210.229) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 14 Aug 2019 13:03:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwXu80eGLsf5qWwMeQhLJsbnQRdf5mxMmM+mzFA7RCUh3Mk1zELIkefuMhWxsPErdYk5Yd6ougPESSuYSheNx/81o8ca4Zn5nAjCxhOvFB/2MtDKsZxF7ugJSqAuXhTgmkPi5LfdxTQnCaQ/algfrKrdmccyWlgv7DIxUiXRiiIlNhmAsHUJ+SnbAwzw4LgnBrVUPbC8l3ZXEINZfLDDZ72IniwD4JkIQNm/xcih4o4r45GyRLGdL9JDo+7Si4dZ9TS9IlL4oQYCL7A7rMuzKPhfRTHuFf3BM7ec6BwaTMtdn9ox+TjnRigG4k1kumMyf3p3lDCYQj2gKHo5HmkR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4ZBeL9O4M271G4kP7/D9RWeqM6U+kt3AkUE0S7aTqs=;
 b=DO9xlnLCoMLMzUhSfqQf7HMt3m66PDREVKcPk7a+4/sa9jJAn4hsw4rUExNeYQK0UsBU2TjWV6GM2Zmiq0AUKGzVjJgWQfEvPg2uadO2nrgqgAq34ohxJcONaFSpDsNIyjmxU7ns8MY+oZKc+QZOHO15T7FM7esJ+Kb+Cl69i1CeTxB/sGsDBIyn2eYIZYZhPbNjlhugRdMk+E4chNgLvG3s0Ptbvu+KSxUPrb6wq+n7p292dJbBbRG9adcvNn0rE8tEiPfw9qOXkrtbYswLYH+mAbCHhkRYLA5FXhrwKQeJZjwxH2/xIB8D2UYkhVkf+yl269sO55BnEfb0wSLqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4ZBeL9O4M271G4kP7/D9RWeqM6U+kt3AkUE0S7aTqs=;
 b=SVlKq7qBF7pj/kSro27hSESxf/CKm42sHkPdF1c1CA2H/mW/T+7Ei5hDh5TYj90nnor276U8Ssk8PU68C26IJHHafh3VocJDbaBaRbZ+TXPcOCxpVoDWFf14dQmGOy2wE4rFLPnsILeImGcde2M1Gn0uoeLajaJMeomrZcJevnM=
Received: from CY4PR11MB1912.namprd11.prod.outlook.com (10.175.81.150) by
 CY4PR11MB1782.namprd11.prod.outlook.com (10.175.59.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Wed, 14 Aug 2019 17:03:44 +0000
Received: from CY4PR11MB1912.namprd11.prod.outlook.com
 ([fe80::496c:dcfc:9192:5d54]) by CY4PR11MB1912.namprd11.prod.outlook.com
 ([fe80::496c:dcfc:9192:5d54%12]) with mapi id 15.20.2157.022; Wed, 14 Aug
 2019 17:03:44 +0000
From:   "Paolo Pettinato (ppettina)" <ppettina@cisco.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git fetch bug in git 2.21+ "Could not access submodule '%s'"
Thread-Topic: Git fetch bug in git 2.21+ "Could not access submodule '%s'"
Thread-Index: AQHVUoa7uzYIHbD+fES+2/mVSFIeOqb6xu2AgAASJ2+AAAZDAA==
Date:   Wed, 14 Aug 2019 17:03:44 +0000
Message-ID: <5a58b0eb-0690-c445-dbfd-bd4c5b614629@cisco.com>
References: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
 <20190814153607.GB12093@sigill.intra.peff.net>
 <xmqqpnl766pj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnl766pj.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ppettina@cisco.com; 
x-originating-ip: [64.103.40.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83ad69fe-598b-4e15-719b-08d720d95d65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR11MB1782;
x-ms-traffictypediagnostic: CY4PR11MB1782:
x-microsoft-antispam-prvs: <CY4PR11MB1782AEEDB244C3760832DD78C3AD0@CY4PR11MB1782.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(51914003)(6436002)(14454004)(256004)(110136005)(6116002)(53546011)(76176011)(36756003)(4326008)(316002)(25786009)(186003)(53936002)(229853002)(3846002)(86362001)(66066001)(65806001)(102836004)(65956001)(6246003)(478600001)(6486002)(31686004)(31696002)(26005)(6506007)(81156014)(58126008)(305945005)(8936002)(7736002)(8676002)(65826007)(6512007)(81166006)(71190400001)(486006)(446003)(5660300002)(64126003)(2616005)(76116006)(66556008)(476003)(64756008)(4001150100001)(99286004)(66476007)(66446008)(11346002)(66946007)(71200400001)(91956017)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1782;H:CY4PR11MB1912.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: di4/Sj0XXVlki8FwBck7ZIRZn5puiqTEhiuuSK0RRuDRejryXZFVbSDyzr9r1XZhUD84MZnRXQ10duNyWNiYRdvkHIZDH03rIHPdPbQLWaQgemhdAXEV8jQyHOQDG1ZVq4YAxMPCnn5tBx9MeB4arVxI2MbBqeVgmOODBymZQInGtRGKbWqZEPJiitCV8trol/UzRucic4r03o6ZR33eyEdVr0Av9RTD3NcSstQ6CH7hYuMIr2QTVXrKQd6+CUtCxn2KAhLGhqVxJydjNlv1Rwy0FhaWU8FwfSxpKh1FW1XiPDmdd0eJPlMW3t+EXJgTZcLvNLJWY7iI3jepfeaCSJ96JXC+EFL1iKiO+FDNAIEsaXjFXGXEPlxTLE23sITUVLgNkZhFphmEiT98zyNTMfTtTSeyBDOkWVDkNmvi+uY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6198F73B4F804043B97670FFCD19B9B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ad69fe-598b-4e15-719b-08d720d95d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 17:03:44.1026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVPFjGwZ4/VwkhLM3zKXO765EjfJsCc9nex8P9SHHET5I7E8RJt2pX0MUU/R5duVL0VmIF8n+W2Fm5dkOSrIsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1782
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.17, xch-rcd-007.cisco.com
X-Outbound-Node: alln-core-8.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmVwbHkhDQoNCk9uIDE0LzA4LzIwMTkgMTc6NDAsIEp1bmlvIEMgSGFt
YW5vIHdyb3RlOg0KPiAgIFdoeSBpcyB0aGUgdXNlciBtdWNraW5nIHdpdGgNCj4gdGhhdCBkaXJl
Y3RvcnkgaW4gdGhlIGZpcnN0IHBsYWNlLCBhbmQgaXNuJ3QgdGhlIGZsYWdnaW5nIG9mIHRoZQ0K
PiBzaXR1YXRpb24gYXMgYW4gZXJyb3IsIGRvbmUgd2l0aCAyNmY4MGNjZiAoInN1Ym1vZHVsZTog
bWlncmF0ZQ0KPiBnZXRfbmV4dF9zdWJtb2R1bGUgdG8gdXNlIHJlcG9zaXRvcnkgc3RydWN0cyIs
IDIwMTgtMTEtMjgpLCBhDQo+IGJ1Z2ZpeD8gIElmIG5vdCwgd2h5IG5vdD8NCg0KTm90IHN1cmUg
aWYgeW91J3JlIGltcGx5aW5nIGhlcmUgdGhhdCB0aGlzIGlzIG5vdCBhIGJ1ZzsgSSdkIHNheSB0
aGF0Og0KDQotIE11Y2tpbmcgYWJvdXQgd2l0aCBhIGZvbGRlciB0aGF0J3Mgc3VwcG9zZWQgdG8g
Y29udGFpbiBhIHN1Ym1vZHVsZSBpcyANCm5vdCBzb21ldGhpbmcgdGhhdCBhIGxvdCBvZiBwZW9w
bGUgZG8gKGFuZCB3ZSB3b3JrZWQgYXJvdW5kIHRoZSBpc3N1ZSksIA0KYW5kIHBlb3BsZSBzaG91
bGRuJ3QgZG8gdGhhdCwgYnV0Li4uDQoNCi0gLi4uIHJlZ2FyZGxlc3MsIEkgYmVsaWV2ZSB0aGF0
ICJnaXQgZmV0Y2giIHNob3VsZG4ndCBwYXJ0aWN1bGFybHkgY2FyZSANCmFib3V0IHRoZSBzdGF0
ZSBvZiB0aGUgY3VycmVudCB3b3JraW5nIGRpcmVjdG9yeS4gSSBkaWRuJ3QgYXNrIGl0IHRvIGRv
IA0KYW55dGhpbmcgd2l0aCB0aGUgc3VibW9kdWxlcywgbm9yIGhhdmUgSSBpbml0aWFsaXNlZCB0
aGVtLiBJbiBteSANCihsaW1pdGVkKSBrbm93bGVkZ2Ugb2YgZ2l0LCBJJ2QgZXhwZWN0IGdpdCBm
ZXRjaCB0byBkbyBpdHMgbWFnaWMgDQplbnRpcmVseSBiZXR3ZWVuIHRoZSByZW1vdGUgYW5kIHRo
ZSAuZ2l0IGZvbGRlci4NCg0KT3VyIHVzZSBjYXNlIHdhcyBmb3IgYSBzdWJtb2R1bGUgY29udGFp
bmluZyBlbmNyeXB0ZWQgc2VjcmV0czsgYW5kIHRoZSANCm11Y2tpbmcgYWJvdXQgd2FzIHN0dWJi
aW5nIG91dCB0aG9zZSBzZWNyZXRzIGluIGEgdGVzdCBidWlsZCB3aXRob3V0IA0KZmV0Y2hpbmcv
ZGVjcnlwdGluZyB0aGVtLg0KDQpJdCdzIGFyZ3VhYmxlIHdoZXRoZXIgdGhpcyBzaG91bGQgYmUg
Zml4ZWQgb3Igbm90OyBsZXNzIGFyZ3VhYmxlIHRoYXQgd2UgDQpjb3VsZCB1c2UgYSBiZXR0ZXIg
ZXJyb3IgbWVzc2FnZSBhbmQgY29uc2lzdGVuY3kgKDFzdCBleGVjdXRpb24gZmFpbHMsIA0KMm5k
IGRvZXMgbm90KS4NCg==
