From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: connecting existing local git repository to svn
Date: Wed, 28 Jan 2009 07:26:27 +0200
Message-ID: <497FEC83.20907@gmail.com>
References: <497E8927.1060506@gmail.com>	 <497EE386.5050805@drmicha.warpmail.net> <497EE4E8.8070705@gmail.com> <bd6139dc0901270416u22b60fefp472935470b1db929@mail.gmail.com> <497F0280.2070400@gmail.com> <497F05D7.3060607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jan 28 06:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS2yu-0006nU-Nb
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 06:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbZA1F1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 00:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbZA1F1b
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 00:27:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:4929 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZA1F1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 00:27:31 -0500
Received: by fg-out-1718.google.com with SMTP id 13so408697fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 21:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gBjw3GSBsmOQG6GaWpNffpQfZuv+MfgVWwtnnkzyxNk=;
        b=n1dC2z6HGT/HPHoIusRfxlBg6cdjFMhi5sh85NRSbrtWXg8e4Qy4v0NUl6/oWLDbin
         W9tsJZ8S73QIot0DA6UGvZcpw+YAaJtBTQOmA2LSptqTNwN+FO1yqLgVmBNxhHBcleyg
         yFQSwJ1XQNAZVBJMjhqHCNjGPQ//RmPS6TTxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=dQgQqBPGIaTr325lQXLsSPdAGbixMJ7pK1GFrXanHTsxwGjlevgpaMYvHth/UhZSSS
         7DCzV5cpQezxPday8Di5jdHWp4iZpH7GDv44jR5/tFIzy1nhVs9i69XLQrkWAMplTjlx
         HKJ2lzp7w5LnyXlSrlUgM4K+OFSwUViNLQFsw=
Received: by 10.103.52.7 with SMTP id e7mr138352muk.52.1233120449112;
        Tue, 27 Jan 2009 21:27:29 -0800 (PST)
Received: from ?192.168.1.9? (bzq-84-108-89-36.cablep.bezeqint.net [84.108.89.36])
        by mx.google.com with ESMTPS id 7sm15138319mup.10.2009.01.27.21.27.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 21:27:28 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <497F05D7.3060607@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107480>



Michael J Gruber wrote:
> Ittay Dror venit, vidit, dixit 01/27/09 13:48:
>   
>> Sverre Rabbelier wrote:
>>
>>     
>>> On Tue, Jan 27, 2009 at 11:41, Ittay Dror <ittay.dror@gmail.com> wrote:
>>>   
>>>       
>>>> git: ----v1----v2----v3--v4---v5
>>>> svn:                     \---v4--v5
>>>>
>>>> so the svn history starts from v3, but the git history remains unchanged.
>>>>     
>>>>         
>>> Create the new branch from v3 then, and use git svn to pull it in.
>>> Then you can do 'git rebase that-svn-branch' on your git branch to put
>>> all commits (not as one big commit) on top of that branch point. Now
>>> you 'git checkout' that-svn-branch and do 'git reset --hard
>>> the-git-branch', which should now consist of
>>> v1--v2--v3--v4(git)--v5(git), etc. If you do 'git svn dcommit' from
>>> the that-svn-branch now it should dcommit to svn each of your git
>>>   
>>>       
>> sorry, my ascii art was confusing:
>>
>> git: ----v1----v2----v3--v4---v5
>> svn: v1-4---v5
>>
>> v1-4 is v1 to v4 squashed together. (e.g., if i added a file in v2 and 
>> removed in v3 it will not appear in svn history)
>>     
>
> Well, for git and svn "revisions" are really "versions" of the complete
> tree, not changesets. Have messed around with hg lately? ;)
>
> On the other hand, a commit that introduces a new version is the
> difference with respect to the previous "version".
>
>   
here's a new one:

initial
git: --- c1 --- c2 --- c3 --- c4

create svn:
git: --- c1 --- c2 --- c3 --- c4
svn --- c1|c2|c3|c4

where c1|c2|c3|c4 is the squashing of all commits into one. it is the 
first revision in the svn repository
c1|c2|c3|c4 === r1


do some work, commit, dcommit:
git: --- c1 --- c2 --- c3 --- c4 --- c5
svn --- c1|c2|c3|c4 --- r2

where 'r2' is revision 2 of the svn repository and contains the same 
changes as c5. that is diff(r2, r1) is the same as diff(c5, c4)



so the svn history starts from how the working tree looks like when it 
is created and progresses from there. the git history is unaltered. i 
want to keep on working on 'master' in git (and 'git log' should show 
all commits as before).



> Ususally it's clear what is meant, but you seem to mix both notions.
>
> So, if v? denotes a version, then v4 is the result of all commits
> leading up to v4. It *is* v4. "squashing" applies only to commits
> ("changes").
>
> In any case, Sverre's as well as my suggestions should do what you want.
> Why not try it out if you doubt it?
>   
well, sverre's suggestion says it will dcommit each git commit 
individually and i think your suggestion means i discard my git history 
in the branch i'm working on.

thank you,
ittay
> Cheers,
> Michael
>   
