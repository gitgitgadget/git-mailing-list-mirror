From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 13:55:30 +0200
Message-ID: <4DF0B4B2.7080007@ira.uka.de>
References: <201106051311.00951.jnareb@gmail.com> <201106072233.28244.jnareb@gmail.com> <4DEF7378.20307@ira.uka.de> <201106082056.38774.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 13:54:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUdoq-0002v2-7p
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 13:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235Ab1FILya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 07:54:30 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58961 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755269Ab1FILya (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 07:54:30 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1QUdoT-00011v-Qu; Thu, 09 Jun 2011 13:54:20 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1QUdoT-0000F0-Lf; Thu, 09 Jun 2011 13:54:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <201106082056.38774.jnareb@gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1307620460.215960000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175518>

On 08.06.2011 20:56, Jakub Narebski wrote:
[...]
>>>      Because of explicit index (cache, staging area) one needs to know if
>>>      it is working area against index, or working area against HEAD.
>>>      Thinking about merge conflict case helps to remember; in such case
>>>      you want your changes against partially resolved merge.
          --------
>>
>> This is far from a straightforward reasoning that would pop up in
>> anyones mind. In truth, I can't follow that reasoning even now. In case
>> of a merge conflict the working area doesn't concern me at all, I would
>> want a diff between 'ours' and 'theirs'.
>
> What you want is irrelevant ;-)

No, because you used my wants in your reasoning above. Makes them highly 
relevant ;-)

> Because in the case of merge conflict
> entries in index is populated automatically, *your* changes are changes
> agains index.  So there.
>
> And what "git diff" would show in that case is --cc diff of file with
> merge markers against stages '1' and '2' in index, which is quite useful.
> Which is 3-way diff between 'ours' and 'theirs'.

Ah okay. This detail about the merge process never really registered 
with me. Which shows that your logic deduction what 'git diff' does is 
often not possible for the casual user

[...]
>> But I can't make it explicit which two targets I want to compare with
>> 'git diff'.
>
> For me it looks XY problem; instead of wanting to compare two explicit
> targets, you should specify what you want to see ;-).

Then don't call the command 'diff' (... I proclaim in the knowledge that 
that isn't possible). 'diff' is the short form of 'difference' which 
means literally a comparison between *two* things. If someone wants to 
see something he would pick the words 'show' or 'list'. So user 
expectation is different from what you want diff to be.

Also there are no good words for what someone wants to see in this case. 
At least I would assume the git project would have found them if they 
existed. '--cached' is definitely not one of them. But we have fitting 
and widely known names for the targets, i.e 'working tree', 'index' and 
'head'.

[...]
>>> At in no place I _have_ to explain what is compared with what to explain
>>> when and what for to use "git diff", "git diff --cached" and "git diff
>>> HEAD".
>>
>> I'm sure every part of the user interface of gimp can be rationalized in
>> the same way by someone deeply involved in the concepts and the
>> structure of gimp, but still it is perceived as difficult by nearly
>> everyone else. You look at it from inside and it looks logical. Others
>> just don't have all the pieces to make that reasoning really work.
>
> What I wanted to say here that instead of teaching / trying to teach
> new people something like the following:
>
>    There is working area, index and current commit (HEAD).  To compare
>    workdir with index use this, to compare index with HEAD use that, to
>    compare workdir with HEAD use this one.

If they know working area, index and head, you don't have to tell them 
three times how to compare this with that, they just have to know they 
can compare any which way they want. In fact, the situation *now* is 
exactly what you describe, you have to tell everyone for any of the 3 
combinations the command to use because it is not obvious.

> we better do explaining higher level concepts
>
>    To examine your remaining changes, i.e. what you can "git stage",
>    use "git diff".  To examine staged changes, i.e. what you
>    "git stage"-d, use "git diff --staged"; that is what "git commit"
>    will create.  To compare working version with given older version,
>    use "git diff<revision>", in particular to compare with last version
>    use "git diff HEAD"; that is what "git commit --all" would create.

Do you realize that you are just enumerating all the possible 
combinations again, exactly what you wanted to avoid? Ok, unfair 
argument, you want to just make it clear how to remember the commands. 
But if I already need 3 emails from you to see the concept behind these 
commands (and lets assume my slow-wittedness is par for the course) many 
others will probably have the same problems. It may be a nice concept, 
but the relation to the user interface is only detectable by close 
examination.

Teaching concepts is good. But if git is only usable after having 
learned all those concepts, the entry barrier is much too big. With 
commands like 'git put' and an improved diff people can use git first, 
then learn the concepts while using git. Which is what most people have 
to do anyway if they encounter git at the work place for example.

> The "git diff NEXT WTREE" looks like training wheels to me.  And like
> training wheels they could become obstacles and not help to learning
> git.  Neverthemind they can snag on sharp corners^W corner-cases. ;-)))
>

If your goal is that anyone who uses git is a git expert, they may be a 
hindrance (as are all the porcelain commands really). If you also want 
to make git friendly to people who will never get past intermediate or 
beginner stage or will only use a small part of git or use git seldomly, 
training wheels are good.

Holger.
