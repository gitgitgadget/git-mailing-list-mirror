Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582A91F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755842AbeEaRlZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:41:25 -0400
Received: from mail-bn3nam01on0126.outbound.protection.outlook.com ([104.47.33.126]:26772
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755824AbeEaRlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLaSYqPcwvhc8KnXhEN6GPvLM5ZWVPxPX+wLhqSMaHA=;
 b=IpJS6IcLRq34eJrKP+VJTrDq+krwXTodtifantCXcrYCqLce5WDQ0i1N26G+vxPq4GqyCf/OzqgSZNqFseRKo74NfA9R0MsZPkY2bQtDexWUbsxQIc2TQFmDb5tKvN93uM856izP09EHCX6J7p5A3UgtZ7GMMvKa6TA3rJUe9uk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.6; Thu, 31 May 2018 17:41:11 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1%5]) with mapi id 15.20.0841.006; Thu, 31 May 2018
 17:41:11 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 2/6] DO NOT MERGE: write commit-graph on every fetch
Thread-Topic: [RFC PATCH 2/6] DO NOT MERGE: write commit-graph on every fetch
Thread-Index: AQHT+QaQyM9WNUxeo0O3mf0gROVvng==
Date:   Thu, 31 May 2018 17:41:11 +0000
Message-ID: <20180531174024.124488-3-dstolee@microsoft.com>
References: <20180531174024.124488-1-dstolee@microsoft.com>
In-Reply-To: <20180531174024.124488-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:LkWHulZychIywgZ5XFP7jjdqAw23wSKndeXoLdXrwu/eU9ZfrEzBRvbIduUEgFKxDMLkGQ/9kWyeb9nezY/rbiOviYKQc4d5i2VG9lUzimFO2AUnDN2sCtt9Ft5r7iWg0kGo3TE9yWXcdmUjDRamySqOnn5OhH6l5C1fbG0pwQHbncWsmBOnTfSXPqHyqm44yV3w9uHjYTDutFerzQ6HHTeWrh47DhZqUuS5VbjQ3wr0WiT9FS0x7IoJWk6f9weC;20:RXTz5XlwdFW6FA2ZLn1025Zhl79JVhje5pxOLNGQueh3ZhBzGo/jl9kA6N3WRxqmfpRZrrD4etcg6vR9f75tC20waXuUlZD56Bopg7AC0RReSJ9MCppiKgXN6TV1Od5t94YWV9izTFGW+ei9Qi8Cnd67fZ+uYuV/reDR+7P7RjQ=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB097766A960E83F0C8F3C1CF1A1630@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(346002)(39380400002)(376002)(189003)(199004)(5250100002)(2351001)(6512007)(10090500001)(97736004)(186003)(3660700001)(54906003)(68736007)(3280700002)(2900100001)(46003)(53936002)(86612001)(86362001)(6486002)(36756003)(6116002)(1076002)(478600001)(99286004)(14454004)(102836004)(316002)(2616005)(6506007)(25786009)(11346002)(8936002)(305945005)(386003)(6916009)(6436002)(5660300001)(2906002)(81156014)(81166006)(476003)(76176011)(5640700003)(8676002)(446003)(59450400001)(107886003)(22452003)(2501003)(1730700003)(486006)(52116002)(106356001)(7736002)(10290500003)(105586002)(39060400002)(4326008)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +4J20oEtqSij8VrInwEOnktz0Gc02bYURWLEH22ndAOecytOm7gb42SjRPYEAnCNzdLNSPrA6Hg3tuMujwv4LsC43haNv7YSBR/hEUeaCC8LL6D9VFu1e6M1Gh4Osd9C1JMP+Fg8+c/A2buene3JB7iL68XaPtS+8xjSLOzjBSd1t25ERL982pv6pwLv5pNj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e95c3399-8515-4949-86ea-08d5c71db29f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95c3399-8515-4949-86ea-08d5c71db29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 17:41:11.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

THIS IS ONLY FOR TESTING TO INCREASE TEST COVERAGE

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fetch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8ee998ea2e..af896e4b74 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -20,6 +20,7 @@
 #include "utf8.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "commit-graph.h"
=20
 static const char * const builtin_fetch_usage[] =3D {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -1480,6 +1481,9 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
=20
 	close_all_packs();
=20
+	if (core_commit_graph)
+		write_commit_graph_reachable(get_object_directory(), 1);
+
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
 		argv_array_push(&argv_gc_auto, "--quiet");
--=20
2.16.2.338.gcfe06ae955

