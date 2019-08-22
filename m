Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AFC1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 18:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfHVSCM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 14:02:12 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:27784 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfHVSCL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 14:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1434; q=dns/txt; s=iport;
  t=1566496930; x=1567706530;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=xmKDeR+hVYEH9ADP6iSFm5XrHlzgGJXIaof77gDC0mc=;
  b=a04KIrHyr6zQ3DOIl/vP1MaPpCja1HQAh/HH3nElslekwQyCQtq5ksRq
   6kiLdU5xMRl77HxRJHMBJbP0PCl57xgEdwSUCUEVo9mphvlrpvIgkeLwC
   c+i3T/N3qlLXGfpM1kCoBwb4lu9sRZzTahwIqXEmAZG/ZTsJHYsde/uMa
   w=;
IronPort-PHdr: =?us-ascii?q?9a23=3Aa15KUhTdMOpoaL690fIe8X+FmNpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESUDdfA8/wRje3QvuigQmEG7Zub+FE6OJ1XH1?=
 =?us-ascii?q?5g640NmhA4RsuMCEn1NvnvOjczBtpDfFRk5Hq8d0NSHZW2ag=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CqAAAV2F5d/4wNJK1kHgEGBwaBUwk?=
 =?us-ascii?q?LAYFEUAOBQiAECyqEIINHA4ppTYFqmAuBLoEkA1QJAQEBDAEBLQIBAYRYgkg?=
 =?us-ascii?q?jNAkOAgkBAQQBAQMBBgRthS0BC4VjEREMAQE4EQEiAh8HAgQwFRIENYMAgWs?=
 =?us-ascii?q?DHQECoF4CgTiIYXOBMoJ7AQEFhR0YghYJgQwoAYtuGIF/gTgME4pZMoIEIo8?=
 =?us-ascii?q?YnEgJAoIdlD0bmEqNX5gTAgQCBAUCDgEBBYFQOIFYcBVlAYJBgkI4gzqKU3K?=
 =?us-ascii?q?BKYtfAQE?=
X-IronPort-AV: E=Sophos;i="5.64,417,1559520000"; 
   d="scan'208";a="317066429"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 Aug 2019 18:02:09 +0000
Received: from XCH-RCD-020.cisco.com (xch-rcd-020.cisco.com [173.37.102.30])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id x7MI29io028160
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 18:02:09 GMT
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by XCH-RCD-020.cisco.com
 (173.37.102.30) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Aug
 2019 13:02:09 -0500
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by xhs-rcd-002.cisco.com
 (173.37.227.247) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Aug
 2019 13:02:07 -0500
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-003.cisco.com (173.37.227.248) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 22 Aug 2019 13:02:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM1NFGQRvdQpKl2A0w6D6X7GTfYFiUpQjn4N2KQ8Z3FZNHy+/luvodPD+w75d8C1my3oGprPUbp32DBwdRhpXuwmAkhliVhlgZsx+oXCQtp74tFQwv+2PQZ3y/t8X+Ko3oEDONqmXaGNIQeUdd+HcspOBVyEF4QUBtfvF6R66eG4uwMNbTEmL2G+jZtXTDooFhooAtn+50P5dgQCUdTwzPzeHOBiPU/0dmLbV6088pawyyPF7WUgUDQMPfum1pmN1GtMstq7E/l09Qh5BXmxsVFzXtgg+beo6YhBK5SrtMXLCoVZUC8bfHOLSj9aP4fFkz7UZcPx81j111BOQkbrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmKDeR+hVYEH9ADP6iSFm5XrHlzgGJXIaof77gDC0mc=;
 b=HMRVoSkYVXSfCnWfRUnFMIz0f2OzuCfg/asFfLILc7DOuXg4teN5W7VkyDOvyLPDjS6DEszRNDlyXj6pEpiUz248k8iqHaDKB5IGU7+aaeDcZn2zyyZph3eDyAnOBK2vd8UCOpigeygDdBiRPxkaaXVEwb6SXbyMMKHB5y3E66kPjIuLe/XAc2D7c29ct5+/wgd/C6kN45DF43Kxsxk65aIZzugLRY8hDEcv6OT9rdLe4sTrBUNeRr0WhE3BrdxsigF5uHkGiWgBnFQ2jmyI2dimF0YL01TFR4Mra0vmviHVfNPVs2k5snTM8snLUv95DvtraVHUmX4OIY9FovXFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmKDeR+hVYEH9ADP6iSFm5XrHlzgGJXIaof77gDC0mc=;
 b=C5+tG+ceiCT0SwT11QRH8BtTha7eWp8RlvvefkfjljwLOwnMO5oHnqb+I5FhNx3+/cfAUQHxgEaoxConXt9FIQFT9apPNnwyLLQXZ0OnnIi2xS1IHutwj5BY4B3RWnmVVd1G4vd8whnrnXgE7rvritBa1bHLGLMlwGWiYYp24Kk=
Received: from BYAPR11MB2694.namprd11.prod.outlook.com (52.135.227.148) by
 BYAPR11MB3127.namprd11.prod.outlook.com (20.177.227.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 18:02:06 +0000
Received: from BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::1977:524c:5db5:d6da]) by BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::1977:524c:5db5:d6da%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 18:02:06 +0000
From:   "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: First Git status takes 40+ minutes, when mounting fileystem/diskimage
 with 50G GIT repo + 900G of builds articles
