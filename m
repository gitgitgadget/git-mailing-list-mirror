From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] git-send-email: Do not send editor backup files in a directory
Date: Fri, 29 Jul 2011 00:41:56 +0000 (UTC)
Message-ID: <loom.20110729T023925-64@post.gmane.org>
References: <865ddd502d9ba4a19c33c69039ecb70ea12c0692.1311319658.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 02:45:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmbCX-0005k0-9v
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 02:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab1G2ApJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 20:45:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:49582 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab1G2ApI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 20:45:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QmbCM-0005gq-My
	for git@vger.kernel.org; Fri, 29 Jul 2011 02:45:06 +0200
Received: from static-173-55-12-11.lsanca.ftas.verizon.net ([173.55.12.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 02:45:06 +0200
Received: from joe by static-173-55-12-11.lsanca.ftas.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 02:45:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.55.12.11 (Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20100101 Firefox/5.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178120>

Joe Perches <joe <at> perches.com> writes:
> Sift out backup files that are commonly created by editors.

Ping?

-------------- 
diff --git a/git-send-email.perl b/git-send-email.perl
[]
@@ -521,7 +521,9 @@ while (defined(my $f = shift @ARGV)) {
[]
-		push @files, grep { -f $_ } map { catfile($f, $_) }
+		push @files, grep { !/#.+#$/ && !/~$/ &&
+					!/\.bak$/ && !/\.orig$/ &&
+					-f $_ } map { catfile($f, $_) }
