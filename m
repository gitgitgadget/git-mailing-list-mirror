From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Thu, 15 Apr 2010 02:57:00 -0400
Message-ID: <20100415065700.GA27542@coredump.intra.peff.net>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <201004142212.33162.jnareb@gmail.com>
 <7vbpdlpy5t.fsf@alter.siamese.dyndns.org>
 <201004142329.38914.jnareb@gmail.com>
 <7viq7toh12.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 08:57:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2J15-000898-PN
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 08:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab0DOG5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 02:57:30 -0400
Received: from peff.net ([208.65.91.99]:54939 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab0DOG53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 02:57:29 -0400
Received: (qmail 13274 invoked by uid 107); 15 Apr 2010 06:57:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Apr 2010 02:57:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Apr 2010 02:57:00 -0400
Content-Disposition: inline
In-Reply-To: <7viq7toh12.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144953>

On Wed, Apr 14, 2010 at 02:34:01PM -0700, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Well, this whole idea started with the fact, that "git status --short"
> > was hard (or impossible) to parse unambigously by scripts[1], and even
> > "git status --porcelain -z"[2] is not that easy to parse[3].
> 
> And you apparently seem to agree with that claim, but I don't.  I think
> Jeff (who did the --porcelain stuff; by the way, why did we lose him from
> Cc list?) has already said that he is open to an update.

I haven't seen any evidence that status --porcelain (or its -z form) is
impossible to parse unambiguously. I don't even think it's that hard,
but it certainly could be easier. But more importantly, from looking at
the output it's not necessarily _obvious_ how to parse it correctly
(e.g., whitespace as value and as field separator, syntax of "-z"
depends on semantics of field contents).

The approach I proposed was to leave it be and document it a bit better.
Adding some format that is close but subtly different is just going to
lead to more confusion.

But since Julian was willing to do the JSON work, I think that is a much
nicer approach. It's not subtly different; it's very different and way
easier to read and parse. And I'm really happy with the way he has
structured the code to handle multiple output formats. It keeps the code
much cleaner, and it should silence any "but YAML is better than JSON is
better than XML" debates.

Even with Julian's patches, we should still better document the regular
and "-z" forms. Eric promised to send some patches this week; I'm hoping
he is still interested in doing so after seeing a better solution arise.
:)

-Peff
