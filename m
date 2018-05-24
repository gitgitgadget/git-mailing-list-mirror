Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BF71F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031050AbeEXQZq (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:25:46 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28256
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030881AbeEXQZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N/SOcy2YI5fDzbncTGp0nI6hgwnefdgSIFSufQ/SUs=;
 b=GgU5ka3pP256WyDjwEdVbSxMvCp5KwNvb2wXT8qJRwvD273JZsBTagswO4WntBdL3lBemY37LHDqL7d+lY/nuiupULeVRsw2O9DHdtJrXMJLkSEJIu7l066sj+tlPJeFAE6UoihjvASKBKpd4a2ZIaFz7L9wA17oVjMgIgSzcyc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0882.namprd21.prod.outlook.com (52.132.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:31 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:31 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 03/20] commit-graph: parse commit from chosen graph
Thread-Topic: [PATCH v3 03/20] commit-graph: parse commit from chosen graph
Thread-Index: AQHT83vVn5ei4JMu6k25IHIBzITivg==
Date:   Thu, 24 May 2018 16:25:31 +0000
Message-ID: <20180524162504.158394-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0882;7:Vwp1gf+Ys8coUNTPewy20iiWhLjso0Fv/52IETz2pcYhd2MpabJyBCQaecDBdO3/E3sRvZwC5CEIHxLu1c6JAJVBnyY+XEKIcfJw19f5BTb3lcX4o9tCT91fAPll4zf7qhYkULIo6vvOCCLg4U0otm4NS0yEMdHvo3QJIHzb4xzYN16/07468u3pFbHv5hBiZNYam/6pEAG0D2mOaMN61c84/sb4HkNWZtQtVgk0D/LEXV+r5VgFMiaqbC2Kqh39;20:lVpk0lLrMOSMEob8XRE069pFs9RcegbrjM5oJo7a6v85YgC8dlsfifK4qglvwfexIOipRKIdr+6xi/AMMilY8437MfCbhyni4AEFrR8a6sS0ExpuEI0P/vDAbFdPVrMyJPKz3YRzIU1exZefVn7Z/2W17kg4uULaubcY/feJe40=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0882;
x-ms-traffictypediagnostic: BL0PR2101MB0882:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB08829C246D81708EE39BAD67A16A0@BL0PR2101MB0882.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0882;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0882;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(36756003)(6116002)(107886003)(1076002)(6486002)(5250100002)(2501003)(6916009)(5660300001)(97736004)(316002)(99286004)(10090500001)(8656006)(6512007)(53936002)(54906003)(39060400002)(22452003)(4326008)(8676002)(2906002)(102836004)(2900100001)(1730700003)(81166006)(81156014)(2351001)(386003)(6506007)(3280700002)(476003)(2616005)(5640700003)(486006)(52116002)(14454004)(46003)(6436002)(25786009)(11346002)(86362001)(86612001)(575784001)(446003)(305945005)(186003)(10290500003)(105586002)(7736002)(3660700001)(68736007)(76176011)(8936002)(106356001)(478600001)(22906009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0882;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zXpqX0fBtJ8vKzAp2BoqjtWAw9aYjDShdLIoOXgNjjF4Eq916+nF+SfO12G5ZGm45XmjInjP7dxtWLk4stbLUodjoTJj0qg3wQQbw1c3s95dHdE8H+X8ubRhY4no8gkaGPnU+SHUWr/3V/WHnoki/O7GbiVmyBXkEtspvC3LkCKhYyi2M9b2ZmbiKJJz0XQH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b5d57d87-c1b5-45b9-e72d-08d5c192f7a3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d57d87-c1b5-45b9-e72d-08d5c192f7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:31.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0882
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before verifying a commit-graph file against the object database, we
need to parse all commits from the given commit-graph file. Create
parse_commit_in_graph_one() to target a given struct commit_graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 82295f0975..78ba0edc80 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -310,7 +310,7 @@ static int find_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 	}
 }
=20
-int parse_commit_in_graph(struct commit *item)
+static int parse_commit_in_graph_one(struct commit_graph *g, struct commit=
 *item)
 {
 	uint32_t pos;
=20
@@ -318,9 +318,21 @@ int parse_commit_in_graph(struct commit *item)
 		return 0;
 	if (item->object.parsed)
 		return 1;
+
+	if (find_commit_in_graph(item, g, &pos))
+		return fill_commit_in_graph(item, g, pos);
+
+	return 0;
+}
+
+int parse_commit_in_graph(struct commit *item)
+{
+	if (!core_commit_graph)
+		return 0;
+
 	prepare_commit_graph();
-	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
-		return fill_commit_in_graph(item, commit_graph, pos);
+	if (commit_graph)
+		return parse_commit_in_graph_one(commit_graph, item);
 	return 0;
 }
=20
--=20
2.16.2.329.gfb62395de6

