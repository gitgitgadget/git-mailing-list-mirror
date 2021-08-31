Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 21:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F8461026
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 21:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbhHaVlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 17:41:16 -0400
Received: from mx0a-003cac01.pphosted.com ([205.220.161.93]:52606 "EHLO
        mx0a-003cac01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235562AbhHaVlP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Aug 2021 17:41:15 -0400
X-Greylist: delayed 1348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2021 17:41:15 EDT
Received: from pps.filterd (m0187214.ppops.net [127.0.0.1])
        by mx0b-003cac01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17VKo1ps001894
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 14:17:51 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0b-003cac01.pphosted.com with ESMTP id 3as6bqhw2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 14:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpfkICzavf+i+VjiEDUxCqTZs7g9IGT2R/DP5O/KrWKF0WhKI5JZpNx3x3q8wFb88NtUEcwGUl4ZlJRTulsN928OiMRhkec1U5T9knpoBk8vqILESkixvJgzgTc7YYVcdFHj4xTZ4EEib4eoC7mJ3vLu7xTlCVw76bwdUSHMvpIe/wN4ZhOxxzPPek2UKwqfZFnLgu7klx7sKvAxRfrmWfU6soio2M9r4Ldmflx+2kevlita+8rcF8iWSXdGZo+EE2ZJWM4Ol0a9SjvHqyInMj5s0wmweUL0C6V4PgS2x0ukdxzSltJBPzfPz3dIQSBwCxNKAClF2+FDkzdn+Bhgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Tuis5ATrOS42kr91FgLFXpUma94Orl2LiazOYnUs2A=;
 b=MOuKzwD87hBzXSn9C+9BukwDuhrLNEdtCKDT+pbp/dQVps2TWkQ7EbINPIz1+dXefoG4gVsQtiAlKoNCVNm4g0JaWO91WZFGPUid6qacedqegUDJEAtlxRNhQ6iHXr86PnC2K91sfEqDjVN7ujSZZyTpahWnfmLGxCtVARRB+apjjNB/YvYUAUfMJi00Od54CgFUxILzTmrrKN0FbtXjwz395ZXg+ZF6u4B5QKqT0yY5V6tyaty2Bdv0k+myydQfrZ7OZ5RsKEQ5skCKnKY6My0FngFh6OiczxWRtM6UsGNs4pNVE0o4tnmynM4y2a/E++x+vQrHFSot2szCn5GsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Tuis5ATrOS42kr91FgLFXpUma94Orl2LiazOYnUs2A=;
 b=bv+biK5HEV2Jc/cjx5Nj0MoDHzv7mNjCilhkfzagVK9z9RHOH1RIRmp10i3S+Him/afjTbDm7jI1x/CFqxwELANTFn3A88F0i5N2P+FM+heRp1Q0n/aparts1cqN/tYw/Aw+jjxLYdhTHzGm3efMmcctAIFO8sgLVt/FEaDBK4k=
Received: from BN6PR17MB3185.namprd17.prod.outlook.com (2603:10b6:405:76::22)
 by BN6PR17MB1508.namprd17.prod.outlook.com (2603:10b6:404:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 21:17:50 +0000
Received: from BN6PR17MB3185.namprd17.prod.outlook.com
 ([fe80::b009:dfd4:717e:64f5]) by BN6PR17MB3185.namprd17.prod.outlook.com
 ([fe80::b009:dfd4:717e:64f5%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 21:17:49 +0000
From:   Caleb Dougherty <caleb_dougherty@keysight.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git stash certain files
Thread-Topic: Git stash certain files
Thread-Index: AdeeqRPZyQFTIvzTTlaj/uBqkmXQFwABHNow
Date:   Tue, 31 Aug 2021 21:17:49 +0000
Message-ID: <BN6PR17MB3185652B92D61670BC92ABA5FECC9@BN6PR17MB3185.namprd17.prod.outlook.com>
References: <BN6PR17MB31854E1EB7F8D358266B2AA8FECC9@BN6PR17MB3185.namprd17.prod.outlook.com>
In-Reply-To: <BN6PR17MB31854E1EB7F8D358266B2AA8FECC9@BN6PR17MB3185.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=keysight.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5095f9f-ba8f-442e-e029-08d96cc4c97c
x-ms-traffictypediagnostic: BN6PR17MB1508:
x-microsoft-antispam-prvs: <BN6PR17MB150820756EC3C5DFD5E2C980FECC9@BN6PR17MB1508.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8sOb67OWRaO7wH7OM5q5xjySpU5mMfV6slTdqNTEKn/ivOt5tXeWNT/MS/C130jRXSd0iZKi/m4OInsRz2dq0AkftPsTKe8bnnVh9Mt9EFhDzHBkD00OKLaq7n9m1E+swnjjXI9IknV/QrhsGxOSCbgQZSTO42CpIXR+I8yz/LHiPKplKdUbOFAArYuR9w0D6i+NzBnhGbaAYGD0BEkfAby1omzAYe40fHfMWHsCHnahheWky7T+LzkdYR+VPHeD6uF1i2Rgtj90aUwboQJmRUB8tmIlf/ZZNAH5MNnzWEWFdrumZSLdclU0NqqUs3FjLZy2oiHqaPXqaEgnzZTjmU811XjUe+ZyKNW4iSpMLOuTAnl8GaYAFwlf8FyIZfgSbj/Da7SY4PJQGD9TSStoYMFw8iBN0CyWUPemsd/Bphz4X+kK/XTRYohBwa0AoTCZKw06Q/kZv6kPwfno6faYi2iXTi5Y9bEwH/BzB/AbdsDtA9wCM6JUmCVS5npr2mRsuxtz6C41bEQBWht0zcPi+a/KVJfTgh82OD7RoGzURWMm4AOkwbIOpIXVf7XH9Im5aLFocHvRlfdsTOMdvYMJiLlBhejDrbQDhl4RzAMJOfiCYMS5zE53xoF20SbiJ5YR29BRkECp4UFJIZpe+i6Id6WmeaIlDuJxUXrpQmBdQHGUSGs5NJJL5ZDz85B/x3wbYzaHDGHilexzcqwMjkanQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3185.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(6916009)(478600001)(6506007)(66946007)(64756008)(7696005)(122000001)(86362001)(316002)(76116006)(9686003)(38070700005)(2940100002)(186003)(55016002)(66556008)(83380400001)(66446008)(26005)(66476007)(3480700007)(2906002)(5660300002)(8676002)(38100700002)(52536014)(71200400001)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nMD9J6OKoIbca7ifHoy2X7c1Umo+4AVPeXqdXnJbsfCR1xypKdAskbq38p?=
 =?iso-8859-1?Q?jMU8pdPp/nea/GZpJbybWg/B5PIsL0nHKgCtb4x721RqH100sDS5vi1yGg?=
 =?iso-8859-1?Q?PNPRHqFIBecJy3SZN5Miw0lm6IXI9OYxc/LEDFnlr3lm5lkKd5MOitIvKB?=
 =?iso-8859-1?Q?cmPyoNBt/phDazmJHXfUVeTJBy7MORnu4YNWDTims4YFcwJrfLfikWsFYu?=
 =?iso-8859-1?Q?Zf4dTNVhlN/d1vo623IYx7mxSItTQrsh/UTcGHor0RRjFy5kg08Xj8dpi/?=
 =?iso-8859-1?Q?u/686Nho5GVrSZAN3ybWRYQKyt7JGf4J8ClFGhZmueapisKhJO54oaOrqM?=
 =?iso-8859-1?Q?bMXlqJqSIwIpRqhHWAUmsQJS0Cnxlx6WL1Dh4wieUNWFClueL2Nl7kdIF0?=
 =?iso-8859-1?Q?XCmK8tPIFIYLqpIfqT8JqpjCskri0kxE52tiEP59wKY1CaHr3FEhOKNO7P?=
 =?iso-8859-1?Q?Pih1z7c3m1SYCFCtJ+s2EDhXjakEPmGdUmCgiposnQOqV+oa1ab40RfB6s?=
 =?iso-8859-1?Q?cBl4iBFvwavvUDVEQbMkgaX066F2u24pfQT7m5YQ2/F8qzTzF2hFt9iTNL?=
 =?iso-8859-1?Q?jt3bnN6lD7vO4s6+Rdt4EnyCqntK3iwn374Tqbi/OEO4x7bU27dukju55K?=
 =?iso-8859-1?Q?5QQYNFHoNdIO8P9OEnDga45i/9nG5PtGpXQ+CxGAFOn7zDWa5ftUZZ0s83?=
 =?iso-8859-1?Q?QTh25i0FwJYaqnvkZ15WXqAwEub7SlEXQ3ivOlrLX2f4JUcFiAL4qSq1dC?=
 =?iso-8859-1?Q?tldpPgnItO2scT+wSJvp0kY0mOIuRTf5pDrUEgkARLTsdnJbP7/2do8tDn?=
 =?iso-8859-1?Q?nhb3uVh4Vv7NLaRZLEjdAMqjrtIGS1Xgjo0aNRGIpHLRLoNZNr8DWJL6pc?=
 =?iso-8859-1?Q?QjvRUo9Vq3iCoGrVuhW8RRmRyALFgMIlRl6rk3Fm3i+PXHUpCsJE1JV+RG?=
 =?iso-8859-1?Q?G9eLamgWdNcROuLltBRMFbWJwhfbRHPgxc+LIKaoMbw/jsa2Cuwb9bfGiC?=
 =?iso-8859-1?Q?UVCon0H1TZxjD1CBfe+Eb2uK87jsKTk7R0FCLzK76dFVedF4k1vufuaEXq?=
 =?iso-8859-1?Q?waIzsZwGdWMB/5e1h5Hz1lEhoUhMsOaMJbMcppm/ukNILnfoE7/a3wPnGi?=
 =?iso-8859-1?Q?Qzyai37Tjhu9r6qyFxPY4pcHuHUCAgLbLE4LYZk117/7+H5A9MnRbzvt/4?=
 =?iso-8859-1?Q?8xCaTNBi+a0QqagWIK1wP3n8TVEKRPNkPbKDzbiBcwb9kIaQZHNBMgMLET?=
 =?iso-8859-1?Q?IQcfmm+NoQuoREOOEy4VV0Z/3RaNwOqxXfNFeAHLRslMe2ey+P7bOj7fdM?=
 =?iso-8859-1?Q?U6R6zJogn3EucJRg7DTpdR12v0OvVL2n84CD2HtMK3nrGBPRsch64OS9re?=
 =?iso-8859-1?Q?KgF+CKWUbP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3185.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5095f9f-ba8f-442e-e029-08d96cc4c97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 21:17:49.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCi/FeqJ38JRfKL/B/EFdwYWVCMmyGdI+C8+Zq8pZvWb1fkU3sQz9+Nd2FrwgxVUNRgaZk3SVzAt41yYaH10xuTGiPDgx6JjkxencstdEEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR17MB1508
X-Proofpoint-ORIG-GUID: _3ga8Psyw7muu9qN0SKQOgRtDn4Sycye
X-Proofpoint-GUID: _3ga8Psyw7muu9qN0SKQOgRtDn4Sycye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-31_09,2021-08-31_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=726
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310116
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Let me know if I should post this somewhere else, but having used git now f=
or a couple years in my work environment, and having come from years of TFS=
 usage, I still find that I want the ability to "shelve" certain file chang=
es for later.

My workflow is to create a personal branch and make changes to different pa=
rts of our codebase, and then stage certain files (not all) that are ready,=
 and then commit them.=A0 Sometimes I need to undo certain files in my work=
ing directory but keep the changes for later.

Git stash will kind of allow that, but it is messy since it snapshots all m=
y checked out files and I have to do several commands to get the operation =
of "just stash these few files."

Here is my "shelve" command.=A0 Stage the files you want to shelve and then=
:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git commit -m '%1'
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git switch -C shelveset/%user=
name%/!shelvename!
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git switch @{-1}
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git reset --keep HEAD~

Here is my "unshelve" command:
	set branch=3Dshelveset/%username%/%1
	git cherry-pick %branch%
	git reset HEAD~
	git branch -D %branch%

It would be nice if this were built into the stage command as an option (to=
 only stash staged files), or perhaps a new shelve/unshelve set of commands=
 could be added.=A0 The additional niceties of shelve/unshelve is that it i=
s on a branch that can be pushed to a remote (so I don't lose it in a momen=
t of absentmindedness or computer failure) and potentially unshelved by som=
eone else ("Hey Joe, take a look at my code on shelveset xyz").

P.s. I cannot easily use the usual git workflow where you only do X feature=
 change on X feature branch.=A0 I work on multiple features in parallel and=
 cannot be switching branches frequently or I will incur too much overhead =
(not only running the commands to do the switch).=A0=20

Regards,
Caleb

