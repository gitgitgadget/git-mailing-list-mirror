From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Fri, 13 Nov 2015 18:41:16 -0500
Message-ID: <20151113234116.GA18234@sigill.intra.peff.net>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net>
 <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:41:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxNy7-0001zE-6G
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 00:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbbKMXlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 18:41:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:57342 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbbKMXlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 18:41:18 -0500
Received: (qmail 18233 invoked by uid 102); 13 Nov 2015 23:41:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 17:41:18 -0600
Received: (qmail 29874 invoked by uid 107); 13 Nov 2015 23:41:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 18:41:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 18:41:16 -0500
Content-Disposition: inline
In-Reply-To: <20151113233807.GD16173@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281275>

On Fri, Nov 13, 2015 at 06:38:07PM -0500, Jeff King wrote:

> On Fri, Nov 13, 2015 at 03:16:01PM -0800, Stefan Beller wrote:
> 
> > Junio wrote on Oct 09, 2014:
> > > This is so non-standard a thing to do that I doubt it is worth
> > > supporting with "git clone".  "git clone --branch", which is about
> > "> I want to follow that particular branch", would not mesh well with
> > > "I want to see the history that leads to this exact commit", either.
> > > You would not know which branch(es) is that exact commit is on in
> > > the first place.
> > 
> > I disagree with this. This is the *exact* thing you actually want to do when
> > dealing with submodules. When fetching/cloning for a submodule, you want
> > to obtain the exact sha1, instead of a branch (which happens to be supported
> > too, but is not the original use case with submodules.)
> 
> I think this is already implemented in 68ee628 (upload-pack: optionally
> allow fetching reachable sha1, 2015-05-21), isn't it?

Note that this just implements the server side. I think to use this with
submodules right now, you'd have to manually "git init && git fetch" in
the submodule. It might make sense to teach clone to handle this, to
avoid the submodule code duplicating what the clone code does.

-Peff
