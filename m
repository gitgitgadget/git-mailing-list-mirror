Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9453B1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933202AbeFTURf (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:17:35 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:45030
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932755AbeFTURc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqgMGja1l6jTG/qB02rtMmLyPPOP3p8jnU+c834+VpI=;
 b=g7jt4HWdmQi7H2/PVcRe5jLjmJfkU57oWvk48/i0Ab9k2KunX5C4/fpIltproC1cFZhHwZA9OvS0RRchV1RyrGgoydguWzYfxsmfzG7e3q2YtO22Yry0Jqja8E6gqVwcArJ6ZRjj/Zuga/gxQGOs+6jRjrlmWf+mWQ87NC01mDY=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0746.namprd21.prod.outlook.com (10.173.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.1; Wed, 20 Jun 2018 20:17:30 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 20:17:30 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 5/8] mem-pool: add lifecycle management functions
Thread-Topic: [PATCH v4 5/8] mem-pool: add lifecycle management functions
Thread-Index: AQHUCNO244YAiV9wwUitwh+5RNaMtw==
Date:   Wed, 20 Jun 2018 20:17:30 +0000
Message-ID: <20180620201557.77155-6-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180620201557.77155-1-jamill@microsoft.com>
In-Reply-To: <20180620201557.77155-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:404:23::32) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0746;7:lsourNL9ztYrlmIztZDf/KO4kK7uPeDVSjg0IznPfCtsk2ZnBHRN5YYer7hEgaXQSUaLBUd+Gd8ncOqD/yVuB9ZMfVYtShfvEZDKljQMzRKrM8moIA4tdR+YCMLP71JKa8E0/2IMTkKJTRC5BuBTlpXZkBOJCj+KstnN1qO9PDDJB3aPOpiCt9z80fwEswySowOsFOHtGGG4E5XFrlYRCRPX4ZCGguCOgWbTS99DmFzwocA3SSXv+zEr3dt3i1Mw
x-ms-office365-filtering-correlation-id: c5e139df-a3bd-4ff2-a0a3-08d5d6ead944
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0746;
x-ms-traffictypediagnostic: DM5PR21MB0746:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0746E2A44646F947331BB872CE770@DM5PR21MB0746.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0746;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0746;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(199004)(189003)(10290500003)(8676002)(305945005)(14454004)(76176011)(11346002)(7736002)(68736007)(4326008)(5660300001)(39060400002)(25786009)(6916009)(52116002)(53936002)(106356001)(36756003)(8936002)(8656006)(1730700003)(22452003)(81156014)(386003)(186003)(2616005)(54906003)(59450400001)(316002)(102836004)(6506007)(446003)(478600001)(99286004)(81166006)(486006)(476003)(107886003)(2351001)(3660700001)(6486002)(46003)(97736004)(6512007)(2900100001)(86612001)(6436002)(6116002)(1076002)(5640700003)(3280700002)(5250100002)(2906002)(105586002)(10090500001)(2501003)(86362001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0746;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gBNuTetvvuDu8QkX9WyDF3Wsh2L9cI6ETvaKWhQ15Hm8zemFpz0HNLkio6KkB1F/DQ3qssGVJzC4BF1CrhLPRYPq3+uvqfWZYR48rtrTFxfayOYgm7sIJaQBiorFNBIjUTRN1WNKSK8twrq221aVkyjIEh6+CyGpEiTv0wQonjJ+fHybtETfeZFZi7FJhTFRK/asnUnvBmRJpJZxjOIElehTlfOUCguG/kVrSXxIgZdND5FJPLOj3eCxawfyRNcL39rqXEV1KwHZpdpMc/tJcsMUnmdR/d660jaxbL/hb/JCM16x/x+aU+QGCIQ2iOIlwAjZ68Xt+OeU9bJduaDVkw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e139df-a3bd-4ff2-a0a3-08d5d6ead944
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 20:17:30.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0746
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add initialization and discard functions to mem_pool type. As the
memory allocated by mem_pool can now be freed, we also track the large
memory alllocations so they can be freed as well.

If the there are existing mp_blocks in the mem_pool's linked list of
mp_blocks, then the mp_block for a large allocation is inserted
after the head block. This is because only the head mp_block is considered
when searching for availble space. This results in the following
desirable properties:

1) The mp_block allocated for the large request will not be included
in the search for available space in future requests, as the large
mp_block is sized for the specific request and does not contain any
spare space.

