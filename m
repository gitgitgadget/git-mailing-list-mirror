Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1850D200B9
	for <e@80x24.org>; Thu, 24 May 2018 16:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033619AbeEXQ0O (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:14 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033605AbeEXQ0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV/0j15UefISSHtEjISCMeJjUO3xRHIa78/m6R2wHiQ=;
 b=Ac/SNpJFhM85bK3jStBw7ztFY4TrgwZsoIGmKticsXm9kpbtNX0uKCTagkEIZOjn9dnXH5VTJTGi8PfzvIy2B2FAlHqL3GfSAXbGMfCCiuV0r73b8YxX2o1hb66M46fSHC3PyR6mWATv1nQfdx+tYWjWpLqIeX8wJ4/4qZWqsYA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:58 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:58 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 14/20] commit-graph: verify commit date
Thread-Topic: [PATCH v3 14/20] commit-graph: verify commit date
Thread-Index: AQHT83vktvMY2VHEOEGY0+FVQLTfFg==
Date:   Thu, 24 May 2018 16:25:57 +0000
Message-ID: <20180524162504.158394-15-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:dMQWXUFgxxzLt7gqmpa7XQSAn+GHzT66P0BLjHscHBIAXgGlYVTCCb0XrJ1vJZeVGQCIreaWbao4F6Gjt5QoNsp1sK7TQztubbeBy7D0Uv+NtnBdgqsr8bXHEXG3oVvuXq9kT9CeeKq+Qm0207IsvaCd7GeUqf4EGBRMKpQ91W+tWNqdXlCJKqTqMEyreRkJYNjCmnr/kD7mS3yFly12yJog07DzdSQoRhaEOha6S+NF52tS+SkDN0P/vC2F/bKK;20:/7xOIxpe1Va8tK4A9a26EglsC+CU569qro5VhJv5qAWsjigVkkooZO8kgpIQa+7UvxDmJ3iNTu+/PqG3by7iMXTVXNY1XKlx4gEVe/zZ+kjQy/tKEcczs9pdDUzdDQ3J6a9v6012kkpNGzKkxn9EBUFt9IGgQuntLaj0PVRrB4c=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10915D86F2DBA89DA4DBBD17A16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(575784001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(15650500001)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z8qrBNwPVa910dpTyzi5miiY51GUZWYcZHhratdkFbXamKH5VAfu416g6Ha4SKcuEfGrZ0I0tX+CgYJhhjeySG6ZbQ5Gpa1BKANKo6q7vbsaAoHeds705Gw8XaNGd+bHE4j4w04yoF2Sw9OMon2BHqAOM/Anl7fW9YZYKRmjMtipg8q/+4kcmGPtnrP/hEC2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9ee5d3e5-f145-47a6-e587-08d5c1930703
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee5d3e5-f145-47a6-e587-08d5c1930703
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:57.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 6 ++++++
 t/t5318-commit-graph.sh | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index ead92460c1..d2b291aca2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -981,6 +981,12 @@ int verify_commit_graph(struct commit_graph *g)
 				     oid_to_hex(&cur_oid),
 				     graph_commit->generation,
 				     max_generation + 1);
+
+		if (graph_commit->date !=3D odb_commit->date)
+			graph_report("commit date for commit %s in commit-graph is %"PRItime" !=
=3D %"PRItime,
+				     oid_to_hex(&cur_oid),
+				     graph_commit->date,
+				     odb_commit->date);
 	}
=20
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 673b0d37d5..58adb8246d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -273,6 +273,7 @@ GRAPH_BYTE_COMMIT_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFF=
SET + $HASH_LEN`
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_L=
EN + 4`
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_L=
EN + 3`
 GRAPH_BYTE_COMMIT_GENERATION=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN=
 + 8`
+GRAPH_BYTE_COMMIT_DATE=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12`
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -372,4 +373,9 @@ test_expect_success 'detect incorrect generation number=
' '
 		"generation"
 '
=20
+test_expect_success 'detect incorrect commit date' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATE "\01" \
+		"commit date"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

