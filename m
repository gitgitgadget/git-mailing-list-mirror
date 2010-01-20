From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC] What to you think about a loose status for
	submodules?
Date: Wed, 20 Jan 2010 19:16:58 +0100
Message-ID: <20100120181652.GA10803@book.hvoigt.net>
References: <20091021160122.GA2067@book.hvoigt.net> <7vy6n4339k.fsf@alter.siamese.dyndns.org> <20091022194446.GA3944@book.hvoigt.net> <7vvdi7fbg3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 19:17:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXf76-0004bV-Cx
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 19:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab0ATSRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 13:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002Ab0ATSRA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 13:17:00 -0500
Received: from darksea.de ([83.133.111.250]:37394 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753649Ab0ATSRA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 13:17:00 -0500
Received: (qmail 1594 invoked from network); 20 Jan 2010 19:16:58 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 20 Jan 2010 19:16:58 +0100
Content-Disposition: inline
In-Reply-To: <7vvdi7fbg3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137560>

On Thu, Oct 22, 2009 at 12:58:04PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > I am not sure what is the best way to create such a group mapping using
> > our config files though. I would like to allow multiple groups/views to
> > have the submodules like:
> > What do you think?
> 
> That, or alternatively:
> 
>     [submodule "doc"]
>         path = Documentation
> 
>     [submodule "help"]
>         path = help
> 
>     [submodule "core"]
>         path = core
> 
>     [submodule "app"]
>         path = app
> 
>     [view "default"]
>         modules = core app
> 
>     [view "doc"]
>         modules = core doc help

Even though there has not been much more work on this item the idea has
become much clearer for me since the last discussion. Now that sparse
checkout is in master I would like to generalize this idea a little
further.

How about adding this to .gitattributes so it can be used for any
file/directory? E.g.:

.gitattributes:
/core           view=default, doc
/app            view=default
/Documentation  view=doc
*.loc           view=doc, default

which could then  be utilized by

  git checkout --view=doc

for example. If no view is given we default to everything.

Does the current sparse implementation work with submodule entries as
well? Then it could be even more straightforward to implement than the
previous idea.

cheers Heiko
