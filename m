From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Coping with the pull-before-you-push model
Date: Tue, 14 Sep 2010 09:51:22 -0600
Message-ID: <4C8F99FA.3040003@workspacewhiz.com>
References: <4C8866F9.1040705@workspacewhiz.com> <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com> <4C88F2A9.2080306@workspacewhiz.com> <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com> <20100910141527.GA6936@sigill.intra.peff.net> <4C8EFE62.7080908@workspacewhiz.com> <D4360EBB-7891-457E-A6AC-7159CADCAC6C@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jon Seymour <jon.seymour@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Sep 14 17:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvXn9-0004Q9-91
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 17:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab0INPvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 11:51:24 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:60120 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab0INPvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 11:51:24 -0400
Received: (qmail 2569 invoked by uid 399); 14 Sep 2010 09:51:23 -0600
Received: from unknown (HELO ?192.168.1.3?) (jjensen@workspacewhiz.com@75.196.173.255)
  by hsmail.qwknetllc.com with ESMTPAM; 14 Sep 2010 09:51:23 -0600
X-Originating-IP: 75.196.173.255
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100825 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <D4360EBB-7891-457E-A6AC-7159CADCAC6C@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156193>

  ----- Original Message -----
From: Theodore Tso
Date: 9/14/2010 6:12 AM
> On Sep 14, 2010, at 12:47 AM, Joshua Jensen wrote:
>>> Bear in mind that you can still shift to a maintainer model, but keep
>>> the maintainer automated. That is, you can queue up "to-pull" heads, and
>>> then have an automated process pull them one by one and do some basic QA
>>> (does it merge, does it build, does it pass automated tests, etc). Which
>> Do you know of any existing software that does this?  This may be ideal in the short ter
> Our workflow at $WORK involves pushing changes to gerrit to various "effort branches", and then once they are approved, we have a "Mergitator" script that will attempt to merge the effort branch with the merged master branch, and then attempt to do a build.  If the build succeeds, then the changes will get pushed back to the publically visible merged master branch, and then the Mergitator will move on to the next effort branch that requires merging.   If there is a merge conflict, the Mergitator will refuse the merge, and then give instructions on how to fix up the tree to avoid merge conflicts.
>
How does the integration with Gerrit work here?  The only thing that 
comes to mind is that you do something like:

git push gerrit HEAD:refs/for/merged-master

Then the approvals are done.  Afterward, Gerrit merges to the 
merged-master branch.

I would suppose an external script is performing regular fetches.  When 
it sees new code, it builds.

No, this can't be right, but I'll leave my incorrect workflow here.
> So this probably doesn't help you since I suspect you meant to ask the question, "do you know of any existing publically available software", but I can tell you that it certainly can be done, and that software exists.  Making it be software which is useful and usable to you would definitely take more work...
It's the branch queueing issue that is my current hang up.  Gerrit's 
method is slick, but that won't work outside of JGit.  I'm not opposed 
to JGit; I just haven't touched Java in years.

So, perhaps, a web interface where the branch owner selects the (pushed 
to central server) branch name that is ready to go.  A merge is 
attempted.  If it succeeds, great.  If it fails, then the merge is reset?

Josh
