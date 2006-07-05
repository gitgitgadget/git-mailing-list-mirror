From: Jeff King <peff@peff.net>
Subject: Re: git-fetch per-repository speed issues
Date: Wed, 5 Jul 2006 02:47:49 -0400
Message-ID: <20060705064749.GA3617@segfault.peff.net>
References: <1151949764.4723.51.camel@neko.keithp.com> <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <20060704002138.GB5716@coredump.intra.peff.net> <Pine.LNX.4.64.0607032007290.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 05 08:48:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy1BV-0000xF-NB
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 08:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWGEGsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 02:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWGEGsN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 02:48:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:31420 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751152AbWGEGsM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 02:48:12 -0400
Received: (qmail 3632 invoked by uid 1000); 5 Jul 2006 02:47:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607032007290.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23336>

On Mon, Jul 03, 2006 at 08:07:49PM -0700, Linus Torvalds wrote:

> > Fetching by ssh actually makes two ssh connections (the second is to
> > grab tags).
> True. Although that should happen only if there are any new tags.

Either you're wrong or there's a bug in git-fetch. 

I think you're missing the call to git-ls-remote --tags to get the list
of tags (which we will then auto-follow if necessary). So in that case,
there would actually be 3 ssh connections. If everything is up to date,
we still make 2 connections (one to check refs from remotes file, and
one to check remote tag list).

-Peff
