Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F5C1F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEKVPX (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:23 -0400
Received: from mail-co1nam03on0125.outbound.protection.outlook.com ([104.47.40.125]:35280
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751366AbeEKVPT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oee1nsKM5FCM9PXdpYn/TYg7nmaBhgaWcomp+xWEU7k=;
 b=YZrCMtw8ta1sfC9jjUcSBDbvKzNYA+0fQGS8NvoAusTgN5+//RQmiRTbgXzq4uRKy0cAPd6pz/zoOYxJbzEtE6PHiy3xUcyaW/xtS+lXNq/OY7BjqTHaekWvX0gI2ptQNaOCjPVL8bk6RFZsg5KVKYUAKZHYKpMZ7don193rkcE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1058.namprd21.prod.outlook.com (52.132.24.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.3; Fri, 11 May 2018 21:15:16 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:16 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 02/12] commit-graph: verify file header information
Thread-Topic: [PATCH v2 02/12] commit-graph: verify file header information
Thread-Index: AQHT6W0onXdpNPhDNUqYG48YV5TCSA==
Date:   Fri, 11 May 2018 21:15:16 +0000
Message-ID: <20180511211504.79877-3-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
In-Reply-To: <20180511211504.79877-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:404:8e::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1058;7:SowNSwKzgtUpdwvB3jBVlIG4168uEABB3duLZkD7stsjaK6JE23v+PngQmRhZLBhSDmJxmd61hkins+x5UYsd7D5chl0AFwHlG0U+DjMmFuvfsQA0p5fqACI6DRKK7FO4Z9CmSdij8ZGIDw5GmyPpA4m7lYHDhEUwX9G0ml1Pb0x74Mmf8w2x4W/EWgHl1P0I3zcNVmgLwsjpxBPOmW6YAP1Qqy75NCf1zxq3Hgzy8WSRqmyIlnZhgTeSUQljCL1;20:iG7j+vCSjPJmdpZcgn9eJ1oe1Atliis04cyYxhTJJix/TeKL/AQLS3VtrN24NV2BKhDi1IQWpnpGV+UuT96WQu6MpULYHZ3RzdqmSAL8dzh0QNz71FFngieBPIBvzBM4mpe5BPbVvaKPJT7dxpp6403+vkUq403mMA+NxmR2wtA=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1058;
x-ms-traffictypediagnostic: BL0PR2101MB1058:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1058967A512E18F2FA25675DA19F0@BL0PR2101MB1058.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1058;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1058;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(189003)(199004)(3660700001)(4326008)(54906003)(11346002)(10290500003)(5250100002)(76176011)(102836004)(14454004)(15650500001)(6512007)(36756003)(59450400001)(478600001)(97736004)(6916009)(52116002)(39060400002)(86362001)(6436002)(5640700003)(86612001)(386003)(2616005)(476003)(6506007)(486006)(186003)(5660300001)(22452003)(7736002)(6486002)(68736007)(106356001)(316002)(1076002)(1730700003)(446003)(25786009)(2501003)(107886003)(81156014)(2906002)(105586002)(2900100001)(53936002)(99286004)(81166006)(8676002)(8936002)(6116002)(305945005)(3280700002)(10090500001)(2351001)(46003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1058;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ribqs7NzBJinFYmCNrq5MVtg6DTA9GezsWiGH4quiD1FvxU1CHA6DXN+O1qEyQx2aZU/iNafG6U3ky7DN1CBQ5C0RQEQxhQukcLm7NhbnVLqfXbeF2x/OsxtCOJq2HpwOrVLFDruUW4ZPzU4FmEq8yYa9g11jOcsgpyT83M6eQ0fEpiYqW8XVo0WD3P4nqdG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8aecd218-a8b7-41e7-3c5b-08d5b7844a66
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aecd218-a8b7-41e7-3c5b-08d5b7844a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:16.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1058
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During a run of 'git commit-graph verify', list the issues with the
header information in the commit-graph file. Some of this information
is inferred from the loaded 'struct commit_graph'. Some header
information is checked as part of load_commit_graph_one().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index b25aaed128..d2db20e49a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -818,7 +818,37 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr =3D 0;
 }
=20
+static int verify_commit_graph_error;
+
+static void graph_report(const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf sb =3D STRBUF_INIT;
+	verify_commit_graph_error =3D 1;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+
+	fprintf(stderr, "%s\n", sb.buf);
+	strbuf_release(&sb);
+	va_end(ap);
+}
+
 int verify_commit_graph(struct commit_graph *g)
 {
-	return !g;
+	if (!g) {
+		graph_report("no commit-graph file loaded");
+		return 1;
+	}
+
+	verify_commit_graph_error =3D 0;
+
+	if (!g->chunk_oid_fanout)
+		graph_report("commit-graph is missing the OID Fanout chunk");
+	if (!g->chunk_oid_lookup)
+		graph_report("commit-graph is missing the OID Lookup chunk");
+	if (!g->chunk_commit_data)
+		graph_report("commit-graph is missing the Commit Data chunk");
+
+	return verify_commit_graph_error;
 }
--=20
2.16.2.329.gfb62395de6

