From: Marc Weber <marco-oweber@gmx.de>
Subject: [PATCH 2] renaming git add -i [r]evert -> reset and adding gitt
	add -i [c]heckout
Date: Sun, 5 Oct 2008 23:46:44 +0200
Message-ID: <20081005214644.GB32727@gmx.de>
References: <20081005152654.GA13618@gmx.de> <20081005164124.GA31903@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 23:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmbSK-0002gi-OI
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 23:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbYJEVqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 17:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbYJEVqt
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 17:46:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:55772 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754685AbYJEVqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 17:46:48 -0400
Received: (qmail invoked by alias); 05 Oct 2008 21:46:44 -0000
Received: from pD9E0B72A.dip.t-dialin.net (EHLO nixos) [217.224.183.42]
  by mail.gmx.net (mp047) with SMTP; 05 Oct 2008 23:46:44 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX18XjF80cxsXuFXmVYxbdDV+iTNavrMlCnSBFFgk9P
	rGnmh08RasUDgD
Received: by nixos (sSMTP sendmail emulation); Sun, 05 Oct 2008 23:46:44 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081005164124.GA31903@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97542>

Hi Jeff, thanks!
I'll try to do it better now (not sure who is the mantainer though, I've
seen that you've commited some lines to this file)..

Both patches apply cleanly against c427559 (master).
You can push enhancements directly to 

git://mawercer.de/git_my_patches 
topic branches: 
        renaming_revert_to_reset
        revert_to_reset_renaming

Sincerly
Marc Weber

============= attachement git show output ============================

commit 852b21bf88b1de784244a6e99de9a53a5c61dd8c
Author: Marc Weber <marco-oweber@gmx.de>
Date:   Sun Oct 5 23:09:04 2008 +0200

    rename the git add -i [r]evert command to [r]eset to use the same term as in git reset
    purpose: decrease possibility of confusion for users with svn background (svn revert = git checkout)
    
    Signed-off-by: Marc Weber <marco-oweber@gmx.de>

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index da768ee..5352d16 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -498,8 +498,8 @@ sub update_cmd {
        print "\n";
 }
 
-sub revert_cmd {
-       my @update = list_and_choose({ PROMPT => 'Revert',
+sub reset_cmd {
+       my @update = list_and_choose({ PROMPT => 'Reset',
                                       HEADER => $status_head, },
                                     list_modified());
        if (@update) {
@@ -527,7 +527,7 @@ sub revert_cmd {
                        }
                }
                refresh();
-               say_n_paths('reverted', @update);
+               say_n_paths('reset', @update);
        }
        print "\n";
 }
@@ -1046,7 +1046,7 @@ sub help_cmd {
        print colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
-revert        - revert staged set of changes back to the HEAD version
+reset         - reset staged set of changes back to the HEAD version
 patch         - pick hunks and update selectively
 diff         - view diff between HEAD and index
 add untracked - add contents of untracked files to the staged set of changes
@@ -1070,7 +1070,7 @@ sub process_args {
 sub main_loop {
        my @cmd = ([ 'status', \&status_cmd, ],
                   [ 'update', \&update_cmd, ],
-                  [ 'revert', \&revert_cmd, ],
+                  [ 'reset', \&reset_cmd, ],
                   [ 'add untracked', \&add_untracked_cmd, ],
                   [ 'patch', \&patch_update_cmd, ],
                   [ 'diff', \&diff_cmd, ],








commit b3d438764a7429e1dfacef8f499a0126076ed2bc
Author: Marc Weber <marco-oweber@gmx.de>
Date:   Sun Oct 5 15:15:38 2008 +0000

    renamed revert in ga -i to reset, added [c]heckout

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index da768ee..32c300f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -498,8 +498,8 @@ sub update_cmd {
        print "\n";
 }
 
-sub revert_cmd {
-       my @update = list_and_choose({ PROMPT => 'Revert',
+sub reset_cmd {
+       my @update = list_and_choose({ PROMPT => 'Reset',
                                       HEADER => $status_head, },
                                     list_modified());
        if (@update) {
@@ -527,7 +527,31 @@ sub revert_cmd {
                        }
                }
                refresh();
-               say_n_paths('reverted', @update);
+               say_n_paths('reset', @update);
+       }
+       print "\n";
+}
+
+sub checkout_cmd {
+       my @update = list_and_choose({ PROMPT => 'Checkout',
+                                      HEADER => $status_head, },
+                                    list_modified());
+       if (@update) {
+               if (is_initial_commit()) {
+                        # should never be executed because there can't
be modified files
+                        print "error: no revision in repo yet\n";
+               }
+               else {
+                       for (@update) {
+                               if ($_->{INDEX_ADDDEL} &&
+                                   $_->{INDEX_ADDDEL} eq 'create') {
+                                       system(qw(git checkout --),
+                                              $_->{VALUE});
+                               }
+                       }
+               }
+               refresh();
+               say_n_paths('checked out', @update);
        }
        print "\n";
 }
@@ -1046,7 +1070,8 @@ sub help_cmd {
        print colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
-revert        - revert staged set of changes back to the HEAD version
+reset         - reset staged set of changes back to the HEAD version
+checkout      - reset working copy file back to the HEAD version
 patch         - pick hunks and update selectively
 diff         - view diff between HEAD and index
 add untracked - add contents of untracked files to the staged set of
changes
@@ -1070,7 +1095,8 @@ sub process_args {
 sub main_loop {
        my @cmd = ([ 'status', \&status_cmd, ],
                   [ 'update', \&update_cmd, ],
-                  [ 'revert', \&revert_cmd, ],
+                  [ 'reset', \&reset_cmd, ],
+                  [ 'checkout', \&checkout_cmd, ],
                   [ 'add untracked', \&add_untracked_cmd, ],
                   [ 'patch', \&patch_update_cmd, ],
                   [ 'diff', \&diff_cmd, ],
