Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2D61F42D
	for <e@80x24.org>; Wed, 23 May 2018 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933469AbeEWOr7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 10:47:59 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:26688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933422AbeEWOrt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 10:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnRZoIMVLy6g7Tjob05b1STHeDGbO78Inje+3qd45Rs=;
 b=SeaKnpLAFWPEtsRmpMk3755gtcovRw8jgr6vHPh5W78PA6dGtldFDxQ8fE5D+9datk+faWoU8x5vXYXJ647GnEDHUchf6VN2uOw7dTYfEu0dYs8rybQ0ncSf0g5cHZu0bZ7WWpJSyCtAMUny6fCZ4HIIcubRndVdOixZqanO5sg=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Wed, 23 May 2018 14:47:42 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0797.007; Wed, 23 May 2018
 14:47:42 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 7/7] block alloc: add validations around cache_entry
 lifecyle
Thread-Topic: [PATCH v3 7/7] block alloc: add validations around cache_entry
 lifecyle
Thread-Index: AQHT8qUA7o5NSKL4CEu2/hvW6f5gfA==
Date:   Wed, 23 May 2018 14:47:42 +0000
Message-ID: <20180523144637.153551-8-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:Eho5VPF6xgh/ti8Igs12cwzI5EB2Bbn2MZtOryyvjZ80BxlwfxWpqMWjKOWAoPQTw4yGdsUqHfIVcbXy4X8DLdAXNLnjR/Q8EH6erkiQ/uWdDNHpAEDY8bON7D+3WE6e9GILaOPH/wvig3vat2WIc0km+XL7ia6tpXgPmCtyCJ0NPYs+s8/CVb6X+ckoaHqdHsnTQ4TJIUPO0hasAFc7l7JuSiQcmxCUbZi2+tJME2+UijaAUgtbbMYcCspnB5bc;20:/8f5KVkCcCU0DhPXPb5IRTM6j21NDMe/1+MAldqC1b2/NncarvCrto5v/CtBWf1JpYKiHm68fZ3YM9H1IlT5aW2EhE+XEnQzc+Wv0Zj6zsVPG2aplyT2dqkDTiZmTFcWpq8qJwnd3EHmSwI9iig6QdonOwa+y8SgANohGnlXcWo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0977360DD4C542414800A385CE6B0@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(76176011)(102836004)(99286004)(59450400001)(6506007)(386003)(2501003)(5250100002)(81166006)(81156014)(1730700003)(8676002)(105586002)(8936002)(305945005)(106356001)(97736004)(7736002)(86362001)(476003)(25786009)(2906002)(3660700001)(1076002)(14454004)(486006)(3280700002)(6116002)(446003)(11346002)(186003)(52116002)(2616005)(86612001)(46003)(10090500001)(6512007)(53936002)(2351001)(478600001)(36756003)(5660300001)(4326008)(6916009)(68736007)(6436002)(5640700003)(2900100001)(22452003)(316002)(54906003)(8656006)(39060400002)(10290500003)(107886003)(6486002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ciMQ18IaFkJv0JhG1lQccKL9x3d66bfdnLr35/SC7HrlogV5fnvTkKPHkQ9oS2xI81EzAr5GFtdeTrwCMvgzJl1WgcRqwEPvWiS5gYSn1IkCwtCFfrrf+8zuvlJK0Mwa895uM4QD0jY/4I5S8GTEI/V7ph0OFWl7EZq+aG7X3iSDN115LMLvAl/qfKXFEMhy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a0325b0a-2135-49d6-7af5-08d5c0bc2331
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0325b0a-2135-49d6-7af5-08d5c0bc2331
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 14:47:42.6207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option (controlled by an environment variable) perform extra
validations on mem_pool allocated cache entries. When set:

  1) Invalidate cache_entry memory when discarding cache_entry.

  2) When discarding index_state struct, verify that all cache_entries
     were allocated from expected mem_pool.

  3) When discarding mem_pools, invalidate mem_pool memory.

This should provide extra checks that mem_pools and their allocated
cache_entries are being used as expected.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 cache.h      |  6 ++++++
 git.c        |  3 +++
 mem-pool.c   |  7 ++++++-
 mem-pool.h   |  2 +-
 read-cache.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 7aae9c8db0..2916e953ad 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,12 @@ extern struct cache_entry *make_empty_transient_cache_=
entry(size_t name_len);
  */
 void discard_cache_entry(struct cache_entry *ce);
