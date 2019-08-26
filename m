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
	by dcvr.yhbt.net (Postfix) with ESMTP id 393621F461
	for <e@80x24.org>; Mon, 26 Aug 2019 20:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfHZUnk (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 16:43:40 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:61851 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfHZUnj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 16:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2038; q=dns/txt; s=iport;
  t=1566852218; x=1568061818;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=uZ3Pi7kCMQHfJ0XzWCP2fYtHxUepXhp54L9af8vuXEQ=;
  b=A44u3U9I4xjMPBhRMLxUJf2/pmcouS9pExNr/qybCnT7LAN+whR6NrGC
   0/6YcdBUJhLbfWc+CjqzeEIVG8mN6Co0BP6xLQFkXt4TDfewB+Ye/HlEm
   jO4ye5sXWMPDktzqtmcGrJ83OYx7qCnI89NqAIz6CVh5VG8ggUZMLpLwV
   c=;
IronPort-PHdr: =?us-ascii?q?9a23=3Afht/3RGfQVAT4fImWQb4+Z1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e4w3A3SRYuO7fVChqKWqK3mVWEaqbe5+HEZON0pNV?=
 =?us-ascii?q?cejNkO2QkpAcqLE0r+eeXjdTI7NM9DT1RiuXq8NBsdFQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0C7IQBDQ2Rd/5JdJa1kHgEGBwaBZ4F?=
 =?us-ascii?q?FUAOBQyAECyqEIYNHA4pvTYFqmA2CUgNUCQEBAQwBAS0CAQGEPxmCUCM4EwI?=
 =?us-ascii?q?KAQEEAQEBAgEGBG2FLQELhWMREQwBATgRASICHwcCBDAVEgQ1gwCBawMdAQK?=
 =?us-ascii?q?fSgKBOIhhc4EygnsBAQWFARiCFgmBDCiLchiBf4E4DBOHZYJ0MoIEIo8dnFE?=
 =?us-ascii?q?JAoIelEMbgjKWHY1ogTaTF4NZAgQCBAUCDgEBBYFnIYFYcBVlAYJBgkI4gzq?=
 =?us-ascii?q?KU3KBKY4rAQE?=
X-IronPort-AV: E=Sophos;i="5.64,433,1559520000"; 
   d="scan'208";a="319674828"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 26 Aug 2019 20:43:37 +0000
Received: from XCH-ALN-012.cisco.com (xch-aln-012.cisco.com [173.36.7.22])
        by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id x7QKhbLG002782
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 20:43:37 GMT
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by XCH-ALN-012.cisco.com
 (173.36.7.22) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 15:43:36 -0500
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xhs-rcd-001.cisco.com
 (173.37.227.246) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 15:43:36 -0500
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-002.cisco.com (64.101.210.229) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Aug 2019 16:43:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8o/qzBgxjkMb90zu1i2j22vWbTKV2cohSRXrRkY6FWraHak1rRcodEGvp2+dmmx/gC5mIzV0YUfj/ohJGpYpecE6LkUZRLWRYT32mDOLCi1ep90znRMprECadEZz19SNFoBwDHEUVzipq+cKdJgJq0xy/IzfKxz/JREjx2t9T5S04Xw+X8p0G2r3g7ysApHoDEbniHkeGxMJk+cMFoERfKnQ4hj0SKlFUdMKfeIoyJyIzViCKFYWjyLV2BqSESkQUwpT93p6zDAIu/7nWKNqkyrGeHngsRHih6N9adSSRaWSmaSF+32RRTfxIF0flIy74hYdjgt0/2Vwp/I5JnIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ3Pi7kCMQHfJ0XzWCP2fYtHxUepXhp54L9af8vuXEQ=;
 b=QqftKTI8Awqwh0nu9V7gJ7bVteGMeBwjbmSiqUKiWjzf4/SvjS/hwAtEF7A0MKo9NwFZTCHiMr3QNbZoy+/2HxFgodkRA+F2kcTKxC2jNb2AZrdw2PJii5cTONRzDe87HZDdHZuWrCA0CdZ0AuYmtOkwqZcSAEV3vtkfBh4oywcwQ1Ii+oBHlF35D+bxIqh4U4qUyVoSbhtt8jrC+DAZLavq4Vi1zpwlOw9bNBq/TtgkYtggm0g32kICIWYVlELRqUJJE1NofocUNHwWoPqWJsfycb379DS9KNm1OyYpDaXRjmEuvHXt19XhjKwsOw+pmUc0cvswqpnqq6oepqs9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ3Pi7kCMQHfJ0XzWCP2fYtHxUepXhp54L9af8vuXEQ=;
 b=tFX+dpI1m6DhGcC0ZfAUF5sn1TMtA/sqM8CStdaZAsLTFWRKcOdybzld6+a2gP/rXOps5wXac1XoYwTgUBFzEMYxUgwLwxHjyvihLC2ex3yFhgsWNe8imPZX+xXwB9s5R2CMBDpAbHkmhGC4V0GAHx5bpRxUcE6KpKKGcI2yyc4=
Received: from BYAPR11MB2694.namprd11.prod.outlook.com (52.135.227.148) by
 BYAPR11MB3544.namprd11.prod.outlook.com (20.178.206.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Mon, 26 Aug 2019 20:43:34 +0000
Received: from BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::1977:524c:5db5:d6da]) by BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::1977:524c:5db5:d6da%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 20:43:34 +0000
From:   "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "git commit" of single file takes 5 minutes, mounted
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
Thread-Topic: "git commit" of single file takes 5 minutes, mounted
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
Thread-Index: AQHVXE7tEXn5rKV5UEWW1pdt7rpvlA==
Date:   Mon, 26 Aug 2019 20:43:34 +0000
Message-ID: <7A1C0468-E07D-4D10-8891-01AC1FA1CC1B@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sarvi@cisco.com; 
x-originating-ip: [2001:420:30d:1254:109f:2b8e:58a0:aeeb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bad2e1ca-4b3f-4a77-8550-08d72a661080
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR11MB3544;
x-ms-traffictypediagnostic: BYAPR11MB3544:
x-microsoft-antispam-prvs: <BYAPR11MB3544D2018E79E66798E80E52BFA10@BYAPR11MB3544.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(23363002)(199004)(189003)(305945005)(5660300002)(256004)(14444005)(6486002)(86362001)(7736002)(6116002)(2616005)(36756003)(81156014)(8676002)(1730700003)(71190400001)(486006)(2906002)(71200400001)(2501003)(81166006)(476003)(102836004)(2351001)(46003)(53936002)(6512007)(5640700003)(58126008)(8936002)(99286004)(76116006)(6436002)(66946007)(66446008)(66476007)(186003)(316002)(66556008)(64756008)(478600001)(33656002)(14454004)(6506007)(25786009)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3544;H:BYAPR11MB2694.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QK+ZLxlB0UR/Z+vPWVDoKA8d3q+ReEnz40eh5u+tzVB9b2kboQqiTYl7nMwcHckZ9bjV1tAyxlWILQA+uwcOTKmmuWxQ4AQEbTpgsphTn/AmuMdhY7Wx6GqSChEOFmoBOr69rLRtFwM1yLYLTe1iD/YiS8D+83SAUnRNtAoB2VT7c5gkZErf7kCrHcIOTXKwy9Ttm8RSvsqcX7goMhuzOvXwqe2zTGsfSQkL2oAR6X0ocAgZra7fy4XOd6lrRP/zIWMQPHoNPRJ0J3B51WC6xYbPuAeBdNcXRumMMZltQhC9MoQBGRQqycIXqF0fnc3PtVOv4VjNyqCmCu2n+g0eoy53EuxBEne66H7RhEkRomgh/RlAWGBOV4bJPZEMpyXs5DVhEKa5XbRCERVj4gI3LWzU7Jc+FbUOBJbBqnreTts=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A6FC115F5D9D742978383D66F4D84CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bad2e1ca-4b3f-4a77-8550-08d72a661080
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 20:43:34.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6sJj6mohG5zjcKKphRzg2263hz19sm7vO2LL+5tf+a/UrFF+1I3nxNrItgEafbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3544
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.22, xch-aln-012.cisco.com
X-Outbound-Node: rcdn-core-10.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpCYXNlZCBvbiBhIHByZXZpb3VzIHRocmVhZCDigJxGaXJzdCBHaXQgc3RhdHVzIHRha2VzIDQw
KyBtaW51dGVzLCB3aGVuIG1vdW50aW5nIGZpbGV5c3RlbS9kaXNraW1hZ2Ugd2l0aCA1MEcgR0lU
IHJlcG8gKyA5MDBHIG9mIGJ1aWxkcyBhcnRpY2xlc+KAnQ0KDQpUaGUgY29udGV4dCBpcyB0aGF0
IA0KICAxLiBnaXQgd29rc3BhY2Ugd2FzIGNsb25lKDUwRykNCiAgMi4gc29tZSAzMCBwbGF0b3Jt
cyBidWlsZCg5MDBHKQ0KICAzLiBUaGlzIHRyZWUgd2FzIHRoZW4gY29waWVkIGludG8gYSBuZXcg
ZGlza2ltYWdlL2ZpbGVzeXN0ZW0gKyBnaXQgdXBkYXRlLWluZGV4IC0tcmVmcmVzaCIgd2FzIGRv
bmUgdG8gdXBkYXRlIHRoZSBpbmRleCB0byB0aGUgbmV3IGZpbGVzeXN0ZW0sIHRoZW4gZnJvemVu
Lg0KICA0LiBOZXcgd29ya3NwYWNlcyBjcmVhdGVkIGJ5IGNsb25pbmcgdGhpcyBmcm96ZW4gZGlz
a2ltYWdlKDwgMzAgc2Vjb25kcykNCiAgNS4gVGhpcyBkaXNraW1hZ2Ugd2FzIG1vdW50ZWQgb24g
YSBuZXcgbWFjaGluZQ0KICA2LiBBIGZpbGUgd2FzIG1vZGlmaWVkIGFuZCAiZ2l0IGFkZC9jb21t
aXQiIHdhcyBkb25lDQoNCkkgaGF2ZSBkb25lIOKAnGdpdCB1cGRhdGUtaW5kZXgg4oCTcmVmcmVz
aOKAnSwgaW4gdGhlIG1vdW50ZWQgZmlsZXN5c3RlbSwgYXMgYWJvdmUNClRoaXMgaGFzIGltcHJv
dmVkIOKAnGdpdCBzdGF0dXMvZGlmZuKAnSB0aW1pbmcgZnJvbSA0MCsgbWludXRlcyB0byAxLjUg
bWludXRlcyBmb3IgdGhlIGZpcnN0IHRpbWUgYW5kIDw1IHNlY29uZHMgZm9yIHN1YnNlcXVlbnQg
Y2FsbHMuDQoNCkJ1dCAiZ2l0IGNvbW1pdCAtbSAiZHVtbXkgY29tbWl0IiBvZiBhIDEgbGluZSBj
aGFuZ2UgaW4gMSBmaWxlIHRha2VzIGFib3V0IDUtNiBtaW51dGVzLCBldmVyeXRpbWUgaW4gdGhp
cyB3b3Jrc3BhY2UuDQpUcmFjaW5nIHNob3dzIGEgd2hvbGUgYnVuY2guIFRoZSBlbnRpcmUgNS02
IG1pbnV0ZXMgd29ydGggb2YgdGhlIGZvbGxvd2luZyBzb3J0IG9mIHRyYWNlIGxvZ3MuDQozOjEz
OjUwLjMyMDkzMCB0cmFjZSBnaXQtbGZzOiBmaWxlcGF0aGZpbHRlcjogcmVqZWN0aW5nICJ4L3kv
ei5vLmNvbW1hbmQiIHZpYSBbXQ0KMTM6MTM6NTAuMzIwOTQwIHRyYWNlIGdpdC1sZnM6IGZpbGVw
YXRoZmlsdGVyOiBhY2NlcHRpbmcgIiB4L3kvei5vLmNvbW1hbmQgIg0KMTM6MTM6NTAuMzIwODYy
IHRyYWNlIGdpdC1sZnM6IGZpbGVwYXRoZmlsdGVyOiByZWplY3RpbmcgImEvYi9jL2Quby5jb21t
YW5kIiB2aWEgW10NCjEzOjEzOjUwLjMyMDk3MiB0cmFjZSBnaXQtbGZzOiBmaWxlcGF0aGZpbHRl
cjogYWNjZXB0aW5nICIgYS9iL2MvZC4uby5jb21tYW5kIg0KDQpEb2VzIGFueW9uZSBoYXZlIGFu
eSBpbnNpZ2h0cyBvbiB3aGF0IGNvdWxkIGJlIGNhdXNpbmcgdGhpcz8NCg0KT24gdGhlIG90aGVy
IGhhbmQsIGlmIEkgaGFkIA0KIA0KVGhhbmtzLA0KU2FydmkNCk9jY2Ft4oCZcyBSYXpvciBSdWxl
cw0KDQo=
