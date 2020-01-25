Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D1C2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 22:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7876F20716
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 22:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAYWW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 17:22:58 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:47930 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727163AbgAYWW6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 17:22:58 -0500
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00PMFTpp007631;
        Sat, 25 Jan 2020 22:22:49 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2xreysbug9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 22:22:48 +0000
Received: from G9W8456.americas.hpqcorp.net (g9w8456.houston.hp.com [16.216.161.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 042344F;
        Sat, 25 Jan 2020 22:22:47 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Sat, 25 Jan 2020 22:22:48 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Sat, 25 Jan 2020 22:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAk8uAohUqQsH29rCqCMjXYhykZXvWYGxqqIuD6kfsT3fJnpuBDDDbojUKJ2aYufSr4jo+Efxnm6bcbY/Xo4R72+KiSjMJacf8cVxveRQZAqBjFuElfhISRwnTVMdJZ1gIi0DKknF09peonHopr1mABkk+yHaHQg+WgtSlIJQmjFTJTvV4ds/YSGcVgmbdwMBD7fnqO+14rU0nUMqVpCmiRdccIQZE9aAN5rvizx0gBB7lB6WEayL8SC0ngzByxQbZCx+AeB37DsTgoCCbsgq8PThP/dlErt+Mw6nYwI6zNGrv4+uwltgRNlYmhR5sHhPhGotz5TdFdPhYejoiyopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuVitRpnBUFQ0QiWiMdMi+FATwhLtyMky+E6zb/N0SI=;
 b=X+aNfxFtyGfvQdk0qJCOvvvGrLbNdQJGPB+g7HAjaXtb57OU7+6nkhpZqEwD2IzhDytNirqJumQI6Rl6gA8LrEgqV6tObsHm9xrLXVFwpNKTSzPUxw8tWyjF1/nrYKQZTAoOz+IAXBaoGPLbH0dwIpkpYGWEBHAmSNPcetm36O6M4FoOPGckcXC97rx26F0g1h4frl4PfAWaRXU40cNe7ixByJCHAmG7cXef17w2AVncvTnRkUwSKzCGQQa17tvY6J09ySjyRwrBFTvPNPadIWCP//IT6pfBRgsCpzcNOCPQYuEAVheos0/JyluAFH32FXNCF5gZ5nDr3sZ7y304tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.136) by
 TU4PR8401MB0735.NAMPRD84.PROD.OUTLOOK.COM (10.169.46.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Sat, 25 Jan 2020 22:22:45 +0000
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::acc0:c9be:d2fd:2dce]) by TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::acc0:c9be:d2fd:2dce%8]) with mapi id 15.20.2665.017; Sat, 25 Jan 2020
 22:22:45 +0000
From:   "Crabtree, Andrew" <andrew.crabtree@hpe.com>
To:     Jeff King <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Inconsistent results from git rev-parse --show-toplevel
Thread-Topic: Inconsistent results from git rev-parse --show-toplevel
Thread-Index: AdXS4BNVVmw1+EsZS66tVrOnfS2Q2QAEK9U0ACoRb5AACAO3gAAFI1pA
Date:   Sat, 25 Jan 2020 22:22:45 +0000
Message-ID: <TU4PR8401MB1117E8EEB853728B0392D83CF9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <xmqqftg4zkvo.fsf@gitster-ct.c.googlers.com>
 <TU4PR8401MB1117B81EB9240905AA36B1E9F9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <20200125195319.GA5519@coredump.intra.peff.net>
