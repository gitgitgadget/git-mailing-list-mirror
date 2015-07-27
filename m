From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Mon, 27 Jul 2015 00:43:52 -0400
Message-ID: <20150727044352.GA27465@peff.net>
References: <20150723012343.GA21000@peff.net>
 <CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
 <20150724074028.GE2111@peff.net>
 <xmqq4mkto9lg.fsf@gitster.dls.corp.google.com>
 <20150725013634.GA7269@peff.net>
 <20150725014722.GA17830@peff.net>
 <xmqqlhe4jgui.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 06:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJaGf-0003DA-5P
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 06:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbbG0En4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 00:43:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:35071 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbbG0Enz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 00:43:55 -0400
Received: (qmail 10591 invoked by uid 102); 27 Jul 2015 04:43:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jul 2015 23:43:55 -0500
Received: (qmail 3637 invoked by uid 107); 27 Jul 2015 04:44:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jul 2015 00:44:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jul 2015 00:43:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhe4jgui.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274648>

On Sat, Jul 25, 2015 at 10:18:45AM -0700, Junio C Hamano wrote:

> > [1] While reading the old "git commit --notes" thread recently, Johan
> >     Herland gave a plausible confusing example:
> >
> >     ...
> >       Why
> >       ---
> >
> >       To show that "---" can be part of a commit message. :)
> 
> That is all true, but such a commit already is problematic when used
> as an input to "am", regardless of where the sign-off goes.

Right, and that is why I think there is no problem at all with treating
"---" specially as part of format-patch. What I was trying to say here
is that doing it for "git commit" is less obviously OK. Many people do
not use "am" at all, and are otherwise fine with a message like the one
above (tools like rebase used to eat their message, but I think that was
fixed long ago).

> We could invent a new and more prominent delimiter, teach
> "format-patch" to add that between the log and patch if and only if
> the log has a three-dashes line in it (with an option to override
> that "if and only if" default), and teach "mailsplit" to pay
> attention to it.  People who are relying on the fact that a
> three-dashes line in the local log message will be stripped off at
> the receiving end have to pass that "The commit has three-dash in it
> as a cut-mark on purpose; don't add that prominent delimiter" option
> when formatting their patches out for submission.
> 
> But I somehow think it is not worth the effort.  It is fairly well
> established that three-dash lines are cut marks and Johan's example
> log message above deliberately violates only to spite itself.  My
> knee-jerk advice is that people can just rephrase s/Why/Reason/ and
> be done with it.

Yeah, I agree it is not worth the effort. Three-dash is a totally fine
micro-format for email messages, and I do not see anybody complaining
about it. I just think that people who do not use "am" should not have
to care about it.

-Peff
