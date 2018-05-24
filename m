Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB531F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031080AbeEXQZw (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:25:52 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:27752
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030884AbeEXQZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYP0J0Akkhq5Tfs6dKvqnQOWmr5/HWKRWQr6Y40YpCI=;
 b=H3/H/d2rQnfeq/K99b7a8mHMIORBRFs++hm1WdjQ8XXj74p3mDcCTMbT4QC8Zpr08wrYkqesYSXvmtSU0tl4nD5FpbjpfT2xpVAoI3lZUrcYX2wFYKfaSswe/6yXcmKlpy7w34UP2IjpJLxdQICIWyORLrWKU7VewzwdrSHKuXY=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:40 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:40 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 07/20] commit-graph: verify catches corrupt signature
Thread-Topic: [PATCH v3 07/20] commit-graph: verify catches corrupt signature
Thread-Index: AQHT83vaY2Nx9o62wkWniekPhdhboQ==
Date:   Thu, 24 May 2018 16:25:40 +0000
Message-ID: <20180524162504.158394-8-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:ICmaMrx0CGDWeye10xUVIrJNnz/JUkv7Pv08Ma8c4NK6ry4rHAEyX92YPVKtHA8mh6TYf1IqXrn9kefAVpCVw7L2UhHip4lm5H+pa9hjP/90rzaOLnmkgQsmatd0YlpYK0diQ2prVqoMr+eGFPA/X61t45uQ3S4VnMQ9sDmZMQOMr7k9Yoj+8QS5f0lDyNzyY8wMPrUD3DIandI1ezrhZ+NmyUgJfjSpRAXaGQDz/KeOntZQqG4/uNsLOTsH8NNr;20:bWUuB1e/e6uW+gSJFsjvvwSTXIikHTfV/mMz4ZyZELRB5OY5evFm3c4hP0vQpurTgZLJzWXiH+P87quQB+pZ0FibI9MX223oF0iBI0GAzyK+yDub1CNi9uWMcaYQ8GdSbM6m4p2mfkL8mUZ7uGrtOgRNUadofSfrqlE5/iTM/uU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB109180ACDE1099A9F1DDEC94A16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(15650500001)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w5cTCd3J3h6i7JifETYVbNmuYAk/2UMUx0oE4Jzl2Rb4tT8D/QW/O8esunCf6et4gFu/xP5w/0ppkcby4ATeTChI2S1kW0wxvhEN/DLEEvSdSGSDiRLr8Ctww6ntyPjXdCjr8Jmyo/vDTCQS0436yh+oIlgtZjfxM6SuCcXK1HmtLKOEK2rUq0KvON1+X4Zf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7b91f20f-e05b-4b13-40c7-08d5c192fcdd
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b91f20f-e05b-4b13-40c7-08d5c192fcdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:40.3314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first of several commits that add a test to check that
'git commit-graph verify' catches corruption in the commit-graph
file. The first test checks that the command catches an error in
the file signature. This is a check that exists in the existing
commit-graph reading code.

Add a helper method 'corrupt_graph_and_verify' to the test script
t5318-commit-graph.sh. This helper corrupts the commit-graph file
at a certain location, runs 'git commit-graph verify', and reports
the output to the 'err' file. This data is filtered to remove the
lines added by 'test_must_fail' when the test is run verbosely.
Then, the output is checked to contain a specific error message.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-commit-graph.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6ca451dfd2..bd64481c7a 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -235,9 +235,52 @@ test_expect_success 'perform fast-forward merge in ful=
l repo' '
 	test_cmp expect output
 '
=20
+# the verify tests below expect the commit-graph to contain
+# exactly the commits reachable from the commits/8 branch.
+# If the file changes the set of commits in the list, then the
+# offsets into the binary file will result in different edits
+# and the tests will likely break.
+
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
+	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
 	git commit-graph verify >output
 '
=20
+GRAPH_BYTE_VERSION=3D4
+GRAPH_BYTE_HASH=3D5
+
+# usage: corrupt_graph_and_verify <position> <data> <string>
+# Manipulates the commit-graph file at the position
+# by inserting the data, then runs 'git commit-graph verify'
+# and places the output in the file 'err'. Test 'err' for
+# the given string.
+corrupt_graph_and_verify() {
+	pos=3D$1
+	data=3D"${2:-\0}"
+	grepstr=3D$3
+	cd "$TRASH_DIRECTORY/full" &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	printf "$data" | dd of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$pos"=
 conv=3Dnotrunc &&
+	test_must_fail git commit-graph verify 2>test_err &&
+	grep -v "^+" test_err >err
+	grep "$grepstr" err
+}
+
+test_expect_success 'detect bad signature' '
+	corrupt_graph_and_verify 0 "\0" \
+		"graph signature"
+'
+
+test_expect_success 'detect bad version' '
+	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
+		"graph version"
+'
+
+test_expect_success 'detect bad hash version' '
+	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
+		"hash version"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

