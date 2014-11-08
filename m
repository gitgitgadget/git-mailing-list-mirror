From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add a few more values for receive.denyCurrentBranch
Date: Sat, 8 Nov 2014 06:18:55 -0500
Message-ID: <20141108111855.GA21620@peff.net>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
 <f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 08 12:19:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn42v-0005qo-6T
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 12:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbaKHLS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 06:18:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:37948 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753521AbaKHLS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 06:18:57 -0500
Received: (qmail 4080 invoked by uid 102); 8 Nov 2014 11:18:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 05:18:57 -0600
Received: (qmail 3649 invoked by uid 107); 8 Nov 2014 11:19:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 06:19:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2014 06:18:55 -0500
Content-Disposition: inline
In-Reply-To: <f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 07, 2014 at 02:58:17PM +0100, Johannes Schindelin wrote:

> Under certain circumstances, it makes a *lot* of sense to allow pushing
> into the current branch. For example, when two machines with different
> Operating Systems are required for testing, it makes much more sense to
> synchronize between working directories than having to go via a third
> server.

FWIW, I do this without a third server (and without resorting to pull),
with:

  host1$ git push host2 master:refs/remotes/host1/master
  host2$ git merge host1/master

You can even set up a push refspec to make "git push host2" do the right
thing.

That being said, I do like the premise of your patch, as it eliminates
the extra step on the remote side (which is not that big a deal in
itself, but when you realize that host2 _did_ have some changes on it,
then you end up doing the merge there, when in general I'd prefer to do
all the work on host1 via "git pull").

-Peff
