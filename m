Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDB51F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeDQSKm (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:10:42 -0400
Received: from mail-by2nam01on0097.outbound.protection.outlook.com ([104.47.34.97]:5120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752719AbeDQSKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AI3qSFaGwDtTcHS3Y9cdIgcfvzs404cOzzSRdVZiOks=;
 b=UhZb1o07O+sToWPdi6YQDGJRB2i501r4WYxMvp8knrF+GEvgUefgrF3rJDUGWzW6m21T+KoiZmyof8KZab+GaqF+UFSDt07bjar7nep8ujm9djLdguIa2bob+FZDWIYU1FRYgJUMSVnNc0XZiVRmdEOJOamf0hgzM3Q1sMxHcXA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1027.namprd21.prod.outlook.com (52.132.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:38 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:38 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 01/12] fixup! commit-graph: always load commit-graph
 information
Thread-Topic: [RFC PATCH 01/12] fixup! commit-graph: always load commit-graph
 information
Thread-Index: AQHT1ndj7m9uk0x5MkKlFLLRZM186A==
Date:   Tue, 17 Apr 2018 18:10:38 +0000
Message-ID: <20180417181028.198397-2-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:zJMxtqEc4lVqU5IQK5BKc0+Et6ZKw+4rckJCi6vobAbDyHVHVtgfGPKqATPk9QG0P91cRbwNE28pxiwDSV6z+KVjzIA8iv6ZQ9dcgGag5iy8nNdWiw6R7EeF18XXkWUu02a5DG+nocO1rWlnhOwMaqgpopDIxR5a7NDoVU3JKAX7darReNfBB9NKnohrgQm8esTy64OM3NvjNdEIfKy+nAXuefCiEmTXcJWD3UlwrQfAYuwHrQys4Wbq9huRrE5V;20:ipjrgqNsWKuMIHCYYob5IAUwOYv1jn9CL032e74/wcVwxi2UoJ1W3D2emp70bgSof33l2ru0nL9prCOO0aljvv7VIfxud+0k3Mn8Aq9QI12MIIMF1MchsUlbFMJ9pY6/58+2PvAos2xD4xMTff9hGPzUpA/G2r4F5GYWCUck3Rs=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB102720403D9C339A02F2BD6EA1B70@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(6512007)(5660300001)(186003)(107886003)(6916009)(2900100001)(478600001)(10290500003)(105586002)(106356001)(2906002)(86612001)(86362001)(99286004)(53936002)(25786009)(22452003)(575784001)(54906003)(316002)(5250100002)(6486002)(6506007)(97736004)(4326008)(8936002)(14454004)(102836004)(3660700001)(6436002)(36756003)(5640700003)(3280700002)(305945005)(10090500001)(81156014)(59450400001)(68736007)(446003)(76176011)(2501003)(52116002)(2351001)(11346002)(8676002)(476003)(1076002)(386003)(81166006)(2616005)(7736002)(486006)(46003)(6116002)(1730700003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M0tEDwYMB6emGrBsLllJN/l15TPWsDLaD4R2npr1SJOr34+lzvUIqNTmZsfHytoPc751ur0V3dOyta9cuk/7SVfj5jdnJ7p/m7ssJpXF8dJUj5QUfiLFyoT0o6r35RuApjYIrRm0bBnmXuf4K4M+1DECVlet5QLrV2ESjzU20lRyOwxRcLPkUHyU4c5BpULT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 54da8f62-1579-4274-13a7-08d5a48e85da
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54da8f62-1579-4274-13a7-08d5a48e85da
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:38.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 21e853c21a..3f0c142603 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -304,7 +304,7 @@ static int find_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 		*pos =3D item->graph_pos;
 		return 1;
 	} else {
-		return bsearch_graph(commit_graph, &(item->object.oid), pos);
+		return bsearch_graph(g, &(item->object.oid), pos);
 	}
 }
=20
--=20
2.17.0.39.g685157f7fb

