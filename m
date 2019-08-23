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
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5651F461
	for <e@80x24.org>; Fri, 23 Aug 2019 00:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbfHWAj2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 20:39:28 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:52715 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbfHWAj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 20:39:27 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 20:39:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2354; q=dns/txt; s=iport;
  t=1566520766; x=1567730366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8Xd5KwDV8aIU9p/101DLp4HTz5xLCD+fUdRUJuHQCwU=;
  b=EPVYyOuzbp1dnQ8I5Qt5bWjEt3DO7I8tOIfj7mdamw37x7Tv8sco0/rl
   Yk9sa9JHaCCBH4XStMp4BHn1WUi5x/c7nc7yVLU1zckVRV0d917JpnRiA
   qwGf8O4c4eBx4QsjFnTmUQVXBJ9WKVv4WNsFiS88mmYPlI5lN7mIHY/nm
   A=;
IronPort-PHdr: =?us-ascii?q?9a23=3AOhvMYhyOwGfWisXXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5YRyN/u1j2VnOW4iTq+lJjebbqejBYSQB+t7A1RJKa5lQT1?=
 =?us-ascii?q?kAgMQSkRYnBZueAFflLdbhbjcxG4JJU1o2t3w=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A1AABBM19d/5pdJa1lGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBVQQBAQELAYFEUAOBQiAECyqEIINHA4puglyXZoEugSQDVAkBAQE?=
 =?us-ascii?q?MAQEtAgEBhD8CF4JIIzYHDgIJAQEEAQEDAQYEbYUtDIVLAQEBAgESEREMAQE?=
 =?us-ascii?q?3AQ8CAQgaAh8HAgICMBUQAgQOBRsHgwCBawMODwECoSQCgTiIYXOBMoJ7AQE?=
 =?us-ascii?q?FhSIYghYJgQwoAYtuGIF/gTgfghc1PoREgwsyggQijxiOFI40CQKCHZQ9G4I?=
 =?us-ascii?q?xi0mKUI8Vll0CBAIEBQIOAQEFgVYBMYFYcBVlAYJBgkIMFxWDOopTcoEpiy0?=
 =?us-ascii?q?BAQ?=
X-IronPort-AV: E=Sophos;i="5.64,419,1559520000"; 
   d="scan'208";a="614527742"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 23 Aug 2019 00:32:20 +0000
Received: from XCH-ALN-013.cisco.com (xch-aln-013.cisco.com [173.36.7.23])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id x7N0WKub026466
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 23 Aug 2019 00:32:20 GMT
Received: from xhs-aln-002.cisco.com (173.37.135.119) by XCH-ALN-013.cisco.com
 (173.36.7.23) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Aug
 2019 19:32:20 -0500
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by xhs-aln-002.cisco.com
 (173.37.135.119) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Aug
 2019 19:32:19 -0500
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-002.cisco.com (173.37.227.247) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 22 Aug 2019 19:32:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWOfmLPb4D0w0E7Xr8l9C9FWtyx6OhGLEIDIn5b+Kie/NWXcX9KNi8CBsQOXm11CW9HcC/4MDs4r180uHwZNeLmA2h3FsK1UqcjlF1KtNyEfh9nBHyoz5WUdMUIqrBrgT37mxM4xOMbMiISmo7gL/+sGKFLDeHknQwP1b0YY4TaMoU/MNp/DHVsQiSpNYXNSo3z+DMPQI8/UUUpEm+Wfb/P+IaZy+9uY9PrevlVQBbWcdzHlQk+h3Cj/gorJvGf/F33k3odb1ceCRm2CqjaQZibhAox/mMB4ZfB130d7WCEa3lNQDnNcswU9JD37c8g+XMOKv/WGrkM/t4hT8YlvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xd5KwDV8aIU9p/101DLp4HTz5xLCD+fUdRUJuHQCwU=;
 b=jhcYTtVEKPDE+CNbdH0I7FUkk8lRdPXoJ9h7D236EobQwFH+SYt57IMBxNW63uMqkTH1leNn52QxZtIFklBueqE38SeLEG/LdPAm318rwy7j1vjVh6SscE1WMrIo0lEh0OdaJArGa3aVw1dokLzNvfe3oizJaF4NiduOIL6TZqUoog0A/19G8R9On+61ScEY2P25b6u/AG4ijDjcfEkwEtAQDyAM4nfDf8sHDkwAp4mQivF4gtIYijMHKXNEUXLycqq9j02x93TZaaWKVc/8Nzs++qnYPtUygC57BdlPzt67zQ9/t/t4W+vHqOSkqTuRKzd+ElNitfesCYtxiEydHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xd5KwDV8aIU9p/101DLp4HTz5xLCD+fUdRUJuHQCwU=;
 b=dASLU8Q2GzcyVGwTkh6GlFDn0qRUHW8VT34RjtCIxE6Cy9PTw8sH+T5zwwmHxU+8maVnaO+rIt+ozednIXjmdyImR1QXVwUbkXUbv4NZJdKUUtsomZiOEw3f1nOR50Tb8JEUcQ2cgIs0rBUHADoVi7tmdbVfEgMdxYHDR7F3YuY=
