From: Jeff King <peff@peff.net>
Subject: Re: git use pattern questions
Date: Mon, 8 Jun 2009 08:29:29 -0400
Message-ID: <20090608122929.GE13775@coredump.intra.peff.net>
References: <e4a904790906080206t51ee260ve64304d8c1147ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex K <spaceoutlet@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 14:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDdza-0006cm-PO
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 14:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbZFHM3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 08:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbZFHM3g
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 08:29:36 -0400
Received: from peff.net ([208.65.91.99]:49780 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380AbZFHM3g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 08:29:36 -0400
Received: (qmail 21371 invoked by uid 107); 8 Jun 2009 12:29:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Jun 2009 08:29:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 08:29:29 -0400
Content-Disposition: inline
In-Reply-To: <e4a904790906080206t51ee260ve64304d8c1147ebc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121068>

On Mon, Jun 08, 2009 at 10:06:50AM +0100, Alex K wrote:

> I would like to publish a repository on say github but I would still
> like to hide sensitive information from a config file which
> nevertheless needs to be part of the repo. If it was possible to
> publish a single branch then I'd make one especially for github and
> publish the config file with something like "your password here"...
> 
> Would you know what's the best pattern to publish a repository but
> still hide sensitive information such as values of passwords, mysq
> port etc..?

That is not really possible with git. If you publish a branch, all of
its contents will be visible to anyone who clones it. You _could_ keep a
pristine branch without any config, do your development there, and then
merge it to a branch with the secret config file in it. And then just
publish the development branch. I suspect that would become a pain in
the long run, as you would need to commit and merge in order to do a
test.

Generally, I think the strategy people use is not to put the config file
into git at all. Put in a sample for people to read, but keep your
personal one as a purely local thing. You will then have to deal with
deployment of the tracked files and the config file separately (but
usually people don't deploy directly using git; they use "make install"
or rsync or whatever from their git checkout).

-Peff