=20
+/*
+ * Check configuration if we should perform extra validation on cache
+ * entries.
+ */
+int should_validate_cache_entries(void);
+
 /*
  * Duplicate a cache_entry. Allocate memory for the new entry from a
  * memory_pool. Takes into account cache_entry fields that are meant
diff --git a/git.c b/git.c
index bab6bbfded..7ce65eab78 100644
--- a/git.c
+++ b/git.c
@@ -347,7 +347,10 @@ static int run_builtin(struct cmd_struct *p, int argc,=
 const char **argv)
=20
 	trace_argv_printf(argv, "trace: built-in: git");
=20
+	validate_cache_entries(&the_index);
 	status =3D p->fn(argc, argv, prefix);
+	validate_cache_entries(&the_index);
+
 	if (status)
 		return status;
=20
diff --git a/mem-pool.c b/mem-pool.c
index cc7d3a7ab1..6770b4f740 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -63,13 +63,18 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t i=
nitial_size)
 	*mem_pool =3D pool;
 }
=20
-void mem_pool_discard(struct mem_pool *mem_pool)
+void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
 {
 	struct mp_block *block, *block_to_free;
+
 	for (block =3D mem_pool->mp_block; block;)
 	{
 		block_to_free =3D block;
 		block =3D block->next_block;
+
+		if (invalidate_memory)
+			memset(block_to_free->space, 0xDD, ((char *)block_to_free->end) - ((cha=
r *)block_to_free->space));
+
 		free(block_to_free);
 	}
=20
diff --git a/mem-pool.h b/mem-pool.h
index 5c892d3bdb..68d8428902 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -29,7 +29,7 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t ini=
tial_size);
 /*
  * Discard a memory pool and free all the memory it is responsible for.
  */
-void mem_pool_discard(struct mem_pool *mem_pool);
+void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory);
=20
 /*
  * Alloc memory from the mem_pool.
diff --git a/read-cache.c b/read-cache.c
index 02fe5d333c..fb2cec6ac6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2023,8 +2023,10 @@ int discard_index(struct index_state *istate)
 	 * Cache entries in istate->cache[] should have been allocated
 	 * from the memory pool associated with this index, or from an
 	 * associated split_index. There is no need to free individual
-	 * cache entries.
+	 * cache entries. validate_cache_entries can detect when this
+	 * assertion does not hold.
 	 */
+	validate_cache_entries(istate);
=20
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
@@ -2041,13 +2043,45 @@ int discard_index(struct index_state *istate)
 	istate->untracked =3D NULL;
=20
 	if (istate->ce_mem_pool) {
-		mem_pool_discard(istate->ce_mem_pool);
+		mem_pool_discard(istate->ce_mem_pool, should_validate_cache_entries());
 		istate->ce_mem_pool =3D NULL;
 	}
=20
 	return 0;
 }
=20
+/*
+ * Validate the cache entries of this index.
+ * All cache entries associated with this index
+ * should have been allocated by the memory pool
+ * associated with this index, or by a referenced
+ * split index.
+ */
+void validate_cache_entries(const struct index_state *istate)
+{
+	int i;
+
+	if (!should_validate_cache_entries() ||!istate || !istate->initialized)
+		return;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		if (!istate) {
+			die("internal error: cache entry is not allocated from expected memory =
pool");
+		} else if (!istate->ce_mem_pool ||
+			!mem_pool_contains(istate->ce_mem_pool, istate->cache[i])) {
+			if (!istate->split_index ||
+				!istate->split_index->base ||
+				!istate->split_index->base->ce_mem_pool ||
+				!mem_pool_contains(istate->split_index->base->ce_mem_pool, istate->cac=
he[i])) {
+				die("internal error: cache entry is not allocated from expected memory=
 pool");
+			}
+		}
+	}
+
+	if (istate->split_index)
+		validate_cache_entries(istate->split_index->base);
+}
+
 int unmerged_index(const struct index_state *istate)
 {
 	int i;
@@ -2854,8 +2888,25 @@ struct cache_entry *dup_cache_entry(const struct cac=
he_entry *ce,
  */
 void discard_cache_entry(struct cache_entry *ce)
 {
+	if (ce && should_validate_cache_entries())
+		memset(ce, 0xCD, cache_entry_size(ce->ce_namelen));
+
 	if (ce && ce->mem_pool_allocated)
 		return;
=20
 	free(ce);
 }
+
+int should_validate_cache_entries(void)
+{
+	static int validate_index_cache_entries =3D -1;
+
+	if (validate_index_cache_entries < 0) {
+		if (getenv("GIT_TEST_VALIDATE_INDEX_CACHE_ENTRIES"))
+			validate_index_cache_entries =3D 1;
+		else
+			validate_index_cache_entries =3D 0;
+	}
+
+	return validate_index_cache_entries;
+}
--=20
2.14.3

