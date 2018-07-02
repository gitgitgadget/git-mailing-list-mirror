Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD231F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeGBTtn (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:49:43 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:42044
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753033AbeGBTth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUIj+1UrLMhhV43k8MN/UBwY4gj8agm9FnDM05skLVE=;
 b=Bs2DLgOda/o1DTj7XSpzj4NsxhtNL1bGIPXu76ZxYRA1qv7ohf5zHU4RgSPk3ienu/xK+1LzCAbOKyBFSAlYCaG1Ch2pOUAYOCdPwazrS9AtjhIdibnHytsjU6ybQf6+XMkSwU3x5M1pYgYC0aN/OpmOD+ObYJ4OSu6zeMRxPA0=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0284.namprd21.prod.outlook.com (10.173.174.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 19:49:34 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989%4]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 19:49:34 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>
Subject: [PATCH v6 5/8] mem-pool: add life cycle management functions
Thread-Topic: [PATCH v6 5/8] mem-pool: add life cycle management functions
Thread-Index: AQHUEj3NljL4LkYvokm5nKRImlNWUw==
Date:   Mon, 2 Jul 2018 19:49:34 +0000
Message-ID: <20180702193745.8940-6-jamill@microsoft.com>
References: <20180628135932.225288-1-jamill@microsoft.com>
 <20180702193745.8940-1-jamill@microsoft.com>
In-Reply-To: <20180702193745.8940-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN3PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:400:4::25) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0284;7:fYYyH7xVJdcNy8viHgc3fACvgKO+U2D2EE7D4h3BQCWPQ28klUhvb49aOUVofCm3xZLJEtpwhDOAH4hfyjQ7eBvADGKWaN1eaWCjuXDeTMwVw0bRANeAWe6YfGMGZV+Pp4qNs3LHDpn7fyVBwrDqJZ4ZtR7tEvP3KQ389aCzvJNVIlC6dn7nqht10QScx9zrjCvRiDv2WlxL2TJgWkgEYvXsG4GoIM8eKBFhHCYuD3oq6H/aumMaR2qCc2xR6lGj
x-ms-office365-filtering-correlation-id: 762711ed-eb22-4663-15b3-08d5e054ef6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0284;
x-ms-traffictypediagnostic: DM5PR21MB0284:
x-microsoft-antispam-prvs: <DM5PR21MB02847611AE6BDBDC14AE04AFCE430@DM5PR21MB0284.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0284;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0284;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(36756003)(316002)(22452003)(86612001)(37006003)(86362001)(54906003)(14444005)(256004)(99286004)(446003)(11346002)(476003)(2906002)(2616005)(10290500003)(4326008)(14454004)(25786009)(39060400002)(6862004)(486006)(10090500001)(53936002)(478600001)(5660300001)(76176011)(5250100002)(102836004)(6200100001)(386003)(6506007)(6436002)(6512007)(8936002)(305945005)(52116002)(68736007)(1076002)(2900100001)(105586002)(8676002)(81156014)(81166006)(6116002)(7049001)(1511001)(97736004)(46003)(6486002)(106356001)(7736002)(6346003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0284;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: yxJ8B3dCjoBu2iCd4zQ94ylamONbXmctcztnia3ytUphJ0D3Ker3WZSMO60CzlHuyHdKMpN93ckk1PystB/5y8MFjGS/nlwS6+fHvMFqwn0fbFt0seXMxtJsr9/dBGfeeUsrm1p8dufRS1/lHSSI1Sb/ZYKjX4IfLtFhudJ1lvq8/Pp0wSCytW3WFR4uRtKrkZimdu00pPun2psrGyuGntTAycmVrVyI5NxSrd/FUjfFF06+pyMsfy+1HKOSkp+T8EMGZqm0JnLWNedPSdaekFbknt4dZy9XU/G4M8oPCLB+ipv26JkoR86HeA8EpW+tRswiwYXU3WuZvrgstOAWVWYd9IO2J/+99FXOZRrNu3w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762711ed-eb22-4663-15b3-08d5e054ef6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 19:49:34.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0284
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add initialization and discard functions to mem_pool type. As the
memory allocated by mem_pool can now be freed, we also track the large
allocations.

If the there are existing mp_blocks in the mem_poo's linked list of
mp_blocksl, then the mp_block for a large allocation is inserted
behind the head block. This is because only the head mp_block is considered
when searching for availble space. This results in the following
desirable properties:

1) The mp_block allocated for the large request will not be included
not included in the search for available in future requests, the large
mp_block is sized for the specific request and does not contain any
spare space.

2) The head mp_block will not bumped from considation for future
memory requests just because a request for a large chunk of memory
came in.

These changes are in preparation for a future commit that will utilize
creating and discarding memory pool.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++--------
 mem-pool.h | 10 +++++++++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index c80124f1fe..1769400d2d 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,20 +5,65 @@
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
=20
 	mem_pool->pool_alloc +=3D sizeof(struct mp_block) + block_alloc;
 	p =3D xmalloc(st_add(sizeof(struct mp_block), block_alloc));
-	p->next_block =3D mem_pool->mp_block;
+
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
@@ -33,12 +78,10 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t =
len)
 		p =3D mem_pool->mp_block;
=20
 	if (!p) {
-		if (len >=3D (mem_pool->block_alloc / 2)) {
-			mem_pool->pool_alloc +=3D len;
-			return xmalloc(len);
-		}
+		if (len >=3D (mem_pool->block_alloc / 2))
+			return mem_pool_alloc_block(mem_pool, len, mem_pool->mp_block);
=20
-		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
+		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc, NULL);
 	}
=20
 	r =3D p->next_free;
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
2.17.1

