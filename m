From: Charles Bailey <charles@hashpling.org>
Subject: Re: How can a custom merge tool get access to file shell variables?
Date: Thu, 21 Aug 2008 23:15:24 +0100
Message-ID: <20080821221524.GA25429@hashpling.org>
References: <1219169604.12921.17.camel@kea-nicira-lt.nicira.com> <1219170004.12921.19.camel@kea-nicira-lt.nicira.com> <1219170751.12921.27.camel@kea-nicira-lt.nicira.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Keith Amidon <keith@nicira.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 00:41:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWIqG-0004sL-15
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 00:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759770AbYHUWkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 18:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759597AbYHUWkP
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 18:40:15 -0400
Received: from ptb-relay01.plus.net ([212.159.14.145]:54415 "EHLO
	ptb-relay01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759568AbYHUWkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 18:40:14 -0400
X-Greylist: delayed 1486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 18:40:13 EDT
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1KWIRB-0002vx-1x; Thu, 21 Aug 2008 23:15:25 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m7LMFOJu025854;
	Thu, 21 Aug 2008 23:15:24 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m7LMFOCQ025853;
	Thu, 21 Aug 2008 23:15:24 +0100
Content-Disposition: inline
In-Reply-To: <1219170751.12921.27.camel@kea-nicira-lt.nicira.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 9ba4390372c9c2fbf5e6cfb71d878cd3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93221>

On Tue, Aug 19, 2008 at 11:32:31AM -0700, Keith Amidon wrote:
> In case anyone is interested, the following does exactly what I want.
> Hopefully this example will help someone else that wants to do something
> similar avoid spending time on writing an unnecessary shell script
> wrapper tool.
> 
> [mergetool "xxdiff-2way-ignorews"]
>     cmd = xxdiff -w $REMOTE $LOCAL --merged-filename $MERGED
>     trustExitCode = false
> 
> I think I was thrown off by the description of mergetool.<name>.cmd in
> the git-config man page.  While on close reading it is definitely
> correct, for me at least it seemed natural to assume that the invoked
> command was supposed to get its information from the environment, not
> that the command line itself could substitute from the environment.
> Would an example such as the above in the man page might help direct
> people toward the best way to do this?
> 
>            --- Keith

Did you also try the git mergetool man page (not that it's much
better!)?

The point of the custom mergetool patch was to make using a new,
previously unknown merge tool a 'simple' configuration exercise rather
than a patch or scripting exercise. At the time, an 'eval' approach
was the compromise between ease of implementation and preventing
environmental pollution.

It's not the most beautiful of solutions, especially since escaping
quotes and spaces in either .gitconfig or in a git config command line
of something that is later going to be expanded by the shell is
something of a mind bender.

An example in the documentation would be a really good idea - you are
not the first person to have asked about how to use the custom merge
tool feature. I'm feeling a little guilty about not adding my name to
the man page when I submitted the patch. It's not Ted's fault that the
custom merge tool section is badly explained; it's mine.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
