Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6721F453
	for <e@80x24.org>; Tue, 18 Sep 2018 23:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeISFFP (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:05:15 -0400
Received: from mail-eopbgr680135.outbound.protection.outlook.com ([40.107.68.135]:62861
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeISFFP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2ZAUas1R1x9ghC1R3CXa7mEQdIoIKZLfSNyJy06Lq8=;
 b=G7Z7uqo4tn9jHF992yv5keA2RqGyqdNVm1T9plU6X4BIed4LDWaiHApNZBLhZ8pvprxiA6EVaYeoa86yTJE84nlGxIojBD0SU90iTiWuEGzY9AGn9TzrXtQIGpUPUBeKRuakTSUUnnfMB6zeCyh2mjNjeLd6p94sl3tVAibJoJs=
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) by
 BL0PR2101MB1092.namprd21.prod.outlook.com (52.132.24.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Tue, 18 Sep 2018 23:29:37 +0000
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be]) by BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be%2]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 23:29:37 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 5/5] preload-index: update GIT_FORCE_PRELOAD_TEST support
Thread-Topic: [PATCH v3 5/5] preload-index: update GIT_FORCE_PRELOAD_TEST
 support
Thread-Index: AQHUT6d2t0DJog0CkU6eOsR67IUsuA==
Date:   Tue, 18 Sep 2018 23:29:37 +0000
Message-ID: <20180918232916.57736-6-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;6:owmucT3YfLml75ZXrAkQwE3a5NKGn5+cupAi7yyEASyqxwkuq5tNaPhuO4JZKuknafRB8Tl7hSMQtjP+9e2URbSXxG9vBSQxYbz4jtk0pT8QCg3BuFCB7LsodiRUp9BZ+nUhQiMQcQpJ+NWwxtlJb85sUttFchGVPWiOPhXnNcvJyPKyOx8ANmZiEM37dvf12DmdR2TtaymaPadLUfEfxGo54zvdeWGfTNRrbMtDZ6WAO1aajmtuDDoLCIkvL1ZXjlaMzsOY5JHrOfs0g4Lk/wlEEQZ+9UEdUwPIB2eEsMVsqZH5phhnSqp6fSgdX83Ygh/3P9WDC7lF7/9Bhy47/T3IvZZt/CAG2dLwWXuxopxhVZAplzJ3811pJBYpZ350FrYEZ21EZBQ4ga5icFR7MBa4iHrE+IduEpmYtEr7CeAKmO7IoxPdPQo729Z9Yulw6xRzEI1o6FtEqJNHohoiaQ==;5:mJAWTlmWJ5eiNnTNvG0UDv0UOR4Aahiergw6e6XTmKLUcC/7ldjibHmoMUwcBXPyt2T3zJOonyD1nk7S5UsYroyQLwq4oQokF6uXwe4+1tVi/xhynHHOafX7N5SvGIK3Fgwz3NMViUPIhNlL0V3IajKqOeXyLWJtumTAOb/Zen8=;7:DfqYJHy4BvvLmJPlsG1AICeVdaMgkSXeCqnBZzTFrsF7eVAT3y4iMzEa+2gFsd+PvIfaa/uNWxNKdFwUmoUNExWrHozkc70b3Gjjr2OX3Qtl6scX9UeZIpRFqgFRCPqhk46AzTDRnLqvLNQDuj5Acw9EkARDXngR/rTfZDlolroyeqsaOGmjdcA5TBl2eTNUhn6+rXed0z6Q9NWLVHNTPEK748QltaRDBOA+wNRG6AmoKUPfsL8z3q3MRZ7bdE1R
x-ms-office365-filtering-correlation-id: c1e2c68e-6ea9-42e2-2c1b-08d61dbe98bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10923EEC1D0EC52FC736753EF41D0@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(186003)(14454004)(8936002)(316002)(81156014)(107886003)(39060400002)(15650500001)(102836004)(2501003)(7736002)(36756003)(476003)(256004)(446003)(14444005)(486006)(305945005)(5660300001)(2616005)(26005)(10090500001)(22452003)(106356001)(81166006)(2351001)(105586002)(11346002)(6916009)(5640700003)(1730700003)(6116002)(54906003)(3846002)(1076002)(6436002)(6506007)(2906002)(6512007)(6486002)(68736007)(386003)(8676002)(97736004)(478600001)(72206003)(52116002)(6346003)(10290500003)(4326008)(5250100002)(25786009)(66066001)(76176011)(99286004)(50226002)(53936002)(86612001)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB0962.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: sE0fJNMk/Zcov/+ojk0yQpB1Q2nzftNk+k6UwZVdbDDSGQT32QGEWlxsWdDc3BkFW3q3+wNikiFYsjCL0X+1rPrGiSdPktu2jgxlBKlsdjewhlXIjvsOWRmNytNpeRowLniKAP/6b1EpXpQ9EYrGAgWKODP4799ZKvv8NQrsouH/uWtqYxydg1FnISXgEvzSu07pfOAa0aNgPi92+8KZVCWA3U5Vj9h7R/3DEPTjRRUsnsnSq6Tl/mz7AmErYBekieWaug+vIiPkrF4o+N5+bpt8IJBbUwUag6hyp0FhQoQlyUFJw1sWq6i6j0B6j9u1c1CrIs3LmXXGP4YsnyvxsDe4+MXNfol5DSZzLMD/oec=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e2c68e-6ea9-42e2-2c1b-08d61dbe98bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:29:37.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename GIT_FORCE_PRELOAD_TEST to GIT_TEST_PRELOAD_INDEX for consistency wit=
h
the other GIT_TEST_ special setups and properly document its use.

Add logic in t/test-lib.sh to give a warning when the old variable is set t=
o
let people know they need to update their environment to use the new
variable.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 preload-index.c             | 2 +-
 t/README                    | 3 +++
 t/t7519-status-fsmonitor.sh | 4 ++--
 t/test-lib.sh               | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 0a4e2933bb..a850e197c2 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -85,7 +85,7 @@ static void preload_index(struct index_state *index,
 		return;
=20
 	threads =3D index->cache_nr / THREAD_COST;
-	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_FORCE_PRE=
LOAD_TEST", 0))
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
index e80c84d13c..8ef86e05a3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -154,6 +154,7 @@ check_var_migration () {
=20
 check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
 check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
+check_var_migration GIT_FORCE_PRELOAD_TEST GIT_TEST_PRELOAD_INDEX
=20
 # Use specific version of the index file format
 if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
--=20
2.18.0.windows.1

