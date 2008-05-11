From: Dima Kagan <dima.kagan@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 14:58:34 +0300
Message-ID: <4826DF6A.2070306@gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 13:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvADY-0003ov-TY
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 13:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYEKL7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 07:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYEKL7E
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 07:59:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:27077 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYEKL6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 07:58:39 -0400
Received: by ug-out-1314.google.com with SMTP id h2so502827ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=vmo/sf/jdMUaamqp1z1pLpXtSzRcK5tfMBVuf6hB878=;
        b=A0pTfp8GeVPB+hvGfN6Wi5lTy4r7PQc4VTgAGX4zYEduci1CGa6w51dCiHzgcRQDPZGB+OP74oHaUYUtQWcV/cZTOPpRSFCA+61cE7CiEaQ6D/pHYvOgiDmQS4GPqAAm+/VsZsJTRBHLBBuotc2ndfF17TQUXmV1sr/+Yt/74R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rWiC/HUduHQzfQ2YVx58z0PI7ZmH2foKM9K7Wn7UIbt/32XLbLAtZzAIhKTXw3KWD+i4iioW4wqin/Uw+HHhCciyUwUSofkuYrWiTQfYyxkmqXfjAxb6ufhtLWa7Q1kuDP2NUZnClg55xfXFjqT/NYCsJXXykg1bQoZWna+RPRI=
Received: by 10.67.26.7 with SMTP id d7mr4031582ugj.12.1210507116611;
        Sun, 11 May 2008 04:58:36 -0700 (PDT)
Received: from ?192.168.1.60? ( [82.166.58.226])
        by mx.google.com with ESMTPS id i6sm12938389gve.4.2008.05.11.04.58.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 04:58:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <m31w495apd.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81760>



Jakub Narebski wrote:
> Dima Kagan <dima.kagan@gmail.com> writes:
> 
>> I'm currently evaluating git for doing some local work without
>> depending on the main subversion server. I started with the following
>> steps:
>>
>>> git-svn clone http://svn.test.org/test/trunk
>>> cd trunk
>>> git branch test_branch
>>> git checkout test_branch
>>> vi somefile
>> Now, when I run 'git status' I get:
>> # On branch test_branch
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #
>> #       modified:   somefile
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
> 
> And now you have 'somefile' in the working arew, which state isn't
> saved anywhere git knows of.
>  
>> This is what I expect of course. However, when I execute 'git checkout
>> master', I get:
>> M       somefile
>> Switched to branch "master"
> 
> Git tries hard to preserve your modifications.  If you don't want to
> commit changes to test_branch, you can use git-stash to stash them
> away.
> 
> Note that the above is possible only in the trivial merge case.
> Otherwise you would need to use "git checkout -m" (to merge), or
> "git checkout -f" (to force checkout, possibly losing changes).
> 

So if I am working on more than one branch at a time I need to commit my changes every time before I do
'git checkout <branch>'?

>> And after running 'git status' on master I get:
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #
>> #       modified:   somefile
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>>
>> Basically I see that the same file I edited on the 'test_branch'
>> branch appears to be modified on the 'master' branch as well. This
>> behavior is unwanted, of course.
>>
>> Can someone please tell me, what am doing wrong? Or is this git's
>> normal behavior?
> 
> This is normal, and wanted, behavior.
> 

That's a subjective point of view :) I'm coming from the SVN world and uncommitted changes on one branch don't affect other branches. Is there a way I can achieve this behavior with git?
