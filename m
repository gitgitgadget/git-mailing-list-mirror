From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Fri, 10 Dec 2010 16:30:17 -0500
Message-ID: <20101210213017.GA14256@sigill.intra.peff.net>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com>
 <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com>
 <20101209015926.GA31119@burratino>
 <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
 <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com>
 <20101210190332.GA6210@burratino>
 <66D6F30D-4707-4057-BB46-57B2DF01F479@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Yann Dirson <dirson@bertin.fr>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Dec 10 22:30:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRAXs-0005LA-OZ
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 22:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab0LJVaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 16:30:23 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37464 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab0LJVaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 16:30:22 -0500
Received: (qmail 23516 invoked by uid 111); 10 Dec 2010 21:30:19 -0000
Received: from 129-79-255-141.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.141)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 10 Dec 2010 21:30:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Dec 2010 16:30:17 -0500
Content-Disposition: inline
In-Reply-To: <66D6F30D-4707-4057-BB46-57B2DF01F479@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163441>

On Fri, Dec 10, 2010 at 01:21:15PM -0800, Kevin Ballard wrote:

> On Dec 10, 2010, at 11:03 AM, Jonathan Nieder wrote:
> 
> > - What is the intended use for this family of modifiers?  I sort
> >   of understand ^{:i/... } for people that forget what case they
> >   have used, but why the :nth and others?
> 
> In my particular case, I was glancing through the logs, and I wanted to grab
> the second branch that someone else had made that was merged into pu. I would
> have loved to be able to run something like
> 
>   git merge origin/pu^{:nth(2)/nd/}
> 
> While we're speaking of modifiers, could we use one that says "only search
> the first parent hierarchy", e.g. something equivalent to git log's --first-parent
> flag?

As neat as this modifier syntax is getting, are we perhaps just
recreating the wheel?

How about:

  git merge `git rev-list -2 --grep=nd/ origin/pu | tail -1`

for the nth one, and:

  git merge `git rev-list --first-parent -1 --grep=nd/ origin/pu`

for a first parent search (I will leave combining them as an exercise to
the reader).

It's not that I'm opposed to a handy ref-specifying syntax. I just
wonder if it is really worth building in all of these obscure scenarios.

-Peff
