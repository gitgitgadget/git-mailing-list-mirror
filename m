Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEF51F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966898AbeF2QND (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:13:03 -0400
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:13680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966880AbeF2QNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYEeLLcCmRwp3l+qJ5BKQhW42Gp0D2FmVMPVHhh/YDg=;
 b=OB/jSmi5CT9cHXSf0xvkrR320Tpcucc3KR3I4QQ30wVSBdJK5CBDvZyQIraKZiMNP0yPJwzpYM7BaehJPll7nqdbbovqHRAHMtVpfPPk2FEbv61axlNmf8ZiJkVjjFzLcm3q8MBkcuf/+/tJQ8K8EfwgxdCUHfPHftXoGMHqjnk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:58 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:58 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 09/13] commit-reach: test can_all_from_reach
Thread-Topic: [RFC PATCH 09/13] commit-reach: test can_all_from_reach
Thread-Index: AQHUD8QLvvu4RsAXF06i3ypsMkYkZQ==
Date:   Fri, 29 Jun 2018 16:12:57 +0000
Message-ID: <20180629161223.229661-10-dstolee@microsoft.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:406:80::39) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:d8ixBFwDACTVxOcdG/4EFCeVwBN8nXFdbfpL+Mo272qCPWOuvmb0+x3OBTYy4yj7xx1bssAi67l7+JhklmAOuIp5n0TL3wqDG2vsC4ijtcq8foxW32Xb80Vs6CdwefDemEwK75pl/G6gWmFViH2lW4GdIcog8ZeobXKO1xTMwtprSWPByIJrimGMDPFdFfwlE8GTWm2araF8kBTdnR0W4Cs8fq/yHwnNzrgWVGr7NJ5godojALvOcov0anes9NM6
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66b0c4ca-0cd9-4d82-da42-08d5dddb2d76
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB1044502543826554ABDE99CCA14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: O0yDxGG9G7w0048e/jAHX4Mn/sBBtja5CLONDr12R/p6kT3t+rOB101+ED1D/QRb4ywgrix3siyTy2oyTNLPO9rP1aXZK3IYV5/+gGhghsvPDv5QxSub7kTo+p9vnerVuTTwFGBC6PIzbw+rHvoqZPhKPRejhAPXnhbcrXtkANyQE5blmYVYJDxcTfYvUliGnTPpzQbTghG8W33CLffzU+6mgCNBrzRNe1wvlo18WF5DjIoV5Pp9AypKfbXO7PEcyVBM47v3xewDDV22zY9GDTvvG+WYx6RQJbqRBioZaGmWHsEH2IDO8pcOrrwetgFfx1/1qhXV39NxYOASyzbkAgbJBxd72UMmRHWCoSthSUA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b0c4ca-0cd9-4d82-da42-08d5dddb2d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:57.6045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c        | 52 +++++++++++++++++++++++++++++++++++++++----
 commit-reach.h        |  4 +++-
 t/helper/test-reach.c |  7 ++++--
 t/t6600-test-reach.sh | 51 +++++++++++++++++++++++++++++++++++++++---
 upload-pack.c         |  2 +-
 5 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 44c09669ec..992ad5cdc7 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -562,14 +562,14 @@ static int reachable(struct commit *from, int with_fl=
ag, int assign_flag, time_t
 	return (from->object.flags & assign_flag);
 }
