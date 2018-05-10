Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F931F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966750AbeEJReT (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:19 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:53659
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966721AbeEJReP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=myZCVcTcSajYLFHTfdpDAANwA6tISkK0tTKXgGfVpXU=;
 b=ZKM8pxovg9KMNSFsV/gPG9+3xdKhoLLjplcmjaTi8poVKHaQ2hsZCCdn+Snj9lpDukEx6pfWaoqdJPKctERjblAB/lKZ8xC5q2OSUmCIyTOLBzUNSz95A9R16dL5EhfZ/mGwXzQpN3nPPtuAoWd4t5Re1b/oqrkyUCI1lvK56ms=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:12 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:12 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 08/12] fsck: verify commit-graph
Thread-Topic: [PATCH 08/12] fsck: verify commit-graph
Thread-Index: AQHT6IUb7JvNkKm3k0C4+gUfoulBpw==
Date:   Thu, 10 May 2018 17:34:12 +0000
Message-ID: <20180510173345.40577-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:40ROeFynYbkprWnnC9Nwn9WgvvH0XTBYBbAWwfjxwjOdmg2/JtCCKuw6kbRHgGRTrLVan2pq+OFGFlanhzoilgAnZBN9htxR/3HGBMM5ao70KBW8PxUf+CBadifo6BkzKXT42VZAB5OPOrN/Ai/COWH7gG3fS4yNlAEmLW76pGgUTfEKldMQW378pR8RAW+VkA4VK16qVPCVM8s8EiriWQd7SC+ZIQopG4tL9Eu9mDKw1rY7UCC3x9ku1vUnZDi/;20:Tx3uQYykfKHqLqS8SD5RMQwd5UpUAkV2E0eF0WgYbtzutVh6wVGlWeV6avnbk342abIpbdWgDaLuaS8zHvbVDXwD/kKcY3DWQEkRjP/gjSaOobru3UUU9zbY+EJNVIWngZOCmHEcxvjGpwk/Q/tffElKjG7FQ7ll0vZq9YXCBWE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09621B54A92E6B1C1061D7F2A1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(15650500001)(59450400001)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sktaejdw80oll4htzXnFun/QZHVQxWZJTDt7oUV3hPc0iJAHapEz9YsX9aoV2q7Kf/NUboWJw+2+VHEa4b0H6MF+kX77apSDQnMNW+R3jEIYSui5bC46yxSz41lTA3jjC7b/p9S210g+3pToaUCC8/sfOYEVzdkaN0EvIe7d6lFfeZi72Gf5U1vkiIbnODwF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d498d6ae-962a-4507-522f-08d5b69c3e38
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d498d6ae-962a-4507-522f-08d5b69c3e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:12.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If core.commitGraph is true, verify the contents of the commit-graph
during 'git fsck' using the 'git commit-graph verify' subcommand. Run
this check on all alternates, as well.

We use a new process for two reasons:

1. The subcommand decouples the details of loading and verifying a
   commit-graph file from the other fsck details.

2. The commit-graph verification requires the commits to be loaded
   in a specific order to guarantee we parse from the commit-graph
   file for some objects and from the object database for others.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-fsck.txt |  3 +++
 builtin/fsck.c             | 21 +++++++++++++++++++++
 t/t5318-commit-graph.sh    |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index b9f060e3b2..ab9a93fb9b 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -110,6 +110,9 @@ Any corrupt objects you will have to find in backups or=
 other archives
 (i.e., you can just remove them and do an 'rsync' with some other site in
 the hopes that somebody else has the object you have corrupted).
=20
+If core.commitGraph is true, the commit-graph file will also be inspected
+using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
+
 Extracted Diagnostics
 ---------------------
=20
diff --git a/builtin/fsck.c b/builtin/fsck.c
index ef78c6c00c..a6d5045b77 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -16,6 +16,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "run-command.h"
=20
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -45,6 +46,7 @@ static int name_objects;
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
 #define ERROR_REFS 010
+#define ERROR_COMMIT_GRAPH 020
=20
 static const char *describe_object(struct object *obj)
 {
@@ -815,5 +817,24 @@ int cmd_fsck(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	check_connectivity();
+
+	if (core_commit_graph) {
+		struct child_process commit_graph_verify =3D CHILD_PROCESS_INIT;
+		const char *verify_argv[] =3D { "commit-graph", "verify", NULL, NULL, NU=
LL, NULL };
+		commit_graph_verify.argv =3D verify_argv;
+		commit_graph_verify.git_cmd =3D 1;
+
+		if (run_command(&commit_graph_verify))
+			errors_found |=3D ERROR_COMMIT_GRAPH;
+
+		prepare_alt_odb();
+		for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
+			verify_argv[2] =3D "--object-dir";
+			verify_argv[3] =3D alt->path;
+			if (run_command(&commit_graph_verify))
+				errors_found |=3D ERROR_COMMIT_GRAPH;
+		}
+	}
+
 	return errors_found;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6ca451dfd2..9680e6e6e0 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -240,4 +240,9 @@ test_expect_success 'git commit-graph verify' '
 	git commit-graph verify >output
 '
=20
+test_expect_success 'git fsck (checks commit-graph)' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

