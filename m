From: Tero Roponen <teanropo@cc.jyu.fi>
Subject: [PATCH] cg-update quotes too much
Date: Mon, 19 Dec 2005 14:19:12 +0200 (EET)
Message-ID: <Pine.GSO.4.58.0512191417180.3752@kanto>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Dec 19 13:22:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoJzb-0006Af-2A
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 13:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVLSMTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 07:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVLSMTd
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 07:19:33 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:14799 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S932211AbVLSMTc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 07:19:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti5.jyu.fi (8.13.4/8.13.4) with ESMTP id jBJCJUto026599
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 14:19:30 +0200
Received: from kanto (kanto.cc.jyu.fi [130.234.4.101])
	by posti5.jyu.fi (8.13.4/8.13.4) with ESMTP id jBJCJCGj026511
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 14:19:12 +0200
X-X-Sender: teanropo@kanto
To: git@vger.kernel.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13821>

Hi,

It seems that cogito commit e5ca051c1d3900f7fbc1592d018ab3aab6a9573a
broke cg-update, as expected ("Such a large patch is bound to introduce
some (probably mostly trivial) bugs").

Quoting $force and $squash gives cg-fetch and cg-merge an empty argument
if they are not set. If they are not quoted they will be omitted if they
are empty, which is the right thing.

Signed-off-by: Tero Roponen <teanropo@cc.jyu.fi>

---

diff --git a/cg-update b/cg-update
index d586631..1d6e0a0 100755
--- a/cg-update
+++ b/cg-update
@@ -55,10 +55,10 @@ name="${ARGS[0]}"
 [ -s "$_git/refs/heads/$name" ] && export _cg_orig_head="$(cat "$_git/refs/heads/$name")"

 if [ -s "$_git/branches/$name" ]; then
-	cg-fetch "$force" "$name" || exit 1
+	cg-fetch $force "$name" || exit 1
 else
 	echo "Updating from a local branch."
 fi
 echo
 echo "Applying changes..."
-cg-merge "$squash" "$name"
+cg-merge $squash "$name"
