From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/63] builtin: use builtin.h for all builtin commands
Date: Sat,  4 Sep 2010 22:10:21 +0000
Message-ID: <1283638229-14199-2-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sam Reed <sam@reedyboy.net>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 00:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0x2-0003Lx-29
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab0IDWKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:10:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37424 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0IDWKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:10:45 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so4554637wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NW6v11C72mMJUMgVcSitig95Unu0d5y7dY68eddILg8=;
        b=PdAWqD1pogwlCqyi6fhaOpoOBZ5prowUfqEv8+SNiaxHSGx0D9iTttf/MH24pFu6WG
         tmdRsfdED9W6ABXV0ZaX7G3D0bbsRwyBRGE3DUpFEPm4OoDLbLtEOihJ1MXT1+JQEzua
         sT7ihW+Q/8HslZ77Vmd4n52V10wCJF9lHjTgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JK5+sqv5VdP3NuRXUCZ8LhPZLiBQaTCXs9rTedhaXpzmD1SwH00Y+B+4dI6TVioizK
         qcjh8N+rYc29pWffDfMJH/FY9/zyfDlGMWSA8cltnbTl5X1joYBNiAP5KTfU4gU1tY3H
         oaT6Tog0/tB6uCQH/3tWyCcbhwnSWkYwurysQ=
Received: by 10.216.165.77 with SMTP id d55mr114963wel.23.1283638244419;
        Sat, 04 Sep 2010 15:10:44 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm2261604wer.23.2010.09.04.15.10.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 15:10:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155373>

Change the builtin/*.c files and wt-status.c files which weren't using
builtin.h to use it, also remove any git-compat-util.h, strbuf.h and
cache.h from those files. We can trust on builtin.h including them.

builtin.h also includes commit.h and notes.h. But I haven't removed
these includes. They're redundant now, but we may want to remove them
from builtin.h in the future.

This impeded my efforts to gettextize git, since I'd otherwise have to
add gettext.h to all of these. Using builtin.h is a good idea in any
case, since it's defining the prototypes for the cmd_* functions that
these files define.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clone.c           |    3 +--
 builtin/fetch-pack.c      |    2 +-
 builtin/hash-object.c     |    2 +-
 builtin/index-pack.c      |    2 +-
 builtin/merge-index.c     |    2 +-
 builtin/merge-recursive.c |    2 +-
 builtin/merge-tree.c      |    2 +-
 builtin/mktag.c           |    2 +-
 builtin/pack-redundant.c  |    2 +-
 builtin/pack-refs.c       |    2 +-
 builtin/patch-id.c        |    2 +-
 builtin/receive-pack.c    |    2 +-
 builtin/remote.c          |    3 +--
 builtin/reset.c           |    2 +-
 builtin/send-pack.c       |    2 +-
 builtin/unpack-file.c     |    2 +-
 builtin/var.c             |    2 +-
 wt-status.c               |    2 +-
 18 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..994d527 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,7 @@
  * Clone a repository into a different directory that does not yet exi=
st.
  */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
@@ -16,7 +16,6 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "transport.h"
-#include "strbuf.h"
 #include "dir.h"
 #include "pack-refs.h"
 #include "sigchain.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..fd70b4c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "commit.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 080af1a..8a5670f 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -4,7 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  * Copyright (C) Junio C Hamano, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2e680d7..9c5c9d6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2c4cf5e..adc2a6d 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "run-command.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 78b9db7..ad2d77d 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "commit.h"
 #include "tag.h"
 #include "merge-recursive.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9b25ddc..1991742 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "blob.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1cb0f3f..9148cc0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 41e1615..a15e366 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -6,7 +6,7 @@
 *
 */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 #define BLKSIZE 512
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 091860b..39a9d89 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "pack-refs.h"
=20
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 5125300..33e9725 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 static void flush_current_id(int patchlen, unsigned char *id, git_SHA_=
CTX *c)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 760817d..f64b79c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 48e0a6b..3cf3c6b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,9 +1,8 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "transport.h"
 #include "remote.h"
 #include "string-list.h"
-#include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
=20
diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..c198b8e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..a55a517 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "commit.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 608590a..c905d80 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/var.c b/builtin/var.c
index 0744bb8..1787771 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 static const char var_usage[] =3D "git var (-l | <variable>)";
diff --git a/wt-status.c b/wt-status.c
index 54b6b03..b05c6db 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
--=20
1.7.2.3.313.gcd15
