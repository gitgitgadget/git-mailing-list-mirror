From: Jeff King <peff@peff.net>
Subject: Re: git push in --tracked branches.
Date: Wed, 21 Apr 2010 21:52:51 -0400
Message-ID: <20100422015251.GA25093@coredump.intra.peff.net>
References: <y2w3abd05a91004211702qf4cd42bau20ac52a4d35a6bf1@mail.gmail.com>
 <20100422004433.GC14249@coredump.intra.peff.net>
 <i2n3abd05a91004211813t8111c77am381bc0b8226a0c9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 03:53:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4lbg-0001kR-2d
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 03:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab0DVBxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 21:53:25 -0400
Received: from peff.net ([208.65.91.99]:56293 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755809Ab0DVBxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 21:53:25 -0400
Received: (qmail 25509 invoked by uid 107); 22 Apr 2010 01:53:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Apr 2010 21:53:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Apr 2010 21:52:51 -0400
Content-Disposition: inline
In-Reply-To: <i2n3abd05a91004211813t8111c77am381bc0b8226a0c9b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145491>

On Wed, Apr 21, 2010 at 09:13:14PM -0400, Aghiles wrote:

> On Wed, Apr 21, 2010, Jeff King <peff@peff.net> wrote:
> 
> > "git push" will by default push matching refs. This has been the
> > behavior since day one. See the description of push.default in "git help
> > config" for other options (I think you want "tracking").
> 
> Thank you very much. The 'tracking' case is what I need. Could you
> enlighten me why pushing all matching branches is a sensible default ?
> It seems like an unusual thing to do.

I think it comes from a workflow where you tend to have a private repo
and then a personal public repo for publishing. The matching refs are
then the set of refs that you have previously pushed. So you do:

  $ git push public foo ;# publish "foo" for the first time
  $ git push public ;# now "foo" will be published every time

And you probably do work on topic branches, and only merge them into
your public branches when they are ready to show the world. So push is
really about synchronizing those public branches.

If you are working by cloning from a collaborative central repository,
then that workflow doesn't make as much sense. The refs on the other end
are not about "things I have published before" but rather "the set of
all refs that our group agrees about". And probably your workflow is to
hack on a specific ref, and then push changes to that ref.

Git grew out of the first type of workflow, and that has always been the
default. Tools for helping the latter workflow have developed later.
There was some discussion about changing the default, but it hurts
people used to the current default, so we ended up with the config
variable.

That is just my two cents, though. I have largely stayed out of the
debates which seem to come up every once in a while. I think this thread
is the one that lead to push.default:

  http://article.gmane.org/gmane.comp.version-control.git/111375

-Peff
