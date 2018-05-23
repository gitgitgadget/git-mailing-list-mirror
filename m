Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F51E1F42D
	for <e@80x24.org>; Wed, 23 May 2018 14:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933419AbeEWOru (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 10:47:50 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:26688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933341AbeEWOrn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 10:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpxhn/71MhpqTwWuS6c6gHTF9sYvF/3p7g4P1rHrOlU=;
 b=Lra0Ym1V8ogP5kjHE5wiW5A7GkcIEsVLw27tG6gOZkeV/CPLcV3gLSTYZIJJuW5SiS4fr1JBNiI6KOj8Q4N3J06E1AQMXyJXTb9cFj8RL4ByMnABoE3rB14o21Z9bEprvwxdP5tb5va0qAwwAo5B2lkVqwOess9RLI8BgUVcHHs=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Wed, 23 May 2018 14:47:38 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0797.007; Wed, 23 May 2018
 14:47:38 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 4/7] mem-pool: add lifecycle management functions
Thread-Topic: [PATCH v3 4/7] mem-pool: add lifecycle management functions
Thread-Index: AQHT8qT+/227qN50dk6tdfjv+ie4GA==
Date:   Wed, 23 May 2018 14:47:38 +0000
Message-ID: <20180523144637.153551-5-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180523144637.153551-1-jamill@microsoft.com>
In-Reply-To: <20180523144637.153551-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR1801CA0033.namprd18.prod.outlook.com
 (2603:10b6:405:5f::46) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:rFX8eVHIEx7t8F7qkbtUJjOYuAH2wPPZL+w3NFN3TNe8YAgf5GN8KaNS/zVHntpUvfv62VJ9oYSKP7gTKZF8haz5n+FfpNj/dStiYL4pW0TDJMHBeRveE9W2/w9DwWGCizScnxY3dQKJ4vGUJJiTl9TWs6uaUutbH5ziuIrabZjLCzG5Piu/wnUB0bHW0deumC2Iay7NCckZ0ro39siqoD+IU9Wa9rbqIcdkHwkMi9JpCabfrCHbbRoG4IdZpFpT;20:nko0B/eJoLwu9MOS8n1r9KHSlzeLa2P1P0JSC1Im2MWpeMeoJ3eW44yWOCRZ8BcqKKtUDn3aXp8rcB4/LPL0Zg01kzDkO0shYPlqu11Cw0d/ls4u8cQMbWIfJJ09X3ya+wAe+su1/r5LQQxgQLReC3XV/aJzLf5QQVvsOF7SH2k=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09779ADA81CB54C09EB488DBCE6B0@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(76176011)(102836004)(99286004)(6506007)(386003)(2501003)(5250100002)(81166006)(81156014)(1730700003)(8676002)(105586002)(8936002)(305945005)(106356001)(97736004)(7736002)(86362001)(476003)(25786009)(2906002)(3660700001)(1076002)(14454004)(486006)(3280700002)(6116002)(446003)(11346002)(186003)(52116002)(2616005)(86612001)(46003)(10090500001)(6512007)(53936002)(2351001)(478600001)(36756003)(5660300001)(4326008)(6916009)(68736007)(6436002)(5640700003)(2900100001)(22452003)(316002)(54906003)(8656006)(39060400002)(10290500003)(107886003)(6486002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4hdU1xXxBt7JvStxn2fwbR1/K64IvKFZQz3al3aZ2XedgsjwhIz2b5pq60b2FeQmDy9i1uY2AprP7FUVaQ3jEd7VOygl7+JLExEmFuzFhOTnkTGx14bxzonTqQch8+Ny1Ff2SIZR6mdE75dapb/Fyo9f8NpZ53srjIyvHGJLbEfd0eVewAXrDBKgEfpe3Q64
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4fb70402-4625-4a0d-6e1f-08d5c0bc20d3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb70402-4625-4a0d-6e1f-08d5c0bc20d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 14:47:38.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add initialization and discard functions to mem-pool type. As part of
this, we now also track "large" allocations of memory so that these
can also be cleaned up when discarding the memory pool.

These changes are in preparation for a future commit that will utilize
creating and discarding memory pool.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c |  2 +-
 mem-pool.c    | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 mem-pool.h    | 12 +++++++++++-
 3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 34edf3fb8f..571898e5db 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -300,7 +300,7 @@ static int global_argc;
 static const char **global_argv;
=20
 /* Memory pools */
-static struct mem_pool fi_mem_pool =3D  {NULL, 2*1024*1024 -
+static struct mem_pool fi_mem_pool =3D  {NULL, NULL, 2*1024*1024 -
 				       sizeof(struct mp_block), 0 };
=20
 /* Atom management */
diff --git a/mem-pool.c b/mem-pool.c
index c80124f1fe..01595bcca5 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,20 +5,77 @@
 #include "cache.h"
 #include "mem-pool.h"
=20
+#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
+
 static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
 {
 	struct mp_block *p;
=20
 	mem_pool->pool_alloc +=3D sizeof(struct mp_block) + block_alloc;
 	p =3D xmalloc(st_add(sizeof(struct mp_block), block_alloc));
+
 	p->next_block =3D mem_pool->mp_block;
 	p->next_free =3D (char *)p->space;
 	p->end =3D p->next_free + block_alloc;
+
 	mem_pool->mp_block =3D p;
=20
+	if (!mem_pool->mp_block_tail)
+		mem_pool->mp_block_tail =3D p;
+
+	return p;
+}
+
+static void *mem_pool_alloc_custom(struct mem_pool *mem_pool, size_t block=
_alloc)
+{
+	struct mp_block *p;
+
+	mem_pool->pool_alloc +=3D sizeof(struct mp_block) + block_alloc;
+	p =3D xmalloc(st_add(sizeof(struct mp_block), block_alloc));
+
+	p->next_block =3D NULL;
+	p->next_free =3D (char *)p->space;
+	p->end =3D p->next_free + block_alloc;
+
+	if (mem_pool->mp_block_tail)
+		mem_pool->mp_block_tail->next_block =3D p;
+	else
+		mem_pool->mp_block =3D p;
+
+	mem_pool->mp_block_tail =3D p;
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
+		mem_pool_alloc_block(pool, initial_size);
+
+	*mem_pool =3D pool;
+}
+
+void mem_pool_discard(struct mem_pool *mem_pool)
+{
+	struct mp_block *block, *block_to_free;
+	for (block =3D mem_pool->mp_block; block;)
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
@@ -33,10 +90,8 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t l=
en)
 		p =3D mem_pool->mp_block;
=20
 	if (!p) {
-		if (len >=3D (mem_pool->block_alloc / 2)) {
-			mem_pool->pool_alloc +=3D len;
-			return xmalloc(len);
-		}
+		if (len >=3D (mem_pool->block_alloc / 2))
+			return mem_pool_alloc_custom(mem_pool, len);
=20
 		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
 	}
diff --git a/mem-pool.h b/mem-pool.h
index 829ad58ecf..5d3e6a367a 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -9,7 +9,7 @@ struct mp_block {
 };
=20
 struct mem_pool {
-	struct mp_block *mp_block;
+	struct mp_block *mp_block, *mp_block_tail;
=20
 	/*
 	 * The amount of available memory to grow the pool by.
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

