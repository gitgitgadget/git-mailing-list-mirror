From: Jeff King <peff@peff.net>
Subject: Re: upgrading GIT from version 1.7.0.4 to 1.7.6.1.
Date: Mon, 19 Sep 2011 18:44:49 -0400
Message-ID: <20110919224449.GC4056@sigill.intra.peff.net>
References: <1316435430491-6808156.post@n2.nabble.com>
 <4E773A71.6020905@op5.se>
 <20110919190023.GC26115@sigill.intra.peff.net>
 <7vwrd48bq8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	=?utf-8?Q?Mika=C3=ABl?= <mikael.donini@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5ma8-000193-E7
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 00:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806Ab1ISWow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 18:44:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37774
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab1ISWov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 18:44:51 -0400
Received: (qmail 10840 invoked by uid 107); 19 Sep 2011 22:49:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 18:49:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 18:44:49 -0400
Content-Disposition: inline
In-Reply-To: <7vwrd48bq8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181716>

On Mon, Sep 19, 2011 at 02:26:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [2] I suspect a similar thing happened with turning on packed refs
> >     (around the v1.4.4 era?), but I didn't dig around for details.
> 
> Also when bisecting down to really ancient versions of git, you may get
> complaints from the configuration reader. E.g.
> 
>     $ rungit v1.0.0 ls-files
>     fatal: bad config file line 78 in .git/config
>     $ sed -n 78p .git/config
>     [remote "git-gui"]

Ugh, yeah. There are similar problems with some specific config options
(one I run into a lot these days is that "pager.foo" used to complain if
the value was non-boolean, but now you can put in an arbitrary command).
But those only bite you if you start using the new config options (which
you obviously are not doing until after you upgrade).

But your example will bite anyone because git generates remote config
like that by default.

Anyway, most of that is only applicable if you are crossing several
major version boundaries, or are using ancient versions of git. I'm
pretty sure that v1.7.0.x -> v1.7.6.x is pretty safe.

-Peff
