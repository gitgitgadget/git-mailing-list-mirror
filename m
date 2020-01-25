Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E5DC2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 19:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323AA20716
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 19:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgAYTb0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Jan 2020 14:31:26 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:53414 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgAYTbZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 14:31:25 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00PJP2lq022838;
        Sat, 25 Jan 2020 19:31:23 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2xrb2648j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 19:31:22 +0000
Received: from G9W9209.americas.hpqcorp.net (g9w9209.houston.hpecorp.net [16.220.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id E2B0563;
        Sat, 25 Jan 2020 19:31:21 +0000 (UTC)
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 25 Jan 2020 19:31:21 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.241.52.10) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Sat, 25 Jan 2020 19:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKrahCT124Bc0fos7ZWxSjdxm1abKdKrn9aWDuAcrKny0Mp13u93Dou89rsoI2Lk/tCB//1jbJEJFNXRJQ7bDorleVPgIWr+c8Cci+18XKBfKHimRpTJM40QiXkJX8JLwqaiHJ2jXpBTEckC4vCKVNpwxdWAtNzPQFhUkMkOtc/ymaFR64572miHQxjuENyh8PwrPqR08XiRasPKfGSZGOHCsAC/gn81CDbkfJ+x5eJeXHmHZJ34wsZrUb1aEpi15iCx0n06dXP/PgG7PPdKwewbZrFXcYDFDQPNmVf79pEA1/t4hAh/9UmGEuiphfFO+oJ46skf7w+OAdr8+lCJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9L99O6dkjyXNh0FKQGtAjWsYN5qq2KE4zVDcNLS6bc=;
 b=PiZqNOtQG1hzPhHnr0E5TU44fua1ThLLtm8+G2eX98Fit96ua39LS5BZrnJ5HSd3rGWYk9OUobhXE2ffjGbFNJlXKwRZhVI1Fj0GT5kBEcuZV37Khd2pmJiEa7Y9/5i6JOTCdIKgAiRv76/1zvgJZzOAC+w7mBKKDuQj/V6b6yAefy5prueH8pTYt7ZoYGYgTzy+dI3kIyGsRuccGnt3uD+ZA9YZkVUQ5wRZeTQm1Lt56/30SZdq2O+ksJBYqKoi+xOW8g4FDi3kTFjW0gVJrj+4+uhxmjis4UY//G50K6vZP/gfFn0C/aNrckWG86uH1Zu5tX+Cx1/nqhdj7QXiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.136) by
 TU4PR8401MB0717.NAMPRD84.PROD.OUTLOOK.COM (10.169.45.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Sat, 25 Jan 2020 19:31:20 +0000
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::acc0:c9be:d2fd:2dce]) by TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::acc0:c9be:d2fd:2dce%8]) with mapi id 15.20.2665.017; Sat, 25 Jan 2020
 19:31:20 +0000
From:   "Crabtree, Andrew" <andrew.crabtree@hpe.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Inconsistent results from git rev-parse --show-toplevel
Thread-Topic: Inconsistent results from git rev-parse --show-toplevel
Thread-Index: AdXS4BNVVmw1+EsZS66tVrOnfS2Q2QAEK9U0ACoRb5A=
Date:   Sat, 25 Jan 2020 19:31:20 +0000
Message-ID: <TU4PR8401MB1117B81EB9240905AA36B1E9F9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <xmqqftg4zkvo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftg4zkvo.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [104.220.13.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0067723c-56ab-41bd-ec0e-08d7a1cd27af
x-ms-traffictypediagnostic: TU4PR8401MB0717:
x-microsoft-antispam-prvs: <TU4PR8401MB0717B345D92230F692CF8BA3F9090@TU4PR8401MB0717.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(4326008)(6916009)(64756008)(81156014)(66556008)(66946007)(52536014)(66476007)(81166006)(8936002)(66446008)(4744005)(76116006)(9686003)(55236004)(55016002)(186003)(6506007)(33656002)(7696005)(2906002)(8676002)(5660300002)(86362001)(26005)(316002)(71200400001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0717;H:TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1leHOSFOHCAxuY266ufKnkW1iZs+2+uQRdlaqCU4NdlV7dohiyvD1TlWSBaFW1HESezdmwFieOwQit/eGLx4E9uxkGearpzovUU69fN4T76OuiI1hXg7bcwVnTf7uox8qN/f61xiCdI/otF1Lz15jS1C/kpOyv4tpK/3WqRu6UdQFF24aRMtTq7FFyoHh0rLjtWErvxzNqektQuYv0P6t+7MRxNe4XSzoeitV5luC8AeStPKWu8MgHzPo9nqSVjV0PPuwDdkg+dLMBPWD+qHzkULrtWxBlK2XUVfRCrKNj62mdWdow85kRm0ARWUN7nwQs9hLTUvNw5z/8cnqNAgPqizT9eMza8fIGSNBQPHOri57XOE5kLAmZNNrlZtwRNO1Rn+hOPVzKcGW9nTgMTJB1vqIuljS5A7fXFDEBUtMCfdoRYGW4+q3Y1zJhJJypxJ
x-ms-exchange-antispam-messagedata: 7SmXc9E5fdEMGqIMpAJhdYgejlbNaDfY7Fz7PLUrqndfWwe0OrA2kG60OFFw/co6Y7O2pdQ6uzcEa9Rd+AMOUV0XshilhVyP4meprjIFUmUjPda2nlzZ2qzA8cts3gBhpRJ8iHacL/EYHbuk3dOljQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-Network-Message-Id: 0067723c-56ab-41bd-ec0e-08d7a1cd27af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 19:31:20.1033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIQraDkrid1zKg05Qyd1T2VPDmppnBFdezrqOVnYdjKhP5Pq/ejwZW2PMHd4SUUjGo7B10Dx7mwzlDr0AODKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0717
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-25_07:2020-01-24,2020-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=813 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001250165
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano [mailto:gitster@pobox.com] 
> Because you do not know where the top level is (otherwise you would not be asking "rev-parse --show-toplevel" about it), either is an option for you, 
> but you can "unset GIT_DIR" to stop telling Git that it should not perform the repository discovery.

Gotcha, thanks.  Would it make sense to have 'git rev-parse --show-toplevel' error out if GIT_DIR is set?  Or update the rev-parse documentation with a warning about GIT_DIR? 

Regards,
-Andrew
