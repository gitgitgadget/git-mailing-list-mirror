From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/diff-highlight: multibyte characters diff
Date: Wed, 12 Feb 2014 20:37:51 -0500
Message-ID: <20140213013751.GA11355@sigill.intra.peff.net>
References: <1392109750-47852-1-git-send-email-sugi1982@gmail.com>
 <20140212205948.GA4453@sigill.intra.peff.net>
 <CA+39Oz5TSPNzYVvFytJwwUhRYjbEp5f_BdBWKT2tcYzpbF1WyQ@mail.gmail.com>
 <20140212232740.GA11098@sigill.intra.peff.net>
 <20140213011753.GD4582@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Thomas Adam <thomas@xteddy.org>,
	Yoshihiro Sugi <sugi1982@gmail.com>,
	git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 13 02:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDlFV-0000s6-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 02:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbaBMBhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 20:37:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:49525 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752676AbaBMBhx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 20:37:53 -0500
Received: (qmail 18532 invoked by uid 102); 13 Feb 2014 01:37:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Feb 2014 19:37:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Feb 2014 20:37:51 -0500
Content-Disposition: inline
In-Reply-To: <20140213011753.GD4582@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242039>

On Thu, Feb 13, 2014 at 01:17:54AM +0000, brian m. carlson wrote:

> On Wed, Feb 12, 2014 at 06:27:40PM -0500, Jeff King wrote:
> > On Wed, Feb 12, 2014 at 11:10:49PM +0000, Thomas Adam wrote:
> > 
> > > On 12 February 2014 20:59, Jeff King <peff@peff.net> wrote:
> > > > +sub decode {
> > > > +       my $orig = shift;
> > > > +       my $decoded = eval { decode_utf8($orig, Encode::FB_CROAK) };
> > > > +       return defined $decoded ?
> > > 
> > > I'd still advocate checking $@ here, rather than the defined $decoded check.
> > 
> > I don't mind changing it, but for my edification, what is the advantage?
> 
> The documentation for decode_utf8 isn't clear, but I don't know if it
> can ever return undef.  What, for example, does it return if $orig is
> not defined?  That's the benefit: it's immediately clear to the user
> that you're interested in whether it threw an exception, rather than
> whether it produced a given value.

I'd argue that I am more interested in whether it returned a value. Let
us imagine for a moment that decode_utf8 could return undef without
throwing an exception. What should the function return in such a case?

I think the only sensible thing is the original (and to indicate that
the result was not converted).

-Peff
