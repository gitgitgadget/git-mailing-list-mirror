Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0E01F403
	for <e@80x24.org>; Mon,  4 Jun 2018 12:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeFDMjY (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 08:39:24 -0400
Received: from mail-co1nam03on0129.outbound.protection.outlook.com ([104.47.40.129]:45381
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752293AbeFDMjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 08:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXN3qjA5gk9b0lDD0tK2iLnZociNd2DVNrgbxkx5NtU=;
 b=BR3CgMj1BJ6ddQ1UsxqBGBBqY8FmXxwzujuTy8bwygwEuGLv8HKREBHJBba21uphrIhm1uClTEfS/5IvSHCFQDu++YUCTkWT0UAlLAwXPb+ysYuba8gdWckCir6x5Xjv/nq/x2JOxLT3HtE3QGRhM+t5XCoNUNWYpDYX9GtdGls=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1099.namprd21.prod.outlook.com (52.132.149.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 12:39:21 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 12:39:21 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] t5318-commit-graph.sh: use core.commitGraph
Thread-Topic: [PATCH] t5318-commit-graph.sh: use core.commitGraph
Thread-Index: AQHT/AEPEnnr73DWFkSPsWcU/QweWg==
Date:   Mon, 4 Jun 2018 12:39:21 +0000
Message-ID: <20180604123906.136417-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0004.prod.exchangelabs.com
 (2603:10b6:207:18::17) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1099;7:KiMbgnD0dBIsa7T1q27bZQLcqr2M62obmSFSSH+bm4aiyCVlo8omgQhscF9nIWx6xybFFrXDFQgJSaDbQF5Iper4N94iLwsfyeoiEtgJjd0sk8Bh/6DxZ0qh5SJMwMZq1ZtW96TnfXRWf7FeySybtcAYPFQxqqmRPqHgLw6TJzVIXlhj7TZv7cKad8anDAfj6JjFB4kjJ0X/97cZkVavUQ2+L0K/pg+apdMhkeeiJyKokPUMgzER6Crqb98hWFQP;20:EfyaPbUvE5a/mJ25pK5RwkVu9byhiMlbMSitdVrc0nLNVT7oSSANY8nT/Kz6Y5mqm397Ul8y/GeLA45LwNca6phlwM1J8Lr6tSeA3Ha5GufmjHJpQw8HfG6OPLp9ruB5oBzyMiKH7p7QcI5Yw0rj/xcdncM3ylBXu4ej39F1OS0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1099;
x-ms-traffictypediagnostic: MW2PR2101MB1099:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB109970A93694397D6AFB1FE9A1670@MW2PR2101MB1099.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1099;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1099;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(8656006)(86362001)(2906002)(8676002)(81166006)(81156014)(1730700003)(2351001)(8936002)(10290500003)(10090500001)(2501003)(478600001)(2616005)(5250100002)(6916009)(14454004)(6436002)(6486002)(5640700003)(6116002)(2900100001)(97736004)(105586002)(1076002)(5660300001)(486006)(36756003)(25786009)(107886003)(4326008)(476003)(53936002)(6512007)(46003)(3660700001)(7736002)(386003)(6506007)(3280700002)(186003)(1857600001)(22452003)(305945005)(102836004)(99286004)(52116002)(68736007)(86612001)(575784001)(316002)(54906003)(106356001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1099;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eqhPbDW9oHYFmT+xJYn/5GuZC6NC92VeIW/LYvWZ+lsryFHfMIvoWoimPTITrqcDzGfsOPVuBHbNG8MYHvv206AhjXoRdR505jorhzyz+YKhrt9ZPkJVNROT+8BplpNhAZ9kj7z5Ew8s6gzO0Mri6XNq6m7ND7VkHQQEwarYyBfb8As2f53dPK19358OFbpC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0b58f6ad-c27b-4355-d9b3-08d5ca1831bb
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b58f6ad-c27b-4355-d9b3-08d5ca1831bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 12:39:21.6776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1099
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph tests should be checking that normal Git operations
succeed and have matching output with and without the commit-graph
feature enabled. However, the test was toggling 'core.graph' instead
of the correct 'core.commitGraph' variable.

Reported-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 77d85aefe7..59d0be2877 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -28,8 +28,8 @@ test_expect_success 'create commits and repack' '
 '
=20
 graph_git_two_modes() {
-	git -c core.graph=3Dtrue $1 >output
-	git -c core.graph=3Dfalse $1 >expect
+	git -c core.commitGraph=3Dtrue $1 >output
+	git -c core.commitGraph=3Dfalse $1 >expect
 	test_cmp output expect
 }
=20
--=20
2.18.0.rc0

