Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5254C1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbeGTRWj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:39 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731583AbeGTRWj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22cxMNR2MqCyf6QMzlOSP0Xl7HceykOOeSxNzyoTE2w=;
 b=Dm6hOz8AcdUIiqN36EbfQ952WOCaUmrYHSZcriMeWE22fKB7+DVqTD/TXuTbJzl0qm/8BME568cwV/KYyGKl4tgfmaGhKETzfChE+NdtXjPZcoPDRf0Y4kLS78FDSsZT3DPwNAF5QAf/qv2y9MCUJ0vlbFgNvHZUiiKHDxJIGEE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:17 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:17 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 10/18] test-reach: test in_merge_bases
Thread-Topic: [PATCH v2 10/18] test-reach: test in_merge_bases
Thread-Index: AQHUIEdcI2Sp0F/bE0SPMsDWt3Eq3A==
Date:   Fri, 20 Jul 2018 16:33:17 +0000
Message-ID: <20180720163227.105950-11-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:Q8tjCR/mJg3pFkZkZUcJtZnO5RAPva98VQQuv1XXK6qLqHFWbEtsaxGc0V6oEBGO6EXVodFumF6yHemdzTMUoxXKHknwOf1GsQkBVnbqJ55a5BNsXKjfENfkb2a0CAr8/kmWuTArs0cMycCTCxbt/ipe69awK3GdQ1nVl1uIyi5aoZO9lN7kG4CTCZCeO+c1Yfe3/2PdSb6i1mYfq0lLIujmUVu0otDoaQPNz3so9Ot7+li8x7+cM7tmy+R9+rvfcmG2CPMwj9QfYin7kv5Sckip/1ST8tmGibV3I8TzekO7AzpwOpFj8g/KwPmXGrrng6YhxS8CFfto9zN1Re5bm0M+aPvNEl4hXw3Ak6eBdtTFIN38r/U0b90b8oMmBp4cS1jiLoALXsf6dz/jenKPsO7OG8TSY7fT0U2wsNH0HqNlwSwwynINwt6zB2SEYmb4wMjL9DdDwkxRYZNLkt5L3g==;5:RprQazU2DdPtbRiFTvBt8Ef2qNbh5g+xhagei9TAaypmK285ny8TTwfShNqaUGwhJWLeP/NEr8sNG4yy7qRcw68TKtN1vNHuy/c9HGhGdlEy+KJR/9cRuAXvWeVuH7KHZ3xDkGvWHhFNk9Mn9/1lKBqRYaD0DgEU0r9GOxXCk0o=;7:8PYx8QJlwthizwa7VGzneRkIxa+y3+d6tmQtarpNVG+qfJDiCnms4P1x86iKt95/taNk2tJY4dhzZFQcijUHjZztAAsBoF0xn1sy1jnBHemBB0eU3uCVmYu9nxzaCZoWTc/PCVJ2aLA/D8lGqgkJdD23rQVuZ6b1/w+dnBM9fxfCdNkagSeWPuYKTZck0SYNH+QmDZEIGO8q4cWBCISEWT+9RXbwSAUmLVb1y7l0qJWqnCNz4tjFDuHpnIR2sT5V
x-ms-office365-filtering-correlation-id: 4657d2bc-e73d-4825-171e-08d5ee5e7edf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929C12C066D9E8272BF7B57A1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9JbT4CUIC1aGEQb/4u1hsbSWQUR2VtS1SLg1Fk7ioC5Lqo4kZROUb0tO08vM9UAb3DMFEBL+dnOioMC9wIpeLi+VmS/jOz+Ic0qQ8qiDZzi93S0gP1lU5iwMFh3hD7aDgMardNO3SVj7L4+9XhCm9/e0Mazk4J42rDdbHmUxIbqcYdzCANNBCzrh+ajIJq6Omjajfck2RCAajGtpnygHmqu7gkdRjdEXENvstViPaB+OznaVYhSWV8xQJ8H6a2MaFP/ypNZf2noUqUfhRuf8FiA5/Xt2YMcRe7UxVajReR/ccTvMIUZC/rOahZ0CkHcFerO8jhnzgWJrGY4rQYA45y9O1aYXUVYbpP9j9cjxRGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4657d2bc-e73d-4825-171e-08d5ee5e7edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:17.1393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c |  6 ++++++
 t/t6600-test-reach.sh | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 620bb46041..f93ad5084d 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -9,6 +9,7 @@
 int cmd__reach(int ac, const char **av)
 {
 	struct object_id oid_A, oid_B;
+	struct commit *A, *B;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct repository *r =3D the_repository;
=20
@@ -17,6 +18,7 @@ int cmd__reach(int ac, const char **av)
 	if (ac < 2)
 		exit(1);
=20
+	A =3D B =3D NULL;
=20
 	while (strbuf_getline(&buf, stdin) !=3D EOF) {
 		struct object_id oid;
@@ -44,10 +46,12 @@ int cmd__reach(int ac, const char **av)
 		switch (buf.buf[0]) {
 			case 'A':
 				oidcpy(&oid_A, &oid);
+				A =3D c;
 				break;
=20
 			case 'B':
 				oidcpy(&oid_B, &oid);
+				B =3D c;
 				break;
=20
 			default:
@@ -58,6 +62,8 @@ int cmd__reach(int ac, const char **av)
=20
 	if (!strcmp(av[1], "ref_newer"))
 		printf("%s(A,B):%d\n", av[1], ref_newer(&oid_A, &oid_B));
+	else if (!strcmp(av[1], "in_merge_bases"))
+		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
=20
 	exit(0);
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 966309c6cf..5cd6b14c69 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -83,4 +83,22 @@ test_expect_success 'ref_newer:hit' '
 	test_three_modes ref_newer
 '
=20
+test_expect_success 'in_merge_bases:hit' '
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	B:commit-8-8
+	EOF
+	echo "in_merge_bases(A,B):1" >expect &&
+	test_three_modes in_merge_bases
+'
+
+test_expect_success 'in_merge_bases:miss' '
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	B:commit-5-9
+	EOF
+	echo "in_merge_bases(A,B):0" >expect &&
+	test_three_modes in_merge_bases
+'
+
 test_done
--=20
2.18.0.118.gd4f65b8d14

