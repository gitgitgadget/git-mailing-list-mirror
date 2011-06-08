From: Jeff King <peff@peff.net>
Subject: Re: Git-Mediawiki : cloning a set of pages
Date: Wed, 8 Jun 2011 13:13:38 -0400
Message-ID: <20110608171338.GA3917@sigill.intra.peff.net>
References: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com>
 <20110608151940.GD7805@sigill.intra.peff.net>
 <BANLkTim54YGYN50gZtqwe8w6-du_aTDWTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"matthieu.moy" <Matthieu.Moy@grenoble-inp.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:13:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMKA-0003cx-SK
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab1FHRNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:13:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58139
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab1FHRNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:13:41 -0400
Received: (qmail 596 invoked by uid 107); 8 Jun 2011 17:13:48 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 13:13:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 13:13:38 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim54YGYN50gZtqwe8w6-du_aTDWTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175405>

On Wed, Jun 08, 2011 at 07:04:27PM +0200, Sverre Rabbelier wrote:

> On Wed, Jun 8, 2011 at 17:19, Jeff King <peff@peff.net> wrote:
> > Maybe it would be even simpler and more flexible to give clone a "-c"
> > flag that writes specific config variables in the newly-created
> > repository.
> 
> This makes a lot of sense. What about a use case like git-svn supports
> currently, where you want to indicate "use the default
> trunk/branches/tags setup"? Yes, you could do `git clone -c defaults
> svn://example.com` and then git-remote-svn can set the relevant config
> options itself. The only downside is that git-remote-svn then needs to
> unset 'defaults' and set the appropriate values itself (to avoid
> cluttering the config file). Thoughts?

Yeah, I'm not sure. There is a similar case in the mediawiki helper
itself, too. If I say:

  git clone -c mediawiki.pagesfiles /path/to/pages mediawiki::...

Should that add config that looks at /path/to/pages every time I fetch?
Should it parse the pages file and load it into the config file as a set
of config options? Should it copy the pages file into the .git directory
and rewrite the config option to point to the local version?

So I think that while setting config options may be useful for some
things, the right model for other things is more like a command-line
option. Maybe we need to offer both forms.

-Peff
