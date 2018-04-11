Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40CE01F404
	for <e@80x24.org>; Wed, 11 Apr 2018 18:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDKSh7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 14:37:59 -0400
Received: from mail-by2nam03on0092.outbound.protection.outlook.com ([104.47.42.92]:7328
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753636AbeDKSh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rf3+k+OTgQuPGxp9z5D6KorjC0iqnIkEKoo5D7yUvV4=;
 b=GhTaGGU9niKLPKmMhGPVmNy5dV2UyO2SKwXo+y3zzK1WnbpeKkmiCudoKos+AQGJHa0ER+K0WyQfG9qnVut2m8k6cKaPAS6hsEXgFSb0wak4X8pM+YEKY2ghBM9H3wqwIclPdUgIwKFwP+xw1EbgNEtwEn1XLZpuFUYd0jhaTcY=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.0; Wed, 11 Apr 2018 18:37:55 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0696.006; Wed, 11 Apr 2018
 18:37:55 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 3/3] Move reusable parts of memory pool into its own file
Thread-Topic: [PATCH v4 3/3] Move reusable parts of memory pool into its own
 file
Thread-Index: AQHT0cQ0RtptPD8IEkGwvqJO1AaIdA==
Date:   Wed, 11 Apr 2018 18:37:55 +0000
Message-ID: <20180411183738.113809-4-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;7:ooWEKAfgmsLw1ACOs30APtOOfSvSXSXCDoS8VsRFyMTyLBf6PTHlWOljK7/g1p28UW6PQ4YxyQ0F4AXdyLBGNLIhz7JF0RLu4qtj/+X3tlPOj6hFieG3ADwenhsnZ7TPHWYEAs8RYK9fMkTJ3Wt2npchBrz2p1WZ6xjBWfcbc755m21yUgL9Ov0IAqxQu/+NB/ZDjf+zc7y2S4xlJHpvcBZNhxTVwE/kVi6TNrbmQayBhfzZApKPz8SjNyyaJ5XC;20:Viqk2kvyTl3LnAfbB1vlPxvVF3aTVNq2B3aPAEuCOuJLKbHc8rCMRqCwpxAvypuOdTNLiUutAX7sEVFr+mDL0cF0QcKk1uRVFRXxDAqfj8LE93mw4GUq+lgSyxBocJMWZM00Erycdba5nrPl5cl9B6PeHrqhjkPE4mnyxXnQNgM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0995D2131043DDFDB73BB99ACEBD0@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(346002)(396003)(376002)(199004)(189003)(5250100002)(5640700003)(2501003)(6436002)(107886003)(53936002)(6512007)(305945005)(7736002)(6916009)(25786009)(478600001)(10290500003)(5660300001)(4326008)(86612001)(86362001)(3660700001)(2900100001)(1076002)(14454004)(3280700002)(2906002)(6486002)(97736004)(54906003)(106356001)(186003)(2351001)(36756003)(105586002)(22452003)(52116002)(8656006)(99286004)(316002)(68736007)(386003)(102836004)(6506007)(76176011)(486006)(2616005)(46003)(446003)(11346002)(476003)(6116002)(8936002)(1730700003)(10090500001)(8676002)(81156014)(81166006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ei6Xy6jvhG2q38cXysfGBWeZdmVjrItUMxGhW6+av3YzqYvdCO1Om7g+kfvl0YB2YidHbvP5FOB9xK3TtprCRIcAJdrj/IO84UpmTEU3HxlTEgBM13MRa1Bp7nXbOQz5WFzY2bt5rvehuB3injiCJK/S0MIlrc4EN4a8VjBccC0VoMN1asxf+sXUhkx+H+8i3xP1Fvl+ZEjycHnrz2yvfYPq1kXwvze5qHLzP8da2+3kkGxL5Y1ncrfxpiimpZ3cZWWFLBMGUHAJVVraJbFgF1/5iiBnsxx/bf5qjcQ9xABeqIFw/pVFfGno1dzKeWAJ1teo3jY6XLt9+asdIvaVdFTtiwYcCt7AUvhuPVghrdTzAjw9DkGagYbH6f469TKrA5d58dECfg2RuBSsaYTRMWFOfVm31mTCIqnAvz1taxI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5fc5aa8a-6f7b-485b-52d8-08d59fdb56f6
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc5aa8a-6f7b-485b-52d8-08d59fdb56f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 18:37:55.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the reusable parts of the memory pool logic used by
fast-import.c into its own file for use by other components.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 Makefile      |  1 +
 fast-import.c | 70 +------------------------------------------------------=
----
 mem-pool.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h    | 34 +++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 69 deletions(-)
 create mode 100644 mem-pool.c
 create mode 100644 mem-pool.h

diff --git a/Makefile b/Makefile
index f181687250..5aa4f8064f 100644
--- a/Makefile
+++ b/Makefile
@@ -844,6 +844,7 @@ LIB_OBJS +=3D log-tree.o
 LIB_OBJS +=3D mailinfo.o
 LIB_OBJS +=3D mailmap.o
 LIB_OBJS +=3D match-trees.o
+LIB_OBJS +=3D mem-pool.o
 LIB_OBJS +=3D merge.o
 LIB_OBJS +=3D merge-blobs.o
 LIB_OBJS +=3D merge-recursive.o
diff --git a/fast-import.c b/fast-import.c
index 48d4797ab5..05d1079d23 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -170,6 +170,7 @@ Format of STDIN stream:
 #include "run-command.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "mem-pool.h"
=20
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -211,26 +212,6 @@ struct last_object {
 	unsigned no_swap : 1;
 };
=20
-struct mp_block {
-	struct mp_block *next_block;
-	char *next_free;
-	char *end;
-	uintmax_t space[FLEX_ARRAY]; /* more */
-};
-
-struct mem_pool {
-	struct mp_block *mp_block;
-
-	/*
-	 * The amount of available memory to grow the pool by.
-	 * This size does not include the overhead for the mp_block.
-	 */
-	size_t block_alloc;
-
-	/* The total amount of memory allocated by the pool. */
-	size_t pool_alloc;
-};
-
 struct atom_str {
 	struct atom_str *next_atom;
 	unsigned short str_len;
@@ -649,55 +630,6 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
=20
-static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
-{
-	struct mp_block *p;
-
-	mem_pool->pool_alloc +=3D sizeof(struct mp_block) + block_alloc;
-	p =3D xmalloc(st_add(sizeof(struct mp_block), block_alloc));
-	p->next_block =3D mem_pool->mp_block;
-	p->next_free =3D (char *)p->space;
-	p->end =3D p->next_free + block_alloc;
-	mem_pool->mp_block =3D p;
-
-	return p;
-}
-
-static void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
-{
-	struct mp_block *p;
-	void *r;
-
-	/* round up to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
-
-	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
-		if (p->end - p->next_free >=3D len)
-			break;
-
-	if (!p) {
-		if (len >=3D (mem_pool->block_alloc / 2)) {
-			mem_pool->pool_alloc +=3D len;
-			return xmalloc(len);
-		}
-
-		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
-	}
-
-	r =3D p->next_free;
-	p->next_free +=3D len;
-	return r;
-}
-
-static void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size=
_t size)
-{
-	size_t len =3D st_mult(count, size);
-	void *r =3D mem_pool_alloc(mem_pool, len);
-	memset(r, 0, len);
-	return r;
-}
-
 static char *pool_strdup(const char *s)
 {
 	size_t len =3D strlen(s) + 1;
diff --git a/mem-pool.c b/mem-pool.c
new file mode 100644
index 0000000000..389d7af447
--- /dev/null
+++ b/mem-pool.c
@@ -0,0 +1,55 @@
+/*
+ * Memory Pool implementation logic.
+ */
+
+#include "cache.h"
+#include "mem-pool.h"
+
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
+{
+	struct mp_block *p;
+
+	mem_pool->pool_alloc +=3D sizeof(struct mp_block) + block_alloc;
+	p =3D xmalloc(st_add(sizeof(struct mp_block), block_alloc));
+	p->next_block =3D mem_pool->mp_block;
+	p->next_free =3D (char *)p->space;
+	p->end =3D p->next_free + block_alloc;
+	mem_pool->mp_block =3D p;
+
+	return p;
+}
+
+void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
+{
+	struct mp_block *p;
+	void *r;
+
+	/* round up to a 'uintmax_t' alignment */
+	if (len & (sizeof(uintmax_t) - 1))
+		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+
+	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
+		if (p->end - p->next_free >=3D len)
+			break;
+
+	if (!p) {
+		if (len >=3D (mem_pool->block_alloc / 2)) {
+			mem_pool->pool_alloc +=3D len;
+			return xmalloc(len);
+		}
+
+		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
+	}
+
+	r =3D p->next_free;
+	p->next_free +=3D len;
+	return r;
+}
+
+void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size=
)
+{
+	size_t len =3D st_mult(count, size);
+	void *r =3D mem_pool_alloc(mem_pool, len);
+	memset(r, 0, len);
+	return r;
+}
diff --git a/mem-pool.h b/mem-pool.h
new file mode 100644
index 0000000000..829ad58ecf
--- /dev/null
+++ b/mem-pool.h
@@ -0,0 +1,34 @@
+#ifndef MEM_POOL_H
+#define MEM_POOL_H
+
+struct mp_block {
+	struct mp_block *next_block;
+	char *next_free;
+	char *end;
+	uintmax_t space[FLEX_ARRAY]; /* more */
+};
+
+struct mem_pool {
+	struct mp_block *mp_block;
+
+	/*
+	 * The amount of available memory to grow the pool by.
+	 * This size does not include the overhead for the mp_block.
+	 */
+	size_t block_alloc;
+
+	/* The total amount of memory allocated by the pool. */
+	size_t pool_alloc;
+};
+
+/*
+ * Alloc memory from the mem_pool.
+ */
+void *mem_pool_alloc(struct mem_pool *pool, size_t len);
+
+/*
+ * Allocate and zero memory from the memory pool.
+ */
+void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
+
+#endif
--=20
2.14.3

