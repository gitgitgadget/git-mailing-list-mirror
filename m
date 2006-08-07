From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Mon, 7 Aug 2006 16:26:52 +0200
Message-ID: <200608071626.52655.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Aug 07 16:27:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA64I-0003YV-Ut
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 16:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWHGO0y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 10:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWHGO0y
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 10:26:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:480 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750952AbWHGO0x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 10:26:53 -0400
Received: by nf-out-0910.google.com with SMTP id p46so476807nfa
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 07:26:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=qbEAEo7XsAng4tkNVcHFg2C4OAKTw1RrmVzoHt6318368SszNtDgDog7DwA4CbQUSqrwLWE7ThD903VGviOBH5r/Iab1xBQXLTfQ4ILh9vGl3KMAZOlF/d3WiiybOcXSt6p9BUkbRikxmK/Jnl9JUyacGhRESL/IE6zVsty2aXY=
Received: by 10.49.21.8 with SMTP id y8mr8507941nfi;
        Mon, 07 Aug 2006 07:26:51 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id a24sm6063490nfc.2006.08.07.07.26.48;
        Mon, 07 Aug 2006 07:26:51 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25013>

This RFC is about better naming of subroutines in gitweb. The patch was
generated on top of 'next' (7c7e45d0cc0f482aeb19ecb0b56e9e7b65472c56)
using embedded gitweb-rename.sh script.


If one would want to apply patch which was generated without 
"subroutine renaming" on top of branch which includes it, simply
run gitweb-unrename.sh, apply patch, run gitweb-rename.sh, commit.

If one would want to apply patch which was created with new subroutine
names on top of branch which doesn not include "subroutine renaming"
commit, simply run gitweb-rename.sh, apply patch, run gitweb-unrename.sh,
then commit.

And in such a case patch calculus, with non-patch operators like those
scripts, is useful.


How should subroutines be named? Do you agree with proposal, or not?
Is such renaming usefull?

Comments? Thought?

-- >8 -- gitweb-rename.sh --
#/bin/sh

rm -f gitweb.perl.re~
echo "Great subroutine renaming"
perl -s -p -i.re~ \
	-e 's/\bgit_get_referencing\b/format_mark_referencing/;' \
	-e 's/\bgit_read_head\b/git_get_head/;' \
	-e 's/\bread_info_ref\b/git_read_info_refs/;' \
	-e 's/\bdate_str\b/parse_date/;' \
	-e 's/\bgit_read_tag\b/parse_tag/;' \
	-e 's/\bgit_read_commit\b/parse_commit/;' \
	-e 's/\bgit_blob_plain_mimetype\b/blob_plain_mimetype/;' \
	-e 's/\bgit_page_nav\b/git_print_page_nav/;' \
	-e 's/\bgit_header_div\b/git_print_header_div/;' \
	gitweb.perl

# end of gitweb-rename.sh

-- >8 -- gitweb-unrename.sh --
#/bin/sh

rm -f gitweb.perl.un~
echo "Reverting Great subroutine renaming"
perl -s -p -i.un~ \
	-e 's/\bformat_mark_referencing\b/git_get_referencing/;' \
	-e 's/\bgit_get_head\b/git_read_head/;' \
	-e 's/\bgit_read_info_refs\b/read_info_ref/;' \
	-e 's/\bparse_date\b/date_str/;' \
	-e 's/\bparse_tag\b/git_read_tag/;' \
	-e 's/\bparse_commit\b/git_read_commit/;' \
	-e 's/\bblob_plain_mimetype\b/git_blob_plain_mimetype/;' \
	-e 's/\bgit_print_page_nav\b/git_page_nav/;' \
	-e 's/\bgit_print_header_div\b/git_header_div/;' \
	gitweb.perl

