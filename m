From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status
	-u|--untracked-files option
Date: Tue, 3 Jun 2008 18:27:04 -0400
Message-ID: <20080603222704.GA20256@sigill.intra.peff.net>
References: <7viqwvk04y.fsf@gitster.siamese.dyndns.org> <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com> <20080603201421.GB17260@sigill.intra.peff.net> <4845B4E8.1040402@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ezD-0000BZ-H0
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759909AbYFCW1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 18:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759905AbYFCW1I
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:27:08 -0400
Received: from peff.net ([208.65.91.99]:2086 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759896AbYFCW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 18:27:07 -0400
Received: (qmail 1519 invoked by uid 111); 3 Jun 2008 22:27:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 03 Jun 2008 18:27:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2008 18:27:04 -0400
Content-Disposition: inline
In-Reply-To: <4845B4E8.1040402@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83719>

On Tue, Jun 03, 2008 at 11:17:28PM +0200, Marius Storm-Olsen wrote:

> You are right. This is the joy of the parse-options() handling of  
> short-options with optional arguments.
>
> -us before meant:
>     1) commit
>     2) show all untracked files
>     3) sign-of the commit
>
> I guess it would be possible to reparse the options without the -u, if  
> the argument is not one of the three (none,normal,all), but I'm not sure 
> it's _that_ critical. Opinions?

I think it would be reasonable to make "-u" mean the same as always, and
for "--untracked-files" to have an optional argument. There isn't direct
support for that construct in parse_options, but you could just make it
two separate options that happen to tweak the same value (though I guess
they would be displayed separately in the auto-generated usage).

Some GNU utils use this strategy to extend existing options. E.g., "ls
-p" comes from XSI and takes no argument, but the long-option form of
--indicator-style=<none|slash|file-type|classify> gives more options.

That makes it a little less pleasant to type the extended version, but
compatibility is maintained.  Though I tend to wonder about this option
in particular...isn't this generally a user preference? Should it
perhaps be found in the config file instead?

-Peff
