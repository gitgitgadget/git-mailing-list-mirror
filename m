Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716F61F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeGBTt6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:49:58 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:42044
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753065AbeGBTti (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeEDKhL+6/YE6H2a/gaSYRWZpfy6OSCJJ5MYMdu50Tk=;
 b=dlbs7YApSxb1B6SnNn7A7Gj1bCT5iJ+w8l/MNcqXwuzJGketYbdo/NAqhJCLszH1UYacjlp7qOjTXyLI7q/6xrfyYR1e9VdfqokPb4xyw5PhfA64oIn/fm2uTqCTAEjJrGhOS/NmmBpXKW4Kag4xlqfqzD+1J9vc8vMpaDw15rY=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0284.namprd21.prod.outlook.com (10.173.174.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 19:49:36 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989%4]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 19:49:36 +0000
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
Subject: [PATCH v6 6/8] mem-pool: fill out functionality
Thread-Topic: [PATCH v6 6/8] mem-pool: fill out functionality
Thread-Index: AQHUEj3Nxs0wc8vMHE2MphPKXGaoBg==
Date:   Mon, 2 Jul 2018 19:49:35 +0000
Message-ID: <20180702193745.8940-7-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0284;7:/Pugjfw+1gzCzne2h9KMHOeINl6+Uvbv8AMcEC8E/UAnWag0C4cYWcWQJo/tZ73j76St+FmF3+XDaPGEN7IEYlh95OXRdPJNk32pj7D2fS7aiSGvPTlJh15s3Aeu/LY3caCajl1RznlFByB5uHawdavMtKlX5tzW988KAsUAXSF3RvbJ/ynon3oqYYF4T3JAU295gGxqfSPHPNO5HI80pZHeGVxUi56yU0nzudLBRUZzMCFxRdfn9fEplYclTqgN
x-ms-office365-filtering-correlation-id: 1fd17666-6ae5-4c7e-1ef2-08d5e054f03a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0284;
x-ms-traffictypediagnostic: DM5PR21MB0284:
x-microsoft-antispam-prvs: <DM5PR21MB02847E014E85B09DC19C8795CE430@DM5PR21MB0284.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0284;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0284;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(36756003)(316002)(22452003)(86612001)(37006003)(86362001)(54906003)(256004)(99286004)(446003)(11346002)(476003)(2906002)(2616005)(10290500003)(4326008)(14454004)(25786009)(39060400002)(6862004)(486006)(10090500001)(53936002)(478600001)(5660300001)(76176011)(5250100002)(102836004)(6200100001)(386003)(6506007)(6436002)(6512007)(8936002)(305945005)(52116002)(68736007)(1076002)(2900100001)(105586002)(8676002)(81156014)(81166006)(6116002)(7049001)(1511001)(97736004)(46003)(6486002)(106356001)(7736002)(6346003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0284;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: 8pukveppaIOB35z4KrGZeM9bq+FN+aVOtpJk9ShRGx5/UQhTsidZJdK+2y1JhzmRr5ZxvBXMmRM1Lxzsd7RIQ+sYjy40NeDjaTbZHQ7MU1ENHa/jBbUFpGQgttwA40JfxUZ7gnuEcqInw6ayXdrokH3+R+phcdwPC6atr9dj0GpmPmZgh76XVAvOOj69gg9O0nvUKPg8jF9xQkRA+v7ezS6BvTDSy7PolaS5ycyPzx2dJpLBTmHpwyVAGeDzYhEA2Pj0l6Ld9hvnq2NcRa4iMC4w7HXqpx2lsNCZFRCCcJ0CbN92Pj6La506VzYp4st2qoACWGtfo/ad6MS+J/iT/b6yi2nX8bgeXSza2qmY0rQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd17666-6ae5-4c7e-1ef2-08d5e054f03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 19:49:35.9539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0284
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
 mem-pool.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h | 13 +++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/mem-pool.c b/mem-pool.c
index 1769400d2d..b250a5fe40 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -96,3 +96,45 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t =
count, size_t size)
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
+	struct mp_block *p;
+
+	/* Append the blocks from src to dst */
+	if (dst->mp_block && src->mp_block) {
+		/*
+		 * src and dst have blocks, append
+		 * blocks from src to dst.
+		 */
+		p =3D dst->mp_block;
+		while (p->next_block)
+			p =3D p->next_block;
+
+		p->next_block =3D src->mp_block;
+	} else if (src->mp_block) {
+		/*
+		 * src has blocks, dst is empty.
+		 */
+		dst->mp_block =3D src->mp_block;
+	} else {
+		/* src is empty, nothing to do. */
+	}
+
+	dst->pool_alloc +=3D src->pool_alloc;
+	src->pool_alloc =3D 0;
+	src->mp_block =3D NULL;
+}
diff --git a/mem-pool.h b/mem-pool.h
index f75b3365d5..adeefdcb28 100644
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
2.17.1

