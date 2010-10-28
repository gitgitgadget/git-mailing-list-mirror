From: "Jonathan \"Duke\" Leto" <jonathan@leto.net>
Subject: [PATCH] Correct help blurb in checkout -p and friends
Date: Wed, 27 Oct 2010 17:49:20 -0700
Message-ID: <1288226960-31584-1-git-send-email-jonathan@leto.net>
Cc: "Jonathan \"Duke\" Leto" <jonathan@leto.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 02:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBGgt-00081F-AX
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 02:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757911Ab0J1At7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 20:49:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34710 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab0J1At5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 20:49:57 -0400
Received: by vws13 with SMTP id 13so270963vws.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=n8BfN9CvP5lQRlVm3/xCnWd46ggZKCHZbJUalMwg9jQ=;
        b=QkJQ30dTNCpeZFAB/zkTH0Gi9Fj8tmWEQll7QkSyo/TL9CQwXawo/UrPsexhkpHsnu
         xxaEx0cnUu5y9allMyiiXTRNQi76GaILIjZmByhtzJPpwrgrhiH3wXfrscdnPY91FvRG
         mEQlu9YETtpN3ZP+bX2Ji6wd4fP5go5fckMHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=xE0izibsyYH07PGUrn0R4xG2k2bBJIBY83Oi3sd2K9isBOmYtF0wso0auqY4VxzZqk
         w0ny3qiRw24r8FiJVAfauBrJTtSvWGoTyF6olYwlJxPLML/h1DxRT0U6UEOs3RZGINDK
         E9ui6SWIAHD+fNuY+yXL4KeXvD2nL0PGAGHTs=
Received: by 10.220.185.140 with SMTP id co12mr1136771vcb.109.1288226996930;
        Wed, 27 Oct 2010 17:49:56 -0700 (PDT)
Received: from localhost.localdomain (turkeyberry.sgn.cornell.edu [132.236.81.245])
        by mx.google.com with ESMTPS id s12sm260189vbp.4.2010.10.27.17.49.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 17:49:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160142>

When git checkout -p from the index or HEAD is run in edit mode, the
help message about removing '-' and '+' lines was backwards. Because it
is reverse applying the patch, the meanings of '-' and '+' are reversed.

Signed-off-by: Jonathan "Duke" Leto <jonathan@leto.net>
---
 git-add--interactive.perl |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 77f60fa..a329c5a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -89,6 +89,7 @@ my %patch_modes = (
 		TARGET => '',
 		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
+		IS_REVERSE => 0,
 	},
 	'stash' => {
 		DIFF => 'diff-index -p HEAD',
@@ -98,6 +99,7 @@ my %patch_modes = (
 		TARGET => '',
 		PARTICIPLE => 'stashing',
 		FILTER => undef,
+		IS_REVERSE => 0,
 	},
 	'reset_head' => {
 		DIFF => 'diff-index -p --cached',
@@ -107,6 +109,7 @@ my %patch_modes = (
 		TARGET => '',
 		PARTICIPLE => 'unstaging',
 		FILTER => 'index-only',
+		IS_REVERSE => 1,
 	},
 	'reset_nothead' => {
 		DIFF => 'diff-index -R -p --cached',
@@ -116,6 +119,7 @@ my %patch_modes = (
 		TARGET => ' to index',
 		PARTICIPLE => 'applying',
 		FILTER => 'index-only',
+		IS_REVERSE => 0,
 	},
 	'checkout_index' => {
 		DIFF => 'diff-files -p',
@@ -125,6 +129,7 @@ my %patch_modes = (
 		TARGET => ' from worktree',
 		PARTICIPLE => 'discarding',
 		FILTER => 'file-only',
+		IS_REVERSE => 1,
 	},
 	'checkout_head' => {
 		DIFF => 'diff-index -p',
@@ -134,6 +139,7 @@ my %patch_modes = (
 		TARGET => ' from index and worktree',
 		PARTICIPLE => 'discarding',
 		FILTER => undef,
+		IS_REVERSE => 1,
 	},
 	'checkout_nothead' => {
 		DIFF => 'diff-index -R -p',
@@ -143,6 +149,7 @@ my %patch_modes = (
 		TARGET => ' to index and worktree',
 		PARTICIPLE => 'applying',
 		FILTER => undef,
+		IS_REVERSE => 0,
 	},
 );
 
@@ -1001,10 +1008,12 @@ sub edit_hunk_manually {
 	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
 	print $fh @$oldtext;
 	my $participle = $patch_mode_flavour{PARTICIPLE};
+	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
+	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
 	print $fh <<EOF;
 # ---
-# To remove '-' lines, make them ' ' lines (context).
-# To remove '+' lines, delete them.
+# To remove '$remove_minus' lines, make them ' ' lines (context).
+# To remove '$remove_plus' lines, delete them.
 # Lines starting with # will be removed.
 #
 # If the patch applies cleanly, the edited hunk will immediately be
-- 
1.7.0.4
