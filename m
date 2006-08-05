From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/5] Merge changes in "split patch 1" series
Date: Sat, 05 Aug 2006 13:42:44 +0200
Organization: At home
Message-ID: <eb2068$cm7$1@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 13:42:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KXu-0006Vt-F3
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWHELmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWHELmQ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:42:16 -0400
Received: from main.gmane.org ([80.91.229.2]:50400 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161238AbWHELmQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:42:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9KXg-0006UV-HL
	for git@vger.kernel.org; Sat, 05 Aug 2006 13:42:08 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:42:08 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:42:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24913>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Strange that git-format-patch does not output merges...

 gitweb/gitweb.perl |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4316bd0..bf1b10f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -67,16 +67,16 @@ our $git_version = qx($GIT --version) =~
 
 $projects_list ||= $projectroot;
 if (! -d $git_temp) {
-       mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
+       mkdir($git_temp, 0700) || die_error(undef, "Couldn't mkdir $git_temp");
 }
 
 
-# ======================================================================
-# input validation and dispatch
+## ======================================================================
+## input validation and dispatch
 our $action = $cgi->param('a');
 if (defined $action) {
        if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
-               die_error(undef, "Invalid action parameter $action");
+               die_error(undef, "Invalid action parameter");
        }
        # action which does not check rest of parameters
        if ($action eq "opml") {
@@ -87,15 +87,15 @@ if (defined $action) {
 
 our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
 $project =~ s|^/||; $project =~ s|/$||;
-if (defined $project || $project) {
+if (defined $project && $project) {
        if (!validate_input($project)) {
-               die_error(undef, "Invalid project parameter $project");
+               die_error(undef, "Invalid project parameter");
        }
        if (!(-d "$projectroot/$project")) {
-               die_error(undef, "No such directory $project");
+               die_error(undef, "No such directory");
        }
        if (!(-e "$projectroot/$project/HEAD")) {
-               die_error(undef, "No such project $project");
+               die_error(undef, "No such project");
        }
        $ENV{'GIT_DIR'} = "$projectroot/$project";
 } else {
@@ -106,42 +106,42 @@ if (defined $project || $project) {
 our $file_name = $cgi->param('f');
 if (defined $file_name) {
        if (!validate_input($file_name)) {
-               die_error(undef, "Invalid file parameter $file_name");
+               die_error(undef, "Invalid file parameter");
        }
 }
 
 our $hash = $cgi->param('h');
 if (defined $hash) {
        if (!validate_input($hash)) {
-               die_error(undef, "Invalid hash parameter $hash");
+               die_error(undef, "Invalid hash parameter");
        }
 }
 
 our $hash_parent = $cgi->param('hp');
 if (defined $hash_parent) {
        if (!validate_input($hash_parent)) {
-               die_error(undef, "Invalid hash parent parameter $hash_parent");
+               die_error(undef, "Invalid hash parent parameter");
        }
 }
 
 our $hash_base = $cgi->param('hb');
 if (defined $hash_base) {
        if (!validate_input($hash_base)) {
-               die_error(undef, "Invalid hash base parameter $hash_base");
+               die_error(undef, "Invalid hash base parameter");
        }
 }
 
 our $page = $cgi->param('pg');
 if (defined $page) {
        if ($page =~ m/[^0-9]$/) {
-               die_error(undef, "Invalid page parameter $page");
+               die_error(undef, "Invalid page parameter");
        }
 }
 
 our $searchtext = $cgi->param('s');
 if (defined $searchtext) {
        if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
-               die_error(undef, "Invalid search parameter $searchtext");
+               die_error(undef, "Invalid search parameter");
        }
        $searchtext = quotemeta $searchtext;
 }
@@ -170,7 +170,7 @@ my %actions = (
 
 $action = 'summary' if (!defined($action));
 if (!defined($actions{$action})) {
-       die_error(undef, "Unknown action $action");
+       die_error(undef, "Unknown action");
 }
 $actions{$action}->();
 exit;
@@ -1282,7 +1282,7 @@ ## actions
 sub git_project_list {
        my $order = $cgi->param('o');
        if (defined $order && $order !~ m/project|descr|owner|age/) {
-               die_error(undef, "Invalid order parameter $order");
+               die_error(undef, "Unknown order parameter");
        }
 
        my @list = git_read_projects();
@@ -1479,7 +1479,7 @@ sub git_blame2 {
        my $fd;
        my $ftype;
        die_error(undef, "Permission denied") if (!git_get_project_config_bool ('blame'));
-       die_error('404 Not Found', "File name not defined.") if (!$file_name);
+       die_error('404 Not Found', "File name not defined") if (!$file_name);
        $hash_base ||= git_get_head($project);
        die_error(undef, "Couldn't find base commit") unless ($hash_base);
        my %co = parse_commit($hash_base)
@@ -1539,12 +1539,12 @@ sub git_blame {
        die_error('403 Permission denied', "Permission denied") if (!git_get_project_config_bool ('blame'));
        die_error('404 Not Found', "File name not defined") if (!$file_name);
        $hash_base ||= git_get_head($project);
-       die_error(undef, "Couldn't find base commit.") unless ($hash_base);
+       die_error(undef, "Couldn't find base commit") unless ($hash_base);
        my %co = parse_commit($hash_base)
                or die_error(undef, "Reading commit failed");
        if (!defined $hash) {
                $hash = git_get_hash_by_path($hash_base, $file_name, "blob")
-                       or die_error(undef, "Error lookup file $file_name");
+                       or die_error(undef, "Error lookup file");
        }
        open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
                or die_error(undef, "Open git-annotate failed");
@@ -1656,14 +1656,14 @@ sub git_blob_plain {
                if (defined $file_name) {
                        my $base = $hash_base || git_get_head($project);
                        $hash = git_get_hash_by_path($base, $file_name, "blob")
-                               or die_error(undef, "Error lookup file $file_name");
+                               or die_error(undef, "Error lookup file");
                } else {
                        die_error(undef, "No file name defined");
                }
        }
        my $type = shift;
        open my $fd, "-|", $GIT, "cat-file", "blob", $hash
-               or die_error("Couldn't cat $file_name, $hash");
+               or die_error(undef, "Couldn't cat $file_name, $hash");
 
        $type ||= blob_plain_mimetype($fd, $file_name);
 
@@ -1689,7 +1689,7 @@ sub git_blob {
                if (defined $file_name) {
                        my $base = $hash_base || git_get_head($project);
                        $hash = git_get_hash_by_path($base, $file_name, "blob")
-                               or die_error(undef, "Error lookup file $file_name");
+                               or die_error(undef, "Error lookup file");
                } else {
                        die_error(undef, "No file name defined");
                }
-- 
1.4.1.1
git diff --patch-with-stat
