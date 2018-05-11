Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3071F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeEKVPV (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:21 -0400
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:2754
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751012AbeEKVPS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdSC8jCXBlDaL4gafpTwi2smqvdFZWcuMx453B5gS+8=;
 b=mWSiod40e1TAmWYbaJrMsnQGjREcLGIeLX96R56ZsfHUQhlxcM+gHBloLEoy8tij5FiY8hIEmqDac8wUk39YrrMdb3w45UEujwURNnGu8X5ZzDiMkP7jGnU2WsHnZCsXpZjHQ8aIW5GYK45N3uoH2stZ32EwazSoWBh19ffHAuk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1060.namprd21.prod.outlook.com (52.132.24.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.3; Fri, 11 May 2018 21:15:15 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:15 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 01/12] commit-graph: add 'verify' subcommand
Thread-Topic: [PATCH v2 01/12] commit-graph: add 'verify' subcommand
Thread-Index: AQHT6W0nLjiu240AH0+VNGE95i4enQ==
Date:   Fri, 11 May 2018 21:15:15 +0000
Message-ID: <20180511211504.79877-2-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1060;7:NWZhDJ1tGkFEYbPTmkkLLJhoOPN5L9HriyNDNm9NCCI5UEB8iDTHot64HkARVOmxgsIM0pP64jmraRlTukLzTR+xEJn4QViKkEMvCcFsKWZgZEEGouJFDXBVZkB7vmHf9f4XU6NJB2Cwa70FPFi2e/g+0Jm8lOSlpuMTGl3wUDBAup+my1//i3OlgHuVL0rAVvMC0wEfySNuevJV/0wFbgHRmAVfAf0q3kVIU9a4rLmZ2U/7xc9girZMEJZ/FTCN;20:jg68Q0JXhq2cgZZ2drrd2GI8T8P+mtNQHjiTRfShpE1UG7Ah+kju0NqVwqCv8V5+aMi2SmHgk8u591VW1oN/bHINJw2dE8pp5KMwHJOKReGa7jgClwB9qsUS490WIlzmkm+SkgXF4dF/k+Ssw2ShSbV50ApVUcgWX+Rfvww0+to=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1060;
x-ms-traffictypediagnostic: BL0PR2101MB1060:
x-microsoft-antispam-prvs: <BL0PR2101MB10607A39F81ACEFD3532181FA19F0@BL0PR2101MB1060.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1060;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1060;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(2900100001)(2501003)(305945005)(68736007)(81166006)(106356001)(46003)(7736002)(3280700002)(105586002)(6486002)(107886003)(97736004)(99286004)(6116002)(25786009)(2351001)(53936002)(1730700003)(2906002)(8676002)(386003)(81156014)(10090500001)(8936002)(1076002)(15650500001)(36756003)(3660700001)(446003)(5250100002)(86362001)(6436002)(86612001)(5660300001)(52116002)(575784001)(10290500003)(102836004)(316002)(186003)(11346002)(2616005)(39060400002)(476003)(59450400001)(6916009)(486006)(5640700003)(6506007)(4326008)(478600001)(6512007)(14454004)(6346003)(54906003)(76176011)(22452003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1060;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: rPWm41LwbhxjVeCRICU26LVgbeETywbCNNuzhDPwIKozklxcmjKKXJjwRtcM3Eg+yUJDg87UXiawFMOx1in0hrlY7Lk88ObCp0rUj3vb0fUnr9TxsEz9RvkuscZu4LffIGjqt+fvTbWmEukpQirqYqBSjp+1z5i/NvLgzE9Ft0RtREltHGLsgGvwGzIGmHDV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d14eaf73-1d32-4bda-0dab-08d5b78449d1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14eaf73-1d32-4bda-0dab-08d5b78449d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:15.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1060
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the commit-graph file becomes corrupt, we need a way to verify
that its contents match the object database. In the manner of
'git fsck' we will implement a 'git commit-graph verify' subcommand
to report all issues with the file.

Add the 'verify' subcommand to the 'commit-graph' builtin and its
documentation. The subcommand is currently a no-op except for
loading the commit-graph into memory, which may trigger run-time
errors that would be caught by normal use. Add a simple test that
ensures the command returns a zero error code.

If no commit-graph file exists, this is an acceptable state. Do
not report any errors.

During review, we noticed that a FREE_AND_NULL(graph_name) was
placed after a possible 'return', and this pattern was also in
graph_read(). Fix that case, too.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  6 ++++++
 builtin/commit-graph.c             | 40 ++++++++++++++++++++++++++++++++++=
+++-
 commit-graph.c                     |  5 +++++
 commit-graph.h                     |  2 ++
 t/t5318-commit-graph.sh            | 10 ++++++++++
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-=
graph.txt
index 4c97b555cc..a222cfab08 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph read' [--object-dir <dir>]
+'git commit-graph verify' [--object-dir <dir>]
 'git commit-graph write' <options> [--object-dir <dir>]
=20
=20
@@ -52,6 +53,11 @@ existing commit-graph file.
 Read a graph file given by the commit-graph file and output basic
 details about the graph file. Used for debugging purposes.
=20
+'verify'::
+
+Read the commit-graph file and verify its contents against the object
+database. Used to check for corrupted data.
+
=20
 EXAMPLES
 --------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 37420ae0fd..af3101291f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,10 +8,16 @@
 static char const * const builtin_commit_graph_usage[] =3D {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
+	N_("git commit-graph verify [--object-dir <objdir>]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-pa=
cks|--stdin-commits]"),
 	NULL
 };
=20
+static const char * const builtin_commit_graph_verify_usage[] =3D {
+	N_("git commit-graph verify [--object-dir <objdir>]"),
+	NULL
+};
+
 static const char * const builtin_commit_graph_read_usage[] =3D {
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	NULL
@@ -29,6 +35,36 @@ static struct opts_commit_graph {
 	int append;
 } opts;
=20
+
+static int graph_verify(int argc, const char **argv)
+{
+	struct commit_graph *graph =3D 0;
+	char *graph_name;
+
+	static struct option builtin_commit_graph_verify_options[] =3D {
+		OPT_STRING(0, "object-dir", &opts.obj_dir,
+			   N_("dir"),
+			   N_("The object directory to store the graph")),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, NULL,
+			     builtin_commit_graph_verify_options,
+			     builtin_commit_graph_verify_usage, 0);
+
+	if (!opts.obj_dir)
+		opts.obj_dir =3D get_object_directory();
+
+	graph_name =3D get_commit_graph_filename(opts.obj_dir);
+	graph =3D load_commit_graph_one(graph_name);
+	FREE_AND_NULL(graph_name);
+
+	if (!graph)
+		return 0;
+
+	return verify_commit_graph(graph);
+}
+
 static int graph_read(int argc, const char **argv)
 {
 	struct commit_graph *graph =3D NULL;
@@ -50,10 +86,10 @@ static int graph_read(int argc, const char **argv)
=20
 	graph_name =3D get_commit_graph_filename(opts.obj_dir);
 	graph =3D load_commit_graph_one(graph_name);
+	FREE_AND_NULL(graph_name);
=20
 	if (!graph)
 		die("graph file %s does not exist", graph_name);
-	FREE_AND_NULL(graph_name);
=20
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
@@ -160,6 +196,8 @@ int cmd_commit_graph(int argc, const char **argv, const=
 char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	if (argc > 0) {
+		if (!strcmp(argv[0], "verify"))
+			return graph_verify(argc, argv);
 		if (!strcmp(argv[0], "read"))
 			return graph_read(argc, argv);
 		if (!strcmp(argv[0], "write"))
diff --git a/commit-graph.c b/commit-graph.c
index a8c337dd77..b25aaed128 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -817,3 +817,8 @@ void write_commit_graph(const char *obj_dir,
 	oids.alloc =3D 0;
 	oids.nr =3D 0;
 }
+
+int verify_commit_graph(struct commit_graph *g)
+{
+	return !g;
+}
diff --git a/commit-graph.h b/commit-graph.h
index 96cccb10f3..71a39c5a57 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -53,4 +53,6 @@ void write_commit_graph(const char *obj_dir,
 			int nr_commits,
 			int append);
=20
+int verify_commit_graph(struct commit_graph *g);
+
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 77d85aefe7..6ca451dfd2 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -11,6 +11,11 @@ test_expect_success 'setup full repo' '
 	objdir=3D".git/objects"
 '
=20
+test_expect_success 'verify graph with no graph file' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify
+'
+
 test_expect_success 'write graph with no packs' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --object-dir . &&
@@ -230,4 +235,9 @@ test_expect_success 'perform fast-forward merge in full=
 repo' '
 	test_cmp expect output
 '
=20
+test_expect_success 'git commit-graph verify' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph verify >output
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

