Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCDD1F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966760AbeEJRe1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:27 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:53659
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966748AbeEJReS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GS7Y24+v567HlAl75gkVkBZzEV7POGKuqbEMZi1XSe0=;
 b=JXNfhmYvKcFe/1vqieWBG4onggVo+C3aEpsdCv0GRfngdIH4+xKg3tU4dUnEZWyuDVPQ48NIXKNkR5Qrr8Apqfzz47PqwYESL6pFXUmiLGqp/CnlDCbm/JYhpW58kw9tfyhtaF2Q8rvgKkcuzAPTdSMKG/I2/a3vXX9dBPmGHgo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:16 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:16 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 11/12] fetch: compute commit-graph by default
Thread-Topic: [PATCH 11/12] fetch: compute commit-graph by default
Thread-Index: AQHT6IUdGbW+UR7M/kSx1GVkfyQO8Q==
Date:   Thu, 10 May 2018 17:34:15 +0000
Message-ID: <20180510173345.40577-12-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:vJUdjF11VeFnQhNieyaw1uLOCuQu+cFKDPgTuXbxdev21mt9SdhOmGgCKgxV1SDZQ0c/kMfvsGeBy+oAdj5Tcb9BL4o4+y4DZJvpz0sgwzKmKOGpdNl7gfaFRqlzBvZFceJQbr9QFw0yfY9BCEzSNTOsGCGbJoo0itPgx/0riA9hkb25vWq6+ugS1Msa0Pkfua8htGm30N4Ew5SKlL5dIud7qyH++SPxl9uU3c+aX1C4aO0fwO9K+m+i/W48B1m1;20:rj5YuVP/5E7jdY//tj/wr4LJBx88ha+enApj9vaZdr/kUvpplC/g9u1L3fUslWC78wQkF4RouEjjo+YRGfdw/oBWBDSy8Oi8ppuI9eBrIpnqhBeBSRtMLLH47Lpl/EZRq8AAvvSaZVw3Q0NI1OtXz493HBYrhHQLgkAoG9xA7as=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096220814E75EDC5768289EDA1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5890100001)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(59450400001)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ijVHGRH7RErFfBAXYadJZoauNxwu/bPVerhSyJJcOJHoh3a/rx3PO4ylpM8c92ePYoqpzlj47oq8lwvvD/YdqDSSYAnXkw4MdCEDJHRr8PoYVpjDUlqyFD2kA03Ya1UnOq2jNuGG9qYyrup51xKsNscFvmaEOa/1L28YVsRRZ3F+YmKi8VmeG1HfT0wGsZp+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d246b3db-d241-46b4-373a-08d5b69c404f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d246b3db-d241-46b4-373a-08d5b69c404f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:15.8093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During a call to 'git fetch', we expect new commits and updated refs.
Use these updated refs to add the new commits to the commit-graph file,
automatically providing performance benefits in other calls.

Use 'fetch.commitGraph' config setting to enable or disable this
behavior. Defaults to false while the commit-graph feature matures.
Specifically, we do not want this on by default until the commit-graph
feature integrates with history-modifying features such as shallow
clones.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt |  4 ++++
 builtin/fetch.c          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9a3abd87e7..3d8225600a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1409,6 +1409,10 @@ fetch.output::
 	`full` and `compact`. Default value is `full`. See section
 	OUTPUT in linkgit:git-fetch[1] for detail.
=20
+fetch.commitGraph::
+	If true, fetch will automatically update the commit-graph file.
+	See linkgit:git-commit-graph[1].
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8ee998ea2e..254f6ecfb6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -38,6 +38,7 @@ enum {
 static int fetch_prune_config =3D -1; /* unspecified */
 static int prune =3D -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
+static int fetch_commit_graph =3D 0;
=20
 static int all, append, dry_run, force, keep, multiple, update_head_ok, ve=
rbosity, deepen_relative;
 static int progress =3D -1;
@@ -66,6 +67,11 @@ static int git_fetch_config(const char *k, const char *v=
, void *cb)
 		return 0;
 	}
=20
+	if (!strcmp(k, "fetch.commitGraph")) {
+		fetch_commit_graph =3D git_config_bool(k, v);
+		return 0;
+	}
+
 	if (!strcmp(k, "submodule.recurse")) {
 		int r =3D git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
@@ -1462,6 +1468,13 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 		result =3D fetch_multiple(&list);
 	}
=20
+	if (!result && fetch_commit_graph) {
+		struct argv_array commit_graph =3D ARGV_ARRAY_INIT;
+		argv_array_pushl(&commit_graph, "commit-graph", "write", "--reachable", =
NULL);
+		if (run_command_v_opt(commit_graph.argv, RUN_GIT_CMD))
+			result =3D 1;
+	}
+
 	if (!result && (recurse_submodules !=3D RECURSE_SUBMODULES_OFF)) {
 		struct argv_array options =3D ARGV_ARRAY_INIT;
=20
--=20
2.16.2.329.gfb62395de6

