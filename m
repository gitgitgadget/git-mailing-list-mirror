From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 11:30:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201110320.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
 <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca>
 <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org> <45390BAF.5040405@utoronto.ca>
 <Pine.LNX.4.64.0610201100070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 20:30:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gaz8i-00071U-Sd
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 20:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992530AbWJTSa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 14:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992613AbWJTSa2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 14:30:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23478 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992530AbWJTSaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 14:30:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KIUGaX030063
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 11:30:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KIUFI1029100;
	Fri, 20 Oct 2006 11:30:15 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <Pine.LNX.4.64.0610201100070.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.974 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29517>



On Fri, 20 Oct 2006, Linus Torvalds wrote:
> 
> So yes, merges are the situation where renames are normally considered a 
> "problem", but it's actually not nearly the most every-day situation at 
> all.

Btw, this is a pet peeve of mine, and it is not at all restricted to 
the SCM world.

In CompSci in general, you see a _lot_ of papers about things that almost 
don't matter - not because the issues are that important in practice, but 
because the issues are something small enough to be something you can 
discuss and explain without having to delve into tons of ugly detail, and 
because it's something that has a lot of "mental masturbation" associated 
with it - ie you can discuss it endlessly.

In the OS world, it's things like schedulers. You find an _inordinate_ 
number of papers on scheduling, considering that the actual algorithm then 
tends to be something that can be expressed in a hundred lines of code or 
so, but it's got quite high "mental masturbatory value" (hereafter called 
MMV).

Other high-MMV areas are page-out algorithms (never mind that almost all 
_real_ VM problems are elsewhere) and some zero-copy schemes (never mind 
that if you actually need to _work_ with the data, zero-copy DMA may 
actually be much worse because it ends up having bad cache behaviour).

In the SCM world, file renames and merging seem to be the high-MMV things. 
Never mind that the real issues tend to be elsewhere (like _performance_ 
when you have a few thousand commits that you want to merge).

For example, in the kernel, I think about half of all merges are what git 
calls "trivial in-index merges". That's HALF. Being a trivial in-index 
merge means that there was not a single file-level conflict that even 
needed a three-way merge, much less any study of the history AT ALL (other 
than finding the common ancestor, of course).

Of the rest, most by far need some trivial 3-way merging. And the ones 
that have trouble? In practice, that trivial and maligned 3-way does 
_better_ than anything more complicated.

Yet, if you actually bother to follow all the discussion on #revctrl and 
other places, what do you find discussed? Right: various high-MMV issues 
like "staircase merge" etc crap.

Go to revctrl.org for prime example of this. I think half the stuff is 
about merge algorithms, some of it is about glossary, and almost none of 
it is about something as pedestrian and simple as performance and 
scalability.

(Actually, to be honest, I think some of the #revctrl noise has become 
better lately. I'm not seeing quite as much theoretical discussion, it may 
be that as open-source distributed SCM's are getting to be more "real", 
people start to slowly realize that the masturbatory crap isn't actually 
what it's all about. So maybe at least this area is getting more about 
real every-day problems, and less about the theoretical-but-not-very- 
important issues).

		Linus
