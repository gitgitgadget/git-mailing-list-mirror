From: Jeff King <peff@peff.net>
Subject: Re: See commits on remote repository
Date: Wed, 28 Apr 2010 21:49:43 -0400
Message-ID: <20100429014943.GA4269@coredump.intra.peff.net>
References: <n2v3f81a4241004281535h30d35f5cw5f33e265d19d35b6@mail.gmail.com>
 <1272495295.3021.84.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bryan Richardson <btricha@gmail.com>, git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Thu Apr 29 03:49:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7Isz-00037C-HB
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 03:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab0D2Btr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 21:49:47 -0400
Received: from peff.net ([208.65.91.99]:36979 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755753Ab0D2Btq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 21:49:46 -0400
Received: (qmail 23724 invoked by uid 107); 29 Apr 2010 01:49:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Apr 2010 21:49:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Apr 2010 21:49:43 -0400
Content-Disposition: inline
In-Reply-To: <1272495295.3021.84.camel@kheops>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146026>

On Thu, Apr 29, 2010 at 12:54:55AM +0200, Sylvain Rabot wrote:

> > For example, say I have repository X, which I do a bare clone on to
> > create repository Y for someone else to work on (effectively forking
> > repo X). Is there a way for me to see, from repository X, what commits
> > have been made to repository Y?
> > 
> $ git remote update
> $ git log origin/<branch>
> $ gitk origin/<branch>

That's backwards. He's in the parent repo and wants to see what the
child did.

The answer is "no, not automatically. Git is fully distributed and
repository X knows nothing about repository Y that was cloned from it".

But also because git is fully distributed, you can simply treat the
cloned child like any other remote:

  git remote add y /path/to/y
  git remote update ;# or just "git fetch y"
  git log y/<branch> ;# what happened in y's <branch>
  gitk y/<branch>...<branch> ;# differences since y forked

-Peff
