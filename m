Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065701F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031107AbeEXQZ6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:25:58 -0400
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:45289
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030897AbeEXQZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg7wji4NAyPvYbnZVhkVI0thtPhE5k3WZdq50N6urGI=;
 b=k5UvRHJcBfvRdRxzC9W4w+cknaIMSB9A1AmlR1keBEIlEuT2s8Iruwtm/xtxQyyK/GykxMAdOzeb3SMXDw5afZuHSxB5GTpQA89UicTR/QcnxgsDMeasdbHJVT96egDKHe726hu2xAOaFaYlu2+Hv6CPMSpf/In2WJVpufmSIUU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:43 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:43 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 08/20] commit-graph: verify required chunks are present
Thread-Topic: [PATCH v3 08/20] commit-graph: verify required chunks are
 present
Thread-Index: AQHT83vcgRMtxL0phEaEntuX7RI8wA==
Date:   Thu, 24 May 2018 16:25:42 +0000
Message-ID: <20180524162504.158394-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:pWjYVHVxUBV18H5Q2trKrDecMlwVYIfTFKIxYFvZcz6HbBURPfhO/VQ7bUKiR7sTghOGkqj6Ibf0mFPwN0nDxUfiFjzjulf+trv+/UDMZKsvVpmH5SrDMjXFCevfoiVqdRwTai0ZalQSeHb3rzXYMImSSCqncBqBX+zQaD/hPSk4ZDOp86vv/WVfdOL346va6yyO7CLzmE35E8fZU+fgettycCDcvbcN535wlPv6Usljm/mkH2IBJft/TJ27NDyO;20:HEXOa/t7GEvRZbbkTFZV3Npj2AEyIpsPwN77FwnSXkA3k9SGXRN+PqnDMAFKt0S5XG2K3uZQYUWumDB5jsu3FeZ9S8pHvd09s/isie0HQz3NawlXBTWY6xa1ZqTUA+YhNDdIWvm9C5+0TaLXx8tPJtjHxJQw+U/LYBKagWrAyes=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10919462AB0E447F1D802B7BA16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(15650500001)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SBXRD+MCHuredMaxw7DvO0XV+1fIfomLuYf2coyCVezvdcOV3MM+w9rJopfuaU/Z6mi70t/pGqrtJfJAMEjZjbjM4OW6IxbT4lMc3rTBzS2FytSm7mfnoNsl5yS8hmmAD+fc+G4ZHh9oqVVt3rBjJVD8LlgECMweRumUhLVdEiNT1PpuxNEjxViL8XWDiiA/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: eb62c675-edd4-4193-cb33-08d5c192fe95
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb62c675-edd4-4193-cb33-08d5c192fe95
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:42.9713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file requires the following three chunks:

* OID Fanout
* OID Lookup
* Commit Data

If any of these are missing, then the 'verify' subcommand should
report a failure. This includes the chunk IDs malformed or the
chunk count is truncated.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          |  9 +++++++++
 t/t5318-commit-graph.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 55b41664ee..06e3e4f9ba 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -860,5 +860,14 @@ int verify_commit_graph(struct commit_graph *g)
 		return 1;
 	}
=20
+	verify_commit_graph_error =3D 0;
+
+	if (!g->chunk_oid_fanout)
+		graph_report("commit-graph is missing the OID Fanout chunk");
+	if (!g->chunk_oid_lookup)
+		graph_report("commit-graph is missing the OID Lookup chunk");
+	if (!g->chunk_commit_data)
+		graph_report("commit-graph is missing the Commit Data chunk");
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index bd64481c7a..4ef3fe3dc2 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -249,6 +249,15 @@ test_expect_success 'git commit-graph verify' '
=20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
+GRAPH_BYTE_CHUNK_COUNT=3D6
+GRAPH_CHUNK_LOOKUP_OFFSET=3D8
+GRAPH_CHUNK_LOOKUP_WIDTH=3D12
+GRAPH_CHUNK_LOOKUP_ROWS=3D5
+GRAPH_BYTE_OID_FANOUT_ID=3D$GRAPH_CHUNK_LOOKUP_OFFSET
+GRAPH_BYTE_OID_LOOKUP_ID=3D`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
+			      1 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
+GRAPH_BYTE_COMMIT_DATA_ID=3D`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
+				2 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -283,4 +292,24 @@ test_expect_success 'detect bad hash version' '
 		"hash version"
 '
=20
+test_expect_success 'detect bad chunk count' '
+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
+		"missing the Commit Data chunk"
+'
+
+test_expect_success 'detect missing OID fanout chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_FANOUT_ID "\0" \
+		"missing the OID Fanout chunk"
+'
+
+test_expect_success 'detect missing OID lookup chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ID "\0" \
+		"missing the OID Lookup chunk"
+'
+
+test_expect_success 'detect missing commit data chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATA_ID "\0" \
+		"missing the Commit Data chunk"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

