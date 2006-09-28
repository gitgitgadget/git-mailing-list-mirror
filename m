From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Remove excessively redundant entries from git_difftree_body
Date: Wed, 27 Sep 2006 17:23:25 -0700 (PDT)
Message-ID: <20060928002325.70519.qmail@web31815.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1072763538-1159403005=:70272"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Sep 28 02:23:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjgX-00042S-CT
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031282AbWI1AX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWI1AX0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:23:26 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:48991 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965171AbWI1AX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 20:23:26 -0400
Received: (qmail 70521 invoked by uid 60001); 28 Sep 2006 00:23:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=P+6b1+RKqsLXKcbsMkiapphg/KlL2Ko4Oe9jp/KVcWn/6Coz8KgDuSB9IE5qx1qk5wdxaqv0wbwD6csKXIDFrUMsB0zfY4UBSQUK3dTaMK3lPls+ZJ/nQ2ktrfnBweC+kPo3lxcZrGuqhOQYPRpfvJeJTOBr6cB2zqaZbbrO9tc=  ;
Received: from [64.215.88.90] by web31815.mail.mud.yahoo.com via HTTP; Wed, 27 Sep 2006 17:23:25 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27954>

--0-1072763538-1159403005=:70272
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

1) All entries on the left are blobs and clicking on them
leads to blobs.  No more diff or blob depending on what
happened (modified or mode changed) to the file -- this goes
to the right, in the "link" column.

2) Remove redundant "blob" from the link column on the right.
This can now be had by clicking on the entry itself.

This reduces and simplifies the code.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   92 +++++++++++++++++++---------------------------------
 1 files changed, 34 insertions(+), 58 deletions(-)
--0-1072763538-1159403005=:70272
Content-Type: text/plain; name="p2.txt"
Content-Description: 1908141687-p2.txt
Content-Disposition: inline; filename="p2.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 56638f2..c87f60e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1692,47 +1692,39 @@ sub git_difftree_body {
 			my $mode_chng = "<span class=\"file_status new\">[new $to_file_type";
 			$mode_chng   .= " with mode: $to_mode_str" if $to_mode_str;
 			$mode_chng   .= "]</span>";
-			print "<td>" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+			print "<td>";
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'}),
-			              -class => "list"}, esc_html($diff{'file'})) .
-			      "</td>\n" .
-			      "<td>$mode_chng</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'})},
-			              "blob");
+				       -class => "list"}, esc_html($diff{'file'}));
+			print "</td>\n";
+			print "<td>$mode_chng</td>\n";
+			print "<td class=\"link\">";
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print " | " .
-				      $cgi->a({-href => "#patch$patchno"}, "patch");
+				print $cgi->a({-href => "#patch$patchno"}, "patch");
 			}
 			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "D") { # deleted
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
-			print "<td>" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
+			print "<td>";
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
 			                             hash_base=>$parent, file_name=>$diff{'file'}),
-			               -class => "list"}, esc_html($diff{'file'})) .
-			      "</td>\n" .
-			      "<td>$mode_chng</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff{'file'})},
-			              "blob") .
-			      " | ";
+			               -class => "list"}, esc_html($diff{'file'}));
+			print "</td>\n";
+			print "<td>$mode_chng</td>\n";
+			print "<td class=\"link\">";
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print " | " .
-				      $cgi->a({-href => "#patch$patchno"}, "patch");
+				print $cgi->a({-href => "#patch$patchno"}, "patch");
+				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
 			                             file_name=>$diff{'file'})},
-			              "history") .
-			      "</td>\n";
+			              "history");
+			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "M" || $diff{'status'} eq "T") { # modified, or type changed
 			my $mode_chnge = "";
@@ -1751,42 +1743,29 @@ sub git_difftree_body {
 				$mode_chnge .= "]</span>\n";
 			}
 			print "<td>";
-			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
-				print $cgi->a({-href => href(action=>"blobdiff",
-				                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-				                             hash_base=>$hash, hash_parent_base=>$parent,
-				                             file_name=>$diff{'file'}),
-				              -class => "list"}, esc_html($diff{'file'}));
-			} else { # only mode changed
-				print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-				                             hash_base=>$hash, file_name=>$diff{'file'}),
-				              -class => "list"}, esc_html($diff{'file'}));
-			}
-			print "</td>\n" .
-			      "<td>$mode_chnge</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'})},
-			              "blob");
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+						     hash_base=>$hash, file_name=>$diff{'file'}),
+				       -class => "list"}, esc_html($diff{'file'}));
+			print "</td>\n";
+			print "<td>$mode_chnge</td>\n";
+			print "<td class=\"link\">";
 			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
 				if ($action eq 'commitdiff') {
 					# link to patch
 					$patchno++;
-					print " | " .
-						$cgi->a({-href => "#patch$patchno"}, "patch");
+					print $cgi->a({-href => "#patch$patchno"}, "patch");
 				} else {
-					print " | " .
-						$cgi->a({-href => href(action=>"blobdiff",
-						                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-						                       hash_base=>$hash, hash_parent_base=>$parent,
-						                       file_name=>$diff{'file'})},
-						        "diff");
+					print $cgi->a({-href => href(action=>"blobdiff",
+								     hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+								     hash_base=>$hash, hash_parent_base=>$parent,
+								     file_name=>$diff{'file'})},
+						      "diff");
 				}
+				print " | ";
 			}
-			print " | " .
-				$cgi->a({-href => href(action=>"history",
-				                       hash_base=>$hash, file_name=>$diff{'file'})},
-				        "history");
+			print $cgi->a({-href => href(action=>"history",
+						     hash_base=>$hash, file_name=>$diff{'file'})},
+				      "history");
 			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "R" || $diff{'status'} eq "C") { # renamed or copied
@@ -1806,10 +1785,7 @@ sub git_difftree_body {
 			                             hash=>$diff{'from_id'}, file_name=>$diff{'from_file'}),
 			              -class => "list"}, esc_html($diff{'from_file'})) .
 			      " with " . (int $diff{'similarity'}) . "% similarity$mode_chng]</span></td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-			                             hash=>$diff{'to_id'}, file_name=>$diff{'to_file'})},
-			              "blob");
+			      "<td class=\"link\">";
 			if ($diff{'to_id'} ne $diff{'from_id'}) {
 				if ($action eq 'commitdiff') {
 					# link to patch
-- 
1.4.2.1.g271e


--0-1072763538-1159403005=:70272--
