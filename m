Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1431F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbeGTRXS (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:23:18 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:31488
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731000AbeGTRXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZjsPpoP6inI0G10nqxX/aTM/ij/YbL6kwv9W2uBFDM=;
 b=i6FxT3sylvXnfvcJLehy3Gp96GbldzAo7H3ApAGyyHTKzVratrvzBSxPcJ5oBsWtFvZrN1+2apiAhyOuqcdRAAQLt1Jh9vcO8IebcDYg/a0a1uVytSoYIiTGdpOUDhm9GBKkNMnaTNr2jEvKQnihh/H51sBjc+jfbHk7JNf53TY=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:22 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:22 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 13/18] test-reach: test reduce_heads
Thread-Topic: [PATCH v2 13/18] test-reach: test reduce_heads
Thread-Index: AQHUIEdf58DhqORDLUK4eFAB+5Qn/w==
Date:   Fri, 20 Jul 2018 16:33:22 +0000
Message-ID: <20180720163227.105950-14-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:PTwvwBu0+SlyxgbD0OBg95sLfVwDo2eZn0MAvwlrmdrS0tGL8wAJH51CHdTq4u667703fqI9HCtu5l8bYQtQPG82FfLifczTkEblr5hqbALx0TBLtCQReNYIqxl6YNbG3y55EOfIcoV9UXL5GW0WSH5xqaR6dfa2nKp1YaInXz2QIwE3atuZ5n6LqDkgiGg00CS7sWPUZaHgmHhYgS6D7CZdj9Yb54fgpoWxprbVaaBXJcuS9fVeN0tgFSarrjeDip+NRti1S/nuPaq5LgV6T9WkrVav+l74ddcEcm8tRApgrCLf7dFlCIQrQAvSkO3OPc9GDjkuSuELDcfSP5jZzw/epZub+Aaseci707onjDf+bzngXck7f3WfmlTaL0lSij56Q3HcXTba3C8LGr9AIgq+SC5J157Eug4O5cVDMDbNr5kZ0PPEcWMupvENB0DfoxUynfuv+w6e0PF5EesiGQ==;5:DlEToHebeeQ/6OzszvFYokOelTFQ0M0hYpOvZUU7c5Mgdlg8h9t7T8wv6rfQP5wr9aj0KMbG5N0C7/rAU9qLpnlY5shhk8Idgg72TuwAvZds4O7kSH4pagR32Wx16VACSvujDCMmyw1f7hRNXJvpxr1jKgxuu/UavT8jqCqbBfY=;7:RxoNdwsy9zdKjTpvau7FeekplI5Am67WURO3agTWVEUiMVbhtLN/mcHBJQx8DsLXgBe4WsbPRlWaNbGT6u6JxrAyFlREyJVAgjNjws9qhWaadQlIOHDkln/NIqb6061HUejPPoJZDLhr5vY48VZRDlacXqbzeD9/zq3p/+4qN/oUa6t7V1V5wxsX40XPcil5m/3CucPwiQ4yahu4Kq+bf5fmpLZJeMPBbNdsrOztFceMvUb7V/uvD7Ah0tNV+s1l
x-ms-office365-filtering-correlation-id: f57a3d39-6cd7-428c-118d-08d5ee5e81e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929BA06211DE5C9371BE53AA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XaEic/69QGBAEUAmG9xuBlAnzIhOWOddlI3D1Ub6KUz3AAfbJykoAEY0+6ZYGhZcAT3CTcyfi+2drOEKlbYfkDpVTZOIDjDXpYwWmUcExIb4y6hRjDNX9XBxFH7YRjTJD6TOY8PXJbE0UFt5skLbsy+QquY503QjIjrCQdsqLTKTYfj9UJwRW/HXyGrBCGVmHR7b1IiNbUaKRji0yeGFfrs6ImnUtCQdpo6ERco38QfXTGzRRMtpt8BR03oU+mR+Eq7rxe3z20IdnBrglVHHI6Pp0jOvRxa2M8DCuwD9iIRvls0HMDDtw9+lveo4MX4ank3Yp+an0kxAwIEQXTLpoY5bPl6hKEg1Do198e/mDow=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57a3d39-6cd7-428c-118d-08d5ee5e81e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:22.0408
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
 t/helper/test-reach.c |  4 ++++
 t/t6600-test-reach.sh | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 4df01187c9..e32e193b70 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -102,6 +102,10 @@ int cmd__reach(int ac, const char **av)
 		struct commit_list *list =3D get_merge_bases_many(A, X_nr, X_array);
 		printf("%s(A,X):\n", av[1]);
 		print_sorted_commit_ids(list);
+	} else if (!strcmp(av[1], "reduce_heads")) {
+		struct commit_list *list =3D reduce_heads(X);
+		printf("%s(X):\n", av[1]);
+		print_sorted_commit_ids(list);
 	}
=20
 	exit(0);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d43e1a61d5..17c6467988 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -138,4 +138,26 @@ test_expect_success 'get_merge_bases_many' '
 	test_three_modes get_merge_bases_many
 '
=20
+test_expect_success 'reduce_heads' '
+	cat >input <<-\EOF &&
+	X:commit-1-10
+	X:commit-2-8
+	X:commit-3-6
+	X:commit-4-4
+	X:commit-1-7
+	X:commit-2-5
+	X:commit-3-3
+	X:commit-5-1
+	EOF
+	{
+		echo "reduce_heads(X):" &&
+		git rev-parse commit-5-1 \
+			      commit-4-4 \
+			      commit-3-6 \
+			      commit-2-8 \
+			      commit-1-10 | sort
+	} >expect &&
+	test_three_modes reduce_heads
+'
+
 test_done
--=20
2.18.0.118.gd4f65b8d14

