From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 02/12] git-remote-mediawiki: test environment of git-remote-mediawiki
Date: Fri,  6 Jul 2012 12:03:05 +0200
Message-ID: <1341568995-12467-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhatl9t4a.fsf@bauges.imag.fr>
 <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 12:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn5O3-0005s3-AN
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 12:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538Ab2GFKDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 06:03:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51830 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab2GFKDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 06:03:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q66A2O55022056
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2012 12:02:24 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5Np-0003Qc-PG; Fri, 06 Jul 2012 12:03:29 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5Np-0003H9-Na; Fri, 06 Jul 2012 12:03:29 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Jul 2012 12:02:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q66A2O55022056
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342173745.95951@k4lsUyTAPNrkY0ZjWfZKJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201097>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

In order to test git-remote-mediawiki, a set of functions is needed to
manage a MediaWiki: edit a page, remove a page, fetch a page, fetch all
pages on a given wiki.

A few helper function are also provided to check the content of
directories.

In addition, this patch provides Makefiles to execute tests.
See the README file for more details.

Signed-off-by: Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/Makefile            |  47 ++++++++
 contrib/mw-to-git/t/.gitignore        |   2 +
 contrib/mw-to-git/t/Makefile          |  31 +++++
 contrib/mw-to-git/t/README            | 124 ++++++++++++++++++++
 contrib/mw-to-git/t/test-gitmw-lib.sh | 143 +++++++++++++++++++++++
 contrib/mw-to-git/t/test-gitmw.pl     | 209 ++++++++++++++++++++++++++++++++++
 6 files changed, 556 insertions(+)
 create mode 100644 contrib/mw-to-git/Makefile
 create mode 100644 contrib/mw-to-git/t/Makefile
 create mode 100644 contrib/mw-to-git/t/README
 create mode 100755 contrib/mw-to-git/t/test-gitmw.pl

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
new file mode 100644
index 0000000..3ed728b
--- /dev/null
+++ b/contrib/mw-to-git/Makefile
@@ -0,0 +1,47 @@
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#
+## Build git-remote-mediawiki
+
+-include ../../config.mak.autogen
+-include ../../config.mak
+
+ifndef PERL_PATH
+	PERL_PATH = /usr/bin/perl
+endif
+ifndef gitexecdir
+	gitexecdir = $(shell git --exec-path)
+endif
+
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+SCRIPT = git-remote-mediawiki
+
+.PHONY: install help doc test clean
+
+help:
+	@echo 'This is the help target of the Makefile. Current configuration:'
+	@echo '  gitexecdir = $(gitexecdir_SQ)'
+	@echo '  PERL_PATH = $(PERL_PATH_SQ)'
+	@echo 'Run "$(MAKE) install" to install $(SCRIPT) in gitexecdir'
+	@echo 'Run "$(MAKE) test" to run the testsuite'
+
+install:
+	sed -e '1s|#!.*/perl|#!$(PERL_PATH_SQ)|' $(SCRIPT) \
+		> '$(gitexecdir_SQ)/$(SCRIPT)'
+	chmod +x '$(gitexecdir)/$(SCRIPT)'
+
+doc:
+	@echo 'Sorry, "make doc" is not implemented yet for $(SCRIPT)'
+
+test:
+	$(MAKE) -C t/ test
+
+clean:
+	$(RM) '$(gitexecdir)/$(SCRIPT)'
+	$(MAKE) -C t/ clean
diff --git a/contrib/mw-to-git/t/.gitignore b/contrib/mw-to-git/t/.gitignore
index a060414..a7a40b4 100644
--- a/contrib/mw-to-git/t/.gitignore
+++ b/contrib/mw-to-git/t/.gitignore
@@ -1,2 +1,4 @@
 WEB/
 wiki/
