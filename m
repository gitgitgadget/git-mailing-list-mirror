From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 1/5] gitweb: Remove function prototypes
Date: Sun, 10 May 2009 02:05:23 +0200
Message-ID: <200905100205.23733.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 02:42:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2x7O-0005rl-MV
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 02:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbZEJAl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 20:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbZEJAly
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 20:41:54 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:53967 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbZEJAlw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2009 20:41:52 -0400
Received: by ewy24 with SMTP id 24so2659316ewy.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 17:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kdLluO0gQHi/hC/cvIenK9MEOQyLei+QjsFvdfm/rgw=;
        b=AwMdOSBzZqSYBRCblEYMViiecBKLDm7VTdCp+xNezCqDzNPzg6MbV5qVUv6Zm3MWCb
         cYA0c27qMxxkIzIal4k7y2GUSUDwSPLKZvV6xVknmx+sIrRHzQVMxUUTb1DycL2gamrj
         mmvUBMa4VxZmc/RdBw1o3WHDeLlGoyZHKS8Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=pVHtXC+kDvSTPLyebYR4r4JOexwAYnwWLev972CT70Rjuv542JKlpKAAC35FTJYu4G
         whA5caraMc5sAn7vJCI6jHK5NLOeguKO+BTwkemY+U0y13jpAhAiReiPkGVxhBR9LM5I
         ZNQ1OmEH8Wa4TDvM81ke40zgBV9qV4vHXyf00=
Received: by 10.210.132.3 with SMTP id f3mr3120997ebd.62.1241916112491;
        Sat, 09 May 2009 17:41:52 -0700 (PDT)
Received: from ?192.168.1.13? (abvf146.neoplus.adsl.tpnet.pl [83.8.203.146])
        by mx.google.com with ESMTPS id 7sm4827142eyb.25.2009.05.09.17.41.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 17:41:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905100203.51744.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118695>

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
Perl::Critic::Policy::Subroutines::ProhibitSubroutinePrototypes

  Don't write 'sub my_function (@@) {}'.

  Contrary to common belief, subroutine prototypes do not enable
  compile-time checks for proper arguments. Don't use them.

See also Damian Conway's book "Perl Best Practices",
chapter "9.10. Prototypes" (Don't use subroutine prototypes.)


This follows similar patch for git-send-email.perl by Bill Pemberton.
Also "sub S_ISGITLINK($) {" line caused `imenu` in my old cperl-mode
(4.23) in GNU Emacs 21.4.1 to fail, sometimes.

This patch was send with slightly different commit message as
standalone patch earlier. This is the replacement patch, which differs
only in the commit message.

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
 
-- 
1.6.3
