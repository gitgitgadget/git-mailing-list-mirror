From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-remote: allow 'git-remote fetch' as a synonym for 'git fetch'
Date: Sat, 30 Jun 2007 20:56:17 +1200
Message-ID: <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Ykv-00065T-1M
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbXF3I4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXF3I41
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:27 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56654 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbXF3I4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:25 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008U3-Dm; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 6289062CE9; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51200>

From: Sam Vilain <sam@vilain.net>

I found myself typing this when doing remote-like things.  Perhaps
other people will find this useful

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-remote.txt |    4 ++++
 git-remote.perl              |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 61a6022..b462ccd 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -64,6 +64,10 @@ With `-n` option, the remote heads are not confirmed first with `git
 ls-remote <name>`; cached information is used instead.  Use with
 caution.
 
+'fetch'::
+
+Synonym for `git fetch <name>`, and accepts all the same options.
+
 'update'::
 
 Fetch updates for a named set of remotes in the repository as defined by
diff --git a/git-remote.perl b/git-remote.perl
index b59cafd..2c60cae 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -404,11 +404,15 @@ elsif ($ARGV[0] eq 'add') {
 	}
 	add_remote($ARGV[1], $ARGV[2], \%opts);
 }
+elsif ($ARGV[0] eq 'fetch') {
+	exec("git-fetch", @ARGV[1..$#ARGV]);
+}
 else {
 	print STDERR "Usage: git remote\n";
 	print STDERR "       git remote add <name> <url>\n";
 	print STDERR "       git remote show <name>\n";
 	print STDERR "       git remote prune <name>\n";
 	print STDERR "       git remote update [group]\n";
+	print STDERR "       git remote fetch <fetch-options> <repository> <refspec>...\n";
 	exit(1);
 }
-- 
1.5.2.1.1131.g3b90
