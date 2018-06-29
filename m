Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9BC1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966896AbeF2QNC (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:13:02 -0400
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:13680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966868AbeF2QM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev0+dIY8bxlOgN8SpeFpgA/RZr7234UYEbNEYu8aKL0=;
 b=HWz5+sdxfkQJPqHeqNL6pmp/82SMDMfzT1YfnA1ZJGxJkKPqV1xyaLxm9uL2QB93bOX713/dvm5U2UB+TFt25sleJ0EqCG81CSKUREvseCP+p6kNW6EBDv3z9uo/+pmq70AoG8EYyOTAaYHesm/GD64qDYltoEDBYQeDXlvGAOM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:56 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:56 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 08/13] test-reach: test reduce_heads()
Thread-Topic: [RFC PATCH 08/13] test-reach: test reduce_heads()
Thread-Index: AQHUD8QK/WmeBLV8YkK5woDUCojsYQ==
Date:   Fri, 29 Jun 2018 16:12:56 +0000
Message-ID: <20180629161223.229661-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:Tr3nt2xlbO8kmwdeiPL5J7mrrHmyqwiUiM+Px9n2yusL3FNyDtHuUC/6+2g7EPT+t3F17sF/kgHChDCY+xZ7fRqx1NomAaemO0GcNnTMExRmIVAMeooLiwSe6M3l5wKYlMk59sw6fNashMsn04TTFdTKYrVp/JcbG6hxo3duJKNCLBqWx/6deSU4cftXCGjJDpTlPjUQCiNBhRVcNDO2T20dwMQmGW4iyyItwMaBvji2Cfo+GpSorg1QC16VecSo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ad85f68-0f57-40e6-cca3-08d5dddb2c9c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB1044A3E679DAFD6D1B27726FA14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 86qbuw8jb7ZhkHU8dibcriU+dSvhlrivH9QTyIThAmbw/pR+CYdh33KW7yNeWcci8efxmIoEOFT1MMZ6ESeq51kcw/96eFZAekRBi0QBCJhgEL6eubNs654yrS/wEet9jgFQEHb5VJ67m25EaQuoltKWIWQScvdyhxLbSCukL3UFhC4IoE771wsftI5xANiy0WbguB1qadrezfEVhBb/fKgF0TGmRYjd0YOvDPmgNAR5NY/dQAQ51q+AjwvYVNSuvmT0a4SIQOxeorD7ztJTxhAy+MarI7a4JSxw50syshRBQ6leGYi6YAvLkpZN+/zAjSZprxGNBxyngtKPcTdz6y5lqxvq8Y1IEW0tDZSRyNY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad85f68-0f57-40e6-cca3-08d5dddb2c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:56.2335
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
 t/t6600-test-reach.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index c9337b6b46..0f60db9c60 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -78,4 +78,30 @@ test_expect_success 'ref_newer:miss' '
 	test_reach_two_modes "ref_newer"
 '
=20
+test_expect_success 'reduce_heads' '
+	cat >input <<- EOF &&
+	X:commit-1-10
+	X:commit-2-8
+	X:commit-3-6
+	X:commit-4-4
+	X:commit-1-7
+	X:commit-2-5
+	X:commit-3-3
+	X:commit-5-1
+	Y:commit-10-10
+	Y:commit-3-10
+	Y:commit-9-9
+	Y:commit-8-1
+	EOF
+	printf "reduce_heads(X):\n" >expect &&
+	git rev-parse commit-5-1 >>expect &&
+	git rev-parse commit-4-4 >>expect &&
+	git rev-parse commit-3-6 >>expect &&
+	git rev-parse commit-2-8 >>expect &&
+	git rev-parse commit-1-10 >>expect &&
+	printf "reduce_heads(Y):\n" >>expect &&
+	git rev-parse commit-10-10 >>expect &&
+	test_reach_two_modes "reduce_heads"
+'
+
 test_done
--=20
2.18.0.118.gd4f65b8d14

