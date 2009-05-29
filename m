From: Jeff King <peff@peff.net>
Subject: Re: Git Confusion
Date: Fri, 29 May 2009 16:38:54 -0400
Message-ID: <20090529203854.GA14326@coredump.intra.peff.net>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com> <20090529125853.GB11785@sigill.intra.peff.net> <m3d49sauru.fsf@localhost.localdomain> <20090529135242.GA30926@coredump.intra.peff.net> <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	yury239@gmail.com
To: Paul Tarjan <ptarjan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 22:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA8rB-0003Sn-53
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 22:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbZE2UjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZE2UjD
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 16:39:03 -0400
Received: from peff.net ([208.65.91.99]:46651 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbZE2UjC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 16:39:02 -0400
Received: (qmail 28725 invoked by uid 107); 29 May 2009 20:39:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 May 2009 16:39:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2009 16:38:54 -0400
Content-Disposition: inline
In-Reply-To: <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120314>

On Fri, May 29, 2009 at 01:24:59PM -0700, Paul Tarjan wrote:

> The reason I need http is slightly convoluted. The remote machine is
> shared hosting with 1 ssh login that I don't want to give to my
> partner AND I don't have root on that box. And as you correctly
> guessed, that box doesn't have the git demon. The local machine where
> he is doing his development. The only solution I saw without giving
> him my username + pass to SSH was to do http cloning. Any better
> solutions?

You can let him login via ssh key and restrict the actions of that key
just to running git-upload-pack (which is what "git clone" and "git
fetch" will invoke to clone or fetch commits). Something like:

  command="git-upload-pack /path/to/repo" ssh-rsa ...

in your .ssh/authorized_keys file. Not that he still won't be able to
actually push (which is maybe what you want).

For a more featureful solution (with permissions for pushing and pulling
multiple repos), I think gitosis will do what you want (but I have never
used it personally).

-Peff
