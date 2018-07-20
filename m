Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7F01F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbeGTRWj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:39 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387858AbeGTRWj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni9f2ASF45kg6+oi3eGrGpdEIDUebHodDWBeWx9gWEA=;
 b=FS6x+J4M+5ndGcSpWvyOjsPpdCHymExsNry/3eHi/pK1ZCWamuvO4cQki3Jj46dx2CgEnkML1rCaZGlFpGn/pmZpRNNMiiasPEAKxl16J48e54D6QpoGC9qN/XcHupuzifR/DiQo+B1z/qnaNOHZk5ZVfUOMBwmEjM+fbOGNTUU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:23 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:23 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 14/18] test-reach: test can_all_from_reach_with_flags
Thread-Topic: [PATCH v2 14/18] test-reach: test can_all_from_reach_with_flags
Thread-Index: AQHUIEdgEwqIzI38ekGvjBFVZsXVIQ==
Date:   Fri, 20 Jul 2018 16:33:23 +0000
Message-ID: <20180720163227.105950-15-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:sAKoQQAV/WhHH/3EXB/L5gwpDcU1qFSfMcUHFiXb5Xlk8s3RNOo+SF3wa05LcfAMDO6/rV35BDwIw7v6AKW7O/g8IZYl/eM2I31hQFG18b/XhH5h6G59Te+1338Qec5JJYLZP81UsNVAJl/mDUp0zEPJD0WVLfQbN1E6wghTo4npNpWR4V9aneeesW+DUJV3FzqyFrMGS/eZlbZwsZgHhZHHxMdNj5wnK3LS5fU53iYX+QnqMO5KNi2W68SM6kRcRaQxwry8zgDozXqVyT4RHm9mXsTG+Iy3dlE0BNsLw1v5bix4IGFbqAVv46kTjemXWgA2aaisweCsnQPwXliGMcd8w3P4jb3f+YBhN2zFYGmQ9WuYY9qrJkmqn4o85SanYgGqhhJui/Z7G31cN0JYW1+NitgcFFpffag7qtMHALWIF1rKIp6TFjrLII7x5gC2NvVcdP44152mw1J5SZIUMw==;5:MyadKApnwSYxNR5mjta4hkjxiUUnd6rPD8TtWBqI5tqg/TXEb0LwUhCUVf4io/1oT1YEhRAQ35/Ub4IMeZzPMi0SQTt5jm1V7HZ8no8PIE0A3HYTgUBqw2IQ0eE9PulV7EamArMBUQdNI401KZjdUNPcQErf8HZUaOrejmlniNE=;7:ealtJ4n2siZs27ULmaxPhr4vKmzYPd/8HjzjieE125PWzGrhYL8g41zPHNMulVEePcqQUdGZwhUQSpQ4YcLCE+h7gOgkMG9HMaPFqp3HdGe6sZjoxF0A9dPdkfVpo2yPN6EUaaRFROX1AuShNjDbxzQL9i1pghmKBLXmDC/dS3PEwgZMg+NoogA0hOGh49SF442W22gzsoNiqyqangqxUNFnJdcqAv/l+TNzpyYmWVrbyahNHY9kRQWBOpYUbGgA
x-ms-office365-filtering-correlation-id: 9fd33df8-d2b0-4bd8-f988-08d5ee5e82f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929A437AB953E5C5AB9714CA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KcUtf3RYXygJK7PqY7YtehxE0ra46dIsdEd7j3g5usRI4obK5paShaXkA4df8bf63DTTbz8rs9UNTMyDh9VyDMVgVhm+C1iPyanthnbhXlRMB3x3Q+rmSj1WC7ztJg2Ajdgkma8tE/PzeiNeqE88hOghEVKT/We6b9uP+q3l0ey/uDp924RKEA9iN053fp512DWaN4VI96mUf6q0vGf0bOtopSvuveUVQ+ssHHcHWeh1Pf9GZp2S5BtTA5TeLTA5sU5sxWhHhUcHu4YsVwearnIMNDUTNRPfDuh1f1A9bVF2NJdpWpppZIst88geNYWzftGq/ZRamdSe+ZUCA9ZMW2BF6GjxvRftYXLMzpi32iE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd33df8-d2b0-4bd8-f988-08d5ee5e82f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:23.8701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The can_all_from_reach_with_flags method is used by ok_to_give_up in
upload-pack.c to see if we have done enough negotiation during a fetch.
This method is intentionally created to preserve state between calls to
assist with stateful negotiation, such as over SSH.

To make this method testable, add a new can_all_from_reach method that
does the initial setup and final tear-down. We will later use this
method in production code. Call the method from 'test-tool reach' for
now.

