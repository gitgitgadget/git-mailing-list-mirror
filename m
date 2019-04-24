Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910EA1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 12:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfDXMAb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 24 Apr 2019 08:00:31 -0400
Received: from smtppost.atos.net ([193.56.114.165]:11491 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfDXMAb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 08:00:31 -0400
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost2.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 3929_09b4_5d9aa7b6_18ff_46a2_ba0f_484002cfcae6;
        Wed, 24 Apr 2019 14:00:27 +0200
Received: from mail1-int.my-it-solutions.net ([10.92.32.11])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3OC0PNx022979
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:00:25 +0200
Received: from DEFTHW99ETZMSX.ww931.my-it-solutions.net (defthw99etzmsx.ww931.my-it-solutions.net [10.86.142.54])
        by mail1-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3OC0Oqd008149
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 14:00:25 +0200
Received: from DEFTHW99ETQMSX.ww931.my-it-solutions.net (10.86.142.98) by
 DEFTHW99ETZMSX.ww931.my-it-solutions.net (10.86.142.54) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 14:00:24 +0200
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.98) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 24 Apr 2019 14:00:23 +0200
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com (20.177.199.143) by
 AM6PR02MB4263.eurprd02.prod.outlook.com (20.177.114.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 12:00:22 +0000
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b]) by AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b%6]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 12:00:22 +0000
From:   "CHIGOT, CLEMENT" <clement.chigot@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] git-compat-util: work around for access(X_OK) under root
Thread-Topic: [PATCH v2] git-compat-util: work around for access(X_OK) under
 root
