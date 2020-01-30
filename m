Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13ECC35240
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E3C214AF
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgA3WAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:00:18 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:38812 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgA3WAS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Jan 2020 17:00:18 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ULmcRZ016734;
        Thu, 30 Jan 2020 22:00:09 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2xv2cd2hch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jan 2020 22:00:09 +0000
Received: from G9W8453.americas.hpqcorp.net (g9w8453.houston.hp.com [16.216.160.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 6082AB4;
        Thu, 30 Jan 2020 22:00:08 +0000 (UTC)
Received: from G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) by
 G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 30 Jan 2020 21:59:33 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W8455.americas.hpqcorp.net (16.216.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 30 Jan 2020 21:59:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA0buwT1Cg9cdtYXJuybvEHGhDJD7ndhjjhDaMqzjyZNnQevCFRV42guEDlyFFIbapxWWsQkJAaZyqo9Wh2y7t4NWNIv2MOP05P2nVa510GxfmaMcMrt5nqPwSAFU+3tYnFCpVHZzYDlh5JSBfUqLfX98PkTlIgF62bIOTEmJAX0StJFOPOQRyQfpRpmhjN376uTHY6AG4OrQjdtR6PDe0u/Cl3MhvZ/1DC5YhL1IM+Cxyp8YjcFuCRWYzZAOhHQUlwFcuYmRVuTPRq+Nlz2bi6xSMb14QVOiZaX7LJ/vwESmhTfBqTqUPZRZCLtMpx0+Ih+HyPO1/euSTgsfIf9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBzklz/tuxR7eSpy0Z4yTAtYjn8Lr+fxtyLuM99FwWM=;
 b=OT4qEiz3U48s7MfWTVsZMR3HNIC++8wNF4H0qCHrc/UsviPR100xCxyKc+Ua0YqrDLM8rgwLkXwWC9mC/A4QvZ4uchgu+vqOOXHJvdBKRRuqbsoul3f/LEukOsH2106CuDzFucNxyD8FjhK/zRSpIl6SG9PKgAjQjKD7Q8URbBRNLGinbx3guTsVA8H2d8Fd2OBLr9Ivro3nAUrTcx7UEEhtcFqu1bDQYwnmctEygO4rPw/XaANAYnvaFcJ2YUH6lI8FkWEyoPg0JbHtRNJOHq/Uazds5YnA2WLaoyHIkY6ZrZNMDCbgYPcGwcRT7Wpb8ifNJgGihOp7YtKuOVTWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.136) by
 TU4SPR00MB08.NAMPRD84.PROD.OUTLOOK.COM (10.169.51.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Thu, 30 Jan 2020 21:59:31 +0000
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a444:5668:3197:45b3]) by TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a444:5668:3197:45b3%3]) with mapi id 15.20.2686.028; Thu, 30 Jan 2020
 21:59:31 +0000
From:   "Crabtree, Andrew" <andrew.crabtree@hpe.com>
To:     Jeff King <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Inconsistent results from git rev-parse --show-toplevel
Thread-Topic: Inconsistent results from git rev-parse --show-toplevel
Thread-Index: AdXS4BNVVmw1+EsZS66tVrOnfS2Q2QAEK9U0ACoRb5AACAO3gAAFI1pAAOKhM4AAF/kv8A==
Date:   Thu, 30 Jan 2020 21:59:31 +0000
Message-ID: <TU4PR8401MB111777B793EA9C3D5336CE26F9040@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <xmqqftg4zkvo.fsf@gitster-ct.c.googlers.com>
 <TU4PR8401MB1117B81EB9240905AA36B1E9F9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <20200125195319.GA5519@coredump.intra.peff.net>
 <TU4PR8401MB1117E8EEB853728B0392D83CF9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <20200130102933.GE840531@coredump.intra.peff.net>