Thread-Topic: First Git status takes 40+ minutes, when mounting
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
Thread-Index: AQHVWRO1ER69eoLi/kiFh7KrYPM/rQ==
Date:   Thu, 22 Aug 2019 18:02:06 +0000
Message-ID: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sarvi@cisco.com; 
x-originating-ip: [2001:420:30d:1254:109f:2b8e:58a0:aeeb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93d3f0a8-a34c-429a-68b0-08d7272ad7ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR11MB3127;
x-ms-traffictypediagnostic: BYAPR11MB3127:
x-microsoft-antispam-prvs: <BYAPR11MB31278027EEB5F70F1175B6E8BFA50@BYAPR11MB3127.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(23363002)(2616005)(46003)(476003)(25786009)(53936002)(64756008)(66556008)(66476007)(66446008)(76116006)(6436002)(6486002)(6512007)(5640700003)(66946007)(478600001)(2501003)(2906002)(14454004)(86362001)(6916009)(2351001)(6116002)(36756003)(33656002)(8936002)(186003)(8676002)(316002)(4744005)(81156014)(81166006)(1730700003)(5660300002)(486006)(71200400001)(71190400001)(7736002)(58126008)(256004)(14444005)(305945005)(6506007)(99286004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3127;H:BYAPR11MB2694.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x8yUgYd6JhDGbvSCZYnJUkFHhWQLBqWUprqjHq3SgN55v9O/0QnIVViQSLDMCVzzHQpTVX7pqNl1GGp5KBjnFABp6NDyRZ33QWVtNgcuzOvC5BCBEbGvHlJY+lmwC/J8K//drT+xB/CRuBKaM/JJkNDmgOq671FeI9MV+0qJu/vxhPCD2KOEvaTvCFFR/LyrTl073+QkHjQ9+qL1xSHgEbT/5SMuDE4UVdUmBkQs0QsRKVLUl5Tqm0bw9YictYZevEWCspfIKlXFFuE1KvMU/m0WIE+E+LMRaKxE1zazcov9B5xgJNN7/9TN4LyCiGHT0ylG0L8lluLZSUw5T/9ht07vRRsqyfiqujqndt5DVP6eoDBdgkIV/VgX+xl3QXN+SDtdV2VVZAOqW3ITRXyuuUP2BDe7d+Z+lRbrdJs1lOc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4933DD42690A9F4BA0A285B1C3FF65A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d3f0a8-a34c-429a-68b0-08d7272ad7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 18:02:06.0894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fah0cSRzS2wIgiHZoT8xje1Udu1cQ1CJWcUcmdx6yIzF6fwCCMLCrwDIxfmfmr7T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3127
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.30, xch-rcd-020.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCldlIGhhdmUgYSBkaXNraW1hZ2UvZmlsZXlzeXN0ZW0gdGhhdCBoYXMgYSA1MEcgR2l0IHJl
cG9zaXRvcnkgKyA5MDBHIG9mIGJpbmFyeS9idWlsZCBhcnRpY2xlcyBhbmQgdW50cmFja2VkIGZp
bGVzLg0KV2hlbiB3ZSBtb3VudCBzdWNoIGEgZGlza2ltYWdlLCBUaGUgdmVyaWZ5IGZpcnN0IOKA
nGdpdCBzdGF0dXPigJ0gY29tbWFuZCBjYW4gdGFrZSBhcyBsb25nIDQwLTUwbWludXRlcy4NClN1
YnNlcXVlbnQg4oCcZ2l0IHN0YXR1c+KAnSBmaW5pc2ggaW4gdW5kZXIgNS0xMCBzZWNvbmRzLg0K
DQpJZiBJIGhhZCBhIGRpc2tpbWFnZSBvZiBqdXN0IHRoZSA1MEcgc291cmNlIHJlcG9zaXRvcnks
IGFuZCBJIG1vdW50IGFuZCBkbyBhIOKAnGdpdCBzdGF0dXPigJ0gdGFrZXMgYXJvdW5kIDE1IHNl
Y29uZHMuDQoNCkhvdyBjYW4gd2Ugb3B0aW1pemUgdGhpcyB0byBiZSBmYXN0ZXI/DQoNCkkgc3Vz
cGVjdCB3YXJtaW5nIHRoZSBmaWxlc3lzdGVtIGNhY2hpbmcgaXMgaW4gcGxheS4NCkJ1dCBzbyBp
cyB0aGUgZmFjdCB0aGF0IHdhbGsgZXZlcnkgdHJlZSB0byBmaW5kIHVudHJhY2tlZCBmaWxlcyBh
cyB3ZWxsLiANCg0KTXkgaW50ZXJlc3QgaW4gZ2l0IHN0YXR1cyBpcyB0aGUgNTBHIG9mIHNvdXJj
ZXMvcmVwb3NpdG9yeSBub3QgdGhlIDkwMEcgb2YgYnVpbGQgZ2VuZXJhdGVkIGFydGljbGVzIGlu
IHRoZSB3b3Jrc3BhY2U/DQpJIGhhdmUgdHJpZWQgYWRkaW5nIC5naXRpZ25vcmUgdG8gd2hvbGUg
ZGlyZWN0b3J5IHRyZWVzIHRoYXQgY29udGFpbiBidWlsZCBhcnRjbGVzLCA3MDBHIGFyZSBleGNs
dWRlZCB1c2luZyBnaXQgaWdub3JlcywgYW5kIHRoYXQgc3RpbGwgZHJvcHMgdGhlIHRpbWUgZm9y
IGdpdCBzdGF0dXMgdG8gb25seSAzMCBtaW51dGVzLCB3aGljaCBpcyBoaWdoLg0KdGltZSBnaXQg
c3RhdHVzIC11bm8gLS1pZ25vcmVkPW5vDQoNCkFueSBzdWdnZXN0aW9ucyBvbiBob3cgdG8gcm9v
dCBjYXVzZSBhbmQgb3B0aW1pemUgdGhpcyBjYXNlPw0KDQoNClRoYW5rcywNClNhcnZpDQpPY2Nh
beKAmXMgUmF6b3IgUnVsZXMNCg0K
