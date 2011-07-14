From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 1/6] decorate: allow storing values instead of
 pointers
Date: Thu, 14 Jul 2011 13:34:54 -0400
Message-ID: <20110714173454.GA21657@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713065700.GA18566@sigill.intra.peff.net>
 <20110713175250.GA1448@elie>
 <20110713200814.GD31965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 19:35:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhPoU-0000tv-6Q
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab1GNRe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 13:34:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42986
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198Ab1GNRe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:34:56 -0400
Received: (qmail 8232 invoked by uid 107); 14 Jul 2011 17:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 13:35:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 13:34:54 -0400
Content-Disposition: inline
In-Reply-To: <20110713200814.GD31965@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177137>

On Wed, Jul 13, 2011 at 04:08:14PM -0400, Jeff King wrote:

> I have to say, though, between the alignment issues and the strict
> aliasing, I am tempted to scrap this whole approach and just use macros
> to define the few functions we need. It's not like these containers are
> heterogenous, or that we have a ton of types. Right now we want to map
> "void *" and "uint32_t". In the future, I'd like to map a 20-byte sha1.

So here's what that would look like (at least the decorate part).

Doing macro meta-programming like this makes me feel a little dirty, but
I actually think the result is more readable.

  [1/3]: implement generic key/value map
  [2/3]: fast-export: use object to uint32 map instead of "decorate"
  [3/3]: decorate: use "map" for the underlying implementation

What do you think?

-Peff
