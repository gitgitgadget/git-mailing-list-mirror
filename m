From: Lea Wiemann <lewiemann@gmail.com>
Subject: [WIP/PATCH v3] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Fri, 20 Jun 2008 05:18:31 +0200
Message-ID: <1213931911-15860-1-git-send-email-LeWiemann@gmail.com>
References: <1213487844-685-1-git-send-email-LeWiemann@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 05:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9XA2-0003xt-6A
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 05:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbYFTDSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 23:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbYFTDSd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 23:18:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:30771 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbYFTDSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 23:18:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so551692fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 20:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=sbTTkU2O+UwCk1Q0B3fw2EBntwrVH4hnx+46UPHIimw=;
        b=aW+Y+zwytfVtqiGwMlrSwui1aw0zFMatX5OuIWJy+N7NhzPCWsQsHQM4yRa2Em2ltQ
         XxEEx/rsLntBW4bD59Db5jFnOeFQ1k0gQU6Ov1n6+oR9CBSKeYuI4L+9li6q+YwwZkvz
         1+8Hijwg4Pm2Ji2TqQkHYD3E9mfL9I9GPYM48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=d6JZHPivB8WRSq97stojXSj2X7fV1/2CcoCeDF6IkZI7vdcCVlHMvv/IbdVWKvw6CK
         tuJt457Mo0vu3Y35+GaDUSnpr+vG/TjYiboyaFg2FE5zWIDspQvwxtePNrMi1Y5j0xQ2
         PNfHQ8GLDxUH4Y5401KcD883dNeZElgBdy3j4=
Received: by 10.86.59.18 with SMTP id h18mr3228195fga.30.1213931909089;
        Thu, 19 Jun 2008 20:18:29 -0700 (PDT)
Received: from fly ( [91.33.204.94])
        by mx.google.com with ESMTPS id 12sm2627974fgg.0.2008.06.19.20.18.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 20:18:27 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K9X8x-00048F-CG; Fri, 20 Jun 2008 05:18:31 +0200
X-Mailer: git-send-email 1.5.6.32.gad63a.dirty
In-Reply-To: <1213487844-685-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85594>

From: Jakub Narebski <jnareb@gmail.com>

This test uses Test::WWW::Mechanize::CGI to check gitweb's output.  It
also uses HTML::Lint (if present) to validate the HTML.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
I haven't gotten around to merging Jakub's recent XML validation patch
yet, but I think it'd be good to have some review now; I'll merge it
tomorrow and send another patch.

Changes since v2:

t9503-gitweb-Mechanize.sh has stayed the same, but t9503/test.pl has
been overhauled: extracted common code into helper functions, only
validate if --long-tests if given, added link-checking with
--long-tests, added some minor tests for page contents, and added
tests for the summary page at the bottom.

This runs on top of the *next* branch plus the following patches:

[PATCH] gitweb: respect $GITPERLLIB
    http://article.gmane.org/gmane.comp.version-control.git/85586/raw
[PATCH 1/2 v3] t/test-lib.sh: add test_external and test_external_without_stderr
    http://article.gmane.org/gmane.comp.version-control.git/85504/raw
[PATCH v3] gitweb: standarize HTTP status codes
    http://article.gmane.org/gmane.comp.version-control.git/85522/raw

(The latter two patches might be in next already by the time you're
reading this.)


 t/t9503-gitweb-Mechanize.sh |  128 +++++++++++++++++++++++++++++++++++++++++++
 t/t9503/test.pl             |  128 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 256 insertions(+), 0 deletions(-)
 create mode 100755 t/t9503-gitweb-Mechanize.sh
 create mode 100755 t/t9503/test.pl

diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
new file mode 100755
index 0000000..abcf987
--- /dev/null
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Jakub Narebski
+# Copyright (c) 2008 Lea Wiemann
+#
+
+test_description='gitweb as CGI (using WWW::Mechanize)
+
+This test uses Perl module Test::WWW::Mechanize::CGI to
+check gitweb output, using HTML::Lint to validate HTML.'
+
+# helper functions
+
+safe_chmod () {
+	chmod "$1" "$2" &&
+	if [ "$(git config --get core.filemode)" = false ]
+	then
+		git update-index --chmod="$1" "$2"
+	fi
+}
+
+. ./test-lib.sh
+
+# check if test can be run
+perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+	test_expect_success \
+		'skipping gitweb tests, perl version is too old' :
+	test_done
+	exit
+}
+
+perl -MTest::WWW::Mechanize::CGI -e '' >/dev/null 2>&1 || {
+	test_expect_success \
+		'skipping gitweb tests, Test::WWW::Mechanize::CGI not found' :
+	test_done
+	exit
+}
+
+# set up test repository
+test_expect_success 'set up test repository' '
+
+	echo "Not an empty file." > file &&
+	git add file &&
+	test_tick && git commit -a -m "Initial commit." &&
+	git branch b &&
+
+	echo "New file" > new_file &&
+	git add new_file &&
+	test_tick && git commit -a -m "File added." &&
+
+	safe_chmod +x new_file &&
+	test_tick && git commit -a -m "Mode changed." &&
+
+	git mv new_file renamed_file &&
+	test_tick && git commit -a -m "File renamed." &&
+
+	rm renamed_file &&
+	ln -s file renamed_file &&
+	test_tick && git commit -a -m "File to symlink." &&
+	git tag with-symlink &&
+
+	git rm renamed_file &&
+	rm -f renamed_file &&
+	test_tick && git commit -a -m "File removed." &&
+
+	cp file file2 &&
+	git add file2 &&
+	test_tick && git commit -a -m "File copied." &&
+
+	echo "New line" >> file2 &&
+	safe_chmod +x file2 &&
+	test_tick && git commit -a -m "Mode change and modification." &&
+
+	git checkout b &&
+	echo "Branch" >> b &&
+	git add b &&
+	test_tick && git commit -a -m "On branch" &&
+	git checkout master &&
+	test_tick && git pull . b
+'
+
+# set up empty repository
+# TODO!
+
+# set up repositories for gitweb
+# TODO!
+
+# set up gitweb configuration
+safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
+cat >gitweb_config.perl <<EOF
+#!/usr/bin/perl
+
+# gitweb configuration for tests
+
+our \$version = "current";
+our \$GIT = "$GIT_EXEC_PATH/git";
+our \$projectroot = "$safe_pwd";
+our \$project_maxdepth = 8;
+our \$home_link_str = "projects";
+our \$site_name = "[localhost]";
+our \$site_header = "";
+our \$site_footer = "";
+our \$home_text = "indextext.html";
+our @stylesheets = ("file:///$safe_pwd/../../gitweb/gitweb.css");
+our \$logo = "file:///$safe_pwd/../../gitweb/git-logo.png";
+our \$favicon = "file:///$safe_pwd/../../gitweb/git-favicon.png";
+our \$projects_list = "";
+our \$export_ok = "";
+our \$strict_export = "";
+
+1;
+__END__
+EOF
+
+cat >.git/description <<EOF
+$0 test repository
+EOF
+
+GITWEB_CONFIG="$(pwd)/gitweb_config.perl"
+export GITWEB_CONFIG
+
+# run tests
+
+test_external \
+	'test gitweb output' \
+	perl ../t9503/test.pl
+
+test_done
diff --git a/t/t9503/test.pl b/t/t9503/test.pl
new file mode 100755
index 0000000..3d72575
--- /dev/null
+++ b/t/t9503/test.pl
@@ -0,0 +1,128 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Cwd qw(abs_path);
+use File::Spec;
+
+# We don't count properly when skipping, so no_plan is necessary.
+use Test::More qw(no_plan);
+use Test::WWW::Mechanize::CGI;
+
+my $long_tests = $ENV{GIT_TEST_LONG};
+
+eval { require HTML::Lint };
+my $use_lint = !$@;
+diag('HTML::Lint is not installed; no HTML validation tests')
+    unless $use_lint;
+
+my @revisions = map { substr $_, 0, 10 } split /\s/, `git-rev-list --first-parent HEAD`;
+my $head = $revisions[-1];
+
+my $gitweb = File::Spec->catfile('..','..','gitweb','gitweb.cgi');
+# the followin two lines of code are workaround for bug in
+# Test::WWW::Mechanize::CGI::cgi_application version up to 0.3
+# (http://rt.cpan.org/Ticket/Display.html?id=36654)
+# for pathnames with spaces (because of "trash directory")
+$gitweb = File::Spec->rel2abs($gitweb);
+$gitweb = Cwd::abs_path($gitweb);
+
+my $mech = new Test::WWW::Mechanize::CGI;
+$mech->cgi_application($gitweb);
+# On some systems(?) it's necessary to have %ENV here, otherwise the
+# CGI process won't get *any* of the current environment variables
+# (not even PATH, etc.)
+$mech->env(%ENV, GITWEB_CONFIG => $ENV{'GITWEB_CONFIG'}, $mech->env);
+
+# import config, predeclaring config variables
+our $site_name = '';
+require_ok($ENV{'GITWEB_CONFIG'})
+	or diag('Could not load gitweb config; some tests would fail');
+
+our %checked_pages;
+# Validate and spider the current page, if --long-tests (-l) is given.
+sub check_page {
+	my $uri = $mech->uri;
+	if (not $checked_pages{$uri}) {
+		$mech->html_lint_ok('validate') or return 0 if $long_tests && $use_lint;
+		$mech->page_links_ok("check links on $uri") if $long_tests;
+		$checked_pages{$uri} = 1;
+	}
+	return 1
+}
+
+our $baseurl = "http://localhost";
+our($params, $url, $pagedesc, $status);
+
+# test_page ( <params>, <page_description>, <expected_status> )
+# Example:
+# if (test_page '?p=.git;a=summary', 'repository summary') {
+#     $mech->...;
+#     $mech->...;
+# }
+#
+# Test that the page can be opened (and if --long-tests is given that
+# it validates and has valid links), and return true if it does.  Also
+# set the global variables $params, $pagedesc, and $url for use in the
+# if block.  Optionally pass a third parameter $status to test the
+# HTTP status code of the page (useful for error pages).
+sub test_page {
+	($params, $pagedesc, $status) = @_;
+	$url = "$baseurl$params";
+	if($status) {
+		$mech->get($url);
+	} else {
+		$mech->get_ok($url, "GET \"$params\" -- $pagedesc") or return 0;
+	}
+	check_page or return 0;
+	if($status) {
+		return is($mech->status, $status, "GET \"$params\" -- $pagedesc -- yields $status");
+	} else {
+		return 1;
+	}
+}
+
+if (test_page '', 'project list (implicit)') {
+	$mech->title_like(qr!$site_name!,
+		"title contains $site_name");
+	$mech->content_contains('./t9503-gitweb-Mechanize.sh test repository', 
+		'lists test repository (by description)');
+}
+
+# Test repository summary: implicit, implicit with pathinfo, explicit.
+for my $sumparams ('?p=.git', '/.git', '?p=.git;a=summary') {
+	if (test_page $sumparams, 'repository summary') {
+		$mech->title_like(qr!$site_name.*\.git/summary!,
+				  "title contains $site_name and \".git/summary\"");
+	}
+}
+
+# Search form (on summary page).
+$mech->get_ok('?p=.git', 'get repository summary');
+if ($mech->submit_form_ok( { form_number => 1,
+			     fields => { 's' => 'Initial' }
+			   }, "submit search form (default)")) {
+	check_page;
+	$mech->content_contains('Initial commit',
+				'content contains searched commit');
+}
+
+test_page('?p=non-existent.git', 'non-existent project', 404);
+test_page('?p=.git;a=commit;h=non-existent', 'non-existent commit', 404);
+
+# Summary page.
+
+# Check short log.  To do: Extract into separate test_short_log
+# function since the short log occurs on several pages.
+$mech->get_ok('?p=.git', 'get repository summary');
+for my $revision (@revisions[-3..-1]) {
+	for my $link_text qw( commit commitdiff tree snapshot ) {
+		ok( $mech->find_link(url_abs_regex => qr/h=$revision/, text => $link_text), "$link_text link for $revision" );
+	}
+}
+
+
+1;
+__END__
-- 
1.5.6.32.gad63a.dirty
