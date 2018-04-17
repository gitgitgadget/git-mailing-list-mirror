Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC351F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeDQRAb (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:31 -0400
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:17088
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753942AbeDQRA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZVyRM/DiOASdSw/lLqDhrBNOuHlsZAw5zhIknyThLXU=;
 b=jTUrqM8NmvLDMSZGDNRRSM+WSPM1LaGBKRXJIpKWZTKglgv6tPLpPk8i2bLUBpqVmrwUNU7mhZALj4UTLZbElQS4FysGExFjtG5hC0uJU/naJUjtygBNkZ0TNt+qpURaNQEXUV+Fh2vfVWaaKAeN5P0idaNjy05+YshxWnjsZJA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:24 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:24 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 4/9] commit-graph.txt: update design document
Thread-Topic: [PATCH v3 4/9] commit-graph.txt: update design document
Thread-Index: AQHT1m2T5xwT2CzEqkKt5cnD8qTbDw==
Date:   Tue, 17 Apr 2018 17:00:24 +0000
Message-ID: <20180417170001.138464-5-dstolee@microsoft.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
In-Reply-To: <20180417170001.138464-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:YSpQcJHjnVQ5N3YwbEO9JZ9mQdsZqr6Koep5m3bJ5KE3+KEairoxuCJ9hgz1jyLLLmmbkZYJEkKh8z0P1ehsyO8NBfA99kRhO1gQLiJ06zVKU17VM+KaNLq4/BUbyXlrz6YywKH34w0F1R0MralmS4CJmhp7LgYBAo5IN0aBF1PTZiUtwRvjEfCmsmscjpernoBuqFQcv2b7fkHDF7/V5dOkBMcn54dxHyRXISmY/MXlpAmhgk6iPFRdGmTfMzLT;20:YYsZHA1R7BlLhtvr9qWrRxcHhnuhyrz8PoLmXhq1NR2pisMYqAYv5AEDQNMI+4VzKXaYRgDP6TF0c8nN0yjYUmc99sc8uzdej9TaIiQ9dy+CeYoNjfzDpQdPOV7KO8YRRHMFyM79i4WFIjxbHVYI2JNNWhDbSyTLyeOHOZvq3Y4=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB107495DF7ABEC12B4D6DD5A3A1B70@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35073007944872);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(102836004)(10090500001)(7416002)(6916009)(2906002)(99286004)(10290500003)(386003)(186003)(6506007)(86612001)(5640700003)(14454004)(5660300001)(8676002)(97736004)(3280700002)(105586002)(4326008)(52116002)(575784001)(86362001)(486006)(8656006)(59450400001)(6116002)(2351001)(15650500001)(11346002)(476003)(106356001)(46003)(2616005)(2900100001)(316002)(36756003)(446003)(54906003)(2501003)(22452003)(478600001)(68736007)(25786009)(3660700001)(107886003)(39060400002)(6486002)(53936002)(305945005)(1730700003)(1076002)(6436002)(81156014)(8936002)(81166006)(6512007)(5250100002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n5jxd6gY6IsYWkZsP2gmw8+nB+RmdqO46i8Ts/Z8OWYH7+R+8+zu3ZV5Yo290lQzpF/dIJfAHJJAXkiDctMGRzDFBYU7LboXOcJaRvGLo8CpMbf8w1+vo+5tQj9LmxC4H4jHtR2fkj3ZgGGn+LMVdvn9ldj4KXUnFqvH4qz3XzexUBhMiqTdvI+igOSDEW7A
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1d04bca9-8102-4ec2-c5d7-08d5a484b632
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d04bca9-8102-4ec2-c5d7-08d5a484b632
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:24.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now calculate generation numbers in the commit-graph file and use
them in paint_down_to_common().

Expand the section on generation numbers to discuss how the three
special generation numbers GENERATION_NUMBER_INFINITY, _ZERO, and
_MAX interact with other generation numbers.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 30 +++++++++++++++++++-----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index 0550c6d0dc..d9f2713efa 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -77,6 +77,29 @@ in the commit graph. We can treat these commits as havin=
g "infinite"
 generation number and walk until reaching commits with known generation
 number.
=20
+We use the macro GENERATION_NUMBER_INFINITY =3D 0xFFFFFFFF to mark commits=
 not
+in the commit-graph file. If a commit-graph file was written by a version
+of Git that did not compute generation numbers, then those commits will
+have generation number represented by the macro GENERATION_NUMBER_ZERO =3D=
 0.
+
+Since the commit-graph file is closed under reachability, we can guarantee
+the following weaker condition on all commits:
+
+    If A and B are commits with generation numbers N amd M, respectively,
+    and N < M, then A cannot reach B.
+
+Note how the strict inequality differs from the inequality when we have
+fully-computed generation numbers. Using strict inequality may result in
+walking a few extra commits, but the simplicity in dealing with commits
+with generation number *_INFINITY or *_ZERO is valuable.
+
+We use the macro GENERATION_NUMBER_MAX =3D 0x3FFFFFFF to for commits whose
+generation numbers are computed to be at least this value. We limit at
+this value since it is the largest value that can be stored in the
+commit-graph file using the 30 bits available to generation numbers. This
+presents another case where a commit can have generation number equal to
+that of a parent.
+
 Design Details
 --------------
=20
@@ -98,17 +121,12 @@ Future Work
 - The 'commit-graph' subcommand does not have a "verify" mode that is
   necessary for integration with fsck.
=20
-- The file format includes room for precomputed generation numbers. These
-  are not currently computed, so all generation numbers will be marked as
-  0 (or "uncomputed"). A later patch will include this calculation.
-
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-order=
ed
   priority queue with one ordered by generation number. The following
-  operations are important candidates:
+  operation is an important candidate:
=20
-    - paint_down_to_common()
     - 'log --topo-order'
=20
 - Currently, parse_commit_gently() requires filling in the root tree
--=20
2.17.0.39.g685157f7fb

