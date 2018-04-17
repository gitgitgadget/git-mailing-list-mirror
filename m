Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1033D1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbeDQQfF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:35:05 -0400
Received: from mail-dm3nam03on0122.outbound.protection.outlook.com ([104.47.41.122]:13033
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755113AbeDQQey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=s5YopF9ySS/ICh3TYEmbGgijpB6lXHnX/aysPfb8aIo=;
 b=KmAaAxS87U2OH2KYJivRMrjNhilbjmT4DiQUz2Ppb/KGGxQFQP84iPbzVfLzSHiPO4TPOff4oe4vcZomZjksZTc7qxdwsCdG0PLi6OvoGSNfh5hgHSNSzDcK+kCaoF4MPNEZ3aDx/reKlZ5YxQ8JdK1FS7y1ggNKQYHjtByX1NY=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0899.namprd21.prod.outlook.com (52.132.23.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 16:34:46 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 16:34:46 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v1 5/5] Add optional memory validations around cache_entry
 lifecyle
Thread-Topic: [PATCH v1 5/5] Add optional memory validations around
 cache_entry lifecyle
Thread-Index: AQHT1mn9b9A3C/vfPkuDxx2nglu3xQ==
Date:   Tue, 17 Apr 2018 16:34:43 +0000
Message-ID: <20180417163400.3875-7-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0899;7:nTrgCOleBxhAz5+Q/q0nUhDty/WD5hJw1VCFkd8r75vPqaEJAa6iTyd+1uQoSaP/eloZvle6T95k9hJ31UGIX9HyOc8S1Q/wmVvf48rNp2FsIS8dOrAqYZpKQKIwUJk9jrXboPSBWmiaqL0m/Q5KzOrDekVLb0CPVFPhkd6Xk/GwncMFGj5xaawpxPjlJAPycj5xqa+sJgxzB+frRP9PDQJ4VTRcFE6cP5nZ/WCQQCGAEQVhq2KrSmKrMpzw6X3I;20:8wofd1nvRie9/VydILEXQxsZGBOliApZUnOc32/F7IiAfT5x3hhV2FcJ6OP9q1B4W6/OB+1eaoPMXMB6wB0nHAmmQmJT+AwjKAOn+E39Lzkjd9Exun/iYKiR3cs/IgaKkT7XJIaUVyA8T/Uxqa7OQA2q0ifrx3ESpdAWtNw70is=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0899;
x-ms-traffictypediagnostic: BL0PR2101MB0899:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0899CD5B6AEBCCD87C4BE8EFCEB70@BL0PR2101MB0899.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0899;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0899;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(7736002)(6116002)(5640700003)(2351001)(14454004)(6512007)(97736004)(8656006)(6486002)(53936002)(2906002)(4326008)(5660300001)(106356001)(39060400002)(6436002)(36756003)(107886003)(6666003)(6916009)(305945005)(1076002)(3280700002)(99286004)(22452003)(478600001)(59450400001)(316002)(476003)(446003)(2616005)(486006)(54906003)(6506007)(5250100002)(386003)(11346002)(10290500003)(575784001)(2900100001)(3660700001)(81166006)(81156014)(1730700003)(86362001)(8676002)(8936002)(10090500001)(186003)(68736007)(25786009)(46003)(86612001)(52116002)(76176011)(102836004)(105586002)(2501003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0899;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MkIKTHaScthmAsQs5MLXvy57+JRq7RxzrilJaywqMOXIfzAZ+VFuWc6qU2vzrNd6XG8SHFyxVq4xv41+e2NrNaEiWvFCULftYRCHfXHFiZIeeKg3k5YzT9VwSzYhsnxp7SrTGKneM0DbTH72vZGPO0INJqGJUwYtMw0TFzyiwWO8jQ5KqO6W2QBpBWDgMNA7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 227bcb9e-ff52-42f7-b59a-08d5a4811fb4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227bcb9e-ff52-42f7-b59a-08d5a4811fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:34:43.6489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0899
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
---
 cache.h      |  7 +++++++
 git.c        |  3 +++
 mem-pool.c   | 35 ++++++++++++++++++++++++++++++++++-
 mem-pool.h   |  2 ++
 read-cache.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 7c0d2343c3..f8934d8113 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,13 @@ void index_cache_entry_discard(struct cache_entry *ce)=
;
  */
 void transient_cache_entry_discard(struct cache_entry *ce);
=20
+/*
+ * Validate the cache entries in the index.  This is an internal
+ * consistency check that the cache_entry structs are allocated from
+ * the expected memory pool.
+ */
+void validate_cache_entries(const struct index_state *istate);
+
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
 #define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
diff --git a/git.c b/git.c
index 3a89893712..16b6c1685b 100644
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
index 09fb78d093..a7e28934b0 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -60,20 +60,44 @@ void mem_pool_discard(struct mem_pool *mem_pool)
 {
 	int i;
 	struct mp_block *block, *block_to_free;
+	int invalidate_memory =3D should_validate_cache_entries();
+
 	for (block =3D mem_pool->mp_block; block;) {
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
-	for (i =3D 0; i < mem_pool->nr; i++)
+	for (i =3D 0; i < mem_pool->nr; i++) {
+		if (invalidate_memory)
+			memset(mem_pool->custom[i], 0xDD, ((char *)mem_pool->custom_end[i]) - (=
(char *)mem_pool->custom[i]));
+
 		free(mem_pool->custom[i]);
+	}
=20
 	free(mem_pool->custom);
 	free(mem_pool->custom_end);
 	free(mem_pool);
 }
=20
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
+
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p;
@@ -110,11 +134,20 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size=
_t count, size_t size)
 int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
 {
 	struct mp_block *p;
+	int i;
+
+	/* Check if memory is allocated in a block */
 	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
 		if ((mem >=3D ((void *)p->space)) &&
 		    (mem < ((void *)p->end)))
 			return 1;
=20
+	/* Check custom memory allocations */
+	for (i =3D 0; i < mem_pool->nr; i++)
+		if (mem >=3D mem_pool->custom[i] &&
+		    mem < mem_pool->custom_end[i])
+			return 1;
+
 	return 0;
 }
=20
diff --git a/mem-pool.h b/mem-pool.h
index 34df4fa709..b1f9a920ba 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -63,4 +63,6 @@ void mem_pool_combine(struct mem_pool *dst, struct mem_po=
ol *src);
  */
 int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
=20
+int should_validate_cache_entries(void);
+
 #endif
diff --git a/read-cache.c b/read-cache.c
index 67438bf375..d2181a0334 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1290,6 +1290,7 @@ int add_index_entry(struct index_state *istate, struc=
t cache_entry *ce, int opti
 			   istate->cache_nr - pos - 1);
 	set_index_entry(istate, pos, ce);
 	istate->cache_changed |=3D CE_ENTRY_ADDED;
+
 	return 0;
 }
=20
@@ -2013,6 +2014,8 @@ int is_index_unborn(struct index_state *istate)
=20
 int discard_index(struct index_state *istate)
 {
+	validate_cache_entries(istate);
+
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
 	istate->cache_changed =3D 0;
@@ -2035,6 +2038,43 @@ int discard_index(struct index_state *istate)
 	return 0;
 }
=20
+
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
+	int validate_index_cache_entries =3D should_validate_cache_entries();
+
+	if (!validate_index_cache_entries)
+		return;
+
+	if (!istate || !istate->initialized)
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
@@ -2828,6 +2868,10 @@ void move_index_extensions(struct index_state *dst, =
struct index_state *src)
  */
 void index_cache_entry_discard(struct cache_entry *ce)
 {
+	int invalidate_cache_entry =3D should_validate_cache_entries();
+
+	if (ce && invalidate_cache_entry)
+		memset(ce, 0xCD, cache_entry_size(ce->ce_namelen));
 }
=20
 void transient_cache_entry_discard(struct cache_entry *ce)
--=20
2.14.3

