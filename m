Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2317C20248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfDASCZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:25 -0400
Received: from mail-eopbgr810110.outbound.protection.outlook.com ([40.107.81.110]:41696
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731037AbfDASCY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXCzxs4EKeQPPOtg80VfgaDekIrWGbZji66f4q0MrFo=;
 b=SRrd2LC4sFoeFwHy11lYn2rNOopdPGigTRMjCiG0k5tXjhZp+Tz/2LTwk5SQiCeZ514GpcKp7OeI8Y9qSbcOwq1su7kzcBsbg8rV9sYPMpDSw3HG9ry4cPVpp+aY1VW2UyKnxA5fmggHoyMXGyu9nvq5neUn+kf+nYGBkcbDPGo=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5610.namprd08.prod.outlook.com (20.178.26.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 18:02:21 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:21 +0000
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
Subject: [PATCH v3 2/8] git-p4: add failing test for "git-p4: match branches
 case insensitively if configured"
Thread-Topic: [PATCH v3 2/8] git-p4: add failing test for "git-p4: match
 branches case insensitively if configured"
Thread-Index: AQHU6LUNbC8yZm9uaEqFmDinXPwhyA==
Date:   Mon, 1 Apr 2019 18:02:21 +0000
Message-ID: <68b68ce1e4782bba552a016867bfc629f0d5e24f.1554141338.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: 5e31b368-61ba-459e-4346-08d6b6cc3018
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5610;
x-ms-traffictypediagnostic: DM6PR08MB5610:
x-microsoft-antispam-prvs: <DM6PR08MB5610F204286145AA433A81B4DA550@DM6PR08MB5610.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(486006)(102836004)(118296001)(86362001)(2906002)(50226002)(316002)(4326008)(54906003)(5660300002)(2351001)(105586002)(5640700003)(6486002)(26005)(106356001)(52116002)(186003)(8936002)(71190400001)(76176011)(68736007)(71200400001)(99286004)(6116002)(3846002)(97736004)(6436002)(6506007)(386003)(14454004)(478600001)(1730700003)(8676002)(81166006)(53936002)(7736002)(81156014)(66066001)(305945005)(7416002)(6512007)(2501003)(36756003)(476003)(14444005)(11346002)(256004)(446003)(6916009)(2616005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5610;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1RyJI8gubOjL9Yz2BdVbk/gpcnBXNs72uh/rP8AKRX77tRV8oPNgH/dHI/Vnj4tFIG9eyE40dXbtqIEDEiOY7lkKtyqxgccWzqoHcClpLO3me4UKTxqKVgLxvL6Tx99jxlX6c3rxYUWNlHOLjdu/uv7izy1ZpetjlF9su8Y08x4uclJUg4lK+DzwVjRlFMYlacz6Xj4OMffejNhxPv9YwoGN8amZcXEh/EepDYPYal+Sex6CdxNvyO4B6qZzmuWHmUYx12688ctNyFDM9zhpnFQ6IuKWDnPux3ISfTsJEcAXza0iQDDLpst3nNA7M6c5+rjVMqP1sZoLcl3NDHroDNbhXmU1dEldRP+BA/wxV+haJVhAMcQhEgkaL/at/6GmVXoHyPni2HpJmu/2a4r7Wk/lM6PAKt+9hL6Xi+CFRCc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e31b368-61ba-459e-4346-08d6b6cc3018
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:21.8335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5610
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a fix, add a failing test case to test that
git-p4 doesn't fold the case in file paths
when doing branch detection case insensitively.
(i.e. when core.ignorecase is set)

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 t/t9801-git-p4-branch.sh | 92 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 6a86d6996b..c48532e12b 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -608,10 +608,102 @@ test_expect_success 'Update a file in git side and s=
ubmit to P4 using client vie
 		cd branch1 &&
 		grep "client spec" file1
 	)
 '
=20
+test_expect_success 'restart p4d (case folding enabled)' '
+	kill_p4d &&
+	start_p4d -C1
+'
+
+#
+# 1: //depot/main/mf1
+# 2: integrate //depot/main/... -> //depot/branch1/...
+# 3: //depot/main/mf2
+# 4: //depot/BRANCH1/B1f3
+# 5: //depot/branch1/b1f4
+#
+test_expect_success !CASE_INSENSITIVE_FS 'basic p4 branches for case foldi=
ng' '
+	(
+		cd "$cli" &&
+		mkdir -p main &&
+
+		echo mf1 >main/mf1 &&
+		p4 add main/mf1 &&
+		p4 submit -d "main/mf1" &&
+
+		p4 integrate //depot/main/... //depot/branch1/... &&
+		p4 submit -d "integrate main to branch1" &&
+
+		echo mf2 >main/mf2 &&
+		p4 add main/mf2 &&
+		p4 submit -d "main/mf2" &&
+
+		mkdir BRANCH1 &&
+		echo B1f3 >BRANCH1/B1f3 &&
+		p4 add BRANCH1/B1f3 &&
+		p4 submit -d "BRANCH1/B1f3" &&
+
+		echo b1f4 >branch1/b1f4 &&
+		p4 add branch1/b1f4 &&
+		p4 submit -d "branch1/b1f4"
+	)
+'
+
+# Check that files are properly split across branches when ignorecase is s=
et
+test_expect_failure !CASE_INSENSITIVE_FS 'git p4 clone, branchList branch =
definition, ignorecase' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList main:branch1 &&
+		git config --type=3Dbool core.ignoreCase true &&
+		git p4 clone --dest=3D. --detect-branches //depot@all &&
+
+		git log --all --graph --decorate --stat &&
+
+		git reset --hard p4/master &&
+		test_path_is_file mf1 &&
+		test_path_is_file mf2 &&
+		test_path_is_missing B1f3 &&
+		test_path_is_missing b1f4 &&
+
+		git reset --hard p4/depot/branch1 &&
+		test_path_is_file mf1 &&
+		test_path_is_missing mf2 &&
+		test_path_is_file B1f3 &&
+		test_path_is_file b1f4
+	)
+'
+
+# Check that files are properly split across branches when ignorecase is s=
et, use-client-spec case
+test_expect_failure !CASE_INSENSITIVE_FS 'git p4 clone with client-spec, b=
ranchList branch definition, ignorecase' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList main:branch1 &&
+		git config --type=3Dbool core.ignoreCase true &&
+		git p4 clone --dest=3D. --use-client-spec --detect-branches //depot@all =
&&
+
+		git log --all --graph --decorate --stat &&
+
+		git reset --hard p4/master &&
+		test_path_is_file mf1 &&
+		test_path_is_file mf2 &&
+		test_path_is_missing B1f3 &&
+		test_path_is_missing b1f4 &&
+
+		git reset --hard p4/depot/branch1 &&
+		test_path_is_file mf1 &&
+		test_path_is_missing mf2 &&
+		test_path_is_file B1f3 &&
+		test_path_is_file b1f4
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
=20
 test_done
--=20
2.19.2

