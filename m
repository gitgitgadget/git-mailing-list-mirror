From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Tue, 8 Jul 2008 18:34:30 +0200
Message-ID: <20080708163430.GK6726@leksak.fem-net>
References: <200807080227.43515.jnareb@gmail.com> <200807080939.31216.jnareb@gmail.com> <20080708144239.GJ6726@leksak.fem-net> <200807081812.15651.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 18:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGGAE-00032N-T5
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 18:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbYGHQel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 12:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbYGHQel
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 12:34:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:43535 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754137AbYGHQek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 12:34:40 -0400
Received: (qmail invoked by alias); 08 Jul 2008 16:34:38 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp014) with SMTP; 08 Jul 2008 18:34:38 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19epWQHFQhejSGkwWTf+B8gwUDVhi65V/Yvo4nSf9
	JC0eIlErsNCJsF
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KGG98-0007qJ-RK; Tue, 08 Jul 2008 18:34:30 +0200
Content-Disposition: inline
In-Reply-To: <200807081812.15651.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87770>

Hi,

Jakub Narebski wrote:
> > It is taking the commit message from the commit in the "From <commit> .*"
> > line, does *not* change it in any way and then applies the changes using
> > threeway merge.
> 
> Not exactly.  "git am --rebasing" still tries to first just *apply*
> the patch, then (I think) it falls back on blob-id based 3way merge.

That's of course totaly right and what I've meant, but unfortunately not
what I've written ;-)

> > Keeping that in mind what about dealing with --rebasing like that:
> > if --rebasing is given, git am simply generates
> > 	pick <commit>
> > lines, instead of
> > 	patch -3 -k <msg>
> > as it is now (and this is not enough, as it seems).
> 
> It is not.
> 
> Nevertheless it would be I think better for ordinary patch based rebase
> to fall back not on git-am 3way merge, but on cherry-pick based merge
> (i.e. on pick).

Hmm, if I get you right you _partly_ agree with me in choosing "pick" for
am --rebasing... But cherry-pick should only be chosen if a simple git-apply
failed first. Right?

I just got another idea which could easily be done and perhaps is the
right thing :)
Generating
	patch -C <commit> -3 <file>

This takes authorship and message from <commit> and does the usual
threeway-fallback behavior.

What do you think?

> But I agree that it would be nice to simplify '--rebasing' logic, for
> example using patch or 2way merge to generate tree, and commit message
> taken directly from commit, not via 'format-patch | am' pipeline.

That's right, but that would require me to hack around in git-rebase
which I tried to avoid for now. :)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
