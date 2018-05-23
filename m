Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899261F42D
	for <e@80x24.org>; Wed, 23 May 2018 14:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933425AbeEWOrx (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 10:47:53 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:26688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933378AbeEWOrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 10:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7aHdCxy6N/uHWEVgXJsXaTOo7YhACFGiaTA1Wh5neg=;
 b=NY0WNDb2yyLyJ5Ns8XIckA5oePadPpj3qaJvnUJpxSzZq8PGTxG5mCPeYBVzQyyKc8uIZ9l0jxKff7QKAdK8ZDHsny6YYSFfs/UiAJK24OMGIbLs69vpVHVf9CEDF8KUAbkrNQ/JMKoc6RNe5/pufO0gdcXRn59LS6BFa9l6zVA=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Wed, 23 May 2018 14:47:40 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0797.007; Wed, 23 May 2018
 14:47:40 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 5/7] mem-pool: fill out functionality
Thread-Topic: [PATCH v3 5/7] mem-pool: fill out functionality
Thread-Index: AQHT8qT/nSBKh5f1CESO913b2S5qFQ==
Date:   Wed, 23 May 2018 14:47:40 +0000
Message-ID: <20180523144637.153551-6-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:znBPGtxYHcnKdBmHK+orCQqgWwH0u+qjDIPJnwODTpcj3di696MpU4yOSpiMmXfQ9Wjurdr57Ll2Jide0hE29RAYHraio/aXrRWrzWDr6Wu6f5rFQnAGJ8Bp4FIeyTPNK1d75An2b82OYDTDEZ6zTdQ4eenNYxOMcbr7AhwLOkq+NpJtrU8h1dadLj3UXAY959jwHGlRli81w8nFhQ3ZgcnoMhveaEer7rsTiX5LMOuI8KcQQrB3DoOot3WMUT/B;20:0zTfSTSgpM+t42Gt2C3019MdtyFHujIwVRzfZEPSLoyiFCTK0HF3/GeCfcySHkYJUH0ox0tOH2Pe/MyNDsdSQV/+gi1Hs4QCvzTMc7WBxczNwxIrtvet1Gp64WNSD1yFrEVsT6StPrcfg0Sh/ZhU0iXIoPY9YmI57sejjjbbopE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09775A3D80730834B6F34E6FCE6B0@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(76176011)(102836004)(99286004)(6506007)(386003)(2501003)(5250100002)(81166006)(81156014)(1730700003)(8676002)(105586002)(8936002)(305945005)(106356001)(97736004)(7736002)(86362001)(476003)(25786009)(2906002)(3660700001)(1076002)(14454004)(486006)(3280700002)(6116002)(446003)(11346002)(186003)(52116002)(2616005)(86612001)(46003)(10090500001)(6512007)(53936002)(2351001)(478600001)(36756003)(5660300001)(4326008)(6916009)(68736007)(6436002)(5640700003)(2900100001)(22452003)(316002)(54906003)(8656006)(39060400002)(10290500003)(107886003)(6486002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m/wieldIGXdzT0HOWxnFq/0ueCOo90ZCwL6JTCqzyeh/ngkk+hGkV4NR7VgyzRN94FpWa7Bi8CdTOAB83erwFTJAew6HZ/WKPZxUKOxTeKhTT9QqR/jj0rJ0H7Q8j3sD7C0TGEmM7k4uQnM0SlJ4oT+njVz3nX4e3Bba+O0Z39E/wMqpIdxH48QQ2VnapeLh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e5829655-ed3b-480f-5542-08d5c0bc216f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5829655-ed3b-480f-5542-08d5c0bc216f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 14:47:40.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add functions for:

    - combining two memory pools

    - determining if a memory address is within the range managed by a
      memory pool

These functions will be used by future commits.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 40 ++++++++++++++++++++++++++++++++++++++++
 mem-pool.h | 13 +++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/mem-pool.c b/mem-pool.c
index 01595bcca5..cc7d3a7ab1 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -108,3 +108,43 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_=
t count, size_t size)
 	memset(r, 0, len);
 	return r;
 }
+
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
+{
+	struct mp_block *p;
+
+	/* Check if memory is allocated in a block */
+	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
+		if ((mem >=3D ((void *)p->space)) &&
+		    (mem < ((void *)p->end)))
+			return 1;
+
+	return 0;
+}
+
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
+{
+	/* Append the blocks from src to dst */
+	if (dst->mp_block && src->mp_block) {
+		/*
+		 * src and dst have blocks, append
+		 * blocks from src to dst.
+		 */
+		dst->mp_block_tail->next_block =3D src->mp_block;
+		dst->mp_block_tail =3D src->mp_block_tail;
+	} else if (src->mp_block) {
+		/*
+		 * src has blocks, dst is empty
+		 * use pointers from src to set up dst.
+		 */
+		dst->mp_block =3D src->mp_block;
+		dst->mp_block_tail =3D src->mp_block_tail;
+	} else {
+		// src is empty, nothing to do.
+	}
+
+	dst->pool_alloc +=3D src->pool_alloc;
+	src->pool_alloc =3D 0;
+	src->mp_block =3D NULL;
+	src->mp_block_tail =3D NULL;
+}
diff --git a/mem-pool.h b/mem-pool.h
index 5d3e6a367a..5c892d3bdb 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -41,4 +41,17 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
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

