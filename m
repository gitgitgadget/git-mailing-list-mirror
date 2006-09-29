From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: git and time
Date: Fri, 29 Sep 2006 13:37:36 -0400
Message-ID: <20060929173736.GA13635@delft.aura.cs.cmu.edu>
References: <20060926233321.GA17084@coredump.intra.peff.net> <20060927002745.15344.qmail@web51005.mail.yahoo.com> <BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1A0@CEZ.ICE> <20060926205632.5d487cc9.seanlkml@sympatico.ca> <Pine.LNX.4.63.0609261746160.22495@qynat.qvtvafvgr.pbz> <7vk63qnlc2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0609261823540.22495@qynat.qvtvafvgr.pbz> <7vhcyukpkc.fsf@assigned-by-dhcp.cox.net> <20060926224133.714337eb.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	David Lang <dlang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 19:37:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTMJ0-00070A-4Z
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 19:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWI2Rhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 13:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWI2Rhm
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 13:37:42 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:48827 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1751188AbWI2Rhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 13:37:41 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.62)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1GTMIq-0005pB-8o; Fri, 29 Sep 2006 13:37:36 -0400
To: Sean <seanlkml@sympatico.ca>
Mail-Followup-To: Sean <seanlkml@sympatico.ca>,
	Junio C Hamano <junkio@cox.net>,
	David Lang <dlang@digitalinsight.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060926224133.714337eb.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28115>

On Tue, Sep 26, 2006 at 10:41:33PM -0400, Sean wrote:
> It is interesting information for some people though.  For instance
> someone wondering how long ago Linus published a certain security fix.
> To be able to say to easily query gitweb and be able to report,
> "Linus published that security fix X day ago etc.."

I don't see the point in knowing how many days ago the security fix was
published, since I'd really care if my machine is running a kernel that
contains the fix.

So I can see how I might want to know which branches (and/or tags) in my
repository contain the security fix. And this is pretty easy,

#!/bin/sh
fix="$(git-rev-parse --verify $1)"
git ls-remote . | while read sha ref ; do
    [ "$fix" == "$(git-merge-base "$fix" "$sha")" ] && echo $ref
done

Of course this could be cleaned up and extended quite a bit, possibly
allowing a user to specify if he cares about only branches, or tags or
some specific branch.

Jan
