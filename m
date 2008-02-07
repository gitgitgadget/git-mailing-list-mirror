From: Jeff King <peff@peff.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 06:06:02 -0500
Message-ID: <20080207110601.GA8488@coredump.intra.peff.net>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 12:07:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN4aY-0005vS-2y
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 12:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbYBGLGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 06:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755013AbYBGLGG
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 06:06:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2943 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754604AbYBGLGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 06:06:05 -0500
Received: (qmail 12131 invoked by uid 111); 7 Feb 2008 11:06:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 07 Feb 2008 06:06:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2008 06:06:02 -0500
Content-Disposition: inline
In-Reply-To: <pan.2008.02.07.10.15.05@progsoc.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72923>

On Thu, Feb 07, 2008 at 10:15:02AM +0000, Anand Kumria wrote:

> > OK, I was finally able to reproduce your bug. It seems that it _only_
> > happens when using curl built against gnutls. I built against the
> > libcurl4-openssl-dev in Debian unstable, and the problem goes away.
> 
> Thanks for figuring out how to reproduce it ... how did you btw?

I saw the gnutls error message in your output and took a guess that it
was related. I was able to reproduce against the first https repository
that I tried (I don't think it has anything to do with the repository).

I wish we could more certainly blame it on something besides git,
though. I can't reproduce it using just 'curl', so it's possible that
there is a problem with the way git is calling libcurl.

> It appears that git 1.5.3.8 on Debian links to libcurl3-gnutls whereas, 
> at least for me, git 1.5.4 on Debian links to libcurl4-gnutls 
> (or libcurl4-openssl).
> 
> I agree with you, it is a bit problematic when the library (curl) relies
> on another library (gnutls) and the bottom one is having a problem.

It would be nice if we could generate a minimal test case that
demonstrates the problem, but I can't seem to reproduce it with a
smaller program. If we could, then we could probably get advice from
curl and/or gnutls people.

-Peff
