Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0D41F404
	for <e@80x24.org>; Fri, 14 Sep 2018 14:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeINTwe (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 15:52:34 -0400
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:51842
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeINTwe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 15:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXjbn/Ym33hZLTd8JHv374hNi2J0w2w4MorIWUux52s=;
 b=Wqc0qiFGksd4aPb3R5NXPCDhLNKOdG0RWqg315QO2Y3MJce0Dz7kkY+DDlbwO8WKFMV1fBWaqHrDHnvj7ouccGEppv4SbyDfGhmtzTkAVbGcvhmnA18VjUOM/1OuS0reA1fRrMNqDlKjjIDOVi22Yn/BB8E1yDCLVcdYL/Xb4bY=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0972.namprd21.prod.outlook.com (52.132.146.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Fri, 14 Sep 2018 14:37:29 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 14:37:29 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 4/4] preload-index: update GIT_FORCE_PRELOAD_TEST support
Thread-Topic: [PATCH v1 4/4] preload-index: update GIT_FORCE_PRELOAD_TEST
 support
Thread-Index: AQHUTDh2RxdElgyF/UW00bwXjPlkZQ==
Date:   Fri, 14 Sep 2018 14:37:29 +0000
Message-ID: <20180914143708.63024-5-benpeart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
In-Reply-To: <20180914143708.63024-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY4PR12CA0037.namprd12.prod.outlook.com
 (2603:10b6:903:129::23) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0972;6:KZlkMaozQuK8k/yn6TuWOmN1MRphtZvK7RvGHUJWdYom7C3YVL0832iwDhpKB5jGQSvnVQk5q62ScrgThmUTztC2mcKMWF+h27IKVWjZQesH/P5LUJsQjcu3ibdMZXrbL6jb1FYuKdseou39Donih1n7Te7l+9KS+pV62cRgMMP2XIm59HNP0hp4r82gy6VejrTu/ldS7BCND2h9Ub2yMsrBJD+RYorudNhbxEWEb+mYDKOx0S2He9PfebzjROL8exvia8x3YAR3TZ785pq2yfuXt4Qh7HR0EnRoMnj3xquD/6/O3eFcbImj65R5VwVKrm4a3F/zpDfQPwxnsMZPegPzDB5tMdz447SO/ba4EOKwmWHwIJODn8P8E8mgVeXYgPCsr9pM3IFxsBOTKPfkq0UJ1LrRHABGUE7Zxys2bXsPtTsheq5y01nAoc1Bnkkf+9fe1IkOoRPK9VMIrnQ08w==;5:hqENpJKAdeEOKFTinDfhu6Ey8BHLRra7qYN/75DS7c3a5TTqreN1OhzUI4csWhW9AwyHXFh9rIhhzLQywbZJbSbS1z4UWLZiuIKTgrsD6rRkOZqsF5dNiD7sueesHH5Zxb++0PYRGfL22mgg6FES1HnOtZErgiVyVT5etxAA0rw=;7:K2mljzfe2f+bKV6M35aQShFOGX9PT9+/zPv9bDpm5fyoDcfIOhsoqOg7r6jEXtDrRXTVvgfQJ8oB0kq0H3Cv+GErRwx9YROEecSXsT/byZFNkPaIt0lBYF7N2HHZyJIB+5z2Juj634RTlaqewgDJ1GsiC8wzC9sSlfzqoLItTuYOnxamFEfF6tfZLXbcL5JN722s5CpjcFA3eDysQzJhvD+JSSs8wx/D5ylIXNWIqHlsy0LmXQq2tMZsibcy+sux
x-ms-office365-filtering-correlation-id: 40194c3a-fcac-4e0e-eb50-08d61a4f9916
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0972;
x-ms-traffictypediagnostic: MW2PR2101MB0972:
x-microsoft-antispam-prvs: <MW2PR2101MB0972D2853A6549B6F66836AAF4190@MW2PR2101MB0972.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0972;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0972;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(486006)(6346003)(3846002)(386003)(22452003)(6506007)(6436002)(26005)(186003)(53936002)(2900100001)(2616005)(446003)(11346002)(5640700003)(5250100002)(6116002)(476003)(14454004)(76176011)(316002)(25786009)(54906003)(6486002)(10090500001)(36756003)(2501003)(99286004)(1076002)(6512007)(102836004)(97736004)(14444005)(52116002)(68736007)(66066001)(2351001)(106356001)(39060400002)(256004)(50226002)(8936002)(10290500003)(81166006)(81156014)(1730700003)(8676002)(107886003)(5660300001)(72206003)(478600001)(305945005)(6916009)(15650500001)(7736002)(2906002)(86612001)(575784001)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0972;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: jk85rbHE7Wt94DOKRlkPUsF4fRfrCag4tbJ2MSCPH5WqL2jPqGuZBw2DRX9PFW8EIQwp67aSD6U1tu5nYapYccpUoBpBb7oy+XFiD4UO0swQZ1QNgxcPSVOer1xpJoTWmgvwtxuLRwSJyXFOLZo6S8joRJj+Wo52L3HqWmUfdiA8HVo1GIEom9an5afHB6hj4aHfyDeti3jBT3PO5PDbser7A2qG7bUqZlJKhgeQHf0VNTm7zbZjIXHKkfIYa8QdrhO91Um/ICcJod7urpyEFPtNWUe2HgrlPMX3dQL882kATmP9aO4bTUjpVoZFeeLn3nexinn3IJd2kg/uzmRzVgZjcDTJKq3/qreJhFKP+6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40194c3a-fcac-4e0e-eb50-08d61a4f9916
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 14:37:29.5783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0972
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename GIT_FORCE_PRELOAD_TEST to GIT_TEST_PRELOAD_INDEX for consistency wit=
h
the other GIT_TEST_ special setups and properly document its use.

Add logic in t/test-lib.sh to give an error when the old variable is set to
let people know they need to update their environment to use the new
variable. If the new variable is also set, just give a warning so they can
eventually remove the old variable.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 preload-index.c             |  3 ++-
 t/README                    |  3 +++
 t/t7519-status-fsmonitor.sh |  4 ++--
 t/test-lib.sh               | 11 +++++++++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 71cd2437a3..a850e197c2 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -5,6 +5,7 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "fsmonitor.h"
+#include "config.h"
=20
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index,
@@ -84,7 +85,7 @@ static void preload_index(struct index_state *index,
 		return;
=20
 	threads =3D index->cache_nr / THREAD_COST;
-	if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_T=
EST"))
+	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_TEST_PREL=
OAD_INDEX", 0))
 		threads =3D 2;
 	if (threads < 2)
 		return;
diff --git a/t/README b/t/README
index 9b13f6d12e..5670c7aad0 100644
--- a/t/README
+++ b/t/README
@@ -327,6 +327,9 @@ GIT_TEST_INDEX_VERSION=3D<n> exercises the index read/w=
rite code path
 for the index version specified.  Can be set to any valid version
 (currently 2, 3, or 4).
=20
+GIT_TEST_PRELOAD_INDEX=3D<boolean> exercises the preload-index code path
+by overriding the minimum number of cache entries required per thread.
+
 Naming Tests
 ------------
=20
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d77012ea6d..8308d6d5b1 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -245,9 +245,9 @@ do
 		git config core.preloadIndex $preload_val &&
 		if test $preload_val =3D true
 		then
-			GIT_FORCE_PRELOAD_TEST=3D$preload_val; export GIT_FORCE_PRELOAD_TEST
+			GIT_TEST_PRELOAD_INDEX=3D$preload_val; export GIT_TEST_PRELOAD_INDEX
 		else
-			unset GIT_FORCE_PRELOAD_TEST
+			sane_unset GIT_TEST_PRELOAD_INDEX
 		fi
 	'
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5f5f0f4b55..3f447b8ddc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -162,6 +162,17 @@ then
 	fi
 fi
=20
+if test -n "$GIT_FORCE_PRELOAD_TEST"
+then
+	if test -n "$GIT_TEST_PRELOAD_INDEX"
+	then
+		echo "warning: the GIT_FORCE_PRELOAD_TEST variable has been renamed to G=
IT_TEST_PRELOAD_INDEX"
+	else
+		echo "error: the GIT_FORCE_PRELOAD_TEST variable has been renamed to GIT=
_TEST_PRELOAD_INDEX"
+		exit 1
+	fi
+fi
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
--=20
2.18.0.windows.1

