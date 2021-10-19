Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A908DC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A616115B
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhJSSnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:43:04 -0400
Received: from mx0b-002f7301.pphosted.com ([148.163.143.211]:49464 "EHLO
        mx0b-002f7301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhJSSnD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 14:43:03 -0400
X-Greylist: delayed 4662 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 14:43:03 EDT
Received: from pps.filterd (m0143752.ppops.net [127.0.0.1])
        by mx0b-002f7301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 19JGeMXQ011682
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 13:23:08 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-002f7301.pphosted.com (PPS) with ESMTPS id 3bsvt5rq3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 13:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs9tiKunF1ek+2+z5fELnbEBue5YaAUTyguDz5E61VOlXscd/b4udE0QLnLx2KwoJIfPrAOkyWV9dGXq7tWp8mDzy3oBclS6WL5ZVAFu2xrifORAPPQO1juAeFpQ6ZZQnBstnk5ZpXd1UhLUeHf5nBFO7V9BgU11JYtwW0I1vl8cXWdcHhANnJE5zew8P0FdAaRh9/MG/nlbQrlXBpbHq4Eo5nYsDd9pfBDWTFxzRIM4hPr6pNoRZwwG/VGERLULQwl/JLwHYnI6LWu9ZtlDgOoFn8HlrCmsKXwa/sc6GvtzYIWO71zyhdI0Yf7drpYufr02hWjk6q2nk7r0sXL6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqnUCL+PNcC7kTI96+BR1tBQMNB3o8o/9vlBmrJflbA=;
 b=n6IB65qpwd8sMgRPGQBCaxDL/wcVU+Cr7igwk6me60VAdCDqfKe7ExjclvBY/cuUt4qKzhaOBTZ1vqNzK5vqwDApGZaU65VMuc2awd60YEfGrCjTtzwGhMBWSmy4rDx7wZ6T1zb+D3uFVR3hH1HNhK1SO94lQjl0aepBb6fgs/24L1M7shtHMoy8NhiyOw9xsNre1MUC1WYGwrMVc+J/c2nzRSiLghucx5vTKPq0nAc4QxdUmYBA/10MMSS5bnx0HpRdsrQetg/xsvQ3GTqJHvWFCAQnPnqwTUduFsUF3P0mPNQ46IWkAwNogd0nII8u4WYLOz30ND68itXSqcc9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calvin.edu; dmarc=pass action=none header.from=calvin.edu;
 dkim=pass header.d=calvin.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=calvincollege.onmicrosoft.com; s=selector2-calvincollege-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqnUCL+PNcC7kTI96+BR1tBQMNB3o8o/9vlBmrJflbA=;
 b=RYXRVyTC2PZKI/Aw/yyPi8Rbzri/IRsFp9q7NI+QA6tuPt7L52rv8LEi5Vy1VWnpntv5e1mQ1ZfvxOXuAk/Hd4W3f1z7Vv1J7S9Ip4hX5hBGE2f7+J6d4UuPyfWwSfikRNsXZaN2w0JH3V/XXDj38FFbfityAnk3KhtKMH0J/AE=
Received: from CH2PR06MB6504.namprd06.prod.outlook.com (2603:10b6:610:86::24)
 by CH2PR06MB6613.namprd06.prod.outlook.com (2603:10b6:610:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 17:23:06 +0000
Received: from CH2PR06MB6504.namprd06.prod.outlook.com
 ([fe80::edf7:9a77:a83a:9c50]) by CH2PR06MB6504.namprd06.prod.outlook.com
 ([fe80::edf7:9a77:a83a:9c50%8]) with mapi id 15.20.4628.015; Tue, 19 Oct 2021
 17:23:06 +0000
From:   Kenneth Arnold <ka37@calvin.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "Not possible to fast-forward" when pull.ff=only and new commits on
 remote
Thread-Topic: "Not possible to fast-forward" when pull.ff=only and new commits
 on remote
Thread-Index: AQHXxQv7sspeiaErXk63K0HtHp5OUQ==
Date:   Tue, 19 Oct 2021 17:23:06 +0000
Message-ID: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.53.21091200
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=calvin.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3209ee49-6059-44f2-346b-08d993251d7a
x-ms-traffictypediagnostic: CH2PR06MB6613:
x-microsoft-antispam-prvs: <CH2PR06MB66131B54322DD5C79D02D9B4B1BD9@CH2PR06MB6613.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLMyIcbZMJYSloBAFLPzi++0+RC8wLSds6N6rCeScNe4ZVu/wU0zmGoVOOTvU+ux2h9ewzhpsTgWKkhq9Fl5x33+CSLZD4BJVcqM2YUul/baECZNgURY/YdmNSw/lFtibxoVRXAmgXU+kUWUOsabZbkFbSUPQxOKpv+b7Yjp4JqJgpdSS8a1QwCd8TY59wevdoV/+PEvgW+cuE7QIqOp4032MNODfOvGVKqf7Ujb5xzfc+wTdZBZBqzZ7tr5piV6Q1sUaOLViXau+bd8TvrG5I4cJnSSHrnD1Opl02YM64qda5JjM4kVaKSU9bI1RZvXmOQBKG3mlvTFnsiK5b7+1sk9JpRB21M4ND8/opWI9+n1py05AL9KWa90BJIfIAZSOyFQOj2X2E+q5mT8rpqxGzbBBX6lkmzAVN/Nf5MSgshmC4m+K3ASKT/bw9ZXuWN/F+QUv4hHnfI6n3kRQAieV0l3YjEjHQ7pJisGyU36dt5+NT7gFnJ6D8gKX02zHRE9SqUiO0uAACES2SuEnzR2Q30vcSmNqH1SIoLBP7lbFZlU0qneGFlQGkqyILtpDQimshwStfCy16ZNPh0JLO8tORAmLjxUjpZWCZAQlhZYiHGoXzyCnhX5tw6JomCFH8kJ0n0uT/ViZk1EAFc1LsnIVTZsBk4ZnDLnf2OxKFGE+5EY/rycPo65YGJ3Mc67s6ccZmW5cNt/KZDChRbcl4/Q+/9PFdWp816+IiUk5lD9mxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR06MB6504.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(786003)(316002)(4744005)(2906002)(8676002)(64756008)(6916009)(8936002)(66556008)(66476007)(66446008)(66946007)(26005)(76116006)(186003)(508600001)(5660300002)(52536014)(33656002)(9686003)(6506007)(55016002)(7696005)(71200400001)(75432002)(83380400001)(38070700005)(38100700002)(122000001)(88722004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjFJSkhPWXo1NXhLWU5zaExNbnZLUTZmd05MdHl3Q3NyL2dmMUJaL1g3U3p0?=
 =?utf-8?B?d2tEOUhxK283am5aSGRlVHJmK1RRUjF3cGQvdjJHTmJxa1dxNWNDWmlJSVJs?=
 =?utf-8?B?c0pLVWFoWjJxT0lMajV1K2F1S0x5bnFIQ1BGRlJIMWJjMGtRR0FpNXdVUWtV?=
 =?utf-8?B?eWlDa3lVdDgrcFd5b2t6Y0t6eVQwNUVib0RCU0dFNU5hd25aUWZ1ekNoNmJx?=
 =?utf-8?B?akhGdkZ6WTRjZGwwQkFSUFUzS1VkTDJlVGpQVkd5K0FCdnZrajZieldvU2Nw?=
 =?utf-8?B?YkpZdDhxLzFPTWMzYm9KT0FNNGlmYk5wNEdrNk9nUC9EaElnOW1xYjNtdHp1?=
 =?utf-8?B?amdJTGdJL1JLZUFKUUlhRmQ4S2ZrckpSQkxyMGRXOTVucjJhWitSOXB4M2Ry?=
 =?utf-8?B?bUtDcDZ3MmlxWXJpVTRhWFNwcS9INzUwdnQxL0YzSGhLTjRmdFBFUERrUjZr?=
 =?utf-8?B?YmFPczk4a0VvWG9IZTlUVW1HSUJHaDVIdjk3eHdlV3MzcWRQV2V0Ni9YaUp3?=
 =?utf-8?B?T0FCMnVpSHhTMUZIbWtTQmZtZFR2NXJUZFd0eWpRa3krcGEvVVRuMFlpWVBL?=
 =?utf-8?B?NzRESXBWNG5BcWF5Njd6NytiVTdHbFBWeVIzTGJmcU1NcEJTVjNnRjdlVGR1?=
 =?utf-8?B?T0ZVTHRTNFpPUnFLR3BXRVRqZjNYOVgxYlkycW9rNExhRkROMG8wSld6VHkx?=
 =?utf-8?B?bkg2TDl1Tkp0VFNrc0pIVkpGeGNiRnRQRkVrQk1PTCtZRHpFcTNHMVZQMWhk?=
 =?utf-8?B?QWRDOTlvMCtLOEtJaitZeHNHdGhCUEpRakFxMWFDVW0wTlZ6b3lMQldyclEz?=
 =?utf-8?B?bUdoSDVuMGd6TjVVU3UzS3NhbUVPZ0JtTlF0V2NGcWNtNXMvMWdocFlKcG93?=
 =?utf-8?B?amFwbURnengvanBlUllZVmcvcWtpZHhFOThkUWl0RHlkYmU2SnpxcnhjNjV6?=
 =?utf-8?B?UnphQUFYanV6YlpiRG5QS1dMcVpNU1BnNXpWTnhTMmNKVXFKTmpROThwRWl6?=
 =?utf-8?B?RWhLSEVwRDdBYVFNMlNXbnZPd3NvTy9wNUFSMU5zU1lReEdYT284RVhYa2h4?=
 =?utf-8?B?ZjB5SHVySm9YWkw1ekltdW9lWnpLSWR2aUcvQWdoUFl2YzlkWGo0cjI1RTVW?=
 =?utf-8?B?ZVlHaitkZHpaeXFtVloveEUwbmx6RVp3djF3ZVR5SlVOZEFzZmdFTldZQUdu?=
 =?utf-8?B?TGdzRDNCTnMwNHJKN1A5OVc0eVBJajR5M1Bzc3l0bVFtU1c4Y05sWUJnbXd5?=
 =?utf-8?B?SmliOEhnTjhZMlpnczlwdTlPL3pZVHhLQ0tLSkwzU0k2QlNDWTJreWF0V0lu?=
 =?utf-8?B?N2lOdmVyaUdialYwd3lvR3J1L21VODNWNkdzOWZDQXAyeWFSTjFjc1NjT2FC?=
 =?utf-8?B?SHJqL0M4WXdtV2IzbmxhbWNScGwxc2NsaE42dnRJYThqSitVdjUyRHNpT2tt?=
 =?utf-8?B?KzhkQm5RV2xvVlpkZUhiQzR6ZnJyNWduKzdhMHoyWFM2OXFDaGVJeWhSU3h1?=
 =?utf-8?B?clUyK1VUQmI2b3hvR1Nieis4a0EzYlF5VEg5aEdsQ2FObjBBdU1kOEY1TXJx?=
 =?utf-8?B?cXB4Mmo4U0twWTM3SHBoNEQySXBzdGswS0NjT3ArWjBZV0J0VGtPLzJwN3RF?=
 =?utf-8?B?TXpFZGpvRXhtM2l0ckJwUTF0QUNGbk1FSTgyY3VNemRTVzY1bWVVeDJxV3pJ?=
 =?utf-8?B?ejUwS21MUTlRcXd0cGJnUnBqeUxrWGhjcG1EWVp1YTVIRmxISHhlZWJwT1Uv?=
 =?utf-8?Q?qcJaKwE+2JWtScfBGoQCOWpeegYUXgasNaySC7Y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6601170FB1BFA5439FB34C4E6A933B96@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calvin.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR06MB6504.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3209ee49-6059-44f2-346b-08d993251d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 17:23:06.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 756349b9-0610-4b01-917b-2a4ac10df947
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdwzMlOGNzKR1aFeA9tjPcjCu00P8+OdWyCcwmaY1PoYN1tlHrMchB6E2ZcjLNyp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR06MB6613
X-Proofpoint-GUID: W2b11GPK8P4feI9szijuicv4OB-IxAYq
X-Proofpoint-ORIG-GUID: W2b11GPK8P4feI9szijuicv4OB-IxAYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190102
X-Proofpoint-Spam-Disposition: Inbox
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QWZ0ZXIgdXBncmFkZSB0byAyLjMzLjEsIHRoZSBiZWhhdmlvciBvZiBgcHVsbC5mZj1vbmx5YCBo
YXMgY2hhbmdlZCBpbiBhIHdheSB0aGF0IGJyZWFrcyBzb21lIHdvcmtmbG93cywgbm90YWJseSB0
aGUgZGVmYXVsdCB1c2VkIGluIFZTQ29kZS4NCg0KRXhhbXBsZSAoc3BlY2lmaWMgcmVwbyBkb2Vz
bid0IG1hdHRlcikNCg0KYGBgDQokIGdpdCBjbG9uZSBnaXRAZ2l0aHViLmNvbTprY2Fybm9sZC91
dGlsLmdpdA0KLi4uDQokIGNkIHV0aWwNCiQgZWNobyAiIiA+IHRlc3QNCiQgZ2l0IGFkZCB0ZXN0
DQokIGdpdCBjb21taXQgLW0gIlRlc3QiDQokIGdpdCAtYyBwdWxsLmZmPW9ubHkgcHVsbA0KZmF0
YWw6IE5vdCBwb3NzaWJsZSB0byBmYXN0LWZvcndhcmQsIGFib3J0aW5nLg0KJCBnaXQgc3RhdHVz
DQpPbiBicmFuY2ggbWFzdGVyDQpZb3VyIGJyYW5jaCBpcyBhaGVhZCBvZiAnb3JpZ2luL21hc3Rl
cicgYnkgMSBjb21taXQuDQogICh1c2UgImdpdCBwdXNoIiB0byBwdWJsaXNoIHlvdXIgbG9jYWwg
Y29tbWl0cykNCmBgYA0KDQpQcmV2aW91c2x5IHRoaXMgcHVsbCBzdWNjZWVkZWQgd2l0aG91dCBl
cnJvciwgd2hpY2ggd2FzIGFzIGV4cGVjdGVkIGJlY2F1c2Ugbm8gbWVyZ2Ugd2FzIG5lY2Vzc2Fy
eS4gDQoNClZTIENvZGUgdXNlcnMgaGF2ZSByZXBvcnRlZCB0aGlzIHByb2JsZW0gYmVjYXVzZSB0
aGF0IGVkaXRvciBoYXMgYSAic3luYyIgb3B0aW9uIHRoYXQgc2VlbXMgdG8gcnVuIHNvbWV0aGlu
ZyBsaWtlIGBnaXQgcHVsbCAmJiBnaXQgcHVzaGAuDQoNCg0K
