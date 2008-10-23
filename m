From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/5] add valgrind support in test scripts
Date: Thu, 23 Oct 2008 11:19:59 -0400
Message-ID: <20081023151959.GA10804@coredump.intra.peff.net>
References: <20081022202810.GA4439@coredump.intra.peff.net> <20081022202915.GA4547@coredump.intra.peff.net> <alpine.DEB.1.00.0810230008430.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 23 17:23:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt20G-0000WJ-BX
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 17:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbYJWPUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 11:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbYJWPUE
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 11:20:04 -0400
Received: from peff.net ([208.65.91.99]:2344 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396AbYJWPUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 11:20:03 -0400
Received: (qmail 10241 invoked by uid 111); 23 Oct 2008 15:20:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 11:20:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 11:19:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810230008430.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98971>

On Thu, Oct 23, 2008 at 12:13:47AM +0200, Johannes Schindelin wrote:

> I wonder if it would not be better to scrap the t/valgrind/ directory and 
> regenerate it everytime you run a test manually;

Yeah, I mentioned that in my 0/5 cover letter. The problem is where to
put it that won't impact test results, but also allow running multiple
tests simultaneously. I'm going to try sticking it in .git/valgrind in
the trash directory, which presumably won't affect any tests.

> I'd use "ln" instead of "cp"

I specifically stayed away from 'ln' for Windows portability. It looks
like for builtins, we do "ln || ln -s || cp". We can probably do the
same here.

I also failed to use git$X in the fake path, which would probably be
necessary for Windows.

> and also parse command-list.txt to catch really all of them (even if 
> a dashed form is used for a builtin by mistake).

That is a little bit trickier. I don't actually want to intercept
git-am, for example, since I have no interest in running valgrind on the
shell. But it is do-able; I will give details in my response to Junio's
suggestion.

> Otherwise: good work, I like it!

Thanks.

-Peff
