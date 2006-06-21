From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 1/3] gitweb: Declare global variables with "our"
Date: Wed, 21 Jun 2006 15:07:08 +0200
Message-ID: <20060621130708.Gcbc6e5c@leonov.stosberg.net>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 15:07:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft2QR-0008U3-5g
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 15:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWFUNHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 09:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWFUNHO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 09:07:14 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:25315 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751494AbWFUNHM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 09:07:12 -0400
Received: from leonov.stosberg.net (p213.54.85.218.tisdip.tiscali.de [213.54.85.218])
	by ncs.stosberg.net (Postfix) with ESMTP id CB8D9AEBA065;
	Wed, 21 Jun 2006 15:07:03 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id BA45310E052; Wed, 21 Jun 2006 15:07:08 +0200 (CEST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060621130535.G2b34d382@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22267>

Variables declared with "my" in the file scope cannot be accessed from
subroutines with mod_perl.
---
 gitweb/gitweb.cgi |   55 ++++++++++++++++++++++++++---------------------------
 1 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index ef7fcbd..8f19fdb 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -16,21 +16,21 @@ use Encode;
 use Fcntl ':mode';
 binmode STDOUT, ':utf8';
 
-my $cgi = new CGI;
-my $version = "267";
-my $my_url = $cgi->url();
-my $my_uri = $cgi->url(-absolute => 1);
-my $rss_link = "";
+our $cgi = new CGI;
+our $version = "267";
+our $my_url = $cgi->url();
+our $my_uri = $cgi->url(-absolute => 1);
+our $rss_link = "";
 
 # location of the git-core binaries
-my $gitbin = "/usr/bin";
+our $gitbin = "/usr/bin";
 
 # absolute fs-path which will be prepended to the project path
-#my $projectroot = "/pub/scm";
-my $projectroot = "/home/kay/public_html/pub/scm";
+#our $projectroot = "/pub/scm";
+our $projectroot = "/home/kay/public_html/pub/scm";
 
 # version of the git-core binaries
-my $git_version = qx($gitbin/git --version);
+our $git_version = qx($gitbin/git --version);
 if ($git_version =~ m/git version (.*)$/) {
 	$git_version = $1;
 } else {
@@ -38,32 +38,31 @@ if ($git_version =~ m/git version (.*)$/
 }
 
 # location for temporary files needed for diffs
-my $git_temp = "/tmp/gitweb";
+our $git_temp = "/tmp/gitweb";
 
 # target of the home link on top of all pages
-my $home_link = $my_uri;
+our $home_link = $my_uri;
 
 # html text to include at home page
-my $home_text = "indextext.html";
+our $home_text = "indextext.html";
 
 # URI of default stylesheet
-my $stylesheet = "gitweb.css";
+our $stylesheet = "gitweb.css";
 
 # source of projects list
-#my $projects_list = $projectroot;
-my $projects_list = "index/index.aux";
+#our $projects_list = $projectroot;
+our $projects_list = "index/index.aux";
 
 # default blob_plain mimetype and default charset for text/plain blob
-my $default_blob_plain_mimetype = 'text/plain';
-my $default_text_plain_charset  = undef;
+our $default_blob_plain_mimetype = 'text/plain';
+our $default_text_plain_charset  = undef;
 
 # file to use for guessing MIME types before trying /etc/mime.types
 # (relative to the current git repository)
-my $mimetypes_file = undef;
-
+our $mimetypes_file = undef;
 
 # input validation and dispatch
-my $action = $cgi->param('a');
+our $action = $cgi->param('a');
 if (defined $action) {
 	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
 		undef $action;
@@ -78,7 +77,7 @@ if (defined $action) {
 	}
 }
 
-my $order = $cgi->param('o');
+our $order = $cgi->param('o');
 if (defined $order) {
 	if ($order =~ m/[^0-9a-zA-Z_]/) {
 		undef $order;
@@ -86,7 +85,7 @@ if (defined $order) {
 	}
 }
 
-my $project = $cgi->param('p');
+our $project = $cgi->param('p');
 if (defined $project) {
 	$project = validate_input($project);
 	if (!defined($project)) {
@@ -108,7 +107,7 @@ if (defined $project) {
 	exit;
 }
 
-my $file_name = $cgi->param('f');
+our $file_name = $cgi->param('f');
 if (defined $file_name) {
 	$file_name = validate_input($file_name);
 	if (!defined($file_name)) {
@@ -116,7 +115,7 @@ if (defined $file_name) {
 	}
 }
 
-my $hash = $cgi->param('h');
+our $hash = $cgi->param('h');
 if (defined $hash) {
 	$hash = validate_input($hash);
 	if (!defined($hash)) {
@@ -124,7 +123,7 @@ if (defined $hash) {
 	}
 }
 
-my $hash_parent = $cgi->param('hp');
+our $hash_parent = $cgi->param('hp');
 if (defined $hash_parent) {
 	$hash_parent = validate_input($hash_parent);
 	if (!defined($hash_parent)) {
@@ -132,7 +131,7 @@ if (defined $hash_parent) {
 	}
 }
 
-my $hash_base = $cgi->param('hb');
+our $hash_base = $cgi->param('hb');
 if (defined $hash_base) {
 	$hash_base = validate_input($hash_base);
 	if (!defined($hash_base)) {
@@ -140,7 +139,7 @@ if (defined $hash_base) {
 	}
 }
 
-my $page = $cgi->param('pg');
+our $page = $cgi->param('pg');
 if (defined $page) {
 	if ($page =~ m/[^0-9]$/) {
 		undef $page;
@@ -148,7 +147,7 @@ if (defined $page) {
 	}
 }
 
-my $searchtext = $cgi->param('s');
+our $searchtext = $cgi->param('s');
 if (defined $searchtext) {
 	if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
 		undef $searchtext;
-- 
1.4.0
