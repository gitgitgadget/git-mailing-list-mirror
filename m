From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 19:22:53 -0500
Message-ID: <20090214002253.GA7769@coredump.intra.peff.net>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com> <1234515275-91263-2-git-send-email-jaysoffian@gmail.com> <1234515275-91263-3-git-send-email-jaysoffian@gmail.com> <1234515275-91263-4-git-send-email-jaysoffian@gmail.com> <1234515275-91263-5-git-send-email-jaysoffian@gmail.com> <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 01:24:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY8Kq-0001VB-LU
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 01:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759537AbZBNAW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 19:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbZBNAW6
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 19:22:58 -0500
Received: from peff.net ([208.65.91.99]:56162 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826AbZBNAW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 19:22:57 -0500
Received: (qmail 27030 invoked by uid 107); 14 Feb 2009 00:23:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 19:23:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 19:22:53 -0500
Content-Disposition: inline
In-Reply-To: <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109789>

On Fri, Feb 13, 2009 at 02:09:01AM -0800, Junio C Hamano wrote:

> The entire series looks sane from a very cursory look; especially the
> earlier ones are obviously good.

I also think it looks good. You raised a few style points below which I
thought were sensible and won't bother repeating.

> Hmph, what does "-a" stand for?  I would have expected to see "-u" that
> stands for "update" here.

It was immediately obvious to me as "auto" (I think I even suggested
"-a" in another thread, so maybe that is why it seems so sensible to
me). However, I think as a rule it is nice to always provide a "long"
alternative for every option. With parse-options, there really is no
downside; it is literally s/0/"auto"/ on the option line. And I think
it:

  - lets people who want to illustrate a command in a more readable
    manner do so (e.g., if they are showing it to somebody else)

  - makes it more obvious in the documentation and usage message what
    the command does. That is, I remember commands much better as "this
    is the --auto option, whose meaningful name reminds me that it does
    X, and -a is the obvious shorthand" rather than "-a does X".

  - enables extra parse-options syntax like automatic "--no-" handling
    (though I doubt anyone is likely to use "--no-auto" in this case,
    the point is that it is easier to allow such constructs consistently
    than to try to guess when people might want it)

Which is maybe more argument than you cared to read about this
particular option, but I want to make clear that I think this should be
the case for just about every command-line option we add.

> Also it may be better to be more explicit about both the syntax and the
> semantics of `<branch>`.  Do you expect "refs/remotes/<name>/master" or
> just "master" (I assume the latter)?  Is it an error if the branch does

I thought it was obvious that you would do:

  git remote set-head master

in the same way that you would do:

  git remote add -m master $remote $url

But I suppose clarifying it doesn't hurt.

-Peff

PS There is a thread elsewhere on the list discussing "what can I do to
make life easy for reviewers?". I think this series (and Jay's patches
in general) model many good behaviors: clearly labeled versions,
discussion of what changed in each version, proper threading, and cc'ing
people who have been involved.
