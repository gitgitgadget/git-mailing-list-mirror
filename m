From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] git-write-tree should not crash if prefix does not exist
Date: Wed, 25 Jul 2007 23:14:54 -0400
Message-ID: <20070726031454.GA2026@localhost.hsd1.ma.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 05:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDtoM-0004zO-1J
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbXGZDOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Jul 2007 23:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbXGZDOn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:14:43 -0400
Received: from qb-out-0506.google.com ([72.14.204.225]:48810 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670AbXGZDOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:14:42 -0400
Received: by qb-out-0506.google.com with SMTP id e11so86121qbe
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 20:14:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=pnzNmiTU0uc5xIyq3uP3VN8oudA8ROzCEIQNE5uGEGqPeL46OwIGse0gWovzhjWNBpxp+hji1yXG8vO0nqrHlAKrbSXSb/TatNH04vSsT572LvBNIZuaOepq/u7sNxRwKa25j/zGqVUJaG+varNApJqdOpboEEW8Lk7bk5+hskY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=UMO/BKbKJH5+cO1N3vqRh+LrYMzD+dW5v6Y/EMJGjHrGaSSmtcfbxfiq9loVUYLlO2f7cyPX+NE5IsKxCQn7Q41E0RYgaFQiuvjwl/yOloW6eTPJY7CtR0SIXPFJLAJFLv4vpdUws91cSyuChjz7K3ISpiyvP+GNwbszCtoH2gg=
Received: by 10.70.67.4 with SMTP id p4mr2289976wxa.1185419680922;
        Wed, 25 Jul 2007 20:14:40 -0700 (PDT)
Received: from pclouds@gmail.com ( [76.118.142.131])
        by mx.google.com with ESMTPS id q57sm2070253wrq.2007.07.25.20.14.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 20:14:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 25 Jul 2007 23:14:54 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53752>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Resend as it seems git-send-email and vger.kernel.org don't like me
 much

 builtin-write-tree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 391de53..88f34ba 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -52,6 +52,8 @@ int write_tree(unsigned char *sha1, int missing_ok, c=
onst char *prefix)
 	if (prefix) {
 		struct cache_tree *subtree =3D
 			cache_tree_find(active_cache_tree, prefix);
+		if (!subtree)
+			die("git-write-tree: prefix %s not found", prefix);
 		hashcpy(sha1, subtree->sha1);
 	}
 	else
--=20
1.5.2
