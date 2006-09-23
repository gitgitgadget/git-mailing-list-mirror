From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sat, 23 Sep 2006 13:50:01 -0700
Message-ID: <7v4puys3ye.fsf@assigned-by-dhcp.cox.net>
References: <200609212356.31806.jnareb@gmail.com>
	<20060923032948.GE8259@pasky.or.cz>
	<200609231034.49545.jnareb@gmail.com>
	<20060923121134.GM13132@pasky.or.cz>
	<7veju2s6bi.fsf@assigned-by-dhcp.cox.net> <ef44r4$km0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 22:50:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRERt-00068f-TV
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWIWUuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 16:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWIWUuE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 16:50:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62387 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964910AbWIWUuC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 16:50:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923205002.CRRD6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 16:50:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rwq01V00D1kojtg0000000
	Sat, 23 Sep 2006 16:50:00 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ef44r4$km0$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	23 Sep 2006 22:18:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27627>

Jakub Narebski <jnareb@gmail.com> writes:

> The idea of doing committag parsing, and preserving replacements
> from matching committag and being subject to HTML escaping by using
> reference to string has it's merits.
>
> I'd have to think about it.

Good.  My obviously buggy illustration would be easier to read
with this patch ;-).

--- gomi	2006-09-23 13:47:52.000000000 -0700
+++ gomi	2006-09-23 13:48:23.000000000 -0700
@@ -2,7 +2,7 @@
                 my @input = (@_);
                 my @output;
                 for (@input) {
-                        if (!ref $_) {
+                        if (ref $_) {
                                 push @output, $_;
                                 next;
                         }
@@ -19,6 +19,9 @@
                                 }
                                 $_ = $post;
                         }
+			if ($_ ne '') {
+				push @output, $_;
+			}
                 }
                 return @output;
         }
