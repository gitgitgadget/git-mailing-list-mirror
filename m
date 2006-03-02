From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-annotate dies when a patch is missing trailing newline
Date: Wed, 01 Mar 2006 18:23:12 -0800
Message-ID: <7vslq1d1pr.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 03:23:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEdTM-0008Fd-8j
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 03:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWCBCXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 21:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWCBCXP
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 21:23:15 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7905 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932085AbWCBCXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 21:23:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060302022318.CKKV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 21:23:18 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 2 Mar 2006 13:53:21 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17041>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> git-annotate is dying when a patch is missing trailing newline. There
> _are_ valid situations where code files are not expected to have
> trailing newlines. Just thing of that glorious programming language,
> PHP.

Does this help?

---
diff --git a/git-annotate.perl b/git-annotate.perl
index f9c2c6c..d30eba7 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -304,6 +304,10 @@ sub _git_diff_parse {
 			}
 			$ri++;
 
+		} elsif (m/^\\/) {
+	
+			; # ignore for now...
+
 		} else {
 			if (substr($_,1) ne get_line($slines,$ri) ) {
 				die sprintf("Line %d (%d) does not match:\n|%s\n|%s\n%s => %s\n",
