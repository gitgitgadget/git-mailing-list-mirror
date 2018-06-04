Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CC61F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeFDQwX (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:23 -0400
Received: from mail-dm3nam03on0132.outbound.protection.outlook.com ([104.47.41.132]:60096
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751042AbeFDQwU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l31UXrj4xFGR4TGyTJW/z6OYDsxgQ3enrpTKAKkfB5U=;
 b=kfltcdcdNFkh+F2RKLn7dhqfaimESK4J5m6kIWRS7wKKYZTAFitAHIZW/uKaWra9sFxPjr6zxL85Vh3Ls6Um9QdG6wT4D0BNZ5rbM9yZt8pHhkSd2iuoNk1f4BgJR5P4BkOLZ0H4XzjF73FqqlX/yoqDeHM1/dspEu0TYpz6rgc=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1081.namprd21.prod.outlook.com (52.132.149.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.11; Mon, 4 Jun 2018 16:52:17 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:17 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 02/21] commit-graph: fix GRAPH_MIN_SIZE
Thread-Topic: [PATCH v4 02/21] commit-graph: fix GRAPH_MIN_SIZE
Thread-Index: AQHT/CRkl4V9NaMZvkW1UhkiD17q3Q==
Date:   Mon, 4 Jun 2018 16:52:17 +0000
Message-ID: <20180604165200.29261-3-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1081;7:cy5fycJ79yCWw9sBBsORZLWafrDzTYRFsbbcvdnlH97URV3OyFEgV53/oaTDn7zhcjphaqICJkzJyF5Gr7XVVUKn+EqMB+d9To6vNVxP0FXL9CCsMGifxtkx8LjsWZSUjUs0hfkoFo2Ak/nApfG883P2zQ8vYRZ56J+QZRWunsmroC/P83+w4xS4J//6fIy7wPcR9aXIegCQUzAAiYgz+Ur5hLVikVkYzjOtXIyS423s1MgdR6eklwhuwHNr94yP;20:yHn1xEuzgJD7W0GWnbfhGhDKE7x07o0BDDDQDT0Qgol5RusNFAB4iZ0JTu/k2mrU6DUWcvknTBv/E9Hqse2jgxv4NuJmQd1EsNQe08c6Rh7cOsFGR1VGQKtZJ59hKnnE3gXp2qx1xN5at79BkQfN+WtgfxULxUYIs8OVmBpH/kU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1081;
x-ms-traffictypediagnostic: MW2PR2101MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1081F61416D94DAEC73C685EA1670@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1081;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1081;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(199004)(189003)(81156014)(486006)(8656006)(102836004)(6512007)(316002)(3280700002)(14454004)(1076002)(54906003)(186003)(107886003)(6116002)(478600001)(3660700001)(39060400002)(2616005)(386003)(2900100001)(99286004)(476003)(6506007)(10290500003)(86612001)(68736007)(11346002)(446003)(52116002)(76176011)(86362001)(2906002)(53936002)(22452003)(36756003)(25786009)(6916009)(5660300001)(5640700003)(2501003)(97736004)(2351001)(4326008)(46003)(105586002)(6436002)(106356001)(10090500001)(6486002)(81166006)(8676002)(305945005)(5250100002)(8936002)(7736002)(1730700003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f0jkddjyZ3O1Nr45LJlqrYsyTDDWTKUMdNdKRHQTVn9kx7vTTvkVQE8qyrx1grUwmZVHOMoQ7UUtluYeyvF/meUOPsgJayKem6L/YW9+2JLW7B2XxvYss48fyWAp9ky1SbFvi6iWJ/omQKFAVC2984lXATpEnFMXoRHhDi1IdcpR/Csl/aj/2+rQkx8V5V8P
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aab1a066-9ae7-441b-a7ed-08d5ca3b874f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab1a066-9ae7-441b-a7ed-08d5ca3b874f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:17.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GRAPH_MIN_SIZE macro should be the smallest size of a parsable
commit-graph file. However, the minimum number of chunks was wrong.
It is possible to write a commit-graph file with zero commits, and
that violates this macro's value.

Rewrite the macro, and use extra macros to better explain the magic
constants.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index bb54c1214c..c09e87c3c2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -34,10 +34,11 @@
=20
 #define GRAPH_LAST_EDGE 0x80000000
=20
+#define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
 #define GRAPH_CHUNKLOOKUP_WIDTH 12
-#define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + =
\
-			GRAPH_OID_LEN + 8)
+#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
+			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
=20
 char *get_commit_graph_filename(const char *obj_dir)
 {
--=20
2.18.0.rc1

