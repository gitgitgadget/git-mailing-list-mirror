From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 23:29:36 +0800
Message-ID: <451BEA60.9050306@dawes.za.net>
References: <20060928131710.GE7469@thunk.org> <20060928145027.26643.qmail@web51011.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 17:30:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSxpT-0007fl-Ri
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 17:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWI1P3g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 11:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWI1P3g
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 11:29:36 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:25291 "EHLO
	spunkymail-a14.dreamhost.com") by vger.kernel.org with ESMTP
	id S965049AbWI1P3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 11:29:36 -0400
Received: from [0.0.0.0] (lucas.dreamhost.com [64.111.99.14])
	by spunkymail-a14.dreamhost.com (Postfix) with ESMTP id 6123F190E3B;
	Thu, 28 Sep 2006 08:29:34 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928145027.26643.qmail@web51011.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28006>

Matthew L Foster wrote:
> --- Theodore Tso <tytso@mit.edu> wrote:
> 
>> In git, we believe that all repositories are equal, and that any sense
>> that a particular repository is the "master" or the "mainline" is
>> strictly speaking, a matter of convention.  What Matthew I think is
>> asking for is direct support in git for that notion.
> 
> No. I merely think git should try harder to ensure that commit order is consistent with time
> order, it really should (somehow) be impossible for git and gitweb.cgi to have commit dates ~2
> days in the future. I think replication is a separate issue. In a distributed system the only
> "time" that makes any sense or is the most relevant in many situations and most importantly is the
> only thing that can be semi-trusted is local time. "Creation date" is basically just random text
> someone entered, there is no guarantee and you are tempting inconsistent time order. And git
> shouldn't be so fragile as to need each and every git server to have time set semi-correctly, but
> I guess it's a bigger deal to non-developers as we actually use time and also believe even web
> interfaces should have consistency and integrity. 
> 
> -Matt
> 

See, the confusion here seems to be that you think that not caring about 
the time attached to a commit for anything more than a heuristic makes 
git fragile.

I think that the rest of the git developers prefer to see this as a 
feature that makes git more robust in the face of something that they 
might not have any control over (or desire to control).

That said, if *you* are managing a repository, it shouldn't be difficult 
to enforce the kind of rule that you are asking for. Simply implement a 
pre-commit hook that checks all commits that will be added to *your* 
repo to make sure that time is monotonically increasing from the last 
commit, and that it does not pass "now".

So if you receive a commit from a developer that violates this rule, you 
can send the commit back to them with a request to fix their system 
time, and recreate the patch/series.

I just don't think that any of the kernel developers feel the need to 
police any one else's clocks . . . they're more interested in the 
contents of the patch.

Regards,

Rogan
