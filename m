From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sat, 17 Nov 2012 16:04:42 +0100
Message-ID: <20121117150441.GA7695@book.hvoigt.net>
References: <20121110184437.GC2739@mjolnir> <20121109162919.GA922@book.hvoigt.net> <20121110190232.GD2739@mjolnir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Nov 17 16:05:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZjxC-0006GG-PY
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 16:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab2KQPEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 10:04:52 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:35914 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab2KQPEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 10:04:51 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TZjwo-0001Mi-Ki; Sat, 17 Nov 2012 16:04:43 +0100
Content-Disposition: inline
In-Reply-To: <20121110190232.GD2739@mjolnir>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209962>

Hi,

sorry for the late reply but my git time is limited.

On Sat, Nov 10, 2012 at 02:02:32PM -0500, W. Trevor King wrote:
> On Fri, Nov 09, 2012 at 05:29:27PM +0100, Heiko Voigt wrote:
> > I think we should agree on a behavior for this option and implement it
> > the same time when add learns about it. When we were discussing floating
> > submodules as an important option for the gerrit people I already started
> > to implement a proof of concept. Please have a look here:
> > 
> > https://github.com/hvoigt/git/commits/hv/floating_submodules
> 
> After skimming through this, something like
> 
>   $ git submodule update --pull
> 
> would probably be better than introducing a new command:

Yeah along the lines of that, but one thing to keep in mind:

We already have --rebase and --merge which do slightly different things
(I think). Adding --pull here should behave similar to them. Like fetch
and merge is the same to pull without submodules.

If I am understanding your goal correctly your --pull would be
different. On the other hand: A --pull makes no sense if we apply it to
the existing --merge option since it merges the recorded sha1 into the
current HEAD. Just a fetch would not really make a difference.

Thinking along the existing options I would probably still expect --pull
to merge something into the current HEAD. So maybe we have to iron out
where this command/option should go. But changing that once we have a
patch to discuss should not be that much work. So please proceed with
--pull and once we know exactly what it does we can polish that.

> On Sat, Nov 10, 2012 at 01:44:37PM -0500, W. Trevor King wrote:
> >   $ git submodule pull-branch
> 
> I think "floating submodules" is a misleading name for this feature
> though, since the checkout SHA is explicitly specified.  We're just
> making it more convenient to explicitly update the SHA.  How about
> "tracking submodules"?

Until now we have always called this workflow floating submodules. I
imaging since the submodule floats to the newest revision (whatever the
user chooses that to be) instead of staying at the recorded sha1.

"tracking submodules" sounds strange to me since the term tracked in git
is mainly used in combination with exact recorded history (e.g. tracking
branch). Since it is about *not* checking out the recorded sha1 but
something that can change I think that could cause confusion.

I think floating is a more unambiguous term and already known on the
list.

Cheers Heiko
