Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB071F453
	for <e@80x24.org>; Tue, 18 Sep 2018 23:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeISFEl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:04:41 -0400
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:52352
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbeISFEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HvX27Gm77CpedPgCethpuqWrkCpSsxyt3gmbF+nIOU=;
 b=of+6tVxldkmj06kwqzS1MZ73zhDDrg0qIjPpqmmM2y5HSWD566BasjMucuzuWSAbikndaOq9jIfWiyUaPWGkWQqkNPR2ccmy7CA4Y9xzFf9/u61/100WdzduSOM+knXTK/ca3ngnf+ZAJCrtJ+D1K/RRL05x5183YtIFpZYf/So=
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.6; Tue, 18 Sep 2018 23:29:37 +0000
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be]) by BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be%2]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 23:29:36 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 4/5] read-cache: update TEST_GIT_INDEX_VERSION support
Thread-Topic: [PATCH v3 4/5] read-cache: update TEST_GIT_INDEX_VERSION support
Thread-Index: AQHUT6d2IAWURHwFNka1k5BUPMcwtw==
Date:   Tue, 18 Sep 2018 23:29:36 +0000
Message-ID: <20180918232916.57736-5-benpeart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180918232916.57736-1-benpeart@microsoft.com>
In-Reply-To: <20180918232916.57736-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: BN6PR19CA0107.namprd19.prod.outlook.com
 (2603:10b6:404:a0::21) To BL0PR2101MB0962.namprd21.prod.outlook.com
 (2603:10b6:207:30::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;6:LxpWUOGFwzqke+VDfJC17jZ20CcVePQfQ9v+AH5Vr4RZvv+8QXlVGjohDEmUNOpIIWO30+TrZrsnuqwM8VHEc2qfAU9i0oYlRMIqefzOgtKsbvAvooEr/W/TDSgJbDVWl77vHEFrKl9j22ix/K78HT9lBJf7di1ledHSnwT6Qh0UsEKnyuXvuKj+CatlWpjZap2mtTa1JGo/mIiay76yYbCgulAWE1Mc1XeYIrs66s7DbmzkDyCvcL3zL18ScUr49ptkqvEvThwtuojEK/FU2jB9YT6wFUlS60JkBVfFUqBPOIDbrdUjN93H2z4ioo0J4pvmW4LkwmWZVmYO4dtHuTut+P5N7TE5ZrqzXuQDbd3d62x6D6FkX/K580McCqob5jjxcc7ze3B9o8YK9qrUZse7XDtDHgFHxyeUpUu8lioeHNJOTErtDJ8JebBerXTBNMMj4WH8taA45kWK88i5gQ==;5:3Rpz+UP7TYLFnYYyC4DaH8lxtMHDH3rgRE8QGE8xYPh1qWONnRMj/okniBSxMzL/MgrAz1Q1KYnfPYuYTDhVyfiwD+kz/2VUuO3sczNmflxsizaNqEmEslDY+P+ML3Ua5WoWX9wvIrFgDLDvUQkqJ1RoOTOHKyG2tV9CCPoYUJ4=;7:aqBTmnZ/bf8JiOEa6bSIxunzDQMSELmZzLtSQqdp7yIefq7p+544WWTAKE+lblMf2pCYIcKoaZ6XZ4ZQUZYmKm0nJryailbjfU8DMWY5YoYGvT7eHmTpmCTBIjCG+DzrGzzXIlrPGd4K7YVzL6ILz4NYMShIXKD8uYSiVI15NzddcxqJsZv/iYY/4Kjyf166SVf62tOS085viNtNia6F1UHcYzwdO/f2lA5MxRuqpb4xwYb7F0JZ7QAUEbDWrH3o
x-ms-office365-filtering-correlation-id: 03242ecb-5134-49e6-1be8-08d61dbe986b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-microsoft-antispam-prvs: <BL0PR2101MB0994E29EB32925D82077E68CF41D0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(189003)(54906003)(14444005)(68736007)(2616005)(2906002)(86612001)(5640700003)(476003)(11346002)(256004)(6506007)(386003)(102836004)(8676002)(3846002)(6512007)(50226002)(36756003)(6116002)(446003)(316002)(486006)(6916009)(1076002)(2900100001)(8936002)(66066001)(10290500003)(5660300001)(81156014)(478600001)(1730700003)(72206003)(186003)(14454004)(99286004)(26005)(105586002)(15650500001)(52116002)(53936002)(2351001)(4326008)(81166006)(6486002)(2501003)(97736004)(107886003)(22452003)(76176011)(106356001)(5250100002)(6346003)(39060400002)(10090500001)(6436002)(305945005)(25786009)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB0962.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: 3XIfy9y3/Z17809yx4+qw+py+lFszwtXAZ8i3iWzr+w4ME5p7e86LLx2Ja2bymrIgqkt6gjlAX1RQirJmtFlhYtnH34iWCRKfR0ilnUct4pz5bCkWc0/L9VYiQzOc7KWa6+6f7s3B+RLmdJ7mqtwrVvD3hVUJa/JiMEtv2zwiUprRNijpteyzN25V0ck2NElwMoG+p2+Zdb7yupf0CBsxjTJzSoAXm/DQ34vKSkVN920zq4IBBn99bAxSZ11F8+zg5DzcTCBn7o4m5AyubO11Rh9W2x2+cWD4PkLFeCFqsXBXksX0gqlzCRYKUGxYhgOsenIEJ25ha/UtmMqc/799qU9EgK0gA8fZMyAjgo3DUo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03242ecb-5134-49e6-1be8-08d61dbe986b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:29:36.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename TEST_GIT_INDEX_VERSION to GIT_TEST_INDEX_VERSION for consistency wit=
h
the other GIT_TEST_ special setups and properly document its use.

Add logic in t/test-lib.sh to give a warning when the old variable is set t=
o
let people know they need to update their environment to use the new
variable.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Makefile      |  6 +++---
 t/README      |  4 ++++
 t/test-lib.sh | 14 ++++++++------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 5a969f5830..9e84ef02f7 100644
--- a/Makefile
+++ b/Makefile
@@ -400,7 +400,7 @@ all::
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
 #
-# Define TEST_GIT_INDEX_VERSION to 2, 3 or 4 to run the test suite
+# Define GIT_TEST_INDEX_VERSION to 2, 3 or 4 to run the test suite
 # with a different indexfile format version.  If it isn't set the index
 # file format used is index-v[23].
 #
@@ -2599,8 +2599,8 @@ endif
 ifdef GIT_INTEROP_MAKE_OPTS
 	@echo GIT_INTEROP_MAKE_OPTS=3D\''$(subst ','\'',$(subst ','\'',$(GIT_INTE=
ROP_MAKE_OPTS)))'\' >>$@+
 endif
-ifdef TEST_GIT_INDEX_VERSION
-	@echo TEST_GIT_INDEX_VERSION=3D\''$(subst ','\'',$(subst ','\'',$(TEST_GI=
T_INDEX_VERSION)))'\' >>$@+
+ifdef GIT_TEST_INDEX_VERSION
+	@echo GIT_TEST_INDEX_VERSION=3D\''$(subst ','\'',$(subst ','\'',$(GIT_TES=
T_INDEX_VERSION)))'\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
=20
diff --git a/t/README b/t/README
index 47165f7eab..9b13f6d12e 100644
--- a/t/README
+++ b/t/README
@@ -323,6 +323,10 @@ GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all exercise=
s the fsmonitor
 code path for utilizing a file system monitor to speed up detecting
 new or changed files.
=20
+GIT_TEST_INDEX_VERSION=3D<n> exercises the index read/write code path
+for the index version specified.  Can be set to any valid version
+(currently 2, 3, or 4).
+
 Naming Tests
 ------------
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 653688c067..e80c84d13c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,12 +134,6 @@ export EDITOR
 GIT_TRACE_BARE=3D1
 export GIT_TRACE_BARE
=20
-if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
-then
-	GIT_INDEX_VERSION=3D"$TEST_GIT_INDEX_VERSION"
-	export GIT_INDEX_VERSION
-fi
-
 check_var_migration () {
 	old_name=3D$1 new_name=3D$2
 	eval "old_isset=3D\${${old_name}:+isset}"
@@ -159,6 +153,14 @@ check_var_migration () {
 }
=20
 check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
+check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
+
+# Use specific version of the index file format
+if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
+then
+	GIT_INDEX_VERSION=3D"$GIT_TEST_INDEX_VERSION"
+	export GIT_INDEX_VERSION
+fi
=20
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
--=20
2.18.0.windows.1

