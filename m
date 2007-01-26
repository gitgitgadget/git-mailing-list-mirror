From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fetch over ssh trouble
Date: Thu, 25 Jan 2007 21:24:42 -0800
Message-ID: <7vmz462wdh.fsf@assigned-by-dhcp.cox.net>
References: <20070126050842.GA18058@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 06:25:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAJaA-00011i-JW
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 06:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030750AbXAZFYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 00:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030751AbXAZFYo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 00:24:44 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:47923 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030750AbXAZFYn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 00:24:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126052442.ZQQY2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 00:24:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FhPl1W00F1kojtg0000000; Fri, 26 Jan 2007 00:23:45 -0500
In-Reply-To: <20070126050842.GA18058@fieldses.org> (J. Bruce Fields's message
	of "Fri, 26 Jan 2007 00:08:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37800>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Any idea why this is happening?:
>
> bfields@pickle:git$ git fetch linux-nfs
> Password:
> /usr/local/bin/git-parse-remote: line 145: test: !=: unary operator
> expected

Ouch.

I wonder what should happen when you do not have anything
defined for "linus-nfs" shorthand.  Should it fetch HEAD?

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 1122c83..12023d2 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -82,6 +82,7 @@ get_remote_default_refs_for_push () {
 # a merge candidate
 expand_refs_wildcard () {
 	first_one=yes
+	test "$#" = 0 && echo empty
 	for ref
 	do
 		lref=${ref#'+'}
