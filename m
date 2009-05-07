From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Remove function prototypes (cleanup)
Date: Thu, 07 May 2009 19:11:29 +0200
Message-ID: <20090507171023.6496.96049.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 19:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M278I-0002Dr-Ho
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 19:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761058AbZEGRLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755354AbZEGRLf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 13:11:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:58168 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304AbZEGRLe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 13:11:34 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1332179fga.17
        for <git@vger.kernel.org>; Thu, 07 May 2009 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=MhEs3PzimvLgnLvHXm43XshEP3XDjVLOGBo2Y6kiv5Q=;
        b=D8ngzV6U5mJw4yiLgUXy02+fwR3FfkeCFKgRnJJ+LqabKcL/WochC0kEMzzQ6/oKLj
         gfU+6uxuuJX5cBtZc/ynnvG6JzORExI0w1Ztb5Zy+9pvM8PJBwi5PWkb6kNVZXura5vC
         CWLyVUaLyBw8GsSRSyUXmnIvtME7zN3rdUknM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=gFxkVZ6iN85ZoEGz80mozVTPwiVE9wqpYaQtxoXDzO9DBXqo1MyA4J0AQqQ/r4HqMH
         syvaKKBtdg6MvzBk5MoZlg8njJXi8lmMbxlrIFhhfB+GqoN/JnjWXO+Bm2qml0LpeI4D
         BhY/fTVTmOIlLUZ8bBAqtuJfTkoVfeX52BBiE=
Received: by 10.86.90.2 with SMTP id n2mr2731018fgb.61.1241716293492;
        Thu, 07 May 2009 10:11:33 -0700 (PDT)
Received: from localhost.localdomain (abwr140.neoplus.adsl.tpnet.pl [83.8.241.140])
        by mx.google.com with ESMTPS id 4sm537162fgg.8.2009.05.07.10.11.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 10:11:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n47HBUnh006534
	for <git@vger.kernel.org>; Thu, 7 May 2009 19:11:33 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118493>

Use of function prototypes is considered bad practice in Perl.  The
ones used here didn't accomplish anything anyhow, so they've been
removed.

>From perlsub(1):

  [...] the intent of this feature [prototypes] is primarily to let
  you define subroutines that work like built-in functions [...]
  you can generate new syntax with it [...]

We don't want to have subroutines behaving exactly like built-in
functions, we don't want to define new syntax / syntactic sugar, so
prototypes in gitweb are not needed... and they can have unintended
consequences.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This follows similar patch for git-send-email.perl by Bill Pemberton.

Also "sub S_ISGITLINK($) {" line caused `imenu` in my old cperl-mode
(4.23) in GNU Emacs 21.4.1 to fail, sometimes.

 gitweb/gitweb.perl |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3f99361..06e9160 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -838,7 +838,7 @@ exit;
 ## ======================================================================
 ## action links
 
-sub href (%) {
+sub href {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
 	my $href = $params{-full} ? $my_url : $my_uri;
@@ -1036,7 +1036,7 @@ sub esc_url {
 }
 
 # replace invalid utf8 character with SUBSTITUTION sequence
-sub esc_html ($;%) {
+sub esc_html {
 	my $str = shift;
 	my %opts = @_;
 
@@ -1296,7 +1296,7 @@ use constant {
 };
 
 # submodule/subproject, a commit object reference
-sub S_ISGITLINK($) {
+sub S_ISGITLINK {
 	my $mode = shift;
 
 	return (($mode & S_IFMT) == S_IFGITLINK)
@@ -2615,7 +2615,7 @@ sub parsed_difftree_line {
 }
 
 # parse line of git-ls-tree output
-sub parse_ls_tree_line ($;%) {
+sub parse_ls_tree_line {
 	my $line = shift;
 	my %opts = @_;
 	my %res;
@@ -3213,7 +3213,6 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
-#sub git_print_authorship (\%) {
 sub git_print_authorship {
 	my $co = shift;
 
@@ -3269,8 +3268,7 @@ sub git_print_page_path {
 	print "<br/></div>\n";
 }
 
-# sub git_print_log (\@;%) {
-sub git_print_log ($;%) {
+sub git_print_log {
 	my $log = shift;
 	my %opts = @_;
 
