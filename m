From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Ask for "git program" when asking for "git-program"
	over SSH connection
Date: Wed, 25 Jun 2008 09:06:46 -0400
Message-ID: <20080625130646.GD20361@mit.edu>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com> <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org> <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org> <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org> <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 15:09:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBUkP-0007M3-Mi
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 15:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbYFYNIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 09:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbYFYNIU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 09:08:20 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:38676 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755223AbYFYNIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 09:08:20 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBUi0-0001nF-IT; Wed, 25 Jun 2008 09:06:48 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBUhy-0006wx-Vi; Wed, 25 Jun 2008 09:06:46 -0400
Content-Disposition: inline
In-Reply-To: <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86274>

On Tue, Jun 24, 2008 at 10:27:07PM -0700, Junio C Hamano wrote:
> Ok, let's map this out seriously.
> 
> * 1.6.0 will install the server-side programs in $(bindir) so that 
>   people coming over ssh will find them on the $PATH
> 
> * In 1.6.0 (and 1.5.6.1), we will change "git daemon" to accept both
>   "git-program" and "git program" forms.  When the spaced form is used, it
>   will behave as if the dashed form is requested.  This is a prerequisite
>   for client side change to start asking for "git program".
> 
> * In the near future, there will no client-side change.  "git-program"
>   will be asked for.
> 
> * 6 months after 1.6.0 ships, hopefully all the deployed server side will
>   be running that version or newer.  Client side will start asking for
>   "git program" by default, but we can still override with --upload-pack
>   and friends.
> 
> * 12 months after client side changes, everybody will be running that
>   version or newer.  We stop installing the server side programs in
>   $(bindir) but people coming over ssh will be asking for "git program"
>   and "git" will be on the $PATH so there is no issue.
> 
> The above 6 and 12 are yanked out of thin air and I am of course open to
> tweaking them, but I think the above order of events would be workable.

Is that really 6 and 12 months, or "6/12 months or at the next major
release boundary, whichever is later".  i.e., would make some of these
changes as part of a minor dot release, such as having the client side
change what it starts asking for in 1.6.3 or some such?  Presumably
the earliest that change would happen is 1.7, and the earliest to make
the server side installation changes is 1.8, right?  Or did you really
mean a hard 6/12 months, regardless of release cycle issues?

       	    	 	 	       	       - Ted
