Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5AA1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756336AbeDKUBa (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:01:30 -0400
Received: from mail-sn1nam02on0137.outbound.protection.outlook.com ([104.47.36.137]:55490
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755722AbeDKUB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=j51eHsfJm4GzQp0ExF8BgElq/5bK60KKmGWOzvcQB+E=;
 b=ayCtPqp77WORRMUvkVM4HKmsgkULHAWRXYn/VoqZBoete44spXzSIX3sEKA1tnF8ACEIIiiQ+lEhfc/SzVuS82xyoWAcRjXlaWAgo4iaKX/SZunBvxbFKX3S1AbKRkyesaLlotrQRyO/aHYlKjJbC8kHrDmqx9Idg1qP0qBywjM=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0984.namprd21.prod.outlook.com (52.132.133.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Wed, 11 Apr 2018 20:01:24 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0696.006; Wed, 11 Apr 2018
 20:01:24 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2 0/2] fsexcludes: Add programmatic way to exclude files
Thread-Topic: [PATCH v2 0/2] fsexcludes: Add programmatic way to exclude files
Thread-Index: AQHT0c/eLgp+QA5U+k2MFqK1wozJ4w==
Date:   Wed, 11 Apr 2018 20:01:24 +0000
Message-ID: <20180411200007.8612-1-benpeart@microsoft.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
In-Reply-To: <20180410210408.13788-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0062.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::22) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:LbqNEVQBWAlzQecZ5VYSX3ylE7+mxiK/KnnmQsrZAfMMsfeeTQvgsfviaH4ImJHrBWMzM/P4N5gLCSatwQ5oDKrwQOxkRpgta62u8EG4ez7GaqijexIUEaYgOUxjVN2JijO2KDXJgA3aEClW2KZcbiZcNyJ3BvlIO5mWU13thiHq/e5MR69kvOOVMje/W/wzEcS2GKUudZx183BGQMXUkjEJD5RU5Ve2IjMnNAdxbLzwhksehyBc9LEGeW0UjqmE;20:B78YQlW5RK6trvqzmpJdwVnmvl5+ar6eC87iVA+35sbQJuoWNUy+mFZFFtk9IZKVd1aENvLVUR1Or9BcV8ywReGrL381d1PQm4y1Rq4xIX2hqLNe59lNq2PA9+OeL4hn2H3nA+9eatNITY3W2+wJuFd60DVzcdYqlCIiHNioZ8s=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0984FEE109BDCA3F251F0D97F4BD0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006)(166708455590820)(15185016700835);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501337)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6916009)(5250100002)(8666007)(105586002)(5640700003)(2900100001)(25786009)(39060400002)(1076002)(6116002)(3846002)(36756003)(6486002)(6436002)(4326008)(97736004)(7736002)(305945005)(5660300001)(10090500001)(2351001)(81166006)(81156014)(8676002)(8936002)(50226002)(106356001)(66066001)(478600001)(59450400001)(72206003)(52116002)(76176011)(10290500003)(575784001)(3280700002)(107886003)(1730700003)(186003)(3660700001)(386003)(53936002)(14454004)(54906003)(2906002)(99286004)(26005)(6506007)(8656006)(102836004)(966005)(2616005)(476003)(486006)(446003)(11346002)(86612001)(68736007)(22452003)(316002)(6512007)(6306002)(22906009)(43043002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Uiy0Bj37o7SqQjPVkmbCv1GrAwUja/Sf+k0xggIJilni4CDeCC2S+ehau6F4Kni5y4jCCRmuGwA2w4OTpoIjO9TUWAqYPyCDeeKGhNBdDm6CPzVll1BdhQL45eOWKRiPzozo6sDlWKnx4O58O7FE1bNYzYjnGhcB6YKdqGvAGj6DQSVf7/Q22p+McolXrls9bFq3+6A/AKJX7mqm7IHwxA3ZpK0JOxgNg2X+wWaVz4zw2TIDyRH2p1ofT14r9dIlafUqc/uKuvVdOZJ4qI9HUqMoSdaCBdUBn5xdFeKzVI8YggAAvtrxzb1iC+/Yv/Xna8tWm/+BK7CVdtWhIG7oO4EiFjcSpnJCHwuJqsu9VOcXY/lj+zZWYa9Eiwxwj4qEirKZPJ0AnZepNVD70yrN2NvbjDfTbHRviKBWyXPS3yg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ea05e111-a7cd-4fab-8911-08d59fe70085
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea05e111-a7cd-4fab-8911-08d59fe70085
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 20:01:24.7233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated to incorporate feedback from V1.

I'd really like a close review of the changes in dir.c where I added the ca=
lls
to fsexcludes_is_excluded_from().  While they work and pass all the git tes=
ts
as well as our internal functional tests, I'd like to be sure I haven't mis=
sed
anything.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/08442c209d
Checkout: git fetch https://github.com/benpeart/git fsexcludes-v2 && git ch=
eckout 08442c209d


### Interdiff (v1..v2):

diff --git a/fsexcludes.c b/fsexcludes.c
index 07bfe376a0..0ef57f107b 100644
--- a/fsexcludes.c
+++ b/fsexcludes.c
@@ -33,7 +33,6 @@ static int check_fsexcludes_hashmap(struct hashmap *map, =
const char *pattern, in
 	char *slash;
=20
 	/* Check straight mapping */
-	strbuf_reset(&sb);
 	strbuf_add(&sb, pattern, patternlen);
 	fse.pattern =3D sb.buf;
 	fse.patternlen =3D sb.len;
@@ -155,7 +154,6 @@ static int check_directory_hashmap(struct hashmap *map,=
 const char *pathname, in
 	struct fsexcludes fse;
=20
 	/* Check for directory */
-	strbuf_reset(&sb);
 	strbuf_add(&sb, pathname, pathlen);
 	strbuf_addch(&sb, '/');
 	fse.pattern =3D sb.buf;
@@ -198,13 +196,16 @@ int fsexcludes_is_excluded_from(struct index_state *i=
state,
 	return -1;
 }
=20
-void fsexcludes_init(struct strbuf *sb) {
+void fsexcludes_init(struct strbuf *sb)
+{
 	fsexcludes_initialized =3D 1;
 	fsexcludes_data =3D *sb;
+	strbuf_detach(sb, NULL);
 }
=20
-void fsexcludes_free() {
+void fsexcludes_free(void) {
 	strbuf_release(&fsexcludes_data);
 	hashmap_free(&fsexcludes_hashmap, 1);
 	hashmap_free(&parent_directory_hashmap, 1);
+	fsexcludes_initialized =3D 0;
 }
diff --git a/fsexcludes.h b/fsexcludes.h
index 1c4101343c..10246daa02 100644
--- a/fsexcludes.h
+++ b/fsexcludes.h
@@ -6,16 +6,18 @@
  * where git will scan for untracked files.  This is used to speed up the
  * scan by avoiding scanning parts of the work directory that do not have
  * any new files.
- *
  */
=20
 /*
  * sb should contain a NUL separated list of path names of the files
  * and/or directories that should be checked.  Any path not listed will
  * be excluded from the scan.
+ *
+ * NOTE: fsexcludes_init() will take ownership of the storage passed in
+ * sb and will reset sb to `STRBUF_INIT`
  */
 void fsexcludes_init(struct strbuf *sb);
-void fsexcludes_free();
+void fsexcludes_free(void);
=20
 /*
  * Return 1 for exclude, 0 for include and -1 for undecided.


### Patches

Ben Peart (2):
  fsexcludes: add a programmatic way to exclude files from git's working
    directory traversal logic
  fsmonitor: switch to use new fsexcludes logic and remove unused
    untracked cache based logic

 Makefile                    |   1 +
 dir.c                       |  33 ++++--
 dir.h                       |   2 -
 fsexcludes.c                | 211 ++++++++++++++++++++++++++++++++++++
 fsexcludes.h                |  29 +++++
 fsmonitor.c                 |  21 +---
 fsmonitor.h                 |  10 +-
 t/t7519-status-fsmonitor.sh |  14 +--
 8 files changed, 273 insertions(+), 48 deletions(-)
 create mode 100644 fsexcludes.c
 create mode 100644 fsexcludes.h


base-commit: 0b0cc9f86731f894cff8dd25299a9b38c254569e
--=20
2.17.0.windows.1