In-Reply-To: <20200130102933.GE840531@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4aa98c41-ebb0-4600-41fe-08d7a5cfaf91
x-ms-traffictypediagnostic: TU4SPR00MB08:
x-microsoft-antispam-prvs: <TU4SPR00MB084590A8ECA9F930537DA8F9040@TU4SPR00MB08.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(189003)(478600001)(4326008)(54906003)(5660300002)(316002)(6916009)(86362001)(26005)(71200400001)(7696005)(53546011)(6506007)(186003)(76116006)(8936002)(81166006)(81156014)(8676002)(33656002)(66946007)(2906002)(66476007)(66556008)(52536014)(9686003)(55016002)(66446008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4SPR00MB08;H:TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWiDz43ZZLt2WAD9iWQAlhm3JPOfGcoLuTdnENwHWRD/+v7eBha5766F0ZY56FglawfABEJ25i4tjAbkSFnbI/gC5G86FbTFuj5/dBdYXnRuGysfajJML5RCcEHDXWu0N1lZExG1B97qZmC2NoDAHP9I6zignv1Y6Z6sNLB2vNcuabPloTSzY+P9IXR0WDKHZpGM9h36Vv0L8ckXftAZK1CcO1Qs4yITdVNxQyHHJLIDBQaQIz7lcAW+faXwP0uc+2UOLcrWklUuk+x4kUJ0EUSrtRzou+brUx+JAqLD+0ohcH+6kl2IfqROXRFM6deWZDS63CKIchFVwfkeFukc5ufXRNJhrfVXTtPl0X4uro+aLCtTk0X1wcrWhy4U32ArPvKbJKNu6UJLbuq/f0fZsGnXoweqiFiI9lt0HoytSzycvI+pKy47vKM1zs/orsur
x-ms-exchange-antispam-messagedata: U8vNTKH+sEnu2VLIY9pOSFg6zMPRNl9EU8EwVRKSYOZa6kYdejIacTWdVz1H1QC71gOVCiPZO+0OJW9o8avhJuKgJdv6G63Sb2UdfFTC6Xz3prSGsrvAW1HilsQ2loeHEwE/zbEKi9ORa9VScFj2rA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa98c41-ebb0-4600-41fe-08d7a5cfaf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 21:59:31.7120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tP4H3ElSx42gD6Mp1u1uDsuzYMglNY4TSwE1XCLWAU1pSf5O8XTrUXGslMILSkwyhWz14trqmPol2zMmC6fkjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4SPR00MB08
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_07:2020-01-30,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RnJvbTogSmVmZiBLaW5nIFttYWlsdG86cGVmZkBwZWZmLm5ldF0gDQpTZW50OiBUaHVyc2RheSwg
SmFudWFyeSAzMCwgMjAyMCAyOjMwIEFNDQpUbzogQ3JhYnRyZWUsIEFuZHJldyA8YW5kcmV3LmNy
YWJ0cmVlQGhwZS5jb20+DQpDYzogSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPjsg
Z2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IEluY29uc2lzdGVudCByZXN1bHRzIGZy
b20gZ2l0IHJldi1wYXJzZSAtLXNob3ctdG9wbGV2ZWwNCj4gPiBCdXQgdGhlIGJpZ2dlciB0aGlu
ZywgSSB0aGluaywgaXM6IHdobyBpcyBzZXR0aW5nIEdJVF9ESVIgYnV0IG5vdCBzZXR0aW5nIEdJ
VF9XT1JLX1RSRUUgdG8gbWF0Y2g/IEJlY2F1c2UgSU1ITyB0aGF0J3MgdGhlIHNpdHVhdGlvbiB0
aGF0IGlzIGNhdXNpbmcgdGhlIGNvbmZ1c2lvbi4NCg0KPiBidXQgaXQgZmFpbHMgYSB0ZXN0IGlu
IHQ1NjAxIGFyb3VuZCBnaXQtY2xvbmUuIA0KDQpUaGFua3MgamVmZi4gIEl0IGxvb2tzIGxpa2Ug
dGhpcyBtaWdodCBoYXZlIGJlZW4gdHJpZWQgcHJldmlvdXNseSBhbmQgYWJhbmRvbmVkPyAgSSdt
IHByZXR0eSBmYXIgb3V0IG9mIG15IGxlYWd1ZSBoZXJlIGluIHRlcm1zIG9mIGhvdyB0aGluZ3Mg
YXJlIHN1cHBvc2VkIHRvIG9wZXJhdGUgYW5kIGFueSBoaXN0b3J5IGFyb3VuZCB0aGUgcHJldmlv
dXMgYXR0ZW1wdHMgYXQgbWFraW5nIGl0IHdvcmsuDQoNCi1BIA0KDQoNCmNvbW1pdCBkOTUxMzhl
Njk1ZDk5ZDMyZGNhZDUyOGEyYTc5NzRmNDM0YzUxZTc5DQpBdXRob3I6IE5ndXnhu4VuIFRow6Fp
IE5n4buNYyBEdXkgPHBjbG91ZHNAZ21haWwuY29tPg0KRGF0ZTogICBGcmkgSnVuIDI2IDE3OjM3
OjM1IDIwMTUgKzA3MDANCg0Kc2V0dXA6IHNldCBlbnYgJEdJVF9XT1JLX1RSRUUgd2hlbiB3b3Jr
IHRyZWUgaXMgc2V0LCBsaWtlICRHSVRfRElSDQoNCldoaWNoIHdhcyBzdWJzZXF1ZW50bHkgcmV2
ZXJ0ZWQgDQoNCmNvbW1pdCA4NmQyNmYyNDBmY2I0ZjI4NzI1OGFkNDU5ZWZjMmI1ZTMwZTYwY2Zk
DQpBdXRob3I6IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgPHBjbG91ZHNAZ21haWwuY29tPg0K
RGF0ZTogICBTdW4gRGVjIDIwIDE0OjUwOjE4IDIwMTUgKzA3MDANCg0KICAgIHNldHVwLmM6IHJl
LWZpeCBkOTUxMzhlIChzZXR1cDogc2V0IGVudiAkR0lUX1dPUktfVFJFRSB3aGVuIC4uDQogICAg
DQogICAgQ29tbWl0IGQ5NTEzOGUgWzFdIGF0dGVtcHRlZCB0byBmaXggYSAuZ2l0IGZpbGUgcHJv
YmxlbSBieQ0KICAgIHNldHRpbmcgR0lUX1dPUktfVFJFRSB3aGVuZXZlciBHSVRfRElSIGlzIHNl
dC4gSXQgc291bmRlZCBoYXJtbGVzcw0KICAgIGJlY2F1c2Ugd2UgaGFuZGxlIEdJVF9ESVIgYW5k
IEdJVF9XT1JLX1RSRUUgc2lkZSBieSBzaWRlIGZvciBtb3N0DQogICAgY29tbWFuZHMsIHdpdGgg
dHdvIGV4Y2VwdGlvbnM6IGdpdC1pbml0IGFuZCBnaXQtY2xvbmUuDQogICAgDQogICAgImdpdCBj
bG9uZSIgaXMgbm90IGhhcHB5IHdpdGggZDk1MTM4ZS4NCg==
