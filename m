Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74D920248
	for <e@80x24.org>; Mon,  4 Mar 2019 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCDRex (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 12:34:53 -0500
Received: from mail-eopbgr730093.outbound.protection.outlook.com ([40.107.73.93]:49038
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727406AbfCDRex (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 12:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYS71XeoDaWAZXGpQQV29M+IKlqtdU6YHO8XpRABOsw=;
 b=aamFm0mPC7w9RO9liXFKlyTyYwe34fuvREiwKhKZVwA4GlUy39VpaVMxy+MQtwCVYdZ2hCk/y9R6y1WcGj3X6872NxSxhmBgs1N1yQUVjaAaO9K8lEUXbF+y5pVsFY8jLWUQ7RvgULZLjNTOkWAIXR0CDFdJM1zjtZ6Y0PY1ZDI=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4377.namprd08.prod.outlook.com (20.176.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 17:34:49 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 17:34:49 +0000
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
Subject: [PATCH 4/5] git-p4: add failing test for "don't exclude other files
 with same prefix"
Thread-Topic: [PATCH 4/5] git-p4: add failing test for "don't exclude other
 files with same prefix"
Thread-Index: AQHU0rCRw/56UEwsAEubO/nhHe3C5w==
Date:   Mon, 4 Mar 2019 17:34:49 +0000
Message-ID: <a0d3fa6add2e9284167457e95d316e689ad798d5.1551485349.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: 590710f3-ad93-4bf0-97a5-08d6a0c7b36f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4377;
x-ms-traffictypediagnostic: DM6PR08MB4377:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR08MB4377;23:HvrSVtMLMv7+BYYdMON87QuT46AcoEi+d1BCmS4?=
 =?iso-8859-1?Q?h8pF22mK0XYsTqBqZCWPeZQGEDTBKUA2LMnu4BJw2soZZigNoyBJNBCzY+?=
 =?iso-8859-1?Q?7MHTHcje3AvmU/TavItVesAyeCEMl9Fd6jshUiqJrtuKQLTYfQLUYAN5RW?=
 =?iso-8859-1?Q?MSTgYQ0JqEqXGJ9VBwFgGypgDnX00ZvSDlqba8Zc4omQEMeeoj2+Y0ke7G?=
 =?iso-8859-1?Q?373hTdrYXQIsC75tlI722JjjTI8Q13NhQWIVu9pZ9H5X3xT9lz4E8DA4BP?=
 =?iso-8859-1?Q?1/3GlV1EGKsBa7PVq9VULy5Sy/ZCioqMhvgzhevMrWuOPPzW6bNl6yfdVE?=
 =?iso-8859-1?Q?GQcf7NAwKWr++iUL+KQ5qjhYublqn+kOod6fZ1GqenQIBSYq0bDs1igaqc?=
 =?iso-8859-1?Q?Zg7HyS8M8XYgLViTAM2b9wizFnNFN5pSlMOrmYhk9SuNqEqhw0MtsXhbEf?=
 =?iso-8859-1?Q?xfr+NkFfIZny5x9D8S9L+sVXjci8TtlcJsujnedPG0XPQU0im5nAzuSHKh?=
 =?iso-8859-1?Q?oMkxDadjl7g6SqOkkS9YMoIC7rbtZKDYumDE9tt55TmhpIiJ0jASxYjpcm?=
 =?iso-8859-1?Q?YRjwrDn3ZW/fq+cCJwXHCZHjTgGAcYGNjFMNCsyPRNkYekdvxSvPOP2muB?=
 =?iso-8859-1?Q?nEMIxuN0bmIlDe3zDqO/bd+3qUfB5bPK8S0XMI5Lf+uoBjpnCIXQfdd3Dm?=
 =?iso-8859-1?Q?IG9Q/jt7m194qLcT7r9x5J0fsnegyQPa4mOE5frg5lMXRFEhRBtADDWd0/?=
 =?iso-8859-1?Q?r4len4g3I4WwTwc1ibsJDczKbW9DUybfemduvLj0rnm7YXizBN7P8FuvqI?=
 =?iso-8859-1?Q?iTyspxhyShENnREkC+k/75dQ3985sv4ADm3EaMamqCCHTJbCQF3BUUKI9F?=
 =?iso-8859-1?Q?nGAFjVbF3RKnfPh4vKhoyH7RML4MadlOBLMG5ErnzLRlVeRMIcG6p/Ef79?=
 =?iso-8859-1?Q?H3b9C7w6QP7JeFAlFiawiUJW0QsnOMXOUB9TH5xbWRaMYvOXHNdd4OO+Ul?=
 =?iso-8859-1?Q?69Myn0SsPITjc20d4AYkN1Qt3LK5em76lhkBAhGiAnT4x2vaks1Dzhjj70?=
 =?iso-8859-1?Q?AoXXiZDspt0MzE63pctfXLaxFdAsHV4cZWzfBwhk+0gRV5sRfXHJlvnS24?=
 =?iso-8859-1?Q?i3RllxJnbMR1MFJK5RIRLHJo6QYkhHvO2Jaf6BaK0aT7f+hho9y8a0cxs1?=
 =?iso-8859-1?Q?Yc9w5242jeSvHrUEHYSqkrBWlbnTue2XdwWtbVvhI1OnT8hs4cgdDUinyi?=
 =?iso-8859-1?Q?1DuX9codGHz57gvs06FEIdDJrUfNKB3nDkjH1z8DNvL7lCPUtbsL2zyPfK?=
 =?iso-8859-1?Q?ESK176QSYaOVr6Rj66FBd2QNRkW8S6rxFEvBD+ng/jYr7uhxw+ZFUuTtbz?=
 =?iso-8859-1?Q?PtlM7lZbC0HTnXjx3xa+yWEIDvWHP?=
x-microsoft-antispam-prvs: <DM6PR08MB43777CA01217B79A443541EEDA710@DM6PR08MB4377.namprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(316002)(5640700003)(86362001)(3846002)(6116002)(186003)(26005)(6512007)(4326008)(6916009)(486006)(6486002)(66066001)(53936002)(6436002)(256004)(118296001)(14444005)(6506007)(52116002)(102836004)(76176011)(99286004)(386003)(2906002)(478600001)(14454004)(2351001)(2501003)(81156014)(5660300002)(81166006)(1730700003)(8676002)(68736007)(2616005)(8936002)(97736004)(50226002)(54906003)(7416002)(105586002)(106356001)(11346002)(25786009)(36756003)(305945005)(7736002)(71190400001)(71200400001)(446003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4377;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6z/TGO2jHAbse/3IgB+cN3I1U6OafZB2btRBAb0RxcZzbZtBNM+QCMUVGYR/8OfOAxiEVuFP0M95Ff8d83s8qnd7aJXvUG+nyJv3bHXbnseOvt3lV1KReITzA7w1q30eRmGnsuqFENxKfEnYlaTuJ1tSsfsivOmQWB7e810vANjWEJNSh+6ul/scq84kDvEvFo/lyMnQVdxD/lvLvGIZbE2Vq+jUVjLsegxh+OwJESkzQFqCMnpRdGByRgW8oIo6Qg5rkMxi01KxwBFpdGTV+zMkUyfQlRhLdo/fkavwU5zxEckR9JhjwL5ojr7j4NlNNvWKkmZx9pLxS/o+/uqy0CVx0EDEGbD1ItDp5pxdTTuoi/PCxLvMLdZmtYhOirelcQfOknCIy1Rs57Or/84uK4/znho3a3BmcYFsMIRlWGo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590710f3-ad93-4bf0-97a5-08d6a0c7b36f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 17:34:49.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4377
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a fix, add a failing test case to test that
git-p4 doesn't exclude files with the same prefix unintentionally
when exclude paths are specified without a trailing /.
I.e., don't exclude "//depot/file_dont_exclude" if run with "-//depot/file"=
.
or don't exclude "//depot/discard_file_not" if run with "-//depot/discard_f=
ile".

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 t/t9817-git-p4-exclude.sh | 51 +++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index aac568eadf..1c22570797 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -20,49 +20,90 @@ test_expect_success 'create exclude repo' '
 	(
 		cd "$cli" &&
 		mkdir -p wanted discard &&
 		echo wanted >wanted/foo &&
 		echo discard >discard/foo &&
-		p4 add wanted/foo discard/foo &&
+		echo discard_file >discard_file &&
+		echo discard_file_not >discard_file_not &&
+		p4 add wanted/foo discard/foo discard_file discard_file_not &&
 		p4 submit -d "initial revision"
 	)
 '
=20
 test_expect_success 'check the repo was created correctly' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest=3D"$git" //depot/...@all &&
 	(
 		cd "$git" &&
 		test_path_is_file wanted/foo &&
-		test_path_is_file discard/foo
+		test_path_is_file discard/foo &&
+		test_path_is_file discard_file &&
+		test_path_is_file discard_file_not
 	)
 '
=20
 test_expect_success 'clone, excluding part of repo' '
 	test_when_finished cleanup_git &&
 	git p4 clone -//depot/discard/... --dest=3D"$git" //depot/...@all &&
 	(
 		cd "$git" &&
 		test_path_is_file wanted/foo &&
-		test_path_is_missing discard/foo
+		test_path_is_missing discard/foo &&
+		test_path_is_file discard_file &&
+		test_path_is_file discard_file_not
+	)
+'
+
+test_expect_failure 'clone, excluding single file, no trailing /' '
+	test_when_finished cleanup_git &&
+	git p4 clone -//depot/discard_file --dest=3D"$git" //depot/...@all &&
+	(
+		cd "$git" &&
+		test_path_is_file wanted/foo &&
+		test_path_is_file discard/foo &&
+		test_path_is_missing discard_file &&
+		test_path_is_file discard_file_not
 	)
 '
=20
 test_expect_success 'clone, then sync with exclude' '
 	test_when_finished cleanup_git &&
 	git p4 clone -//depot/discard/... --dest=3D"$git" //depot/...@all &&
 	(
 		cd "$cli" &&
-		p4 edit wanted/foo discard/foo &&
+		p4 edit wanted/foo discard/foo discard_file_not &&
 		date >>wanted/foo &&
 		date >>discard/foo &&
+		date >>discard_file_not &&
 		p4 submit -d "updating" &&
=20
 		cd "$git" &&
 		git p4 sync -//depot/discard/... &&
 		test_path_is_file wanted/foo &&
-		test_path_is_missing discard/foo
+		test_path_is_missing discard/foo &&
+		test_path_is_file discard_file &&
+		test_path_is_file discard_file_not
+	)
+'
+
+test_expect_failure 'clone, then sync with exclude, no trailing /' '
+	test_when_finished cleanup_git &&
+	git p4 clone -//depot/discard/... -//depot/discard_file --dest=3D"$git" /=
/depot/...@all &&
+	(
+		cd "$cli" &&
+		p4 edit wanted/foo discard/foo discard_file_not &&
+		date >>wanted/foo &&
+		date >>discard/foo &&
+		date >>discard_file_not &&
+		p4 submit -d "updating" &&
+
+		cd "$git" &&
+		git p4 sync -//depot/discard/... -//depot/discard_file &&
+		test_path_is_file wanted/foo &&
+		test_path_is_missing discard/foo &&
+		test_path_is_missing discard_file &&
+		test_path_is_file discard_file_not
 	)
 '
=20
 test_expect_success 'kill p4d' '
 	kill_p4d
--=20
2.19.2

