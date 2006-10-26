X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: Slight visual improvements to commitdiff view
Date: Thu, 26 Oct 2006 18:43:10 +0200
Message-ID: <200610261843.10529.jnareb@gmail.com>
References: <200610261813.12567.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 16:44:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oOLA0JjelA+Y59UMZh6EeV1yjC+QokBtwGSXPQvIzrxF5tq3XhIaO9tlnlAXotiAKjpsAS0Tobq9WLEaxHJAGH7V9P7kxzkiNkMlyyq2dn89zaAKXz5/ABGNMz3ym/BG/9qmdWRVKqbdrsxGy0BLm9RQWHIiu1yDi9IV+uwkHvo=
User-Agent: KMail/1.9.3
In-Reply-To: <200610261813.12567.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30236>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8JY-00041F-KF for gcvg-git@gmane.org; Thu, 26 Oct
 2006 18:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423617AbWJZQml (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423618AbWJZQml
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 12:42:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:50903 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423617AbWJZQmk
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 12:42:40 -0400
Received: by ug-out-1314.google.com with SMTP id 32so420631ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 09:42:36 -0700 (PDT)
Received: by 10.67.27.3 with SMTP id e3mr3176764ugj; Thu, 26 Oct 2006
 09:42:35 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id a1sm780019ugf.2006.10.26.09.42.35; Thu, 26 Oct
 2006 09:42:35 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This amend fixes regression which caused signoff lines
to be not highlighted as such.

 gitweb/gitweb.css  |   16 ++++++++++++++--
 gitweb/gitweb.perl |   18 ++++++++++--------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 0eda982..83d900d 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -100,7 +100,7 @@ span.age {
 	font-style: italic;
 }
 
-div.page_body span.signoff {
+span.signoff {
 	color: #888888;
 }
 
@@ -114,7 +114,7 @@ div.log_link {
 	width: 136px;
 }
 
-div.list_head {
+div.diff_tree_head {
 	padding: 6px 8px 4px;
 	border: solid #d9d8d1;
 	border-width: 1px 0px 0px;
@@ -128,6 +128,18 @@ div.author_date {
 	font-style: italic;
 }
 
+div.commitdiff_log {
+	padding: 8px;
+	border: solid #d9d8d1;
+	border-width: 0px 0px 1px 0px;
+}
+
+div.patchset {
+	padding-top: 8px;
+	border: solid #d9d8d1;
+	border-width: 1px 0px 0px 0px;
+}
+
 a.list {
 	text-decoration: none;
 	color: #000000;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0d2ea72..044a47d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1844,11 +1844,11 @@ sub git_print_tree_entry {
 sub git_difftree_body {
 	my ($difftree, $hash, $parent) = @_;
 
-	print "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
+		print "<div class=\"list_head\">\n";
 		print(($#{$difftree} + 1) . " files changed:\n");
+		print "</div>\n";
 	}
-	print "</div>\n";
 
 	print "<table class=\"diff_tree\">\n";
 	my $alternate = 1;
@@ -2053,9 +2053,9 @@ sub git_patchset_body {
 			}
 			$patch_idx++;
 
-			# for now, no extended header, hence we skip empty patches
-			# companion to	next LINE if $in_header;
-			if ($diffinfo->{'from_id'} eq $diffinfo->{'to_id'}) { # no change
+			# for now we skip empty patches
+			if ($diffinfo->{'from_id'} eq $diffinfo->{'to_id'}) {
+				# no change, empty patch
 				$in_header = 1;
 				next LINE;
 			}
@@ -3486,13 +3486,15 @@ sub git_commitdiff {
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 		git_print_authorship(\%co);
-		print "<div class=\"page_body\">\n";
+
 		if (@{$co{'comment'}} > 1) {
-			print "<div class=\"log\">\n";
+			print "<div class=\"commitdiff_log\">\n";
 			git_print_log($co{'comment'}, -final_empty_line=> 1, -remove_title => 1);
-			print "</div>\n"; # class="log"
+			print "</div>\n"; # class="commitdiff_log"
 		}
 
+		print "<div class=\"page_body\">\n";
+
 	} elsif ($format eq 'plain') {
 		my $refs = git_get_references("tags");
 		my $tagname = git_get_rev_name_tags($hash);
-- 
1.4.3.3
