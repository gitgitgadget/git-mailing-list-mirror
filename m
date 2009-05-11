From: Jeff King <peff@peff.net>
Subject: Re: (revised) What's cooking in git.git (May 2009, #01; Sat, 09)
Date: Mon, 11 May 2009 05:35:50 -0400
Message-ID: <20090511093550.GB5685@coredump.intra.peff.net>
References: <7vk54p30uu.fsf@alter.siamese.dyndns.org> <7vab5kwuoz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 11:36:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3RvX-00078d-Bu
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 11:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbZEKJfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 05:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZEKJft
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 05:35:49 -0400
Received: from peff.net ([208.65.91.99]:43142 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbZEKJft (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 05:35:49 -0400
Received: (qmail 25743 invoked by uid 107); 11 May 2009 09:36:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 11 May 2009 05:36:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 May 2009 05:35:50 -0400
Content-Disposition: inline
In-Reply-To: <7vab5kwuoz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118786>

On Sun, May 10, 2009 at 01:48:28PM -0700, Junio C Hamano wrote:

> * jk/maint-add-empty (Tue Apr 28 23:21:01 2009 -0400) 1 commit
>  - add: don't complain when adding empty project root
> 
> When you say "git add ." in an empty directory, you get "No path matches
> ''", instead of "No path matches '.'", and this "fixes" it by hiding the
> error and making the command silently succeed.  Strictly speaking it
> introduces inconsistency, but I think an empty directory is so
> uninteresting special case that not signalling it as an error is Ok.
> 
> Will merge to 'next'.

Actually, it is less invasive than that. It _already_ silently ignores
empty directories, like "mkdir foo && git add foo". And because of the
way we chdir to the project root, that is equivalent to "mkdir foo && cd
foo && git add .".

This just extends the behavior to the project root ("mkdir foo && cd foo
&& git init && git add ."). So arguably it is reducing inconsistency. :)

> * jk/no-no-no-empty-directory (Fri May 8 01:01:17 2009 -0400) 2 commits
>  + parseopt: add OPT_NEGBIT
>  + parseopt: add OPT_NEGBIT
> 
> I somehow botched the commit log message of the top one; it is about
> fixing "ls-files --no-empty-directory".

Too bad it is not possible to rewind 'next'. ;)

> * jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
>  - Allow --date=local --date=other-format to work as expected
> 
> The one I posted had a few corner-case bugs that was caught with the test
> suite; this one has them fixed.  People did not like the UI so it is kept
> out of 'next'

This one has been sitting for a while. I was one of the complainers. If
there is interest, I can rework it according to our previous discussion
(but I'm beginning to wonder if anybody actually cares about this
patch).

-Peff
