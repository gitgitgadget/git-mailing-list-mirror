From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v20 00/48] Use ref transactions
Date: Wed, 9 Jul 2014 01:02:26 -0400
Message-ID: <20140709050226.GA2318@sigill.intra.peff.net>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
 <53BC1C53.9030203@alum.mit.edu>
 <xmqqa98jadqx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:02:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4k1Y-0000xB-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 07:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbaGIFC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 01:02:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:58470 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbaGIFC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 01:02:28 -0400
Received: (qmail 22229 invoked by uid 102); 9 Jul 2014 05:02:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 00:02:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 01:02:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa98jadqx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253061>

On Tue, Jul 08, 2014 at 11:48:06AM -0700, Junio C Hamano wrote:

> I'd say that "if you have foo/bar you cannot have foo" may have
> started as an implementation limitation, but the interoperability
> requirement with existing versions of Git and with existing
> repositories makes it necessary to enforce it the same way as other
> rules such as "you cannot have double-dots in name, e.g. foo..bar"
> or "no branches whose name begins with a dash", neither of which
> comes from any filesystem issues.  That a rule can be loosened with
> one new backend does not at all mean it is a good idea to loosen it
> "because we can" in the first place.

To me it makes sense to to have it as an option, for two reasons:

  1. If you want to pay the compatibility cost (e.g., because you work
     with a defined set of users on a small project and can dictate how
     they set their git options), you get the extra feature.

  2. It provides a migration path if we eventually want to move to a
     default backend that allows it.

I admit that I don't care _too_ much, though. My main desire for it is
not to store two live branches that overlap, but to store reflogs for
deleted branches without conflicting with live branches.

And of course all of this is getting rather ahead of ourselves. We do
not have _any_ alternate backends yet, nor even yet the infrastructure
to make them.

-Peff
