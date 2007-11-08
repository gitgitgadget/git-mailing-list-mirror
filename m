From: Jeff King <peff@peff.net>
Subject: Re: git rebase --skip
Date: Thu, 8 Nov 2007 18:16:32 -0500
Message-ID: <20071108231632.GC29840@sigill.intra.peff.net>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net> <20071108102412.GA31187@atjola.homenet> <4732E5A8.3020101@op5.se> <20071108104403.GB31187@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 00:35:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqGsm-00081H-Oh
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 00:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbXKHXXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 18:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753581AbXKHXXT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 18:23:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1538 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbXKHXXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 18:23:19 -0500
Received: (qmail 19392 invoked by uid 111); 8 Nov 2007 23:16:34 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 Nov 2007 18:16:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2007 18:16:32 -0500
Content-Disposition: inline
In-Reply-To: <20071108104403.GB31187@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64086>

On Thu, Nov 08, 2007 at 11:44:03AM +0100, Bj=F6rn Steinbrink wrote:

> > How about if the state to skip was stashed, the patch reapplied and=
 the
> > differences compared. If they were identical, go ahead and force th=
e
> > reset --hard, otherwise abort. That way, --skip will dwim only when
> > it's safe, and all the lost work can be automagically created by
> > just re-applying the patch again?
>=20
> I'd prefer the --force option suggested in some other mail. Maybe I'm
> just not manly enough, but messing up a rebase can mean lots of
> duplicated work, so I'm rather happy with no dwim at all. Maybe for t=
he
> real manly users out there, add a rebase.alwaysForce option so they c=
an
> laugh at me for not using that ;-)

Personally, I don't see the point of a --force option; it turns your wo=
rk
flow from:

  1. git-rebase --skip
  2. Oops, I guess I have to reset.
  3. git-reset --hard; git-rebase --skip

to:

  1. same as above
  2. same as above
  3. git-rebase --force --skip

I guess it's a little bit easier to explain to new users, but it in no
way eliminates the annoyance of "I expected this to work, and it
didn't, so now I have to think about what happened and enter another
command."

AIUI, Andreas's proposal is not so much DWIM as "do the obvious thing,
but include a safety valve to prevent throwing away work." Is there
actually a case where it would not have the desired effect?

-Peff
