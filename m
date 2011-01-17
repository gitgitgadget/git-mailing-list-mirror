From: Jeff King <peff@peff.net>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Mon, 17 Jan 2011 17:21:28 -0500
Message-ID: <20110117222128.GA30869@sigill.intra.peff.net>
References: <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
 <20110114162144.GA867@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: JT Olds <jtolds@xnet5.com>
X-From: git-owner@vger.kernel.org Mon Jan 17 23:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PexSE-000323-S8
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 23:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab1AQWVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jan 2011 17:21:33 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52616 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896Ab1AQWVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 17:21:32 -0500
Received: (qmail 26171 invoked by uid 111); 17 Jan 2011 22:21:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 17 Jan 2011 22:21:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Jan 2011 17:21:28 -0500
Content-Disposition: inline
In-Reply-To: <20110114162144.GA867@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165186>

On Fri, Jan 14, 2011 at 11:21:45AM -0500, Jeff King wrote:

> So we should probably do one or both of:
> 
>   1. Make an --allow-any-name option to mailinfo, and use it when we
>      invoke mailinfo internally for rebasing. That still doesn't solve
>      the emailed patch problem, but at least keeps purely internal
>      operations sane.

So I wrote up a nice tidy patch series with mailinfo changes and tests,
and then am/rebase changes and tests on top of that. And guess what I
noticed? My rebase tests didn't actually fail with stock git.

I bisected to 43c2325 (am: use get_author_ident_from_commit instead of
mailinfo when rebasing, 2010-06-16), which was written to handle exactly
this sort of thing.

That commit made it into v1.7.2. JT, which version of git are you
running? Do you still see any problems with v1.7.2 and above? I can't
replicate your issue with more recent versions.

So unless we want to do any sort of commit-time warning, I don't think
there is anything left to be done on this topic.

-Peff
