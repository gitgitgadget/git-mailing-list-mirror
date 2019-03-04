Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6C220248
	for <e@80x24.org>; Mon,  4 Mar 2019 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCDRez (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 12:34:55 -0500
Received: from mail-eopbgr730093.outbound.protection.outlook.com ([40.107.73.93]:49038
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbfCDRey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 12:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHqrEVUDqwRM9G4TICO4+0L6bjzLhdTt6paW6CviqPM=;
 b=ZyPzmGXcD5M06E4577VFuicBLWPT/v21XfEpHYC0t/Ez3/RO1nTJMKMrWJXbGzEmubuZ1YXTZ/f3hxoThgoIDKLrokB4FnMsiAjCn4A6fuKiAUvf/aPbPhfxDW/5id2mEYbN25ahVz6BzZqg8Hs6Ln+jgSy0frGd+SLGhJI3lwM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4377.namprd08.prod.outlook.com (20.176.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 17:34:51 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 17:34:51 +0000
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
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH 5/5] git-p4: don't exclude other files with same prefix
Thread-Topic: [PATCH 5/5] git-p4: don't exclude other files with same prefix
Thread-Index: AQHU0rCSIFaJ0tMC4UW6ipPslBBeSw==
Date:   Mon, 4 Mar 2019 17:34:51 +0000
Message-ID: <3330f88a0d1ccd8aa1a376ee8c543690ac983958.1551485349.git.amazo@checkvideo.com>
References: <cover.1551485349.git.amazo@checkvideo.com>
In-Reply-To: <cover.1551485349.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:404:13e::32) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cbaf300-597c-46e6-22ee-08d6a0c7b4a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4377;
x-ms-traffictypediagnostic: DM6PR08MB4377:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR08MB4377;23:k3x2p+bPdCExsZBdsrCN9bmIenwH1fh1YvSDDoQ?=
 =?iso-8859-1?Q?aPKzzVLVk4YN373/s9GPMmv6TWI2QUWKm43fGB8DTPRUYSRfQdd27ng8UU?=
 =?iso-8859-1?Q?1VS3DZn3K0jglr4y9gQpV4p57U3EVMrIGxzzDroKQjjVAe5rYCO8pMCmpw?=
 =?iso-8859-1?Q?Op5ZBtBsbkY2KI7MLfay66jsCXqz6pCSFz+aQUgTC6PHJfhEhNzdwk0PRa?=
 =?iso-8859-1?Q?r1RPUQe1Vl/7kVbGUQgQ5i2hXqOBWWh9+eF0LZdpK+Gn5lsmLNg1Oqfb/J?=
 =?iso-8859-1?Q?sISN5IENj9HNiMQvUhXO7vJQPSOztQqw/1kOTZTyhOprriXyVYypk2p2cY?=
 =?iso-8859-1?Q?ErK7g0JqqqXuevlNP/TiXxreoXpMyGMTBbabxsIn6ScxiIcIQVZeRwkYY8?=
 =?iso-8859-1?Q?0gWMK3NtEjEzEcFZwogbobAEtTX53gRx1P100IjwFlMgrIv2QLcQuqCdcm?=
 =?iso-8859-1?Q?5KOSAoFk6jsBS8e5hKpMnNqIv1TL7EjQvwqeZGF3Opjz86cpDR1Svg/40y?=
 =?iso-8859-1?Q?7Bd6Jpdh7DGLqnZ3Gyc3TotD1efZE/Hx+0HmO9IL8mhzTYKNbo/9cwlRJC?=
 =?iso-8859-1?Q?HgLRlLWpxFJRC2qclguuSXN/LcdbZPreVy9WxFudLfk6yZ6JfX0dcEQo96?=
 =?iso-8859-1?Q?qQuqiNpOvhUmJBKtuS95AZCPMlHUveGcMciV7psByIdmZclnkNNQRUIJdY?=
 =?iso-8859-1?Q?HSdko2NjIwCkY0Yf4pn7I19WdaljWfFBCwECzFlXhWm2ZRVSDThN+6WrHU?=
 =?iso-8859-1?Q?ZwvHKtWmEACtQCPni4s/jeDpU5W0bYzyHSm2TuOVh+4oTx0RoHfupsY5Fs?=
 =?iso-8859-1?Q?i1HfUYzP2tGVX4G43WuTQ69GFE3yYklAfH6S3cUjfZUD1/XDK5dusY2gdM?=
 =?iso-8859-1?Q?eiWLO4xNBR5wPCdoHzdSl1fgXtUeI22ku1ec169gVAjBNbOntYxL0N4TwV?=
 =?iso-8859-1?Q?QT9EFhGDlFeiZAn+qC09DNHTMZgaaby5tHcFOrqx/E+thpbK2tAALGAjU/?=
 =?iso-8859-1?Q?VZmZOE0Uf4A8uxaILcby3WhbnTPiK8iZim1SBXAh/R2Q81b5BhHu7ObrS1?=
 =?iso-8859-1?Q?HmT6MGougD8WxQDZtptsfnQwCEXBTFEo6moG8EYc82Dt18501FCK+g3IiX?=
 =?iso-8859-1?Q?FLFk2yTQvoJ97gYXPP24x4gff57QHSd6pP9RHFVQQU1N3ZdFl/1cqhEgMb?=
 =?iso-8859-1?Q?INfzU3VXWX9DJ+LpaJCSZ2a8fGkAmi/e07y/0xes5zQ1Y4JWAb6FeTts4t?=
 =?iso-8859-1?Q?CnKCV525wob2StgwAhnf+Lga1grOo+w8PV5hyc9wV4qW1MfddMHoWk4Ofh?=
 =?iso-8859-1?Q?GlQc1dC575zg00YP0s9ndarBDiF2Er6GI83VS1675yPWRZBtz9Fdkq+1Sp?=
 =?iso-8859-1?Q?dEhh+rYatVOwUNark9WcnGcXKlIJW?=
x-microsoft-antispam-prvs: <DM6PR08MB43771E797754540470B80FACDA710@DM6PR08MB4377.namprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(316002)(5640700003)(86362001)(3846002)(6116002)(186003)(26005)(6512007)(4326008)(6916009)(486006)(6486002)(66066001)(53936002)(6436002)(256004)(118296001)(14444005)(6506007)(52116002)(102836004)(76176011)(99286004)(386003)(2906002)(478600001)(14454004)(2351001)(2501003)(81156014)(5660300002)(81166006)(1730700003)(8676002)(68736007)(2616005)(8936002)(97736004)(50226002)(54906003)(7416002)(105586002)(106356001)(11346002)(25786009)(36756003)(305945005)(7736002)(71190400001)(71200400001)(446003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4377;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X6uHV/+yV7gy9f1bUcMT2G2wVdPpKdtJ09DvP71ZNzqXF8ryZPGocxes/TAINZgWhvysxidKkESXzS6+T+qB3sFmKWErHh1qbBLHVSgKDmrfC1fyrxDSn/PwIyG98mDlEyRoGYKPH5AOsvGYlTd4Sf2CRbpUnHT8ERiuYit/gO3SPRWiW2E4f1dG5qBO9jcKPnejfUvynpVEZ3ttxafC6KeFc22ui7HmEGE4Uukf+Iiee1LC88cR/TgCg88E/ENWqORGu8SGBbiKD77KX2XAsH8gOZEd1veEwOJ+OBdHN2R7gDJ+BJMdi5aUx58ZVz8M5rlS1lFhdeA1Oidzb8TOlc3XXIuzFx/Yd2Gg15Sy0w2Ck2rY/JdFif1ALWQKyHo8m7Rh+5Mg9Sv+Q+qUIOChA1hWaSYRazkgZZ50/H4u8XE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbaf300-597c-46e6-22ee-08d6a0c7b4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 17:34:51.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4377
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

