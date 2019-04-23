Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146501F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 08:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfDWIio convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 23 Apr 2019 04:38:44 -0400
Received: from smtppost.atos.net ([193.56.114.166]:27288 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWIio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 04:38:44 -0400
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost3.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 7189_70df_95966d7a_570b_4a37_8a23_a4eb898db489;
        Tue, 23 Apr 2019 10:38:40 +0200
Received: from mail3-int.my-it-solutions.net ([10.92.32.10])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3N8ceuF022983
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 10:38:40 +0200
Received: from DEERLM99ETZMSX.ww931.my-it-solutions.net ([10.86.142.48])
        by mail3-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3N8ceVB006088
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 10:38:40 +0200
Received: from DEERLM99ETRMSX.ww931.my-it-solutions.net (10.86.142.103) by
 DEERLM99ETZMSX.ww931.my-it-solutions.net (10.86.142.48) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Tue, 23 Apr 2019 10:38:40 +0200
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.103) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Tue, 23 Apr 2019 10:38:39 +0200
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com (20.177.199.143) by
 AM6PR02MB4998.eurprd02.prod.outlook.com (20.178.91.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Tue, 23 Apr 2019 08:38:38 +0000
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b]) by AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b%6]) with mapi id 15.20.1835.010; Tue, 23 Apr 2019
 08:38:38 +0000
From:   "CHIGOT, CLEMENT" <clement.chigot@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] git-compat-util: work around for access(X_OK) under root
Thread-Topic: [PATCH] git-compat-util: work around for access(X_OK) under root
Thread-Index: AQHU+a/BrB7ZLE29Jku4TzdCEFH6dA==
Date:   Tue, 23 Apr 2019 08:38:38 +0000
Message-ID: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clement.chigot@atos.net; 
x-originating-ip: [193.56.241.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2744e233-2705-4e5f-31a9-08d6c7c71534
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR02MB4998;
x-ms-traffictypediagnostic: AM6PR02MB4998:
x-microsoft-antispam-prvs: <AM6PR02MB49989D7FF7D92532E1D571CAEA230@AM6PR02MB4998.eurprd02.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(6506007)(14454004)(26005)(97736004)(305945005)(53346004)(14444005)(5660300002)(256004)(74316002)(86362001)(102836004)(25786009)(71190400001)(71200400001)(68736007)(6116002)(3846002)(186003)(7736002)(66574012)(6436002)(6916009)(2351001)(81166006)(33656002)(81156014)(99286004)(1730700003)(8676002)(7696005)(66066001)(8936002)(66446008)(73956011)(9686003)(66946007)(53936002)(64756008)(52536014)(316002)(55016002)(2906002)(478600001)(476003)(5640700003)(2501003)(486006)(66476007)(66556008)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4998;H:AM6PR02MB4950.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4RD96PZ/hNJTW4UBZa+zyK6Ed/ZsevZYUgGb3k2bRK1MvPHbvhfDVK2Rzc5S/Yr9g1ht+Xo6Io/f3Pqv1IsO8iVs77NY0fU6wP4sS3Dnk2tQvK89H7Gs563FmLeR/yiKLzCjpucr/m6AjQDeIdDN1i1fETlr2dO+XPcAs9g8OwB7UUcpIPYTCUfxrjbLD/hSI/Tl1KEEU/elY36Io0JFl9Lad8krWheWPOngj5fr3RGA78ThT9Jq1TYTe4B3cn0mo6nQqlH+HbAuprB0gLSAs0sLj2LWrj//4dDEGpXrx594hZAizQ+udd9pBSpQlHFcR5TZMbYUFKE9b+GsZWERyd10TK4DPXKvhiiwfeffp4IQNRHSSoQCBGd1m4CNjYpP+mjkMiGb2/56e16WsLQcnuwF1w1I1UnqD52U410TYpY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2744e233-2705-4e5f-31a9-08d6c7c71534
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 08:38:38.6914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4998
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On some OSes like AIX, access with X_OK is always true if launched under
root.
Add NEED_ACCESS_ROOT_HANDLER in order to use an access helper function.
It checks with stat if any executable flags is set when the current user
is root.

Signed-off-by: Clément Chigot <clement.chigot@atos.net>
---
 Makefile          |  8 ++++++++
 compat/access.c   | 29 +++++++++++++++++++++++++++++
 config.mak.uname  |  1 +
 git-compat-util.h |  8 ++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 compat/access.c

diff --git a/Makefile b/Makefile
index 9f1b6e8926..513d835d01 100644
--- a/Makefile
+++ b/Makefile
@@ -439,6 +439,9 @@ all::
 #
 # Define FILENO_IS_A_MACRO if fileno() is a macro, not a real function.
 #
+# Define NEED_ACCESS_ROOT_HANDLER if access() with X_OK returns always true
+# when launched as root.
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
index 0000000000..e4202d4585
--- /dev/null
+++ b/compat/access.c
@@ -0,0 +1,29 @@
+#include "../git-compat-util.h"
+
+/* Do the same thing access(2) does, but use the effective uid and gid,
+   and don't make the mistake of telling root that any file is
+   executable.  This version uses stat(2). */
+int git_access (const char *path, int mode)
+{
+	struct stat st;
+	uid_t euid = geteuid();
+	uid_t uid = getuid();
+
+	if (stat(path, &st) < 0)
+		return -1;
+
+	if (!(uid) || !(euid)) {
+		/* Root can read or write any file. */
+		if (!(mode & X_OK))
+			return 0;
+
+		/* Root can execute any file that has any one of the execute
+		   bits set. */
+		if (st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))
+			return 0;
+		errno = EACCES;
+		return -1;
+	}
+
+	return access(path, X_OK);
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
index 31b47932bd..bb8df9d2e5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1242,6 +1242,14 @@ int git_fileno(FILE *stream);
 # endif
 #endif
 
+#ifdef NEED_ACCESS_ROOT_HANDLER
+#ifdef access
+#undef access
+#endif
+#define access git_access
+extern int git_access(const char *path, int mode);
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
