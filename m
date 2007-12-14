From: Jeff King <peff@peff.net>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 23:08:03 -0500
Message-ID: <20071214040803.GA10169@sigill.intra.peff.net>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org> <20071213180347.GE1224@artemis.madism.org> <1197570521.28742.0.camel@hinata.boston.redhat.com> <1197571656.28742.13.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 05:08:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J31qr-0007e4-FR
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 05:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761845AbXLNEII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 23:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761798AbXLNEIH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 23:08:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4481 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761288AbXLNEIG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 23:08:06 -0500
Received: (qmail 14781 invoked by uid 111); 14 Dec 2007 04:08:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 13 Dec 2007 23:08:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2007 23:08:03 -0500
Content-Disposition: inline
In-Reply-To: <1197571656.28742.13.camel@hinata.boston.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68217>

On Thu, Dec 13, 2007 at 01:47:36PM -0500, Kristian H=F8gsberg wrote:

> Oops, sorry about that.  I just wanted to say we shouldn't jump throu=
gh
> all these hoops to make the option parser support every type of optio=
n
> there ever was in the git command line ui.  A lot of these were proba=
bly
> decided somewhat arbitrarily by whoever implemented the command.
> Instead it's an opportunity to retroactively enforce some consistency
> and predictability to the various option-styles that have been
> hand-rolled over time in different git commands.

I agree. I am already a little bit uncomfortable with the "--abbrev 10"
won't work but "--foo 10" will, because it requires that the user
remember which arguments are optional and which are required. But
switching it to "--abbrev 10 works, but --abbrev $foo does not, unless
of course $foo is an integer, in which case you must use --abbrev=3D$fo=
o"
is just a little bit too DWIM. E.g., if you are scripting, it's just on=
e
more source of error (if I have $foo, how must I write --abbrev $foo fo=
r
it to ensure that I _don't_ trigger the optional argument?).

-Peff
