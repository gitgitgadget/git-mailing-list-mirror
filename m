Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1561F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030968AbeEXQZn (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:25:43 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28256
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030897AbeEXQZh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c0vXr7TFUV1hb7eyzS4wXdiljrdB6/F3CTW1R8ouZk=;
 b=M5SplgiWEUCXB5mxq7hccVt/xAnZW9UIR6kTmepgQZVg5zr9L70tzfAeY1LOQQUwsUx+ijy2TspQuGE+DqjVq+qgXGgL3y8gS9l3U7b4TgSd5Gv8yWnQe1ZeXbCM+pE7l6ayL7nWM5n878QufDOdOwn1nqqper55PcC14vDYs28=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0882.namprd21.prod.outlook.com (52.132.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:33 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:33 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 04/20] commit: force commit to parse from object database
Thread-Topic: [PATCH v3 04/20] commit: force commit to parse from object
 database
Thread-Index: AQHT83vWYgg3r0MiwU2naqa3inUanQ==
Date:   Thu, 24 May 2018 16:25:33 +0000
Message-ID: <20180524162504.158394-5-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0882;7:6TUuYkbU6OuKuH/SVY6iP7lKaignrgCNu6hVYWj+PodEWfo8XSi8ZBpndhfrJI1j+dFn4Vcbk1kfeT2ey106seAFd60uF/i+z8YWDevuhnbcSPI91V+tJhYby1HIc1mkcq+1U0oRONlgR/bnwLoAQdgPLQ7VK5X8iUEbGz6velPAh8OdoZWP4rhHQvJR4eKXeZCzUZlj0SJCVe53rUMU2bj8tD+LaTCveytBM1bzJyJ02Qx5nifRjexqjLysuAmz;20:tSDXMeoI25u21A75BX3NUv/oyj6wzy4w6scO9UCC1+wnxtzXx8GThuszVGxPlZv/c7CzdSWSCNAZlX3CiaBiq2mnf1A1dJT7N0ayVqAMVAG1HHhgXiK3QPQqg3+3GD8ZtBvchM90NNfIYeuynFysEfuJSyWs3/7z+c1nj37WfRI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0882;
x-ms-traffictypediagnostic: BL0PR2101MB0882:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0882FCF1D829066CBE0190D7A16A0@BL0PR2101MB0882.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0882;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0882;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(36756003)(6116002)(107886003)(1076002)(6486002)(5250100002)(2501003)(6916009)(5660300001)(97736004)(316002)(99286004)(10090500001)(8656006)(6512007)(53936002)(54906003)(39060400002)(22452003)(4326008)(8676002)(2906002)(102836004)(2900100001)(1730700003)(81166006)(81156014)(2351001)(386003)(6506007)(3280700002)(476003)(2616005)(5640700003)(486006)(52116002)(14454004)(46003)(6436002)(25786009)(11346002)(86362001)(86612001)(446003)(305945005)(186003)(10290500003)(105586002)(7736002)(3660700001)(68736007)(76176011)(8936002)(106356001)(478600001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0882;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kwfOnG03FR2wa1YmxlPbUTeqzB5ERhDe1Jd8SO3G+lXTTS2+TSq6rc8ggqPMHEcZnCwEFZaRaLm21g05wDX+ijme923sqT40KsBhqdApVmMoICJX7+spw9kgw+n4W8k6aMbVtdWdW+2eS2xmqy5CXdS7JozN+mPAwE5Vnc+nSnor/B+FhbLMZJ23j6lwrvav
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a2d26623-3951-40f5-f2bb-08d5c192f8e5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d26623-3951-40f5-f2bb-08d5c192f8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:33.7025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0882
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of verifying commit-graph file contents against the
object database, create parse_commit_internal() to allow side-stepping
the commit-graph file and parse directly from the object database.

Due to the use of generation numbers, this method should not be called
unless the intention is explicit in avoiding commits from the
commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 9 +++++++--
 commit.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 1d28677dfb..6eaed0174c 100644
--- a/commit.c
+++ b/commit.c
@@ -392,7 +392,7 @@ int parse_commit_buffer(struct commit *item, const void=
 *buffer, unsigned long s
 	return 0;
 }
=20
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int u=
se_commit_graph)
 {
 	enum object_type type;
 	void *buffer;
@@ -403,7 +403,7 @@ int parse_commit_gently(struct commit *item, int quiet_=
on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (parse_commit_in_graph(item))
+	if (use_commit_graph && parse_commit_in_graph(item))
 		return 0;
 	buffer =3D read_sha1_file(item->object.oid.hash, &type, &size);
 	if (!buffer)
@@ -424,6 +424,11 @@ int parse_commit_gently(struct commit *item, int quiet=
_on_missing)
 	return ret;
 }
=20
+int parse_commit_gently(struct commit *item, int quiet_on_missing)
+{
+	return parse_commit_internal(item, quiet_on_missing, 1);
+}
+
 void parse_commit_or_die(struct commit *item)
 {
 	if (parse_commit(item))
diff --git a/commit.h b/commit.h
index b5afde1ae9..5fde74fcd7 100644
--- a/commit.h
+++ b/commit.h
@@ -73,6 +73,7 @@ struct commit *lookup_commit_reference_by_name(const char=
 *name);
 struct commit *lookup_commit_or_die(const struct object_id *oid, const cha=
r *ref_name);
=20
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned =
long size, int check_graph);
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int u=
se_commit_graph);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
--=20
2.16.2.329.gfb62395de6

