X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 23:55:03 +0100
Message-ID: <200612012355.03493.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 23:00:48 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32980>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqHMr-0000cg-36 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162149AbWLAXA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162147AbWLAXA0
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:00:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:38802 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1162149AbWLAXAZ (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 18:00:25 -0500
Received: (qmail invoked by alias); 01 Dec 2006 22:55:03 -0000
Received: from p5496B457.dip0.t-ipconnect.de (EHLO noname) [84.150.180.87] by
 mail.gmx.net (mp042) with SMTP; 01 Dec 2006 23:55:03 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 23:26, Linus Torvalds wrote:
> 
> On Fri, 1 Dec 2006, Josef Weidendorfer wrote:
> > > 
> > > Well, I would actually argue that you may often want to have a supermodule 
> > > and then at least have the _option_ to decide to not fetch all the 
> > > submodules.
> > 
> > If you want to allow this, you have to be able to cut off fetching the
> > objects of the supermodule at borders to given submodules, the ones you
> > do not want to track. With "border" I mean the submodule commit in some
> > tree of the supermodule.
> >
> > This looks a little bit like a shallow clone
> 
> No. 
> 
> I would say that it looks more like a "partial checkout" than a shallow 
> clone.
> 
> A shallow clone limits the data in "time" - we have _some_ data, but we 
> don't have all of the history of that data.
> 
> In contrast, a submodule that we don't fetch is an all-or-nothing 
> situation: we simply don't have the data at all, and it's really a matter 
> of simply not recursing into that submodule at all - much more like not 
> checking out a particular part of the tree.

OK.

I still think it should be about "limit in space" regarding the
objects in the local repository.

For a project containing "gcc" as submodule, and I am not
interested in this submodule, there should be a way to not need
to fetch all the objects from the gcc submodule at clone time.


What about my other argument for a submodule namespace:
You want to be able to move the relative root path of a submodule
inside of your supermodule, but yet want to have a unique name
for the submodule:
- to be able to just clone a submodule without having to know
the current position in HEAD
- more practically, e.g. to be able to name a submodule
independent from any current commit you are on in the supermodule,
e.g. to be able to store some meta information about a submodule:
- "Where is the official upstream of this submodule?"
- "Should git allow to commit rewind actions of this submodule
   in the supermodule?" (which, AFAICS, exactly has the same
   problems as publishing a rewound branch: you will get into
   merge hell when you want to pull upstream changes into the
   supermodule)
- "Should this submodule be checked out?"
and so on.

