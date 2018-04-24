Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85541F424
	for <e@80x24.org>; Tue, 24 Apr 2018 17:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeDXRLt (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 13:11:49 -0400
Received: from mail-sn1nam02on0114.outbound.protection.outlook.com ([104.47.36.114]:9088
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeDXRLo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 13:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XaFg8VLZgoqf4TjmeWq/4maELF1SAly1EGAITO9WbuM=;
 b=kSGUY6EbMDF6RIRYzl4ZeHRB32P5JJSEgqRHHHqP2PFSzPQJio84JZR9BcibVBmPWDiLki01M1dgltD8Sil3vM/x/WCyNYpg9Jyd5izoG8dOAAN/24pgpHFUoYEMjVUvsk6PpV7rIqSPMpWM1L4LNKM2KL+GrC++42qh4Dw8EAU=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0982.namprd21.prod.outlook.com (52.132.133.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.4; Tue, 24 Apr 2018 17:11:42 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0735.005; Tue, 24 Apr 2018
 17:11:42 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: [PATCH v2 2/2] merge: Add merge.aggressive config setting
Thread-Topic: [PATCH v2 2/2] merge: Add merge.aggressive config setting
Thread-Index: AQHT2+9QadykipooJk6vgBfdRwiNkg==
Date:   Tue, 24 Apr 2018 17:11:42 +0000
Message-ID: <20180424171124.12064-3-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180424171124.12064-1-benpeart@microsoft.com>
In-Reply-To: <20180424171124.12064-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN4PR10CA0014.namprd10.prod.outlook.com (2603:10b6:403::24)
 To DM5PR2101MB1016.namprd21.prod.outlook.com (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:pEp8atxoOlVLx2djmlkGEtQ/RO4vl6ZJiutwOlsKwoet47+NfKucdl52c/FQ8juSrQT6DlOY9Y1/uLpLztDzb2GS5bkWWTrWuJOvck1QhQXpA6i4qWtSczQ8l1lYzSw9rGvpRt01RuxFmJGy8orADOl/jwn7Z+bsQ0e2VgzEocR28XfF2VtTbq0vqahrnaIkzy9ihvm8NgHDEBXhL5ca4aNakwtj46p3TaZrL1SguvPkGrFXyS8GBTfUA4nE6jXJ;20:kFSgq/A55xRj/zeO2qLVszGxlfaLK3q1H8KnyiJjZ6MnbVZ+3KAXNnHICk9PKjmV7QioCNbjeOVVeTn+78qwCHSEmObn+SrISuUnwLB3L8hD8/O8kd8Msapgpozc2t7wojw/nNI9F0UvkgGXhUEOuz4Az+bGViO540AapknFacU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB09821FD30563996F6565D2F7F4880@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(366004)(396003)(346002)(199004)(189003)(36756003)(102836004)(3280700002)(6916009)(22452003)(5660300001)(6116002)(1076002)(26005)(3660700001)(3846002)(14454004)(76176011)(2906002)(52116002)(66066001)(105586002)(10090500001)(8656006)(305945005)(476003)(97736004)(486006)(316002)(50226002)(99286004)(54906003)(2501003)(11346002)(81156014)(1730700003)(81166006)(5250100002)(6512007)(8666007)(53936002)(25786009)(2616005)(6486002)(2351001)(186003)(68736007)(478600001)(10290500003)(5640700003)(72206003)(8936002)(7736002)(39060400002)(86612001)(4326008)(2900100001)(446003)(386003)(8676002)(6506007)(6436002)(106356001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5I7lS2VCctCH3pZkidaO77XKKzYCC1qj3OO4yhif4XLqNwcQnX6Awy5bMCEuWzw6YMqRGTlLWYypiTmETm+Fs3D5mPPPKlnzmPQkG8cidDD9NMGOqmddwtF2X4M4mqzVZFmn2c9G2o/pdGzQOiOhI1ChUvq0PMG02DgQxCTzXXZz/9DLv7IaFD9IgwR0Y9iX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 50c15ee3-502d-483f-afdd-08d5aa0672f0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c15ee3-502d-483f-afdd-08d5aa0672f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 17:11:42.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to control the aggressive flag passed to read-tree via a co=
nfig setting.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/merge-config.txt | 4 ++++
 merge-recursive.c              | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.tx=
t
index 0540c44e23..38492bcb98 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,3 +1,7 @@
+merge.aggressive::
+	Passes "aggressive" to read-tree which makes the command resolve
+	a few more cases internally. See "--aggressive" in linkgit:git-read-tree[=
1].
+
 merge.conflictStyle::
 	Specify the style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
diff --git a/merge-recursive.c b/merge-recursive.c
index cd5367e890..0ca84e4b82 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -355,6 +355,7 @@ static int git_merge_trees(struct merge_options *o,
 	o->unpack_opts.fn =3D threeway_merge;
 	o->unpack_opts.src_index =3D &the_index;
 	o->unpack_opts.dst_index =3D &the_index;
+	git_config_get_bool("merge.aggressive", (int *)&o->unpack_opts.aggressive=
);
 	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
=20
 	init_tree_desc_from_tree(t+0, common);
--=20
2.17.0.windows.1

