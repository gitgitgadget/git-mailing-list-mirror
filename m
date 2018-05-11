Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018B21F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEKVPx (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:53 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:27712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751985AbeEKVPg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rm+oMpWDEt4QUvJ+y4tugJZg15cMYHrpvvX+sqCQgQ=;
 b=NIZkYnCKAQAezmEF09cYMJYlfcbIqkOPqHaa09q8XbcCbB7Nc5PLbCOygJu4ChrYzFRLd5Gfg91WiZ3pNDNBLxchRvVBkCRHVD89hoenQt3SsED1XmKeW9/Ek6lLp6yFL3iH3Jw0XDgF6qL2gQqKGXvUOm3NXO5/fDFe5fkxj9s=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Fri, 11 May 2018 21:15:33 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:33 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 10/12] commit-graph: add '--reachable' option
Thread-Topic: [PATCH v2 10/12] commit-graph: add '--reachable' option
Thread-Index: AQHT6W0sbORzqMy4J0Cwy72Obi6L7w==
Date:   Fri, 11 May 2018 21:15:24 +0000
Message-ID: <20180511211504.79877-11-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:KXFH08fxtwQC15abD3AChhlDgOEdmkhlucUooIUIZPOhLT93GbsHRog2/MfxjubJH43uGyHrFsx2J9SVx6UvkdSYdrBO7SADJMkYSXu0qAByCjLtzV+DB+BdWQ0JT/R/huteL40xOusA3iDH4yRuPht3V+vt9KlHLoMVT5pYex2rJ0uKDBUFscCfgGksvt5o1wBLEcBbu0ZDqs+uD4HiB+7sPGGlZHurE3efddcNvATd3CU76YicY7Eau1FcSMmP;20:vmnwBpoCzIVNryQ3h8DRKfMDN2w9c6CaIIacmsfPRL1rRgUegvK6FWqiV16trnoGP0ei+UKGuTg84e17IZ0p257WW3Qgg4bwB+ZJ/rIw5Loi+ohN+sbU35upt+pMZIZq0XoTagkMr5y721lid/bo6PLy62vfAc5QBcso4g7SKIw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962D80164A82068B40E1AD9A19F0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(5660300001)(39060400002)(316002)(305945005)(6116002)(7736002)(6506007)(52116002)(386003)(81166006)(81156014)(186003)(3660700001)(5640700003)(46003)(76176011)(54906003)(1730700003)(68736007)(6436002)(446003)(102836004)(3280700002)(1076002)(59450400001)(97736004)(2351001)(11346002)(22452003)(106356001)(99286004)(2616005)(476003)(2501003)(36756003)(14454004)(2906002)(8936002)(6666003)(105586002)(107886003)(4326008)(8676002)(86612001)(6486002)(486006)(25786009)(10090500001)(53936002)(478600001)(2900100001)(86362001)(6916009)(6512007)(10290500003)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HBoe+m/op7+XYSNLrwpTFknrZKqlS032f1Hb8Rt6dW+rvWCxwrHgPnog+fPDMiSu+qgfD1MrD9QoGWnallfChRv/KCuK9nCv8lCFHFVMryxBDI+jCWCayS6U/PLX7Vuze7XDcrE63UVb3xIim57cFBbddcnavGs7cVUHoG9OzmaL6io/EHAcrl2eDp0OiGDG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 211fe0f6-a830-409d-76c7-08d5b7844f38
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211fe0f6-a830-409d-76c7-08d5b7844f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:24.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing commit-graph files, it can be convenient to ask for all
reachable commits (starting at the ref set) in the resulting file. This
is particularly helpful when writing to stdin is complicated, such as a
future integration with 'git gc' which will call
'git commit-graph write --reachable' after performing cleanup of the
object database.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  8 ++++++--
 builtin/commit-graph.c             | 41 ++++++++++++++++++++++++++++++++++=
----
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-=
graph.txt
index a222cfab08..cc1715a823 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -38,12 +38,16 @@ Write a commit graph file based on the commits found in=
 packfiles.
 +
 With the `--stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
-with --stdin-commits.)
+with --stdin-commits or --reachable.)
 +
 With the `--stdin-commits` option, generate the new commit graph by
 walking commits starting at the commits specified in stdin as a list
 of OIDs in hex, one OID per line. (Cannot be combined with
---stdin-packs.)
+--stdin-packs or --reachable.)
++
+With the `--reachable` option, generate the new commit graph by walking
+commits starting at all refs. (Cannot be combined with --stdin-commits
+or --stind-packs.)
 +
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index af3101291f..7cb94a4813 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -3,13 +3,14 @@
 #include "dir.h"
 #include "lockfile.h"
 #include "parse-options.h"
+#include "refs.h"
 #include "commit-graph.h"
=20
 static char const * const builtin_commit_graph_usage[] =3D {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-pa=
cks|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachabl=
e|--stdin-packs|--stdin-commits]"),
 	NULL
 };
=20
@@ -24,12 +25,13 @@ static const char * const builtin_commit_graph_read_usa=
ge[] =3D {
 };
=20
 static const char * const builtin_commit_graph_write_usage[] =3D {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-pa=
cks|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachabl=
e|--stdin-packs|--stdin-commits]"),
 	NULL
 };
=20
 static struct opts_commit_graph {
 	const char *obj_dir;
+	int reachable;
 	int stdin_packs;
 	int stdin_commits;
 	int append;
@@ -113,6 +115,25 @@ static int graph_read(int argc, const char **argv)
 	return 0;
 }
=20
+struct hex_list {
+	char **hex_strs;
+	int hex_nr;
+	int hex_alloc;
+};
+
+static int add_ref_to_list(const char *refname,
+			   const struct object_id *oid,
+			   int flags, void *cb_data)
+{
+	struct hex_list *list =3D (struct hex_list*)cb_data;
+
+	ALLOC_GROW(list->hex_strs, list->hex_nr + 1, list->hex_alloc);
+	list->hex_strs[list->hex_nr] =3D xcalloc(GIT_MAX_HEXSZ + 1, 1);
+	strcpy(list->hex_strs[list->hex_nr], oid_to_hex(oid));
+	list->hex_nr++;
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	const char **pack_indexes =3D NULL;
@@ -127,6 +148,8 @@ static int graph_write(int argc, const char **argv)
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph")),
+		OPT_BOOL(0, "reachable", &opts.reachable,
+			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			N_("scan pack-indexes listed by stdin for commits")),
 		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
@@ -140,8 +163,8 @@ static int graph_write(int argc, const char **argv)
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
=20
-	if (opts.stdin_packs && opts.stdin_commits)
-		die(_("cannot use both --stdin-commits and --stdin-packs"));
+	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
+		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs=
"));
 	if (!opts.obj_dir)
 		opts.obj_dir =3D get_object_directory();
=20
@@ -164,6 +187,16 @@ static int graph_write(int argc, const char **argv)
 			commit_hex =3D lines;
 			commits_nr =3D lines_nr;
 		}
+	} else if (opts.reachable) {
+		struct hex_list list;
+		list.hex_nr =3D 0;
+		list.hex_alloc =3D 128;
+		ALLOC_ARRAY(list.hex_strs, list.hex_alloc);
+
+		for_each_ref(add_ref_to_list, &list);
+
+		commit_hex =3D (const char **)list.hex_strs;
+		commits_nr =3D list.hex_nr;
 	}
=20
 	write_commit_graph(opts.obj_dir,
--=20
2.16.2.329.gfb62395de6