In-Reply-To: <20200125195319.GA5519@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [104.220.13.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37f117ab-23ea-4a68-e201-08d7a1e51a67
x-ms-traffictypediagnostic: TU4PR8401MB0735:
x-microsoft-antispam-prvs: <TU4PR8401MB0735AEC48E562E4C88638B4CF9090@TU4PR8401MB0735.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(39860400002)(396003)(199004)(189003)(52536014)(8936002)(55016002)(5660300002)(66556008)(66476007)(9686003)(64756008)(66446008)(66946007)(76116006)(81166006)(55236004)(8676002)(81156014)(71200400001)(6506007)(26005)(186003)(86362001)(33656002)(4744005)(4326008)(54906003)(316002)(7696005)(2906002)(478600001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0735;H:TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZXaQHTmxNe90ABMqABQk7E8QVlWxfhxRDIJYdTUa63J4iVlTjqv+U8ftxaDfhWrqjuEA5j5PnkJTOl5m4Vagsi0WzaMfYVSZnSgwawiGnQc2t5xhfGxlWAFK6a8gajysm1i9JUo6fRPCcCylCVJ/8wcF4n1sYT1Af8AATay4wKQKlBU/HOLlm+PCgABA9hrd5sFBv8TVUlfSBdFzqlVNEdy/5YI5wMfmX+hsFu2GaTUDShiAlehOTT/zl4ZfFSNDt+TnA+1GLwXF44/Xd3kbwSYYA+bgusaKtUZacRh01OnleIsSh6W8KQYOQBW7DTeDpKYobN8DiOWhh6PdEJTxqMrXoPM7i69tw1O6iP/R8lWzIKwdBFbMp2p4I5XVTX5Coe3+4eMwjtOlAgD6Zc2h/crf069Kf77WECB0CG7qkGFT4jCVtriqAgPTey9jBMP
x-ms-exchange-antispam-messagedata: /MXYD48VLxE2yFajSupVkArLfgJwrDrdP5CQ6uMj0uimRZ0a41LXm4vNU8y24VZ/tyl3AUPkZHAiCbw/PTPhEpdQD+JmAXARlJCkKgP+IsLQOK62jU9oTGZe9kf7tHVGrlD2JmjjBJin+ga70VhtMQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f117ab-23ea-4a68-e201-08d7a1e51a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 22:22:45.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5y1nk+iuCp0bDCQ+xetylYOdVvBeEGEvo0EmnTle1KZnPIUEhLzY0/7XZNySthJqSkRZNsVikBhiAlVORTOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0735
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-25_09:2020-01-24,2020-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001250189
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBCdXQgdGhlIGJpZ2dlciB0aGluZywgSSB0aGluaywgaXM6IHdobyBpcyBzZXR0aW5nIEdJVF9E
SVIgYnV0IG5vdCBzZXR0aW5nIEdJVF9XT1JLX1RSRUUgdG8gbWF0Y2g/IEJlY2F1c2UgSU1ITyB0
aGF0J3MgdGhlIHNpdHVhdGlvbiB0aGF0IGlzIGNhdXNpbmcgdGhlIGNvbmZ1c2lvbi4NClByZS1j
b21taXQgaG9vayB3aGVuIHdvcmt0cmVlcyBhcmUgdXNlZD8gDQoNCnByZS1jb21taXQNCiMhL2Jp
bi9iYXNoDQplbnYgfCBncmVwIEdJVA0KDQovdG1wL3ByZV9jb21taXRfdGVzdF93b3JrdHJlZSAg
KG5ld19icmFuY2gpJCBnaXQgYWRkIGZyb2INCi90bXAvcHJlX2NvbW1pdF90ZXN0X3dvcmt0cmVl
ICAobmV3X2JyYW5jaCkkIGdpdCBjb21taXQgLW0gImZyb2IiDQpHSVRfRElSPS90bXAvcHJlX2Nv
bW1pdF90ZXN0Ly5naXQvd29ya3RyZWVzL3ByZV9jb21taXRfdGVzdF93b3JrdHJlZQ0KR0lUX0VE
SVRPUj06DQpHSVRfSU5ERVhfRklMRT0vdG1wL3ByZV9jb21taXRfdGVzdC8uZ2l0L3dvcmt0cmVl
cy9wcmVfY29tbWl0X3Rlc3Rfd29ya3RyZWUvaW5kZXgNCkdJVF9QUkVGSVg9DQpHSVRfQVVUSE9S
X0RBVEU9QDE1Nzk5OTA3ODkgLTA4MDANCkdJVF9BVVRIT1JfTkFNRT1BbmRyZXcgQ3JhYnRyZWUN
CkdJVF9FWEVDX1BBVEg9L3Vzci9sb2NhbC9saWJleGVjL2dpdC1jb3JlDQpHSVRfQVVUSE9SX0VN
QUlMPWFuZHJldy5jcmFidHJlZUBocGUuY29tDQpbbmV3X2JyYW5jaCA3YjFiNzQ3XSBmcm9iDQog
MSBmaWxlIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZnJvYg0K
