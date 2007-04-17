From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: quiet some warnings when run only with --version/--help
Date: Tue, 17 Apr 2007 02:41:43 -0700
Message-ID: <20070417094143.GB2778@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 11:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdkC4-0002rm-3p
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbXDQJlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbXDQJlp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:41:45 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54792 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109AbXDQJlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:41:44 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3653E7DC0A1;
	Tue, 17 Apr 2007 02:41:43 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 17 Apr 2007 02:41:43 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44749>

These are harmless but annoying.  They were introduced in
512b620bd9fef7f170562ecad835e37479f051ce

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Junio: did you miss
 http://permalink.gmane.org/gmane.comp.version-control.git/44493 ?

 Thanks,

 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eb3b79c..d2a5fe4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -168,14 +168,14 @@ for (my $i = 0; $i < @ARGV; $i++) {
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
 read_repo_config(\%opts);
-Getopt::Long::Configure('pass_through') if $cmd eq 'log';
+Getopt::Long::Configure('pass_through') if ($cmd && $cmd eq 'log');
 my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
                     'minimize-connections' => \$Git::SVN::Migration::_minimize,
                     'id|i=s' => \$Git::SVN::default_ref_id,
                     'svn-remote|remote|R=s' => sub {
                        $Git::SVN::no_reuse_existing = 1;
                        $Git::SVN::default_repo_id = $_[1] });
-exit 1 if (!$rv && $cmd ne 'log');
+exit 1 if (!$rv && $cmd && $cmd ne 'log');
 
 usage(0) if $_help;
 version() if $_version;

-- 
Eric Wong
