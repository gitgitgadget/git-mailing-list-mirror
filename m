From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Sun, 03 Aug 2008 19:45:38 -0700
Message-ID: <7vabft5wh9.fsf@gitster.siamese.dyndns.org>
References: <1217684549.8296.10.camel@heerbeest>
 <20080802172742.GT32184@machine.or.cz>
 <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
 <1217701021.8296.35.camel@heerbeest> <20080804020931.GA4109@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 04:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPq5w-00052F-62
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 04:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbYHDCpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 22:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbYHDCpq
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 22:45:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbYHDCpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 22:45:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0570D4DBBF;
	Sun,  3 Aug 2008 22:45:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4C24D4DBBE; Sun,  3 Aug 2008 22:45:40 -0400 (EDT)
In-Reply-To: <20080804020931.GA4109@untitled> (Eric Wong's message of "Sun, 3
 Aug 2008 19:09:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FA35A64-61CF-11DD-B0CD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91308>

Eric Wong <normalperson@yhbt.net> writes:

>> I could imagine that leaving git-svn alone and adding a hook to git-log
>> would be more useful, though.
>
> NACK on modifying git-svn to support more changelog formats.

Honestly, I am neutral about this one.  I think it all depends on the
motivation behind the desire to rewrite the log.

If the project that was hosted in Subversion wants to switch (perhaps
gradually) to git, _and_ if the project also wants to adopt a workflow
that does not do the GNU style changelog in the commit log but use a
one-line summary friendly format, then sanitizing the commit log while
importing via git-svn would make sense.  Even though filter-branch after
conversion would be another possibility, that option is only available if
you are converting away from Subversion, never to return.

On the other extreme, if the Subversion side will always be the canonical
one, _or_ if the project does not want to change its commit log format,
then I think it makes perfect sense to limit the commit log munging to the
absolute minimum (but even in such a case, the user can just run git-svn
without activating the log munging option --- so I do not think it is such
a big deal to add or reject an option like this).

> A better idea would be to write a generic script that takes "git log",
> "git svn log" or even plain "svn log" output and filters it
> independently.

That's an independent topic.  If such a filter supports a feature like our
shortlog command has, people whose history is still trapped in Subversion
would benefit from it.
