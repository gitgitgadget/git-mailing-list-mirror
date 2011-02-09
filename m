From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/16] Add display_columns() to display in column layout
Date: Wed,  9 Feb 2011 19:24:30 +0700
Message-ID: <1297254284-3729-3-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:26:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn981-0006wL-P7
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab1BIM0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:26:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35859 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab1BIM0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:26:30 -0500
Received: by mail-iy0-f174.google.com with SMTP id 8so92702iyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Nvk9Nt1az0PDslOTuVTjWB8rzICmAnxTw9rRdDx3hpY=;
        b=ig4WxkbD3XCDV+xNJdDQh+QfQxbHd0qU+AnBFHglXB0UP2f/RrEvpvUnMitsBVXcWe
         1qxFEj67p+qAIY4CO9r/NkEIVw9os6D2FODVPpaCbC+Lx3MCgJm+/F8qcKI/VmylV6Gv
         MT2wN8pSQ1xf4MqxtN0fT+RlFTrjWSwh7mNAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Y0wboJCdi5nE8G8JZiH8eSegzVj6pyeStI5+WtGXc2twkpyAhc9XTThKyzrE4zhWCX
         KJ8hT3sD2fUhkxNf01u6ejH7TK51YgRrx2cqsx8EQG3LEczq44eUb/rjA360A4OdFrIN
         eLXjk/elw2ou2GAJyUiJ+mJuVV8+isdFnLUQs=
Received: by 10.42.239.129 with SMTP id kw1mr2075515icb.295.1297254390206;
        Wed, 09 Feb 2011 04:26:30 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id i2sm211297icv.15.2011.02.09.04.26.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:26:29 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:24:59 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166407>

Currently it does not do that, just provide the API.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    3 ++-
 column.c |   31 +++++++++++++++++++++++++++++++
 column.h |    4 ++++
 3 files changed, 37 insertions(+), 1 deletions(-)
 create mode 100644 column.c

diff --git a/Makefile b/Makefile
index ed9e94b..88e20de 100644
--- a/Makefile
+++ b/Makefile
@@ -575,6 +575,7 @@ LIB_OBJS +=3D branch.o
 LIB_OBJS +=3D bundle.o
 LIB_OBJS +=3D cache-tree.o
 LIB_OBJS +=3D color.o
+LIB_OBJS +=3D column.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D config.o
@@ -1956,7 +1957,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
-pager.o help.o: column.h
+column.o pager.o help.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/column.c b/column.c
new file mode 100644
index 0000000..c7d9a84
--- /dev/null
+++ b/column.c
@@ -0,0 +1,31 @@
+#include "cache.h"
+#include "column.h"
+#include "string-list.h"
+
+#define MODE(mode) ((mode) & COL_MODE)
+
+/* Display without layout, COL_MODE_PLAIN */
+static void display_plain(const struct string_list *list, const char *=
indent)
+{
+	int i;
+
+	for (i =3D 0; i < list->nr; i++)
+		printf("%s%s\n", indent, list->items[i].string);
+}
+
+void display_columns(const struct string_list *list, int mode, int wid=
th, int padding, const char *indent)
+{
+	int real_mode =3D MODE(mode);
+	if (!indent)
+		indent =3D "";
+	if (width <=3D 1)
+		real_mode =3D COL_MODE_PLAIN;
+	switch (real_mode) {
+	case COL_MODE_PLAIN:
+		display_plain(list, indent);
+		break;
+
+	default:
+		die("BUG: invalid mode %d", MODE(mode));
+	}
+}
diff --git a/column.h b/column.h
index 55d8067..da0bf9a 100644
--- a/column.h
+++ b/column.h
@@ -1,6 +1,10 @@
 #ifndef COLUMN_H
 #define COLUMN_H
=20
+#define COL_MODE          0x000F
+#define COL_MODE_PLAIN         0   /* Single column */
+
 extern int term_columns(void);
+extern void display_columns(const struct string_list *list, int mode, =
int width, int padding, const char *indent);
=20
 #endif
--=20
1.7.2.2
