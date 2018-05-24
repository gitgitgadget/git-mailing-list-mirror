Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FA631F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031140AbeEXQ0A (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:00 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28256
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030872AbeEXQZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoNTZjq6md5V8KEciWNWZwtCf+wXYrCGgkmwkk5btRQ=;
 b=nMgLXcldJDR/Uuc9/Flizh+tPPeEc1TLSHrfr9ah5QK8+bk9n5q57x7rbpfATJ+mDc9uzVG7/10ODDePiP1XZw173zkes/wIVTpHC5S+EzQ5sgu93gnDUGWcbOWgP2nSpH/CUaPfuQjAQwlCrvrSvW1GibSQ8jVexVtiXqE5IoE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0882.namprd21.prod.outlook.com (52.132.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:30 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:30 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 02/20] commit-graph: fix GRAPH_MIN_SIZE
Thread-Topic: [PATCH v3 02/20] commit-graph: fix GRAPH_MIN_SIZE
Thread-Index: AQHT83vU+3kokCV7iUCooY0tcreD9A==
Date:   Thu, 24 May 2018 16:25:29 +0000
Message-ID: <20180524162504.158394-3-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0882;7:SAC52ycqXFnPmBKqImCXzJiq/AJoHF8Zc5njiAQM//sz91L0yC8SymrDLtdyBkbhvyrg+pd0wa4/eAVgoVJFmI49DDEnOGeQr/tCZhNg0pYQ6WG8sxMPTOe7DBsGtaSMi8ZUQVeaw5APj7itxXewZSu8XmHNBGWiom9jMWauOAGyj+YtfQasGtVREhGHwWAMRnV56bLtaWvfENIoD2/FXJvMTv7nguAr2w64tM3XIGmvzea3pDqF09GDYjqkMRZm;20:03ToQRv51SNPRrrGNpQbaF1TBXMf0FSS8q9G/X7YJ8MLANC3oE1Pih/+iRuYzzjclPNV2DjibKaxzttEypybd+qthX7MsbdvqzcW+fhHpnxncx7VjArPcBNEVcSAx++4R5b54DXcjHiK/w9im7AOF3ixGrWpcTR/ngPK1nPo+Jc=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0882;
x-ms-traffictypediagnostic: BL0PR2101MB0882:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB088291C8BEBDD9EB76C2C5AAA16A0@BL0PR2101MB0882.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0882;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0882;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(36756003)(6116002)(107886003)(1076002)(6486002)(5250100002)(2501003)(6916009)(5660300001)(97736004)(316002)(99286004)(10090500001)(8656006)(6512007)(53936002)(54906003)(39060400002)(22452003)(4326008)(8676002)(2906002)(102836004)(2900100001)(1730700003)(81166006)(81156014)(2351001)(386003)(6506007)(3280700002)(476003)(2616005)(5640700003)(486006)(52116002)(14454004)(46003)(6436002)(25786009)(11346002)(86362001)(86612001)(446003)(305945005)(186003)(10290500003)(105586002)(7736002)(3660700001)(68736007)(76176011)(8936002)(106356001)(478600001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0882;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Zprpc3sbpTWCOCE53OS7aieYwF0+uamNl4aBNAKAinHIMQ32r/Ff0mCf6y7mwdhuvC/qLUAWGBfPC8q4giyRL0As1XIcewpZOAUXG+cJ5ioc++ZHLSxLzfp+SEqL+BygpL0TnWstyRkkBcK8Slmxc3eXbZsslx75Uu4wTJK7zxJZCBM9kKtg3dss4CI22F3W
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f4e6fd99-5827-4b51-c7a1-08d5c192f657
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e6fd99-5827-4b51-c7a1-08d5c192f657
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:29.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0882
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GRAPH_MIN_SIZE macro should be the smallest size of a parsable
commit-graph file. However, the minimum number of chunks was wrong.
It is possible to write a commit-graph file with zero commits, and
that violates this macro's value.

Rewrite the macro, and use extra macros to better explain the magic
constants.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a8c337dd77..82295f0975 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -33,10 +33,11 @@
=20
 #define GRAPH_LAST_EDGE 0x80000000
=20
+#define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
 #define GRAPH_CHUNKLOOKUP_WIDTH 12
-#define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + =
\
-			GRAPH_OID_LEN + 8)
+#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
+			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
=20
 char *get_commit_graph_filename(const char *obj_dir)
 {
--=20
2.16.2.329.gfb62395de6

