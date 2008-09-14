From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/16] Add tests for updating no-checkout entries in index
Date: Sun, 14 Sep 2008 20:07:55 +0700
Message-ID: <1221397685-27715-7-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerMh-0005rr-MS
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbYINNJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbYINNI7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:08:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:58663 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084AbYINNI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:08:58 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1704394rvb.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wFAPjFPmByyHATuCgzW2DCUGx0hfkpqrmVfi1Fk9B4Q=;
        b=FevDNp6+1fMwGPmUCM1HuSCbpg4BQg1k62YMYiyiuni4lcNiH22kCezZJVfFb2EyIk
         wugS2zKRXhsaodUP+Vjn18sUUdyePxJP5iahKmAyClsZjgVbHQ1SsAeGQfavohvXHDKS
         7KbYWC3soVZDcwz+IYyfvV7a8ElOlqyTT8t7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WNhvP1ZmHMDHmWDXm3NZhUtOGgid+cE0tGBeavru4uStsXZ50/ohzwPIk09Y2rqKnm
         X4rc1CssxBCHi/BG9PKjBNsQKBLjs/AgSTB92v9QcSzHk5AzeET+nLUQ9mvFqfL+nV0w
         Ld2+t7vtQdLJHJY8oBEDFRLtNdiZADfA38S8Y=
Received: by 10.142.125.9 with SMTP id x9mr2275839wfc.66.1221397738294;
        Sun, 14 Sep 2008 06:08:58 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 20sm20088872wfi.11.2008.09.14.06.08.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:08:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:08:51 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95833>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                     |    1 +
 Makefile                       |    2 +-
 t/t2104-update-index-narrow.sh |   36 ++++++++++++++++++++++++++++++++=
++++
 test-index-version.c           |   14 ++++++++++++++
 4 files changed, 52 insertions(+), 1 deletions(-)
 create mode 100755 t/t2104-update-index-narrow.sh
 create mode 100644 test-index-version.c

diff --git a/.gitignore b/.gitignore
index bbaf9de..0c35577 100644
--- a/.gitignore
+++ b/.gitignore
@@ -147,6 +147,7 @@ test-date
 test-delta
 test-dump-cache-tree
 test-genrandom
+test-index-version
 test-match-trees
 test-parse-options
 test-path-utils
diff --git a/Makefile b/Makefile
index 716161d..7a22bde 100644
--- a/Makefile
+++ b/Makefile
@@ -1323,7 +1323,7 @@ endif
=20
 ### Testing rules
=20
-TEST_PROGRAMS =3D test-chmtime$X test-genrandom$X test-date$X test-del=
ta$X test-sha1$X test-match-trees$X test-parse-options$X test-path-util=
s$X
+TEST_PROGRAMS =3D test-chmtime$X test-genrandom$X test-date$X test-del=
ta$X test-sha1$X test-match-trees$X test-parse-options$X test-path-util=
s$X test-index-version$X
=20
 all:: $(TEST_PROGRAMS)
=20
diff --git a/t/t2104-update-index-narrow.sh b/t/t2104-update-index-narr=
ow.sh
new file mode 100755
index 0000000..2683929
--- /dev/null
+++ b/t/t2104-update-index-narrow.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
+#
+
+test_description=3D'git update-index narrow checkout update'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir sub &&
+	touch 1 2 sub/1 sub/2 &&
+	git add 1 2 sub/1 sub/2
+'
+
+test_expect_success 'index is at version 2' '
+	test "$(test-index-version < .git/index)" =3D 2
+'
+
+test_expect_success 'update-index --no-checkout' '
+	git update-index --no-checkout 1 sub/1 &&
+	test -z "$(git ls-files --narrow-checkout|grep 1)"'
+
+test_expect_success 'index is at version 3 after having some no-checko=
ut entries' '
+	test "$(test-index-version < .git/index)" =3D 3
+'
+
+test_expect_success 'update-index --checkout' '
+	git update-index --checkout 1 sub/1 &&
+	test "$(git ls-files)" =3D "$(git ls-files --narrow-checkout)"'
+
+test_expect_success 'index version is back to 2 when there is no no-ch=
eckout entry' '
+	test "$(test-index-version < .git/index)" =3D 2
+'
+
+test_done
diff --git a/test-index-version.c b/test-index-version.c
new file mode 100644
index 0000000..bfaad9e
--- /dev/null
+++ b/test-index-version.c
@@ -0,0 +1,14 @@
+#include "cache.h"
+
+int main(int argc, const char **argv)
+{
+	struct cache_header hdr;
+	int version;
+
+	memset(&hdr,0,sizeof(hdr));
+	if (read(0, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
+		return 0;
+	version =3D ntohl(hdr.hdr_version);
+	printf("%d\n", version);
+	return 0;
+}
--=20
1.6.0.96.g2fad1.dirty
