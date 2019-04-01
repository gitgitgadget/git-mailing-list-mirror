Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62E020248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfDASCd (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:33 -0400
Received: from mail-eopbgr800114.outbound.protection.outlook.com ([40.107.80.114]:16704
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729644AbfDASCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLBJc3/6T45L7LU/ZLPvJFaGpn7iSfrlOaluT++5XzA=;
 b=zDC7ASafT5T1BoNtcQyw1oh2XPDW94BrG7hTpsAaYJj94onf9WuiUoiLCdBUuX+vEwhqVqhBoqUpnsWIF8VnVHy+Js7usG6Cd2UYTrZZ3W3F+AWQutWHPlnJAGYO+f8P/mOq023aj0OpSustSw2Y5t84UM0sRIHrOJfSnpdXsnM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4412.namprd08.prod.outlook.com (20.176.82.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Mon, 1 Apr 2019 18:02:24 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:24 +0000
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
Subject: [PATCH v3 3/8] git-p4: match branches case insensitively if
 configured
Thread-Topic: [PATCH v3 3/8] git-p4: match branches case insensitively if
 configured
Thread-Index: AQHU6LUPgABiTghHjkK8/wWQW9SQGQ==
Date:   Mon, 1 Apr 2019 18:02:24 +0000
Message-ID: <6eaad2582c14961ec682d299267b279ce16906ef.1554141338.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
 <cover.1554141338.git.amazo@checkvideo.com>
In-Reply-To: <cover.1554141338.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:405:14::30) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dc4edde-b0b0-4b89-ec25-08d6b6cc316e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR08MB4412;
x-ms-traffictypediagnostic: DM6PR08MB4412:
x-microsoft-antispam-prvs: <DM6PR08MB4412680C4E3A6D5CF71A3A2FDA550@DM6PR08MB4412.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(6116002)(118296001)(2351001)(66066001)(305945005)(105586002)(6916009)(3846002)(50226002)(97736004)(2501003)(106356001)(8936002)(81166006)(81156014)(7736002)(8676002)(2906002)(1730700003)(54906003)(71200400001)(71190400001)(316002)(14454004)(478600001)(14444005)(256004)(19627235002)(99286004)(446003)(6506007)(386003)(102836004)(52116002)(76176011)(486006)(476003)(2616005)(25786009)(11346002)(7416002)(6436002)(5660300002)(26005)(5640700003)(4326008)(53936002)(6512007)(86362001)(68736007)(36756003)(6486002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4412;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fiDBXrU0ImMYkwQPExTfhZS16OZF6c7kgLnk4s0kAknoFeiAw/0t5JtCvt79P8BEgoQIGhzywPUcIUaR2SbtvSrFVBJtiprTKrxLWqToUAamK3wcCIcyBZnEVR11RVgH0w7MLKjtyCet7yFy+oqcGbyiY2pqh8Aq47qLxGxfzwnvHz1VpS2M2VZoXVZPgB7ukfg0q2ElS4yKk2LNaQF3NGQu3GEItp1Gv3Bn63J866mD/wZi6TEGmDQ/cFigJwM6RLPi1MlVKC5gJnOAFT9rSTCo4PnxevT1RiYHH/6eF/WCxL3k+dAjXS4PcBCxcsUEMBKJzR1a5Ax9YWEvE3ucM/tLOfrveQiMTCT5QRDZCeE2sFgCOJ6+aP4CoIs7mYhwrL+xMIZay8gezJwFUqbLZxciA68/JlSWuiQAZCifLro=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc4edde-b0b0-4b89-ec25-08d6b6cc316e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:24.1302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4412
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
 git-p4.py                | 4 ++--
 t/t9801-git-p4-branch.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c0a3068b6f..f3e5ccb7af 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2666,11 +2666,11 @@ def stripRepoPath(self, path, prefixes):
             # branch detection moves files up a level (the branch name)
             # from what client spec interpretation gives
             path =3D self.clientSpecDirs.map_in_client(path)
             if self.detectBranches:
                 for b in self.knownBranches:
-                    if path.startswith(b + "/"):
+                    if p4PathStartsWith(path, b + "/"):
                         path =3D path[len(b)+1:]
=20
         elif self.keepRepoPath:
             # Preserve everything in relative path name except leading
             # //depot/; just look at first prefix as they all should
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
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index c48532e12b..4779448b4c 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -648,11 +648,11 @@ test_expect_success !CASE_INSENSITIVE_FS 'basic p4 br=
anches for case folding' '
 		p4 submit -d "branch1/b1f4"
 	)
 '
=20
 # Check that files are properly split across branches when ignorecase is s=
et
-test_expect_failure !CASE_INSENSITIVE_FS 'git p4 clone, branchList branch =
definition, ignorecase' '
+test_expect_success !CASE_INSENSITIVE_FS 'git p4 clone, branchList branch =
definition, ignorecase' '
 	test_when_finished cleanup_git &&
 	test_create_repo "$git" &&
 	(
 		cd "$git" &&
 		git config git-p4.branchList main:branch1 &&
@@ -674,11 +674,11 @@ test_expect_failure !CASE_INSENSITIVE_FS 'git p4 clon=
e, branchList branch defini
 		test_path_is_file b1f4
 	)
 '
=20
 # Check that files are properly split across branches when ignorecase is s=
et, use-client-spec case
-test_expect_failure !CASE_INSENSITIVE_FS 'git p4 clone with client-spec, b=
ranchList branch definition, ignorecase' '
+test_expect_success !CASE_INSENSITIVE_FS 'git p4 clone with client-spec, b=
ranchList branch definition, ignorecase' '
 	client_view "//depot/... //client/..." &&
 	test_when_finished cleanup_git &&
 	test_create_repo "$git" &&
 	(
 		cd "$git" &&
--=20
2.19.2

