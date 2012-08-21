From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Tue, 21 Aug 2012 15:40:49 -0400
Message-ID: <20120821194049.GB15667@sigill.intra.peff.net>
References: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
 <20120821023033.GB20271@sigill.intra.peff.net>
 <CAFFUb6UypNJ-8p8Hs14+QMGeU3KSG+pQX7NJTeh3OtBoTZoO3g@mail.gmail.com>
 <7vzk5ocdg7.fsf@alter.siamese.dyndns.org>
 <CAFFUb6XMGgG=6uUzd0Xs1TXWFbJhDpMz1FeFdC8jHqaRi8Y58A@mail.gmail.com>
 <7vvcgccaol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conley Owens <cco3@android.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 21:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3uJv-0002tK-0R
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 21:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957Ab2HUTkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 15:40:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44063 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756635Ab2HUTkv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 15:40:51 -0400
Received: (qmail 2127 invoked by uid 107); 21 Aug 2012 19:41:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 15:41:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 15:40:49 -0400
Content-Disposition: inline
In-Reply-To: <7vvcgccaol.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203988>

On Tue, Aug 21, 2012 at 12:22:18PM -0700, Junio C Hamano wrote:

> Conley Owens <cco3@android.com> writes:
> 
> > Yes, that's the upstart I'm referring to.  This makes sense.  However, it's a
> > confusing situation to run into.  Would a warning about an unset $HOME be
> > appropriate?
> 
> Unsetting HOME is an easy way to skip what is in ~/.gitconfig when
> helping other people on this list, and I wouldn't mind such a
> warning while I knowingly unset it, I can imagine other helpful
> people may find such a warning irritating and complain "I know I do
> not have $HOME set, as I earlier explicitly did unset it myself!".
> 
> So, I am on the fence on this one, but because
> 
>  (1) no warning would mean upstart scripts writers need to be aware
>      of lack of $HOME, but they need to be aware of it for reasons
>      unrelated to Git anyway; and
> 
>  (2) a warning while trying vanilla Git behaviour to help others
>      might be irritating, it is not an every day use anyway.
> 
> I do not think it matters either way in practice.

I do not use upstart, but presumably it logs the stderr of jobs it runs.
Which means that a warning about unset $HOME would help debugging for
people who care about looking in ~/.gitconfig, but would become a noisy
nuisance for people whose jobs did not care.

Personally, I think it would be much friendlier of upstart to give the
user's jobs a sane minimal environment. That is what cron has always
done, setting HOME, LOGNAME, and SHELL. But that is my uninformed
5-second opinion as a long-time Unix user; I have not looked at upstart
at all, so perhaps there is some argument I haven't seen.

-Peff
