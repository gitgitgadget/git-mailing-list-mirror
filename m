Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002FD20248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfCUWdi (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:33:38 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:2850
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbfCUWdi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHqrEVUDqwRM9G4TICO4+0L6bjzLhdTt6paW6CviqPM=;
 b=v7iOvstSldqngfb1imCRmk3Z20MFxId2ydJ2BL7Pl3AyqXgSSaUjztMh/qitoHobJFTWbkdGBDUVchodCW4goAdmJ298NKBAf5KpyoWLxZDXDvKpPaerzSG8v5/qpSb8bfyZFBsGj5J8JgwciKVySKB/MvvsRXEI51CP0TDlaBM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4251.namprd08.prod.outlook.com (20.176.82.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 22:33:10 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 22:33:10 +0000
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
Subject: [PATCH v2 5/7] git-p4: don't exclude other files with same prefix
Thread-Topic: [PATCH v2 5/7] git-p4: don't exclude other files with same
 prefix
Thread-Index: AQHU4DYL82yhg3sxak2s9yXpzDSfVQ==
Date:   Thu, 21 Mar 2019 22:33:02 +0000
Message-ID: <3330f88a0d1ccd8aa1a376ee8c543690ac983958.1553207234.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: 71849c06-7e67-4cf8-a90a-08d6ae4d2ddb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4251;
x-ms-traffictypediagnostic: DM6PR08MB4251:
x-microsoft-antispam-prvs: <DM6PR08MB42510DA7219A94F7C1D0A19EDA420@DM6PR08MB4251.namprd08.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(14444005)(6666004)(6436002)(5640700003)(53936002)(36756003)(76176011)(386003)(486006)(446003)(6506007)(8676002)(68736007)(2501003)(97736004)(305945005)(256004)(25786009)(186003)(478600001)(476003)(86362001)(6512007)(71200400001)(4326008)(7416002)(6916009)(2616005)(11346002)(6486002)(102836004)(118296001)(3846002)(6116002)(26005)(7736002)(66066001)(50226002)(316002)(99286004)(14454004)(54906003)(2906002)(106356001)(81156014)(5660300002)(52116002)(71190400001)(1730700003)(81166006)(2351001)(8936002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4251;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s3Fo1w6EUZmjVpV6ftW8S4G9T5oDFOyI64XQdhubc7eKSaWAgWjem0U35X9Rn7F0Aa5efu+OhaawVw6w3amSGtNeSfgV0M/BclE079OhDiKf5TIGvjMurSRiE0oY1gSi211R05GOh0rG71F+kn3TZDWUSA5d6kNC7mqfg8GDricLmDCYUgIaaPZ9dryq8u6msWcrueo5wxELTpxgrOoZYS/IGnEXyhePO6B5hnQCPuugW6fpJyoYgpeyQI5Ygfj/jDPQyqgio6SFJCeUYM9YhNnjtHvAC/1WIFsgMUv8HJzV9jdC9of04gy2GAkPglxxuwPOTCVQgVh4QLh8em1UaAIEZQdMzTGzXITpXaE/XXKNC42nk8C7ErH7cX5+CmzLn3rgzhntcBNT4fhFo1UCrMxFKo7G5GXusX2gf2QaoUg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71849c06-7e67-4cf8-a90a-08d6ae4d2ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 22:33:02.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4251
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure not to exclude files unintentionally
if exclude paths are specified without a trailing /.
I.e., don't exclude "//depot/file_dont_exclude" if run with "-//depot/file"=
.

Do this by ensuring that paths without a trailing "/" are only matched comp=
letely.

Also, abort path search on the first match as a micro-optimization.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py                 | 21 ++++++++++++++-------
 t/t9817-git-p4-exclude.sh |  4 ++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a9f53e5b88..162877aa82 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2621,22 +2621,29 @@ def checkpoint(self):
         self.gitStream.write("progress checkpoint\n\n")
         out =3D self.gitOutput.readline()
         if self.verbose:
             print("checkpoint finished: " + out)
=20
+    def isPathWanted(self, path):
+        for p in self.cloneExclude:
+            if p.endswith("/"):
+                if p4PathStartsWith(path, p):
+                    return False
+            # "-//depot/file1" without a trailing "/" should only exclude =
"file1", but not "file111" or "file1_dir/file2"
+            elif path.lower() =3D=3D p.lower():
+                return False
+        for p in self.depotPaths:
+            if p4PathStartsWith(path, p):
+                return True
+        return False
+
     def extractFilesFromCommit(self, commit, shelved=3DFalse, shelved_cl =
=3D 0):
         files =3D []
         fnum =3D 0
         while "depotFile%s" % fnum in commit:
             path =3D  commit["depotFile%s" % fnum]
-
-            if [p for p in self.cloneExclude
-                if p4PathStartsWith(path, p)]:
-                found =3D False
-            else:
-                found =3D [p for p in self.depotPaths
-                         if p4PathStartsWith(path, p)]
+            found =3D self.isPathWanted(path)
             if not found:
                 fnum =3D fnum + 1
                 continue
=20
             file =3D {}
diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index 1c22570797..275dd30425 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -51,11 +51,11 @@ test_expect_success 'clone, excluding part of repo' '
 		test_path_is_file discard_file &&
 		test_path_is_file discard_file_not
 	)
 '
=20
-test_expect_failure 'clone, excluding single file, no trailing /' '
+test_expect_success 'clone, excluding single file, no trailing /' '
 	test_when_finished cleanup_git &&
 	git p4 clone -//depot/discard_file --dest=3D"$git" //depot/...@all &&
 	(
 		cd "$git" &&
 		test_path_is_file wanted/foo &&
@@ -83,11 +83,11 @@ test_expect_success 'clone, then sync with exclude' '
 		test_path_is_file discard_file &&
 		test_path_is_file discard_file_not
 	)
 '
=20
-test_expect_failure 'clone, then sync with exclude, no trailing /' '
+test_expect_success 'clone, then sync with exclude, no trailing /' '
 	test_when_finished cleanup_git &&
 	git p4 clone -//depot/discard/... -//depot/discard_file --dest=3D"$git" /=
/depot/...@all &&
 	(
 		cd "$cli" &&
 		p4 edit wanted/foo discard/foo discard_file_not &&
--=20
2.19.2

