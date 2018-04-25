Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE231F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeDYOiE (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:38:04 -0400
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:50240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754365AbeDYOh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=isdWRk+Va/kvkrmDIM5UCuNd3FFK6Jzdleq0fEyBtnQ=;
 b=XSxhp+A/eBWF1Sf0j/16ek3Ydk4+hBrM0zN7NetSbNjtr3H5O1UEy+iXRaXEGZca+ZfRn0cy70qkEC+64UHi1S7KZ5p5blBxIETWFBMbPl3XRwZ0QA1MRcSupTBzBPCmRMrQjDMvXRbcBRAEyyHUgeVMA435GKgqlvCqojLX3vg=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.5; Wed, 25 Apr 2018 14:37:55 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0735.006; Wed, 25 Apr 2018
 14:37:55 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 02/10] commit: add generation number to struct commmit
Thread-Topic: [PATCH v4 02/10] commit: add generation number to struct commmit
Thread-Index: AQHT3KL/y5c/KOhLxU+IzD7vbaiBLg==
Date:   Wed, 25 Apr 2018 14:37:55 +0000
Message-ID: <20180425143735.240183-3-dstolee@microsoft.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
In-Reply-To: <20180425143735.240183-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR12CA0040.namprd12.prod.outlook.com
 (2603:10b6:405:70::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1106;7:cT1SZrG+sLAbPNDFEz5wJe+MID3nNZBMMb2M9HWC1XiZKbuB2NYWIVvnRW6Hs1T0ZFDmYDaXpRUyNaIf3O4InKzVO2La3UfeszrNWJaQvuimNrMT/V3fnKJuRIq35yQjmNqxCQtqN7z7OC83EhiXHPrihDzUoWxQcwUqIIW+0MH35ElwtDKh8oiF1NmP1sTkvhsl3ubAUBfCMpCwQmpmWkbCUBcsu0M8wGcEfj1Glm7E8pjNUeJ0QBVt8pg3ypgv;20:/sd7jbokuvyIekdBSXaeO8TqRMJ0lQBzXQSoTmkcpYp21NtkyPmOVFemXsB8c+RecDCZg2qgIxoU6Eqtp4NZoxeIAOLb5SDiXc9brOn+fIDejgFYGXEVlzQWq233O+0u67q3UcpSuZYZTgC4EynUq0m7v1MRItkwxaVNzucQV3w=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1106;
x-ms-traffictypediagnostic: BL0PR2101MB1106:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB11067E8BF50C5035DE58FC12A18F0@BL0PR2101MB1106.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1106;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1106;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(106356001)(86612001)(25786009)(105586002)(39060400002)(22452003)(486006)(316002)(6512007)(186003)(8676002)(1730700003)(81166006)(305945005)(6486002)(97736004)(8936002)(5250100002)(14454004)(76176011)(81156014)(386003)(6506007)(7736002)(99286004)(6116002)(86362001)(36756003)(102836004)(478600001)(1076002)(3280700002)(8656006)(3660700001)(52116002)(10290500003)(5660300001)(46003)(2900100001)(107886003)(5640700003)(4326008)(6436002)(6916009)(2501003)(2351001)(68736007)(10090500001)(11346002)(54906003)(2906002)(446003)(53936002)(476003)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1106;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8/6YV/moitIzVyqIweAC6Pzhi3/S6w88XreY0xnja//awsm8eyIj/iuf7eho6rhEkER+d3jRu5rGvs7OI+lGENj0P2Y7HHOdubkW5dOoByuj8/8iMjVXwbkOYXLKjLze0JWNzYUU17tjXhGG70dyQVdNgS8AYcB03bSFaLg9HYMefe4EgJlTPDDCNi36isp1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 308f28dd-5773-459c-9462-08d5aaba21b5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308f28dd-5773-459c-9462-08d5aaba21b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:37:55.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The generation number of a commit is defined recursively as follows:

* If a commit A has no parents, then the generation number of A is one.
* If a commit A has parents, then the generation number of A is one
  more than the maximum generation number among the parents of A.

Add a uint32_t generation field to struct commit so we can pass this
information to revision walks. We use three special values to signal
the generation number is invalid:

GENERATION_NUMBER_INFINITY 0xFFFFFFFF
GENERATION_NUMBER_MAX 0x3FFFFFFF
GENERATION_NUMBER_ZERO 0

The first (_INFINITY) means the generation number has not been loaded or
computed. The second (_MAX) means the generation number is too large to
store in the commit-graph file. The third (_ZERO) means the generation
number was loaded from a commit graph file that was written by a version
of git that did not support generation numbers.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 alloc.c        | 1 +
 commit-graph.c | 2 ++
 commit.h       | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/alloc.c b/alloc.c
index cf4f8b61e1..e8ab14f4a1 100644
--- a/alloc.c
+++ b/alloc.c
@@ -94,6 +94,7 @@ void *alloc_commit_node(void)
 	c->object.type =3D OBJ_COMMIT;
 	c->index =3D alloc_commit_index();
 	c->graph_pos =3D COMMIT_NOT_FROM_GRAPH;
+	c->generation =3D GENERATION_NUMBER_INFINITY;
 	return c;
 }
=20
diff --git a/commit-graph.c b/commit-graph.c
index 70fa1b25fd..9ad21c3ffb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -262,6 +262,8 @@ static int fill_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 	date_low =3D get_be32(commit_data + g->hash_len + 12);
 	item->date =3D (timestamp_t)((date_high << 32) | date_low);
=20
+	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
+
 	pptr =3D &item->parents;
=20
 	edge_value =3D get_be32(commit_data + g->hash_len);
diff --git a/commit.h b/commit.h
index 23a3f364ed..aac3b8c56f 100644
--- a/commit.h
+++ b/commit.h
@@ -10,6 +10,9 @@
 #include "pretty.h"
=20
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
+#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
+#define GENERATION_NUMBER_MAX 0x3FFFFFFF
+#define GENERATION_NUMBER_ZERO 0
=20
 struct commit_list {
 	struct commit *item;
@@ -30,6 +33,7 @@ struct commit {
 	 */
 	struct tree *maybe_tree;
 	uint32_t graph_pos;
+	uint32_t generation;
 };
=20
 extern int save_commit_buffer;
--=20
2.17.0.39.g685157f7fb

