From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 10:29:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604131023250.13970@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7ya13e3.fsf@assigned-by-dhcp.cox.net> <7vek02ynif.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 10:29:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTxCP-00089P-NK
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 10:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWDMI3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 04:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWDMI3F
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 04:29:05 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41104 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751196AbWDMI3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 04:29:04 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 8EAC31D78;
	Thu, 13 Apr 2006 10:29:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 7FE202056;
	Thu, 13 Apr 2006 10:29:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 6129B1D78;
	Thu, 13 Apr 2006 10:29:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek02ynif.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18657>

Hi,

On Wed, 12 Apr 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > I wonder if you can also make this an independent option that
> > prepends diffstat in front of the patch, just like the way the
> > new flag --patch-with-raw flag prepends raw output in front of
> > the patch.
> 
> Clarification.
> 
> Traditionally, we had diff-raw and diff-patch formats.
> We can think of --name-status and --name-only variants of
> diff-raw (just like different --abbrev settings give different
> visuals for diff-raw).  Until very recently, these were either-or
> output formats, but for Cogito we added an option to show both.
> 
> We could reorganize the output format options to:
> 
> 	- diff-raw and its name variants
> 	- diff-stat
>         - diff-patch
> 
> and have (internally) three bools to specify which ones to
> output, in the above order.  The recent --patch-with-raw would
> flip bit #0 (show raw) and bit #2 (show patch) on.  It is very
> likely that diff-stat followed by diff-patch would be a popular
> format (that is what git-format-patch does), and it also is
> conceivable that diff-raw with diff-stat but without diff-patch
> might turn out to be useful for some people.

That sounds plausible. Note that if diff-stat and diff-patch are turned 
on, the patch generating code will be called twice. I do not think it is 
sensible (or robust, for that matter) to cache the patch for this case.

> Also, I forgot to mention, but would it be useful to have a
> diffstat to show --cc?  It is unclear, without much thinking,
> what the numbers would mean, though...

I thought long and hard about that. But how would you display it? You can 
have lines starting with "+ ", " +", "--", etc. The only half-way 
reasonable approach I found was to display the diffstat against each 
parent individually. Since it would be a bit involved to implement that, I 
wanted to think about it a bit longer, if it really makes sense.

Ciao,
Dscho
