Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2091F404
	for <e@80x24.org>; Fri, 14 Sep 2018 20:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIOBaE (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 21:30:04 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:25600
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOBaE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 21:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buVBrNEGVJ1ejPnwXPjvBvi+zgjlL3vypayHal3KR4o=;
 b=Z0fHYPPM+3hgKN1spjXoQz02G2Hrq18pHRm6MVnwdxO0ScKkulKS6FkAfXxSTKGDx5FY9qbMGG47na83WtSsE7wJZFXvqdnIeBB0EALNK94z67GWRAB48H9xAS8AbGC2F25r85+PFpIDMPv6n8b14epLECFCAX1h14SipCiRVvQ=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1083.namprd21.prod.outlook.com (52.132.149.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Fri, 14 Sep 2018 20:14:01 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 20:14:01 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>
Subject: [PATCH v2 2/5] preload-index: teach GIT_FORCE_PRELOAD_TEST to take a
 boolean
Thread-Topic: [PATCH v2 2/5] preload-index: teach GIT_FORCE_PRELOAD_TEST to
 take a boolean
Thread-Index: AQHUTGd5Hr3vQtUps02druf/BL7ikw==
Date:   Fri, 14 Sep 2018 20:14:01 +0000
Message-ID: <20180914201340.37400-3-benpeart@microsoft.com>
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
 <20180914201340.37400-1-benpeart@microsoft.com>
In-Reply-To: <20180914201340.37400-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY1PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::29) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:y38ACaYmgwErdmyRcmqJZyO8cbXxQoJ72uzkH/Nh0QQN0D8gQgerVG0eDHGQhws1S/nBuZ7wOmSbfHX2fj3EByjNT/RDlDLHNmqgPjdh6+5vr0c2VzRDNh8CYS94hufCecmh5vFX73sTo4Cd4M7r3TD3rauYwOMGJ/yLVLpZSnOMYz4wR0hY6AKdhTU22Tn8pBQiXLtozumNLNSxg/muJD4HX7yPxHA8fmpMdETZ3llLU3ocr1QHF4iZCZ/0bvGvI2U5EHZ3QRzeurPhDKEKO7OVsyVQS6eC1+WctBdmjRd6Vbp1pCAXkRe3toBMivJa7u30as/dL5mJvk0p4zL28SqMlPn0wRlL1BO1uo02HWhu/8s477aOCUthoMxD5+gP1efTv7r8Q+7KCFLxEyRKIae4ekzzZng21FsoiNZ+4rW9JcbC+/rfdjznf0so1sU5Go65aqJl/fljOli6ma37+A==;5:W3TFRxmFbVepo9qzg9GuozKHsUSC2+/a3rieNtiVRFgjg3vHg5YNE3da21Z+sX2ZKZur7WgJ1aI2inE6kiUg00HUKFSFcXMtnfdBSRUtCgU1CEnLPwS3HEZMFaAi9RNEc0xyu9+/nKPCEVqyfbANRg0PzC5dx83Fl0of/QUvfnY=;7:SdzhdFt/c/UcURJfscIbO+5uaaqov2v7UMvEjeiTv+KQ5uJpRelYaJr0oMheiqgHW7nX44eFfoAe2gaTRXmwEhHTD+yisvX0/km7H1oObkKSZe7Fl/ic3c33H/ISJOLKbOUN0WWbOy4o0EZZtmwPVsWZy2h0yoovzpkL9Lu3DW7qPwdAWAxKp1Xo6Sn7grfnqwkAd4tAFPK/tYdfWLeOx3gONvhkF29mAekeZQZV+1Q0Htr7cb9dCaas23JyoaTc
x-ms-office365-filtering-correlation-id: 9eaf7941-ac9c-443e-f79c-08d61a7e9c24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB10836D07E4154BCA7271BDB9F4190@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(54906003)(478600001)(36756003)(2351001)(81166006)(81156014)(386003)(1730700003)(6506007)(8676002)(4326008)(316002)(8936002)(97736004)(22452003)(102836004)(1076002)(6116002)(3846002)(106356001)(1361003)(72206003)(25786009)(50226002)(105586002)(305945005)(14454004)(7736002)(1411001)(99286004)(86612001)(2906002)(76176011)(52116002)(10290500003)(5660300001)(6916009)(39060400002)(5250100002)(6512007)(486006)(186003)(6436002)(11346002)(476003)(2616005)(6486002)(446003)(26005)(5640700003)(2900100001)(10090500001)(2501003)(66066001)(53936002)(68736007)(14444005)(256004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y0C7Uy8snmayzjYPVp9IzxqoqjVHlODwYeZq4E7Lo7yCUrtojh5cEzaEG2MGlDRWN+xRuVyWcNn2ByEbXz5uqlJXSKqLPAApx2eZ9aUliWSnv4Sv7L8LnW0Ii8/XRXb0dkPZQYtZSNHmvSp1EwJXYX8iW4WY9NdCiSti30CYtRiGjWXplIA/NkyaeEfGvfq0kk/f7eeI6+q5GkamC4aRdCXFxSV1UdqpkpQCQiRKXczW24GyIUyVd+sCI/ZyJuCt2WOxnGpCeg50SR2hsc1MDexykIbacnyMLMR9672/ZgFQx2sV3pi7EzsQZxRhhg7YZgZbS9NGaY5VFiYlaTxgSIoErJbd7cLLdRThtw0PeXU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaf7941-ac9c-443e-f79c-08d61a7e9c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:14:01.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach GIT_FORCE_PRELOAD_TEST to take a boolean to turn on or off this test
feature instead of simply testing for existance.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 preload-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/preload-index.c b/preload-index.c
index 71cd2437a3..0a4e2933bb 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -5,6 +5,7 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "fsmonitor.h"
+#include "config.h"
=20
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index,
@@ -84,7 +85,7 @@ static void preload_index(struct index_state *index,
 		return;
=20
 	threads =3D index->cache_nr / THREAD_COST;
-	if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_T=
EST"))
+	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_FORCE_PRE=
LOAD_TEST", 0))
 		threads =3D 2;
 	if (threads < 2)
 		return;
--=20
2.18.0.windows.1

