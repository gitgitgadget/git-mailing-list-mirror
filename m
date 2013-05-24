From: John Keeping <john@keeping.me.uk>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 11:06:12 +0100
Message-ID: <20130524100612.GA27005@serenity.lan>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <20130523235711.GJ12252@machine.or.cz>
 <20130524082253.GY27005@serenity.lan>
 <20130524094006.GM12252@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri May 24 12:06:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfotJ-0001dm-D5
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 12:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760340Ab3EXKGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 06:06:25 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:50863 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760240Ab3EXKGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 06:06:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D218D60655A;
	Fri, 24 May 2013 11:06:23 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUcci94+b70e; Fri, 24 May 2013 11:06:22 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 3A4FB60657E;
	Fri, 24 May 2013 11:06:14 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130524094006.GM12252@machine.or.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225339>

On Fri, May 24, 2013 at 11:40:07AM +0200, Petr Baudis wrote:
> On Fri, May 24, 2013 at 09:22:53AM +0100, John Keeping wrote:
> > On Fri, May 24, 2013 at 01:57:12AM +0200, Petr Baudis wrote:
> > >   Just to clear up on what the best practice is, I'd imagine the setup
> > > to be something like:
> > > 
> > > 	(a) Makefile contains inclusion of Makefile.include.
> > > 
> > > 	(b) There is a file like Makefile.include.template containing
> > > 	a template to be copied over and filled by the user.
> > > 
> > > 	(c) Makefile contains code that makes sure all variables that
> > > 	are supposed to be set are set and obsolete variables are not,
> > > 	since there is no mechanism to cause e.g. a merge conflict
> > > 	on change of Makefile.include.template.
> > > 
> > > Is there a better way to solve this?
> > 
> > I think the best practice would be what Git itself does ;-)
> > 
> > The Makefile sets default values for all parameters, some of which are
> > inferred based on the system.  It then includes config.mak, which allows
> > the user to override any of these values.
> 
> So that's pretty similar to what I described, modulo the filenames.
> I'd say it's more friendly if you don't need to tweak any of the
> defaults in the common case, but less friendly if you always need to
> tweak something/everything (you really want a template file then
> and not covering (c) is a problem).

I don't see anything wrong with having a template file documenting the
parameters, but I think it's important that there are sensible defaults
in place when the user's configuration file does not specify a value for
a parameter.  It wasn't clear to me from your definition that there were
defaults to be overridden by the user's configuration file, as opposed
to forcing the user to define certain values and causing an error if
those are not defined.
