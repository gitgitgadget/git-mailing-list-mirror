Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384121F404
	for <e@80x24.org>; Fri, 14 Sep 2018 20:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeIOBaL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 21:30:11 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:25600
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOBaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 21:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPNsWhYUgu8RnWJoBJGtDPvxf0XRfyZXnceIUerUf58=;
 b=NJ2yWEKqikGa9c045XlJ2Kq4CAnuJJgEl5q0WtHRWvOB5t80mYTBIfVMnmV8tomLXnaKvqePpYOPDrgZZVs5WIQDkMGLIDCOXkuJ4xOjzHpklK2YX0GmkXe/Dg7VNdVwzj4nMMeCPGFw4EpJNQOkR7XpBv0D49wi1dXL0JwnU2s=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1083.namprd21.prod.outlook.com (52.132.149.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Fri, 14 Sep 2018 20:14:03 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 20:14:03 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>
Subject: [PATCH v2 4/5] read-cache: update TEST_GIT_INDEX_VERSION support
Thread-Topic: [PATCH v2 4/5] read-cache: update TEST_GIT_INDEX_VERSION support
Thread-Index: AQHUTGd7ZiZOlAjVQUSnyC2pf0z3nw==
Date:   Fri, 14 Sep 2018 20:14:03 +0000
Message-ID: <20180914201340.37400-5-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:SdJe1P0QUg3KnCUrp0aQgXgQn32/PNqXbZcXYvj6kAgt5rMwSrEDCPJnCJEbRZHq2FY2Pn9ZsZ3D3j6xq0NJi4/cVGhLPkHEVAqMzoGhAtNZJPr9UlEieA7wXbjZ6iFrj6ooer37qvFLfwum0uO8ZllIILmrL2LUAUcbGIEtfIc1lKeRHUYvRHFrX6MoehTBfO4Ji3qtVjLhlskW15LGoJH5iwOG69mRcvmUn+syxYp3a43u8zqAiD8lcwsc5IEmG0fv9cmmJWONG6c49Qde5Solh6+aFCBnYJnYFgn69kbGZ5OtpLDWtjRLdAZdmTMoRbjsDO2m+tt5vwa/vwd/KkFWgyEXH+eKMtshrrd1jmdwTSgfSZgk4AE4BMZvlw6Vp8XJ8H7Xe1d9rsD36TyHXqUPrVml7Oeuo6Y4Iw28UlQWbmcP6H12GiLEzQlWkX+7RNBy8+V8lrx8kYo1BjibWA==;5:uUppDXCy4Ofb1sthnLt/HA4TgKz7qhmltSZWAFhha0RVdxFFssnH/0WipPRCwV1HvO9uhZuKNC2uS/gHGVRMR9Qqcy/hIAPd9fhgz77yKwZeWCNXlSSfMp9TgDMkGZs97p9atorUVOvH9oNba290o4bvstIjVWHCU6LTzEFLtZI=;7:ZcTBg8f84Yxh4aZz+mhJ65jP5F7ugComMft7EWSCZUjvxV2T4YU5sRMN7wQK2RRLRexz0fFjBjMCOpEy6Qj9owFzL/dcUIbZh+XNiUhGjlyUVCzplfRvUEScYQSqpMDLZE45AMNBQJ1oxcajs/qmsBwzVqDtcOP35q6QDw9B3YLywo7NOfpzUci6PuD9D5uIzKYF3DGa/qik6/POf0zUF4oMbxWSKn/W2XcXyFObAUKWRJ5lullBppY7Y3NZxJ3q
x-ms-office365-filtering-correlation-id: b6ac79cc-a2be-4137-a9ef-08d61a7e9dbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB108326F2FA6B72414863E9D6F4190@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(54906003)(478600001)(36756003)(2351001)(81166006)(81156014)(386003)(1730700003)(6506007)(8676002)(4326008)(316002)(8936002)(97736004)(22452003)(102836004)(1076002)(6116002)(3846002)(106356001)(1361003)(72206003)(25786009)(50226002)(105586002)(305945005)(14454004)(7736002)(1411001)(99286004)(86612001)(2906002)(15650500001)(76176011)(52116002)(10290500003)(5660300001)(6916009)(39060400002)(5250100002)(6512007)(486006)(186003)(6436002)(11346002)(476003)(2616005)(6486002)(446003)(26005)(5640700003)(2900100001)(10090500001)(2501003)(66066001)(53936002)(68736007)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7HR8cXMhNwhmslTyXna2YoKi3bHLWL2vM7TXBFe8a3wK7OdSphZblGZHpQERun1rztQ1VtmMxpXUQrqp6zY07xKDYgvBX7/kPbBHiagduIlGEb8Ux34PUo4vaFFJq6lifvEC2kwaqtWBt6BHD9vZ84lnszdjqCVZjTHMftWqoL6Q4ZpwD4fbbVxEVMx/EAqJlekoKvbI+N4M4+2MjVkr/LvLNZy5sHvBMEWIO2uL56ihiR1ydIIaZdVSdJbpJoAA3Y3iVGiHgrFn76yThgRYUXBSmyztxCGQQB6Ao9P4eRsUSDExtUKf4dIxX+VLQ0Ldk1URhdlz658+EI6d2ijeRg3gtmymeYFhAP5J4qb7sYg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ac79cc-a2be-4137-a9ef-08d61a7e9dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:14:03.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
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
 Makefile      | 6 +++---
 t/README      | 4 ++++
 t/test-lib.sh | 5 +++--
 3 files changed, 10 insertions(+), 5 deletions(-)

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
index 653688c067..397eb71578 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,9 +134,9 @@ export EDITOR
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
@@ -159,6 +159,7 @@ check_var_migration () {
 }
=20
 check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
+check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
=20
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
--=20
2.18.0.windows.1

