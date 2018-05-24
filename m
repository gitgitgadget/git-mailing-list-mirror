Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5CC11F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033623AbeEXQ0R (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:17 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030897AbeEXQ0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItF9UL6mUYkFYKJBlhpehlhtguX9bk7ozYN5GLe/fAc=;
 b=kFNFef+T/hAGE6sfYgCherWv3CgnGLvbI0E5bHqfiGijOhyGsC+tBbMiK3I2b9SODA6BKlp5thH/ehexpfiI7FA4HySwBVpyFEJpsDPw07dTwgisjk0IN0GjBzlCL2Ytg8fE4t+Mc5arWcX4fzNEXVjzwL/qJ7bTXzEXrc+ym8k=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:26:01 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:26:01 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 16/20] commit-graph: verify contents match checksum
Thread-Topic: [PATCH v3 16/20] commit-graph: verify contents match checksum
Thread-Index: AQHT83vnPdKoYK2f50O/s3Ws/E/biw==
Date:   Thu, 24 May 2018 16:26:01 +0000
Message-ID: <20180524162504.158394-17-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:077flBa/Ce9jC1azysujPZtJqP/oD6TqoZQIdnouutL6Wm9MnsJFfbzFeECAfq1h1n5dL/bNtNsIrxP/etphrlaqk+RdTXDMNk0TuZLgISu9yanvW4Bx+WR/OQ20PsOph//PNhJjrAfAfFNp9t4RtnfW3XazUpzvuosyC/jxRC84mpFMBKmSW/3uU5/+SkmWyR2wQhNQft+3Mrt7l4BQldxu3hF7roKa1QMrgWxtIazsZYGd8Kd09F2jyiwvOuOB;20:Dw5j5AvhVDLQOI7xgsTSnJW0CWBOh3AjyFqcknnUttkZ3314BsKoHKmWUfHCs9gRZ2J6WjxDiHC0gCNEheFtY6Uzd0peR1jANOdWVZIKoGHIH1b/aTe5m2XLsP05K2T6UXpZPNBPkGLMwix6J2tZ+sYuweW6CWzbNWoiSdsP1PY=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1091B578761D3DC83A3E09EEA16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(1496009)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(15650500001)(6436002)(6486002)(105586002)(6916009)(22906009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0y86zm++VupRHOb75f4iAwsmMSW9aJW1MwVQQQijQ7pLSxohBIqdP7PW8i0Q+Iom33iYKc9hpIFLj8jTd33FtlWAs4Q/uABU9mQj0jCHKrRrRWPzoK71BJEEQ/WbjB89bU89S1uVg4HiOB+v1ihDSwmJJumFZitcRNYEGPlBOUEP+pMMBBCca8Th5mG5wtv+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aaafe422-f792-42c5-110b-08d5c1930987
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaafe422-f792-42c5-110b-08d5c1930987
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:26:01.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file ends with a SHA1 hash of the previous contents. If
a commit-graph file has errors but the checksum hash is correct, then we
know that the problem is a bug in Git and not simply file corruption
after-the-fact.

Compute the checksum right away so it is the first error that appears,
and make the message translatable since this error can be "corrected" by
a user by simply deleting the file and recomputing. The rest of the
errors are useful only to developers.

Be sure to continue checking the rest of the file data if the checksum
is wrong. This is important for our tests, as we break the checksum as
we modify bytes of the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 16 ++++++++++++++--
 t/t5318-commit-graph.sh |  6 ++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d2b291aca2..a33600c584 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -841,6 +841,7 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr =3D 0;
 }
=20
+#define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 static int verify_commit_graph_error;
=20
 static void graph_report(const char *fmt, ...)
@@ -860,7 +861,9 @@ static void graph_report(const char *fmt, ...)
 int verify_commit_graph(struct commit_graph *g)
 {
 	uint32_t i, cur_fanout_pos =3D 0;
-	struct object_id prev_oid, cur_oid;
+	struct object_id prev_oid, cur_oid, checksum;
+	struct hashfile *f;
+	int devnull;
=20
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -879,6 +882,15 @@ int verify_commit_graph(struct commit_graph *g)
 	if (verify_commit_graph_error)
 		return verify_commit_graph_error;
=20
+	devnull =3D open("/dev/null", O_WRONLY);
+	f =3D hashfd(devnull, NULL);
+	hashwrite(f, g->data, g->data_len - g->hash_len);
+	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
+	if (hashcmp(checksum.hash, g->data + g->data_len - g->hash_len)) {
+		graph_report(_("the commit-graph file has incorrect checksum and is like=
ly corrupt"));
+		verify_commit_graph_error =3D VERIFY_COMMIT_GRAPH_ERROR_HASH;
+	}
+
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
=20
@@ -916,7 +928,7 @@ int verify_commit_graph(struct commit_graph *g)
 		cur_fanout_pos++;
 	}
=20
-	if (verify_commit_graph_error)
+	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
=20
 	for (i =3D 0; i < g->num_commits; i++) {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 240aef6add..2680a2ebff 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -279,6 +279,7 @@ GRAPH_COMMIT_DATA_WIDTH=3D`expr $HASH_LEN + 16`
 GRAPH_OCTOPUS_DATA_OFFSET=3D`expr $GRAPH_COMMIT_DATA_OFFSET + \
 				$GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS`
 GRAPH_BYTE_OCTOPUS=3D`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4`
+GRAPH_BYTE_FOOTER=3D`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4 \* $NUM_OCTOPUS_E=
DGES`
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -388,4 +389,9 @@ test_expect_success 'detect incorrect parent for octopu=
s merge' '
 		"invalid parent"
 '
=20
+test_expect_success 'detect invalid checksum hash' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

