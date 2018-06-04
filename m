Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38C41F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeFDQxD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:53:03 -0400
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:58612
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751647AbeFDQw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc9lWPyQZOvlxxqb5YTC9EvnU9/jHQa/d9KVFV99ers=;
 b=DClwWlvYJleoZySoWvhCZ0qVdBXcRSvTzMbGDJ5SD6xbSsRweZ54h6+f2Py2Ar+GTApG/KWpLNfWZny8eMsK7iFoURKJRW3+W4xXuWxT1A22SQLodV6G+5QJwr+0jC69eUnYiXDmIyJr3JWAb2JC4TlrZbUizQST7xizu6wZ3LM=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:57 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:57 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 18/21] commit-graph: use string-list API for input
Thread-Topic: [PATCH v4 18/21] commit-graph: use string-list API for input
Thread-Index: AQHT/CR7kPv8AfMCVEiXT8O8IzP/Gg==
Date:   Mon, 4 Jun 2018 16:52:56 +0000
Message-ID: <20180604165200.29261-19-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:Li62zrMOnfGaicsBbY1cBT4E8izeclCB+slarRoCoHHVIdRokYuwJBubxa3wcBoqMPU3YNozJCuxS0O2t/80tI5qwrUyJWc8KqA7EoTSGYwa01j6k9e00Tnsr9AVz5yf7fywesIGSjVDBSumrNXLs4jlExtmYGTocdhVtpSIWGfsAdWfvvDrWKN/L2bBCTc8foxQNEq0miuVyMDWShHemmUOkaZRRCLb/8FG6HrUUnz/wHvOnjhWeXjRA1EiRT04;20:L5GzBJdmUusQMZXyJSfVx3XXrP+GObUfnm9pEH6TaZNfIej/rd9rILu9lvg75Y15WwJjvJ5rOZSdRRng52r0FZV9hLWoikMUTCfr+O/7sfy8bTa29w5fANlISIm4EicmHF3MgNjYMF/ndOtYBHrrBqjUvjIoRVhPX6mfym+KR8Y=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1129C8B1F0CD90455C6DF704A1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(6486002)(486006)(446003)(46003)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mIvXSKvV94+U6wEuEcbhNf3Z5KbH7CG4pwz9SjjkEx05hV2tqMM5V5KErZRNcZKJj4EfGGNMzDhfZ1HtKhX6SnXlfbOzdS8yUI1Sh3mqpQFncINuYnHruRUg5KTpGVdAEAxNRvLXq4Lp7IE3fupSSdLTrBR8lHPMSzOkHSXTLzvWycLsYQ1J3+ny5Jj/uvYZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 606f4ae3-efe2-42c3-f669-08d5ca3b9e3f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606f4ae3-efe2-42c3-f669-08d5ca3b9e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:57.0291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 39 +++++++++++++--------------------------
 commit-graph.c         | 15 +++++++--------
 commit-graph.h         |  7 +++----
 3 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 3079cde6f9..d8eb8278b3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -118,13 +118,9 @@ static int graph_read(int argc, const char **argv)
=20
 static int graph_write(int argc, const char **argv)
 {
-	const char **pack_indexes =3D NULL;
-	int packs_nr =3D 0;
-	const char **commit_hex =3D NULL;
-	int commits_nr =3D 0;
-	const char **lines =3D NULL;
-	int lines_nr =3D 0;
-	int lines_alloc =3D 0;
+	struct string_list *pack_indexes =3D NULL;
+	struct string_list *commit_hex =3D NULL;
+	struct string_list lines;
=20
 	static struct option builtin_commit_graph_write_options[] =3D {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -150,32 +146,23 @@ static int graph_write(int argc, const char **argv)
=20
 	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf =3D STRBUF_INIT;
-		lines_nr =3D 0;
-		lines_alloc =3D 128;
-		ALLOC_ARRAY(lines, lines_alloc);
-
-		while (strbuf_getline(&buf, stdin) !=3D EOF) {
-			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
-			lines[lines_nr++] =3D strbuf_detach(&buf, NULL);
-		}
-
-		if (opts.stdin_packs) {
-			pack_indexes =3D lines;
-			packs_nr =3D lines_nr;
-		}
-		if (opts.stdin_commits) {
-			commit_hex =3D lines;
-			commits_nr =3D lines_nr;
-		}
+		string_list_init(&lines, 0);
+
+		while (strbuf_getline(&buf, stdin) !=3D EOF)
+			string_list_append(&lines, strbuf_detach(&buf, NULL));
+
+		if (opts.stdin_packs)
+			pack_indexes =3D &lines;
+		if (opts.stdin_commits)
+			commit_hex =3D &lines;
 	}
=20
 	write_commit_graph(opts.obj_dir,
 			   pack_indexes,
-			   packs_nr,
 			   commit_hex,
-			   commits_nr,
 			   opts.append);
=20
+	string_list_clear(&lines, 0);
 	return 0;
 }
=20
diff --git a/commit-graph.c b/commit-graph.c
index 05879de26c..c6070735c2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -653,10 +653,8 @@ static void compute_generation_numbers(struct packed_c=
ommit_list* commits)
 }
=20
 void write_commit_graph(const char *obj_dir,
-			const char **pack_indexes,
-			int nr_packs,
-			const char **commit_hex,
-			int nr_commits,
+			struct string_list *pack_indexes,
+			struct string_list *commit_hex,
 			int append)
 {
 	struct packed_oid_list oids;
@@ -697,10 +695,10 @@ void write_commit_graph(const char *obj_dir,
 		int dirlen;
 		strbuf_addf(&packname, "%s/pack/", obj_dir);
 		dirlen =3D packname.len;
-		for (i =3D 0; i < nr_packs; i++) {
+		for (i =3D 0; i < pack_indexes->nr; i++) {
 			struct packed_git *p;
 			strbuf_setlen(&packname, dirlen);
-			strbuf_addstr(&packname, pack_indexes[i]);
+			strbuf_addstr(&packname, pack_indexes->items[i].string);
 			p =3D add_packed_git(packname.buf, packname.len, 1);
 			if (!p)
 				die("error adding pack %s", packname.buf);
@@ -713,12 +711,13 @@ void write_commit_graph(const char *obj_dir,
 	}
=20
 	if (commit_hex) {
-		for (i =3D 0; i < nr_commits; i++) {
+		for (i =3D 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
 			struct commit *result;
=20
-			if (commit_hex[i] && parse_oid_hex(commit_hex[i], &oid, &end))
+			if (commit_hex->items[i].string &&
+			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
 				continue;
=20
 			result =3D lookup_commit_reference_gently(&oid, 1);
diff --git a/commit-graph.h b/commit-graph.h
index 71a39c5a57..66661e1fc5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -2,6 +2,7 @@
 #define COMMIT_GRAPH_H
=20
 #include "git-compat-util.h"
+#include "string-list.h"
=20
 char *get_commit_graph_filename(const char *obj_dir);
=20
@@ -47,10 +48,8 @@ struct commit_graph {
 struct commit_graph *load_commit_graph_one(const char *graph_file);
=20
 void write_commit_graph(const char *obj_dir,
-			const char **pack_indexes,
-			int nr_packs,
-			const char **commit_hex,
-			int nr_commits,
+			struct string_list *pack_indexes,
+			struct string_list *commit_hex,
 			int append);
=20
 int verify_commit_graph(struct commit_graph *g);
--=20
2.18.0.rc1

