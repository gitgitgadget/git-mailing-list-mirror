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
	by dcvr.yhbt.net (Postfix) with ESMTP id C36551F461
	for <e@80x24.org>; Tue, 27 Aug 2019 17:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfH0RNw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 13:13:52 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:1793 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0RNw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 13:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2410; q=dns/txt; s=iport;
  t=1566926031; x=1568135631;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=9G8FGZxe7tTnSzoMTmHskKxrc4SFz2avLR4J5mvwjoo=;
  b=jomsoHqzJRjFOP59yQF9zheoW+534sHisN4QgVHHn5X/jZuxMNS1XS8c
   hVJR7IQBjw8T1eDoS01WRw4Vs/DXVXn6R0Jz2/SCO8PSlQf6LeN2kCUEw
   1a/hQoygZa3zO5JyWoIoB/IZlO2e1EyCKWInLJg5PuQonJcsYowFTjoPj
   4=;
IronPort-PHdr: =?us-ascii?q?9a23=3A1f0urxAyOByeaiUms85pUyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qg93kTRU9Dd7PRJw6rNvqbsVHZIwK7JsWtKMfkuHw?=
 =?us-ascii?q?QAld1QmgUhBMCfDkiuN/fwcS0SF8VZX1gj9Ha+YgBY?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DRAADoY2Vd/5NdJa1lHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBVQUBAQsBgURQA4FDIAQLKoQhg0cDinNNgWqYDoEugSQDVAkBAQEMAQE?=
 =?us-ascii?q?tAgEBhD8CF4IvIzYHDgIKAQEEAQEBAgEGBG2FLgELhUsCBBIREQwBATgPAgE?=
 =?us-ascii?q?IGgIfBwICAjAVEAIEEyKDAIFrAx0BAqAvAoE4iGFzgTKCewEBBYUHGIIWCYE?=
 =?us-ascii?q?MKAGLdBiBf4E4DBOCTD6ERBeCdDKCBCKPHpxVCQKCHpRIG4IyliSNa4E2kxu?=
 =?us-ascii?q?DWQIEAgQFAg4BAQWBVwgpgVhwFWUBgkGCQjiDOopTcoEpjh4BAQ?=
X-IronPort-AV: E=Sophos;i="5.64,438,1559520000"; 
   d="scan'208";a="621688698"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 27 Aug 2019 17:13:51 +0000
Received: from XCH-ALN-014.cisco.com (xch-aln-014.cisco.com [173.36.7.24])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id x7RHDp8h009018
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 17:13:51 GMT
Received: from xhs-aln-003.cisco.com (173.37.135.120) by XCH-ALN-014.cisco.com
 (173.36.7.24) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 12:13:50 -0500
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by xhs-aln-003.cisco.com
 (173.37.135.120) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 12:13:49 -0500
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-003.cisco.com (64.101.210.230) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 13:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeAw3Xv8XOrVn9Ue0ZRjRC/dkQzZtiEcBwzsDq4loJsR6zuh0bnJOe41AYsWndTdgRB55ZooPx79F5OLlzxpBPj+EblS/15qprQHGauEcjy+PNb8ALjYc5lt9jLbw1Cj0/CJBaiDKk0kGFtUeUJiNzxSKIGOROeXgYmnrBPHdVVVpAYMMDsoWpKmAZKFchahKYycUh2Urbn2mGb1mZNNsrK+5M7Z1hB2ZylxMnb7CJSrJQHLaP2faZHCZaxYJCicaJhepUn1b/8i+4VxWfHA2E9PmRKQemGKw26IEjfw5EoYns2rZ1R7gxNKftJj0wnKxH6mr/HcXXpL7l0FDDbH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G8FGZxe7tTnSzoMTmHskKxrc4SFz2avLR4J5mvwjoo=;
 b=VlgeRTw2qqBp/7ED3OR1ouzruYSCjrq0TAHWgdnF3RDVf/YPDPcfBt6wihWMsKpLoUKezhyS/MG2TzbeF4PW5yolWY5T7H0KsoeXLtUskKUdN0GpILdNuq0YtpXvxGFWmFY7lqOsQdPjS4UgTbkL36jlnc3huf4uIgemkJraQM/lR0GOZU8VNVVrVH/GA7kDWBJ5q9RZUw/aC8KciEEYcuZK8muFj+XfWTbjS+MvDzeHT5TieZPFb5MgVhpI51aso01D+y4ED9Bhb7wkz9ccajiV7RnRSz0HBbh6RelHs1Tu9lIsTdQrNX/RhmLxyZUxK1vN9aQ7TQrwFsO5By60Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G8FGZxe7tTnSzoMTmHskKxrc4SFz2avLR4J5mvwjoo=;
 b=0SAfcwYXo0x830R2ne0R4ZANPdO0DY2evnA/0BX46V3Ff5tzVJv7k2O2+/YIXzk9fQ9ooksZ8id4w4K7l3t92hS9XUbODs4KcxpQQSlRH+kopwNw38mjHFp+AkWrlezQhkMrJ76dNnQ3mFiYWZaESBA9Gf5P6TCEpl+mq2u0t40=
