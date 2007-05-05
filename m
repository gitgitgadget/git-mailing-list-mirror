From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Sat, 5 May 2007 01:21:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705050115270.28708@iabervon.org>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
 <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704290152410.28708@iabervon.org>
 <7vejm3g0dg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705022330460.28708@iabervon.org>
 <7virba31wd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705030137520.28708@iabervon.org>
 <7vejly305u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 07:21:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkCiN-0006SX-Kl
	for gcvg-git@gmane.org; Sat, 05 May 2007 07:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXEEFVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 01:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753883AbXEEFVr
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 01:21:47 -0400
Received: from iabervon.org ([66.92.72.58]:3198 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbXEEFVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 01:21:47 -0400
Received: (qmail 27931 invoked by uid 1000); 5 May 2007 05:21:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 May 2007 05:21:42 -0000
In-Reply-To: <7vejly305u.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46244>

On Wed, 2 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Indeed. Is there documentation on all the possibilities for refspecs 
> > somewhere all together? I could only find it for particular programs, and 
> > didn't see a no-colon option permitted anywhere.
> 
> Documentation/pull-fetch-param.txt which is included by various
> manpages would be the best place to start.
> 
>     <refspec>::
>             The canonical format of a <refspec> parameter is
>             `+?<src>:<dst>`; that is, an optional plus `+`, followed
>             by the source ref, followed by a colon `:`, followed by
>             the destination ref.
>     +
>     The remote ref that matches <src>
>     is fetched, and if <dst> is not empty string, the local
>     ref that matches it is fast forwarded using <src>.
>     Again, if the optional plus `+` is used, the local ref
>     is updated even if it does not result in a fast forward
>     update.
> 
> Hmph.  So <dst> could be empty, and in such a case there is no
> tracking.  But this does not say missing colon is allowed (but
> that was intentionally left out as we clarify it later).  Let's
> read on.  After a few [Notes], we find this.
> 
>     Some short-cut notations are also supported.
>     +
>     * `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`; 
>       it requests fetching everything up to the given tag.
>     * A parameter <ref> without a colon is equivalent to
>       <ref>: when pulling/fetching, so it merges <ref> into the current
>       branch without storing the remote branch anywhere locally
> 
> Ahh, so a refspec that does not have a colon, and ends with a
> colon (hence an empty <dst>) are equivalent, and does not result
> in remote tracking.

Is this actually supported in config files? At least for pulls, the "tag 
<tag>" notation is only available on the command line, afaict. For that 
matter, I think that having "<ref>:" or "<ref>" in a config file fetch 
line would be really bad; these refs would always be merged into any 
current head (without any remote tracking) when the remote is fetched 
from?

	-Daniel
*This .sig left intentionally blank*
