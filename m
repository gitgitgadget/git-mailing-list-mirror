From: Elrond <elrond+kernel.org@samba-tng.org>
Subject: [Patch] git-cvsimport: tiny fix
Date: Wed, 10 May 2006 19:37:04 +0200
Message-ID: <20060510173703.GA10335@memak.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 10 19:38:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdscd-0007AJ-Lg
	for gcvg-git@gmane.org; Wed, 10 May 2006 19:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWEJRhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 13:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWEJRhH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 13:37:07 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de ([130.83.48.97]:35770
	"EHLO baerbel.mug.maschinenbau.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S1751393AbWEJRhG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 13:37:06 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de (localhost [127.0.0.1])
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4) with ESMTP id k4AHb4cR010561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 10 May 2006 19:37:04 +0200
Received: (from tacke@localhost)
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4/Submit) id k4AHb4MY010559
	for git@vger.kernel.org; Wed, 10 May 2006 19:37:04 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: ClamAV 0.88.2/1455/Wed May 10 17:34:38 2006 on baerbel.mug.maschinenbau.tu-darmstadt.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19892>

git-cvsimport: Handle "Removed" from pserver

Sometimes the pserver says "Removed" instead of
"Remove-entry".

Signed-off-by: Elrond <elrond+kernel.org@samba-tng.org>
---
Hi,

At least the above happened to me on a repository I tried
to convert.
Without the patch, it just die("Unknown: Removed ...")s.


    Elrond

--- git-cvsimport.perl
+++ git-cvsimport.perl
@@ -350,7 +350,7 @@ sub _line {
 				return $res;
 			} elsif($line =~ s/^E //) {
 				# print STDERR "S: $line\n";
-			} elsif($line =~ /^Remove-entry /i) {
+			} elsif($line =~ /^(Remove-entry|Removed) /i) {
 				$line = $self->readline(); # filename
 				$line = $self->readline(); # OK
 				chomp $line;