2) The head mp_block will not bumped from considation for future
memory requests just because a request for a large chunk of memory
came in.

These changes are in preparation for a future commit that will utilize
creating and discarding memory pool.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++--------=
----
 mem-pool.h | 10 ++++++++++
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index a5d5eed923..4e544459e9 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,7 +5,14 @@
 #include "cache.h"
 #include "mem-pool.h"
=20
-static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
+#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
+
+/*
+ * Allocate a new mp_block and insert it after the block specified in
+ * `insert_after`. If `insert_after` is NULL, then insert block at the
+ * head of the linked list.
+ */
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc, struct mp_block *insert_after)
 {
 	struct mp_block *p;
 	size_t total_alloc =3D st_add(offsetof(struct mp_block, space), block_all=
oc);
@@ -13,14 +20,51 @@ static struct mp_block *mem_pool_alloc_block(struct mem=
_pool *mem_pool, size_t b
 	mem_pool->pool_alloc =3D st_add(mem_pool->pool_alloc, total_alloc);
 	p =3D xmalloc(total_alloc);
=20
-	p->next_block =3D mem_pool->mp_block;
 	p->next_free =3D (char *)p->space;
 	p->end =3D p->next_free + block_alloc;
-	mem_pool->mp_block =3D p;
+
+	if (insert_after) {
+		p->next_block =3D insert_after->next_block;
+		insert_after->next_block =3D p;
+	} else {
+		p->next_block =3D mem_pool->mp_block;
+		mem_pool->mp_block =3D p;
+	}
=20
 	return p;
 }
=20
+void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
+{
+	struct mem_pool *pool;
+
+	if (*mem_pool)
+		return;
+
+	pool =3D xcalloc(1, sizeof(*pool));
+
+	pool->block_alloc =3D BLOCK_GROWTH_SIZE;
+
+	if (initial_size > 0)
+		mem_pool_alloc_block(pool, initial_size, NULL);
+
+	*mem_pool =3D pool;
+}
+
+void mem_pool_discard(struct mem_pool *mem_pool)
+{
+	struct mp_block *block, *block_to_free;
+
+	while ((block =3D mem_pool->mp_block))
+	{
+		block_to_free =3D block;
+		block =3D block->next_block;
+		free(block_to_free);
+	}
+
+	free(mem_pool);
+}
+
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p =3D NULL;
@@ -33,15 +77,10 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t =
len)
 	if (mem_pool->mp_block &&
 	    mem_pool->mp_block->end - mem_pool->mp_block->next_free >=3D len)
 		p =3D mem_pool->mp_block;
-
-	if (!p) {
-		if (len >=3D (mem_pool->block_alloc / 2)) {
-			mem_pool->pool_alloc +=3D len;
-			return xmalloc(len);
-		}
-
-		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
-	}
+	else if (len >=3D (mem_pool->block_alloc / 2))
+		p =3D mem_pool_alloc_block(mem_pool, len, mem_pool->mp_block);
+	else
+		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc, NULL);
=20
 	r =3D p->next_free;
 	p->next_free +=3D len;
diff --git a/mem-pool.h b/mem-pool.h
index 829ad58ecf..f75b3365d5 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -21,6 +21,16 @@ struct mem_pool {
 	size_t pool_alloc;
 };
=20
+/*
+ * Initialize mem_pool with specified initial size.
+ */
+void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size);
+
+/*
+ * Discard a memory pool and free all the memory it is responsible for.
+ */
+void mem_pool_discard(struct mem_pool *mem_pool);
+
 /*
  * Alloc memory from the mem_pool.
  */
--=20
2.14.3

