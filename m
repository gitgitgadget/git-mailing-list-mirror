Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E393F1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 14:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeINTwd (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 15:52:33 -0400
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:51842
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeINTwb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 15:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2qG+Z+WRrzHW1nV2YCTjt+j2zQNaAlZQAg38F1YAso=;
 b=lfs2GFQK7hW9ooS785WaHjwRgehARomeJaoWMPamKgKEm4FCcyNj3Yb4trFcx/fjZ+dJIfsjtNBCx/b76DwP6slOw3n1nAZ8Z4nUXXGq2bw0jGUCYHawaGKFB72abvd9U/E9CjgLV1OGQI1kOI3MTxd0yg/93AmSIm5Nb6/+YQU=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0972.namprd21.prod.outlook.com (52.132.146.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Fri, 14 Sep 2018 14:37:28 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 14:37:28 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 3/4] read-cache: update TEST_GIT_INDEX_VERSION support
Thread-Topic: [PATCH v1 3/4] read-cache: update TEST_GIT_INDEX_VERSION support
Thread-Index: AQHUTDh2CHVnD0bUhE+q1qB6eUTylQ==
Date:   Fri, 14 Sep 2018 14:37:28 +0000
Message-ID: <20180914143708.63024-4-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0972;6:8xGEnRJWGAAr5ulpjmTXqxSAZGBKF5Xjpl/BljUt8SwzmQsI870nk2KVwHdP+uAg889Z25Y9BunuOFumGCx/nSmI5meRgPdNktbBQusK8SjP3Nf1MxSPjBFwk60eT2K4Ec3ky2BRUSGS5hEQlTuenIKrjWYM4Ej9G58Zyo+BhqKpXhxajySCJSZjp3bHuB8jbOQxtv7M3J/K+YlbbFeOpB7Pl03WN0GZXKe7UcN9T30rDmXYj14fLIGCGB0YAXwEMpj44/r3LFCCXQw3Zbne9OhC8xoxOSx+RSgTv3cHk0d/fCs4yHYfSu+Y/V4O/8gUtu0KkjVWZkaCySPAO/lKiaKleGsKnHDYInwvpq6Efo36zpIgx0SdviNVf0ooHtsDRuaQEa6OGgDrzPMaq4FYg7WDDLc4I3UnotZ2Ke1D4h4IVOQkzeFstfZSJP5DDm1QlZzP/1zYfU0kes5ssaBcLg==;5:P/+a8qAo53LRHTRm4h5mhvctaDWJzbpxqTh7WWg3Vsbaewal0gHa8Xk2PuEFyu9ghg0/+tNjcBByj5WeERBv4OOaLF8PLMOcbchJuxdiU/AbuDKjFm8xYgg03/yog3FVUaRv5tA2yPEeuQ2VSz1Y/QDSDPh+4EC7kaJp5T33aCk=;7:GNnS0gso+3oHamoPGea6nHqF1Lql7dMCM+gQ6k+D6N4OsJ3ORIVwVFi0akYvPGDv5JnQFhvkl5p+XIt/Ni+AjmEHjuJW9T7lUyh2rxUek1D3OpAFIzBDLUZyIAes8sJSDj32ZhzaTF0MoSsi5cFmlpljazeqUcU2Krn5JCTJkLcPBOS0wOgPYKuKtfVhwFKkbJiInqEOissKZ6c7CRNSX3bbqynLV23vEZgk/PRYtYTt4k7rNiJH96T+7hRMP6mv
x-ms-office365-filtering-correlation-id: 57ccd06e-d638-468a-1a4a-08d61a4f9864
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0972;
x-ms-traffictypediagnostic: MW2PR2101MB0972:
x-microsoft-antispam-prvs: <MW2PR2101MB09722B5561D722F11AA11584F4190@MW2PR2101MB0972.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0972;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0972;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(486006)(6346003)(3846002)(386003)(22452003)(6506007)(6436002)(26005)(186003)(53936002)(2900100001)(2616005)(446003)(11346002)(5640700003)(5250100002)(6116002)(476003)(14454004)(76176011)(316002)(25786009)(54906003)(6486002)(10090500001)(36756003)(2501003)(99286004)(1076002)(6512007)(102836004)(97736004)(14444005)(52116002)(68736007)(66066001)(2351001)(106356001)(39060400002)(256004)(50226002)(8936002)(10290500003)(81166006)(81156014)(1730700003)(8676002)(107886003)(5660300001)(72206003)(478600001)(305945005)(6916009)(15650500001)(7736002)(2906002)(86612001)(575784001)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0972;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: PafqA84q29BAusfbm3RFFX3ps+Fq+xkWR1+o3ghTaaKqDU6HXjv7z1oeyCep5k/oQd6/r8S9vnXnvVnAD8AX4br4S2SVAdlTuiJ/YE6YJLo2fZV/n7QLWDGDkhwei9mQFKNKAcs9V80iDCKJyePiVE1TA7/Cd5NTuk7+wjO8YyACVm6pCj3dZvGjl6oClcFw5t+dkOExbetN7pql0wGSVBwxnJ5jX74vBfT3nQUM2TCrjr6qMeweBwKHD2+4Y+vbaD28vfz7OopBe9flZmyv63gfgaKY20+1CEhrAOuuOxklQkPiv9wV6TJGxYTI+bedoGYclLJ/bWrYpNgrpQp5LT92pbgv+ngYa5CVi7r5FdQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ccd06e-d638-468a-1a4a-08d61a4f9864
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 14:37:28.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0972
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename TEST_GIT_INDEX_VERSION to GIT_TEST_INDEX_VERSION for consistency wit=
h
the other GIT_TEST_ special setups and properly document its use.

Add logic in t/test-lib.sh to give an error when the old variable is set to
let people know they need to update their environment to use the new
variable. If the new variable is also set, just give a warning so they can
eventually remove the old variable.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Makefile      |  6 +++---
 t/README      |  4 ++++
 t/test-lib.sh | 15 +++++++++++++--
 3 files changed, 20 insertions(+), 5 deletions(-)

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
index 0ef111d808..5f5f0f4b55 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,12 +134,23 @@ export EDITOR
 GIT_TRACE_BARE=3D1
 export GIT_TRACE_BARE
=20
-if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
+if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
 then
-	GIT_INDEX_VERSION=3D"$TEST_GIT_INDEX_VERSION"
+	GIT_INDEX_VERSION=3D"$GIT_TEST_INDEX_VERSION"
 	export GIT_INDEX_VERSION
 fi
=20
+if test -n "$TEST_GIT_INDEX_VERSION"
+then
+	if test -n "$GIT_TEST_INDEX_VERSION"
+	then
+		echo "warning: the TEST_GIT_INDEX_VERSION variable has been renamed to G=
IT_TEST_INDEX_VERSION"
+	else
+		echo "error: the TEST_GIT_INDEX_VERSION variable has been renamed to GIT=
_TEST_INDEX_VERSION"
+		exit 1
+	fi
+fi
+
 if test -n "$GIT_FSMONITOR_TEST"
 then
 	if test -n "$GIT_TEST_FSMONITOR"
--=20
2.18.0.windows.1

