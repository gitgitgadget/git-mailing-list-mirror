Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E6E215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755486AbeEAMrN (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:13 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:40065
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754970AbeEAMrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=isdWRk+Va/kvkrmDIM5UCuNd3FFK6Jzdleq0fEyBtnQ=;
 b=KnHvTFAeWkjEkul0zAM3J/tOvDA7ZTIP92oEptpb48/peUZvIDkMhTyaao+KG17ih6mbRSK2W3GulzRiWt902o//0ciIC24ub1ltJ+1p0gxKbFJHzN4ikIlVdYRkQOpr5+dQSrL3fny6Q8gMKynLCgcH2k63QD85Qxpv+gNvHvk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:08 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:08 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 02/11] commit: add generation number to struct commmit
Thread-Topic: [PATCH v5 02/11] commit: add generation number to struct commmit
Thread-Index: AQHT4UqD2JFn0hpEDECjrvWNwMgyeQ==
Date:   Tue, 1 May 2018 12:47:07 +0000
Message-ID: <20180501124652.155781-3-dstolee@microsoft.com>
References: <20180425143735.240183-1-dstolee@microsoft.com>
 <20180501124652.155781-1-dstolee@microsoft.com>
In-Reply-To: <20180501124652.155781-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:403:2::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:4UPiCKSusIHBl4f/JY7WCgGgT17phOZGcIkKvHb2jVA1T5qVyRBvC2WOdPa6i81tbnUm2/l8XJOXZTxdNYDyNzD9wypyqx4HbkdXSiD9Iw7eKxBqU9792SI9785R5BBxF1xJfvvLYg2Xhsjw/xE0/ghQIUl1/Y+diukGPr846an4ogrpr2vb6r9YQRCiagcii7ZokXIH4wqDDxHxZRxYhV7sFczPWrnNGNtJGBjKPBKevIJJzQmOn5wVDDK5g5vM;20:LnAAG+11n1gFy5HtHQGEll7tmzCjaye1IIgfuCOtJ8EF2Z8iTKMt9xS8C1qZiuY2KUwL4Bwdu9dN43QsyorQPMb0bTO/adRXZTiyzhzHJfjgW/ukUEbqo3L1YVSyfD2aLmUckeLUWv8tMlKuJW56xxp2XI56lT5p7vE3E8xxbRk=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
x-microsoft-antispam-prvs: <BL0PR2101MB09779E2A989607E72D2049C1A1810@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(39380400002)(346002)(396003)(189003)(199004)(102836004)(53936002)(6506007)(386003)(99286004)(2900100001)(54906003)(5640700003)(3280700002)(3660700001)(2906002)(6512007)(6486002)(25786009)(39060400002)(4326008)(107886003)(86612001)(6436002)(6346003)(8656006)(36756003)(52116002)(76176011)(105586002)(106356001)(5660300001)(6916009)(5250100002)(2501003)(97736004)(7736002)(68736007)(8676002)(81166006)(81156014)(10290500003)(8936002)(478600001)(86362001)(486006)(10090500001)(6116002)(476003)(2351001)(1730700003)(186003)(1076002)(305945005)(446003)(22452003)(46003)(2616005)(316002)(11346002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: zjEgk05SC1X4ZW+bIvBNiH82MrioP+j3SsJaeJtiLvpoPUKlP5rQwQe8HeLGU2e5ZxjIu4N9jmtVNAeIm8umZI/QfclA05zY77zwh/njqI5wrIvwMUsHciaIuo5k4Rhv5ksuRKbETP0ISGcneIhIWwWmqxj4p/NGJDvrLKGvVot08HOKL1AIEKD+FcITHsJm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 99cb781a-aaaa-492e-7cc0-08d5af61a611
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cb781a-aaaa-492e-7cc0-08d5af61a611
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:07.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
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

