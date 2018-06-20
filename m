Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44DF71F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeFTURq (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:17:46 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:45030
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933190AbeFTURd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsqLKUDaIeDVPxm+/YOWzyBFMsyMYXbfp6Btiq0vYkY=;
 b=UXlI86EmFWqEryqVBhvktwAiC+e+lM6nwAAQ9qC26bO8kRnyexKRQ32LIrh/hseUqZBAxSk3srO4tj6EI45on7c3nTfETj8Ko2ccNp0w06IazHTuSl0tYwnSoahxo+a0dEQaZuki29HsqGFA3bSizZXh2XiAU615vAHRMNaYFhA=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0746.namprd21.prod.outlook.com (10.173.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.1; Wed, 20 Jun 2018 20:17:31 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 20:17:31 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 6/8] mem-pool: fill out functionality
Thread-Topic: [PATCH v4 6/8] mem-pool: fill out functionality
Thread-Index: AQHUCNO359Qeda3N2kCTBNaNCq1WFw==
Date:   Wed, 20 Jun 2018 20:17:31 +0000
Message-ID: <20180620201557.77155-7-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0746;7:qV2H731qMto4V6Emz67CE+jEKoacC/5Z0DIN4+4gyluva54N3yl6WDQTVG/F0Xq6fApNdh/eQl0BTOXsEiGzyQXK9qJyOaNnz40khTWwaxudyW/tOktJBIs/jX8k+qEQGH8S0jDQ0VojcNccAmwC34/cxOGD+5Za5mGO809ZyBoi1/zWPM/KVE2k7kxWxLb/usSCQVFuyPeJ5o4TMXHYS+maNP8FwNr45kF2pXNgxPQ1xmLstKedqKfo0ZY8dTrT
x-ms-office365-filtering-correlation-id: c2ca7310-9b01-4951-e6af-08d5d6ead9f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0746;
x-ms-traffictypediagnostic: DM5PR21MB0746:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB074630D52158886F1E5D516BCE770@DM5PR21MB0746.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0746;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0746;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(199004)(189003)(10290500003)(8676002)(305945005)(14454004)(76176011)(11346002)(7736002)(68736007)(4326008)(5660300001)(39060400002)(25786009)(6916009)(52116002)(53936002)(106356001)(36756003)(8936002)(8656006)(1730700003)(22452003)(81156014)(386003)(186003)(2616005)(54906003)(316002)(102836004)(6506007)(446003)(478600001)(99286004)(81166006)(486006)(476003)(107886003)(2351001)(3660700001)(6486002)(46003)(97736004)(6512007)(2900100001)(86612001)(6436002)(6116002)(1076002)(5640700003)(3280700002)(5250100002)(2906002)(105586002)(10090500001)(2501003)(86362001)(22906009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0746;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U1RGe47XmblizihAOgZ3P5829zGgO9WXfLgOJEv/DlUuakpe5HvcoisTZUEowfv3fnOoCuWrEIR3h2qcMKfPoYFUPyrrv/QXDcejD7Dpl8f9WvU+YXCCWzeko66GzWv1l42OSClRnk3NtFQQsQB6Xhc7n2Vet9zQ6LBAftIQSdmLRmCcJj01R2hFgqwecjrB++cp/qMQX6nC6jLwIcmjgjd1a92GMJA8GN/Zekx9GzKc60d0B4e/2GtHzHRRUgvC7bcbzyjJRp/3FhGTC2yLWOVJ78hUSgasQg6e/vUFwDPUD0J3tOWiq+73rf8A1yTokf4LLAoPSQO9ggR4skeGDA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ca7310-9b01-4951-e6af-08d5d6ead9f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 20:17:31.5722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0746
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
index 4e544459e9..81fda969d3 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -94,3 +94,45 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t =
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
2.14.3

