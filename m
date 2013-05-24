From: John Keeping <john@keeping.me.uk>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 11:40:18 +0100
Message-ID: <20130524104018.GB27005@serenity.lan>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <20130523235711.GJ12252@machine.or.cz>
 <20130524082253.GY27005@serenity.lan>
 <20130524094006.GM12252@machine.or.cz>
 <20130524100612.GA27005@serenity.lan>
 <20130524101416.GO12252@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri May 24 12:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfpQJ-0003gA-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 12:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab3EXKkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 06:40:31 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:35298 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab3EXKk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 06:40:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 69BF460657F;
	Fri, 24 May 2013 11:40:28 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07Oo0w36N6Qb; Fri, 24 May 2013 11:40:28 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 005F560658B;
	Fri, 24 May 2013 11:40:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130524101416.GO12252@machine.or.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225344>

On Fri, May 24, 2013 at 12:14:16PM +0200, Petr Baudis wrote:
> On Fri, May 24, 2013 at 11:06:12AM +0100, John Keeping wrote:
> > I don't see anything wrong with having a template file documenting the
> > parameters, but I think it's important that there are sensible defaults
> > in place when the user's configuration file does not specify a value for
> > a parameter.  It wasn't clear to me from your definition that there were
> > defaults to be overridden by the user's configuration file, as opposed
> > to forcing the user to define certain values and causing an error if
> > those are not defined.
> 
> That's the case in plenty of situations - when specifying usernames and
> passwords and server hostnames, paths to cross-compiling environments
> that pretty much everyone has at a different place, and so on.

Yeah, I didn't mean to say that everything can have a sensible default.

Going back to where this started, in the omxplayer Makefile, I would map
my suggestion to a change like this:

    * Change most of the ":=" in Makefile.include to "=" so that the
      order of variable definition matters less
    * Move Makefile.include to Makefile.defaults
    * Change the "include Makefile.include" at the top of Makefile to:

        include Makefile.defaults
        -include Makefile.config
    
    * Add Makefile.config to .gitignore

So that it continues to Just Work for people using buildroot but you can
create Makefile.config to override those defaults.

I agree that this isn't possible in all cases, and your template
approach is certainly useful for configuration files - particularly
because those templates can be included in end-user documentation or the
installation as they are likely to be needed in the installed
application and not just development.
