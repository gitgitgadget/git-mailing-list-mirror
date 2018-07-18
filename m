Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA811F597
	for <e@80x24.org>; Wed, 18 Jul 2018 13:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeGROSl (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 10:18:41 -0400
Received: from mail-co1nam03on0125.outbound.protection.outlook.com ([104.47.40.125]:39442
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731314AbeGROSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBdq2DZF+qYDrG3CIN89QHeOcgrmtY4WyU2+Z92DVl4=;
 b=B/Fa8r9dt9OPYuP3yAiCtuXv27UReZm01mMFt+f7MpUEXTOxojhcAP09/2bi7Mpf7UzVoT70EtPB6+OPLibfQ/klJRi1lAethzrDgGBxuqXtOQFDIGde7FDibbP/Gd41Ofbd3w4Sfgel5ahG7ZUFxS6uFSev23TgJS9vPH4yaRA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0993.namprd21.prod.outlook.com (52.132.23.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.995.0; Wed, 18 Jul 2018 13:40:38 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Wed, 18 Jul 2018
 13:40:38 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "mhagger@alum.mit.edu" <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] TO-SQUASH: replace the_repository with arbitrary r
Thread-Topic: [PATCH] TO-SQUASH: replace the_repository with arbitrary r
Thread-Index: AQHUHpzpdB98e6+lUkS/hoYED3xsHQ==
Date:   Wed, 18 Jul 2018 13:40:38 +0000
Message-ID: <20180718134026.243823-1-dstolee@microsoft.com>
References: <20180717224935.96397-3-sbeller@google.com>
In-Reply-To: <20180717224935.96397-3-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0034.namprd02.prod.outlook.com
 (2603:10b6:803:2e::20) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;6:NTzjc9ib3xCTyZzXTur8ZGi6hxpmUt1sV3Xu2TmPdgQVau3u7EYUQXNkeS8CekEKgWaw99ZK/Lvmi6YBrkUmNYFqdhpozXg6Ki6T58hAoOKmc7vOkg8Y84NblM6ZMj7WFGXnr7xUspv+NHlJpxfKmxWH2ScQzlHsU0SnJLrYZcYy7jqJxybcyxOR7mNET7KR34+rw8dD2dSfI6CArCwmkDhcI7H+FFKMEtjoWWj6+I65Wby4FCGy3WN2A7DuKMGuetic2HD1rzZjxus8jOKaIffqDvvkjaLH7acSOL/o6ZorgmlVrjfOc1txLda/kVhk7imPsjb1Bi/MU+U7kuKe2PS3BXnRzx6sunY2y9xjHDsulWcVBIeZiZbFkX6oCRh1Xkm9TErAZl8WNkgmCpWYaYAMMR0xf1jpv5KsZIZrbslXMgdoicQ61iby9CDwS9sx2SsccsFMbiwOV/5E2tTz5A==;5:QjukRqnbBTn6I17yqt6qEHcTX6EQp3TH1Gi6NHnBPJ7nwQVLS38bpme6UvwZwGDlIwj2Y3y579r0eN11DGEiUu2nAmnlEBuMxOgv1eDgtATdc86VuXMDhFZlKOLXXkirfujxYnU/tONxivaXitpO9tYRUmdtYunK9qQIkeReSTI=;7:qidVk7izKMJ8ms6JBeyfz8L2/ibOlsqEW/gvzFimEDKRN9U0BHHCrVR9L3ITMiNhAaucpm7MiBB9Zb2CddPN1YuOA2xRKB86qbtVqkE3LLicVCbsNwmCUhHw6bRla8BX4z2ygkYuHUoRZo3aAaMN2Fb44r6Sf9OTHNQ+MOPAULBZJgC1d7bNALwPjXJBgLhL1rNNZgQ6EPne8xCHA/3FOKdKFQ0OODJvbmhXYIY85e6PqVnoCPSoDd9HFNqFyolP
x-ms-office365-filtering-correlation-id: 7726f2cf-f38b-41ee-5079-08d5ecb40ba7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600064)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB099314E8AFAA53AD8A81F695A1530@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(256004)(6512007)(6436002)(6486002)(1857600001)(186003)(105586002)(2900100001)(6506007)(386003)(102836004)(76176011)(99286004)(52116002)(5640700003)(486006)(2906002)(446003)(36756003)(11346002)(107886003)(46003)(10290500003)(86362001)(5250100002)(2501003)(575784001)(86612001)(106356001)(2616005)(476003)(478600001)(1076002)(2351001)(10090500001)(81156014)(81166006)(1730700003)(14454004)(7736002)(316002)(4326008)(25786009)(8676002)(8936002)(305945005)(22452003)(53936002)(54906003)(5660300001)(68736007)(6116002)(6916009)(97736004)(129723003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ymZ7yx50RVZ7WXers75OZnRAIXPtqGTi7NRvHcnGS/ng8n44xocWTQcYYdzvbXYsll/8YsGIlRwZKRzUljcazJEJAPVT5nCSdNm1mR468DSvpe9S+oxqyLYNYo2LCT8MVkTh4m7y/hnXTx3uJmOwnFGNKWg5WHR9ODn320VoSVwAqmQn+r0AbQE/BO1DGUBMOXeeTXe+5fk7/hXFMNJCmF0onDBNP2lgbRUe/bNB+Br+sJSA69aVm/qKKSwd1WghrxX2xWwuVCBJx6DcoUej8fk/kgdAk4i/kULte9Jg/1fNaWqHz/+FtwbWR2s6Cvqp0u0KK0IjFpKRgnk+hvZMk5egwxTswP8yed8nuWttoyQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7726f2cf-f38b-41ee-5079-08d5ecb40ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 13:40:38.2650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

This should just be squashed into PATCH 2.

 builtin/replace.c | 5 ++---
 replace-object.c  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 5f34659071..d0b1cdb061 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -57,9 +57,8 @@ static int show_reference(struct repository *r, const cha=
r *refname,
 			if (get_oid(refname, &object))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
=20
-			obj_type =3D oid_object_info(the_repository, &object,
-						   NULL);
-			repl_type =3D oid_object_info(the_repository, oid, NULL);
+			obj_type =3D oid_object_info(r, &object, NULL);
+			repl_type =3D oid_object_info(r, oid, NULL);
=20
 			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
 			       oid_to_hex(oid), type_name(repl_type));
diff --git a/replace-object.c b/replace-object.c
index 01a5a59a35..017f02f8ef 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -26,7 +26,7 @@ static int register_replace_ref(struct repository *r,
 	oidcpy(&repl_obj->replacement, oid);
=20
 	/* Register new object */
-	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
+	if (oidmap_put(r->objects->replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
=20
 	return 0;
--=20
2.18.0.118.gd4f65b8d14

