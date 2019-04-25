Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A061F453
	for <e@80x24.org>; Thu, 25 Apr 2019 07:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbfDYHCE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 25 Apr 2019 03:02:04 -0400
Received: from smtppost.atos.net ([193.56.114.165]:15468 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYHCE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 03:02:04 -0400
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost2.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 47b6_7bcd_39124ce6_71c8_486c_a7ed_edbed58f294c;
        Thu, 25 Apr 2019 09:02:01 +0200
Received: from mail2-int.my-it-solutions.net ([10.92.32.13])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3P71wCG013991
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 09:01:59 +0200
Received: from DEFTHW99ETZMSX.ww931.my-it-solutions.net (defthw99etzmsx.ww931.my-it-solutions.net [10.86.142.54])
        by mail2-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3P71wdD029569
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Apr 2019 09:01:58 +0200
Received: from DEFTHW99ETRMSX.ww931.my-it-solutions.net (10.86.142.99) by
 DEFTHW99ETZMSX.ww931.my-it-solutions.net (10.86.142.54) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 09:01:58 +0200
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.99) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 25 Apr 2019 09:01:57 +0200
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com (20.177.199.143) by
 AM6PR02MB4551.eurprd02.prod.outlook.com (20.177.196.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 07:01:56 +0000
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b]) by AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b%6]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 07:01:56 +0000
From:   "CHIGOT, CLEMENT" <clement.chigot@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] git-compat-util: work around for access(X_OK) under root
Thread-Topic: [PATCH v3] git-compat-util: work around for access(X_OK) under
 root
Thread-Index: AQHU+zSC2Y70xO2IYUebGVwmh5mJNg==
Date:   Thu, 25 Apr 2019 07:01:56 +0000
Message-ID: <AM6PR02MB49501E0BCA8052FA7747B314EA3D0@AM6PR02MB4950.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clement.chigot@atos.net; 
x-originating-ip: [193.56.241.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35d8ed57-bda6-4173-c854-08d6c94be7d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR02MB4551;
x-ms-traffictypediagnostic: AM6PR02MB4551:
x-microsoft-antispam-prvs: <AM6PR02MB45513500F25A608596BE8E70EA3D0@AM6PR02MB4551.eurprd02.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(7696005)(55016002)(186003)(53936002)(66066001)(99286004)(86362001)(81156014)(2906002)(8936002)(1730700003)(9686003)(5640700003)(81166006)(8676002)(2501003)(7736002)(14454004)(478600001)(305945005)(74316002)(25786009)(71190400001)(316002)(71200400001)(97736004)(476003)(486006)(33656002)(6916009)(2351001)(66574012)(6436002)(66946007)(66446008)(102836004)(66476007)(64756008)(76116006)(26005)(73956011)(53346004)(68736007)(52536014)(256004)(6506007)(14444005)(3846002)(6116002)(4326008)(5660300002)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4551;H:AM6PR02MB4950.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gEg9yzfcrM75QIoloPgBrUtJo+XYSb2uQZANBpIQaInzr1V9ynJZ3abrlW+Oub+yrDKzKI2WB7NXHIj/7uFYbiFGwnlW0c3+7Q8TtbKnVuEbzKwlMkIeCIYYygBdVWFe5lneeKg9Se6POf2G0peyStHqHb6S9Kb99tTmHE0SiGdosyNwKMjtUhhvia/TmsfAyRBtUG35KsdnycM4lCFYF88iSXe/W5Ml1ryZOk3nj6j1k8P0+3Kv6O5Ls5LuIbKGyuYUG7KDfee5SR9gIoNtt2C++zc7cgu+SblUumOhNbLVJk0yyxCL5EFDn97FdI5zZMx8VtRGi0vGlnO8zSGFetZ3A9/2L5uMetMo7D4JviSw4RzUBZdqrsjDiHyrcrNjltGPCQGqIpbrG1oIm0E9YLAKZ4VVWKQ2DSeiW2r8H9I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d8ed57-bda6-4173-c854-08d6c94be7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 07:01:56.7404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4551
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On AIX, access(X_OK) may succeed when run as root even if the
execution isn't possible. This behavior is allowed by POSIX
which says:

  ... for a process with appropriate privileges, an implementation
  may indicate success for X_OK even if execute permission is not
  granted to any user.

It can lead hook programs to have their execution refused:

   git commit -m content
   fatal: cannot exec '.git/hooks/pre-commit': Permission denied

Add NEED_ACCESS_ROOT_HANDLER in order to use an access helper function.
It checks with stat if any executable flags is set when the current user
is root.

Signed-off-by: Clément Chigot <clement.chigot@atos.net>
Message-ID: <AM6PR02MB4950ED66291B16F35BE61A26EA3C0@AM6PR02MB4950.eurprd02.prod.outlook.com>
---
 Makefile          |  8 ++++++++
 compat/access.c   | 31 +++++++++++++++++++++++++++++++
 compat/fileno.c   |  2 +-
 config.mak.uname  |  1 +
 git-compat-util.h | 12 +++++++++++-
 5 files changed, 52 insertions(+), 2 deletions(-)
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
index 0000000000..19fda3e877
--- /dev/null
+++ b/compat/access.c
@@ -0,0 +1,31 @@
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
+	 * bits set.
+	 */
+	if (st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))
+		return 0;
+
+	errno = EACCES;
+	return -1;
+}
diff --git a/compat/fileno.c b/compat/fileno.c
index 7b105f4cd7..8e80ef335d 100644
--- a/compat/fileno.c
+++ b/compat/fileno.c
@@ -1,4 +1,4 @@
-#define COMPAT_CODE
+#define COMPAT_CODE_FILENO
 #include "../git-compat-util.h"
 
 int git_fileno(FILE *stream)
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
index 31b47932bd..bdca50e64d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1236,12 +1236,22 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 
 #ifdef FILENO_IS_A_MACRO
 int git_fileno(FILE *stream);
-# ifndef COMPAT_CODE
+# ifndef COMPAT_CODE_FILENO
 #  undef fileno
 #  define fileno(p) git_fileno(p)
 # endif
 #endif
 
+#ifdef NEED_ACCESS_ROOT_HANDLER
+int git_access(const char *path, int mode);
+# ifndef COMPAT_CODE_ACCESS
+#  ifdef access
+#  undef access
+#  endif
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
