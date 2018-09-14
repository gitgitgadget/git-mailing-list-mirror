Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B561F404
	for <e@80x24.org>; Fri, 14 Sep 2018 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeIOBaJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 21:30:09 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:25600
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbeIOBaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 21:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBPv0x7qpFIjCywICJvI2lmeTtqGYm7nMVlfVZVAxI0=;
 b=iEYAH1uDxGOkHbzdVbY59DKbpszofdP4JANYboclHAnkFKHZwL//cqP3XWAR4vhFuE674pHCg6F+Zpq/eRtLjDmBm8AWJm8Ni9OZPMEd6UR16YxAfb2NHNFfiJFD9cYBoXD1WkDZ1EmYOwQE90Gyqgp0q3uRd5NfN0Fzstb30dU=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1083.namprd21.prod.outlook.com (52.132.149.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Fri, 14 Sep 2018 20:14:02 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 20:14:02 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>
Subject: [PATCH v2 3/5] fsmonitor: update GIT_TEST_FSMONITOR support
Thread-Topic: [PATCH v2 3/5] fsmonitor: update GIT_TEST_FSMONITOR support
Thread-Index: AQHUTGd644xDfWaU4U67smCy4q78mA==
Date:   Fri, 14 Sep 2018 20:14:02 +0000
Message-ID: <20180914201340.37400-4-benpeart@microsoft.com>
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
 <20180914201340.37400-1-benpeart@microsoft.com>
In-Reply-To: <20180914201340.37400-1-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:nEkhH6LNcMGbzMYZ+lhuqv3XiXGt+yk6izb+Con5YyC4ibsMU4sVyaVPb4oV3cHHVlmePWrbNBKZ3qWzDJWbKpJk40WgCq0vrkbwMzZaMlwX0XwQAGkrDcBkg1eYFo/L35QNvMo5bWznEn7o8jyWqnDJ1ZadTW9nSLHNAm8e75PEPZB/CQWEzrDaB5zjwg9FsacVBtZcwHSEHuSvhBIhoQ5pteh4MsZdfST5xFSh4sqJMwBAV3zNio4mePqKTWGXauUQEmPXT7Ntpwy1GNH4pS8yXKl5cmRJ+rjhjWkXUhnXKmHXkmkWmqF0zQgcsbSMrB8wBNUMdAdEv0mxCjJ9bRHhOFyZODDRs2UR8WLdRUIMIPMlv+5h/0L4Rwbc88uRvWhSvlIjreuo0QFChzCLaVYvXYxSCGxzDIkZCWGo2cgfmVu+D/NRhFxzo0s/JY5Avkr/ixIP7zxhHrFHV3G1+w==;5:hoJKpv8H/tUX7y/2tetfbQyNbmAbSLO8PiANZkdmhXbHApWw6CFv1cNOnI+7D8RdEn54zoW9UgnvUl89IYKc3BtPEIjdnxSG2fX9tr2KEg5hOPTkJzEmjp+NWJT3E5PCegt3TKyHqPsG7+p05urmpw7E8XMMvMMkRGT1mPFilvg=;7:cqrQd0lcr8xx13LbPhWXxEq/N3KSec5zg4I/jdb9ivQGU8nS9iBjjkv436uN+uhFUdZNMfCOf1nso+pFzL8ehQ6vw9y1IFpEhxKD8EzGmxmgbkB+mypfnxjxGOefxSd6dP3H8wrA09G6O5OvKnE0BGtnC+Qd9JsHr76lwYmyXPSDGhmKTHebVlIo1Ar51q6QU8LeYpt3a5LuO5VF7Lllx4Mq3JNjtnHhlHk2eS7P8LUtCNZqvG4bunCIbeHb/h9Y
x-ms-office365-filtering-correlation-id: 689b08ab-0384-4c69-2901-08d61a7e9cf9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1083468B2C38BF76F4EE2FE7F4190@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(54906003)(478600001)(36756003)(2351001)(81166006)(81156014)(386003)(1730700003)(6506007)(8676002)(4326008)(316002)(8936002)(97736004)(22452003)(102836004)(1076002)(6116002)(3846002)(106356001)(1361003)(72206003)(575784001)(25786009)(50226002)(105586002)(305945005)(14454004)(7736002)(1411001)(99286004)(86612001)(2906002)(15650500001)(76176011)(52116002)(10290500003)(5660300001)(6916009)(39060400002)(5250100002)(6512007)(486006)(186003)(6436002)(11346002)(476003)(2616005)(6486002)(446003)(26005)(5640700003)(2900100001)(10090500001)(2501003)(66066001)(53936002)(68736007)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Zeq2KG0S0UTYnLlynpdv6STPKSox/QjDMmO8tk7Pr3kQTtflAMr69Zss7XLIkZZSLllISaC8SnaovKlhl7mkeYqPSFoULr5VaniT6s0EwraFAAcTeA3m24QV/Nu94bggA8ImlHsiKx1UbR3nPldGv4TrGcbHbdCXjkXaw4ZfZUJDZx7e9pYnqDEZZ9PhBEUFNE7ZJRIK+hdIzRYaxW5Au5BkWQmirqOKkUNfdAO3mjMO43YYDoBFX851dkw3MXQaZTqadM3D9lOIxsfGn+unLp0g+rjiq6izKkqRnMW5hvHC6ozUCN/A7nTiwoRpATxU3V7u327CSdOqe0qZle6q5HZsHwZMCF0QvR2lxuOFiWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689b08ab-0384-4c69-2901-08d61a7e9cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:14:02.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename GIT_FSMONITOR_TEST to GIT_TEST_FSMONITOR for consistency with the
other GIT_TEST_ special setups and properly document its use.

Add logic in t/test-lib.sh to give a warning when the old variable is set t=
o
let people know they need to update their environment to use the new
variable.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 config.c                    |  2 +-
 t/README                    |  4 ++++
 t/t1700-split-index.sh      |  2 +-
 t/t7519-status-fsmonitor.sh |  2 +-
 t/test-lib.sh               | 20 ++++++++++++++++++++
 5 files changed, 27 insertions(+), 3 deletions(-)

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
index 56a417439c..47165f7eab 100644
--- a/t/README
+++ b/t/README
@@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncommon pa=
ck-objects code
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 44288cbb59..653688c067 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -140,6 +140,26 @@ then
 	export GIT_INDEX_VERSION
 fi
=20
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
+
+check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
--=20
2.18.0.windows.1