+trash directory.t*/
+test-results/
diff --git a/contrib/mw-to-git/t/Makefile b/contrib/mw-to-git/t/Makefile
new file mode 100644
index 0000000..f422203
--- /dev/null
+++ b/contrib/mw-to-git/t/Makefile
@@ -0,0 +1,31 @@
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#
+## Test git-remote-mediawiki
+
+all: test
+
+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
+T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
+
+.PHONY: help test clean all
+
+help:
+	@echo 'Run "$(MAKE) test" to launch test scripts'
+	@echo 'Run "$(MAKE) clean" to remove trash folders'
+
+test:
+	@for t in $(T); do \
+		echo "$$t"; \
+		"./$$t" || exit 1; \
+	done
+
+clean:
+	$(RM) -r 'trash directory'.*
diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
new file mode 100644
index 0000000..96e9739
--- /dev/null
+++ b/contrib/mw-to-git/t/README
@@ -0,0 +1,124 @@
+Tests for Mediawiki-to-Git
+==========================
+
+Introduction
+------------
+This manual describes how to install the git-remote-mediawiki test
+environment on a machine with git installed on it.
+
+Prerequisite
+------------
+
+In order to run this test environment correctly, you will need to
+install the following packages (Debian/Ubuntu names, may need to be
+adapted for another distribution):
+
+* lighttpd
+* php5
+* php5-cgi
+* php5-cli
+* php5-curl
+* php5-sqlite
+
+Principles and Technical Choices
+--------------------------------
+
+The test environment makes it easy to install and manipulate one or
+several MediaWiki instances. To allow developers to run the testsuite
+easily, the environment does not require root priviledge (except to
+install the required packages if needed). It starts a webserver
+instance on the user's account (using lighttpd greatly helps for
+that), and does not need a separate database daemon (thanks to the use
+of sqlite).
+
+Run the test environment
+------------------------
+
+Install a new wiki
+~~~~~~~~~~~~~~~~~~
+
+Once you have all the prerequisite, you need to install a MediaWiki
+instance on your machine. If you already have one, it is still
+strongly recommended to install one with the script provided. Here's
+how to work it:
+
+a. change directory to contrib/mw-to-git/t/
+b. if needed, edit test.config to choose your installation parameters
+c. run `./install-wiki.sh install`
+d. check on your favourite web browser if your wiki is correctly
+   installed.
+
+Remove an existing wiki
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Edit the file test.config to fit the wiki you want to delete, and then
+execute the command `./install-wiki.sh delete` from the
+contrib/mw-to-git/t directory.
+
+Run the existing tests
+~~~~~~~~~~~~~~~~~~~~~~
+
+The provided tests are currently in the `contrib/mw-to-git/t` directory.
+The files are all the t936[0-9]-*.sh shell scripts.
+
+a. Run all tests:
+To do so, run "make test" from the contrib/mw-to-git/ directory.
+
+b. Run a specific test:
+To run a given test <test_name>, run ./<test_name> from the
+contrib/mw-to-git/t directory.
+
+How to create new tests
+-----------------------
+
+Available functions
+~~~~~~~~~~~~~~~~~~~
+
+The test environment of git-remote-mediawiki provides some functions
+useful to test its behaviour. for more details about the functions'
+parameters, please refer to the `test-gitmw-lib.sh` and
+`test-gitmw.pl` files.
+
+** `test_check_wiki_precond`:
+Check if the tests must be skipped or not. Please use this function
+at the beggining of each new test file.
+
+** `wiki_getpage`:
+Fetch a given page from the wiki and puts its content in the
+directory in parameter.
+
+** `wiki_delete_page`:
+Delete a given page from the wiki.
+
+** `wiki_edit_page`:
+Create or modify a given page in the wiki. You can specify several
+parameters like a summary for the page edition, or add the page to a
+given category.
+See test-gitmw.pl for more details.
+
+** `wiki_getallpage`:
+Fetch all pages from the wiki into a given directory. The directory
+is created if it does not exists.
+
+** `test_diff_directories`:
+Compare the content of two directories. The content must be the same.
+Use this function to compare the content of a git directory and a wiki
+one created by wiki_getallpage.
+
+** `test_contains_N_files`:
+Check if the given directory contains a given number of file.
+
+** `wiki_page_exists`:
+Tests if a given page exists on the wiki.
+
+** `wiki_reset`:
+Reset the wiki, i.e. flush the database. Use this function at the
+begining of each new test, except if the test re-uses the same wiki
+(and history) as the previous test.
+
+How to write a new test
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Please, follow the standards given by git. See git/t/README.
+New file should be named as t936[0-9]-*.sh.
+Be sure to reset your wiki regulary with the function `wiki_reset`.
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index 47341f7..14f6577 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -13,6 +13,7 @@
 
 . ./test.config
 
