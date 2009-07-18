From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: [PATCH] Trivial path quoting fixes in git-instaweb
Date: Sat, 18 Jul 2009 09:45:44 -0700
Message-ID: <BLU0-SMTP74459FFFD6FF936D27AD4FAE1F0@phx.gbl>
References: <4A61E563.7000401@superdigi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bodo Schlecht <schlecht@superdigi.de>
X-From: git-owner@vger.kernel.org Sat Jul 18 18:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSD4F-0004Wi-P6
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 18:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbZGRQpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 12:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbZGRQpt
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 12:45:49 -0400
Received: from blu0-omc3-s32.blu0.hotmail.com ([65.55.116.107]:5851 "EHLO
	blu0-omc3-s32.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753111AbZGRQps (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2009 12:45:48 -0400
Received: from BLU0-SMTP74 ([65.55.116.73]) by blu0-omc3-s32.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 18 Jul 2009 09:45:47 -0700
X-Originating-IP: [96.49.109.68]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([96.49.109.68]) by BLU0-SMTP74.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 18 Jul 2009 09:45:47 -0700
In-Reply-To: <4A61E563.7000401@superdigi.de>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.2; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Jul 2009 16:45:47.0440 (UTC) FILETIME=[33525300:01CA07C7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123527>


Bodo Schlecht noticed that Instaweb didn't propely quote all
path instances in the Apache config file it generated.
---
 git-instaweb.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 5f4419b..32f6496 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -256,7 +256,7 @@ apache2_conf () {
 	mkdir -p "$GIT_DIR/gitweb/logs"
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
-	echo 'text/css css' > $fqgitdir/mime.types
+	echo 'text/css css' > "$fqgitdir/mime.types"
 	cat > "$conf" <<EOF
 ServerName "git-instaweb"
 ServerRoot "$fqgitdir/gitweb"
@@ -272,7 +272,7 @@ EOF
 		fi
 	done
 	cat >> "$conf" <<EOF
-TypesConfig $fqgitdir/mime.types
+TypesConfig "$fqgitdir/mime.types"
 DirectoryIndex gitweb.cgi
 EOF
 
-- 
1.6.3.3