Received: from BYAPR11MB2694.namprd11.prod.outlook.com (52.135.227.148) by
 BYAPR11MB2710.namprd11.prod.outlook.com (52.135.227.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 17:13:47 +0000
Received: from BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::1977:524c:5db5:d6da]) by BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::1977:524c:5db5:d6da%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 17:13:47 +0000
From:   "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git commit" of single file takes 5 minutes, mounted
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
Thread-Topic: "git commit" of single file takes 5 minutes, mounted
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
Thread-Index: AQHVXE7tEXn5rKV5UEWW1pdt7rpvlKcOx5sA
Date:   Tue, 27 Aug 2019 17:13:47 +0000
Message-ID: <C09D54C7-6759-4205-B4D7-66C847B62450@cisco.com>
References: <7A1C0468-E07D-4D10-8891-01AC1FA1CC1B@cisco.com>
In-Reply-To: <7A1C0468-E07D-4D10-8891-01AC1FA1CC1B@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sarvi@cisco.com; 
x-originating-ip: [2001:420:30d:1254:109f:2b8e:58a0:aeeb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78bc60aa-05d5-44a8-9261-08d72b11ec3b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR11MB2710;
x-ms-traffictypediagnostic: BYAPR11MB2710:
x-microsoft-antispam-prvs: <BYAPR11MB2710D90862E13E83CE45560BBFA00@BYAPR11MB2710.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(23363002)(199004)(305945005)(5660300002)(6116002)(102836004)(6506007)(46003)(71190400001)(6246003)(53936002)(2351001)(33656002)(71200400001)(25786009)(36756003)(2616005)(14454004)(6512007)(11346002)(478600001)(446003)(86362001)(6486002)(6436002)(5640700003)(2501003)(76116006)(229853002)(76176011)(7736002)(14444005)(256004)(476003)(486006)(8676002)(1730700003)(81156014)(81166006)(66446008)(64756008)(66556008)(186003)(8936002)(58126008)(66476007)(316002)(66946007)(99286004)(2906002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2710;H:BYAPR11MB2694.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m8AxwocR4u9hJkztbRvrdY3MCSpNx7yuWtObN0b144WvpA5TfpL3fFEz7lpT5eJ66vQLg+xZrzl936wmSA5P1JmZUAvDu6CN3gj6yoUV+yFSJUPeAS4tjWebUqsy47srr3CSXoYhcK+z1uzjXljvepGyv0rUQuIfX6wwlZmvENRbqLiZrBing/t/L+0JNtIg2BHEfeuxPTFbPoMY3zbjhp7HpPIt1H+V5JDAHpC1pZL+Mwnyq/fJnAonQdv0HYYRT4dz+QOei8uDVXnbgDMJft6WCsT8/SQ+5VhqIIDLLJvF4YR8Ne+6UD6mj10SbaVmP4Mg4ZLT8yQkdkK264GlRiF3bXO3R+yiVIHHZsmgp7LE1nh1tb54K4kkknuLDUd9uD8fqtftgOCNWxYHr0V2Jas/CzX8j8GYl3V4pjmwSYc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <09EF1D3B2D984848B85C1D543D1D7527@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bc60aa-05d5-44a8-9261-08d72b11ec3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 17:13:47.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mU1quBqqgLdmlZzkeYQ3ojzyaEwRITsjC67V4AHVr0SI3z4QtG1HBrVs6nOF/v38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2710
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.24, xch-aln-014.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW55IHN1Z2dlc3Rpb24gb3IgYWR2aWNlIGhvdyB0byBvcHRpbWl6ZSB0aGlzIGluIEdJVCA/DQoN
CiANClRoYW5rcywNClNhcnZpDQpPY2NhbeKAmXMgUmF6b3IgUnVsZXMNCg0K77u/T24gOC8yNi8x
OSwgMTo0MyBQTSwgIlNhcmF2YW5hbiBTaGFubXVnaGFtIChzYXJ2aSkiIDxzYXJ2aUBjaXNjby5j
b20+IHdyb3RlOg0KDQogICAgDQogICAgQmFzZWQgb24gYSBwcmV2aW91cyB0aHJlYWQg4oCcRmly
c3QgR2l0IHN0YXR1cyB0YWtlcyA0MCsgbWludXRlcywgd2hlbiBtb3VudGluZyBmaWxleXN0ZW0v
ZGlza2ltYWdlIHdpdGggNTBHIEdJVCByZXBvICsgOTAwRyBvZiBidWlsZHMgYXJ0aWNsZXPigJ0N
CiAgICANCiAgICBUaGUgY29udGV4dCBpcyB0aGF0IA0KICAgICAgMS4gZ2l0IHdva3NwYWNlIHdh
cyBjbG9uZSg1MEcpDQogICAgICAyLiBzb21lIDMwIHBsYXRvcm1zIGJ1aWxkKDkwMEcpDQogICAg
ICAzLiBUaGlzIHRyZWUgd2FzIHRoZW4gY29waWVkIGludG8gYSBuZXcgZGlza2ltYWdlL2ZpbGVz
eXN0ZW0gKyBnaXQgdXBkYXRlLWluZGV4IC0tcmVmcmVzaCIgd2FzIGRvbmUgdG8gdXBkYXRlIHRo
ZSBpbmRleCB0byB0aGUgbmV3IGZpbGVzeXN0ZW0sIHRoZW4gZnJvemVuLg0KICAgICAgNC4gTmV3
IHdvcmtzcGFjZXMgY3JlYXRlZCBieSBjbG9uaW5nIHRoaXMgZnJvemVuIGRpc2tpbWFnZSg8IDMw
IHNlY29uZHMpDQogICAgICA1LiBUaGlzIGRpc2tpbWFnZSB3YXMgbW91bnRlZCBvbiBhIG5ldyBt
YWNoaW5lDQogICAgICA2LiBBIGZpbGUgd2FzIG1vZGlmaWVkIGFuZCAiZ2l0IGFkZC9jb21taXQi
IHdhcyBkb25lDQogICAgDQogICAgSSBoYXZlIGRvbmUg4oCcZ2l0IHVwZGF0ZS1pbmRleCDigJNy
ZWZyZXNo4oCdLCBpbiB0aGUgbW91bnRlZCBmaWxlc3lzdGVtLCBhcyBhYm92ZQ0KICAgIFRoaXMg
aGFzIGltcHJvdmVkIOKAnGdpdCBzdGF0dXMvZGlmZuKAnSB0aW1pbmcgZnJvbSA0MCsgbWludXRl
cyB0byAxLjUgbWludXRlcyBmb3IgdGhlIGZpcnN0IHRpbWUgYW5kIDw1IHNlY29uZHMgZm9yIHN1
YnNlcXVlbnQgY2FsbHMuDQogICAgDQogICAgQnV0ICJnaXQgY29tbWl0IC1tICJkdW1teSBjb21t
aXQiIG9mIGEgMSBsaW5lIGNoYW5nZSBpbiAxIGZpbGUgdGFrZXMgYWJvdXQgNS02IG1pbnV0ZXMs
IGV2ZXJ5dGltZSBpbiB0aGlzIHdvcmtzcGFjZS4NCiAgICBUcmFjaW5nIHNob3dzIGEgd2hvbGUg
YnVuY2guIFRoZSBlbnRpcmUgNS02IG1pbnV0ZXMgd29ydGggb2YgdGhlIGZvbGxvd2luZyBzb3J0
IG9mIHRyYWNlIGxvZ3MuDQogICAgMzoxMzo1MC4zMjA5MzAgdHJhY2UgZ2l0LWxmczogZmlsZXBh
dGhmaWx0ZXI6IHJlamVjdGluZyAieC95L3ouby5jb21tYW5kIiB2aWEgW10NCiAgICAxMzoxMzo1
MC4zMjA5NDAgdHJhY2UgZ2l0LWxmczogZmlsZXBhdGhmaWx0ZXI6IGFjY2VwdGluZyAiIHgveS96
Lm8uY29tbWFuZCAiDQogICAgMTM6MTM6NTAuMzIwODYyIHRyYWNlIGdpdC1sZnM6IGZpbGVwYXRo
ZmlsdGVyOiByZWplY3RpbmcgImEvYi9jL2Quby5jb21tYW5kIiB2aWEgW10NCiAgICAxMzoxMzo1
MC4zMjA5NzIgdHJhY2UgZ2l0LWxmczogZmlsZXBhdGhmaWx0ZXI6IGFjY2VwdGluZyAiIGEvYi9j
L2QuLm8uY29tbWFuZCINCiAgICANCiAgICBEb2VzIGFueW9uZSBoYXZlIGFueSBpbnNpZ2h0cyBv
biB3aGF0IGNvdWxkIGJlIGNhdXNpbmcgdGhpcz8NCiAgICAgICAgIA0KICAgIFRoYW5rcywNCiAg
ICBTYXJ2aQ0KICAgIE9jY2Ft4oCZcyBSYXpvciBSdWxlcw0KICAgIA0KICAgIA0KDQo=
