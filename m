Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947511F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeDIQmD (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:03 -0400
Received: from mail-sn1nam02on0112.outbound.protection.outlook.com ([104.47.36.112]:37815
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbeDIQmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1LzCHtRqhXa4FXbE6e9pel4ebnCaLAgc2SAhfN6zenY=;
 b=XIeK1sntdC15LSzZhzNul1cCg7Z9KLdOXBFDaZp/7YvAN9sPdIvcUGKIg9uFMHCOI2L0d3cQqQ+8L6Ayyvq5kdX345A+WcCMaO93VC/LKHgkziq4qrpIUMHjHLfMqLqcehp/U2xvu9hqcS9VE2ZKYTUv2+LLPzC4ThnMquK98wA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:42:00 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:42:00 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 03/10] commit: add generation number to struct commmit
Thread-Topic: [PATCH v2 03/10] commit: add generation number to struct commmit
Thread-Index: AQHT0CGuGVFASWA8B0WRpfTLB5LuQA==
Date:   Mon, 9 Apr 2018 16:42:00 +0000
Message-ID: <20180409164131.37312-4-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
In-Reply-To: <20180409164131.37312-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:903:99::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:uKUVFcMAAW3ersKpkNJvRIvXPZZWryyLoR6ai0X7sH9RFcZ2yuTfFt2nYMUeaoTvkv0o5mWVUmX5UWj0qRGzFFHjTBlllkMhsyUpnUQGfK1Rdn8UFAhI6/CguqxyFGQVD38uLJEWHMKx1zAwtw7xzJtUb2GIj8QcgqoxembkRRMh01haT+qlkxMSSB0yq+PsW91cyjaJ82q7R+Q+BESwzVHIB2NfbafiWFiZpCl9rWulj7Rc/lVSqXK/6TBesDHB;20:e+B+51iODv3GGzlcqWtLKIAkgdT1kBhB4/JycEj8Y9DzkUrIrswUTqqzlUUKAgfJk/IKwy111jnR4mS0C/3NwKZBUBGLshRodztzFNuFYEev2ibX3Dx9aNOyiq9rrEr7jVc81VRJEat/+aN2/nW2T4uLksUgXXjDhxmElRz54Z8=
X-MS-Office365-Filtering-Correlation-Id: ee0bfa44-1db8-4dab-d44a-08d59e38d0a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962161FA7D2DC0B9D780F08A1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h0bcoFn/r2ZUn1Xom+EJ9RGHKqgQRjBfZ0jlfQGOhVSeoPeW4F1h62VUarpFba5C+BxrIkOwSkhFcl4h27Q+oYx/rbFy9ULtru9IXLCiPGKFVOS3Ui5L78Smsu1rm6FalaXc0tVqr2C4U6UqbClThb0Dj6go5B1nuLQD0prlWH9OyfaoTnu1Nwpq2Enrr3jKVClTZVpohtmrA5u47GjbJ4cRLbx/FiNTeqPCE0dz+P4PyFsoaAeIkCCQtogd/gO34EpLirQvZNn2SrGcpAnsORJo5buBsieJ98ry7qIz7TBd6LlAplAXW8vozr0ynGySRA+E91Iim87rrH7ks0O54pl4FnhY3ipcNTQTSxGMC/hInZnwcrX7flZ6tzlK7lUqV2JVecwhlxbUNR2N2zrOCN0u1k5xByYvdhRTp26QfrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0bfa44-1db8-4dab-d44a-08d59e38d0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:42:00.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The generation number of a commit is defined recursively as follows:

* If a commit A has no parents, then the generation number of A is one.
* If a commit A has parents, then the generation number of A is one
  more than the maximum generation number among the parents of A.

Add a uint32_t generation field to struct commit so we can pass this
information to revision walks. We use two special values to signal
the generation number is invalid:

GENERATION_NUMBER_ININITY 0xFFFFFFFF
GENERATION_NUMBER_ZERO 0

The first (_INFINITY) means the generation number has not been loaded or
computed. The second (_ZERO) means the generation number was loaded
from a commit graph file that was stored before generation numbers
were computed.

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
index 1fc63d541b..d24b947525 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -264,6 +264,8 @@ static int fill_commit_in_graph(struct commit *item, st=
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
index e57ae4b583..b91df315c5 100644
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
@@ -24,6 +27,7 @@ struct commit {
 	struct commit_list *parents;
 	struct tree *tree;
 	uint32_t graph_pos;
+	uint32_t generation;
 };
=20
 extern int save_commit_buffer;
--=20
2.17.0

