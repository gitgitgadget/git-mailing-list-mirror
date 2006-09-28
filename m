From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: "alternate" starts with shade (i.e. 1)
Date: Thu, 28 Sep 2006 16:47:50 -0700 (PDT)
Message-ID: <20060928234750.47448.qmail@web31802.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1281253118-1159487270=:46000"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 01:48:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5bi-0005CP-GR
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWI1Xrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbWI1Xrz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:47:55 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:44153 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750927AbWI1Xry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:47:54 -0400
Received: (qmail 47450 invoked by uid 60001); 28 Sep 2006 23:47:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DwVQjix7vOB3pexrMA/tiitPYBppiRMDT8kbWdrkaAqgHAsSIjWG6HfliR5SgU/mFR06Q08343soBaMN/YdAtUKstwpH3NqyaF32DvpxM2WRs0OQxqUNs1OMAqe2cE2qiEnBROFLHvHvpIsJuErS5NlLww/i5FdfanVgCpcRS2I=  ;
Received: from [64.215.88.90] by web31802.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 16:47:50 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28068>

--0-1281253118-1159487270=:46000
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

When displaying a list of rows (difftree, shortlog, etc),
the first entry is now printed shaded, i.e. alternate is
initialized to 1, as opposed to non-shaded (alternate
initialized to 0).

This solves the problem when there is only one row to
display -- it is displayed shaded to visually indicate that
it is "active", part of a "list", etc.

(Compare this to the trivial case of more than one entry,
where the rows have alternating shade, thus suggesting
being part of a "list" of "active" entries, etc.)

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)
--0-1281253118-1159487270=:46000
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index afffbbe..79c8052 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1699,7 +1699,7 @@ sub git_difftree_body {
 	print "</div>\n";
 
 	print "<table class=\"diff_tree\">\n";
-	my $alternate = 0;
+	my $alternate = 1;
 	my $patchno = 0;
 	foreach my $line (@{$difftree}) {
 		my %diff = parse_difftree_raw_line($line);
@@ -1993,7 +1993,7 @@ sub git_shortlog_body {
 	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
 
 	print "<table class=\"shortlog\" cellspacing=\"0\">\n";
-	my $alternate = 0;
+	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $commit = $revlist->[$i];
 		#my $ref = defined $refs ? format_ref_marker($refs, $commit) : '';
@@ -2035,7 +2035,7 @@ sub git_history_body {
 	$to = $#{$revlist} unless (defined $to && $to <= $#{$revlist});
 
 	print "<table class=\"history\" cellspacing=\"0\">\n";
-	my $alternate = 0;
+	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		if ($revlist->[$i] !~ m/^([0-9a-fA-F]{40})/) {
 			next;
@@ -2099,7 +2099,7 @@ sub git_tags_body {
 	$to = $#{$taglist} if (!defined $to || $#{$taglist} < $to);
 
 	print "<table class=\"tags\" cellspacing=\"0\">\n";
-	my $alternate = 0;
+	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $taglist->[$i];
 		my %tag = %$entry;
@@ -2159,7 +2159,7 @@ sub git_heads_body {
 	$to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
 
 	print "<table class=\"heads\" cellspacing=\"0\">\n";
-	my $alternate = 0;
+	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $headlist->[$i];
 		my %tag = %$entry;
@@ -2275,7 +2275,7 @@ sub git_project_list {
 	}
 	print "<th></th>\n" .
 	      "</tr>\n";
-	my $alternate = 0;
+	my $alternate = 1;
 	foreach my $pr (@projects) {
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
@@ -2793,7 +2793,7 @@ sub git_tree {
 	git_print_page_path($file_name, 'tree', $hash_base);
 	print "<div class=\"page_body\">\n";
 	print "<table cellspacing=\"0\">\n";
-	my $alternate = 0;
+	my $alternate = 1;
 	foreach my $line (@entries) {
 		my %t = parse_ls_tree_line($line, -z => 1);
 
@@ -3389,7 +3389,7 @@ sub git_search {
 	git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
 	print "<table cellspacing=\"0\">\n";
-	my $alternate = 0;
+	my $alternate = 1;
 	if ($commit_search) {
 		$/ = "\0";
 		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", $hash or next;
-- 
1.4.2.1.g05f0f


--0-1281253118-1159487270=:46000--
