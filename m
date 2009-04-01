From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: More help with "pull" please
Date: Thu, 2 Apr 2009 01:14:45 +0200
Message-ID: <F364AB31-EC5B-4719-834E-58613BDBC433@dbservice.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com> <4659A860-4AF5-4E34-B38E-60C926E2BAE1@dbservice.com> <450196A1AAAE4B42A00A8B27A59278E70A7D4E71@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 01:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp9g1-0003HQ-UT
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 01:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935159AbZDAXPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 19:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934513AbZDAXPR
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 19:15:17 -0400
Received: from office.neopsis.com ([78.46.209.98]:33045 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759052AbZDAXPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 19:15:15 -0400
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Thu, 2 Apr 2009 01:15:12 +0200
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A7D4E71@EXCHANGE.trad.tradestation.com>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115425>


On Apr 2, 2009, at 12:53 AM, John Dlugosz wrote:

>> When you create a branch, you can tell git which remote branch it
>> tracks, like this:
>>
>> $ git branch --track mynext origin/next
>>
>> So whenever you are on brach 'mynext' and do a git-pull, it will  
>> fetch
>> and merge origin/next.
>>
>> You can do the same with the git-checkout command:
>>
>> $ git checkout --track origin/next
>>
>> This will create a local branch 'next' which tracks 'origin/next'
>>
>
> OK, that works by adding something to the config file, right?  The  
> docs
> don't say, but does mention "having Pull: <refspec> lines for a
> <repository>".  Does tracking add Pull: lines, or is that another
> feature?

I think Pull: lines are not used anymore in newer repositories.  
Tracking is done through the 'branch.<name>.remote' and  
'branch.<name>.merge' config options (which are automatically set by  
git-branch/git-checkout when you use --track).

>>
>> $ git clone $url XXX
>> $ cd XXX
>> $ git checkout --track origin/ReleaseCandidate
>> ...
>> $ git pull # will automatically fetch and merge
> origin/ReleaseCandidate
>
> According to the manpage on pull, "While git-pull run without any
> explicit <refspec> parameter takes default <refspec>s from Pull:  
> lines,
> it merges only the first <refspec> found into the current branch,  
> after
> fetching all the remote refs."
>
> Also, "When no refspec was given on the command line ... If
> branch.<name>.merge configuration for the current branch <name>  
> exists,
> that is the name of the branch at the remote site that is merged."  So
> is that yet again different from having Pull: lines?  If so, I'm  
> fine if
> no "Pull:" lines exist, or it would merge the first refspec found  
> there.
>
> Also, "Normally the branch merged in is the HEAD of the remote
> repository, but the choice is determined by the branch.<name>.remote  
> and
> branch.<name>.merge options; see git-config(1) for details."  That
> agrees with the previous.  If branch.<name>.merge configuration  
> exists,
> I don't need to worry about the remote HEAD.

I'd say forget about Pull: because you won't see any of that in newer  
repositories. Instead, just use --track when checking out a branch you  
intend to follow. And, more as an implementation detail than anything  
else, remember that the tracking is done through the above mentioned  
config options (which you can set/change using git-config or directly  
by editing the .git/config file).

>
>> $ git checkout --track origin/ReleaseCandidate
>
> That command does not work.  It compains that --track can only be used
> with -b, etc.
>
> I think
> 	git checkout -b origin/ReleaseCandidate
>
> is the correct shortcut?
>
> 	git checkout -b ReleaseCandidate origin/ReleaseCandidate
>
> did work.  I know that --track is automatic if the second argument is
> remote.

Maybe it's because I'm using a fairly recent version  
(1.6.2.1.307.g91408).

tom
