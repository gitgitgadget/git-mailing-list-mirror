Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537151F404
	for <e@80x24.org>; Fri, 14 Sep 2018 20:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeIOBaB (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 21:30:01 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:25600
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOBaB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 21:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQsH3FswpI7Ue5UYrMzXYwO2GJrPRuo0KgfB5uHIzw4=;
 b=K5+yYdEu0vYJvFhsRQ67IGHlHUb44QoMHdR/ktZL2M2SFSUkzLIlPh1jREf0UrJ4Cr7AWW4jfmtlQAw+8R60WMM9OC743Y5fk8tVqF7xLLijhFGvTA32HWJCZjcNc75c+mXLKAm5m1rEID6WxBguVzaRc7ImuPQESjvbQ2Ss9n0=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1083.namprd21.prod.outlook.com (52.132.149.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Fri, 14 Sep 2018 20:13:57 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 20:13:57 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>
Subject: [PATCH v2 0/5] Cleanup pass on special test setups
Thread-Topic: [PATCH v2 0/5] Cleanup pass on special test setups
Thread-Index: AQHUTGd3mnvoKy9ktkGU+X17ESBOSA==
Date:   Fri, 14 Sep 2018 20:13:57 +0000
Message-ID: <20180914201340.37400-1-benpeart@microsoft.com>
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
In-Reply-To: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY1PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::29) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:Xic0IYI3+1nkpTjzOcOxDw9fYFNPGZ9kgFTkyNVtTjsz6vkoLfs98TiDHln8rDiBibUYaJxuMmG2z+p+Ac3blYs2CGN1Ukm7posz/l2GefyUONmv/ipp2jxZ9j9Wrw+MYkQywYdxW3YN8ptICaqszRmzE8m6vAtM4Y+MTEBq/5FrALG1CXLHiTShaB+DJhsL6ZonzbFho+1PTKV9wQu+ZRoUVR25NFt9stMuNlJvd4r1ZH7G7wJLuetRBxHRdKstyaaX8JgGFIFHOGiKuuzei4oX1OF53HMxML3SN2KIsFqoab79GEuFlS7zSGXJhCLucV+CUj7dRjuTMQKL0hWFb6ZgBtaIqbvYQvyK9vHUDKy3vlGhlJElPvfrZHsnhjF42pRw0A/tAfhCFQ4L1QFLORA/z3gk0XlzKUNQ5gELbvXeEw6vKIScOaU9JC+1BDfwIjoj/ytOTXcrmFv6p367IQ==;5:Ex6AY/d++py4xESUj+SjgxW4YaGWLW8tvAngEv6xSf1NopVfC810yweOPWbluH47xxyTG+2KnPVRBwBlP+1EA+BjyMIxnXogbFcbHp+895cEswX7LfZSuk+OoieFVJKUhHRHZbq2SSkrsxu6T3K2121yyv+IWWhSDCnzdcwnmmI=;7:Vu+uCuVl4ZiiX/sFS6Xjyzb7jgCZTvzE66E3M/aSJQ0H+UQEjEa6BYiWeXxXb7ySYkww0dqKtPY+3OiJsNQmkMOayZdlKCcKZQ4Bgd6oEyANLEfUp5FdAtks2liMpiANhXXSNXxN6BZBq3AA+UNWAdQuwSS1BKaiRPz4WzB0PF9PcB2EHWKjPpRtSa24rQnogQPCvHDCARjsIuS94mtCYO0C5JGLa93tXGosj/3IEc7HkLb0DR6POCuPKFq0VHF3
x-ms-office365-filtering-correlation-id: 398512e7-2bce-4597-e8a2-08d61a7e9a0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1083DAFD6E1F1813E687D24BF4190@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(54906003)(478600001)(36756003)(2351001)(81166006)(81156014)(386003)(1730700003)(6506007)(8676002)(4326008)(316002)(8936002)(97736004)(22452003)(102836004)(1076002)(6116002)(3846002)(106356001)(1361003)(72206003)(966005)(575784001)(25786009)(50226002)(105586002)(305945005)(14454004)(7736002)(1411001)(99286004)(86612001)(2906002)(76176011)(52116002)(10290500003)(5660300001)(6916009)(39060400002)(5250100002)(6512007)(486006)(186003)(6436002)(6306002)(11346002)(476003)(2616005)(6486002)(446003)(26005)(5640700003)(2900100001)(10090500001)(2501003)(66066001)(53936002)(68736007)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NlN6hjewcwWf6NyjiZEVwXCCyL3BLboryWyxskCEQPSXAcVmlGpm3N8TgL+HqZDBLWCW2iXLuYFpUnnu9xOn/r/uaD/1+vwXspbSS4Jszha/U9tK3zJdLkDvOCVv/PHROd4GWqdppRG0Q4hykHEdtgQsnpjWG8PxtTUt6Q1clF+8M95s5vWoWwgusDfMUCWAZsXsOXvpwss020uaNseD1nlxANhnQ6WgG859HjebNjyZQqYjeRdcChUKM/0gu/bgGL9JEjZBfgIe2e/4N8OkSkAmgpGgya2IYs7+2NySf1OWn9GmOPHuAPoFVhcky4XA04Rna0p3Fh5xEjetORTBV9RFPtrWRuQqvklRL1WdU1w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398512e7-2bce-4597-e8a2-08d61a7e9a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:13:57.7686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes this round are to use Junio's more elegant script to test and warn
about using old variables and munging which changes are in which commit.

Base Ref: v2.19.0
Web-Diff: https://github.com/benpeart/git/commit/79d62d39e4
Checkout: git fetch https://github.com/benpeart/git git-test-cleanup-v2 && =
git checkout 79d62d39e4


### Interdiff (v1..v2):

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3f447b8ddc..17a56f44ad 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -140,38 +140,27 @@ then
 	export GIT_INDEX_VERSION
 fi
=20
-if test -n "$TEST_GIT_INDEX_VERSION"
-then
-	if test -n "$GIT_TEST_INDEX_VERSION"
-	then
-		echo "warning: the TEST_GIT_INDEX_VERSION variable has been renamed to G=
IT_TEST_INDEX_VERSION"
-	else
-		echo "error: the TEST_GIT_INDEX_VERSION variable has been renamed to GIT=
_TEST_INDEX_VERSION"
-		exit 1
-	fi
-fi
-
-if test -n "$GIT_FSMONITOR_TEST"
-then
-	if test -n "$GIT_TEST_FSMONITOR"
-	then
-		echo "warning: the GIT_FSMONITOR_TEST variable has been renamed to GIT_T=
EST_FSMONITOR"
-	else
-		echo "error: the GIT_FSMONITOR_TEST variable has been renamed to GIT_TES=
T_FSMONITOR"
-		exit 1
-	fi
-fi
+check_var_migration () {
+	old_name=3D$1 new_name=3D$2
+	eval "old_isset=3D\${${old_name}:+isset}"
+	eval "new_isset=3D\${${new_name}:+isset}"
+	case "$old_isset,$new_isset" in
+	isset,)
+		echo >&2 "warning: $old_name is now $new_name"
+		echo >&2 "hint: set $new_name too during the transition period"
+		eval "$new_name=3D\$$old_name"
+		;;
+	isset,isset)
+		# do this later
+		# echo >&2 "warning: $old_name is now $new_name"
+		# echo >&2 "hint: remove $old_name"
+		;;
+	esac
+}
=20
-if test -n "$GIT_FORCE_PRELOAD_TEST"
-then
-	if test -n "$GIT_TEST_PRELOAD_INDEX"
-	then
-		echo "warning: the GIT_FORCE_PRELOAD_TEST variable has been renamed to G=
IT_TEST_PRELOAD_INDEX"
-	else
-		echo "error: the GIT_FORCE_PRELOAD_TEST variable has been renamed to GIT=
_TEST_PRELOAD_INDEX"
-		exit 1
-	fi
-fi
+check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
+check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
+check_var_migration GIT_FORCE_PRELOAD_TEST GIT_TEST_PRELOAD_INDEX
=20
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind


### Patches

Ben Peart (5):
  correct typo/spelling error in t/README
  preload-index: teach GIT_FORCE_PRELOAD_TEST to take a boolean
  fsmonitor: update GIT_TEST_FSMONITOR support
  read-cache: update TEST_GIT_INDEX_VERSION support
  preload-index: update GIT_FORCE_PRELOAD_TEST support

 Makefile                    |  6 +++---
 config.c                    |  2 +-
 preload-index.c             |  3 ++-
 t/README                    | 13 ++++++++++++-
 t/t1700-split-index.sh      |  2 +-
 t/t7519-status-fsmonitor.sh |  6 +++---
 t/test-lib.sh               | 26 ++++++++++++++++++++++++--
 7 files changed, 46 insertions(+), 12 deletions(-)


base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
--=20
2.18.0.windows.1


