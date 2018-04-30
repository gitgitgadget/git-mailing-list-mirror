Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CBD9215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeD3Pbs (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:31:48 -0400
Received: from mail-bn3nam01on0103.outbound.protection.outlook.com ([104.47.33.103]:2570
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753980AbeD3Pbp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=76EpmzQ/zFd9b6cfnO18Z/cSYHQVsMyvodY+q8Fo1o8=;
 b=CYvHBlyp1LcpKRkeRMNgIAi69x83rkUL37sqUTYc1Py7/6ON3V9Yw4r0/il11bQ6LDXSGy9xNDO2mSz19Cb7E5CFirnkfLSaWDd7ZafSSlY3+ccGvkmqz8UPGPZo/quxrfOc6rL/4CL81I6foEjghHAD/Y/8GbTXjN2Mu2lyKyc=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0914.namprd21.prod.outlook.com (52.132.23.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Mon, 30 Apr 2018 15:31:43 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.002; Mon, 30 Apr 2018
 15:31:43 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 3/5] mem-pool: fill out functionality
Thread-Topic: [PATCH v2 3/5] mem-pool: fill out functionality
Thread-Index: AQHT4JhXgM+PkPx06Uufvuo1NfMsXQ==
Date:   Mon, 30 Apr 2018 15:31:43 +0000
Message-ID: <20180430153122.243976-4-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180430153122.243976-1-jamill@microsoft.com>
In-Reply-To: <20180430153122.243976-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN4PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:403:3::17) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0914;7:RsxeqDJc7rxPgqY/ZKIk1hFKqj4bk2EHmcegi1s1qJQyqtf1oWTml6c0yYxHYFfJ7lFqqp8Brzor+dJkSj4YJLU3v7sutBXD+W5LuAvwAyfGCJoxZTTuY+IfVQE7jOi9ZHrsZWpkAywCL1Lk7zFgO/vZVmOEPEaSMNHDBabE3gKGJK1s+p5cV/FOFYWPtRBN9qzIBqyus0Qf/KZsrjSMddj1cM1Qh5t7AtJA+OiH633VvLU+e1f3YHtMTJANPV9X;20:EzkmBHD6Dxzx4fx/H37308XwocRJF+Cj7IgS5eXbZ/NewLupmZLuqIktWc11qdlMK8qvO18GE5DlE9cFVg2vf0jEH3yc780aHq9jZjeqlwQjV4Bxnzp2kRP6qwmMOE/TXeU+c5uvWACh5Vy8azreE6ypHpLEeSQNw1kkOk/O5ik=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0914;
x-ms-traffictypediagnostic: BL0PR2101MB0914:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB091480D67F7E0D9CE7E2C687CE820@BL0PR2101MB0914.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0914;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0914;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(396003)(376002)(39860400002)(189003)(199004)(4326008)(36756003)(97736004)(8936002)(1730700003)(81156014)(81166006)(46003)(14454004)(22452003)(8676002)(86612001)(8656006)(186003)(6436002)(54906003)(6116002)(3660700001)(1076002)(105586002)(6512007)(53936002)(476003)(2906002)(107886003)(2616005)(316002)(6486002)(3280700002)(68736007)(2351001)(39060400002)(11346002)(5640700003)(446003)(2501003)(99286004)(486006)(6916009)(2900100001)(102836004)(5660300001)(7736002)(52116002)(6506007)(106356001)(386003)(305945005)(86362001)(10290500003)(25786009)(5250100002)(10090500001)(478600001)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0914;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 75/D/vm60wrNAYJ4ZVWxobXMIW8wKBQrNxs9kq4GhqbW9q1YMeb67+GJXoUB8eoyfRfwgdVyMXGf5Z0VLdNbHWfxVl06lqW15bxoQQVUWQZWN6BQ7fNPFDPSP6/ANQUJuzVNmT4NB5Y175U/+YM1JDiknmC9jMGaMY/xntIz/dkU3R2SoOGtDhnxNgsWyrPm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 169c547c-5d17-4c3b-f581-08d5aeaf79c7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169c547c-5d17-4c3b-f581-08d5aeaf79c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 15:31:43.3033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds the following functionality to memory pools:

 - Lifecycle management functions (init, discard)

 - Test whether a memory location is part of the managed pool

 - Function to combine 2 pools

This also adds logic to track all memory allocations made by a memory
pool.

These functions will be used in a future commit in this commit series.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 mem-pool.h |  32 +++++++++++++++++
 2 files changed, 142 insertions(+), 4 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 389d7af447..a495885c4b 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,6 +5,8 @@
 #include "cache.h"
 #include "mem-pool.h"
=20
+#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
+
 static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
 {
 	struct mp_block *p;
@@ -19,6 +21,60 @@ static struct mp_block *mem_pool_alloc_block(struct mem_=
pool *mem_pool, size_t b
 	return p;
 }
=20
+static void *mem_pool_alloc_custom(struct mem_pool *mem_pool, size_t block=
_alloc)
+{
+	char *p;
+	ALLOC_GROW(mem_pool->custom, mem_pool->nr + 1, mem_pool->alloc);
+	ALLOC_GROW(mem_pool->custom_end, mem_pool->nr_end + 1, mem_pool->alloc_en=
d);
+
+	p =3D xmalloc(block_alloc);
+	mem_pool->custom[mem_pool->nr++] =3D p;
+	mem_pool->custom_end[mem_pool->nr_end++] =3D p + block_alloc;
+
+	mem_pool->pool_alloc +=3D block_alloc;
+
+	return mem_pool->custom[mem_pool->nr];
+}
+
+void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
+{
+	if (!(*mem_pool))
+	{
+		*mem_pool =3D xmalloc(sizeof(struct mem_pool));
+		(*mem_pool)->pool_alloc =3D 0;
+		(*mem_pool)->mp_block =3D NULL;
+		(*mem_pool)->block_alloc =3D BLOCK_GROWTH_SIZE;
+		(*mem_pool)->custom =3D NULL;
+		(*mem_pool)->nr =3D 0;
+		(*mem_pool)->alloc =3D 0;
+		(*mem_pool)->custom_end =3D NULL;
+		(*mem_pool)->nr_end =3D 0;
+		(*mem_pool)->alloc_end =3D 0;
+
+		if (initial_size > 0)
+			mem_pool_alloc_block(*mem_pool, initial_size);
+	}
+}
+
+void mem_pool_discard(struct mem_pool *mem_pool)
+{
+	int i;
+	struct mp_block *block, *block_to_free;
+	for (block =3D mem_pool->mp_block; block;)
+	{
+		block_to_free =3D block;
+		block =3D block->next_block;
+		free(block_to_free);
+	}
+
+	for (i =3D 0; i < mem_pool->nr; i++)
+		free(mem_pool->custom[i]);
+
+	free(mem_pool->custom);
+	free(mem_pool->custom_end);
+	free(mem_pool);
+}
+
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p;
@@ -33,10 +89,8 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t l=
en)
 			break;
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
@@ -53,3 +107,55 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t=
 count, size_t size)
 	memset(r, 0, len);
 	return r;
 }
