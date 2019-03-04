Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA5620248
	for <e@80x24.org>; Mon,  4 Mar 2019 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfCDRes (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 12:34:48 -0500
Received: from mail-eopbgr760120.outbound.protection.outlook.com ([40.107.76.120]:18492
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbfCDRes (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 12:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsXKuS0sLoF6vg9kwfz/4lj7MRt+ss9M7eELjPZ5gdM=;
 b=dXvUUfPeo02CXvsSE8YSNFWyJS7fZ3IPLOUBmgEE4nzYV89RINT5JARsEA/69TfoqgeG9aE/Cj1nMmUJWE+91DFT/ZeGb/K6j6RkV2x2xnOGuNUvmufx6EWJCCJBhy3Ef8u+x2Vk+6IkHeV1LCc9dqfpxBmrfyVya6/6YTkx0SM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4377.namprd08.prod.outlook.com (20.176.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 17:34:44 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 17:34:44 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH 2/5] git-p4: match branches case insensitively if configured
Thread-Topic: [PATCH 2/5] git-p4: match branches case insensitively if
 configured
Thread-Index: AQHU0rCOhWeI+255OUaXkVf9ovY5fA==
Date:   Mon, 4 Mar 2019 17:34:44 +0000
Message-ID: <e644a8ab4928349ed83ac9ab6ffdbcafc3a3a7b5.1551485349.git.amazo@checkvideo.com>
References: <cover.1551485349.git.amazo@checkvideo.com>
In-Reply-To: <cover.1551485349.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:404:13e::32) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7838a892-e376-459d-12a5-08d6a0c7b0c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4377;
x-ms-traffictypediagnostic: DM6PR08MB4377:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR08MB4377;23:GoBCly04bOUoXmnyH2OBZAZsYna7K+ykRnXfNuo?=
 =?iso-8859-1?Q?DevtPhDyVrxnGqR+zeo2ROCXvtByvwJlI3psaJJlPHlfJ82mcnbsK8xbJn?=
 =?iso-8859-1?Q?M21Z6FRiVZ9f8Sw/Gdl9jBjwqSkjaxREZsTXOhrPLK/MpD5JiYmvagWDOT?=
 =?iso-8859-1?Q?qrP8aKj+CAJJJIC84w34tM8sBBD5JKkYfZjdKn5J6nvGKjFGP/G+SGIjIM?=
 =?iso-8859-1?Q?w+875nCkW2rPgk+SHEoJf5+8KqKP1MMSSuVNkpv5O66PD/9TwFD2ocxNv5?=
 =?iso-8859-1?Q?5ToRWwozTVDWqT9yGvHF1jL9RsrNgCC6NeY6XGDN41qRpl2yOtXeld++6m?=
 =?iso-8859-1?Q?bqbTUuZjKwjXHgyOSuxFkCBUl2Pop3ADLKQdEyXl9XsS1gIuNcnbXbuN6M?=
 =?iso-8859-1?Q?QSbJL4xwUTxul1kmBX+5HEZ6ntv3aMTbjyVUm+kzVBA+TB6VR//+kJNAOY?=
 =?iso-8859-1?Q?RjmD8htukSPrgLbE6DMKnY3RqC9kpsKKde56W/mZiN6ii9zGINi9GSy503?=
 =?iso-8859-1?Q?xjmYw2Krz65Paia/LIMbuXGXjfAQlbNS7wWHZSWt4Qm6TPl48LparNGEWn?=
 =?iso-8859-1?Q?ZK3g2cEXbaUbLWwyM3Da26jzW+P2uwXhh0edfMq1hnQoU5ALNSVyHqe7UI?=
 =?iso-8859-1?Q?7gM7R8ZupAdAapbXoYzRyCCqnmgMLckR3C3Y33l+laVGsnUzwv5CgGiVuo?=
 =?iso-8859-1?Q?gCbr5WbmHsrMR0042Tzaz1HHaZbDP15q0af3Q8ADYxEXxFSrIbByRx1SYV?=
 =?iso-8859-1?Q?1WeEBtw3/hzv92UYXxuRsVSznBFEPC9CQ22yMO/cLDARceDpi3vgAPfqU5?=
 =?iso-8859-1?Q?2W03+hzXWAl64DR9t6ZSf5369cX5eNqOzPVIH3aw/ya+83ZWM9y5zerZ/9?=
 =?iso-8859-1?Q?XGd488gwcqUn1HrHlFnerdD/ZMYxalxcfCWESwE1Xxs3mxMYBDBAOx/CuD?=
 =?iso-8859-1?Q?ZVEyTPYwAnZ36ks3dSLYJlGojuZID/pZO5kgP4cSO/baaKPfjQriHvwcNB?=
 =?iso-8859-1?Q?nu6usHB4AlEVV4aZcaThMdhoiGIG6YmnG2WfHPbJIA2uyPvrMTIn/KG2a3?=
 =?iso-8859-1?Q?qVxBSJW0RygssvI8KYAJ+iqJsj9MJqlr1u7lHG8V7RzZf+KY/6XlcF62x9?=
 =?iso-8859-1?Q?q+PICQVZ4FVLB9aCMS+FpSRNJA/6JGjYd5nAzUj4xCD3YaBoatcs96gRom?=
 =?iso-8859-1?Q?nROjZcpKX1AbnEOHCTSjYSxBhp75BK/1qg9FY91mbcvEtPywTi6X0KuRU4?=
 =?iso-8859-1?Q?PqLBHzdF4+HObIfV++VrKW0lqmwEsKdy1oUeWNmFohU/gs/7u8+8txZXcZ?=
 =?iso-8859-1?Q?m9phYNSUA71gAuzFajp1gfAxduIW4fif6uvesYjRiqFPyquQE/bocXkKKs?=
 =?iso-8859-1?Q?GNgbf7MDexQLNOC30BbisBivCSNDo2nrbu3K3O7pxkz5fasRsLg=3D=3D?=
x-microsoft-antispam-prvs: <DM6PR08MB43772B089C2643290FFB9B44DA710@DM6PR08MB4377.namprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(316002)(5640700003)(86362001)(3846002)(6116002)(186003)(26005)(6512007)(4326008)(6916009)(486006)(6486002)(66066001)(53936002)(6436002)(256004)(118296001)(14444005)(6506007)(52116002)(102836004)(76176011)(99286004)(386003)(2906002)(478600001)(14454004)(2351001)(2501003)(81156014)(5660300002)(81166006)(1730700003)(8676002)(68736007)(2616005)(8936002)(97736004)(50226002)(54906003)(19627235002)(7416002)(105586002)(106356001)(11346002)(25786009)(36756003)(305945005)(7736002)(71190400001)(71200400001)(446003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4377;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 51IwYgbtcquaO2qTcZ639yChmlAbBBRH/hDx1rmKM8Pxb3FK2qosJa/LJOzHulqF6BaXzm9qPb6Mxy6vzduZowWhklUWN0Gyl2Lgvh9FG9JGhr0mvSoFNokcaZyOA5Siouo8tepWfy5R5e2T4rHBOChryq04PvuPz1c+5vgWpRXKQjKiuUtx0vUt6ex1BA/roQ9FTdffk8troNhPnz7QXk+C9SYzyari/xAtTzGUO49tMnE1O1oIiJLKA02E3mWVbNVD4qkPKw7PgCJ/k8JYOTlol6Nw1BqpROFzdJ4Boi90Ajg0YrJEplff8y0HRDCckPDtew/1y7ilQgnGoqWsWK3wduD/u6KhBRUjovbdLcohj0ozoX1DK6hwP5OCh/a+PL3BrGYC3e627ZdGuSHmhP+Z2MlyGQTfgI8c7am9dDE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7838a892-e376-459d-12a5-08d6a0c7b0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 17:34:44.5854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4377
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 knows how to handle case insensitivity in file paths
if core.ignorecase is set.
However, when determining a branch for a file,
it still does a case-sensitive prefix match.
This may result in some file changes to be lost on import.

For example, given the following commits
 1. add //depot/main/file1
 2. add //depot/DirA/file2
 3. add //depot/dira/file3
 4. add //depot/DirA/file4
and "branchList =3D main:DirA" branch mapping,
commit 3 will be lost.

So, do branch search case insensitively if running with core.ignorecase set=
.
Teach splitFilesIntoBranches() to use the p4PathStartsWith() function
for path prefix matches instead of always case-sensitive match.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index c0a3068b6f..91c610f960 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2721,11 +2721,11 @@ def splitFilesIntoBranches(self, commit):
                 relPath =3D self.stripRepoPath(path, self.depotPaths)
=20
             for branch in self.knownBranches.keys():
                 # add a trailing slash so that a commit into qt/4.2foo
                 # doesn't end up in qt/4.2, e.g.
-                if relPath.startswith(branch + "/"):
+                if p4PathStartsWith(relPath, branch + "/"):
                     if branch not in branches:
                         branches[branch] =3D []
                     branches[branch].append(file)
                     break
=20
--=20
2.19.2

