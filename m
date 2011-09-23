From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] use -h for synopsis and --help for manpage consistently
Date: Fri, 23 Sep 2011 13:55:12 +0200
Message-ID: <20110923115512.GB12122@ecki.lan>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 14:55:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R75Hr-0006yV-95
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 14:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab1IWMzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 08:55:22 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:48771 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753879Ab1IWMzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 08:55:18 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id CB67910019;
	Fri, 23 Sep 2011 14:54:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181961>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Wed, Sep 21, 2011 at 10:04:28PM -0700, Junio C Hamano wrote:
> 
> * cb/send-email-help (2011-09-12) 1 commit
>   (merged to 'next' on 2011-09-14 at ae71999)
>  + send-email: add option -h
> 
> A separate set of patches to remove the hidden fully-spelled "help" from
> other commands would be nice to have as companion patches as well.

This should do it.

Clemens

 Documentation/blame-options.txt |    1 -
 git-cvsserver.perl              |    4 ++--
 git-difftool.perl               |    2 +-
 git-pull.sh                     |    2 +-
 git-sh-setup.sh                 |    2 +-
 git-svn.perl                    |    2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index e76195a..d4a51da 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -117,5 +117,4 @@ commit. And the default value is 40. If there are more than one
 take effect.
 
 -h::
---help::
 	Show help message.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 1b8bff2..6c5185e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -109,14 +109,14 @@ my $usage =
     "    --strict-paths      : Don't allow recursing into subdirectories\n".
     "    --export-all        : Don't check for gitcvs.enabled in config\n".
     "    --version, -V       : Print version information and exit\n".
-    "    --help, -h, -H      : Print usage information and exit\n".
+    "    -h                  : Print usage information and exit\n".
     "\n".
     "<directory> ... is a list of allowed directories. If no directories\n".
     "are given, all are allowed. This is an additional restriction, gitcvs\n".
     "access still needs to be enabled by the gitcvs.enabled config option.\n".
     "Alternately, one directory may be specified in GIT_CVSSERVER_ROOT.\n";
 
-my @opts = ( 'help|h|H', 'version|V',
+my @opts = ( 'h', 'version|V',
 	     'base-path=s', 'strict-paths', 'export-all' );
 GetOptions( $state, @opts )
     or die $usage;
diff --git a/git-difftool.perl b/git-difftool.perl
index ced1615..09b65f1 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -97,7 +97,7 @@ sub generate_command
 			$prompt = 'yes';
 			next;
 		}
-		if ($arg eq '-h' || $arg eq '--help') {
+		if ($arg eq '-h') {
 			usage();
 		}
 		push @command, $arg;
diff --git a/git-pull.sh b/git-pull.sh
index 63da37b..8c1370f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -120,7 +120,7 @@ do
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
-	-h|--h|--he|--hel|--help|--help-|--help-a|--help-al|--help-all)
+	-h|--help-all)
 		usage
 		;;
 	*)
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 8e427da..1fba6c2 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -90,7 +90,7 @@ $LONG_USAGE"
 	fi
 
 	case "$1" in
-		-h|--h|--he|--hel|--help)
+		-h)
 		echo "$LONG_USAGE"
 		exit
 	esac
diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..a019f55 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -294,7 +294,7 @@ read_git_config(\%opts);
 if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
 	Getopt::Long::Configure('pass_through');
 }
-my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
+my $rv = GetOptions(%opts, 'h' => \$_help, 'version|V' => \$_version,
                     'minimize-connections' => \$Git::SVN::Migration::_minimize,
                     'id|i=s' => \$Git::SVN::default_ref_id,
                     'svn-remote|remote|R=s' => sub {
-- 
1.7.6.1
