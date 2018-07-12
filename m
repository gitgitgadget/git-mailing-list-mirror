Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B9C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeGLPyq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:54:46 -0400
Received: from mail-eopbgr720103.outbound.protection.outlook.com ([40.107.72.103]:56404
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbeGLPyq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4dVx+MDfmUQqw5OWOZmdb0bSTjAT5ZJpgn2pYL6bCg=;
 b=LRioeTNyyUhHRYnLbPNKAMH1JIUNL7rIk7enql7+RtuD6+r+pJ+fGrM+53we1A4LWxSD2V2UjOSFR/fmxRXGS6XcJr04l50ZFggS8/KSx0KsnYpCwnH0zKR1mUtYIzzUGY7H24PgJ3hwm8XvwZ3eoNHCWjOeRXnp76c+WqkQ868=
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) by
 BL0PR2101MB1058.namprd21.prod.outlook.com (52.132.24.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Thu, 12 Jul 2018 15:44:37 +0000
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724]) by BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 15:44:37 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3] handle lower case drive letters on Windows
Thread-Topic: [PATCH v3] handle lower case drive letters on Windows
Thread-Index: AQHUGfc8DLm8h3WDaEu2/WTYIc2wTg==
Date:   Thu, 12 Jul 2018 15:44:36 +0000
Message-ID: <20180712154419.18100-1-benpeart@microsoft.com>
References: <20180711175420.16940-1-benpeart@microsoft.com>
In-Reply-To: <20180711175420.16940-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: MWHPR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:300:13d::26) To BL0PR2101MB1012.namprd21.prod.outlook.com
 (2603:10b6:207:37::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1058;7:KSVPMjvYcNUufipZCkLH+RPdKf28NnDDBuV2d79yvW2rc3MqWW7qwBmpHalT71TFgEdi5r6HpCspmOOsj66l+H0IxGn/ms50KeccRwE61D76G/I9lNZ/aHpGTU8XxGm5mf1hUdRYMSS/2gc3+sAHRUmvrEjutWyzO9RzfQGuXxY26xnQcdVfCfxLk/ljMjSPLPJpjY7Laxy88VsuPLMXuQoNILGeFzSEBay2YJtJOSqypSuemclXle3lfKXWteeU
x-ms-office365-filtering-correlation-id: 17450c0b-85a1-49a8-ed0b-08d5e80e5efb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1058;
x-ms-traffictypediagnostic: BL0PR2101MB1058:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10586133B2A904A8ABBA73C0F4590@BL0PR2101MB1058.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1058;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1058;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(66066001)(5250100002)(4326008)(476003)(68736007)(6306002)(6512007)(22452003)(25786009)(2201001)(8936002)(8676002)(316002)(486006)(54906003)(10290500003)(36756003)(2501003)(11346002)(110136005)(81166006)(2616005)(86612001)(81156014)(50226002)(76176011)(446003)(1076002)(6506007)(26005)(52116002)(478600001)(105586002)(106356001)(107886003)(186003)(2906002)(386003)(72206003)(10090500001)(14454004)(256004)(97736004)(6116002)(966005)(3846002)(2900100001)(102836004)(6436002)(5660300001)(305945005)(6486002)(7736002)(53936002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1058;H:BL0PR2101MB1012.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aXZDrzWnopziMoChnzWPyT+0KcNGvooc11J4WRz8FMnp1piSZsNXRarDSbjLI9CEsDsss2mo13hTTT2k5/STixOZJJtLvx0iV2VE6wqk+KzEQVT61JjzNFtvyPNimgVl5SaELsG6pHK+knPXK168Ap1l1V9zJ87taIoQytHmIHoSiJvin2SaBtIbtMqubuVmt1XUzBUR2+UfsakgX7wabAeDaqR7ij34NgsWdyInPybufHVVbmQPCL9DUpANTTaJX0V6SwGZTlrZ5D28qv/KQLOoJz/Alv4SXkJxvjI+2bO9alt2WvnebdBvzko3icl8i/OesFluZvpo2BKmoysVH46TY0mBenR58wSeC2q5nek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17450c0b-85a1-49a8-ed0b-08d5e80e5efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 15:44:36.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1058
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, if a tool calls SetCurrentDirectory with a lower case drive
letter, the subsequent call to GetCurrentDirectory will return the same
lower case drive letter. Powershell, for example, does not normalize the
path. If that happens, test-drop-caches will error out as it does not
correctly to handle lower case drive letters.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/1ff8de1b6c
    Checkout: git fetch https://github.com/benpeart/git drop-caches-v3 && g=
it checkout 1ff8de1b6c
   =20
    ### Interdiff (v2..v3):
   =20
    diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
    index 37047189c3..f65e301f9d 100644
    --- a/t/helper/test-drop-caches.c
    +++ b/t/helper/test-drop-caches.c
    @@ -16,8 +16,8 @@ static int cmd_sync(void)
     	if ((0 =3D=3D dwRet) || (dwRet > MAX_PATH))
     		return error("Error getting current directory");
   =20
    -	if ((toupper(Buffer[0]) < 'A') || (toupper(Buffer[0]) > 'Z'))
    -		return error("Invalid drive letter '%c'", Buffer[0]);
    +	if (!has_dos_drive_prefix(Buffer))
    +		return error("'%s': invalid drive letter", Buffer);
   =20
     	szVolumeAccessPath[4] =3D Buffer[0];
     	hVolWrite =3D CreateFile(szVolumeAccessPath, GENERIC_READ | GENERIC_W=
RITE,
   =20
    ### Patches

 t/helper/test-drop-caches.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index d6bcfddf13..f65e301f9d 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -16,8 +16,8 @@ static int cmd_sync(void)
 	if ((0 =3D=3D dwRet) || (dwRet > MAX_PATH))
 		return error("Error getting current directory");
=20
-	if ((Buffer[0] < 'A') || (Buffer[0] > 'Z'))
-		return error("Invalid drive letter '%c'", Buffer[0]);
+	if (!has_dos_drive_prefix(Buffer))
+		return error("'%s': invalid drive letter", Buffer);
=20
 	szVolumeAccessPath[4] =3D Buffer[0];
 	hVolWrite =3D CreateFile(szVolumeAccessPath, GENERIC_READ | GENERIC_WRITE=
,

base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
--=20
2.17.0.gvfs.1.123.g449c066

