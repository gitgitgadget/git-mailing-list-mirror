Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A411F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 10:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfHNKE7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 06:04:59 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:26537 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNKE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 06:04:58 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 06:04:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2570; q=dns/txt; s=iport;
  t=1565777096; x=1566986696;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Wtmd3AvA/+aqCe7X4sFZSpt+l5czOeEjuRKHRRvkIy8=;
  b=RycQSy6MG2Ebce/sUseqVfV5r3cmnVmYIT8xmgQ/bNAs6JGSdJAaaX4k
   bCARj43Qra1Y/BWhRkYCwydFYjZe69/NWbcgbc1vNwK7cv6FAiiU5W5st
   K9Dty6Lx1R45Q3Cgi7aXDL4fpkj7klmkFMfs8toEpStjp9oMKg6XTbiOT
   s=;
IronPort-PHdr: =?us-ascii?q?9a23=3AwdVM5xTBhWauNBogGckLuE2TBNpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESXBNfA8/wRje3QvuigQmEG7Zub+FE6OJ1XH1?=
 =?us-ascii?q?5g640NmhA4RsuMCEn1NvnvOjQiEdheVVls13q6KkNSXs35Yg6arw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DRCQC22lNd/4wNJK1mHgEGBwaBZ4F?=
 =?us-ascii?q?FUANtVSAECyoKhBSDRwOKdkyZcYJSA1QJAQEBDAEBIwoCAQGEPxmCdSM4EwE?=
 =?us-ascii?q?EAQEEAQEEAQpthScBC4VjEQQNDAEBOBEBBhwCJgIEMBUSBA0IAQEegwABgWo?=
 =?us-ascii?q?DHQEOjmSQYQKBOIhgc38zgnoBAQWCR4I8GIIUAwaBDCiLaReBQD+BOIYKAgI?=
 =?us-ascii?q?YgV6CdIJYjxScPQkCgh0DhmGNSQYbmD2NV4dfkCQCBAIEBQIOAQEFgWchgVh?=
 =?us-ascii?q?wFYMnE4IUG4NyglmHenKBKYwrAYEgAQE?=
X-IronPort-AV: E=Sophos;i="5.64,384,1559520000"; 
   d="scan'208";a="310226062"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 14 Aug 2019 09:57:53 +0000
Received: from XCH-RCD-010.cisco.com (xch-rcd-010.cisco.com [173.37.102.20])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id x7E9vrtw018459
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 09:57:53 GMT
Received: from xhs-aln-002.cisco.com (173.37.135.119) by XCH-RCD-010.cisco.com
 (173.37.102.20) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 04:57:52 -0500
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xhs-aln-002.cisco.com
 (173.37.135.119) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 04:57:52 -0500
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-002.cisco.com (64.101.210.229) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 14 Aug 2019 05:57:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDKMM+qMCNxugEjGzppSyjjhVvZPThadTjn56Tf83WEtk2ZKic7eoXUIU7D5m1CyIE5In+7mPjybS2euhg2dLumpD4ywSrrweqfuQrz+/WxRmOkBGEaeohFiSb0Kq9DfeN3891AhI2OvmsYbn5qGWyL+xo/9CV67WgEBynWHIbCcRDkkhCDeu8PDZNae8uwjfZDne83n/ZHxc/z8YxfCC37M0RWWIfVps53Cmbkgh9jEU8fKWiW6ErCahQzft4hdiDh3az/+98Dppe0Bq7puYMkQAl7yzLbH4Bffkcm0mf40Dl32gjaLOdABLkQg8jeEdvK0KRMV3omJ3H4e7nLaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wtmd3AvA/+aqCe7X4sFZSpt+l5czOeEjuRKHRRvkIy8=;
 b=nNsWjcfCJ892j8Eae8P6lcEAz3iCZTkm0HDB0NrcO3nQ1T8FBJuvUq6dRLjY7BQ7pAS1VzONd1TAaK92NNBZErEykiEnCmFspUHGitQSzm31iUcMuc6y7pY11h65Qyaw7rk6cyKvsm2D53+E4IazrUiR+SLMsDaL4N5wUKxQJZdQulc4YWJ24GRxxMkukfeFm+hVtoRLqh8By5qGPDo8oB1g9KBOOlbs8dEMCCrqdKeDy91fwYpBRYkCXEOQ1TXtWRreqZ4FAkhwnKcykbm2mejHBTGjQ+gTOhaXG418e5oENXUfAB+1Gu2OPxNlL/0IvSnSbbAaH1o629agCQ/Rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wtmd3AvA/+aqCe7X4sFZSpt+l5czOeEjuRKHRRvkIy8=;
 b=jH5qUigA80rOG00UgxbzCF14pKL2VZ1Betdpi6jpPZDAEm11AEH7m2WB7nYtohm4GhnBafSXuZsIh1lTSmKZEb43XbCcvK/2QAZF2GTLg5Pp/23n7beRPOVgAOuGchwcXzgpOP8mltOyIV9eGHA4dWI+FYR+WokzDf8ByVLU6rc=
