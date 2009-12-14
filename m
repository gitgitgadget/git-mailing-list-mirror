From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/23] read-tree: add --no-sparse-checkout to disable sparse checkout support
Date: Mon, 14 Dec 2009 17:31:04 +0700
Message-ID: <1260786666-8405-22-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:35:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8Gl-0008VO-IA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbZLNKdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756189AbZLNKdj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:39 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34948 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016AbZLNKdf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:35 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so1839222pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=K3T6rJ2lDsxFyOYWZ49DBGiAN7+vt/XGxWHMHI6JAqY=;
        b=Xg8Bm5EsWUv+RpLcv2K+nMZBrJgFO+TxvrtKW4WZ9qSoWz4izuvtSmmgdQk0jXvNah
         W4taW9bm4Af8XdWvn2V7rU7ugcBB/rYbU9ywcbHxmet5vjrzweI5725j5NBMwOTy5BLX
         2/wD5qKNpIupkaANcY9ygGLu9LF5ajsuO6CbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WQY278Uod2vNRovz9aEPyu77oHDsmkwnAUBmW7klK0xvv48oOlV9WatW6trJbUXly4
         PaHblNLVIaiHBVoFkup7QpNV1p4VW0MCbJS1l/lxNuwoNelV4Qvkaly1T2VVBkQlJLt4
         rAiUAwRjekt15sHR8opzBXPHLQ2BuyQcAcqvw=
Received: by 10.115.114.11 with SMTP id r11mr3086937wam.195.1260786815544;
        Mon, 14 Dec 2009 02:33:35 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 21sm4905016pzk.7.2009.12.14.02.33.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:54 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135190>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-read-tree.txt |    6 +++++-
 builtin-read-tree.c             |    4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index fc3f08b..ea7b0b2 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>]
 		[-u [--exclude-per-directory=3D<gitignore>] | -i]]
-		[--index-output=3D<file>]
+		[--index-output=3D<file>] [--no-sparse-checkout]
 		<tree-ish1> [<tree-ish2> [<tree-ish3>]]
=20
=20
@@ -110,6 +110,10 @@ OPTIONS
 	directories the index file and index output file are
 	located in.
=20
+--no-sparse-checkout::
+	Disable sparse checkout support even if `core.sparseCheckout`
+	is true.
+
 <tree-ish#>::
 	The id of the tree object(s) to be read/merged.
=20
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9c2d634..f5acb1a 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -31,7 +31,7 @@ static int list_tree(unsigned char *sha1)
 }
=20
 static const char * const read_tree_usage[] =3D {
-	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]]  [--index-=
output=3D<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]",
+	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-spar=
se-checkout] [--index-output=3D<file>] <tree-ish1> [<tree-ish2> [<tree-=
ish3>]]",
 	NULL
 };
=20
@@ -98,6 +98,8 @@ int cmd_read_tree(int argc, const char **argv, const =
char *unused_prefix)
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
 			    "don't check the working tree after merging", 1),
+		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
+			    "skip applying sparse checkout filter", 1),
 		OPT_END()
 	};
=20
--=20
1.6.5.2.216.g9c1ec
