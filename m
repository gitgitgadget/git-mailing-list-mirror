From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Tue, 09 Sep 2008 14:38:31 -0700
Message-ID: <7vljy13sq0.fsf@gitster.siamese.dyndns.org>
References: <20080910062529.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAw7-0002MJ-8v
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYIIVij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbYIIVij
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:38:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbYIIVij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:38:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DCD4A5AA56;
	Tue,  9 Sep 2008 17:38:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 17E4B5AA55; Tue,  9 Sep 2008 17:38:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A98091B6-7EB7-11DD-8C9B-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95443>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> The environment variable CVS_SERVER is still set to "git-cvsserver",
> because tests fail with CVS_SERVER='git cvsserver' (or double quotes).

My eyes are getting dry after looking at these s/git-/git / patches, so
please do not get offended if I leave these in my Inbox unread for a few
days.

But I think this particular one is worth mentioning something about, so I
am responding to it now.

To me, the above suggests that:

 * we should install git-cvsserver in $(bindir) so that it can be found on
   $PATH; and

 * it would be better to encourage users to consistently use
   "git-cvsserver" everywhere instead of "git cvsserver"; hence

 * this [6/6] in the series should be discarded.

We already install "server side programs" in $(bindir).

When we think about any of these server side programs, we do not think of
it as a feature chosen by the subcommand word on the command line given to
a program "git" (even though for built-ins, internal implementation might
allow such usage).

Instead we think of it as a single freestanding program in git suite.  For
example, when people talk about "You can use git-shell as your user's
login shell to limit the potential damage to your system", they do not
mean "the shell subcommand of git", but they mean the git-shell "program".

We do not run "git in daemon mode", but run "git-daemon" which is the
daemon program that serves native git protocol.

So why don't we do this (not just for test but for documentation as well)?

 * We do not use "git foo" form when refering to the "server side
   programs".  Make it official;

 * We move "server side programs" in git(7) documentation into its
   separate subsection; and

 * We always install "server side programs" in $(bindir).

I think git-cvsserver is the last one we missed from the set of server
side programs (git-cvsserver, git-daemon, git-receive-pack,
git-upload-archive, git-upload-pack).
