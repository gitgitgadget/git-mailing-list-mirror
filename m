From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Blaming diffs
Date: Sun, 16 Sep 2007 19:05:35 +0200
Message-ID: <20070916170534.GU22865@planck.djpig.de>
References: <20070916163829.GA6679@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:39:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWy5P-0004CH-Nt
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbXIPRjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbXIPRjG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:39:06 -0400
Received: from planck.djpig.de ([85.10.192.180]:1704 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbXIPRjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:39:05 -0400
X-Greylist: delayed 2004 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2007 13:39:05 EDT
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id BE3CB88102;
	Sun, 16 Sep 2007 19:05:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V+TpwHXMHoNI; Sun, 16 Sep 2007 19:05:35 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 8005888105; Sun, 16 Sep 2007 19:05:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070916163829.GA6679@glandium.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58335>

On Sun, Sep 16, 2007 at 06:38:29PM +0200, Mike Hommey wrote:
> It seems to me there is no tool to "blame diffs", i.e. something to know
> what commit(s) is(are) responsible for a set of changes.
> 
> For example, the following script tries to get the set of commits
> involved in the changes between $A and $B. Note it only works for text
> additions. 
> 
> git diff --unified=0 $A $B | awk 'BEGIN { FS="(^(--- a/|+++ b/)|^@@ -[0-9,]+ \\+| @@)" } /^---/ || ( /^+++ b\/(.*)/ && file=="" ) { file = $2 } /^@@/ {split($2, a, /,/); a[2] = a[2] ? a[2] + a[1] - 1 : a[1]; print "git blame -l -L " a[1] "," a[2], "'$A..$B'", file }' | sh | cut -f 1 -d " " | sort -u
> 
> Has anyone tried to work on something similar yet ?
> 
> If not, as git users, what kind of output would you expect from such a
> tool, and where do you think this should lie (extension to git diff, or
> separate tool) ?

What do you use for $A and $B? commits? What is the difference between
your script and "git log --pretty=format:%H $A..$B"
then?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