+WIKI_URL=http://"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"
 CURR_DIR=$(pwd)
 TEST_OUTPUT_DIRECTORY=$(pwd)
 TEST_DIRECTORY="$CURR_DIR"/../../../t
@@ -25,6 +26,148 @@ else
 	WIKI_DIR_INST="$CURR_DIR/$WEB_WWW"
 fi
 
+
+wiki_getpage () {
+	"$CURR_DIR"/test-gitmw.pl get_page "$@"
+}
+
+wiki_delete_page () {
+	"$CURR_DIR"/test-gitmw.pl delete_page "$@"
+}
+
+wiki_editpage () {
+	"$CURR_DIR"/test-gitmw.pl edit_page "$@"
+}
+
+die () {
+	die_with_status 1 "$@"
+}
+
+die_with_status () {
+	status=$1
+	shift
+	echo >&2 "$*"
+	exit "$status"
+}
+
+
+# Check the preconditions to run git-remote-mediawiki's tests
+test_check_precond () {
+	if ! test_have_prereq PERL
+	then
+		skip_all='skipping gateway git-mw tests, perl not available'
+		test_done
+	fi
+
+	if [ ! -f "$GIT_BUILD_DIR"/git-remote-mediawiki ];
+	then
+		echo "No remote mediawiki for git found. Copying it in git"
+		echo "cp $GIT_BUILD_DIR/contrib/mw-to-git/git-remote-mediawiki $GIT_BUILD_DIR/"
+		ln -s "$GIT_BUILD_DIR"/contrib/mw-to-git/git-remote-mediawiki "$GIT_BUILD_DIR"
+	fi
+
+	if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ];
+	then
+		skip_all='skipping gateway git-mw tests, no mediawiki found'
+		test_done
+	fi
+}
+
+# test_diff_directories <dir_git> <dir_wiki>
+#
+# Compare the contents of directories <dir_git> and <dir_wiki> with diff
+# and errors if they do not match. The program will
+# not look into .git in the process.
+# Warning: the first argument MUST be the directory containing the git data
+test_diff_directories () {
+	rm -rf "$1_tmp"
+	mkdir -p "$1_tmp"
+	cp "$1"/*.mw "$1_tmp"
+	diff -r -b "$1_tmp" "$2"
+}
+
+# $1=<dir>
+# $2=<N>
+#
+# Check that <dir> contains exactly <N> files
+test_contains_N_files () {
+	if test `ls -- "$1" | wc -l` -ne "$2"; then
+		echo "directory $1 sould contain $2 files"
+		echo "it contains these files:"
+		ls "$1"
+		false
+	fi
+}
+
+
+# wiki_check_content <file_name> <page_name>
+#
+# Compares the contents of the file <file_name> and the wiki page
+# <page_name> and exits with error 1 if they do not match.
+wiki_check_content () {
+	mkdir -p wiki_tmp
+	wiki_getpage "$2" wiki_tmp
+	# replacement of forbidden character in file name
+	page_name=$(printf "%s\n" "$2" | sed -e "s/\//%2F/g")
+
+	diff -b "$1" wiki_tmp/"$page_name".mw
+	if test $? -ne 0
+	then
+		rm -rf wiki_tmp
+		error "ERROR: file $2 not found on wiki"
+	fi
+	rm -rf wiki_tmp
+}
+
+# wiki_page_exist <page_name>
+#
+# Check the existence of the page <page_name> on the wiki and exits
+# with error if it is absent from it.
+wiki_page_exist () {
+	mkdir -p wiki_tmp
+	wiki_getpage "$1" wiki_tmp
+	page_name=$(printf "%s\n" "$1" | sed "s/\//%2F/g")
+	if test -f wiki_tmp/"$page_name".mw ; then
+		rm -rf wiki_tmp
+	else
+		rm -rf wiki_tmp
+		error "test failed: file $1 not found on wiki"
+	fi
+}
+
+# wiki_getallpagename
+#
+# Fetch the name of each page on the wiki.
+wiki_getallpagename () {
+	"$CURR_DIR"/test-gitmw.pl getallpagename
+}
+
+# wiki_getallpagecategory <category>
+#
+# Fetch the name of each page belonging to <category> on the wiki.
+wiki_getallpagecategory () {
+	"$CURR_DIR"/test-gitmw.pl getallpagename "$@"
+}
+
+# wiki_getallpage <dest_dir> [<category>]
+#
+# Fetch all the pages from the wiki and place them in the directory
+# <dest_dir>.
+# If <category> is define, then wiki_getallpage fetch the pages included
+# in <category>.
+wiki_getallpage () {
+	if test -z "$2";
+	then
+		wiki_getallpagename
+	else
+		wiki_getallpagecategory "$2"
+	fi
+	mkdir -p "$1"
+	while read -r line; do
+		wiki_getpage "$line" $1;
+	done < all.txt
+}
+
 # ================= Install part =================
 
 error () {
diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-gitmw.pl
new file mode 100755
index 0000000..b0117e2
--- /dev/null
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -0,0 +1,209 @@
+#!/usr/bin/perl -w -s
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+# License: GPL v2 or later
+
+# Usage:
+#       ./test-gitmw.pl <command> [argument]*
+# Execute in terminal using the name of the function to call as first
+# parameter, and the function's arguments as following parameters
+#
+# Example:
+#     ./test-gitmw.pl "get_page" foo .
+# will call <wiki_getpage> with arguments <foo> and <.>
+#
+# Available functions are:
+#     "get_page"
+#     "delete_page"
+#     "edit_page"
+#     "getallpagename"
+
+use MediaWiki::API;
+use Getopt::Long;
+use encoding 'utf8';
+use DateTime::Format::ISO8601;
+use open ':encoding(utf8)';
+use constant SLASH_REPLACEMENT => "%2F";
+
+#Parsing of the config file
+
+my $configfile = "$ENV{'CURR_DIR'}/test.config";
+my %config;
+open my $CONFIG, "<",  $configfile or die "can't open $configfile: $!";
+while (<$CONFIG>)
+{
+	chomp;
+	s/#.*//;
+	s/^\s+//;
+	s/\s+$//;
+	next unless length;
+	my ($key, $value) = split (/\s*=\s*/,$_, 2);
+	$config{$key} = $value;
+	last if ($key eq 'LIGHTTPD' and $value eq 'false');
+	last if ($key eq 'PORT');
+}
+close $CONFIG or die "can't close $configfile: $!";
+
+my $wiki_address = "http://$config{'SERVER_ADDR'}".":"."$config{'PORT'}";
+my $wiki_url = "$wiki_address/$config{'WIKI_DIR_NAME'}/api.php";
+my $wiki_admin = "$config{'WIKI_ADMIN'}";
+my $wiki_admin_pass = "$config{'WIKI_PASSW'}";
+my $mw = MediaWiki::API->new;
+$mw->{config}->{api_url} = $wiki_url;
+
+
+# wiki_login <name> <password>
+#
+# Logs the user with <name> and <password> in the global variable
+# of the mediawiki $mw
+sub wiki_login {
+	$mw->login( { lgname => "$_[0]",lgpassword => "$_[1]" } )
+	|| die "getpage: login failed";
+}
+
+# wiki_getpage <wiki_page> <dest_path>
+#
+# fetch a page <wiki_page> from the wiki referenced in the global variable
+# $mw and copies its content in directory dest_path
+sub wiki_getpage {
+	my $pagename = $_[0];
+	my $destdir = $_[1];
+
+	my $page = $mw->get_page( { title => $pagename } );
+	if (!defined($page)) {
+		die "getpage: wiki does not exist";
+	}
+
+	my $content = $page->{'*'};
+	if (!defined($content)) {
+		die "getpage: page does not exist";
+	}
+
+	$pagename=$page->{'title'};
+	# Replace spaces by underscore in the page name
+	$pagename =~ s/ /_/g;
+	$pagename =~ s/\//%2F/g;
+	open(my $file, ">$destdir/$pagename.mw");
+	print $file "$content";
+	close ($file);
+
+}
+
+# wiki_delete_page <page_name>
+#
+# delete the page with name <page_name> from the wiki referenced
+# in the global variable $mw
+sub wiki_delete_page {
+	my $pagename = $_[0];
+
+	my $exist=$mw->get_page({title => $pagename});
+
+	if (defined($exist->{'*'})){
+		$mw->edit({ action => 'delete',
+				title => $pagename})
+		|| die $mw->{error}->{code} . ": " . $mw->{error}->{details};
+	} else {
+		die "no page with such name found: $pagename\n";
+	}
+}
+
+# wiki_editpage <wiki_page> <wiki_content> <wiki_append> [-c=<category>] [-s=<summary>]
+#
+# Edit a page named <wiki_page> with content <wiki_content> on the wiki
+# referenced with the global variable $mw
+# If <wiki_append> == true : append <wiki_content> at the end of the actual
+# content of the page <wiki_page>
+# If <wik_page> doesn't exist, that page is created with the <wiki_content>
+sub wiki_editpage {
+	my $wiki_page = $_[0];
+	my $wiki_content = $_[1];
+	my $wiki_append = $_[2];
+	my $summary = "";
+	my ($summ, $cat) = ();
+	GetOptions('s=s' => \$summ, 'c=s' => \$cat);
+
+	my $append = 0;
+	if (defined($wiki_append) && $wiki_append eq 'true') {
+		$append=1;
+	}
+
+	my $previous_text ="";
+
+	if ($append) {
+		my $ref = $mw->get_page( { title => $wiki_page } );
+		$previous_text = $ref->{'*'};
+	}
+
+	my $text = $wiki_content;
+	if (defined($previous_text)) {
+		$text="$previous_text$text";
+	}
+
+	# Eventually, add this page to a category.
+	if (defined($cat)) {
+		my $category_name="[[Category:$cat]]";
+		$text="$text\n $category_name";
+	}
+	if(defined($summ)){
+		$summary=$summ;
+	}
+
+	$mw->edit( { action => 'edit', title => $wiki_page, summary => $summary, text => "$text"} );
+}
+
+# wiki_getallpagename [<category>]
+#
+# Fetch all pages of the wiki referenced by the global variable $mw
+# and print the names of each one in the file all.txt with a new line
+# ("\n") between these.
+# If the argument <category> is defined, then this function get only the pages
+# belonging to <category>.
+sub wiki_getallpagename {
+	# fetch the pages of the wiki
+	if (defined($_[0])) {
+		my $mw_pages = $mw->list ( { action => 'query',
+				list => 'categorymembers',
+				cmtitle => "Category:$_[0]",
+				cmnamespace => 0,
+				cmlimit => 500 },
+		)
+		|| die $mw->{error}->{code}.": ".$mw->{error}->{details};
+		open(my $file, ">all.txt");
+		foreach my $page (@{$mw_pages}) {
+			print $file "$page->{title}\n";
+		}
+		close ($file);
+
+	} else {
+		my $mw_pages = $mw->list({
+				action => 'query',
+				list => 'allpages',
+				aplimit => 500,
+			})
+		|| die $mw->{error}->{code}.": ".$mw->{error}->{details};
+		open(my $file, ">all.txt");
+		foreach my $page (@{$mw_pages}) {
+			print $file "$page->{title}\n";
+		}
+		close ($file);
+	}
+}
+
+# Main part of this script: parse the command line arguments
+# and select which function to execute
+my $fct_to_call = shift;
+
+wiki_login($wiki_admin, $wiki_admin_pass);
+
+my %functions_to_call = qw(
+	get_page       wiki_getpage
+	delete_page    wiki_delete_page
+	edit_page      wiki_editpage
+	getallpagename wiki_getallpagename
+);
+die "$0 ERROR: wrong argument" unless exists $functions_to_call{$fct_to_call};
+&{$functions_to_call{$fct_to_call}}(@ARGV);
-- 
1.7.11.1.147.g47a574d
