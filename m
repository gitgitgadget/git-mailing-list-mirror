From: Jeff King <peff@peff.net>
Subject: Re: how to clone/checkout branch/tag vesion from GIT repository
Date: Thu, 10 May 2012 09:56:05 -0400
Message-ID: <20120510135605.GA1495@sigill.intra.peff.net>
References: <1336657187852-7546744.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Thu May 10 15:56:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSTqx-000102-Pd
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 15:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758755Ab2EJN4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 09:56:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38743
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758034Ab2EJN4I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 09:56:08 -0400
Received: (qmail 28301 invoked by uid 107); 10 May 2012 13:56:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 09:56:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 09:56:05 -0400
Content-Disposition: inline
In-Reply-To: <1336657187852-7546744.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197564>

On Thu, May 10, 2012 at 06:39:47AM -0700, supadhyay wrote:

> I try to use below command to do clone from particular branch/version
> number. I used below command...
> 
> $ git clone -b br6-1-0 ssh://gitolite@myservername/testrep
> Cloning into 'testrep'...
> remote: Counting objects: 19536, done.
> remote: Compressing objects: 100% (5850/5850), done.
> remote: Total 19536 (delta 13869), reused 18869 (delta 13202)
> Receiving objects: 100% (19536/19536), 61.44 MiB | 17 KiB/s, done.
> Resolving deltas: 100% (13869/13869), done.
> warning: Remote branch br6-0 not found in upstream origin, using HEAD
> instead

Side note: if I repeat your experiment, I get "br6-1-0" in the error
message (i.e., what was on the command line). Is this just a cut and
paste mistake in reporting the error, or is that actually what you see?

Assuming that is the case, the problem is that git versions before
v1.7.10 did not expect a tag name with the "-b" switch. Either upgrade
to git v1.7.10, or clone and manually switch to the tag, like this:

  $ git clone ssh://.../testrep
  $ cd testrep
  $ git checkout br6-1-0

Note that if you are planning on doing work based on the tag, you
probably want to create a new branch, like:

  $ git checkout -b my-work br6-1-0

> Is there any way to findout how many branches are available in my GIT
> repository.

In your local clone, or on the remote? In the local clone, you can use
"git branch" to see local branches, or "git branch -a" to see branches
copied from the remote. To see what is available on the remote, try "git
ls-remote ssh://...".

-Peff
