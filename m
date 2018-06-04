Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F131F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeFDQxf (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:53:35 -0400
Received: from mail-dm3nam03on0097.outbound.protection.outlook.com ([104.47.41.97]:18336
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751575AbeFDQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U7qIi7dVBXe3dxhah4yC15leChdiDdu1sKmnSIrRyI=;
 b=d/GOGpDc7HxvAuPbYhdsV6cyGZlaqvgd04e5DTMTlumzxSBnzfk5LwrfcNdmQYf/uz6X3Sjak8WuwPtIIb8y/fJ6wTzLPDgYjQmTbYYR7Hjp+uVl9fl9L4XkfUUr4OE2MasthvxcrXNZE4/2gz2wwGzMZ82d6L52IbL8Vj6N9W0=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1081.namprd21.prod.outlook.com (52.132.149.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.11; Mon, 4 Jun 2018 16:52:48 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:48 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 15/21] commit-graph: test for corrupted octopus edge
Thread-Topic: [PATCH v4 15/21] commit-graph: test for corrupted octopus edge
Thread-Index: AQHT/CR346vXjBfASUWcs5tS0Ic+kQ==
Date:   Mon, 4 Jun 2018 16:52:48 +0000
Message-ID: <20180604165200.29261-16-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1081;7:ZBKl+Igrv/ZCOoIy/nqdb6XvhcI30phIaWT8bDD7JVrdrqMLmhe+soT/vQ1A044nAN9dxXSoFFy6Rr3PSGETOJu9oVH/J4ZOpkTufXfTp5Si/8Z9UW+0Bm4/nx1fQikaSbA7UxJemnT5ixoGW7mD9jLxnZYTDrbh44q3ps4cUb3+HmDuJYrvJryeLKPq+dG0rxn8nRfOYcCh5So9sGmQBAf8Yjq6uCZyaR9B3FEE1DXmghUrYSbNLTmTOZnYyJHa;20:YJ3jXVSWZGpWu/qedzyY1te6hlAjKpKBPlt8ewMnEmbpvqQ4kIkMVW2xcp5X77gSS6XaYzDNxoYfYwto4RsqsGxCkUFRTC9AIuZzHR2SHCNhXV2jnTRO19T6Cv5DxZnUS1vW4ozdFtGdoVNM2+NCJFNZfla8nLvChN0SXZpmI5k=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1081;
x-ms-traffictypediagnostic: MW2PR2101MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1081CD9ECC6787AF8BEC84F8A1670@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1081;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1081;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(199004)(189003)(81156014)(486006)(8656006)(102836004)(6512007)(316002)(3280700002)(14454004)(1076002)(54906003)(186003)(107886003)(6116002)(478600001)(3660700001)(39060400002)(2616005)(386003)(2900100001)(99286004)(476003)(6506007)(10290500003)(59450400001)(86612001)(68736007)(11346002)(446003)(52116002)(76176011)(86362001)(2906002)(53936002)(22452003)(36756003)(25786009)(6916009)(5660300001)(5640700003)(2501003)(97736004)(2351001)(4326008)(46003)(105586002)(6436002)(106356001)(10090500001)(6486002)(81166006)(8676002)(305945005)(5250100002)(8936002)(7736002)(1730700003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8jNPPKMte15ivyEG6U5K3y4sPHRkTk7jHXpY9vlhNU3jqsQb2nBOSkecm+nKTI7kP1KZ0IvjTDofX2SqSRpR6Og02tIkbcupV6ygyrWYiW1iKcjomvA6ZH+do16iRwfWuHst/qHd+NQNLyvnrllL0Rv6S6PX1dz4Ufwg+X4BBtWddvDNMFBO3lJ6v14n4voe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5f052b1f-22b2-4345-12c7-08d5ca3b99f0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f052b1f-22b2-4345-12c7-08d5ca3b99f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:48.2009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file has an extra chunk to store the parent int-ids for
parents beyond the first parent for octopus merges. Our test repo has a
single octopus merge that we can manipulate to demonstrate the 'verify'
subcommand detects incorrect values in that chunk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-commit-graph.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6a873bfda8..cf67fb391a 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -248,6 +248,7 @@ test_expect_success 'git commit-graph verify' '
 '
=20
 NUM_COMMITS=3D9
+NUM_OCTOPUS_EDGES=3D2
 HASH_LEN=3D20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
@@ -274,6 +275,10 @@ GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D$(($GRAPH_COMMIT_DATA=
_OFFSET + $HASH_LEN + 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 3))
 GRAPH_BYTE_COMMIT_GENERATION=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + =
11))
 GRAPH_BYTE_COMMIT_DATE=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
+GRAPH_COMMIT_DATA_WIDTH=3D$(($HASH_LEN + 16))
+GRAPH_OCTOPUS_DATA_OFFSET=3D$(($GRAPH_COMMIT_DATA_OFFSET + \
+			     $GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS))
+GRAPH_BYTE_OCTOPUS=3D$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -383,4 +388,9 @@ test_expect_success 'detect incorrect commit date' '
 		"commit date"
 '
=20
+test_expect_success 'detect incorrect parent for octopus merge' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OCTOPUS "\01" \
+		"invalid parent"
+'
+
 test_done
--=20
2.18.0.rc1

