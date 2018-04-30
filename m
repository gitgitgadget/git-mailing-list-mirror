Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799E1215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeD3Pby (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:31:54 -0400
Received: from mail-by2nam01on0133.outbound.protection.outlook.com ([104.47.34.133]:50446
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754524AbeD3Pbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ipZOEYya9V54RQ/4BAVTgU/HiE8XkQ4hG8zkFPkLjEo=;
 b=PuyG3EaU8BoNeIma3101UMzSJ1vSr1wTvBDv2SOZ/L+raSFP4c3OkYuxNA4UqSyxkwhxOvSgpmtUfCtg+I3JIyYxx0zrIiGR/nhhnCqopjPPrRMnWy7v1yhACSA3/xk4NmD2fPqBB4osaOoUDCrLtZc8kcqkBtsuHgagcOU+RN4=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.4; Mon, 30 Apr 2018 15:31:45 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.002; Mon, 30 Apr 2018
 15:31:45 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 5/5] block alloc: add validations around cache_entry
 lifecyle
Thread-Topic: [PATCH v2 5/5] block alloc: add validations around cache_entry
 lifecyle
Thread-Index: AQHT4JhYat2eJw0F006J+r4PXfM5ug==
Date:   Mon, 30 Apr 2018 15:31:45 +0000
Message-ID: <20180430153122.243976-6-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:0IhLh5c8U3oMZvfUT0pVAWmx/ALzUpCcnFPoEQHWuEXw0TUSu0qvzQrR+54kFnT++r71wjsVVxERFg4dbfNRFECiFs2zl5PZwZ7ESBNZl39aG+G9rnYBkMJKpqpvlebI17bfX4NR0b2pyvO5N5a+wK0aLA7+8lGDYFzzXbm88jt80uka24Kzm3IcGT1wByMM3PQU+xJliAVJIREC876yUrnPksZVrpDXyeTldUwHlev25+xxKtVDi7d5TDd8XWkR;20:RXqoB2RtO2Fui2340RbiqMkISLrIAbQsZOLTZM6bZScI0g7Bwmi7/zhZXY/8I1TB8VKUpkNF8Q6d6NNInOPZS8XcIYWOja3pY1JwQDQPnl6tw1WQLuqcrpMMbfBOsvbJHFNcwRL6jrqcsMKBNCGtJqz0KAqV5oZQ7h97xHTo5CY=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1012DFEE75078C25C6E8211BCE820@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(10090500001)(6506007)(3660700001)(386003)(59450400001)(1730700003)(7736002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8936002)(8676002)(186003)(3280700002)(476003)(2616005)(97736004)(446003)(11346002)(6116002)(86612001)(106356001)(46003)(99286004)(4326008)(102836004)(6916009)(105586002)(76176011)(1076002)(107886003)(2351001)(14454004)(54906003)(2906002)(6512007)(2900100001)(53936002)(36756003)(5640700003)(10290500003)(316002)(25786009)(39060400002)(8656006)(478600001)(68736007)(22452003)(5250100002)(486006)(6486002)(86362001)(2501003)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PZTYXGc/7D57r3W/j/xJ/tJScoa1etaOqDIGmqAJCczDmXVRXzaokldmAfZTllGJnKdR+gXUcZe732F0lHC/2mWiZn5HsuBKxB0Pc1TI2MIS0HNGcoLJZaBIFsy1ffp3+XSdSJ5DZNgiH7+Bsb2DMhVuEQVOBTToE4pczvbs6j4J03iwBpNtup1MLg/+LePo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cb4ee143-100c-4104-c683-08d5aeaf7ad5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4ee143-100c-4104-c683-08d5aeaf7ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 15:31:45.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
 cache.h      |  7 +++++++
 git.c        |  3 +++
 mem-pool.c   | 24 +++++++++++++++++++++++-
 mem-pool.h   |  2 ++
 read-cache.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 7ed68f28e0..8f10f0649b 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,13 @@ void discard_index_cache_entry(struct cache_entry *ce)=
;
  */
 void discard_transient_cache_entry(struct cache_entry *ce);
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
index f598fae7b7..28ec7a6c4f 100644
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
index a495885c4b..77adb5d5b9 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -60,21 +60,43 @@ void mem_pool_discard(struct mem_pool *mem_pool)
 {
 	int i;
 	struct mp_block *block, *block_to_free;
+	int invalidate_memory =3D should_validate_cache_entries();
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
-	for (i =3D 0; i < mem_pool->nr; i++)
+	for (i =3D 0; i < mem_pool->nr; i++) {
+		memset(mem_pool->custom[i], 0xDD, ((char *)mem_pool->custom_end[i]) - ((=
char *)mem_pool->custom[i]));
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
index 01cd7fea41..e1dc9f7f33 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1270,6 +1270,8 @@ int add_index_entry(struct index_state *istate, struc=
t cache_entry *ce, int opti
 {
 	int pos;
=20
+	validate_cache_entries(istate);
+
 	if (option & ADD_CACHE_JUST_APPEND)
 		pos =3D istate->cache_nr;
 	else {
@@ -1290,6 +1292,8 @@ int add_index_entry(struct index_state *istate, struc=
t cache_entry *ce, int opti
 			   istate->cache_nr - pos - 1);
 	set_index_entry(istate, pos, ce);
 	istate->cache_changed |=3D CE_ENTRY_ADDED;
+
+	validate_cache_entries(istate);
 	return 0;
 }
=20
@@ -2013,6 +2017,8 @@ int is_index_unborn(struct index_state *istate)
=20
 int discard_index(struct index_state *istate)
 {
+	validate_cache_entries(istate);
+
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
 	istate->cache_changed =3D 0;
@@ -2035,6 +2041,43 @@ int discard_index(struct index_state *istate)
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
@@ -2828,6 +2871,10 @@ void move_index_extensions(struct index_state *dst, =
struct index_state *src)
  */
 void discard_index_cache_entry(struct cache_entry *ce)
 {
+	int invalidate_cache_entry =3D should_validate_cache_entries();
+
+	if (ce && invalidate_cache_entry)
+		memset(ce, 0xCD, cache_entry_size(ce->ce_namelen));
 }
=20
 void discard_transient_cache_entry(struct cache_entry *ce)
--=20
2.14.3

