From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git pull opinion
Date: Mon, 5 Nov 2007 16:37:50 -0800
Message-ID: <1922673A-C57E-4C10-BAB0-5853B8499164@midwinter.com>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Aghiles <aghilesk@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 01:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpCSF-0007Yb-0Z
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 01:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbXKFAhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 19:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbXKFAhw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 19:37:52 -0500
Received: from tater.midwinter.com ([216.32.86.90]:47288 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755268AbXKFAhv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 19:37:51 -0500
Received: (qmail 23068 invoked from network); 6 Nov 2007 00:37:50 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=vjDaV6JBt4eXoBZKmF3KYQHudJCoTo92ynVaA/IMATlJk2Msy0t8p40iYekecynq  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 6 Nov 2007 00:37:50 -0000
In-Reply-To: <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63602>

On Nov 5, 2007, at 3:33 PM, Junio C Hamano wrote:

> Aghiles <aghilesk@gmail.com> writes:
>
>> Is there an "easier" way to pull into a dirty directory ? I am
>> asking this to make sure I understand the problem and not
>> because I find it annoying to type those 4 commands to perform
>> a pull (although some of my colleagues do find that annoying :).
>
> You need to switch your mindset from centralized SVN workflow.

I don't think wanting to pull in the middle of one's work has anything  
to do with centralized vs. decentralized, actually, though I do agree  
that it's a question of workflow.

For maybe 80% of my work, I do things "the git way" (lots of little  
local commits) and only sync up with other people when I've reached a  
good stopping point. Those are cases where I'm working in isolation on  
a new feature or a fix and will publish it as a whole unit when I'm  
done.

But the other 20% of the time, I'm working closely with another  
person. For example, I might be working with a front-end developer who  
is writing some nice snazzy JavaScript or Flash UI code to talk to my  
server-side code. And in that case, I really do want to be able to  
pull down his latest changes while I'm still in the middle of working  
on my own stuff, not least because it's only by testing with the real  
client -- where the button to invoke a particular piece of code on my  
side has just been added in the last 2 minutes -- that I can decide  
whether my work in progress is actually functional or not. (Unit tests  
only get you partway there.)

In other words, for traditional open-source-style distributed  
development where each repository is an isolated island that goes off  
and does its own thing, ignoring the outside world, the recommended  
git workflow is totally appropriate. It's also appropriate for a lot  
of in-house non-distributed development.

But for some classes of collaboration, where two or more people are  
essentially editing the same code base to work on the same feature and  
their changes are highly interdependent, that workflow is next to  
useless. There *is* no "I've gotten my code working and am ready to  
look at other people's changes now" stage until pretty late in the  
game. This kind of workflow happens a lot in commercial development in  
my experience.

Before git-stash, I did a lot of "commit; fetch; rebase; reset"  
sequences to support this kind of tight collaboration. Now it's  
"stash; fetch; rebase; unstash" which is the same number of commands  
but is semantically clearer. "fetch; rebase --dirty" or "pull --dirty - 
s rebase" will be nicer.

-Steve
