Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302391F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966700AbeEJReL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:11 -0400
Received: from mail-dm3nam03on0135.outbound.protection.outlook.com ([104.47.41.135]:42450
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966615AbeEJReH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cbGBUOA2+o+yGMxYdSeaJ30Dh5qJ0Q6kolEtgZ0Hu5E=;
 b=YBZXWlI44rurX0APpv7dQgtqK/CIi8DEOge1PVsVyyfI+b05mE9mz9OEw0AY/KdxfNqpAe6reF35+Zp3jL2j2SgbIWNYjJF4/K8ok9/f0zjGQwrhawJd0DhQDNqQNHBHREL8VruzuJAsO/5tsWZbN7X0qPE/C07aPTxz3BwkHYo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:05 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:05 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 02/12] commit-graph: verify file header information
Thread-Topic: [PATCH 02/12] commit-graph: verify file header information
Thread-Index: AQHT6IUXKI7ojaZYRUKFysMU6vw8bA==
Date:   Thu, 10 May 2018 17:34:05 +0000
Message-ID: <20180510173345.40577-3-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
In-Reply-To: <20180510173345.40577-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:404:79::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:FPT0zn3igPdAKOV2EIoMNEe/qpjVWCHD+0mT2fKhPiF9OnfWRZ5tpzZfmnE08YbMmyS3YugcmoutgsTMyFRN++AVHyNgUkbd5AkAUIaiD+osDaGLbZukXZIix+vwE3/NtzKvA6Rk+IEHqPIJNVRw02ySzyIdnL97yRN8U91njtLXy1sgU4o7nk6zZsr5lLLfidCJvRLCiV1YuMUZgjgCfP6fZ7GGxbl+dmdXlzTNuojHJos4Nki+kSd3EHwjfv7t;20:z0u51IhFI0futYVvWgqGWl09rp7n84hDVmrtWT9IZTilm09cAWHlY3Vb9O3tlbBJUcUHIiw1uH1CEiNo1vwVcpOmd7rTWEf+tlbhM1q0BRnAvmPuCrqr9cdhWObRiaozSFZnO9HdrlInsc3JLaSPJULt+cJD/1hHLYJUXk3CsLg=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09626D7331CA2E459EC5C8D1A1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(15650500001)(59450400001)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o0wZNyer1sxx3qY1Ev6k7Z1/TQ1uBme+bgm6q+ez03J8jn/L4lebT0iaqgGFxwiVLwg9RQ0+f4oIS8HAVnklMRs7DtHEOLNRXcjU05qFDvcBtb6dbEXfKKH3U0XGBVH0E//VAALJfva0tzJNvKgovGmgqgnP1abO0ATUXUevtEpeRJQW9Y3gK4XxuYFF5Spm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d1b6f4ce-3e40-4e6c-e947-08d5b69c3a00
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b6f4ce-3e40-4e6c-e947-08d5b69c3a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:05.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
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
 commit-graph.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index b25aaed128..c3b8716c14 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -818,7 +818,28 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr =3D 0;
 }
=20
+static int verify_commit_graph_error;
+#define graph_report(...) \
+	do {\
+		verify_commit_graph_error =3D 1;\
+		printf(__VA_ARGS__);\
+	} while (0);
+
 int verify_commit_graph(struct commit_graph *g)
 {
-	return !g;
+	if (!g) {
+		graph_report(_("no commit-graph file loaded"));
+		return 1;
+	}
+
+	verify_commit_graph_error =3D 0;
+
+	if (!g->chunk_oid_fanout)
+		graph_report(_("commit-graph is missing the OID Fanout chunk"));
+	if (!g->chunk_oid_lookup)
+		graph_report(_("commit-graph is missing the OID Lookup chunk"));
+	if (!g->chunk_commit_data)
+		graph_report(_("commit-graph is missing the Commit Data chunk"));
+
+	return verify_commit_graph_error;
 }
--=20
2.16.2.329.gfb62395de6

