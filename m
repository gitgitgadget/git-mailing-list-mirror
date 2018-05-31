Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A051F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755869AbeEaRl1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:41:27 -0400
Received: from mail-bn3nam01on0126.outbound.protection.outlook.com ([104.47.33.126]:26772
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755815AbeEaRlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6QN9YgHmNmEhjnb0/m2625+SyQRLJJkfvg7C0Wo6a0=;
 b=EZYnt/vFPfHrEAvpJz7j0q8Nb3j4yN4MEd/HHih1NhzC0k+jPIXJEVEevvPHbB2yJ9QK0V7K3zg37g/hFvf9DjOPlI3P9RW/YP5uLH+Y5OvAoTwx2rmT8e8/iAeF2sc97wCWMElVdESsYXL4T4WOaA2Q7fiDqwz1SjKwr8NaJJo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.6; Thu, 31 May 2018 17:41:13 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1%5]) with mapi id 15.20.0841.006; Thu, 31 May 2018
 17:41:13 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 3/6] commit-graph: enable replace-object and grafts
Thread-Topic: [RFC PATCH 3/6] commit-graph: enable replace-object and grafts
Thread-Index: AQHT+QaRH7dCtiR16U+C/CUvAr/3iw==
Date:   Thu, 31 May 2018 17:41:13 +0000
Message-ID: <20180531174024.124488-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:BTaSW7W1GCWGpZQC0bpkm4oXfwtpcbusyuvrFThvBE6Za3UrstvzxWhIPqi18G0NGolob74IDlh2F+gDiC8glur3AUP2Y1hXJLfNQfVF9RgMl4pzYOw99zNwHAiWPSiEKROmhhxwzSzC5ss4/WI9PW71ICGKOGpss89hBWaczfHYnvUH3N6jtix8NsqN4ByXshTUI9c9+Bvj9PGTu1zuVm9c5a8JGUXW+6g7jlk+EpgE8gSlYrb8UXr623AqV2PR;20:8pptXQsppTcZ1KbJp/myzl+9DCs1aPDvctzGiLu1OZ2jyHsaXe3XwU0bZdaodZ/IzCI5Jz4M9Gy5MorF/umo1xg//yGxEkTFKOIQOk+tweAXjEcFyr6QD2l2Ln3dr9SNAHm0M2oMSQEvwTmQsbt7jrGdsYn06WyNBx2K9026sDk=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0977A377801160B9BB55E6BBA1630@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(346002)(39380400002)(376002)(189003)(199004)(5250100002)(2351001)(6512007)(10090500001)(97736004)(186003)(3660700001)(54906003)(68736007)(3280700002)(2900100001)(46003)(53936002)(86612001)(86362001)(6486002)(36756003)(6116002)(1076002)(478600001)(99286004)(14454004)(102836004)(316002)(2616005)(6506007)(25786009)(11346002)(8936002)(305945005)(386003)(6916009)(6436002)(5660300001)(2906002)(81156014)(81166006)(476003)(76176011)(5640700003)(8676002)(446003)(59450400001)(107886003)(22452003)(2501003)(1730700003)(486006)(52116002)(106356001)(7736002)(10290500003)(105586002)(39060400002)(4326008)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BXrI04BN/1FQP8GwXoBjpr1i4pZoN1YiE+zK9PZMklRDyv9Jo0YkuR17GLfLL/Ua5ycdjrLYrM64IDOI6GGeiu2Sz9C9g/IIXyfCdOhljTWUDXyfWu3CSzDbcuyfgH7SynW1l9095V6qGlVXRJ4f0nsjm81GT2PksStA1KXowe+XPSDqb1+0p71ihFtzuK4M
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bc6e6c32-e69b-4676-f09a-08d5c71db3ac
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6e6c32-e69b-4676-f09a-08d5c71db3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 17:41:13.0852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create destroy_commit_graph() method to delete the commit-graph file
when history is altered by a replace-object call. If the commit-graph
is rebuilt after that, we will load the correct object while reading
the commit-graph.

When parsing a commit, first check if the commit was grafted. If so,
then ignore the commit-graph for that commit and insted use the parents
loaded by parsing the commit buffer and comparing against the graft
file.=20

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/replace.c |  3 +++
 commit-graph.c    | 20 +++++++++++++++++++-
 commit-graph.h    |  9 +++++++++
 commit.c          |  5 +++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 9f01f3fc7f..d553aadcdc 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -15,6 +15,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "tag.h"
+#include "commit-graph.h"
=20
 static const char * const git_replace_usage[] =3D {
 	N_("git replace [-f] <object> <replacement>"),
@@ -468,6 +469,8 @@ int cmd_replace(int argc, const char **argv, const char=
 *prefix)
 		usage_msg_opt("--raw only makes sense with --edit",
 			      git_replace_usage, options);
=20
+	destroy_commit_graph(get_object_directory());
+
 	switch (cmdmode) {
 	case MODE_DELETE:
 		if (argc < 1)
diff --git a/commit-graph.c b/commit-graph.c
index e9195dfb17..95af4ed519 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -6,6 +6,7 @@
 #include "pack.h"
 #include "packfile.h"
 #include "commit.h"
+#include "dir.h"
 #include "object.h"
 #include "refs.h"
 #include "revision.h"
@@ -240,15 +241,22 @@ static struct commit_list **insert_parent_or_die(stru=
ct commit_graph *g,
 {
 	struct commit *c;
 	struct object_id oid;
+	const unsigned char *real;
=20
 	if (pos >=3D g->num_commits)
 		die("invalid parent position %"PRIu64, pos);
=20
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
+
+	real =3D lookup_replace_object(oid.hash);
+
 	c =3D lookup_commit(&oid);
 	if (!c)
 		die("could not find commit %s", oid_to_hex(&oid));
-	c->graph_pos =3D pos;
+
+	if (!hashcmp(real, oid.hash))
+		c->graph_pos =3D pos;
+
 	return &commit_list_insert(c, pptr)->next;
 }
=20
@@ -1019,3 +1027,13 @@ int verify_commit_graph(struct commit_graph *g)
=20
 	return verify_commit_graph_error;
 }
+
+void destroy_commit_graph(const char *obj_dir)
+{
+	char *graph_name;
+	close_commit_graph();
+
+	graph_name =3D get_commit_graph_filename(obj_dir);
+	remove_path(graph_name);
+	FREE_AND_NULL(graph_name);
+}
diff --git a/commit-graph.h b/commit-graph.h
index 9a06a5f188..1d17da1582 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -56,4 +56,13 @@ void write_commit_graph(const char *obj_dir,
=20
 int verify_commit_graph(struct commit_graph *g);
=20
+/*
+ * Delete the commit-graph file in the given object directory.
+ *
+ * WARNING: this deletes data, so should only be used when
+ * performing history-altering actions like replace-object
+ * or grafts.
+ */
+void destroy_commit_graph(const char *obj_dir);
+
 #endif
diff --git a/commit.c b/commit.c
index 6eaed0174c..2fe31cde77 100644
--- a/commit.c
+++ b/commit.c
@@ -403,6 +403,11 @@ int parse_commit_internal(struct commit *item, int qui=
et_on_missing, int use_com
 		return -1;
 	if (item->object.parsed)
 		return 0;
+
+	prepare_commit_graft();
+	if (commit_graft_pos(item->object.oid.hash) >=3D 0)
+		use_commit_graph =3D 0;
+
 	if (use_commit_graph && parse_commit_in_graph(item))
 		return 0;
 	buffer =3D read_sha1_file(item->object.oid.hash, &type, &size);
--=20
2.16.2.338.gcfe06ae955

