Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA771F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfKFPcZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:32:25 -0500
Received: from mail-eopbgr770118.outbound.protection.outlook.com ([40.107.77.118]:40165
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfKFPcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:32:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjdmm6eyVnB+12n5DOyP9Tyx2BDiVb+zT/j0qPfeTZLXzsgY7i/3xyx6K8/nG1jSfiPgb6rGBtN1vRDq0wMNmUWwPZbNrC6n/ubzqcEDdu5a94wuWDAb6CLRNdA5ofI9lSJoDF2BAR/ciBK1YO1ltXlRjw1ayfExRzRS1EsQkPVVoPFp+bH9w0aS4bmaxx2OOoPaALsq7GG2mYiGtHX6QNC+Wcz8qno8W0FWinpuiyCCAFkWZL+GsQ/BpuB/zIGgh9Yi4XV5uOSbi9sL0YoP8RQU+Sm62GG6ATvAu20TJ5Q0XTXdRA1mI+efxxc3GCotzzfh80Q1VdMYabayGRzg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zOTo2b4zVoHV8mp3tG+H4UH3Xx9fwrNtnzzNGVjRFc=;
 b=ilhgsUJZzvJskDAUv9J4+mnmEuZ0apclPcwC7gaDqL9vNpAba4rEJaFiTgdlRMgfxkwVi3Pi7ofdlhGzNjJzMbLvuuYQiK8tZuMNy/UlH+X8p39zuFusYcRtVqrcxBy2zXmxZ3Nkf9D6khWiix4YGj7j1fGPVkFmWr/7zvDyIGuH5PxiNDAwWffzN/m4kXZdF+c84L8L5GPI9rLSNaoIC19C0IC9z228N5tWsUTQz3YXkJLxwzkTcpjpptocQiM39z8PIDq4PjWSJOHs4EA+vL7ODT4JJ7TqnBAN0PgIvVp687SICTk511VER9A3z2eL6JlsKjyu2zNoT7tz7QH7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zOTo2b4zVoHV8mp3tG+H4UH3Xx9fwrNtnzzNGVjRFc=;
 b=bPYVPgBO1g7xeAQoDxwsgb0afPCpJnRhK2wD+si3PLJg+gtOfskapTGQ6PS4+HXKP7XkAx/Q5kWrpbA8oohBol3jnfyjSlgHGRHsi5pr2litxMYq+1FQ9706KXO7/jBOLvw2ErczqJ2cPZrbZvid1RpJ88clEdRzbZd7EN/pN7s=
Received: from BN6PR21MB0786.namprd21.prod.outlook.com (10.175.132.14) by
 BN6PR21MB0849.namprd21.prod.outlook.com (10.173.205.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.11; Wed, 6 Nov 2019 15:32:22 +0000
Received: from BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e]) by BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e%9]) with mapi id 15.20.2430.011; Wed, 6 Nov 2019
 15:32:22 +0000
From:   Kevin Willford <Kevin.Willford@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 0/1] fsmonitor: fix watchman integration
Thread-Topic: [PATCH 0/1] fsmonitor: fix watchman integration
Thread-Index: AQHVk1FrAhwPWx1BAU2RsRhj0eLmRad9flAwgADF+qA=
Date:   Wed, 6 Nov 2019 15:32:22 +0000
Message-ID: <BN6PR21MB0786856156CFB55E8812D51E91790@BN6PR21MB0786.namprd21.prod.outlook.com>
References: <pull.444.git.1572889841.gitgitgadget@gmail.com>
 <xmqqlfstvg09.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfstvg09.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin.Willford@microsoft.com; 
x-originating-ip: [174.126.253.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0bb3fde-09cd-4a74-4bfd-08d762ce84cc
x-ms-traffictypediagnostic: BN6PR21MB0849:
x-microsoft-antispam-prvs: <BN6PR21MB08491E0FF429F87F7419657691790@BN6PR21MB0849.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(3846002)(25786009)(6116002)(71190400001)(71200400001)(52536014)(7736002)(10290500003)(5660300002)(305945005)(186003)(33656002)(74316002)(9686003)(99286004)(2906002)(55016002)(8936002)(81166006)(81156014)(8676002)(478600001)(6436002)(11346002)(4326008)(8990500004)(6506007)(446003)(6246003)(7696005)(86362001)(76176011)(26005)(486006)(10090500001)(66066001)(66446008)(66946007)(66476007)(66556008)(256004)(76116006)(110136005)(476003)(64756008)(102836004)(316002)(229853002)(14454004)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0849;H:BN6PR21MB0786.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSomPGTvn1vkZKs7u2jwXxHmKPpM/vSeU6uGRJLRjr3RK7Rny5jXZ2XrYgdaMRZJ6UmI0kzVj/mt8PjAycTY7dvPxvTIY9ksHqcM8bM+DVKtTJnCzuxusMYsH8E0iO6sLoVNBnVMAKyslCn7QauU8k0jrvMFRlWZgdqq0YruIQ+RTMSoayj7HneOeCD+UM7Q5M4hDKiN0Bt2yuE/JprNYotDUOzMiWpoGyk0Pis8AwnEzLUrXT0cYDgauap3QbMZmMXJzxPa2m66uTt2lmUXtqmfCRKGvl8LjOtUllukFhvbMr2RAjJ/H99zTSPnd3pk4SAeDm0Jlz7BVcp3M88WO9cGN/yE0BhHNIrrZy7Oe+wj4BxrCcq4ESZyuD/hd+2tzASn+QHnWzpztcvtdeWMz0x57piS8GMijSoVEORWjqIsnt9bJWRfl+Ae7KW+qqxf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bb3fde-09cd-4a74-4bfd-08d762ce84cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 15:32:22.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kectw280UIy9A2QFpP2cvLoCumZvPEYNyoDL5V67ojLeTGlgeO7hyjdULFOp2sXgcVI2MED8QNbysAMTkxBqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0849
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano <gitster@pobox.com>
> Sent: Tuesday, November 5, 2019 8:30 PM
>=20
> "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > When running Git commands quickly -- such as in a shell script or the
> > test suite -- the Git commands frequently complete and start again
> > during the same second. The example fsmonitor hooks to integrate with
> > Watchman truncate the nanosecond times to seconds. In principle, this
> > is fine, as Watchman claims to use inclusive comparisons [1]. The
> > result should only be an over-representation of the changed paths since
> the last Git command.
> > ...
>=20
> So, it doesn't seem to use "inclusive" and we need a workaround?

That is what is seems like.  I would like to dig into the watchman code
to understand what is really going on.  They also document that "Using
a timestamp is prone to race conditions in understanding the complete
state of the file tree." Which could be the cause since the tests are
running things in quick succession, i.e. change a file, run a git command.

Long term we should switch to using watchman's clock id which the
documentation says does not have the race conditions. But the clock
id is a string and would take more invasive changes to integrate that
into the index where we are now simply using a uint64_t.

