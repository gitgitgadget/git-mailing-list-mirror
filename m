From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 14:27:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181411400.18017@i5.linux-foundation.org>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com>  <20100318204416.GM8256@thunk.org>
 <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tytso@mit.edu, Nicolas Pitre <nico@fluxnic.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 22:30:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsNIU-0008V2-C6
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab0CRVa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 17:30:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53840 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181Ab0CRVaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 17:30:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2ILUIPY025985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 14:30:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2ILUHmN016681;
	Thu, 18 Mar 2010 14:30:18 -0700
In-Reply-To: <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142523>



On Thu, 18 Mar 2010, Michael Witten wrote:
> 
> This is all that I'm saying: Keep git exactly the way it is, but add
> one extra piece of identifying information for each person.

The thing is, you don't seem to realize that most authorship is over 
email.

Let's take some numbers from the kernel archive, for example. Here's _one_ 
trivial way to count it:

 - number of commits where author/committer email matches (presumably 
   _not_ emailed, although sometimes people commit their own patches that 
   were emailed around):

	[torvalds@i5 linux]$ git log --no-merges "--pretty=format:%h-%ae%n%h-%ce" | uniq -d | wc
	  33473   33473  959167

 - total number of commits:

	[torvalds@i5 linux]$ git rev-list --no-merges HEAD | wc
	 176415  176415 7233015

IOW, less than a fifth of the patches were done by the person who actually 
committed things. 80%+ of all changes were committed by somebody else than 
the author.

How do you think the authorship information can be transferred sanely, 
considering that the author didn't even use git in the first place? 
Really?

That's where the typos/mistakes/missing-info really happens. And it often 
starts out with incomplete information, because the person has a bad email 
setup, and the thing only has an email address to begin with, ie the 
"From:" might literally say just "tytso@mit.edu" or something (to pick an 
example from the Cc list in this discussion - when Ted sends real emails, 
they tend to have proper naming).

Sometimes we'll edit the messages to have the "From: xyz <abc>" thing at 
the top, fixing up the incomplete thing then. Typos happen there. Or the 
patch will simply come in two different ways, so there's no typo, yet 
there are two different emails that get author attribution.

The thing is, development really is about human interaction. Yes, there's 
a tool involved (git), and once the data is in the tool we won't lose it 
any more, but this is about getting the data _into_ the tool in the first 
place.

And the data you want to add simply DOES NOT EXIST. And we can't make it 
exist. The fact that even the trivial and obvious data that git _does_ ask 
for gets to be incomplete should tell you something.

			Linus
