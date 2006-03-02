From: Andreas Ericsson <ae@op5.se>
Subject: Re: impure renames / history tracking
Date: Thu, 02 Mar 2006 23:06:00 +0100
Message-ID: <44076C48.7010207@op5.se>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org> <4405C012.6080407@op5.se> <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org> <4405DD35.8060804@op5.se> <Pine.LNX.4.64.0603012129310.13612@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 23:06:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEvvz-0006ju-8e
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 23:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWCBWGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 17:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWCBWGD
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 17:06:03 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:29158 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751697AbWCBWGC
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 17:06:02 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 32A506BCBE; Thu,  2 Mar 2006 23:06:01 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603012129310.13612@sheen.jakma.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17112>

Paul Jakma wrote:
> On Wed, 1 Mar 2006, Andreas Ericsson wrote:
> 
>> It's completely impossible to fold *ALL* the history into a single 
>> commit, and since you want heuristics I would imagine you wouldn't 
>> want that either.
> 
> 
> I want to know whether additional meta-data to help the existing 
> heuristics would be acceptable. From a discussion on #git yesterday I 
> gather the best way forward would to be to first prototype something 
> keeping state in a file in .git.
> 
> All that's needed really is something that relates the following 3 things:
> 
>     commit-id obj1-id obj2-id
> 
> Ie: For <commit-id>, <obj1-id> is similar to <obj2-id>.
> 
> Maintaining this state could be done via the git-mv/rename wrappers and 
> an additional git-edit wrapper. Those who are quite happy with the 
> existing diff-input only similarity heuristics wouldn't have to bother 
> using a git-edit wrapper obviously, those who want to let git gather 
> additional 'similarity hint' in this way could.
> 
> Aside:
> 
> Git might be easier to extend generally if it adopted just /one/ new 
> core header, say "see-also" - that could serve as a pointer to arbitrary 
> commit-related meta-info objects that aren't of immediate interest to 
> either:
> 
> a) core git
> 
> or
> 
> b) the user
> 

Things that aren't of interest to either core git or the user is already 
handled properly. It's called "cruft". ;)

However, I see what you're trying for here. Something like the X-* 
headers inside a mailer. Not all MUA's understand them, but if they do 
they can make use of them to the users benefit.


> Format:
> 
>     see-also <word> <obj-id>
> 
> E.g.:
> 
>     see-also similars <obj-id>
> 
> Where <obj-id> would list the 'commit obj1 obj2', but just as:
> 
>     obj1 obj2
> 
> Would ultimately be neater than fishing around in .git/, and would allow 
> other extensions in the future too.
> 
> The <word> identifier preferably would need to be centrally co-ordinated.
> 

With X-* headers I don't see why it should have to be. Only the X-* part 
is mentioned in the RFC, so with a proper format Junio won't have to 
coordinate cross-SCM tools, git-tortoise, etc, etc...


>> I'm confused. First you say you want to have one single mega-patch for 
>> each commit, then you say you want to be able to follow history back. 
>> It's like deciding to throw away your wallet and then trying to get 
>> someone to pick it up and carry it around for you.
> 
> 
> I'm not sure why think mega-patch. Collapsing a bunch of commits related 
> to one project need not result in a big patch relative to the repository 
> as a whole.
> 

Mainly I think it's because you mentioned several renames of a single 
file and many files renamed + rewritten (beyond gits current ability of 
recognizing it). That's definitely a mega-patch in my book.


> Where the project concerned is like BSD, not 
> just a kernel but a complete userland (so 1.1GB of source code).
> 

<just curious>
Such a large project surely must be split in several smaller 
sub-projects? GNU is, after all, several small (and not so small) 
components. X works the same way. Linux is a large project, but each 
compartment of code can be managed on its own, so long as they adhere to 
the ABI hooking them back in to the kernel core.
</just curious>

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
