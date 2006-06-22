From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: whitespace cleanup around '='
Date: Thu, 22 Jun 2006 00:09:47 -0700
Message-ID: <7vejxhwts4.fsf@assigned-by-dhcp.cox.net>
References: <20060622023546.28cb4291.froese@gmx.de>
	<11509591773212-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 09:09:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJK4-0005IS-DC
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 09:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWFVHJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 03:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWFVHJt
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 03:09:49 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:5612 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751031AbWFVHJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 03:09:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622070948.XDMK554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 03:09:48 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11509591773212-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Thu, 22 Jun 2006 08:52:57 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22302>

Jakub Narebski <jnareb@gmail.com> writes:

> @@ -326,7 +326,7 @@ EOF
>  		} elsif (defined $hash) {
>  			$search_hash = $hash;
>  		} else {
> -			$search_hash  = "HEAD";
> +			$search_hash = "HEAD";
>  		}
>  		$cgi->param("a", "search");
>  		$cgi->param("h", $search_hash);

My copy from "next" has this part like the following:

		if (!defined $searchtext) {
			$searchtext = "";
		}
		my $search_hash;
		if (defined $hash) {
			$search_hash = $hash;
		} else {
			$search_hash  = "HEAD";
		}

I thought we were both reasonably sure that we are now in
sync...  I could apply it by hand but once I start doing that
I'm afraid we will never converge.

It's quite frustrating.

> @@ -1766,8 +1766,8 @@ sub git_opml {
>  		}
>  
>  		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
> -		my $rss =  "$my_url?p=$proj{'path'};a=rss";
> -		my $html =  "$my_url?p=$proj{'path'};a=summary";
> +		my $rss  = "$my_url?p=$proj{'path'};a=rss";
> +		my $html = "$my_url?p=$proj{'path'};a=summary";
>  		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
>  	}
>  	print "</outline>\n".

Are you sure you want to do "my $rss two-spaces equal space"?

I've fixed up the whitespace you missed and will be applying the
following on top of what is in "next" tonight.

-- >8 --
gitweb: do not align assignment = with extra whitespaces

---
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index f2e5046..e2ed6db 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -55,7 +55,7 @@ my $projects_list = "index/index.aux";
 
 # default blob_plain mimetype and default charset for text/plain blob
 my $default_blob_plain_mimetype = 'text/plain';
-my $default_text_plain_charset  = undef;
+my $default_text_plain_charset = undef;
 
 # file to use for guessing MIME types before trying /etc/mime.types
 # (relative to the current git repository)
@@ -325,7 +325,7 @@ EOF
 		if (defined $hash) {
 			$search_hash = $hash;
 		} else {
-			$search_hash  = "HEAD";
+			$search_hash = "HEAD";
 		}
 		$cgi->param("a", "search");
 		$cgi->param("h", $search_hash);
@@ -1283,21 +1283,21 @@ HTML
 
 		if ($line =~ m/^([0-9a-fA-F]{40})\t\(\s*([^\t]+)\t(\d+) \+\d\d\d\d\t(\d+)\)(.*)$/) {
 			$long_rev = $1;
-			$author   = $2;
-			$time     = $3;
-			$lineno   = $4;
-			$data     = $5;
+			$author = $2;
+			$time = $3;
+			$lineno = $4;
+			$data = $5;
 		} else {
 			print qq(  <tr><td colspan="5" class="error">Unable to parse: $line</td></tr>\n);
 			next;
 		}
-		$short_rev  = substr ($long_rev, 0, 8);
-		$age        = time () - $time;
-		$age_str    = age_string ($age);
-		$age_str    =~ s/ /&nbsp;/g;
-		$age_class  = age_class($age);
-		$author     = esc_html ($author);
-		$author     =~ s/ /&nbsp;/g;
+		$short_rev = substr ($long_rev, 0, 8);
+		$age = time () - $time;
+		$age_str = age_string ($age);
+		$age_str =~ s/ /&nbsp;/g;
+		$age_class = age_class($age);
+		$author = esc_html ($author);
+		$author =~ s/ /&nbsp;/g;
 		# escape tabs
 		while ((my $pos = index($data, "\t")) != -1) {
 			if (my $count = (8 - ($pos % 8))) {
@@ -1765,8 +1765,8 @@ sub git_opml {
 		}
 
 		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
-		my $rss =  "$my_url?p=$proj{'path'};a=rss";
-		my $html =  "$my_url?p=$proj{'path'};a=summary";
+		my $rss = "$my_url?p=$proj{'path'};a=rss";
+		my $html = "$my_url?p=$proj{'path'};a=summary";
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
 	print "</outline>\n".
@@ -1941,7 +1941,7 @@ sub git_commit {
 	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") .
 	      "</td>" .
 	      "</tr>\n";
-	my $parents  = $co{'parents'};
+	my $parents = $co{'parents'};
 	foreach my $par (@$parents) {
 		print "<tr>" .
 		      "<td>parent</td>" .
