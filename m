From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Date handling.
Date: Thu, 14 Apr 2005 02:00:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
References: <1113466592.12012.192.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 10:55:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM082-000288-9N
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 10:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDNI6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 04:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVDNI6c
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 04:58:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:50152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261453AbVDNI63 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 04:58:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3E8w7s4014796
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 01:58:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3E8w6Vc017523;
	Thu, 14 Apr 2005 01:58:07 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113466592.12012.192.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, David Woodhouse wrote:
> 
> I see two possible solutions:
> 	1. Just store seconds-since-GMT-epoch and if we really want, the
> 	   timezone as auxiliary information.

Yeah, I think this is the right thing to do. I can change "commit" to do 
it.

I used to think that the date was purely a "enforced comment" (like the
committer info is, as far as git is concerned), which is why I used the 
simple textual representation. But yes, when I wrote that "rev-tree" thing 
I did curse that and consider just changing it.

It's still just technically a "hint", since time isn't synchronized in any 
way (and in a distributed system, time _cannot_ be synchronized). But 
it's a useful hint, so ..

> 	2. Store dates in RFC2822 form.
> 
> Unless someone convincingly expresses a preference before I get to work
> and start playing with it, I'll implement the latter.

I do like text output, but if it is painful, the "unix seconds" format is 
certainly a hell of a lot simpler. And quite frankly, if we change it, we 
might as well just change it all the way. So I'd almost prefer (1).

But "He who does the work gets to choose the implementation". And I do
agree that this is a bad format decision, and that we should change it. It 
shouldn't even be that painful. Only "rev-tree" cares, and even rev-tree 
doesn't care _that_ deeply.

		Linus
