Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5071F404
	for <e@80x24.org>; Thu, 13 Sep 2018 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIMW44 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 18:56:56 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:33389
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbeIMW44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 18:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiR+gcQM1F+JWsr/aIPTmjXHcBEwEaM8QPo4O1AiZpQ=;
 b=EtLhKJCP8xP8LWzkExTVYPAGTEZHv9ycO0iOlMJirBCKOYVfsWYbr51VW21QuXWFr/kJyTjU8vATddTezIQMfUOSRYwxmfb5dxa8iEkqUHVg/O9vk51WHXHRdJrdJZ0ufgAcKFM1TsAP0SDbdk6RTgTSYFVm0/ZuFZLonD+q8LI=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1050.namprd21.prod.outlook.com (52.132.149.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Thu, 13 Sep 2018 17:45:43 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Thu, 13 Sep 2018
 17:45:43 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] fsmonitor: update GIT_TEST_FSMONITOR support
Thread-Topic: [PATCH v1] fsmonitor: update GIT_TEST_FSMONITOR support
Thread-Index: AQHUS4mXE0CDYXL6xkea7ScTYRU/Ow==
Date:   Thu, 13 Sep 2018 17:45:42 +0000
Message-ID: <20180913174522.53872-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: DF4PR8401CA0028.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7602::14) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1050;6:ygz0YYbPufxeGNwiV3127yLoVyn9STEcHXBKDAQRk6vJrc31fGACCAwKbBqrpiDr+yPm5//iK6OXT6OdIrOK4FZXvscX6I6jW8d+uHwCsZpFpYuWT/XYRx4VABnZRR5Ds4vRHc3Agomoh9pfjuFLB4LPSb7uJgNGOuGoMO7Bwn6hfXZZLMdbgj4uRhDRVi3pPS9e6enD+EKvuBkYUztI0RUOAwk7IQvfQYnozNt8Zr+X8csGJd7Agb2+9XlOcOIm1GTLOhToFKnajrLjWnXqzVcS07b/g3QIJfTEXjh0LPJ95YNEqzzKvOWz8DHY6N4Dv0YpwT0M31HKCUcbdAuHBETZ2bBJNptUa8rEs2591UncP3RTtCz9GGD4JiqMRvgtECVqBr6TVAp3sJUlawEpcQi3wMRfGHdVoqIxm6TZ+a2qFblSPtJRdIzlzhnUmiYJ0zlGVGJpXR01Hkvq2eyi5Q==;5:UBihKTq1/lhKNh8XQMXKR1uAKcB2kIk2eV/up/hvlxY1iR3jboe5YwhyfwcUjA/HzdQRrQW3qgdy9XwRqsdptsje90qITR1LJNOT+Kf+KTeeLfksT59JoTsscAd95SXYAiNq57+X4NASsTWXTW5RXWuaTXhw+h6a6bFKTCJbdNQ=;7:UsyqfmiKUDXYEdusbl8LiB5cEHDXE3F0/FHLSHaSRoI/aL7WzTxbmwuzarZGNI3yojeC+U6d/5ICxHbsSpqePoiFOgTb4AZ7EimNt9nTY/WtaWubrWgjemFwnZfyVqXgIQj9oLjAU6gXiRjYwbfxgJ7zRfhYxQQGabMTrXN4t7HIsArtUnVbRKFJA0Xzbt/OWzLuhYBKvdnFlf50lD2Qq7t29Lx/0CszbuCfDyTmDb2TrJHC+knQYE6kljeEIa/T
x-ms-office365-filtering-correlation-id: df30239b-08ad-4b0c-8d9a-08d619a0b9bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1050;
x-ms-traffictypediagnostic: MW2PR2101MB1050:
x-microsoft-antispam-prvs: <MW2PR2101MB1050FBF1EDB6AAC1CEC8B4D9F41A0@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1050;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1050;
x-forefront-prvs: 07943272E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(7736002)(106356001)(6346003)(26005)(22452003)(1076002)(186003)(102836004)(6506007)(105586002)(386003)(6916009)(5640700003)(6116002)(2351001)(5660300001)(3846002)(72206003)(53936002)(966005)(10290500003)(81166006)(66066001)(25786009)(99286004)(478600001)(305945005)(81156014)(86612001)(8676002)(4326008)(14454004)(6306002)(52116002)(6512007)(54906003)(68736007)(8936002)(50226002)(316002)(1730700003)(2900100001)(10090500001)(36756003)(2906002)(6486002)(97736004)(14444005)(2501003)(256004)(486006)(476003)(107886003)(575784001)(2616005)(6436002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1050;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: lnhBblPeppB5cC7msRNesUE3GnlBBTOnHBvlntrPJaqY/eZfPH6MTzHxftyISjJjCr27RbWcBg9F7ByAMbRy0Dwzeo9hPRCpyYMs7nrZCk6hAZT1lFwsutUhS4ZnYp/6OJJ4XTdV1qdrW9XAkgjmho8MAMDLbcql6u4bxrzg1VeAFKKDwwigBhbyPoUMb+C07GOrK2pDv0T0S+NDyDagIa1FXrULDCYCAXt4GxqOLSDFVlf3LHmxOWripbc1w6Qu1cydByw66puNnKnF4WK6oCP24ZZOAjA0dZWmdTeSpb8jaQt2GnjZKr4LdmaWExIpy9h7NPczga2TTRvQP5OSM58LMXMfzKMkce/nXv4hOJc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df30239b-08ad-4b0c-8d9a-08d619a0b9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 17:45:42.9545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename GIT_FSMONITOR_TEST to GIT_TEST_FSMONITOR for consistency with the
other GIT_TEST_ special setups and properly document its use.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: v2.19.0
    Web-Diff: https://github.com/benpeart/git/commit/311484a684
    Checkout: git fetch https://github.com/benpeart/git git-test-fsmonitor-=
v1 && git checkout 311484a684

 config.c                    | 2 +-
 t/README                    | 4 ++++
 t/t1700-split-index.sh      | 2 +-
 t/t7519-status-fsmonitor.sh | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 3461993f0a..3555c63f28 100644
--- a/config.c
+++ b/config.c
@@ -2278,7 +2278,7 @@ int git_config_get_max_percent_split_change(void)
 int git_config_get_fsmonitor(void)
 {
 	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
-		core_fsmonitor =3D getenv("GIT_FSMONITOR_TEST");
+		core_fsmonitor =3D getenv("GIT_TEST_FSMONITOR");
=20
 	if (core_fsmonitor && !*core_fsmonitor)
 		core_fsmonitor =3D NULL;
diff --git a/t/README b/t/README
index 9028b47d92..545438c820 100644
--- a/t/README
+++ b/t/README
@@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncomon pac=
k-objects code
 path where deltas larger than this limit require extra memory
 allocation for bookkeeping.
=20
+GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all exercises the fsmonitor
+code path for utilizing a file system monitor to speed up detecting
+new or changed files.
+
 Naming Tests
 ------------
=20
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index b3b4d83eaf..f6a856f24c 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -6,7 +6,7 @@ test_description=3D'split index mode tests'
=20
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
-sane_unset GIT_FSMONITOR_TEST
+sane_unset GIT_TEST_FSMONITOR
=20
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 756beb0d8e..d77012ea6d 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -8,7 +8,7 @@ test_description=3D'git status with file system watcher'
 # To run the entire git test suite using fsmonitor:
 #
 # copy t/t7519/fsmonitor-all to a location in your path and then set
-# GIT_FSMONITOR_TEST=3Dfsmonitor-all and run your tests.
+# GIT_TEST_FSMONITOR=3Dfsmonitor-all and run your tests.
 #
=20
 # Note, after "git reset --hard HEAD" no extensions exist other than 'TREE=
'

base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
--=20
2.18.0.windows.1

