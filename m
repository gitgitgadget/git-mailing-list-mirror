Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C3E1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeFDQwv (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:51 -0400
Received: from mail-co1nam03on0100.outbound.protection.outlook.com ([104.47.40.100]:45329
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751564AbeFDQws (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w/dpLfV5ZrEfXw0zTFmdmGXnsH1gMQxIvK3oasZha0=;
 b=hYmaBMUnT+ZHNf3PmK3sGDX3z/tJSwkJUM9fwxMBJ3h4XsADufwzT2RTl7mFFKiQB527ub2F71C8lQJTJNbWKnxMGlnE4MFCTTHcWPKRvK+vE4+C4haUwwAlbEnd73ZlJ+kSf+jW/KvnVjjxAGXraold7gM507mb3nyXwFFiZr0=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:46 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:46 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 14/21] commit-graph: verify commit date
Thread-Topic: [PATCH v4 14/21] commit-graph: verify commit date
Thread-Index: AQHT/CR2AXns7QRHV0C6RazegFLbDg==
Date:   Mon, 4 Jun 2018 16:52:45 +0000
Message-ID: <20180604165200.29261-15-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:Hq78hZnHa231un0iTvgxD135nXnFB/Mp6FjC5Mkw3w5iWDRvZqla1KOS/0ZaRaOzCrvJy3qPpJtlFdktBSuuVR3LUrX4zS+tyPjW8aIAfbiGANnDrb05hZqNjk/kz8+RClFcNasD/LCiNrGKd5juzSarpHB+KLsGsckY9G6/J8Lda61UClm0OxMgo2y8TfD9QThN+6AY0Uxtbls37b/3lQIQiFH+5ylPzcbU2SBHFGYH1frUwpVkRufSM9Vl2ZiE;20:1cD4gLxRaJyV7PNf9svlaGcKnTXWxtZJdVZfAGDbjcYjIHYzm5y3T8dOXy1DWArSBiaSrl1epy46CZpRh6gbNJbp6ZrIVGiW/zNzMT5dLhq2q+sxOGGushyFarmgrttk9yKZaZSHusJx8xp/54ffC91vQapAebSkSsd4Ypw4Uvg=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB112941A79D26ABF816541306A1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(15650500001)(6486002)(486006)(446003)(46003)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BKcrIVhYO6BGW0M6CHdeshoYPcqUymLuXQb7OClu/0f3Ivr9ZpZ0emV7/O0Hfamp4UIvMRY7WAsPRYFfeXPDWoADW6xB6KQgyi24MIeBoSGlSwxUqq/WAtD653ZG0UaskPqTc+Zhy60iu+6KeZa1TWqgGMKUGuPn0a10OCOsIQhARz7tjy3fal0JDb74GGV0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 14d86413-27d9-4cc8-7133-08d5ca3b988a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d86413-27d9-4cc8-7133-08d5ca3b988a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:45.9353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
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
index 5faecae2a7..47fdd62e88 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -982,6 +982,12 @@ int verify_commit_graph(struct commit_graph *g)
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
index a6ea1341dc..6a873bfda8 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -273,6 +273,7 @@ GRAPH_BYTE_COMMIT_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET=
 + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 3))
 GRAPH_BYTE_COMMIT_GENERATION=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + =
11))
+GRAPH_BYTE_COMMIT_DATE=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -377,4 +378,9 @@ test_expect_success 'detect incorrect generation number=
' '
 		"non-zero generation number"
 '
=20
+test_expect_success 'detect incorrect commit date' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATE "\01" \
+		"commit date"
+'
+
 test_done
--=20
2.18.0.rc1

