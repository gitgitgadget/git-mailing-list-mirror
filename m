From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 14/19] gitweb: Always display link to blobdiff_plain in git_blobdiff
Date: Fri, 25 Aug 2006 21:05:45 +0200
Message-ID: <200608252105.45448.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 21:07:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGh1Q-0007jn-Hc
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWHYTHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWHYTHK
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:07:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:19500 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751493AbWHYTHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 15:07:05 -0400
Received: by nf-out-0910.google.com with SMTP id o25so872260nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:07:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i2/i/TA1qxRvfAPuQNPTRmhqMWMCXHqm/0IjXTTF3xJtOVX+W8cpluYG/Gw8aiWgrbmYvjBgr4PQsbl0AmWTEtM47KAucBvKVteXgnQm3mKUjBKKzU27QdqGe9to+n/hYg6u40KczvgvBMnB1TM97g6C12NgswyKiEPD8w7+v+8=
Received: by 10.48.210.16 with SMTP id i16mr5750510nfg;
        Fri, 25 Aug 2006 12:07:04 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p72sm7119215nfc.2006.08.25.12.07.03;
        Fri, 25 Aug 2006 12:07:03 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26004>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7e68292..ade5d42 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2790,18 +2790,18 @@ sub git_commit {
 sub git_blobdiff {
 	mkdir($git_temp, 0700);
 	git_header_html();
+	my $formats_nav =
+		$cgi->a({-href => href(action=>"blobdiff_plain",
+		                       hash=>$hash, hash_parent=>$hash_parent,
+		                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
+		                       file_name=>$file_name, file_parent=>$file_parent)},
+		        "plain");
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
-		my $formats_nav =
-			$cgi->a({-href => href(action=>"blobdiff_plain",
-			                       hash=>$hash, hash_parent=>$hash_parent,
-			                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
-			                       file_name=>$file_name, file_parent=>$file_parent)},
-			        "plain");
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
 		print <<HTML;
-<div class="page_nav"><br/><br/></div>
+<div class="page_nav"><br/>$formats_nav<br/></div>
 <div class="title">$hash vs $hash_parent</div>
 HTML
 	}
-- 
1.4.1.1
