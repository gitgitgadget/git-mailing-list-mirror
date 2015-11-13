From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Fri, 13 Nov 2015 18:38:07 -0500
Message-ID: <20151113233807.GD16173@sigill.intra.peff.net>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net>
 <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:38:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxNv6-0006M2-AI
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 00:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbbKMXiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 18:38:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:57335 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750931AbbKMXiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 18:38:10 -0500
Received: (qmail 17923 invoked by uid 102); 13 Nov 2015 23:38:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 17:38:10 -0600
Received: (qmail 29833 invoked by uid 107); 13 Nov 2015 23:38:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 18:38:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 18:38:07 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281274>

On Fri, Nov 13, 2015 at 03:16:01PM -0800, Stefan Beller wrote:

> Junio wrote on Oct 09, 2014:
> > This is so non-standard a thing to do that I doubt it is worth
> > supporting with "git clone".  "git clone --branch", which is about
> "> I want to follow that particular branch", would not mesh well with
> > "I want to see the history that leads to this exact commit", either.
> > You would not know which branch(es) is that exact commit is on in
> > the first place.
> 
> I disagree with this. This is the *exact* thing you actually want to do when
> dealing with submodules. When fetching/cloning for a submodule, you want
> to obtain the exact sha1, instead of a branch (which happens to be supported
> too, but is not the original use case with submodules.)

I think this is already implemented in 68ee628 (upload-pack: optionally
allow fetching reachable sha1, 2015-05-21), isn't it?

> If the server contains at least one superproject/submodule, there is a legit
> use case for fetching an exact sha1, which isn't a tip of a branch, but may
> be in any branch  or even in no branch at all.

The patch above doesn't handle "no branch at all", but I'm not sure if
we want to (it violates git's usual access model; moreover, a git
repository does not necessarily have all ancestors of an unreachable
object, though these days it usually does).

-Peff
