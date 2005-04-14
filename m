From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Reorganize common code
Date: Thu, 14 Apr 2005 12:33:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504141230310.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504131755550.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 18:31:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM7EM-0003ht-L3
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 18:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVDNQdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 12:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVDNQdc
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 12:33:32 -0400
Received: from iabervon.org ([66.92.72.58]:61959 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261543AbVDNQdN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 12:33:13 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DM7HJ-0006dR-00; Thu, 14 Apr 2005 12:33:17 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504131755550.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I forgot to include util.c. On my to-do list is something to make this
more obvious.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: util.c
===================================================================
--- /dev/null  (tree:e8194c62bfc68725972a6847fa2c6d529ca64137)
+++ 420a52c504bf712cd898a11746a54ea4349a9386/util.c  (mode:100644 sha1:d1d497c6709503f71138e816b2599d5105cc4915)
@@ -0,0 +1,37 @@
+#include "util.h"
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+void usage(const char *err)
+{
+	fprintf(stderr, "usage: %s\n", err);
+	exit(1);
+}
+
+static void report(const char *prefix, const char *err, va_list params)
+{
+	fputs(prefix, stderr);
+	vfprintf(stderr, err, params);
+	fputs("\n", stderr);
+}
+
+void die(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	report("fatal: ", err, params);
+	va_end(params);
+	exit(1);
+}
+
+int error(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	report("error: ", err, params);
+	va_end(params);
+	return -1;
+}