+
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
+{
+	int i;
+	struct mp_block *p;
+
+	/* Check if memory is allocated in a block */
+	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
+		if ((mem >=3D ((void *)p->space)) &&
+		    (mem < ((void *)p->end)))
+			return 1;
+
+	/* Check if memory is allocated in custom block */
+	for (i =3D 0; i < mem_pool->nr; i++)
+		if ((mem >=3D mem_pool->custom[i]) &&
+		    (mem < mem_pool->custom_end[i]))
+			return 1;
+
+	return 0;
+}
+
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
+{
+	int i;
+	struct mp_block **tail =3D &dst->mp_block;
+
+	/* Find pointer of dst's last block (if any) */
+	while (*tail)
+		tail =3D &(*tail)->next_block;
+
+	/* Append the blocks from src to dst */
+	*tail =3D src->mp_block;
+
+	/* Combine custom allocations */
+	ALLOC_GROW(dst->custom, dst->nr + src->nr, dst->alloc);
+	ALLOC_GROW(dst->custom_end, dst->nr_end + src->nr_end, dst->alloc_end);
+
+	for (i =3D 0; i < src->nr; i++) {
+		dst->custom[dst->nr++] =3D src->custom[i];
+		dst->custom_end[dst->nr_end++] =3D src->custom_end[i];
+	}
+
+	dst->pool_alloc +=3D src->pool_alloc;
+	src->pool_alloc =3D 0;
+	src->mp_block =3D NULL;
+	src->custom =3D NULL;
+	src->nr =3D 0;
+	src->alloc =3D 0;
+	src->custom_end =3D NULL;
+	src->nr_end =3D 0;
+	src->alloc_end =3D 0;
+}
diff --git a/mem-pool.h b/mem-pool.h
index 829ad58ecf..34df4fa709 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -19,8 +19,27 @@ struct mem_pool {
=20
 	/* The total amount of memory allocated by the pool. */
 	size_t pool_alloc;
+
+	/*
+	 * Array of pointers to "custom size" memory allocations.
+	 * This is used for "large" memory allocations.
+	 * The *_end variables are used to track the range of memory
+	 * allocated.
+	 */
+	void **custom, **custom_end;
+	int nr, nr_end, alloc, alloc_end;
 };
=20
+/*
+ * Initialize mem_pool specified initial.
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
@@ -31,4 +50,17 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
  */
 void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
=20
+/*
+ * Move the memory associated with the 'src' pool to the 'dst' pool. The '=
src'
+ * pool will be empty and not contain any memory. It still needs to be fre=
e'd
+ * with a call to `mem_pool_discard`.
+ */
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
+
+/*
+ * Check if a memory pointed at by 'mem' is part of the range of
+ * memory managed by the specified mem_pool.
+ */
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
+
 #endif
--=20
2.14.3