Received: from BYAPR11MB2694.namprd11.prod.outlook.com (52.135.227.148) by
 BYAPR11MB2597.namprd11.prod.outlook.com (52.135.227.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 00:32:18 +0000
Received: from BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::1977:524c:5db5:d6da]) by BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::1977:524c:5db5:d6da%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 00:32:17 +0000
From:   "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: First Git status takes 40+ minutes, when mounting
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
Thread-Topic: First Git status takes 40+ minutes, when mounting
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
Thread-Index: AQHVWRO1ER69eoLi/kiFh7KrYPM/racHeJNy///gEQA=
Date:   Fri, 23 Aug 2019 00:32:17 +0000
Message-ID: <A240FE33-2B36-46EF-8AE4-0B3B2106908A@cisco.com>
References: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com>
 <xmqqh869oypk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh869oypk.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sarvi@cisco.com; 
x-originating-ip: [2001:420:c0c8:1002::422]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75ab706-4d11-47c2-d0cf-08d727615a75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR11MB2597;
x-ms-traffictypediagnostic: BYAPR11MB2597:
x-microsoft-antispam-prvs: <BYAPR11MB25976F36468ACC0BCE577040BFA40@BYAPR11MB2597.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(23363002)(189003)(199004)(229853002)(76176011)(53936002)(25786009)(71200400001)(6486002)(8936002)(81166006)(81156014)(6246003)(14454004)(6512007)(66446008)(64756008)(8676002)(76116006)(6436002)(478600001)(66946007)(36756003)(46003)(66476007)(71190400001)(66556008)(486006)(11346002)(446003)(2616005)(6916009)(4326008)(476003)(305945005)(102836004)(6116002)(99286004)(6506007)(186003)(14444005)(256004)(5660300002)(2906002)(316002)(86362001)(7736002)(58126008)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2597;H:BYAPR11MB2694.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HXmtFjWgNHUkZX8Nde7zQNQA4RxiRfXVhP8R1H2/USG+SMMFFqCGWmUcD6AP2EXF0Jis4w1QhUnrg2E7PDlybUfB9hjLbSW4jleVFWMFANioVMldpuC3flMyYOdUIbfqGybe6zsNLL6oe1XAFG9nIatgJjUuN0ct4G9+QUr9jixtDr9xQJzrJnt3hKPCjWZk9JaSm8YES/3odqNRAGXbHkyYVu3IVn6sKNIKJTZVrLx2tEuJ07d8X278tx48TyuE+CijsgHbevZtCDL7u6wynYzsYqcDViYym6uTG3T6MAT7GvndZ8K9DQ8qLHNjayTfN5mwCD3ePtGiP8ZvlXLmFVrC6K6gQLHea8pH4gY9hYeYabIW8+K5nhv0z0fAVRfR1u+5NJjItGNNPn239q9lEA9qBIV1uPNowPN8KQKsbnE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4725AF48D65B5E4691031B3ED20DD30B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b75ab706-4d11-47c2-d0cf-08d727615a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 00:32:17.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UEwBB9dhcPt5kKiprgvkUsgGHU+AqBLySGXM4cq4Sy4N+ILe4jGFEn57/ETZs2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2597
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.23, xch-aln-013.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzLiBUaGF0IHNlZW1zIHRvIGhlbHAuDQoNCkp1c3QgZm9yIGNvbnRleHQsIHdlIGFyZSB1
c2luZyBhIGNvcHktb24td3JpdGUvY2xvbmluZyBzb2x1dGlvbiB0byBnaXZlIGRldmVsb3BlcnMg
IGEgcHJlYnVpbHQgd29ya3NwYWNlIHdpdGggYWxsIHRoZSBwbGF0Zm9ybXMgZnVsbHkgYnVpbHQs
IGFzIHdlbGwgYXMgc291cmNlcyBhbGwgY2xvbmVkLA0KU28gdGhleSBhcmUgcmVhZHkgZm9yIGlu
Y3JlbWVudGFsIGRldmVsb3BtZW50Lg0KDQpXZSBjcmVhdGUgYSBleHQ0IGRpc2tpbWFnZSwgd2l0
aCBhIGdpdCBjbG9uZSB3b3Jrc3BhY2UoNTBHKSBhbmQgOTAwRyBvZiBmdWxseSBidWlsdCB0cmVl
cywgdGhlbiBmcmVlemUgdGhhdCBkaXNraW1hZ2UuDQpEZXZlbG9wZXJzIGhhdmUgYSB3YXkgdG8g
Y2xvbmUgdGhhdCBkaXNraW1hZ2UoaW50byBhIGNvcHktb24td3JpdGUpIGNvcHkgb2YgdGhlIGRp
c2tpbWFnZShpbiAzMCBzZWNvbmRzKSB0aGF0IHRoZXkgY2FuIG1vdW50IGFuZCB1c2UgZm9yIGlu
Y3JlbWVudGFsIGJ1aWxkIGRldmVsb3BtZW50Lg0KDQpJIGRpZCB0aGUgZm9sbG93aW5nLg0KDQpN
b3VudGVkIHRoZSBleGlzdGluZyBmaWxlc3lzdGVtDQpnaXQgdXBkYXRlLWluZGV4IC0tdW50cmFj
a2VkLWNhY2hlDQpnaXQgdXBkYXRlLWluZGV4IC0tcmVmcmVzaA0KDQpOb3Qgc3VyZSB3aGF0IHlv
dSBtZWFudCBieSAiIHdvcmtpbmcgdHJlZSBzdGF0ZSBpbiB0aGUgZGlza2ltYWdlIg0KDQpJIHRo
ZW4gZGV0YWNoZWQgdGhlIGRpc2tpbWFnZSwgZHJvcHBlZCBhbGwgdGhlIGNhY2hlcy4gDQpSZW1v
dW50ZWQgdGhlIGRpc2tpbWFnZS4NCg0KDQpnaXQgc3RhdHVzICAtIFRoZSB2ZXJ5IGZpcnN0IGdp
dCBzdGF0dXMgYWZ0ZXIgZHJvcHBpbmcgdGhlIGNhY2hlIG5vdyByZXR1cm5zIGluIGluIDEuNTQg
c2Vjb25kcywgd2hpY2ggc2VlbXMgdmVyeSBtdWNoIGFjY2VwdGFibGUuDQoNCkkgb2J2aW91c2x5
IG5lZWQgdG8gZG8gbW9yZSByZWFkIHVwIG9uIHdoYXQvaG93IGdpdCBjYWNoZXMuDQoNCkNhbiB5
b3UgcG9pbnQgdG8gYW55IGRvY3VtZW50YXRpb24gb24gd2hhdCBzb3J0IG9mIGluZm9ybWF0aW9u
IEdJVCBjYWNoZXMsIGFuZCBob3cgdG8gdW5kZXJzdGFuZCBkZWJ1ZyB0aGF0Pw0KSSB3b3VsZCBs
aWtlIHRvIHVuZGVyc3RhbmQgd2hhdCB0aGUgYWJvdmUgZ2l0IHVwZGF0ZS1pbmRleCBjb21tYW5k
cyBhY3R1YWxseSBkbywgdGhhdCBpcyBtYWtpbmcgdGhpcyBmYXN0ZXIuDQogDQpUaGFua3MsDQpT
YXJ2aQ0KT2NjYW3igJlzIFJhem9yIFJ1bGVzDQoNCu+7v09uIDgvMjIvMTksIDExOjEzIEFNLCAi
SnVuaW8gQyBIYW1hbm8iIDxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGU6DQoNCiAgICAiU2FyYXZh
bmFuIFNoYW5tdWdoYW0gKHNhcnZpKSIgPHNhcnZpQGNpc2NvLmNvbT4gd3JpdGVzOg0KICAgIA0K
ICAgID4gSSBzdXNwZWN0IHdhcm1pbmcgdGhlIGZpbGVzeXN0ZW0gY2FjaGluZyBpcyBpbiBwbGF5
Lg0KICAgID4gQnV0IHNvIGlzIHRoZSBmYWN0IHRoYXQgd2FsayBldmVyeSB0cmVlIHRvIGZpbmQg
dW50cmFja2VkIGZpbGVzIGFzIHdlbGwuIA0KICAgIA0KICAgIEVuYWJsZSB0aGUgdW50cmFja2Vk
IGNhY2hlIGFuZCAidXBkYXRlLWluZGV4IC0tcmVmcmVzaCIsIGJlZm9yZQ0KICAgIGZyZWV6aW5n
IHRoZSByZXBvc2l0b3J5ICsgd29ya2luZyB0cmVlIHN0YXRlIGluIHRoZSBkaXNraW1hZ2U/DQog
ICAgDQoNCg==
