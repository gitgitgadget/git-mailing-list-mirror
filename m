From: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 20:05:51 +0100
Message-ID: <20110207190551.GA25413@pcpool00.mathematik.uni-freiburg.de>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102061711.45460.johan@herland.net> <AANLkTi=gd5iu0i=ggqJC++N_rL+nU6RO9PNw=jMpT0NH@mail.gmail.com> <201102062312.51655.johan@herland.net> <AANLkTi=A-rh+wfg7O4KryydxVuorM8nkuGYmpbgVfVJp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 20:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmWiP-0005St-Mn
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 20:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab1BGTZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 14:25:27 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:58359
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753936Ab1BGTZ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 14:25:26 -0500
X-Greylist: delayed 1172 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Feb 2011 14:25:26 EST
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1PmWPH-0006I1-Bz; Mon, 07 Feb 2011 20:05:51 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1PmWPH-0006f0-AB; Mon, 07 Feb 2011 20:05:51 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTi=A-rh+wfg7O4KryydxVuorM8nkuGYmpbgVfVJp@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166273>

* Dmitry Potapov <dpotapov@gmail.com> [110207 01:07]:
> There are two sorts of tags:
> - local tags, which are never intended to be shared with others but used
>   by users to mark some points in the working repository.
> - global tags, which are just _social_convention_ about what the current
>   project considers as official versions. Without social convention, they
>   make no sense.
>[...]
> It seems you do not understand the problem that I am trying to say all
> way along: there is more than one repo from which I fetch tags, and
> because they are belong to the same project, they should be in the same
> namespace.

So there are those "local tags", which are not to be shared with others.
Does that mean an user should always have two repositories, one with
those tags for themselves and one without those tags for each other?

And the private one should always be the one that does the push and
fetch (as issuing a a fetch in the public to get something from the
private will also get all those tags)?

> > Granted, if we leave all tags in a single namespace, I can still work around
> > this by manually futzing with the configured refspecs to create ad hoc
> > namespaces. But I _really_ hate it when I'm forced to hack around the tool,
> > because the tool thinks it "knows better".
>
> I believe that the right interface when the common case is simple, but
> an uncommon case is still possible to handle. I don't think that
> currently git meets this criterion, but making tag namespaces based on
> the remote name strikes me as a really bad idea. Tags are attributes of
> a project and not particular remote.

Global tags are. Local tags are not.
And even for global tags it can be interesting to see which remote has
them, without having to manually look at all those remotes.

> IMHO, it is very confusing, especially for people whose script was
> suddenly broken by those namespaces.

Like it was when remotes where introduced?

> So, IMHO, the proper solution should be ability to specify the desired
> namespace for any remote repository, like this:
>
> remote.<name>.tagNameSpace = foo
>
> So, those who want to have many namespaces should be able to that
> easily, but forcing multiple namespaces on those who have a single
> namespace semantically is simple wrong. Not to mention that it breaks
> existing scripts for no good reason.

I'd consider it more logical to have remote tags and a config to
automatically make local copies of remote tags. (With whatever default
people consider proper).


	Bernhard R. Link
