From: Jeff King <peff@peff.net>
Subject: Re: get upstream branch
Date: Tue, 9 Dec 2008 00:56:29 -0500
Message-ID: <20081209055629.GB2972@coredump.intra.peff.net>
References: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com> <7vljup6hdf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff Whiteside <jeff.m.whiteside@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 06:57:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9vbQ-0003v5-SK
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 06:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbYLIF4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 00:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbYLIF4b
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 00:56:31 -0500
Received: from peff.net ([208.65.91.99]:4699 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbYLIF4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 00:56:31 -0500
Received: (qmail 503 invoked by uid 111); 9 Dec 2008 05:56:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Dec 2008 00:56:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2008 00:56:29 -0500
Content-Disposition: inline
In-Reply-To: <7vljup6hdf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102599>

On Mon, Dec 08, 2008 at 09:35:08PM -0800, Junio C Hamano wrote:

> I do not think there is any plumbing facility to get that information, as
> such "upstream/parent" concept did not exist back then when building the
> whole Porcelain by scripting was the norm.

In one of my scripts I do something like this (actually this is not
straight from my script, as the operation there is "find all pairs of
local/remote branches" and this is "find the current upstream"):

  ref=`git symbolic-ref HEAD`
  head=${ref#refs/heads/}
  remote=`git config branch.$head.remote`
  branch=`git config branch.$head.merge`
  echo refs/remote/$remote/${branch#refs/heads/}

And obviously this is missing error checking for the detached HEAD
(symbolic-ref should fail) and no tracking branch ($remote and/or $branch
will be empty) cases.

-Peff