# end of gitweb-unrename.sh
+++
From 73aac631709c11d01ac36a1f3f8c8ea3d1591b4d Mon Sep 17 00:00:00 2001
From: Jakub Narebski <jnareb@gmail.com>
Date: Mon, 7 Aug 2006 15:32:07 +0200
Subject: [PATCH] gitweb: Great subroutines renaming

Rename some of subroutines to better reflect what they do.
Some renames were not performed because subroutine name
reflects hash key.

Subroutines name guideline:
* git_ prefix for subroutines related to git commands,
  or to gitweb actions
* git_get_ prefix for subroutines calling git command
  and returning some output
* git_read_ prefix for subroutines directly accessing git
  repository files
* parse_ prefix for subroutines parsing some text, or reading and
  parsing some text into hash or list
* format_ prefix for subroutines formatting/post-processing some
  HTML/text fragment
* _get_ infix for subroutines which return result
* _print_ infix for subroutines which print fragment of output
* _body suffix for subroutines which outputs main part (body)
  of related action
* _nav suffix for subroutines related to navigation bars
* _div suffix for subroutines returning or ptinting div element

Renames:
- git_get_referencing => format_mark_referencing
- git_read_head => git_get_head
- read_info_ref => git_read_info_refs
- date_str => parse_date
- git_read_tag => parse_tag
- git_read_commit => parse_commit
- git_blob_plain_mimetype => blob_plain_mimetype
- git_page_nav => git_print_page_nav
- git_header_div => git_print_header_div

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |  218 ++++++++++++++++++++++++++--------------------------
 1 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b3bfc6b..d8dbd3d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -362,7 +362,7 @@ sub format_log_line_html {
 }
 
 # format marker of refs pointing to given object
