From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Tue, 23 Aug 2011 21:43:50 +0200
Message-ID: <20110823194350.GA57187@book.hvoigt.net>
References: <cover.1312923673.git.hvoigt@hvoigt.net> <7v8vqzreeo.fsf@alter.siamese.dyndns.org> <20110811195955.GA21185@book.hvoigt.net> <7vy5yujtr2.fsf@alter.siamese.dyndns.org> <20110822200052.GC11745@sandbox-rc> <7v62lpuky8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 21:43:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvwtC-00038G-A2
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 21:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab1HWTny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 15:43:54 -0400
Received: from darksea.de ([83.133.111.250]:42541 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752070Ab1HWTnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 15:43:52 -0400
Received: (qmail 2204 invoked from network); 23 Aug 2011 21:43:50 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Aug 2011 21:43:50 +0200
Content-Disposition: inline
In-Reply-To: <7v62lpuky8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179963>

Hi,

On Mon, Aug 22, 2011 at 03:42:55PM -0700, Junio C Hamano wrote:
> > On Mon, Aug 15, 2011 at 01:37:53PM -0700, Junio C Hamano wrote:
> >> Heiko Voigt <hvoigt@hvoigt.net> writes:
> >> What I usually do is say "submodule init" without any extra option once.
> >> That will register all submodules from .gitmodules in the config. Now
> >> when I say "submodule update" all submodules would be cloned. In the
> >> case of recursive submodules actually
> >>
> >> 	git submodule update --init --recursive
> >>
> >> is the only command which can get you really everything in one go.
> >>
> >> Do you think the "submodule init" behavior is wrong? If so I think its a
> >> bit late to change this since people using submodules (me included)
> >> already have got used to it.
> >>
> >> With this config variable all submodules will still be registered to
> >> .git/config on "submodule init" but "submodule update" will skip those
> >> submodules.
> >
> > Ok, that sort-of makes sense, but we have been using "do we have the
> > submodule registered in the .git/config of the superproject?" to decide
> > "does the user interested in having a checkout of the submodule?" (I think
> > in the ancient days it was "do we have .git in that submodule directory?"
> > that decided it, but we dropped that because it won't work when switching
> > branches that has and does not have the submodule in superproject).
> >
> > It is somewhat worrying that some parts of the system may still be using
> > that old criteria "do we have it in .git/config of the superproject?" to
> > decide if the user is interested in the submodule. If so they need to be
> > updated to take this new semantics "do we have it in .git/config without
> > its submodule.$name.update set to none" into account. We would probably
> > need to have a paragraph in the release notes to warn about the semantics
> > change (which I tend to agree with you that it is a good one).

Sorry that I forgot to answer to this. I am not sure what you mean by
"the semantics change". This patch does not change any existing
behavior. I rather see this as an extra way to specify the default
behavior of what happens on submodule update. If people do not use it
there will be no expectations broken.

Another change I am thinking of (which would definitely need an entry in
the release notes) is to change submodule foreach to iterate over all
gitmodule entries in the index/HEAD/worktree (not sure yet) instead of
"just entries that are in .git/config".

What do you think?

Cheers Heiko
