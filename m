From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-commit: search author pattern against mailmap
Date: Fri, 23 Aug 2013 14:35:41 -0400
Message-ID: <20130823183541.GB30130@sigill.intra.peff.net>
References: <1377265711-11492-1-git-send-email-apelisse@gmail.com>
 <xmqqbo4opajg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 20:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCwD6-0004LD-71
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 20:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab3HWSfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 14:35:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:39324 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab3HWSfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 14:35:43 -0400
Received: (qmail 13450 invoked by uid 102); 23 Aug 2013 18:35:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 13:35:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 14:35:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbo4opajg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232821>

On Fri, Aug 23, 2013 at 10:44:03AM -0700, Junio C Hamano wrote:

> My initial reaction was "Why should something as important as 'git
> commit' should be playing a guessing-game?" ;-) and I am kind of
> ashamed to have added 146ea068 (git commit --author=$name: look
> $name up in existing commits, 2008-08-26) and then am embarrased to
> have completely forgotten about it. I never use the feature myself.
> 
> But for that old and established "--author parameter that does not
> use the standard format guesses" feature to be useful, I agree that
> it should honor the mailmap.
> 
> I wonder if it would hurt anybody if we made this unconditional, not
> even with "--no-mailmap" override? Opinions?

I think it would be OK. You can always override by giving the actual
full address you want instead of a partial one. And if somebody is not
up to date in the .mailmap file, maybe this would be a good hint that
you should take care of that. :)

I paused for a second, thinking that such advice might not be good for
people who do not want to make an official change to upstream's
.mailmap (e.g., because they do not want to pollute a long-running fork
that will need to merge from upstream, or do not want to pollute a topic
branch with an unrelated commit). But I forgot that we have
mailmap.file, if they want something custom.

So I think anyone for whom the mailmap lookup does not provide the right
answer will fall into one of two groups:

  1. A one-off, which can be overridden by specifying the address you
     do want.

  2. Somebody you will be mentioning frequently; bother to set up
     a mailmap.file.

As an aside, it seems silly that we do not respect $GIT_DIR/mailmap by
default, even without a config option. But I doubt that anybody cares
too much, if nobody has raised the issue in all of these years.

-Peff
