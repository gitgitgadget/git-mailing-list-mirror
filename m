From: Jeff King <peff@peff.net>
Subject: Re: error: cannot run hooks/pre-receive: No such file or directory
Date: Wed, 30 Mar 2011 16:04:42 -0400
Message-ID: <20110330200442.GA30663@sigill.intra.peff.net>
References: <AANLkTinehsLJWYona7ONqquWpCZozr3hW-JNMhYz4Rvn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:05:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51dV-000609-5b
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 22:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890Ab1C3UEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 16:04:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46555
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932880Ab1C3UEp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 16:04:45 -0400
Received: (qmail 21343 invoked by uid 107); 30 Mar 2011 20:05:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 16:05:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 16:04:42 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinehsLJWYona7ONqquWpCZozr3hW-JNMhYz4Rvn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170420>

On Wed, Mar 30, 2011 at 03:27:14PM +0200, Mathieu Malaterre wrote:

> $ git push
> Counting objects: 5, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 304 bytes, done.
> Total 3 (delta 2), reused 0 (delta 0)
> error: cannot run hooks/pre-receive: No such file or directory
> To ssh://malat@gdcm.git.sourceforge.net/gitroot/gdcm/gdcm.old
>  ! [remote rejected] master -> master (pre-receive hook declined)
> error: failed to push some refs to
> 'ssh://malat@gdcm.git.sourceforge.net/gitroot/gdcm/gdcm.old'

We won't try to execute a hook that doesn't exist, so the "no such file
or directory" almost certainly means the #! interpreter is missing.

> I tried with something as simple as :
> 
> % cat pre-receive
> #!/usr/bin/ruby
> % which ruby
> /usr/bin/ruby

This might be a stupid question, but which machine is that output from?
The pre-receive hook runs on the server, so you must have ruby there. I
ask mainly because I didn't realize sourceforge would give people
arbitrary shell access on the git boxes.

My next guess would be that the git process runs in some kind of chroot
that doesn't have ruby in it.

> Do I need to do something special with ruby ?

>From git's perspective, no, but it may depend on how the server is
configured.

-Peff
