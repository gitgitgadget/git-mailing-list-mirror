From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] gitweb: Make the Git logo link target to point to the homepage
Date: Sat, 23 Sep 2006 12:36:01 -0700
Message-ID: <7virjes7dq.fsf@assigned-by-dhcp.cox.net>
References: <20060919212725.GA13132@pasky.or.cz>
	<20060923125746.GJ8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 21:36:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRDII-0000zA-Ra
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWIWTgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 15:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWIWTgH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:36:07 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60896 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751497AbWIWTgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 15:36:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923193604.QTPE22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 15:36:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rvc01V00P1kojtg0000000
	Sat, 23 Sep 2006 15:36:01 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27619>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Tue, Sep 19, 2006 at 11:27:25PM CEST, I got a letter
> where Petr Baudis <pasky@suse.cz> said that...
>> It provides more useful information for causual Git users than the Git docs
>> (especially about where to get Git and such).
>> 
>> Signed-off-by: Petr Baudis <pasky@suse.cz>
>
> Ping?  This is the only gitweb patch still in my stg stack. I guess
> noone really cares strongly either way since there were no comments.

I did not care either way, but I did not like either of these
hardcoded strings in the code, and felt that if we are touching
that part of the code we also should be making real improvement
at the same time ;-).  

Doing something like this would let us update it easier, and 
let people override with GITWEB_CONFIG if they want to.

---

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d06181..ce90178 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -51,6 +51,9 @@ our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
 our $favicon = "++GITWEB_FAVICON++";
 
+our $githelp_url = "http://git.or.cz/";
+our $githelp_label = "git homepage";
+
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
@@ -1335,7 +1338,9 @@ EOF
 	print "</head>\n" .
 	      "<body>\n" .
 	      "<div class=\"page_header\">\n" .
-	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
+	      "<a href=\"" . esc_html($githelp_url) .
+	      "\" title=\"" . esc_html($githelp_label) .
+	      "\">" .
 	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
 	      "</a>\n";
 	print $cgi->a({-href => esc_param($home_link)}, $home_link_str) . " / ";