=20
-int can_all_from_reach_with_flag(struct object_array from,
+int can_all_from_reach_with_flag(struct object_array *from,
 				 int with_flag, int assign_flag,
 				 time_t min_commit_date)
 {
 	int i;
=20
-	for (i =3D 0; i < from.nr; i++) {
-		struct object *from_one =3D from.objects[i].item;
+	for (i =3D 0; i < from->nr; i++) {
+		struct object *from_one =3D from->objects[i].item;
=20
 		if (from_one->flags & assign_flag)
 			continue;
@@ -580,7 +580,7 @@ int can_all_from_reach_with_flag(struct object_array fr=
om,
 			 * leave a note to ourselves not to worry about
 			 * this object anymore.
 			 */
-			from.objects[i].item->flags |=3D assign_flag;
+			from->objects[i].item->flags |=3D assign_flag;
 			continue;
 		}
 		if (!reachable((struct commit *)from_one, with_flag,
@@ -589,3 +589,47 @@ int can_all_from_reach_with_flag(struct object_array f=
rom,
 	}
 	return 1;
 }
+
+int can_all_from_reach(struct commit_list *from, struct commit_list *to)
+{
+	struct object_array from_objs =3D OBJECT_ARRAY_INIT;
+	time_t min_commit_date =3D from->item->date;
+	struct commit_list *from_iter =3D from;
+	struct commit_list *to_iter =3D to;
+	int result;
+
+	while (from_iter) {
+		add_object_array(&from_iter->item->object, NULL, &from_objs);
+
+		if (from_iter->item->date < min_commit_date)
+			min_commit_date =3D from_iter->item->date;
+
+		from_iter =3D from_iter->next;
+	}
+
+	while (to_iter) {
+		if (to_iter->item->date < min_commit_date)
+			min_commit_date =3D to_iter->item->date;
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
+
+	return result;
+}
diff --git a/commit-reach.h b/commit-reach.h
index c3da8488eb..8ab06af2eb 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -27,7 +27,9 @@ int commit_contains(struct ref_filter *filter, struct com=
mit *commit,
  * the 'with_flag' bit on? Mark the commits in 'from' that can reach
  * such commits with 'assign_flag'.
  */
-int can_all_from_reach_with_flag(struct object_array from, int with_flag,
+int can_all_from_reach_with_flag(struct object_array *from, int with_flag,
 				 int assign_flag, time_t min_commit_date);
=20
+int can_all_from_reach(struct commit_list *from, struct commit_list *to);
+
 #endif
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index d57660af45..88639a2945 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -15,9 +15,9 @@ int cmd__reach(int ac, const char **av)
 	struct strbuf buf =3D STRBUF_INIT;
=20
 	setup_git_directory();
-	get_git_config(default_git_config, 0);
+	git_config(git_default_config, NULL);
=20
-	if (argc < 2)
+	if (ac < 2)
 		exit(1);
=20
 	/* load input data */
@@ -117,6 +117,9 @@ int cmd__reach(int ac, const char **av)
 			printf("%s\n", oid_to_hex(&list->item->object.oid));
 			list =3D list->next;
 		}
+	} else if (!strcmp(av[1], "can_all_from_reach")) {
+		int result =3D can_all_from_reach(list_X, list_Y);
+		printf("%s(X,Y):%d\n", av[1], result);
 	}
=20
 	exit(0);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 0f60db9c60..ef25e70174 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -64,7 +64,7 @@ test_expect_success 'ref_newer:miss' '
 	cat >expect <<- EOF &&
 	ref_newer:0
 	EOF
-	test_reach_two_modes "ref_newer"
+	test_reach_two_modes ref_newer
 '
=20
 test_expect_success 'ref_newer:miss' '
@@ -75,7 +75,7 @@ test_expect_success 'ref_newer:miss' '
 	cat >expect <<- EOF &&
 	ref_newer:1
 	EOF
-	test_reach_two_modes "ref_newer"
+	test_reach_two_modes ref_newer
 '
=20
 test_expect_success 'reduce_heads' '
@@ -101,7 +101,52 @@ test_expect_success 'reduce_heads' '
 	git rev-parse commit-1-10 >>expect &&
 	printf "reduce_heads(Y):\n" >>expect &&
 	git rev-parse commit-10-10 >>expect &&
-	test_reach_two_modes "reduce_heads"
+	test_reach_two_modes reduce_heads
+'
+
+test_expect_success 'can_all_from_reach:hit' '
+	cat >input <<- EOF &&
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
+	printf "can_all_from_reach(X,Y):1\n" >expect &&
+	test_reach_two_modes can_all_from_reach
+'
+
+test_expect_success 'can_all_from_reach:miss' '
+	cat >input <<- EOF &&
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
+	printf "can_all_from_reach(X,Y):0\n" >expect &&
+	test_reach_two_modes can_all_from_reach
 '
=20
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 7c58cb8f5e..e59fbca257 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -339,7 +339,7 @@ static int ok_to_give_up(void)
 	if (!have_obj.nr)
 		return 0;
=20
-	return can_all_from_reach_with_flag(want_obj, THEY_HAVE,
+	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE,
 					    COMMON_KNOWN, oldest_have);
 }
=20
--=20
2.18.0.118.gd4f65b8d14

