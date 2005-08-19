From: Johnny Stenback <jst@jstenback.com>
Subject: Re: git commit (or git-commit-script) question
Date: Fri, 19 Aug 2005 10:44:52 -0700
Message-ID: <43061A94.9030002@jstenback.com>
References: <4306119C.8000600@jstenback.com> <Pine.LNX.4.58.0508191028190.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 19:45:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6AvX-0000xW-Hd
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 19:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVHSRpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 13:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbVHSRpH
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 13:45:07 -0400
Received: from smeagol.dreamhost.com ([66.33.209.5]:24010 "EHLO
	smeagol.dreamhost.com") by vger.kernel.org with ESMTP
	id S932556AbVHSRpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 13:45:06 -0400
Received: from [192.168.0.100] (dpc674551026.direcpc.com [67.45.51.26])
	by smeagol.dreamhost.com (Postfix) with ESMTP
	id CCCB623A59; Fri, 19 Aug 2005 10:44:57 -0700 (PDT)
User-Agent: Mail/News 1.6a1 (X11/20050816)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508191028190.3412@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ah, that explains it. I had already marked all my changes for update, 
that's what threw me off here. Thanks!

Linus Torvalds wrote:
> 
> On Fri, 19 Aug 2005, Johnny Stenback wrote:
>> That made me assume that if I do:
>>
>>    git-commit-script somedir
>>
>> it would *only* commit the changes I've made in "somedir", but it 
>> appears to commit *all* files that have changed (and shows all files in 
>> the list of changed files in the commit message it displays in the 
>> editor), as if it's completely ignoring the <path> argument.
>>
>> Known problem? I got this using git that I pulled from kernel.org 
>> earlier this morning.
> 
> It works for me. You _should_ see something like
> 
> 	#
> 	# Updated but not checked in:
> 	#   (will commit)
> 	#
> 	#       modified: somedir/somefile
> 	#
> 	#
> 	# Changed but not updated:
> 	#   (use git-update-cache to mark for commit)
> 	#
> 	#	modified: otherdir/anotherfile
> 	#
> 
> which basically means that it will commit "somedir/somefile", but _not_ 
> commit "otherdir/anotherfile".
> 
> However, one thing to look out for is that if you've marked any files for 
> update (with git-update-cache) those will always be committed regardless 
> of what arguments you give to "git commit". You can reset the index with 
> "git reset" if you decided that you don't want to commit after all.
> 
> (For example, if you do a "git commit --all", but decide not to commit 
> after all by writing an empty commit message, that will already have 
> marked all the files to be committed, so next time, even if you then use 
> "git commit somedir", all the files in all the _other_ dirs have already 
> been marked for update, so you'll see everything being committed).
> 
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
jst
