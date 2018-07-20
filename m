Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A16D1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbeGTRWl (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:41 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388010AbeGTRWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VieSmVpqpBSu3HFWoiLg2Z6lnqAptb/ZtSlBtZk7/no=;
 b=nNTUdem27+T9/Kh8VuwzAOEjPcmTlUJMmuiFbcuHdLqbfNQ2qZEYrYq1tt0uUTqQ9lGfnv1Y3gNMSs3DFYR7bud98xhV0CokcfUXqOVUGzZmF6aDkk4ajYkmxSsf+wZyWCCRVtn2Dq46z4fQv+T2+vQ7i41FrRZQ1iorXyD3GGQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:25 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:25 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 15/18] test-reach: test commit_contains
Thread-Topic: [PATCH v2 15/18] test-reach: test commit_contains
Thread-Index: AQHUIEdhEb77BcH/H0KIKqyLEZbwxA==
Date:   Fri, 20 Jul 2018 16:33:25 +0000
Message-ID: <20180720163227.105950-16-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:bVvsLtkDXBlb+GKWDNLvQIvvOdWwVJ+4uFgIU/RQ53MEteTo5QxYX5yHBaxUmkNOPujlaeLYKz9o4K20Rz2G5rKd1dy4VifueFDYFUcm4OBnWwQHUUzKLNRhcrI5J76VjdFFRWSpLPbJ7u469sclU3TKGGK0KrcQu8rJc+J4RFOcIIGcQL7MHIMcMW78VhAzpO6tcMwZ2RelMdTGEl6h2nnzjH7hwNPWtsUTGeBCqZR8OZ9KxynVCw8OlYz43iDHSPpnWZvelWqfcZEfjLbys0GmIf/wgrWt69Y4guc44z9S4p0e/6a60jZ+/VqepC1dS7HPJfcCMe3nN2VOg6datuxU38TJjfEHT6nwJxjo2kBgc4GBCSL7O1Bo9+4HplPn4QdCvq6qbGYNBq9i8FFmgpb8bbrU0BNkyseNtS1XUNuRADbU6c8Hkelxm0qpEb9RuCpvpxVb2OkmrX/H1RRmqQ==;5:zM21t/bjLWw1cuoPC4lXXW8eRbwwpksBXz6pAKH/xeYwV6ZIpr0qwdV+stYYUls03u9bnhDUsTjM/fii7vZRCPuxQAfo3EZmF5XfSM5OaQdqDtt1UNvQjegLUzx04brxr/B4c/w/mvi+EMJrxWIJIJePrEa+4odEjKd2CXACp3c=;7:wumdLOdhrvYx29jt91e6n3p2QyFrPTgsNcSayEzwBD3EVk0+FdU0MM6w+OR2Dq9sLW6lkHBi6wxl4NCSGtCIQmEbQIvkQg8VUCF8K5a6I7H/Jk8gLWxkXpx1yxNSMFTWY2gkGkl9MhRESnpnmwRIgz8bDI3SYSutqmlMYCdjvyam8BGKxzyvDYQKjV8kwVdcTPiw7/jALxSP5ncSS4ipZep3M7HU8MV1pJ8eVOFhm8HcT13+19e6uBtr+s0xE4eg
x-ms-office365-filtering-correlation-id: 80835ce9-bbcd-42df-7c7a-08d5ee5e83e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB092921E30093BA948147FFA6A1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kX55I6CzjM5DAIuw5x/0hBJEXR0hgQOjBMG7v/SJEPraC0vPOo1t/AM7hDj/jgtMzqKlxysKi+Q/S1adQLL3l4bL2gPmwiITwTfpFk16nvx3eW1dcVrAjz/+hgUKBO0HJhgz1eZoNkNrb2r9HORUJm6Q1Kz4md8+/iGIJH96dn5rF7BAgf5Y850CP1kYIiAPuOcSVvz6nDoMtGd+VOD87yZefOBS+qcM45tFdGPmJCuRT7oQOpELSVANHwfqiSVn/WTuZgJeB1n8vhjJmVXSKnq+Cd/VpbU+iH05u9oiY55sElq/AvtivnYQSDlSoF3PLlg7UfNMz0E07imAR2LwgaIw+WSNuWm3o2tglfqv4lY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80835ce9-bbcd-42df-7c7a-08d5ee5e83e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:25.4472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit_contains method has two modes which depend on the given
ref_filter struct. We have the "normal" algorithm (which is also the
typically-slow operation) and the "tag" algorithm. This difference is
essentially what changes performance for 'git branch --contains' versus
'git tag --contains'. There are thoughts that the data shapes used by
these two applications justify the different implementations.

Create tests using 'test-tool reach commit_contains [--tag]' to cover
both methods.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c | 12 ++++++++++++
 t/t6600-test-reach.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index c79729cac0..eb21103998 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -4,6 +4,7 @@
 #include "commit-reach.h"
 #include "config.h"
 #include "parse-options.h"
+#include "ref-filter.h"
 #include "string-list.h"
 #include "tag.h"
=20
@@ -112,6 +113,17 @@ int cmd__reach(int ac, const char **av)
 		print_sorted_commit_ids(list);
 	} else if (!strcmp(av[1], "can_all_from_reach")) {
 		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(X, Y, 1));
+	} else if (!strcmp(av[1], "commit_contains")) {
+		struct ref_filter filter;
+		struct contains_cache cache;
+		init_contains_cache(&cache);
+
+		if (ac > 2 && !strcmp(av[2], "--tag"))
+			filter.with_commit_tag_algo =3D 1;
+		else
+			filter.with_commit_tag_algo =3D 0;
+
+		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache)=
);
 	}
=20
 	exit(0);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index e41eb397a7..d139a00d1d 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -205,4 +205,38 @@ test_expect_success 'can_all_from_reach:miss' '
 	test_three_modes can_all_from_reach
 '
=20
+test_expect_success 'commit_contains:hit' '
+	cat >input <<-\EOF &&
+	A:commit-7-7
+	X:commit-2-10
+	X:commit-3-9
+	X:commit-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	EOF
+	echo "commit_contains(_,A,X,_):1" >expect &&
+	test_three_modes commit_contains &&
+	test_three_modes commit_contains --tag
+'
+
+test_expect_success 'commit_contains:miss' '
+	cat >input <<-\EOF &&
+	A:commit-6-5
+	X:commit-2-10
+	X:commit-3-9
+	X:commit-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	EOF
+	echo "commit_contains(_,A,X,_):0" >expect &&
+	test_three_modes commit_contains &&
+	test_three_modes commit_contains --tag
+'
+
 test_done
--=20
2.18.0.118.gd4f65b8d14

