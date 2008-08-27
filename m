From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t9700-perl-git.sh: Fix a test failure on cygwin
Date: Wed, 27 Aug 2008 19:09:15 +0100
Message-ID: <48B5984B.4020901@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:12:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPVQ-0003Vj-PD
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYH0SL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYH0SL2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:11:28 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:3922 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103AbYH0SL1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 14:11:27 -0400
Received: from [193.237.126.196]
	by anchor-post-34.mail.demon.net with esmtp (Exim 4.67)
	id 1KYPUL-0004np-F8; Wed, 27 Aug 2008 18:11:26 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93912>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

This patch fixes the t9700 test failure on cygwin. Don't ask me to
explain why the original test.pl fails on cygwin, but passes on Linux!

My perl version:

    $ perl --version

    This is perl, v5.8.7 built for cygwin-thread-multi-64int
    (with 1 registered patch, see perl -V for more detail)

    Copyright 1987-2005, Larry Wall

    Perl may be copied only under the terms of either the Artistic License or the
    GNU General Public License, which may be found in the Perl 5 source kit.

    Complete documentation for Perl, including FAQ lists, should be found on
    this system using `man perl' or `perldoc perl'.  If you have access to the
    Internet, point your browser at http://www.perl.org/, the Perl Home Page.
    $ 

[My perl version on Linux is whatever comes with Ubuntu 7.04]

ATB,

Ramsay Jones

 t/t9700/test.pl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 4d23125..6d59356 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -15,9 +15,9 @@ BEGIN { use_ok('Git') }
 
 # set up
 our $repo_dir = "trash directory";
-our $abs_repo_dir = Cwd->cwd;
+our $abs_repo_dir = cwd();
 die "this must be run by calling the t/t97* shell script(s)\n"
-    if basename(Cwd->cwd) ne $repo_dir;
+    if basename($abs_repo_dir) ne $repo_dir;
 ok(our $r = Git->repository(Directory => "."), "open repository");
 
 # config
-- 
1.6.0
