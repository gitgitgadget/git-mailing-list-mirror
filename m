Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B446A1F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755874AbeEaRl3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:41:29 -0400
Received: from mail-dm3nam03on0139.outbound.protection.outlook.com ([104.47.41.139]:61214
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755818AbeEaRlW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWRP/bUi1FVtZjDEznAcImsFtZINH95urEM/rqzSt+s=;
 b=hGit0BtRG816HtoLBBkkHjxKvHMYpoNmKQQ85itSLJYCsyksi6Wa8/RcfxHE6uTliauW6vUAyVCh4CxCA/QBQ+6JdDysNAg5bQ5F/1HKrKblmP5h/oXZtR5KWqPlp7XOjkpDHncwAQ2QkK0ztD0dsSrf9KmzKKLtkKF5kFLYGkg=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0996.namprd21.prod.outlook.com (52.132.23.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.841.6; Thu, 31 May 2018 17:41:20 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1%5]) with mapi id 15.20.0841.006; Thu, 31 May 2018
 17:41:20 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 6/6] commit-graph: revert to odb on missing parents
Thread-Topic: [RFC PATCH 6/6] commit-graph: revert to odb on missing parents
Thread-Index: AQHT+QaUUeW/YZgZr0+knxfKROiRrQ==
Date:   Thu, 31 May 2018 17:41:20 +0000
Message-ID: <20180531174024.124488-7-dstolee@microsoft.com>
References: <20180531174024.124488-1-dstolee@microsoft.com>
In-Reply-To: <20180531174024.124488-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0996;7:Z9U7kBwuUbD7Gj5x9BwQBo2CtnAhRlhS4KZue8w5Xf302UM3wtkhy3f88bfJ1qazmnDON0Q/7lzJH+W5yf/M00YvRcbuotl50QLXGIBcyZlnBnjFnrGi+uP9xi5JRBOu9o22aoB80TqOneG/KrVMvDiB1wDUYE1GduYhhOEruP+x28DY3I5EwJaCR71M0dKulwSn0YFO4Ttof+4Fldvr/u+nCNkP2Odi+UXku/9HGWmOCdMBTq2+lITz+JegAv71;20:L+z+O6+PtY5Y7hb1t8V4Napo9UZRvDOQDASktX6zXeINnUIBkiGnh1FcJhumiRc+XAUOcW/L1lwi5WTa+GfzM9zETlR8szvgLqVZM7Xkjr+nTr/fKKK4hcfkNt07xQBXPvidr2NVpx1IPWKmC3xZ1VMiXEZWf5mj5fOfS3+SbTI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0996;
x-ms-traffictypediagnostic: BL0PR2101MB0996:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0996C63A5A8F2371186C89B7A1630@BL0PR2101MB0996.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0996;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0996;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(366004)(39860400002)(376002)(199004)(189003)(55674003)(39060400002)(22452003)(6436002)(25786009)(316002)(10090500001)(4326008)(86362001)(107886003)(3660700001)(3280700002)(5640700003)(97736004)(8936002)(478600001)(53936002)(81166006)(1730700003)(81156014)(2906002)(46003)(6486002)(6916009)(10290500003)(54906003)(8676002)(68736007)(5660300001)(1076002)(2616005)(99286004)(476003)(6116002)(52116002)(6512007)(486006)(36756003)(186003)(2501003)(446003)(2900100001)(7736002)(76176011)(5250100002)(11346002)(14454004)(305945005)(102836004)(106356001)(59450400001)(2351001)(386003)(105586002)(86612001)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0996;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RxLO4pDftE0kUhTEBOvzpUOrIxT3HCCQIj9x3si0FIr5C9pwMj/uKx08yC8OZm17Jn7an6c3OeJLxVNRmPJ/V3bmncjxLMhcBtcpKMk3Fkfg7QQGsh9c6urvm3430NOLvlJcn+TgyORbrRRY6XSAkIftaQoGA8nV0bqptJY+g+7OiknL22c3P0L6mOrN3wCv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 499f147a-44f8-4ad6-b419-08d5c71db71c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499f147a-44f8-4ad6-b419-08d5c71db71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 17:41:20.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph format includes a way to specify a parent is
"missing" from the commit-graph (i.e. we do not have a record of
that parent in our list of object IDs, and hence cannot provide
a graph position). For mose cases, this does not occur due to
the close_reachable() method adding all reachable commits. However,
in a shallow clone, we will try to record the parents of a commit
on the shallow boundary, but the parents are not in the repository.

The GRAPH_PARENT_MISSING value that is stored in the format is
purposeful, especially for future plans to make the commit-graph file
incremental or transporting sections of a commit-graph file across
the network.

In the meantime, check if a commit has a missing parent while filling
its details from the commit-graph. If a parent is missing, still
assign the generation number and graph position for that item, but
report that the commit-graph failed to fill the contents. Then the
caller is responsible for filling the rest of the data from a commit
buffer.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 80e377b90f..3e33d061fe 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -278,17 +278,44 @@ static int fill_commit_in_graph(struct commit *item, =
struct commit_graph *g, uin
 	struct commit_list **pptr;
 	const unsigned char *commit_data =3D g->chunk_commit_data + (g->hash_len =
+ 16) * pos;
=20
-	item->object.parsed =3D 1;
+	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
 	item->graph_pos =3D pos;
=20
+	/*
+	 * If we have any edges marked as GRAPH_PARENT_MISSING, we must not parse=
 any
+	 * more of this object and leave it to the commit buffer to parse.
+	 */
+	edge_value =3D get_be32(commit_data + g->hash_len);
+	if (edge_value =3D=3D GRAPH_PARENT_MISSING)
+		return 0;
+	if (edge_value =3D=3D GRAPH_PARENT_NONE)
+		goto continue_parsing;
+
+	edge_value =3D get_be32(commit_data + g->hash_len + 4);
+	if (edge_value =3D=3D GRAPH_PARENT_MISSING)
+		return 0;
+	if (edge_value =3D=3D GRAPH_PARENT_NONE)
+		goto continue_parsing;
+	if (!(edge_value & GRAPH_OCTOPUS_EDGES_NEEDED))
+		goto continue_parsing;
+
+	parent_data_ptr =3D (uint32_t*)(g->chunk_large_edges +
+			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
+	do {
+		edge_value =3D get_be32(parent_data_ptr);
+		if (edge_value =3D=3D GRAPH_PARENT_MISSING)
+			return 0;
+		parent_data_ptr++;
+	} while (!(edge_value & GRAPH_LAST_EDGE));
+=09
+continue_parsing:
+	item->object.parsed =3D 1;
 	item->maybe_tree =3D NULL;
=20
 	date_high =3D get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low =3D get_be32(commit_data + g->hash_len + 12);
 	item->date =3D (timestamp_t)((date_high << 32) | date_low);
=20
-	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
-
 	pptr =3D &item->parents;
=20
 	edge_value =3D get_be32(commit_data + g->hash_len);
--=20
2.16.2.338.gcfe06ae955

