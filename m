From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 08:22:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701310805500.3632@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net> <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
 <Pine.LNX.4.64.0701302029460.3611@woody.linux-foundation.org>
 <7vodofx06s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 17:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIEM-0001Ip-KF
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbXAaQWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbXAaQWj
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:22:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36825 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030234AbXAaQWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:22:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0VGMa9V000546
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 31 Jan 2007 08:22:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0VGMZ7W019810;
	Wed, 31 Jan 2007 08:22:35 -0800
In-Reply-To: <7vodofx06s.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.459 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38269>



On Tue, 30 Jan 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > 
> > But I'll admit - my main reason going with C is (a) it's what I know and 
> > (b) I absolutely _hate_ being constrained by the language. The great thing 
> > about C (still) is that you can do *anything* in it. You're literally 
> > limited by hardware, and by your own abilities. Nothing else.
> 
> Well, if you count "time" as part of your own ability then that
> is true.  Some things are too cumbersome and not performance
> critical enough to do in C.

Sure. I'd probably not do some graphical front-end in C - although some of 
the toolkits make that resonable too. 

But even for "time", C actually does have a number of big advantages that 
some people often seem to overlook:

 - it has absolutely tons of infrastructure. Something like Perl comes 
   *close*, but in the end, even the Perl CPAN stuff is just a drop in the 
   bucket for what somebody programming in C has. Other scripting 
   languages? Outside of their specific things (ie the tcl/tk kind of 
   thing), they really have nothing.

 - perhaps even more importantly: there's a ton of clueful people who know 
   it. Maybe this stems from my personal blinders on what "competent" is 
   (and from just my sheltered life in general), but absolutely everybody 
   who is deeply competent will know C. Not everybody will want to program 
   in it, but they *all* know enough to be able to work with it.

The latter one is rather relevant for open source programming. Finding 
some really competent person who has written a library to do (say, purely 
hypothetically - NOT!) a clean and efficient "diff" implementation can be 
a huge deal. And you will find that using C. 

So yeah, C is low-level. Yeah, you have to know how "pointers" work. And 
yeah, it takes effort especially to get started. But once you have gotten 
started, you realize that:

 - it may have been a lot more work to get over the hump, but once you 
   did, you can find people who can work with you and help you.

 - yeah, you didn't really want to work with people who didn't know how a 
   "pointer to a function returning a const pointer" really works.

I agree that C is a really hard language for "prototyping". And yes, I'll 
also agree that probably 95% of all programming is really about 
prototyping. Make something that works, and move on. In that environment, 
C is simply wrong.

But in a real core infrastructure environment, I'd say that almost 
anything *but* C (or "fairly similar" language) tends to be a mistake.

So I personally tend to always work on that infrastructure thing, which is 
why I love C. If it's not "core enough" that C is the proper language, I'm 
probably simply not interested.

And yeah, it will change. I realize that. My bet is that C will remain as 
the default "system language" for at least another decade. 

Of course, is an SCM "core enough"? Some parts definitely are. The actual 
low-level diff generation fairly obviously is. Is revision walking? 
Per-file operations? hg and git disagree about that decision.

		Linus