Since this is a many-to-many reachability query, add a new type of input
to the 'test-tool reach' input format. Lines "Y:<committish>" create a
list of commits to be the reachability targets from the commits in the
'X' list. In the context of fetch negotiation, the 'X' commits are the
'want' commits and the 'Y' commits are the 'have' commits.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c        | 47 +++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h        |  2 ++
 t/helper/test-reach.c | 10 +++++++--
 t/t6600-test-reach.sh | 45 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index d806291d5d..940fbf2e17 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -595,3 +595,50 @@ int can_all_from_reach_with_flag(struct object_array *=
from,
 	}
 	return 1;
 }
+
+int can_all_from_reach(struct commit_list *from, struct commit_list *to,
+		       int cutoff_by_min_date)
+{
+	struct object_array from_objs =3D OBJECT_ARRAY_INIT;
+	time_t min_commit_date =3D cutoff_by_min_date ? from->item->date : 0;
+	struct commit_list *from_iter =3D from, *to_iter =3D to;
+	int result;
+
+	while (from_iter) {
+		add_object_array(&from_iter->item->object, NULL, &from_objs);
+
+		if (!parse_commit(from_iter->item)) {
+			if (from_iter->item->date < min_commit_date)
+				min_commit_date =3D from_iter->item->date;
+		}
+
+		from_iter =3D from_iter->next;
+	}
+
+	while (to_iter) {
+		if (!parse_commit(to_iter->item)) {
+			if (to_iter->item->date < min_commit_date)
+				min_commit_date =3D to_iter->item->date;
+		}
+
+		to_iter->item->object.flags |=3D PARENT2;
+
+		to_iter =3D to_iter->next;
+	}
+
+	result =3D can_all_from_reach_with_flag(&from_objs, PARENT2, PARENT1,
+					      min_commit_date);
+
+	while (from) {
+		clear_commit_marks(from->item, PARENT1);
+		from =3D from->next;
+	}
+
+	while (to) {
+		clear_commit_marks(to->item, PARENT2);
+		to =3D to->next;
+	}
+
+	object_array_clear(&from_objs);
+	return result;
+}
diff --git a/commit-reach.h b/commit-reach.h
index b28bc22fcd..aa202c9703 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -72,5 +72,7 @@ int can_all_from_reach_with_flag(struct object_array *fro=
m,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
 				 time_t min_commit_date);
+int can_all_from_reach(struct commit_list *from, struct commit_list *to,
+		       int commit_date_cutoff);
=20
 #endif
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index e32e193b70..c79729cac0 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -29,7 +29,7 @@ int cmd__reach(int ac, const char **av)
 {
 	struct object_id oid_A, oid_B;
 	struct commit *A, *B;
-	struct commit_list *X;
+	struct commit_list *X, *Y;
 	struct commit **X_array;
 	int X_nr, X_alloc;
 	struct strbuf buf =3D STRBUF_INIT;
@@ -41,7 +41,7 @@ int cmd__reach(int ac, const char **av)
 		exit(1);
=20
 	A =3D B =3D NULL;
-	X =3D NULL;
+	X =3D Y =3D NULL;
 	X_nr =3D 0;
 	X_alloc =3D 16;
 	ALLOC_ARRAY(X_array, X_alloc);
@@ -86,6 +86,10 @@ int cmd__reach(int ac, const char **av)
 				X_array[X_nr++] =3D c;
 				break;
=20
+			case 'Y':
+				commit_list_insert(c, &Y);
+				break;
+
 			default:
 				die("unexpected start of line: %c", buf.buf[0]);
 		}
@@ -106,6 +110,8 @@ int cmd__reach(int ac, const char **av)
 		struct commit_list *list =3D reduce_heads(X);
 		printf("%s(X):\n", av[1]);
 		print_sorted_commit_ids(list);
+	} else if (!strcmp(av[1], "can_all_from_reach")) {
+		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(X, Y, 1));
 	}
=20
 	exit(0);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 17c6467988..e41eb397a7 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -160,4 +160,49 @@ test_expect_success 'reduce_heads' '
 	test_three_modes reduce_heads
 '
=20
+test_expect_success 'can_all_from_reach:hit' '
+	cat >input <<-\EOF &&
+	X:commit-2-10
+	X:commit-3-9
+	X:commit-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	Y:commit-1-9
+	Y:commit-2-8
+	Y:commit-3-7
+	Y:commit-4-6
+	Y:commit-5-5
+	Y:commit-6-4
+	Y:commit-7-3
+	Y:commit-8-1
+	EOF
+	echo "can_all_from_reach(X,Y):1" >expect &&
+	test_three_modes can_all_from_reach
+'
+
+test_expect_success 'can_all_from_reach:miss' '
+	cat >input <<-\EOF &&
+	X:commit-2-10
+	X:commit-3-9
+	X:commit-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	Y:commit-1-9
+	Y:commit-2-8
+	Y:commit-3-7
+	Y:commit-4-6
+	Y:commit-5-5
+	Y:commit-6-4
+	Y:commit-8-5
+	EOF
+	echo "can_all_from_reach(X,Y):0" >expect &&
+	test_three_modes can_all_from_reach
+'
+
 test_done
--=20
2.18.0.118.gd4f65b8d14

