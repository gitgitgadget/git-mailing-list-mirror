From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Command-line interface thoughts
Date: Wed, 08 Jun 2011 15:04:56 +0200
Message-ID: <4DEF7378.20307@ira.uka.de>
References: <201106051311.00951.jnareb@gmail.com> <4DEE755C.8030108@ira.uka.de> <20110607191152.GB24929@elie> <201106072233.28244.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:04:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUIQS-0001jZ-Le
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 15:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab1FHNDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 09:03:55 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59320 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752650Ab1FHNDy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 09:03:54 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1QUIQ6-0005dv-UM; Wed, 08 Jun 2011 15:03:44 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1QUIQ6-0005YK-Lr; Wed, 08 Jun 2011 15:03:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <201106072233.28244.jnareb@gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1307538224.811399000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175366>

On 07.06.2011 22:33, Jakub Narebski wrote:
> To reiterate; perhaps it is not stated clearly in documentation:
 >
> 1. "git diff" is about examining _your_ changes.  This short form is the
>     same in every SCM.

you are right, more explicit mention in the docs would help about this.

But other SCMs don't have the additional target 'index'. Much easier to 
reason there. Also, wouldn't Joe User then conclude that 'git diff' must 
be comparing working area against HEAD ?

>     Because of explicit index (cache, staging area) one needs to know if
>     it is working area against index, or working area against HEAD.
>     Thinking about merge conflict case helps to remember; in such case
>     you want your changes against partially resolved merge.

This is far from a straightforward reasoning that would pop up in 
anyones mind. In truth, I can't follow that reasoning even now. In case 
of a merge conflict the working area doesn't concern me at all, I would 
want a diff between 'ours' and 'theirs'

Since perl has been brought up as example of this DWIM philosophy: In 
perl commands have their defaults, but you always can specify exactly 
what you want if you are not sure or want to make it explicit. You can 
use 'chomp' or you can use 'chomp $_'. But I can't make it explicit 
which two targets I want to compare with 'git diff'.

>     Also advanced users can use index to hide fully cooked changes from
>     having to browse during review.
>
>     Novice users which do not use index (and use "git commit -a") would
>     never notice the difference, if not for the complication of newly
>     added files: in other SCM you would see on "<scm>  diff" creation
>     diff (well, there is "git add -N").  Same with removal if one uses
>     "git rm" and not simply "rm".

> 2. "git diff --cached" is about cached (staged) changes, therefore
>     it is index against HEAD.

We use three words to talk about the index: cache, stage, index. So 
apart from having an additional target for diff that target also is 
diffused by three words. Sure, index is the real designation and cached 
and staged are used as verbs, but that is just one more confusing bit. 
Also 'cache' in computer science is a transparent buffer to access data 
faster (wikipedia definition). Not what I would think of the index.

Probably there are good reasons to not use "git diff --index" and 
probably they have been discussed a few times, but it doesn't make using 
diff easier. But that's a side issue.

If someone sees 'git diff --cached' he might know one target, the index. 
But how does he get the other? By reasoning that 'git diff' alone is 
already index against working area? But for that he would have first to 
conclude that 'git diff' is not working area against HEAD (as it is in 
other SCMs), see above.

> 3. "git diff<commit>" in general, and "git diff HEAD" in particular,
>     is about your changes (worktree), compared to given commit.
>
> At in no place I _have_ to explain what is compared with what to explain
> when and what for to use "git diff", "git diff --cached" and "git diff
> HEAD".
>

I'm sure every part of the user interface of gimp can be rationalized in 
the same way by someone deeply involved in the concepts and the 
structure of gimp, but still it is perceived as difficult by nearly 
everyone else. You look at it from inside and it looks logical. Others 
just don't have all the pieces to make that reasoning really work.

Holger.
