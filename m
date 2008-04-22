From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Friendly refspecs
Date: Tue, 22 Apr 2008 13:19:35 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804221259180.19665@iabervon.org>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net>
 <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net>
 <7v63u9zva9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Teemu Likonen <tlikonen@iki.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:20:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoMAP-0007Um-RE
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbYDVRTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755753AbYDVRTi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:19:38 -0400
Received: from iabervon.org ([66.92.72.58]:43568 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880AbYDVRTh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:19:37 -0400
Received: (qmail 6315 invoked by uid 1000); 22 Apr 2008 17:19:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2008 17:19:35 -0000
In-Reply-To: <7v63u9zva9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80145>

On Tue, 22 Apr 2008, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The "refs/heads/" dwimmery makes sense to me, because:
> >
> >   1. it changes a behavior which is currently an error condition, so
> >      we're not hurting anyone's existing workflow
> >
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

That's no good for people who make lightweight tags, since those will be 
commits, and "git push <remote> tag:tag" would push refs/tags/tag to 
refs/heads/tag.

But I think the proposal was for "git push $there $name:$name", where name 
gets expanded locally to refs/heads/$name, which I think should probably 
work. I think it should require $name to be unambiguous locally, though, 
because it wouldn't be too unusual for people to end up with the same name 
for a branch and a lightweight tag, and then try pushing that name, 
expecting one or the other to get pushed.

	-Daniel
*This .sig left intentionally blank*
