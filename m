From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 16:20:14 -0400
Message-ID: <20071030202014.GA22733@coredump.intra.peff.net>
References: <20071030042118.GA14729@sigill.intra.peff.net> <alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org> <20071030134355.GA21342@coredump.intra.peff.net> <alpine.LFD.0.999.0710300818390.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy C <andychup@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:20:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxZj-0001ka-Hz
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbXJ3UUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbXJ3UUT
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:20:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2726 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbXJ3UUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 16:20:18 -0400
Received: (qmail 3147 invoked by uid 111); 30 Oct 2007 20:20:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 16:20:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 16:20:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710300818390.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62750>

On Tue, Oct 30, 2007 at 08:38:24AM -0700, Linus Torvalds wrote:

> > with the old and new code. Pairs like Documentation/git-add-script.txt
> > -> Documentation/git-add.txt are not found, because the file is composed
> > almost entirely of boilerplate.
> 
> Ok, that does imply to me that we cannot just drop boilerplate text, 
> because the fact is, lots of files contain boilerplate, but people still 
> think they are "similar".

Well, the problem is that instead of just "dropping" boilerplate text,
we fail to count it as a similarity, but it still counts towards the
file size. It may be that just dropping it totally is the right thing
(in which case those renames _will_ turn up, because they will be filled
with identical non-boilerplate goodness).

> Hmm. I hope that is sufficient. But I suspect it may well not be. 
> Especially since you ignore boiler-plate lines for *some* files but not 
> others (ie it depends on which file you happen to find it in first).

Yes, that part bothers me a little, so I think a "too common, ignore"
overflow flag would at least be better.

But I think the best thing to do now is for me to shut up and see what
the results look like with the tweaks I have mentioned.

-Peff
