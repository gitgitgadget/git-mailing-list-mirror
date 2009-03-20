From: Jeff King <peff@peff.net>
Subject: Re: How to commit changes if remote repository changed directory
	structure?
Date: Fri, 20 Mar 2009 02:09:26 -0400
Message-ID: <20090320060926.GC27008@coredump.intra.peff.net>
References: <22612715.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: andholt <andholt@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 07:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkXwg-0002Ly-NO
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 07:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbZCTGJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 02:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbZCTGJh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 02:09:37 -0400
Received: from peff.net ([208.65.91.99]:54606 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbZCTGJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 02:09:36 -0400
Received: (qmail 6872 invoked by uid 107); 20 Mar 2009 06:09:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 02:09:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 02:09:26 -0400
Content-Disposition: inline
In-Reply-To: <22612715.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113900>

On Thu, Mar 19, 2009 at 06:17:15PM -0700, andholt wrote:

> I have a lot of local changes to add, commit, and push. Right now our
> directory structure is 1/2/3. Another developer decided to move everything
> up one level, so used git move to move 3 to 2, and removed 3, so now the
> level is 1/2. However, locally, all of my changes are in 1/2/3. 
> 
> I want to commit my changes and merge them into the new directory structure.
> How would I go about doing that?

First, commit your changes. Then merge the other developer's changes. :)

This is exactly the sort of case that git's rename detection should
handle; it should detect that the other side renamed files, and then
consider your changes against the newly named files. The only thing it
_won't_ handle is new files that you added in 1/2/3. You will have to
manually move them to 1/2 as part of the merge (there has been
discussion of "detect that this whole directory seems to have had its
content moved and automatically move new files", but the patches have
not been accepted).

-Peff
