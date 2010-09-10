From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH] read-tree: abort if no trees are given
Date: Fri, 10 Sep 2010 12:06:04 +0200
Message-ID: <20100910120604.50aa1e94@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 10 12:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou0Uq-0006Lz-IT
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 12:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab0IJKGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 06:06:11 -0400
Received: from zoidberg.org ([88.198.6.61]:43886 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab0IJKGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 06:06:09 -0400
Received: from jk.gs (p508A2DEF.dip.t-dialin.net [::ffff:80.138.45.239])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 10 Sep 2010 12:06:07 +0200
  id 00400158.4C8A030F.00000C2A
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155923>

Currently, read-tree silently accepts an invocation without any
tree-ishs given and simply clobbers the index in that case. This
contradicts the usage synopsis and it's also probably not what anyone
would want to happen. So, instead, abort with a fatal error.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
Someone in #git got confused by this.

 builtin/read-tree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9ad1e66..67eb08e 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -166,6 +166,8 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
+	if (nr_trees =3D=3D 0)
+		die("no trees specified to read");
 	if (1 < opts.index_only + opts.update)
 		die("-u and -i at the same time makes no sense");
 	if ((opts.update||opts.index_only) && !opts.merge)
--=20
1.7.2.3.392.g02377.dirty
