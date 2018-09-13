Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2500C1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeIMXLt (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:11:49 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:36502
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbeIMXLt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40NutjFjTgA1FaEK298MydrNsYvWGFv07fxGecG3C7s=;
 b=SdReu5+bITNV2pgl+Sy3V9FiYHkvWifuNSSl4bqB6J5kW1xl9yZDnK9Bu2Fivv3jfZURV2r03O9Mbp/E0l53s70u9jZWIQPm3JgVmurJNVfJXvgIoNEdNEnKu7OME/+inbyL/4Y0h8Q6SUQnf0WAfZ3HUcall2GNzJ+7D6Z26Js=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0906.namprd21.prod.outlook.com (52.132.152.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Thu, 13 Sep 2018 18:01:12 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Thu, 13 Sep 2018
 18:01:12 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] preload-index: update GIT_FORCE_PRELOAD_TEST support
Thread-Topic: [PATCH v1] preload-index: update GIT_FORCE_PRELOAD_TEST support
Thread-Index: AQHUS4vBJf4VJmkaC0ae4h9H7JlH/Q==
Date:   Thu, 13 Sep 2018 18:01:12 +0000
Message-ID: <20180913180054.29720-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: DM6PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:5:1c::19) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0906;6:2U6DQt3Cs8S980q+wTcB8kr7LRbn2i22XBDypng1EbzfwrzqD4VhVTJT3hwBOkF1/NW4pBlW6h7IvgFieU1kk9OFW7yp7ZRpk80BYlDmU9Vco9KCpXUvQ6wrMjACOUx2pi2nyODpB0yV7AS0LWUv0JRUXtqRGDGd0BdRZSjCGEjYaGTlvLD72DHiCPcUgwf0kkR5N5vhIezk8i4G03N3FZwLa/GGxOg8I6f0Usjt2Ju96LcJZYcmgVYbep4UlIVpFshdMYOnfhRbWw0VL7a6f0tJoT4lVqa1zCGKQ1fdi0/Qo4eONoupZWRnqDjl4jnYsvPLMtZE9VN/DAcSJFF2WBLZKwm9nJd9Ly/LayfUbrfKq9Kzm/6ODevFQeHipOxLjNkCB4PxttkmSBU7Ff65KgKxQvWwjHe39T+0wz8a1l11gC5rVRwjI2mrkEibKCCHpi9+fiUb0WbvbevOFsBlcQ==;5:CBpoDnrL7O5CU9u4qaFZh9mLm63QgDtND96D1FBovGitSvvYSlX3p8oZXea194XpKNfh8We2zHKd2ys+wktS7kMbOLQKVG6UlLNf2dmUcnqksfstll6Tm1b1JuFsQCStHUOPqJYu+ncn1N/sWpiG82sr6GT0QWaK0wnSohncpgw=;7:NGMy+ctm1uXzK9bBjmqK9uhn9j6FC1rxp2JvizHNnLskwvqjn0n4zxyPrpDPwPql56Lr479cqOsOltaF1xoygh5sLyFHHR4yx3qSrZ7N3D47K3NedFvJjKKrYXzSPpXloMtNO3YAO2yzoejgYqFUcCYPWcRKofRBvMqjZRWkCxUB0lgenN96ovPfYKZ1VFaXmP2tIz1izLxM+dvS9qv7heVEq9xjwVDtsIip98ImTI6wFrPXwV9Bwz3sok0Yk6Ng
x-ms-office365-filtering-correlation-id: 8afa71f3-000f-4dd1-1cfc-08d619a2e411
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0906;
x-ms-traffictypediagnostic: MW2PR2101MB0906:
x-microsoft-antispam-prvs: <MW2PR2101MB09062746A39EE76A714CA012F41A0@MW2PR2101MB0906.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0906;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0906;
x-forefront-prvs: 07943272E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(186003)(26005)(105586002)(106356001)(6346003)(6486002)(6436002)(5660300001)(102836004)(2616005)(25786009)(476003)(486006)(5250100002)(4326008)(2351001)(53936002)(14454004)(2501003)(256004)(2900100001)(6916009)(14444005)(10090500001)(10290500003)(99286004)(6512007)(6306002)(72206003)(5640700003)(22452003)(478600001)(966005)(97736004)(68736007)(8676002)(305945005)(52116002)(66066001)(2906002)(1730700003)(81166006)(81156014)(107886003)(36756003)(1076002)(575784001)(86612001)(50226002)(6506007)(386003)(6116002)(3846002)(8936002)(54906003)(7736002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0906;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: sMmNhLfgfn7KoPqvauQFrwVBMsIu38vmsiLZjIqDCvpod367JPArlKTui6v6glN4g5K3wO9/kqEftIm6d4aY378cGBdudLDWu1xXZRvIet/F+Ckr1b4kWh7TRbSCu4ejREBgtlmOrica94Hg+qujSQmPVulyQeivJ5abfUlHRyaaZXN2OdAL87WC9puBcEuuQv2QMWxmpvfP5QGM3Va4FJCqcHRGPqd/2n7doddQVPsyisFwWvlD7DHM9yHx287EQervB1o8Kdf+qFKE9ymmcPBBxF+f//IduW1CrPUtGfDVwTUE/R955+e9pU/EDrdvr2kxCNocDONy3bKrGfKjn2+nFE9Tojt74VtINi+ySB4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afa71f3-000f-4dd1-1cfc-08d619a2e411
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 18:01:12.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0906
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename GIT_FORCE_PRELOAD_TEST to GIT_TEST_PRELOAD for consistency with the
other GIT_TEST_ special setups and properly document its use.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: v2.19.0
    Web-Diff: https://github.com/benpeart/git/commit/dcd201b920
    Checkout: git fetch https://github.com/benpeart/git git-test-preload-v1=
 && git checkout dcd201b920

 preload-index.c             | 2 +-
 t/README                    | 3 +++
 t/t7519-status-fsmonitor.sh | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 71cd2437a3..cc8a7333c2 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -84,7 +84,7 @@ static void preload_index(struct index_state *index,
 		return;
=20
 	threads =3D index->cache_nr / THREAD_COST;
-	if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_T=
EST"))
+	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_TEST_PREL=
OAD", 0))
 		threads =3D 2;
 	if (threads < 2)
 		return;
diff --git a/t/README b/t/README
index 9028b47d92..73fb09560f 100644
--- a/t/README
+++ b/t/README
@@ -319,6 +319,9 @@ GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncomon pack=
-objects code
 path where deltas larger than this limit require extra memory
 allocation for bookkeeping.
=20
+GIT_TEST_PRELOAD=3D<boolean> exercises the preload-index code path by
+overriding the minimum number of cache entries required per thread.
+
 Naming Tests
 ------------
=20
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 756beb0d8e..9b703d49b5 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -245,9 +245,9 @@ do
 		git config core.preloadIndex $preload_val &&
 		if test $preload_val =3D true
 		then
-			GIT_FORCE_PRELOAD_TEST=3D$preload_val; export GIT_FORCE_PRELOAD_TEST
+			GIT_TEST_PRELOAD=3D$preload_val; export GIT_TEST_PRELOAD
 		else
-			unset GIT_FORCE_PRELOAD_TEST
+			sane_unset GIT_TEST_PRELOAD
 		fi
 	'
=20

base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
--=20
2.18.0.windows.1

