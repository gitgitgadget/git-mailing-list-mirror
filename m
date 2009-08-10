From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v2 4/4] read-tree: add --no-sparse to turn off sparse hook
Date: Mon, 10 Aug 2009 22:19:22 +0700
Message-ID: <1249917562-5931-5-git-send-email-pclouds@gmail.com>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com>
 <1249917562-5931-2-git-send-email-pclouds@gmail.com>
 <1249917562-5931-3-git-send-email-pclouds@gmail.com>
 <1249917562-5931-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWfU-0002vZ-IK
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbZHJPTx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 11:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755358AbZHJPTx
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:19:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:22103 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbZHJPTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:19:52 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1021748rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=I0zUIaS0DZuSNrQACrr6rFW5f07YSI8orQaQqz5nd8w=;
        b=SQQkiwhIYz9s4XK4uEw2P98KhJ9Tc7NvA+Qnt2KlVLKbOKnNpH3MHzaiZ0/73VEQp3
         fSLYo/ab24l4LHiAh7GKomicIV4Ta4Zzca0LA0S+Q9GESTC7+dzHGEA+aLVPyHMhPOSp
         IFxt/Sgq90rU5o65GLIeAaO6/a9vprgwIUjEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NgO4+3Nd+nR9PMYnFCTbkPp0771B4B36z8RVfmswx65nMSXBtjGV922+jv1Y/FJH55
         aPZvGCEYSGWQ9uBdb2UAg8I94SPt0ZSNsHgP5KMcaQg29LXvfewiQR63gjZi2wSIblA9
         F3qvRlUsow7yrQTaEHfbd0HmYq4wRP/q2/XBo=
Received: by 10.140.172.20 with SMTP id u20mr518468rve.108.1249917594220;
        Mon, 10 Aug 2009 08:19:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.231.150])
        by mx.google.com with ESMTPS id f42sm25396305rvb.45.2009.08.10.08.19.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 08:19:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 10 Aug 2009 22:19:48 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1249917562-5931-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125460>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-read-tree.c         |    4 +++-
 t/t1009-read-tree-sparse.sh |    6 ++++++
 unpack-trees.c              |    6 ++++--
 unpack-trees.h              |    1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9c2d634..4c1061e 100644
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
se] [--index-output=3D<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]",
 	NULL
 };
=20
@@ -98,6 +98,8 @@ int cmd_read_tree(int argc, const char **argv, const =
char *unused_prefix)
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
 			    "don't check the working tree after merging", 1),
+		OPT_SET_INT(0, "no-sparse", &opts.no_sparse_hook,
+			    "do not run sparse hook", 1),
 		OPT_END()
 	};
=20
diff --git a/t/t1009-read-tree-sparse.sh b/t/t1009-read-tree-sparse.sh
index b613a89..18115b1 100755
--- a/t/t1009-read-tree-sparse.sh
+++ b/t/t1009-read-tree-sparse.sh
@@ -39,4 +39,10 @@ test_expect_success 're-add one' '
 	test -f one
 '
=20
+test_expect_success 'read-tree --no-sparse' '
+	make_hook "git update-index --assume-unchanged one"
+	git read-tree -u -m --no-sparse HEAD &&
+	test -f one
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index f407bf5..d087112 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -530,8 +530,10 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
=20
-	if (run_sparse_hook(o))
-		return unpack_failed(o, NULL);
+	if (!o->no_sparse_hook) {
+		if (run_sparse_hook(o))
+			return unpack_failed(o, NULL);
+	}
=20
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
diff --git a/unpack-trees.h b/unpack-trees.h
index ad21823..81eb2ef 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -30,6 +30,7 @@ struct unpack_trees_options {
 		     skip_unmerged,
 		     initial_checkout,
 		     diff_index_cached,
+		     no_sparse_hook,
 		     gently;
 	const char *prefix;
 	int pos;
--=20
1.6.3.GIT
