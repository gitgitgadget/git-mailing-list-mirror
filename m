Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0731F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbeGTRWh (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:37 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:31488
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387858AbeGTRWh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRWIsYrMciANddYRdYqvwN0zCfeaoUHqMPjSv22xqhI=;
 b=HYGu/TBfkROoAwDMKCdln/F7wyEiPkgBdNtAQ6tqM08edXuFKDHBxYhn2PmnkmQp5Wa5yNdqM4ttjmF5dqu73cNvMVTpAZO44mPUHqkbvW5BnU3oX6Zs4MMbKgyb02s7ZhHICBrH/aPQNgmKXO4ygmF59TVL7iEnGrEVRAOmauw=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:20 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:20 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 12/18] test-reach: test get_merge_bases_many
Thread-Topic: [PATCH v2 12/18] test-reach: test get_merge_bases_many
Thread-Index: AQHUIEdejsRK0cR10E2hMjtvGFB+dg==
Date:   Fri, 20 Jul 2018 16:33:20 +0000
Message-ID: <20180720163227.105950-13-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:u2w1LraMLquTNn5g+DBAoItVLi0WOx9/4/CbWLHYeXWMwAfC37nREfTQxwzyso2edV39Xnc7NCATTMEtcJ+0N93W0XfZZj2NVFoBwoSBDm8CWID7aqFCaRQ5eGmiOgIAGv4hrxRyB7jd3qAn8vE8Q7KkCNMiIVYKXrzaCxGPjnzEwAZXP1By7Oa7CkLCtlZfFkn0Umc2rGQbTVTjTP5sv76VdSFKUfX4L/SfJm32VPC6z2KI6YEjQAzUO5a+futKaIatkMndPx29zw4tr+Bdanf3dVh8VkEGJQqqVj7XENkr1VLieaRac6XIYu3ZIyk6Ww7JT+rdG921Sd+LXBSG0lbl976KwU2WTUbWH39e+77szP1vUjEVv4/x81CUV5IdtBTLi2T7Iaa5xya/qCPM1LhQQVNit5L2Bhg2iTdZphpFs81orilrM7smzmNrVK+8AofN/fsa5UY7/Pi9j0tGcg==;5:AFprtXIQ5Vjuf3vQBKoozDeVmUSQqWQMCJIlvGwmoNrDMpM0K/ec/9NB+1wIWJZofKGSAdjJfszy+OUnCkDHAbI0/zRpiGh7499H3KxfI6niPfzAvbDH7Av246lY5qJaAGYhAKtjbMvEPLTTp4vouo3wHpmqhyazzeWGPF4NLBI=;7:R2qqJL5UF7tMdu5LSubBKqH+iKAztsKYqTJeEWC/oh7KqeQiJWqO0Q1gNkR4ee4wisuz8MxkjdYWMyWikZ0prG9QG8d4+TctMQtKDMUioBYd6j3gsI3GmR+Kk+AhikyVA0NW6tzbS24KFvST60188Rop1BvVbmEQmj6UlJeC6Z7NycFZnXiykKYbAbBp8N/IpUhJl9kjy0bwr1o2iunsmjAYFlxGh645D0/a/NGnJ2wSHR/IfYhgS0OLCtvEYstC
x-ms-office365-filtering-correlation-id: 3efc4b84-3d28-4f92-8875-08d5ee5e80ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929F8661ED99C54B8688329A1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fZlUORv6Xl2Ua3azkLOJF9cOIUs7XlGq64MH0+FQRnELRfXiuxwgvoupwTelN9EwTeC6JWwKV3JbMSxMWfBNYurgjVtq9+Iq9jVgJhtfud/aO641CG+bXb1WUx0kjPn8OiSbCmROBt3ECcYHMsKJ7FwTXVo2X7ToMwh4oNznL48OHRDrOCeY6kfEDuEKN1+KJKIftb/m/adq5+8emDVU1eVxddT5Kj+UcebiREEHKCOgdbGwSTgozm19fhVvO7oJLsGFJQjiAK+KqTer+DP1e1L8c+AdZ43w34j5FcceKFaxLUAVTSZ0uKn2sjNj/UhfhuRtVjjhlEGdAzgpQempviRVOMMJwezSYYxo4/18yYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc4b84-3d28-4f92-8875-08d5ee5e80ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:20.4707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_merge_bases_many method returns a list of merge bases for a
single commit (A) against a list of commits (X). Some care is needed in
constructing the expected behavior because the result is not the
expected merge-base for an octopus merge with those parents but instead
the set of maximal commits that are reachable from A and at least one of
the commits in X.

Add get_merge_bases_many to 'test-tool reach' and create a test that
demonstrates that this output returns multiple results. Specifically, we
select a list of three commits such that we output two commits that are
reachable from one of the first two, respectively, and none are
reachable from the third.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c | 31 +++++++++++++++++++++++++++++++
 t/t6600-test-reach.sh | 15 +++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index dccbd48178..4df01187c9 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -4,13 +4,34 @@
 #include "commit-reach.h"
 #include "config.h"
 #include "parse-options.h"
+#include "string-list.h"
 #include "tag.h"
=20
+static void print_sorted_commit_ids(struct commit_list *list)
+{
+	int i;
+	struct string_list s =3D STRING_LIST_INIT_DUP;
+
+	while (list) {
+		string_list_append(&s, oid_to_hex(&list->item->object.oid));
+		list =3D list->next;
+	}
+
+	string_list_sort(&s);
+
+	for (i =3D 0; i < s.nr; i++)
+		printf("%s\n", s.items[i].string);
+
+	string_list_clear(&s, 0);
+}
+
 int cmd__reach(int ac, const char **av)
 {
 	struct object_id oid_A, oid_B;
 	struct commit *A, *B;
 	struct commit_list *X;
+	struct commit **X_array;
+	int X_nr, X_alloc;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct repository *r =3D the_repository;
=20
@@ -21,6 +42,9 @@ int cmd__reach(int ac, const char **av)
=20
 	A =3D B =3D NULL;
 	X =3D NULL;
+	X_nr =3D 0;
+	X_alloc =3D 16;
+	ALLOC_ARRAY(X_array, X_alloc);
=20
 	while (strbuf_getline(&buf, stdin) !=3D EOF) {
 		struct object_id oid;
@@ -58,6 +82,8 @@ int cmd__reach(int ac, const char **av)
=20
 			case 'X':
 				commit_list_insert(c, &X);
+				ALLOC_GROW(X_array, X_nr + 1, X_alloc);
+				X_array[X_nr++] =3D c;
 				break;
=20
 			default:
@@ -72,6 +98,11 @@ int cmd__reach(int ac, const char **av)
 		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, X));
+	else if (!strcmp(av[1], "get_merge_bases_many")) {
+		struct commit_list *list =3D get_merge_bases_many(A, X_nr, X_array);
+		printf("%s(A,X):\n", av[1]);
+		print_sorted_commit_ids(list);
+	}
=20
 	exit(0);
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 98bcb17960..d43e1a61d5 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -123,4 +123,19 @@ test_expect_success 'is_descendant_of:miss' '
 	test_three_modes is_descendant_of
 '
=20
+test_expect_success 'get_merge_bases_many' '
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-6-6
+	X:commit-8-3
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse commit-5-6 \
+			      commit-4-7 | sort
+	} >expect &&
+	test_three_modes get_merge_bases_many
+'
+
 test_done
--=20
2.18.0.118.gd4f65b8d14

