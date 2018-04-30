Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A38215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 14:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeD3O0O (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 10:26:14 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:1488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753881AbeD3O0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 10:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y4tB3+RMAkgpcjP8kU14XraUk6XNqEMrGjH4SK/nxhM=;
 b=m3DJug13Rl+B2JzNurhN53WuWCCVcmy8DmXndfDVN0udFXLaanAA1RdLmwGK8CqCorGo9v6HF7GCrIaXkTpVglRXo5vs68AwTHaIwyTNuvSb6dE5w2UwUpZRD7j0jGIU//f+w56MfEuPguzE8b/1y13NA//g7Z0miZMNi8HE6n4=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0935.namprd21.prod.outlook.com (52.132.131.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.0; Mon, 30 Apr 2018 14:26:11 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0755.002; Mon, 30 Apr 2018
 14:26:11 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] test-drop-caches: simplify delay loading of
 NtSetSystemInformation
Thread-Topic: [PATCH v1] test-drop-caches: simplify delay loading of
 NtSetSystemInformation
Thread-Index: AQHT4I8vZ98oY0x3y0m+Dk4pIUqxkA==
Date:   Mon, 30 Apr 2018 14:26:11 +0000
Message-ID: <20180430142555.23260-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0061.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::21) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0935;7:UxIeGzDKDBhNPiWl0bdOSMa3dmUma75X/3BWtgmhDnbI6XOyCw0QKTKpT0HcPV4Jvi2oL2k2/BehIISWhtmAjn0qZIsuKAD7byr147pFUYNyIrmMJDLGktk6XC1N/MVJqThSw9WROBCGFiS57gIXZ2LYl5AkGoaM3MNQd7kSm+5+jZM0vXviEKx+UluQvV6uU8MXxWgcNbQch7LF72LfOlaN7Gepf+n0kEmQWy2QrxhESRJDs2Z7y17sQz6rN+wP;20:iVzCt356XWyTq6EVh7L3PQCHlg/afURvE0UeXkVJ1uQoP4XLIIPOhWe0N6gTfX3u7Rq/vWQy/yuvQqTaF9KY7Eo4vQd1mnqLSOu1fK1kZP1yIzCTuXUcSr3YlUZALWipLTl8PZdOD5KVeikWM2vJgioeBJrNJnieDsMiH5l8drU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0935;
x-ms-traffictypediagnostic: DM5PR2101MB0935:
x-microsoft-antispam-prvs: <DM5PR2101MB0935C4D51352B28BD9626F4FF4820@DM5PR2101MB0935.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0935;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0935;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(346002)(39860400002)(376002)(366004)(396003)(39380400002)(199004)(189003)(8666007)(7736002)(4326008)(106356001)(102836004)(6506007)(10290500003)(305945005)(575784001)(52116002)(26005)(14454004)(50226002)(8936002)(25786009)(97736004)(86612001)(6346003)(2906002)(6916009)(386003)(81166006)(8676002)(6116002)(3846002)(81156014)(2501003)(3280700002)(10090500001)(6306002)(1730700003)(72206003)(5640700003)(2616005)(486006)(3660700001)(476003)(966005)(186003)(22452003)(66066001)(478600001)(107886003)(105586002)(54906003)(36756003)(99286004)(1076002)(6486002)(6436002)(5250100002)(316002)(6512007)(2351001)(53936002)(5660300001)(68736007)(39060400002)(2900100001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0935;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: PspPErqh4OwZYXTWAJe/g8g4KbtadcoVoASd2m+R4RstQ8glmDSmo9Yxtr8T25wPghDehcZsIlVoEBCy/GG9hJ12hCsbPl2AOxv3aEHMWHV8hM+DDLhtZ/EJJ0FZFOiwsbOeUPLlTlYtUQKZq8fy/yjTyUnmWkuPUdPT7F0dTNo8D4UJfUUxqBrjpbcOhpKd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e4869a06-23a9-46e3-6cce-08d5aea651fa
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4869a06-23a9-46e3-6cce-08d5aea651fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 14:26:11.3428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0935
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of the recent addition of support for lazy loading functions
on Windows to simplfy the loading of NtSetSystemInformation.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/6e6ce4a788
    Checkout: git fetch https://github.com/benpeart/git test-drop-caches-v1=
 && git checkout 6e6ce4a788

 t/helper/test-drop-caches.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 838760898b..dd41da1a2c 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "lazyload.h"
=20
 #if defined(GIT_WINDOWS_NATIVE)
=20
@@ -82,8 +83,6 @@ static int cmd_dropcaches(void)
 {
 	HANDLE hProcess =3D GetCurrentProcess();
 	HANDLE hToken;
-	HMODULE ntdll;
-	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG);
 	SYSTEM_MEMORY_LIST_COMMAND command;
 	int status;
=20
@@ -95,14 +94,9 @@ static int cmd_dropcaches(void)
=20
 	CloseHandle(hToken);
=20
-	ntdll =3D LoadLibrary("ntdll.dll");
-	if (!ntdll)
-		return error("Can't load ntdll.dll, wrong Windows version?");
-
-	NtSetSystemInformation =3D
-		(DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemIn=
formation");
-	if (!NtSetSystemInformation)
-		return error("Can't get function addresses, wrong Windows version?");
+	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, U=
LONG);
+	if (!INIT_PROC_ADDR(NtSetSystemInformation))
+		return error("Could not find NtSetSystemInformation() function");
=20
 	command =3D MemoryPurgeStandbyList;
 	status =3D NtSetSystemInformation(
@@ -115,8 +109,6 @@ static int cmd_dropcaches(void)
 	else if (status !=3D STATUS_SUCCESS)
 		error("Unable to execute the memory list command %d", status);
=20
-	FreeLibrary(ntdll);
-
 	return status;
 }
=20

base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
--=20
2.17.0.windows.1

