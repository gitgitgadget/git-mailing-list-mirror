Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9A91F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeDFTJk (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:09:40 -0400
Received: from mail-sn1nam02on0112.outbound.protection.outlook.com ([104.47.36.112]:57709
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751913AbeDFTJi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CpfD+nu1VcNZblRR39BhnabpHCrlNxnc7OlEf/8H7Fg=;
 b=ITZdlkr4jDjssGnOClMl7rO6c4ciQYxxqYex9y3GkpTo3YoXOFkak31Tdw0PqrLCJykmoRHhZsff2YYhLkZdvWT9X43BExA24bSozXUV+Q2kVvOIzcuntkTjJwt6cOBz5dDNy+LS+9ngfX4on/Lq7I3AcFm42JEn+4cbxpXT7Z0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1108.namprd21.prod.outlook.com (52.132.24.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Fri, 6 Apr 2018 19:09:35 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.000; Fri, 6 Apr 2018
 19:09:35 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 2/4] commit: create get_commit_tree() method
Thread-Topic: [PATCH v2 2/4] commit: create get_commit_tree() method
Thread-Index: AQHTzdrM1pWZg1F/Dkqml/zeTkfaWA==
Date:   Fri, 6 Apr 2018 19:09:34 +0000
Message-ID: <20180406190919.167092-3-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com>
In-Reply-To: <20180406190919.167092-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:400:4::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1108;7:q/2TplYcu/P7W4/lDtj5r8so3pzmnIt1q2OlpvYNpIdplo1L6v6nZGT1WE6I+6sX3ILMFPIopou/fqMHBXYKvzDxeqcQexo2x1WrnYptUpISGELIIPZVKQodp22MqO+cqLfqDgg3iBWbPrzUAJiJUlxiuZ7ZZmbOCZCMm1O1vYu1EOu2dIZyLmnv6oV611Sr1QTwN9IEprAb4PZGtiQlortHEbc94xGvQSnirpcRNXzzhpgPm81U9fLxdSXBjhvD;20:PgrDxysElADDLU9F8SVsEFTjWO0WPtPd+/VmY15QWOJtLfTyPpctth4uqMcw7aw3oBeTtuEITDfXf2K8HT2tihwGCtswhjxgpEFOgcanWl9ukdTpOdkl0xzWBoGuElHeHn7cVswD+aY73Mgjq2E5fpizQKdcIxDa8r5uFpOlZJ0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df8248bd-f74a-4df9-1203-08d59bf1ee9c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1108;
x-ms-traffictypediagnostic: BL0PR2101MB1108:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB11084AA736A7D691EA435D20A1BA0@BL0PR2101MB1108.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1108;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1108;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(366004)(39860400002)(189003)(199004)(22452003)(105586002)(316002)(2906002)(2501003)(5250100002)(76176011)(25786009)(54906003)(3280700002)(106356001)(3660700001)(14454004)(102836004)(486006)(46003)(478600001)(52116002)(99286004)(4326008)(5660300001)(6506007)(386003)(2616005)(446003)(11346002)(10290500003)(476003)(86362001)(186003)(6486002)(2900100001)(97736004)(107886003)(39060400002)(5640700003)(6436002)(36756003)(8656006)(10090500001)(305945005)(7736002)(8676002)(6116002)(6916009)(53936002)(8936002)(1076002)(81166006)(1730700003)(86612001)(81156014)(6512007)(2351001)(68736007)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1108;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i0nUdp1Y9MnVQsMj4aJn6DFMT5+iFh+txnstMQKlep759QMPW/aCjD8uLJ1Vvq+33Y4m1XYszY8aytcrERm2jENHom1vMHIEdMRiP+DEIuUSUSRGLP89D2ti7/Vsk66aN94V7o9rhUjI5mk3jPoSi4Gv/RAw7scUdTsttOeP7RV8GlZ5hdS7y5cF1GWtoA4Ii1lF7IYHrvMczibiE4xbCS5aQH52s5MrdBp3W5ywVrwb8Ad6XIdAjv5LEecbhz2OuY+1yDEf58HhcDXhq1o/LovmED4O0q2aId9wYJXYuSF98x3gh3wnpxvCztJvBzk4TNWITqwgu8dAw7AWvrmmItRCoC1vyAwOkdyJCO/dIHRphUSzBVqwz571x8hOjnw/CUj7K4/Ipbofg13kvxrM7tpFU0L0UXVRNF1Qn35FzVk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8248bd-f74a-4df9-1203-08d59bf1ee9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 19:09:35.1854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While walking the commit graph, we load struct commit objects into
the object cache. During this process, we also load struct tree
objects for the root tree of each of these commits. We load these
objects even if we are only computing commit reachability information,
such as a merge base or ahead/behind information.

Create get_commit_tree() as a first step to removing direct
references to the 'maybe_tree' member of struct commit.

Create get_commit_tree_oid() as a shortcut for several references
to "&commit->maybe_tree->object.oid" in the codebase.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 10 ++++++++++
 commit.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/commit.c b/commit.c
index fbc092808c..aea2ca1f8b 100644
--- a/commit.c
+++ b/commit.c
@@ -296,6 +296,16 @@ void free_commit_buffer(struct commit *commit)
 	}
 }
=20
+struct tree *get_commit_tree(const struct commit *commit)
+{
+	return commit->maybe_tree;
+}
+
+struct object_id *get_commit_tree_oid(const struct commit *commit)
+{
+	return &get_commit_tree(commit)->object.oid;
+}
+
 const void *detach_commit_buffer(struct commit *commit, unsigned long *siz=
ep)
 {
 	struct commit_buffer *v =3D buffer_slab_peek(&buffer_slab, commit);
diff --git a/commit.h b/commit.h
index c4d6e6e064..dc4bf97d9f 100644
--- a/commit.h
+++ b/commit.h
@@ -102,6 +102,9 @@ void unuse_commit_buffer(const struct commit *, const v=
oid *buffer);
  */
 void free_commit_buffer(struct commit *);
=20
+struct tree *get_commit_tree(const struct commit *);
+struct object_id *get_commit_tree_oid(const struct commit *);
+
 /*
  * Disassociate any cached object buffer from the commit, but do not free =
it.
  * The buffer (or NULL, if none) is returned.
--=20
2.17.0

