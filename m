From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message
 configurable
Date: Mon, 7 Sep 2009 04:24:31 -0400
Message-ID: <20090907082430.GA17997@coredump.intra.peff.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
 <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
 <20090906072322.GA29949@coredump.intra.peff.net>
 <7vzl98fr22.fsf@alter.siamese.dyndns.org>
 <20090907094457.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZX6-0003I2-DX
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbZIGIYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZIGIYc
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:24:32 -0400
Received: from peff.net ([208.65.91.99]:47363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbZIGIYc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:24:32 -0400
Received: (qmail 15629 invoked by uid 107); 7 Sep 2009 08:24:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Sep 2009 04:24:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Sep 2009 04:24:31 -0400
Content-Disposition: inline
In-Reply-To: <20090907094457.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127903>

On Mon, Sep 07, 2009 at 09:44:57AM +0900, Nanako Shiraishi wrote:

> > Speaking of which, has anybody felt annoyed by this message?
> >
> >     $ git reset --hard HEAD^^
> >     HEAD is now at 3fb9d58 Do not scramble password read from .cvspass
> >
> > This is not "maybe you should try this", but I would consider that it
> > falls into the same "I see you are trying to be helpful, but I know what I
> > am doing, and you are stealing screen real estate from me without helping
> > me at all, thank you very much" category.
> 
> You may be fixated at the sha1 part of the message when you find this
> message annoying, but I disagree strongly. I always appreciate the
> assurance this message gives me that I counted the number of commits
> correctly, whether I say HEAD^^^^ or HEAD~7.

Let me add a "me too" to Nanako's comments. This assurance has actually
saved me in the past from accidentally going to the wrong commit (just
the other day I did a rebase followed by "git reset --hard HEAD@{1}",
when of course what I meant was "git reset --hard master@{1}".

I think this type of message is different from the other "advice"
messages.

In the case of the push non-fast-forward message and the status "here is
how you stage" comments, those messages are not specific to this exact
situation. They are general advice for "if you do not understand or need
a reminder of how git works, this is it." Experienced users know how git
works, so the messages are just clutter.

This message, on the other hand, tells you about this _specific_
instance. So even if you have mastered git, the information can reassure
you that you have gone to the intended commit (and yes, I have actually
gone to the wrong commit before, noticed it via this reset message, and
corrected the situation).

So really they are two different conceptual types of message. And while
I have no problem with an argument of "I _personally_ find this clutter
and would like to configure it off", I don't think such an option should
go under "advice.*". My patch had "message.all" (which will become
"advice.all") to turn off all advice messages, which can act as a sort
of "I am an expert" switch. But because this type of message is
conceptually different, it should not be lumped in with the others.

OTOH, I am open to arguments against "advice.all"; maybe it is a good
thing for users to manually say "this message is annoying me, and
therefore I am now an expert in this particular area". It's not like
there are more than two. ;)

-Peff
