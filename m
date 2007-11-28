From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Tue, 27 Nov 2007 22:25:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711272143470.5349@iabervon.org>
References: <20071127211730.GA11861@midwinter.com> <7v4pf7b20b.fsf@gitster.siamese.dyndns.org>
 <49EB8C6F-8100-48C1-BB2D-A8F6023BACAD@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:14:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwu-0004me-9z
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:19:24 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxDfV-0000Ah-Jf
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 04:32:57 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxDfM-0006Hn-Uh
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 04:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbXK1DZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 22:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbXK1DZg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 22:25:36 -0500
Received: from iabervon.org ([66.92.72.58]:51597 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629AbXK1DZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 22:25:35 -0500
Received: (qmail 23097 invoked by uid 1000); 28 Nov 2007 03:25:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 03:25:32 -0000
In-Reply-To: <49EB8C6F-8100-48C1-BB2D-A8F6023BACAD@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.5, required=5.0, autolearn=disabled, AWL=1.514,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 2A7B1E5DD375F048F667BED6686C900BB94EFBAF
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -54 maxlevel 200 minaction 2 bait 0 mail/h: 16 total 723743 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66294>

On Tue, 27 Nov 2007, Steven Grimm wrote:

> On Nov 27, 2007, at 5:19 PM, Junio C Hamano wrote:
> 
> >How does this interact with the "pretend to have fetched back
> >immediately" supported by modern git-push?
> 
> 
> That continues to fire, but it updates the local tracking ref to point to the
> SHA1 that was pushed, which isn't the actual remote ref. So you have to do a
> real fetch to get the local tracking ref pointed to the right place. In other
> words, that feature doesn't do any good in this context, but it doesn't really
> hurt anything either.
> 
> It would of course be better if git-push could notice that it needs to do an
> actual fetch. I think it'd be sufficient to transmit the final remote ref SHA1
> back to git-push, and if it doesn't match what was pushed, that's a sign that
> a fetch is needed. But that change wouldn't be mutually exclusive with this
> patch, I believe.

Couldn't you do this with a status message? ("ok <refname> changed by 
hook" or something.)

I disagree that the feature doesn't do any good; it records that the state 
of the remote is at least as new as the local state, so you can tell 
without a network connection that you don't have any local changes you 
haven't sent off.

	-Daniel
*This .sig left intentionally blank*
