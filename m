Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B834620248
	for <e@80x24.org>; Tue,  2 Apr 2019 00:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfDBANm (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 20:13:42 -0400
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:17730
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfDBANm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 20:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYJ7tEB2e/nB8pJCxaZNilJmvi/mP8RzTZBR6cRx7kM=;
 b=bTItEPBO9iFF9z6nTxs+jxWluhQfTO8DAAbjq+QLv/JJEtwYDR1FXu0vwuG4T6eu9pPCySsqmn1+KWX9qaDttqtSLnNCVIoFZU2j1pf30/tre7du21k3RPbkT4xcjtMd3P8NjsBCp0JZHcGeSsAxlFVHJXcmSd6JLJopOJeMi38=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4827.namprd08.prod.outlook.com (20.176.115.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Tue, 2 Apr 2019 00:13:37 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Tue, 2 Apr 2019
 00:13:37 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Andrey Mazo <ahippo@yandex.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 0/2] git-p4: inexact labels and load changelist
 description from file
Thread-Topic: [RFC PATCH v2 0/2] git-p4: inexact labels and load changelist
 description from file
Thread-Index: AQHU6Ojr5d+XqxO8wkeD+67AjetD5Q==
Date:   Tue, 2 Apr 2019 00:13:37 +0000
Message-ID: <cover.1554162242.git.amazo@checkvideo.com>
References: <cover.1554141338.git.amazo@checkvideo.com>
In-Reply-To: <cover.1554141338.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 897ebdfc-e0e3-42c5-3cf0-08d6b7000d37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB4827;
x-ms-traffictypediagnostic: DM6PR08MB4827:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR08MB48271563A80C2714B1104D04DA560@DM6PR08MB4827.namprd08.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(71200400001)(11346002)(6436002)(476003)(446003)(486006)(102836004)(305945005)(6506007)(386003)(97736004)(186003)(7736002)(256004)(26005)(71190400001)(86362001)(2501003)(76176011)(4326008)(52116002)(66066001)(68736007)(478600001)(966005)(105586002)(106356001)(2616005)(50226002)(8936002)(36756003)(25786009)(6512007)(6306002)(8676002)(5640700003)(81156014)(7416002)(81166006)(1730700003)(2906002)(53936002)(316002)(6486002)(6916009)(54906003)(14454004)(3846002)(6116002)(5660300002)(2351001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4827;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SadQssZECx2U3JEHys84zG5cBnO/2svp7mXJDXMFASRZshkbSf0RZflEDReSs5mXbU4F9oWzxn0dOyq6sE7RnDoSzxr/corvesnvMrycfVM3tscc9Wj+gG/XGjoyGcgYlAViXha14oIs0tLrUeuJeHwTBWm8mvkk1tSUxjDFNl0AphSC2U3hBjcDlx+xQvD1LGZSy9BkcmdpcdN5+dnD858C/Pjfdhc5AK/HHLvZykcAlU3dojO81uwtAVfRW+sd4WjDCO4VQlRiuHFs9/r9TyCQLxy4uGu5nyB2DAN/Tij51uiZEIwJrtdynAGtjeGP+yX+xOAyTokInjyGEhCQ4HpOz9O5QX2gkRXdlsPb/rJYHecTkjB2FYwxf+icN2w80A9ayag36S6GNTR47+hlbDVO7gpbEVNK9u0Ke9RBBiE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897ebdfc-e0e3-42c5-3cf0-08d6b7000d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 00:13:37.4604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4827
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces two experimental features to git-p4,
unrelated to each other.
 1. The first patch adds support for "inexact" label detection.
    The feature lets git-p4 find a git commit for a Perforce label
    even if there is no git commit with exact same changelist number as in =
Perforce.
    It is particularly useful when splitting a large Perforce depot
    into multiple git repositories
    or when importing just a subset of a depot into git.
 2. The second patch adds support for loading changelist description from a=
 file.
    (`p4 -G describe` equivalent)
    The original use case is to be able to migrate a Perforce depot,
    which database got a little bit corrupted, into git.

This patch series should be applied on top of
"[PATCH v3 0/8] git-p4: a few assorted fixes for branches, excludes" [1]

This is the second iteration of the patch series.
Changes since the v1 [1]:
 * Dropped "alien" branch feature;
 * Added "inexact" label feature by suggestion from Luke;
 * Added minimal documentation;
 * Changed "damaged"-oriented narrative to more generic one.
   (renamed "git-p4.damagedChangelists" to "git-p4.changelistDescriptionFil=
e",
    functions and variables correspondingly)

Range-diff vs v1:
1:  b02df749b9 < -:  ---------- git-p4: introduce alien branch mappings
-:  ---------- > 1:  54ef897fcf git-p4: inexact label detection
2:  bb3e14a389 ! 2:  83b0034538 git-p4: support loading changelist descript=
ions from files

[1] https://public-inbox.org/git/cover.1554141338.git.amazo@checkvideo.com/

Andrey Mazo (2):
  git-p4: inexact label detection
  git-p4: support loading changelist descriptions from files

 Documentation/git-p4.txt | 41 +++++++++++++++++++++++
 git-p4.py                | 72 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 106 insertions(+), 7 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
prerequisite-patch-id: 23e039fec7a1f5c51c98326a14d788adb1ecb5ba
prerequisite-patch-id: 9840851ffca6f00126c9c91da5a8828c7d0dcaed
prerequisite-patch-id: 32a738b41fb3dccfbbfb4d382a9748e36dcdfa8b
prerequisite-patch-id: 10661f77392f4131d2375976c77a7cd231fdf9ab
prerequisite-patch-id: a55360c904eba1b9e9c934405d3141eb96c5ad30
prerequisite-patch-id: 46357586199c02d956d53d782a12f1ee0c991302
prerequisite-patch-id: c683e7d6017580df9385a1544af409ca615d770c
prerequisite-patch-id: 411dcb5e95aff036e0cb3e850ea75f2424b260a6
--=20
2.19.2

