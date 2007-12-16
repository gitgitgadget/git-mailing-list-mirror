From: Jeff King <peff@peff.net>
Subject: Re: git-browse-help?
Date: Sun, 16 Dec 2007 02:21:04 -0500
Message-ID: <20071216072104.GA4892@sigill.intra.peff.net>
References: <20071214092829.GA22725@coredump.intra.peff.net> <7vtzmlrxc2.fsf@gitster.siamese.dyndns.org> <20071215100811.GA1692@coredump.intra.peff.net> <20071215110153.GA3447@coredump.intra.peff.net> <7vabobn4i3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 08:21:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3nof-0005nQ-Sx
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 08:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbXLPHVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 02:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbXLPHVI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 02:21:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2260 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbXLPHVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 02:21:07 -0500
Received: (qmail 20918 invoked by uid 111); 16 Dec 2007 07:21:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 16 Dec 2007 02:21:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2007 02:21:04 -0500
Content-Disposition: inline
In-Reply-To: <7vabobn4i3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68442>

On Sat, Dec 15, 2007 at 11:26:44AM -0800, Junio C Hamano wrote:

> > Although I would have called it "git-help--browse" rather than
> > "git-browse--help" since
> 
> Good point.

And here is the patch (I based the change-sites off of the ones in your
previous patch, plus a grep to double-check).

-- >8 --
rename git-browse--help to git-help--browse

The convention for helper scripts has been
git-$TOOL--$HELPER. Since this is a "browse" helper for the
"help" tool, git-help--browse is a more sensible name.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore                                 |    2 +-
 Documentation/git-help.txt                 |    4 ++--
 Makefile                                   |    2 +-
 git-browse--help.sh => git-help--browse.sh |    0 
 help.c                                     |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename git-browse--help.sh => git-help--browse.sh (100%)

diff --git a/.gitignore b/.gitignore
index aef01c5..dab5bc2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,7 +12,6 @@ git-archive
 git-bisect
 git-blame
 git-branch
-git-browse--help
 git-bundle
 git-cat-file
 git-check-attr
@@ -52,6 +51,7 @@ git-gc
 git-get-tar-commit-id
 git-grep
 git-hash-object
+git-help--browse
 git-http-fetch
 git-http-push
 git-imap-send
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 8cd69e7..da3f718 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -47,13 +47,13 @@ OPTIONS
 +
 The web browser can be specified using the configuration variable
 'help.browser', or 'web.browser' if the former is not set. If none of
-these config variables is set, the 'git-browse--help' helper script
+these config variables is set, the 'git-help--browse' helper script
 (called by 'git-help') will pick a suitable default.
 +
 You can explicitly provide a full path to your prefered browser by
 setting the configuration variable 'browser.<tool>.path'. For example,
 you can configure the absolute path to firefox by setting
-'browser.firefox.path'. Otherwise, 'git-browse--help' assumes the tool
+'browser.firefox.path'. Otherwise, 'git-help--browse' assumes the tool
 is available in PATH.
 +
 Note that the script tries, as much as possible, to display the HTML
diff --git a/Makefile b/Makefile
index 62f1893..7776077 100644
--- a/Makefile
+++ b/Makefile
@@ -227,7 +227,7 @@ SCRIPT_SH = \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
 	git-stash.sh \
-	git-browse--help.sh
+	git-help--browse.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/git-browse--help.sh b/git-help--browse.sh
similarity index 100%
rename from git-browse--help.sh
rename to git-help--browse.sh
diff --git a/help.c b/help.c
index f9ce6db..1302a61 100644
--- a/help.c
+++ b/help.c
@@ -331,7 +331,7 @@ static void show_info_page(const char *git_cmd)
 static void show_html_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
-	execl_git_cmd("browse--help", page, NULL);
+	execl_git_cmd("help--browse", page, NULL);
 }
 
 void help_unknown_cmd(const char *cmd)
-- 
1.5.4.rc0.1122.g899d-dirty
