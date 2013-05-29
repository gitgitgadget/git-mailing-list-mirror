From: Jeff King <peff@peff.net>
Subject: Re: Retrieving a file at a before a specified commit
Date: Wed, 29 May 2013 03:58:11 -0400
Message-ID: <20130529075811.GA7204@sigill.intra.peff.net>
References: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik de Castro Lopo <mle+tools@mega-nerd.com>
X-From: git-owner@vger.kernel.org Wed May 29 09:58:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhbH2-0000aF-B7
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958Ab3E2H6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 03:58:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:36839 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964850Ab3E2H6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 03:58:15 -0400
Received: (qmail 18394 invoked by uid 102); 29 May 2013 07:58:55 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 02:58:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 03:58:11 -0400
Content-Disposition: inline
In-Reply-To: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225772>

On Wed, May 29, 2013 at 04:47:35PM +1000, Erik de Castro Lopo wrote:

> I have a commit like this:
> 
>     commit 4d77a3cee01db0412956d40875c79f51ac745acc
>     tree 3443c9f633114c3bd2e015453a8c55a171e62b53
>     parent 340d808ade8a79857bec40770f0eb4f98224c53d
>     author ....
>     committer .....
> 
> which modifies file A/B/C (ie specifically does not add, but changes
> an existing file in the repo).
> 
> I would then like to retrive the version of the file A/B/C before
> commit 4d77a3cee by using the parent commit 340d808a:
> 
>    git show 340d808ade8a79857bec40770f0eb4f98224c53d:A/B/C
> 
> which works for most files/commits I try this with, but doesn't work
> in one particular case.

Yes, that should work as long as the file is modified and not added. You
can also say "4d77a3cee^:A/B/C" if you do not want to look up the parent
id yourself.

Note that for a merge commit with multiple parents, the question is more
complex, as there are two previous states that are merged.

You say that it doesn't work in one particular case. What is that case?
What happens?

> Questions:
> 
> - Is my understanding of the above git command incorrect?

No, I think it is correct.

> - Is this a corrupt repo? Is there some way to check?

Running "git fsck" can tell you if there is repository corruption.

> - Is there some explaination of why I can't get the previous version
>   of that file?

Probably. Can you show us the commit that fails? What does git say when
you try it?

-Peff
