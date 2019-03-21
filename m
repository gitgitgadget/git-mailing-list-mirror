Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2834920248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfCUWdd (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:33:33 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:2850
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfCUWdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlH2x1R8E9eZa6pzO88bQsHk1eo441ZLR7kYd5RqXTc=;
 b=cQZ5nOdOHFE06Xg+KBwOpOy4I6Iyb40bA2GX9XYnSqfurccpKchUMN9C1EP3+1l9Uh9uHV68rCdEeZ4LS2TN4S7iywtZd3jjgIKInXAlHDfiMV120jVJtSdGf+5eDLGKBO3tP/uW42nS//LPZCwMZ15UUAGlVuo4Y4jmqbW8CIQ=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4251.namprd08.prod.outlook.com (20.176.82.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 22:32:57 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 22:32:57 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "ahippo@yandex.com" <ahippo@yandex.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH v2 3/7] git-p4: don't groom exclude path list on every commit
Thread-Topic: [PATCH v2 3/7] git-p4: don't groom exclude path list on every
 commit
Thread-Index: AQHU4DYI1vGn3yFeRk27bGYJZI+79A==
Date:   Thu, 21 Mar 2019 22:32:57 +0000
Message-ID: <44fed954dc4ee7d98ce518c0665cc71a0751dd3b.1553207234.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
In-Reply-To: <cover.1553207234.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:400::33)
 To DM6PR08MB4956.namprd08.prod.outlook.com (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72c1c5da-f34d-4dd0-4cfe-08d6ae4d2ab1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4251;
x-ms-traffictypediagnostic: DM6PR08MB4251:
x-microsoft-antispam-prvs: <DM6PR08MB42517B364148AD9BD6DBA0CEDA420@DM6PR08MB4251.namprd08.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(14444005)(6436002)(5640700003)(53936002)(36756003)(76176011)(386003)(486006)(446003)(6506007)(8676002)(68736007)(2501003)(97736004)(305945005)(256004)(25786009)(186003)(478600001)(476003)(86362001)(6512007)(71200400001)(4326008)(7416002)(6916009)(2616005)(11346002)(6486002)(102836004)(118296001)(3846002)(6116002)(26005)(7736002)(66066001)(50226002)(316002)(99286004)(14454004)(54906003)(2906002)(106356001)(81156014)(5660300002)(52116002)(71190400001)(1730700003)(81166006)(2351001)(8936002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4251;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZjeSYiCMk52cOxiSdvUt4e9IHbGxq+j5ZOYhXWxedZL0CRkC0Ib6vLwOAEa20XaWZjZSC0lQSSLuwLH6Q8G7+fevcRPLz2Aho3HoB0Vs4n3Hyv2PIyAQfPKG/nF71DZENoZoG4407ViRs/XxFw/h7WJOHg2qrB5xyyv7P5gdbDjJ4AjRDBZZ3UF3JuNIh7hXHGWUsUQRdlR+tVBSOzSfQjtNggxDaqMVarqTniui4ef1sGMda4FRUv8+6zz/GyBDxSfl4titUreySIzulsuHiJCvQKT1M+F8uXPra25h8WajXl/Ql5X/JS3S3COk8XZvRpab5HzeV+ngZ/tXVWUyLA96z+GtaK18t9TKr4/81x67uLAwFGtL/IGA6iQYhgPU/b1JTJep1FmFz7t+U0cTah6tx4wdIsZH9DxFRsdTJYU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c1c5da-f34d-4dd0-4cfe-08d6ae4d2ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 22:32:57.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4251
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `cloneExclude` array is being groomed (by removing trailing "...=
")
on every changeset.
(since `extractFilesFromCommit()` is called on every imported changeset)

As a micro-optimization, do it once while parsing arguments.
Also, prepend "/" and remove trailing "..." at the same time.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 91c610f960..a9f53e5b88 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1314,11 +1314,11 @@ class Command:
     def __init__(self):
         self.usage =3D "usage: %prog [options]"
         self.needsGit =3D True
         self.verbose =3D False
=20
-    # This is required for the "append" cloneExclude action
+    # This is required for the "append" update_shelve action
     def ensure_value(self, attr, value):
         if not hasattr(self, attr) or getattr(self, attr) is None:
             setattr(self, attr, value)
         return getattr(self, attr)
=20
@@ -2528,10 +2528,15 @@ def map_in_client(self, depot_path):
             return self.client_spec_path_cache[depot_path]
=20
         die( "Error: %s is not found in client spec path" % depot_path )
         return ""
=20
+def cloneExcludeCallback(option, opt_str, value, parser):
+    # prepend "/" because the first "/" was consumed as part of the option=
 itself.
+    # ("-//depot/A/..." becomes "/depot/A/..." after option parsing)
+    parser.values.cloneExclude +=3D ["/" + re.sub(r"\.\.\.$", "", value)]
+
 class P4Sync(Command, P4UserMap):
=20
     def __init__(self):
         Command.__init__(self)
         P4UserMap.__init__(self)
@@ -2551,11 +2556,11 @@ def __init__(self):
                 optparse.make_option("--keep-path", dest=3D"keepRepoPath",=
 action=3D'store_true',
                                      help=3D"Keep entire BRANCH/DIR/SUBDIR=
 prefix during import"),
                 optparse.make_option("--use-client-spec", dest=3D"useClien=
tSpec", action=3D'store_true',
                                      help=3D"Only sync files that are incl=
uded in the Perforce Client Spec"),
                 optparse.make_option("-/", dest=3D"cloneExclude",
-                                     action=3D"append", type=3D"string",
+                                     action=3D"callback", callback=3Dclone=
ExcludeCallback, type=3D"string",
                                      help=3D"exclude depot path"),
         ]
         self.description =3D """Imports from Perforce into a git repositor=
y.\n
     example:
     //depot/my/project/ -- to import the current head
@@ -2617,12 +2622,10 @@ def checkpoint(self):
         out =3D self.gitOutput.readline()
         if self.verbose:
             print("checkpoint finished: " + out)
=20
     def extractFilesFromCommit(self, commit, shelved=3DFalse, shelved_cl =
=3D 0):
-        self.cloneExclude =3D [re.sub(r"\.\.\.$", "", path)
-                             for path in self.cloneExclude]
         files =3D []
         fnum =3D 0
         while "depotFile%s" % fnum in commit:
             path =3D  commit["depotFile%s" % fnum]
=20
@@ -3888,11 +3891,10 @@ def run(self, args):
=20
         if not self.cloneDestination and len(depotPaths) > 1:
             self.cloneDestination =3D depotPaths[-1]
             depotPaths =3D depotPaths[:-1]
=20
-        self.cloneExclude =3D ["/"+p for p in self.cloneExclude]
         for p in depotPaths:
             if not p.startswith("//"):
                 sys.stderr.write('Depot paths must start with "//": %s\n' =
% p)
                 return False
=20
--=20
2.19.2

