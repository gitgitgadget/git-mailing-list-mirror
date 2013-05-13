From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] teach the user to be nice to git and let him say
 please sometimes
Date: Mon, 13 May 2013 15:30:35 +0200
Message-ID: <20130513133035.GA3561@book-mint>
References: <20130511201928.GA22938@book.hvoigt.net>
 <CACsJy8A+vjtwnB0LStVS3Q9v2JaKcMDa0sATr9H==X3EhQt6Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 15:31:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubsqh-0004xI-2f
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab3EMNbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:31:09 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.44]:58362 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab3EMNat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:30:49 -0400
Received: from [77.23.112.173] (helo=book-mint)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Ubspw-0004L0-7c; Mon, 13 May 2013 15:30:45 +0200
Content-Disposition: inline
In-Reply-To: <CACsJy8A+vjtwnB0LStVS3Q9v2JaKcMDa0sATr9H==X3EhQt6Jg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224133>

On Sun, May 12, 2013 at 05:23:15PM +0700, Duy Nguyen wrote:
> On Sun, May 12, 2013 at 3:20 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > Since ages we do not care about our program enough. Lets not treat them
> > as slaves anymore and say please.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> > Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> > Signed-off-by: Johan Herland <johan@herland.net>
> 
> A product of Git Berlin Meetup?

Yep :-)

> > +static void check_politeness(const char *cmd)
> > +{
> > +       const char *user_config;
> > +       struct strbuf buf = STRBUF_INIT;
> > +
> > +       if (getenv("GIT_POLITENESS_CHECK_PASSED"))
> > +               return;
> > +
> > +       setenv("GIT_POLITENESS_CHECK_PASSED", "Yes", 1);
> > +
> > +       git_config_early(read_polite_counter, NULL, NULL);
> > +       if (!strcmp(cmd, "please")) {
> > +               impolite_counter = 0;
> > +               polite_counter++;
> > +       } else {
> > +               impolite_counter++;
> > +               polite_counter = 0;
> > +       }
> > +
> > +       if (impolite_counter > 10)
> > +               die("Error: Learn some manners, say please some time!");
> > +       if (polite_counter > 10)
> > +               die("Error: Too many please! I don't believe you.");
> 
> NAK. If we truly care, we need better AI here!

I agree but this patches goal was to implement the basic politeness
infrastructure. We planned to add more features, like inter-repository
jealousy, later. For inter-repository jealousy git would complain if you
worked more with one repository than others you cloned and you'd for
example sometimes need a double please to satisfy it.

Cheers Heiko