Received: from CY4PR11MB1912.namprd11.prod.outlook.com (10.175.81.150) by
 CY4SPR00MB2450.namprd11.prod.outlook.com (10.172.182.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Wed, 14 Aug 2019 09:57:51 +0000
Received: from CY4PR11MB1912.namprd11.prod.outlook.com
 ([fe80::496c:dcfc:9192:5d54]) by CY4PR11MB1912.namprd11.prod.outlook.com
 ([fe80::496c:dcfc:9192:5d54%12]) with mapi id 15.20.2157.022; Wed, 14 Aug
 2019 09:57:50 +0000
From:   "Paolo Pettinato (ppettina)" <ppettina@cisco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git fetch bug in git 2.21+ "Could not access submodule '%s'"
Thread-Topic: Git fetch bug in git 2.21+ "Could not access submodule '%s'"
Thread-Index: AQHVUoa7uzYIHbD+fES+2/mVSFIeOg==
Date:   Wed, 14 Aug 2019 09:57:50 +0000
Message-ID: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
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
x-ms-office365-filtering-correlation-id: 9d666d69-7d2a-4045-0da8-08d7209dde64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4SPR00MB2450;
x-ms-traffictypediagnostic: CY4SPR00MB2450:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <CY4SPR00MB24505EA87D04DB4D6B69D385C3AD0@CY4SPR00MB2450.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(6436002)(66946007)(58126008)(53936002)(102836004)(26005)(486006)(6506007)(2616005)(5640700003)(2906002)(186003)(3846002)(6486002)(14454004)(64126003)(99286004)(316002)(478600001)(6916009)(86362001)(2501003)(6116002)(6306002)(6512007)(31696002)(305945005)(966005)(36756003)(14444005)(256004)(81166006)(476003)(2351001)(81156014)(5660300002)(8936002)(66446008)(1730700003)(71200400001)(25786009)(8676002)(64756008)(91956017)(76116006)(31686004)(65826007)(65806001)(65956001)(7736002)(66476007)(71190400001)(66556008)(66066001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4SPR00MB2450;H:CY4PR11MB1912.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EoaxFBBdGDI2BvPJTNMACd74SD8GRxBHJiAkOoakXMhwQOTx0Wr996oEOjwTg2rcdGaSQC/yBwTgWb/TSmGkbk1bpDPA6YS+34GJbiLNtdMEu1pTuQOIOHY1JpU6Nfnc7/dqoR8OfWYW5yKxT18z/9GrCQAqvDxbUXyWgaFFR4RT6Y7WYlqaPs63YjmcQYQd6FsDAGf65/KMGgHRu3vqMVvtp4YyHB1bGi0Hljgl/LEH3O0Z7mBDlnw2SWgXKeLwMrZK/n4rh1Pzor2pH4ZeXeMyPJIy0U+rPgYgCbTRT+mzsZWFWh8prLPYocjHqK0BMYMt0NmtBDzzEXYwoZ+dLiaDs2k8sZ4xg/m6KdnrvVNndXNjIaGsBA7uUc+7BPP7xm5V8rz/xEDuPBzJw/w05/JgDQ7VDWd4sQhLJBt4+SU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAAB5F1239DD9F41B211AF9CFCD368A0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d666d69-7d2a-4045-0da8-08d7209dde64
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 09:57:50.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SO46PSL80eC/ptR09k67gVTYaVZmf3xTBig5G/8z8DNYZ5/RgZh7culydXcxcUps1OIDS1BCh/pjT5UaWcYuzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4SPR00MB2450
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.20, xch-rcd-010.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U3BvdHRlZCB0aGlzIHdoZW4gb3VyIEplbmtpbnMgZXhlY3V0b3JzIGhhZCBnaXQgdXBkYXRlZCwg
YW5kIGxhdGVyIA0KbWFuYWdlZCB0byByZXByb2R1Y2UgbG9jYWxseS4NClRoZSBpc3N1ZSBoYXBw
ZW5zIHdoZW4gZmV0Y2hpbmcgYW4gdXBkYXRlZCByZWYgZnJvbSBhIHJlbW90ZSwgYW5kIHRoYXQg
DQpyZWYgdXBkYXRlcyBhIHN1Ym1vZHVsZSB3aGljaCBpcyBub3QgY2hlY2tlZCBvdXQgYnV0IHdo
b3NlIGZvbGRlciBpcyBkaXJ0eS4NCg0KU3RlcHMgdG8gcmVwcm9kdWNlIChvbiAqbml4KSB3aXRo
IHJlcG9zaXRvcmllcyBvbiBHaXRIdWI6DQpTY2VuYXJpbzogZ2l0LWZldGNoLWJ1ZyByZXBvc2l0
b3J5IHdpdGggMiBicmFuY2hlcywgdGhlIEhFQURzIGZvciB0aGVzZSANCmJyYW5jaGVzIHBvaW50
IHJlc3BlY3RpdmVseSB0byAyIGRpZmZlcmVudCBjb21taXRzIGluIGEgc3VibW9kdWxlLg0KDQok
IG1rZGlyIGdpdF9yZXBvDQokIGNkIGdpdF9yZXBvDQoNCiMgTWFudWFsbHkgZmV0Y2ggIm1hc3Rl
ciIgYnJhbmNoDQokIGdpdCBpbml0DQokIGdpdCByZW1vdGUgYWRkIG9yaWdpbiBodHRwczovL2dp
dGh1Yi5jb20vcGFvbG9wZS9naXQtZmV0Y2gtYnVnLmdpdA0KJCBnaXQgZmV0Y2ggb3JpZ2luIG1h
c3Rlcg0KDQojIENoZWNrb3V0DQokIGdpdCBjaGVja291dCBtYXN0ZXINCg0KIyBSZXBvIG5vdyBj
b250YWlucyBhIGZvbGRlciBuYW1lZCAic20iIHdoaWNoIGlzIGJvdW5kIHRvIGNvbnRhaW4gYSAN
CnN1Ym1vZHVsZSBjaGVja291dC4gQnV0IHRoZSBzdWJtb2R1bGUgaXMgbm90IGNoZWNrZWQgb3V0
IHlldC4NCiMgRGlydHkgdGhhdCBmb2xkZXI6DQokIHRvdWNoIHNtL3Rlc3QNCg0KIyBGZXRjaGlu
ZyBhbm90aGVyIGJyYW5jaCB3aWxsIGZhaWwNCiQgZ2l0IGZldGNoIG9yaWdpbiBicmFuY2hfMQ0K
DQpPdXRwdXQ6DQpyZW1vdGU6IEVudW1lcmF0aW5nIG9iamVjdHM6IDcsIGRvbmUuDQpyZW1vdGU6
IENvdW50aW5nIG9iamVjdHM6IDEwMCUgKDcvNyksIGRvbmUuDQpyZW1vdGU6IENvbXByZXNzaW5n
IG9iamVjdHM6IDEwMCUgKDMvMyksIGRvbmUuDQpyZW1vdGU6IFRvdGFsIDUgKGRlbHRhIDIpLCBy
ZXVzZWQgNSAoZGVsdGEgMiksIHBhY2stcmV1c2VkIDANClVucGFja2luZyBvYmplY3RzOiAxMDAl
ICg1LzUpLCBkb25lLg0KIEZyb20gaHR0cHM6Ly9naXRodWIuY29tL3Bhb2xvcGUvZ2l0LWZldGNo
LWJ1Zw0KIMKgKiBicmFuY2jCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyYW5jaF8xwqDCoCAtPiBG
RVRDSF9IRUFEDQogwqAqIFtuZXcgYnJhbmNoXcKgwqDCoMKgwqAgYnJhbmNoXzHCoMKgIC0+IG9y
aWdpbi9icmFuY2hfMQ0KQ291bGQgbm90IGFjY2VzcyBzdWJtb2R1bGUgJ3NtJyAjIGZhaWxzLCBw
bHVzIG5vIG5ld2xpbmUgaGVyZSA6UCENCg0KIyBSZS1pc3N1aW5nIHRoZSBjb21tYW5kIHN1Y2Nl
ZWRzDQokIGdpdCBmZXRjaCBvcmlnaW4gYnJhbmNoXzENCg0KT3V0cHV0Og0KIEZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3Bhb2xvcGUvZ2l0LWZldGNoLWJ1Zw0KIMKgKiBicmFuY2jCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyYW5jaF8xwqDCoCAtPiBGRVRDSF9IRUFEDQoNCkknZCBleHBlY3QgdGhl
IGNvbW1hbmQgbm90IHRvIGZhaWwsIG9yIHRvIGZhaWwgY29uc2lzdGVudGx5LiBUaGlzIA0KYmVo
YXZpb3VyIGRpZG4ndCBoYXBwZW4gaW4gZ2l0IDIuMTguMSwgc28gdGhlIHJlZ3Jlc3Npb24gd2Fz
IGludHJvZHVjZWQgDQpzb21ld2hlcmUgaW4gYmV0d2Vlbi4NCkl0IGlzIHBvc3NpYmxlIHRoYXQg
dGhpcyBpcyByZWxhdGVkIHRvIHRoaXMgaXNzdWU6IA0KaHR0cHM6Ly9tYXJjLmluZm8vP2w9Z2l0
Jm09MTU1MjQ2NDkzNjEzNTkyJnc9Mg0KUmVnYXJkcywNClBhb2xvIFBldHRpbmF0bw0KKio=
