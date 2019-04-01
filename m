Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E3B20248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfDASCl (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:41 -0400
Received: from mail-eopbgr700122.outbound.protection.outlook.com ([40.107.70.122]:4813
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729644AbfDASCi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m+inUKchaFpUaP9pA04dauDSik59Fo32R/dgPzLyvk=;
 b=A4NzckrgEUQkkI5r7yEJhxgsNLCQQ3ojaKmDW4PJZynyR27IqQ+O2EF9KYMylaUIYFszWb23k5Zdq+JqLMEpbWfy0JSGmWZ68NNdC8+m3GyotDrtoWoxrREfG/iyndYF+313FzhqK0hsyhQHFlQNxmIDp6Q9+3Wf+8Z4N29bTKI=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5465.namprd08.prod.outlook.com (20.178.24.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 18:02:35 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:35 +0000
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
Subject: [PATCH v3 7/8] git-p4: add failing test for "git-p4: respect excluded
 paths when detecting branches"
Thread-Topic: [PATCH v3 7/8] git-p4: add failing test for "git-p4: respect
 excluded paths when detecting branches"
Thread-Index: AQHU6LUW4zWXpNn8rkaozp8QyCxVTA==
Date:   Mon, 1 Apr 2019 18:02:35 +0000
Message-ID: <2bde24b7e4d51e52614aaba1d38489cdf58c1543.1554141338.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: d7b3ce08-a56b-4c69-e68a-08d6b6cc3873
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5465;
x-ms-traffictypediagnostic: DM6PR08MB5465:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR08MB54658D2480C65B44A89430A6DA550@DM6PR08MB5465.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(105586002)(81156014)(2351001)(446003)(36756003)(76176011)(6916009)(11346002)(71190400001)(305945005)(4326008)(102836004)(478600001)(50226002)(7736002)(25786009)(53376002)(6116002)(5660300002)(14454004)(2906002)(256004)(14444005)(3846002)(6436002)(1730700003)(53936002)(6512007)(26005)(5640700003)(966005)(71200400001)(66066001)(7416002)(186003)(6486002)(97736004)(86362001)(2501003)(81166006)(99286004)(316002)(6506007)(386003)(8676002)(54906003)(8936002)(486006)(68736007)(52116002)(6306002)(2616005)(118296001)(476003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5465;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T18HSIKRJlY/1bBkppZcwugA1dA+QriFKxW2Ca1D5DYHonzIBPY1cxHl1TDav00yak3rT4znZGs2TQTuiovSFWnoxcIvKvSkYf18sRaxmWeb0qSHA2MliiDumcGc+x2q0hI4ZbHYh0IPFcnIF66wlTDDiU3qYuyyWcYyoPJ7tubQG0QBXqCZbr2OuoQ9yAvDzw0zij+aMgxt+pRiRDBPvTnfQpZywSitDyt4Ool2lCZboIDaZ0trJKP0ahdCBaDJz3Mf3Fa2UCl9pXld3b89gVuD4AyWySRMUZ2C4Ik3aw3meD3CP1cq7gbHB00OU52ZeHeaHs/94LeQPhhp+6ebbJFv5xZ9LuWOO8KQWhjMIeVY6vb65qL2K6Veuh82u9wyX2QHaYcvS5OpbhWpKGT4EwEIy2hhJz7a7xMi41kT4Ls=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b3ce08-a56b-4c69-e68a-08d6b6cc3873
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:35.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a fix, add a failing test case to test that
git-p4 doesn't exclude files despite being told to
when handling multiple branches.

I.e., it should exclude //depot/branch2/file2 when run with -//depot/branch=
2/file2,
but doesn't do this right now.

The test is based on 'git p4 clone complex branches' test with the followin=
g changes:
 * account for file3 moved from branch3 to branch4 in test 'git p4 submit t=
o two branches in a single changelist';
 * account for branch6 created in test 'git p4 clone file subset branch';
 * file2 is expected to be missing from all branches due to explicit exclud=
e.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 t/t9801-git-p4-branch.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 4779448b4c..7530d22de2 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -409,10 +409,50 @@ test_expect_failure 'git p4 clone file subset branch'=
 '
 		test_path_is_missing file2 &&
 		test_path_is_missing file3
 	)
 '
=20
+# Check that excluded files are omitted during import
+test_expect_failure 'git p4 clone complex branches with excluded files' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList branch1:branch2 &&
+		git config --add git-p4.branchList branch1:branch3 &&
+		git config --add git-p4.branchList branch1:branch4 &&
+		git config --add git-p4.branchList branch1:branch5 &&
+		git config --add git-p4.branchList branch1:branch6 &&
+		git p4 clone --dest=3D. --detect-branches -//depot/branch1/file2 -//depo=
t/branch2/file2 -//depot/branch3/file2 -//depot/branch4/file2 -//depot/bran=
ch5/file2 -//depot/branch6/file2 //depot@all &&
+		git log --all --graph --decorate --stat &&
+		git reset --hard p4/depot/branch1 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_file file3 &&
+		git reset --hard p4/depot/branch2 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_missing file3 &&
+		git reset --hard p4/depot/branch3 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_missing file3 &&
+		git reset --hard p4/depot/branch4 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_file file3 &&
+		git reset --hard p4/depot/branch5 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_file file3 &&
+		git reset --hard p4/depot/branch6 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_missing file3
+	)
+'
+
 # From a report in http://stackoverflow.com/questions/11893688
 # where --use-client-spec caused branch prefixes not to be removed;
 # every file in git appeared into a subdirectory of the branch name.
 test_expect_success 'use-client-spec detect-branches setup' '
 	rm -rf "$cli" &&
--=20
2.19.2