-sub git_get_referencing {
+sub format_mark_referencing {
 	my ($refs, $id) = @_;
 
 	if (defined $refs->{$id}) {
@@ -376,7 +376,7 @@ ## -------------------------------------
 ## git utility subroutines, invoking git commands
 
 # get HEAD ref of given project as hash
-sub git_read_head {
+sub git_get_head {
 	my $project = shift;
 	my $oENV = $ENV{'GIT_DIR'};
 	my $retval = undef;
@@ -511,7 +511,7 @@ sub git_read_projects {
 	return @list;
 }
 
-sub read_info_ref {
+sub git_read_info_refs {
 	my $type = shift || "";
 	my %refs;
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
@@ -536,7 +536,7 @@ sub read_info_ref {
 ## ----------------------------------------------------------------------
 ## parse to hash functions
 
-sub date_str {
+sub parse_date {
 	my $epoch = shift;
 	my $tz = shift || "-0000";
 
@@ -561,7 +561,7 @@ sub date_str {
 	return %date;
 }
 
-sub git_read_tag {
+sub parse_tag {
 	my $tag_id = shift;
 	my %tag;
 	my @comment;
@@ -596,7 +596,7 @@ sub git_read_tag {
 	return %tag
 }
 
-sub git_read_commit {
+sub parse_commit {
 	my $commit_id = shift;
 	my $commit_text = shift;
 
@@ -716,10 +716,10 @@ sub git_read_refs {
 		$ref_item{'epoch'} = 0;
 		$ref_item{'age'} = "unknown";
 		if ($type eq "tag") {
-			my %tag = git_read_tag($ref_id);
+			my %tag = parse_tag($ref_id);
 			$ref_item{'comment'} = $tag{'comment'};
 			if ($tag{'type'} eq "commit") {
-				%co = git_read_commit($tag{'object'});
+				%co = parse_commit($tag{'object'});
 				$ref_item{'epoch'} = $co{'committer_epoch'};
 				$ref_item{'age'} = $co{'age_string'};
 			} elsif (defined($tag{'epoch'})) {
@@ -731,7 +731,7 @@ sub git_read_refs {
 			$ref_item{'name'} = $tag{'name'};
 			$ref_item{'refid'} = $tag{'object'};
 		} elsif ($type eq "commit"){
-			%co = git_read_commit($ref_id);
+			%co = parse_commit($ref_id);
 			$ref_item{'reftype'} = "commit";
 			$ref_item{'name'} = $ref_file;
 			$ref_item{'title'} = $co{'title'};
@@ -806,7 +806,7 @@ sub mimetype_guess {
 	return $mime;
 }
 
-sub git_blob_plain_mimetype {
+sub blob_plain_mimetype {
 	my $fd = shift;
 	my $filename = shift;
 
@@ -955,7 +955,7 @@ sub die_error {
 ## ----------------------------------------------------------------------
 ## functions printing or outputting HTML: navigation
 
-sub git_page_nav {
+sub git_print_page_nav {
 	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
 	$extra = '' if !defined $extra; # pager or formats
 
@@ -1022,7 +1022,7 @@ sub git_get_paging_nav {
 ## ......................................................................
 ## functions printing or outputting HTML: div
 
-sub git_header_div {
+sub git_print_header_div {
 	my ($action, $title, $hash, $hash_base) = @_;
 	my $rest = '';
 
@@ -1062,10 +1062,10 @@ sub git_shortlog_body {
 	my $alternate = 0;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $commit = $revlist->[$i];
-		#my $ref = defined $refs ? git_get_referencing($refs, $commit) : '';
-		my $ref = git_get_referencing($refs, $commit);
-		my %co = git_read_commit($commit);
-		my %ad = date_str($co{'author_epoch'});
+		#my $ref = defined $refs ? format_mark_referencing($refs, $commit) : '';
+		my $ref = format_mark_referencing($refs, $commit);
+		my %co = parse_commit($commit);
+		my %ad = parse_date($co{'author_epoch'});
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -1289,12 +1289,12 @@ sub git_project_list {
 		die_error(undef, "No projects found");
 	}
 	foreach my $pr (@list) {
-		my $head = git_read_head($pr->{'path'});
+		my $head = git_get_head($pr->{'path'});
 		if (!defined $head) {
 			next;
 		}
 		$ENV{'GIT_DIR'} = "$projectroot/$pr->{'path'}";
-		my %co = git_read_commit($head);
+		my %co = parse_commit($head);
 		if (!%co) {
 			next;
 		}
@@ -1385,9 +1385,9 @@ sub git_project_list {
 
 sub git_summary {
 	my $descr = git_read_description($project) || "none";
-	my $head = git_read_head($project);
-	my %co = git_read_commit($head);
-	my %cd = date_str($co{'committer_epoch'}, $co{'committer_tz'});
+	my $head = git_get_head($project);
+	my %co = parse_commit($head);
+	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $owner;
 	if (-f $projects_list) {
@@ -1408,9 +1408,9 @@ sub git_summary {
 		$owner = get_file_owner("$projectroot/$project");
 	}
 
-	my $refs = read_info_ref();
+	my $refs = git_read_info_refs();
 	git_header_html();
-	git_page_nav('summary','', $head);
+	git_print_page_nav('summary','', $head);
 
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table cellspacing=\"0\">\n" .
@@ -1419,24 +1419,24 @@ sub git_summary {
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
 
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_read_head($project)
+	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head($project)
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
-	git_header_div('shortlog');
+	git_print_header_div('shortlog');
 	git_shortlog_body(\@revlist, 0, 15, $refs,
 	                  $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "..."));
 
 	my $taglist = git_read_refs("refs/tags");
 	if (defined @$taglist) {
-		git_header_div('tags');
+		git_print_header_div('tags');
 		git_tags_body($taglist, 0, 15,
 		              $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tags")}, "..."));
 	}
 
 	my $headlist = git_read_refs("refs/heads");
 	if (defined @$headlist) {
-		git_header_div('heads');
+		git_print_header_div('heads');
 		git_heads_body($headlist, $head, 0, 15,
 		               $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=heads")}, "..."));
 	}
@@ -1445,11 +1445,11 @@ sub git_summary {
 }
 
 sub git_tag {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	git_header_html();
-	git_page_nav('','', $head,undef,$head);
-	my %tag = git_read_tag($hash);
-	git_header_div('commit', esc_html($tag{'name'}), $hash);
+	git_print_page_nav('','', $head,undef,$head);
+	my %tag = parse_tag($hash);
+	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
 	print "<div class=\"title_text\">\n" .
 	      "<table cellspacing=\"0\">\n" .
 	      "<tr>\n" .
@@ -1458,7 +1458,7 @@ sub git_tag {
 	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'type'};h=$tag{'object'}")}, $tag{'type'}) . "</td>\n" .
 	      "</tr>\n";
 	if (defined($tag{'author'})) {
-		my %ad = date_str($tag{'epoch'}, $tag{'tz'});
+		my %ad = parse_date($tag{'epoch'}, $tag{'tz'});
 		print "<tr><td>author</td><td>" . esc_html($tag{'author'}) . "</td></tr>\n";
 		print "<tr><td></td><td>" . $ad{'rfc2822'} . sprintf(" (%02d:%02d %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'}) . "</td></tr>\n";
 	}
@@ -1478,9 +1478,9 @@ sub git_blame2 {
 	my $ftype;
 	die_error(undef, "Permission denied") if (!git_get_project_config_bool ('blame'));
 	die_error('404 Not Found', "File name not defined") if (!$file_name);
-	$hash_base ||= git_read_head($project);
+	$hash_base ||= git_get_head($project);
 	die_error(undef, "Couldn't find base commit") unless ($hash_base);
-	my %co = git_read_commit($hash_base)
+	my %co = parse_commit($hash_base)
 		or die_error(undef, "Reading commit failed");
 	if (!defined $hash) {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
@@ -1496,8 +1496,8 @@ sub git_blame2 {
 	my $formats_nav =
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
 		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
-	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	git_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype);
 	my @rev_color = (qw(light dark));
 	my $num_colors = scalar(@rev_color);
@@ -1536,9 +1536,9 @@ sub git_blame {
 	my $fd;
 	die_error('403 Permission denied', "Permission denied") if (!git_get_project_config_bool ('blame'));
 	die_error('404 Not Found', "File name not defined") if (!$file_name);
-	$hash_base ||= git_read_head($project);
+	$hash_base ||= git_get_head($project);
 	die_error(undef, "Couldn't find base commit") unless ($hash_base);
-	my %co = git_read_commit($hash_base)
+	my %co = parse_commit($hash_base)
 		or die_error(undef, "Reading commit failed");
 	if (!defined $hash) {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
@@ -1550,8 +1550,8 @@ sub git_blame {
 	my $formats_nav =
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
 		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
-	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	git_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, 'blob');
 	print "<div class=\"page_body\">\n";
 	print <<HTML;
@@ -1619,10 +1619,10 @@ HTML
 }
 
 sub git_tags {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	git_header_html();
-	git_page_nav('','', $head,undef,$head);
-	git_header_div('summary', $project);
+	git_print_page_nav('','', $head,undef,$head);
+	git_print_header_div('summary', $project);
 
 	my $taglist = git_read_refs("refs/tags");
 	if (defined @$taglist) {
@@ -1632,10 +1632,10 @@ sub git_tags {
 }
 
 sub git_heads {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	git_header_html();
-	git_page_nav('','', $head,undef,$head);
-	git_header_div('summary', $project);
+	git_print_page_nav('','', $head,undef,$head);
+	git_print_header_div('summary', $project);
 
 	my $taglist = git_read_refs("refs/heads");
 	my $alternate = 0;
@@ -1648,7 +1648,7 @@ sub git_heads {
 sub git_blob_plain {
 	if (!defined $hash) {
 		if (defined $file_name) {
-			my $base = $hash_base || git_read_head($project);
+			my $base = $hash_base || git_get_head($project);
 			$hash = git_get_hash_by_path($base, $file_name, "blob")
 				or die_error(undef, "Error lookup file");
 		} else {
@@ -1659,7 +1659,7 @@ sub git_blob_plain {
 	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 
-	$type ||= git_blob_plain_mimetype($fd, $file_name);
+	$type ||= blob_plain_mimetype($fd, $file_name);
 
 	# save as filename, even when no $file_name is given
 	my $save_as = "$hash";
@@ -1681,7 +1681,7 @@ sub git_blob_plain {
 sub git_blob {
 	if (!defined $hash) {
 		if (defined $file_name) {
-			my $base = $hash_base || git_read_head($project);
+			my $base = $hash_base || git_get_head($project);
 			$hash = git_get_hash_by_path($base, $file_name, "blob")
 				or die_error(undef, "Error lookup file");
 		} else {
@@ -1691,14 +1691,14 @@ sub git_blob {
 	my $have_blame = git_get_project_config_bool ('blame');
 	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
-	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
+	my $mimetype = blob_plain_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
 		close $fd;
 		return git_blob_plain($mimetype);
 	}
 	git_header_html();
 	my $formats_nav = '';
-	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
+	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		if (defined $file_name) {
 			if ($have_blame) {
 				$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$hash;hb=$hash_base;f=$file_name")}, "blame") . " | ";
@@ -1709,8 +1709,8 @@ sub git_blob {
 		} else {
 			$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain");
 		}
-		git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-		git_header_div('commit', esc_html($co{'title'}), $hash_base);
+		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n" .
 		      "<br/><br/></div>\n" .
@@ -1732,7 +1732,7 @@ sub git_blob {
 
 sub git_tree {
 	if (!defined $hash) {
-		$hash = git_read_head($project);
+		$hash = git_get_head($project);
 		if (defined $file_name) {
 			my $base = $hash_base || $hash;
 			$hash = git_get_hash_by_path($base, $file_name, "tree");
@@ -1748,16 +1748,16 @@ sub git_tree {
 	close $fd or die_error(undef, "Reading tree failed");
 	$/ = "\n";
 
-	my $refs = read_info_ref();
-	my $ref = git_get_referencing($refs, $hash_base);
+	my $refs = git_read_info_refs();
+	my $ref = format_mark_referencing($refs, $hash_base);
 	git_header_html();
 	my $base_key = "";
 	my $base = "";
 	my $have_blame = git_get_project_config_bool ('blame');
-	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
+	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		$base_key = ";hb=$hash_base";
-		git_page_nav('tree','', $hash_base);
-		git_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
+		git_print_page_nav('tree','', $hash_base);
+		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n";
 		print "<br/><br/></div>\n";
@@ -1813,14 +1813,14 @@ sub git_tree {
 }
 
 sub git_log {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	if (!defined $hash) {
 		$hash = $head;
 	}
 	if (!defined $page) {
 		$page = 0;
 	}
-	my $refs = read_info_ref();
+	my $refs = git_read_info_refs();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
@@ -1831,21 +1831,21 @@ sub git_log {
 	my $paging_nav = git_get_paging_nav('log', $hash, $head, $page, $#revlist);
 
 	git_header_html();
-	git_page_nav('log','', $hash,undef,undef, $paging_nav);
+	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
 
 	if (!@revlist) {
-		my %co = git_read_commit($hash);
+		my %co = parse_commit($hash);
 
-		git_header_div('summary', $project);
+		git_print_header_div('summary', $project);
 		print "<div class=\"page_body\"> Last change $co{'age_string'}.<br/><br/></div>\n";
 	}
 	for (my $i = ($page * 100); $i <= $#revlist; $i++) {
 		my $commit = $revlist[$i];
-		my $ref = git_get_referencing($refs, $commit);
-		my %co = git_read_commit($commit);
+		my $ref = format_mark_referencing($refs, $commit);
+		my %co = parse_commit($commit);
 		next if !%co;
-		my %ad = date_str($co{'author_epoch'});
-		git_header_div('commit',
+		my %ad = parse_date($co{'author_epoch'});
+		git_print_header_div('commit',
 									 "<span class=\"age\">$co{'age_string'}</span>" .
 									 esc_html($co{'title'}) . $ref,
 									 $commit);
@@ -1883,12 +1883,12 @@ sub git_log {
 }
 
 sub git_commit {
-	my %co = git_read_commit($hash);
+	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
-	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
-	my %cd = date_str($co{'committer_epoch'}, $co{'committer_tz'});
+	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
+	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $parent = $co{'parent'};
 	if (!defined $parent) {
@@ -1904,22 +1904,22 @@ sub git_commit {
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		$expires = "+1d";
 	}
-	my $refs = read_info_ref();
-	my $ref = git_get_referencing($refs, $co{'id'});
+	my $refs = git_read_info_refs();
+	my $ref = format_mark_referencing($refs, $co{'id'});
 	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
 		$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;hb=$parent;f=$file_name")}, "blame");
 	}
 	git_header_html(undef, $expires);
-	git_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
+	git_print_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
 							 $hash, $co{'tree'}, $hash,
 							 $formats_nav);
 
 	if (defined $co{'parent'}) {
-		git_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
+		git_print_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
 	} else {
-		git_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $hash);
+		git_print_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $hash);
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table cellspacing=\"0\">\n";
@@ -2081,11 +2081,11 @@ sub git_commit {
 sub git_blobdiff {
 	mkdir($git_temp, 0700);
 	git_header_html();
-	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
+	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my $formats_nav =
 			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
-		git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-		git_header_div('commit', esc_html($co{'title'}), $hash_base);
+		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
 		print "<div class=\"page_nav\">\n" .
 		      "<br/><br/></div>\n" .
@@ -2111,7 +2111,7 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	mkdir($git_temp, 0700);
-	my %co = git_read_commit($hash);
+	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
@@ -2128,13 +2128,13 @@ sub git_commitdiff {
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		$expires = "+1d";
 	}
-	my $refs = read_info_ref();
-	my $ref = git_get_referencing($refs, $co{'id'});
+	my $refs = git_read_info_refs();
+	my $ref = format_mark_referencing($refs, $co{'id'});
 	my $formats_nav =
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
 	git_header_html(undef, $expires);
-	git_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
-	git_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
+	git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
+	git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 	print "<div class=\"page_body\">\n";
 	my $comment = $co{'comment'};
 	my $empty = 0;
@@ -2200,7 +2200,7 @@ sub git_commitdiff {
 
 sub git_commitdiff_plain {
 	mkdir($git_temp, 0700);
-	my %co = git_read_commit($hash);
+	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
@@ -2214,7 +2214,7 @@ sub git_commitdiff_plain {
 
 	# try to figure out the next tag after this commit
 	my $tagname;
-	my $refs = read_info_ref("tags");
+	my $refs = git_read_info_refs("tags");
 	open $fd, "-|", $GIT, "rev-list", "HEAD";
 	my @commits = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -2228,7 +2228,7 @@ sub git_commitdiff_plain {
 	}
 
 	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
-	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
+	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 	my $comment = $co{'comment'};
 	print "From: $co{'author'}\n" .
 	      "Date: $ad{'rfc2822'} ($ad{'tz_local'})\n".
@@ -2264,17 +2264,17 @@ sub git_commitdiff_plain {
 
 sub git_history {
 	if (!defined $hash_base) {
-		$hash_base = git_read_head($project);
+		$hash_base = git_get_head($project);
 	}
 	my $ftype;
-	my %co = git_read_commit($hash_base);
+	my %co = parse_commit($hash_base);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
-	my $refs = read_info_ref();
+	my $refs = git_read_info_refs();
 	git_header_html();
-	git_page_nav('','', $hash_base,$co{'tree'},$hash_base);
-	git_header_div('commit', esc_html($co{'title'}), $hash_base);
+	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	if (!defined $hash && defined $file_name) {
 		$hash = git_get_hash_by_path($hash_base, $file_name);
 	}
@@ -2290,11 +2290,11 @@ sub git_history {
 	while (my $line = <$fd>) {
 		if ($line =~ m/^([0-9a-fA-F]{40})/){
 			my $commit = $1;
-			my %co = git_read_commit($commit);
+			my %co = parse_commit($commit);
 			if (!%co) {
 				next;
 			}
-			my $ref = git_get_referencing($refs, $commit);
+			my $ref = format_mark_referencing($refs, $commit);
 			if ($alternate) {
 				print "<tr class=\"dark\">\n";
 			} else {
@@ -2330,9 +2330,9 @@ sub git_search {
 		die_error(undef, "Text field empty");
 	}
 	if (!defined $hash) {
-		$hash = git_read_head($project);
+		$hash = git_get_head($project);
 	}
-	my %co = git_read_commit($hash);
+	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
@@ -2351,8 +2351,8 @@ sub git_search {
 		$pickaxe_search = 1;
 	}
 	git_header_html();
-	git_page_nav('','', $hash,$co{'tree'},$hash);
-	git_header_div('commit', esc_html($co{'title'}), $hash);
+	git_print_page_nav('','', $hash,$co{'tree'},$hash);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
@@ -2370,7 +2370,7 @@ sub git_search {
 				next;
 			}
 			my @commit_lines = split "\n", $commit_text;
-			my %co = git_read_commit(undef, \@commit_lines);
+			my %co = parse_commit(undef, \@commit_lines);
 			if (!%co) {
 				next;
 			}
@@ -2451,7 +2451,7 @@ sub git_search {
 					print "</td>\n" .
 					      "</tr>\n";
 				}
-				%co = git_read_commit($1);
+				%co = parse_commit($1);
 			}
 		}
 		close $fd;
@@ -2461,14 +2461,14 @@ sub git_search {
 }
 
 sub git_shortlog {
-	my $head = git_read_head($project);
+	my $head = git_get_head($project);
 	if (!defined $hash) {
 		$hash = $head;
 	}
 	if (!defined $page) {
 		$page = 0;
 	}
-	my $refs = read_info_ref();
+	my $refs = git_read_info_refs();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
@@ -2486,8 +2486,8 @@ sub git_shortlog {
 
 
 	git_header_html();
-	git_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-	git_header_div('summary', $project);
+	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
+	git_print_header_div('summary', $project);
 
 	git_shortlog_body(\@revlist, ($page * 100), $#revlist, $refs, $next_link);
 
@@ -2499,7 +2499,7 @@ ## feeds (RSS, OPML)
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project)
+	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_get_head($project)
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-rev-list failed");
@@ -2514,12 +2514,12 @@ sub git_rss {
 
 	for (my $i = 0; $i <= $#revlist; $i++) {
 		my $commit = $revlist[$i];
-		my %co = git_read_commit($commit);
+		my %co = parse_commit($commit);
 		# we read 150, we always show 30 and the ones more recent than 48 hours
 		if (($i >= 20) && ((time - $co{'committer_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = date_str($co{'committer_epoch'});
+		my %cd = parse_date($co{'committer_epoch'});
 		open $fd, "-|", $GIT, "diff-tree", '-r', $co{'parent'}, $co{'id'} or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd or next;
@@ -2569,12 +2569,12 @@ sub git_opml {
 
 	foreach my $pr (@list) {
 		my %proj = %$pr;
-		my $head = git_read_head($proj{'path'});
+		my $head = git_get_head($proj{'path'});
 		if (!defined $head) {
 			next;
 		}
 		$ENV{'GIT_DIR'} = "$projectroot/$proj{'path'}";
-		my %co = git_read_commit($head);
+		my %co = parse_commit($head);
 		if (!%co) {
 			next;
 		}
-- 
1.4.1.1
