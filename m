Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3322A1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 23:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeISFEb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:04:31 -0400
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:52352
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726971AbeISFEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaNKialn2GcdkZ2bMzu1cvVVzYdow/fRsAijAx31pVg=;
 b=WQOZqk5XX/6f5MpKKV80tDRB5gKhcqC6JPIAYQIULMDz6yV6MwLwB0Hoo5Rk3yVeIVdKCfRKK+aWrKyBVl74Atn0jcvTSTAO1mKfW7O+VG9o87zkjsTJtNjYagjWELezqs/gXQ1/3CwP5uApmExfXiQZwI93T5c0Pkn9yYO4HfU=
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.6; Tue, 18 Sep 2018 23:29:33 +0000
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be]) by BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be%2]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 23:29:33 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 0/5] Cleanup pass on special test setups
Thread-Topic: [PATCH v3 0/5] Cleanup pass on special test setups
Thread-Index: AQHUT6d0WkUM1rUAzESEFiAOJ89n9A==
Date:   Tue, 18 Sep 2018 23:29:33 +0000
Message-ID: <20180918232916.57736-1-benpeart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
In-Reply-To: <20180914143708.63024-1-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;6:EMENqjZO7Co8tCocZRVdbQ+FHE7zMJ132sqN+gnnsLJfjvdAoXbbh40/IyATrGy5I8L6VciHbqYBTjUiW5XiJCsGOK2zQ0jr8XKP9ksQzk5qlJb+5Ilp4rsqXZzRIao9/x1LoqSUvBo7eiYUKV135B0fDcgrS/MdoOYTG6KN0swFlLN4TU7W/5pCa+1FGNixBb/KIGD/bxJrJ4hhvj1KuHiM3fI418qnd5JSptV7TV1gYgIFGyo9zgZNRDoTpgfdUqvq7INXjamUSxr0hKLAhFI/JYgiG09zyAaXQR7rKoWWrlyMMl8LlSa6fqjr4ypXBTWVxF7in+FreWn7gj4ItnHX9ObLY79CY9fN2JeublZMThNY1aX06KVIDLcqLZvGqY2E6wN0UwrSX5yehNCcDJK+s9qq3qWkiUoff9Hb84/K+cCJa/0tYhEqPsXDWo5tO/KVZ3liRbCaDu6qCQ8GWg==;5:qOYHjSYbpcVwujjoXlJmCDOKKAr9N/VTIBLkFoTI/dsyFwkqTOFFM69j7C6bVWGAPVHYilDLcjfCctZIdKRnB7ulBuF3mnb76XiR3idkqXe7/dTiYH3PYVz8eR0c8FSY+jqlQKzIa3T7ZvtEkgeFB9lyNSkJjaK3EjGOtCAMjwc=;7:AyeYB3pybIt1FEPwMIo7F6RIOfZ08PiiZkuT4/TKS85XXlTagPOgdSNBtkwJh5uBK10osRyepjlSThz8b8ofQE9CTlitQZT0K62ru4H49bb7sKvuBR3e1oGlG0gN/dsMyLbttFzCcE8gh6qExMrtj87+BSskiLKic8EVpoZe8hJ+vrlRK0+m60KGAgW5Pjk5RWsaafMzfZ4FuI+FVrpH3bJo4sFomPyk/T3Qum5rqSbb/1GDeLz71YP49DmB/Tef
x-ms-office365-filtering-correlation-id: ba3edd31-b023-45db-08b6-08d61dbe9693
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-microsoft-antispam-prvs: <BL0PR2101MB0994914370234A8BA0D66076F41D0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(189003)(54906003)(14444005)(68736007)(2616005)(2906002)(86612001)(5640700003)(476003)(11346002)(256004)(6506007)(386003)(102836004)(8676002)(3846002)(6512007)(50226002)(36756003)(6116002)(446003)(316002)(486006)(575784001)(6916009)(6306002)(1076002)(2900100001)(8936002)(66066001)(10290500003)(966005)(5660300001)(81156014)(478600001)(1730700003)(72206003)(186003)(14454004)(99286004)(26005)(105586002)(52116002)(53936002)(2351001)(4326008)(81166006)(6486002)(2501003)(97736004)(107886003)(22452003)(76176011)(106356001)(5250100002)(6346003)(39060400002)(10090500001)(6436002)(305945005)(25786009)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB0962.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: EcMfO6xFn6NctLYRo3nGR38WtWRxgrdu+MeqgDGw1+EQXRGDTyyYSCAz5f8LOdumlsJ1177e3LMfutrHK1XCgUXLRY91hrpMcVoXEKFx5uibYRkVufHsTn0PdKZFj7uJehSo/6cTfvLpm+6xe35CTxv05OiVbTUq2mBk87XQlFlzmcRHRQKywiMwXSM38/E15GkHGQjJ2LDNWVbA3LlxhT3lZ/aSHOFzK7lL4UjpjqKODlkVkClAXIPxGdePprne/XoUCWs83CsvkNOgQRKAJ67Zj8Awhyxa/FADpMqeCaiqlMwKr1MpRLHmY0snglDSWIlCh2nSVxgRtwUM/7KMjZ0iF9ftjQ3GtMwjp3pwjts=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3edd31-b023-45db-08b6-08d61dbe9693
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:29:33.6557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This round has one code change based on feedback. Other changes are just
rewording commit messages.

Base Ref: v2.19.0
Web-Diff: https://github.com/benpeart/git/commit/043246d936
Checkout: git fetch https://github.com/benpeart/git git-test-cleanup-v3 && =
git checkout 043246d936


### Interdiff (v2..v3):

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 17a56f44ad..8ef86e05a3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,12 +134,6 @@ export EDITOR
 GIT_TRACE_BARE=3D1
 export GIT_TRACE_BARE
=20
-if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
-then
-	GIT_INDEX_VERSION=3D"$GIT_TEST_INDEX_VERSION"
-	export GIT_INDEX_VERSION
-fi
-
 check_var_migration () {
 	old_name=3D$1 new_name=3D$2
 	eval "old_isset=3D\${${old_name}:+isset}"
@@ -162,6 +156,13 @@ check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONI=
TOR
 check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
 check_var_migration GIT_FORCE_PRELOAD_TEST GIT_TEST_PRELOAD_INDEX
=20
+# Use specific version of the index file format
+if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
+then
+	GIT_INDEX_VERSION=3D"$GIT_TEST_INDEX_VERSION"
+	export GIT_INDEX_VERSION
+fi
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||


### Patches

Ben Peart (5):
  t/README: correct spelling of "uncommon"
  preload-index: use git_env_bool() not getenv() for customization
  fsmonitor: update GIT_TEST_FSMONITOR support
  read-cache: update TEST_GIT_INDEX_VERSION support
  preload-index: update GIT_FORCE_PRELOAD_TEST support

 Makefile                    |  6 +++---
 config.c                    |  2 +-
 preload-index.c             |  3 ++-
 t/README                    | 13 ++++++++++++-
 t/t1700-split-index.sh      |  2 +-
 t/t7519-status-fsmonitor.sh |  6 +++---
 t/test-lib.sh               | 27 +++++++++++++++++++++++++--
 7 files changed, 47 insertions(+), 12 deletions(-)


base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
--=20
2.18.0.windows.1


