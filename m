From: Jeff King <peff@peff.net>
Subject: Re: commit summary, --pretty=short and other tools
Date: Mon, 17 Sep 2007 07:42:37 -0400
Message-ID: <20070917114237.GA14707@coredump.intra.peff.net>
References: <20070917112136.GA30201@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 13:42:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXF00-0005Zu-Qs
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 13:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbXIQLmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 07:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbXIQLmk
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 07:42:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3488 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbXIQLmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 07:42:40 -0400
Received: (qmail 13461 invoked by uid 111); 17 Sep 2007 11:42:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Sep 2007 07:42:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2007 07:42:37 -0400
Content-Disposition: inline
In-Reply-To: <20070917112136.GA30201@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58426>

On Mon, Sep 17, 2007 at 01:21:36PM +0200, Mike Hommey wrote:

> ... and I happen to not have done the "followed by a blank line" part.

If this isn't a published repo, you can fix it with filter-branch:

git filter-branch --msg-filter 'sed "1a
"'

> Now, git log --pretty=oneline (for instance), shows me the full commit
> message on one line, which is not really what I would expect...
> 
> On the other hand, and that's how I got trapped into this, gitweb and
> gitk only display the first line, be it followed by a blank line or not.

This was changed recently for git-log and company, but gitk and gitweb
have not followed suit.  Traditionally, the behavior was to take the
first line. This was changed in 4234a761 to take the first paragraph.
The rationale was that people without the nice one-line summaries are
typically importing old histories, and the paragraph makes a much more
sensible summary (as opposed to cutting off the summary in
mid-sentence).

> So, IMHO, there would be 2 solutions:
> - either change --pretty=oneline,short and other similar things to take
>   only the first line and change the git-commit manpage (and whenever
>   else this might be written)
> - or change gitweb, gitk and any other tool that would only take the
>   first line so that it takes the same summary as --pretty=oneline.
> 
> What do you think ?

It depends on whether people like the new behavior. I think it is more
sensible in every case _except_ the one you have mentioned, but your
case is hopefully somewhat rare (though it just made it to the public in
1.5.3, so yours might be the first of many comments).

I do agree that it makes sense for all of the tools to be consistent.

-Peff
