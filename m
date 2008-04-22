From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Tue, 22 Apr 2008 16:05:50 -0400
Message-ID: <20080422200550.GB29313@sigill.intra.peff.net>
References: <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net> <7v63u9zva9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 22:07:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoOlG-0005QB-70
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 22:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbYDVUFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 16:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755304AbYDVUFy
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 16:05:54 -0400
Received: from peff.net ([208.65.91.99]:2655 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266AbYDVUFx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 16:05:53 -0400
Received: (qmail 15460 invoked by uid 111); 22 Apr 2008 20:05:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 16:05:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 16:05:50 -0400
Content-Disposition: inline
In-Reply-To: <7v63u9zva9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80162>

On Tue, Apr 22, 2008 at 09:52:46AM -0700, Junio C Hamano wrote:

> >   2. In my usage, pushing a branch to a tag (or vice versa) is the
> >      exception, so I don't mind favoring pushing like types to like
> >      types.
> >
> > But I recognize that (2) is based on my own workflow, so if people
> > disagree, I guess it isn't so for everyone.
> 
> So the proposal is:
> 
> 	"git push $there $commit:$name", when $name does not begin with
> 	refs/, is interpreted as "git push $there $commit:refs/heads/$name"
> 
> right?  I think that makes sense, at least to me.

No, the proposal is:

        "git push $there $commit:$name", when $name does not begin with
        refs/, is interpreted as "git push $there
        $commit:$prefix/$name", where $prefix is determined by resolving
        $commit and pulling off its first two directories.

(or maybe this should just be picky and DWIM only for refs/heads and
refs/tags). So "git push v1.0" is the same as "git push v1.0:v1.0",
which is the same as "git push refs/tags/v1.0:refs/tags/v1.0".

-Peff
