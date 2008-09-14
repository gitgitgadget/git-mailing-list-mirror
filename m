From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/16] update-index: add --checkout/--no-checkout to update CE_NO_CHECKOUT bit
Date: Sun, 14 Sep 2008 20:07:53 +0700
Message-ID: <1221397685-27715-5-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerML-0005o4-TL
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbYINNIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754044AbYINNIp
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:08:45 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbYINNIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:08:44 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FJmaos5IakNOvytiPDXGVr7uVCaGo7iqtFewf8floAs=;
        b=BE160O46IIh5AWzN9n35YnxH55jtWjB/Gx/CdMQc95qByerguMeT2QsqMCdh0wmnLE
         sQVVnyYn1lz6tGrJTCdsIYpuGE8Ggh9IsyqzF1aCkotgo46icsZiV/noIUDBfo9BChyr
         dunpN4WVLhekY9VCXdmWgJLFLjyXW+kDXSvXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aZZRrfhpNl4Xhiyoorn79Q6a6mTdxdHBfC2sC/1Wqa/zjZ501VtRQTHyCtbRKy+lfE
         CJQQAoeZHol22/JNJrSZUkidoQEGgEtx6T7OlnTXGBijmexTwFTsVaXzXyRfU1Cd4ZmI
         YSg/P/1hrxas3kTveDoYCfHWdDljc8TJzcQvY=
Received: by 10.143.42.3 with SMTP id u3mr2257553wfj.148.1221397723981;
        Sun, 14 Sep 2008 06:08:43 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 32sm19970738wfa.8.2008.09.14.06.08.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:08:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:08:36 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95831>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-update-index.txt |   12 ++++++++++++
 builtin-update-index.c             |   16 +++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 1d9d81a..707c33f 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=3D(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
+	     [--checkout | --no-checkout]
 	     [--ignore-submodules]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
@@ -88,6 +89,17 @@ OPTIONS
 	sometimes helpful when working with a big project on a
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
+--checkout::
+--no-checkout::
+	When these flags are specified, the object name recorded
+	for the paths are not updated. Instead, these options
+	set and unset the "no-checkout" bit for the paths. This
+	bit is used for marking files for narrow checkout. If
+	a path is marked "no-checkout", then it should not be
+	checked out unless requested by user or needed for a git
+	command to function.
+	See linkgit:git-checkout[1] for more information about
+	narrow checkout.
 +
 This option can be also used as a coarse file-level mechanism
 to ignore uncommitted changes in tracked files (akin to what
diff --git a/builtin-update-index.c b/builtin-update-index.c
index f63a34e..6ed883d 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -24,6 +24,7 @@ static int info_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only;
+static int mark_no_checkout_only;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
=20
@@ -276,6 +277,11 @@ static void update_one(const char *path, const cha=
r *prefix, int prefix_length)
 			die("Unable to mark file %s", path);
 		goto free_return;
 	}
+	if (mark_no_checkout_only) {
+		if (mark_ce_flags(p, CE_NO_CHECKOUT, mark_no_checkout_only =3D=3D MA=
RK_FLAG))
+			die("Unable to mark file %s", path);
+		goto free_return;
+	}
=20
 	if (force_remove) {
 		if (remove_file_from_cache(p))
@@ -386,7 +392,7 @@ static void read_index_info(int line_termination)
 }
=20
 static const char update_index_usage[] =3D
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--u=
nresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file=
>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--checkout|--no-checkout] [--info-only] [--force-remove] [-=
-stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] =
[-z] [--verbose] [--] <file>...";
=20
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
@@ -652,6 +658,14 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
 				mark_valid_only =3D UNMARK_FLAG;
 				continue;
 			}
+			if (!strcmp(path, "--checkout")) {
+				mark_no_checkout_only =3D UNMARK_FLAG;
+				continue;
+			}
+			if (!strcmp(path, "--no-checkout")) {
+				mark_no_checkout_only =3D MARK_FLAG;
+				continue;
+			}
 			if (!strcmp(path, "--info-only")) {
 				info_only =3D 1;
 				continue;
--=20
1.6.0.96.g2fad1.dirty