Thread-Index: AQHU+pQOK7o0X8XzDU2gNrjAC7OR3g==
Date:   Wed, 24 Apr 2019 12:00:22 +0000
Message-ID: <AM6PR02MB4950ED66291B16F35BE61A26EA3C0@AM6PR02MB4950.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clement.chigot@atos.net; 
x-originating-ip: [193.56.241.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9469db19-f22f-430d-6020-08d6c8ac6e36
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR02MB4263;
x-ms-traffictypediagnostic: AM6PR02MB4263:
x-microsoft-antispam-prvs: <AM6PR02MB426388D0CB5F1352F0B1D316EA3C0@AM6PR02MB4263.eurprd02.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(6506007)(2351001)(14454004)(8676002)(14444005)(3846002)(8936002)(81156014)(256004)(81166006)(6916009)(1730700003)(86362001)(316002)(9686003)(74316002)(66066001)(76116006)(7736002)(6116002)(54906003)(478600001)(7696005)(2906002)(55016002)(71190400001)(305945005)(102836004)(25786009)(66574012)(73956011)(99286004)(26005)(52536014)(6436002)(4326008)(71200400001)(5640700003)(476003)(66476007)(66556008)(486006)(33656002)(53936002)(68736007)(66446008)(53346004)(186003)(64756008)(5660300002)(97736004)(66946007)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4263;H:AM6PR02MB4950.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: misbat0yJAOY+wUmfY8IEQMeA+vSIAZZ09lYYWeqZDD8QsGGt6IEa4FbHEoQM/rQ9+lHO9QZ+5n5IQuojVI1Rh/l52sXh401YLNY8TVYWB7+uQyUEfywc4s6kQXt6bnWdxeZMNfL2stGDTHsYAE+MLXVuLrgDTV/FfSkLAtkI5/1617dZBNwJWWg3qDAuf6lhc12CkBe/BazhzWxyIHFpCxVWGXgp61osVHmAglYTDLV9WuGD5ovhMN9kcRZAaPCBOu/Pnc4TXGZ1Ip4CrOBGpAS6LPRxFzk/6Qah8lOVeMKbOiRS3uNDIByyN26szSnrwSqJCs5UKS3IpZK2kkGS1DGQ7ex00agq+mSX5cyqlBLpd+C159nIDPQg9ThZKn9F+NXWCCVOmn7nLxIBqNli11tgwwu/GtcS69ACnvjwPY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9469db19-f22f-430d-6020-08d6c8ac6e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:00:22.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4263
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On AIX, access(X_OK) may success when run under root even if the
execution isn't possible. This comes from the POSIX specifications
which say:
"... for a process with appropriate privileges, an implementation
 may indicate success for X_OK even if execute permission is not
 granted to any user."

This behavior can lead hook programs to have their execution refused:
 "git commit -m content
  fatal: cannot exec '.git/hooks/pre-commit': Permission denied"

Add NEED_ACCESS_ROOT_HANDLER in order to use an access helper function.
It checks with stat if any executable flags is set when the current user
is root.

Signed-off-by: Clément Chigot <clement.chigot@atos.net>
Message-ID: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
---
 Makefile          |  8 ++++++++
 compat/access.c   | 30 ++++++++++++++++++++++++++++++
 config.mak.uname  |  1 +
 git-compat-util.h |  7 +++++++
 4 files changed, 46 insertions(+)
 create mode 100644 compat/access.c

diff --git a/Makefile b/Makefile
index 9f1b6e8926..6ac7218106 100644
--- a/Makefile
+++ b/Makefile
@@ -439,6 +439,9 @@ all::
 #
 # Define FILENO_IS_A_MACRO if fileno() is a macro, not a real function.
 #
+# Define NEED_ACCESS_ROOT_HANDLER if access() under root may success for X_OK
+# even if execution permission isn't granted for any user.
+#
 # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
 # default environment variables to be passed when a pager is spawned, e.g.
 #
@@ -1833,6 +1836,11 @@ ifdef FILENO_IS_A_MACRO
 	COMPAT_OBJS += compat/fileno.o
 endif
 
+ifdef NEED_ACCESS_ROOT_HANDLER
+	COMPAT_CFLAGS += -DNEED_ACCESS_ROOT_HANDLER
+	COMPAT_OBJS += compat/access.o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/compat/access.c b/compat/access.c
new file mode 100644
index 0000000000..fcfaefb0c0
--- /dev/null
+++ b/compat/access.c
@@ -0,0 +1,30 @@
+#define COMPAT_CODE_ACCESS
+#include "../git-compat-util.h"
+
+/* Do the same thing access(2) does, but use the effective uid,
+ * and don't make the mistake of telling root that any file is
+ * executable.  This version uses stat(2).
+ */
+int git_access(const char *path, int mode)
+{
+	struct stat st;
+
+	/* do not interfere a normal user */
+	if (geteuid())
+		return access(path, mode);
+
+	if (stat(path, &st) < 0)
+		return -1;
+
+	/* Root can read or write any file. */
+	if (!(mode & X_OK))
+		return 0;
+
+	/* Root can execute any file that has any one of the execute
+	   bits set. */
+	if (st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))
+		return 0;
+
+	errno = EACCES;
+	return -1;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 86cbe47627..ce13ab8295 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -270,6 +270,7 @@ ifeq ($(uname_S),AIX)
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
 	FILENO_IS_A_MACRO = UnfortunatelyYes
+	NEED_ACCESS_ROOT_HANDLER = UnfortunatelyYes
 	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		NO_PTHREADS = YesPlease
 	else
diff --git a/git-compat-util.h b/git-compat-util.h
index 31b47932bd..d0cb380522 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1242,6 +1242,13 @@ int git_fileno(FILE *stream);
 # endif
 #endif
 
+#ifdef NEED_ACCESS_ROOT_HANDLER
+int git_access(const char *path, int mode);
+# ifndef COMPAT_CODE_ACCESS
+#  define access(path, mode) git_access(path, mode)
+# endif
+#endif
+
 /*
  * Our code often opens a path to an optional file, to work on its
  * contents when we can successfully open it.  We can ignore a failure
-- 
2.17.1


Clément Chigot
ATOS Bull SAS
1 rue de Provence - 38432 Échirolles - France
