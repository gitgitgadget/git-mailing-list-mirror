From: Chris Packham <judge.packham@gmail.com>
Subject: Re: GIT cloning(or pull/push) doesn't work properly if you have a
 sub-folder as its own GIT repo
Date: Sun, 24 Apr 2011 19:59:31 +1200
Message-ID: <4DB3D863.4080500@gmail.com>
References: <BANLkTi=YsEr9hOz7-u_t3BJUiMt+34P+ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Siddique Hameed <siddii@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 09:58:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDuD8-0006Ca-V0
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 09:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab1DXH6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 03:58:13 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:38659 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab1DXH6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 03:58:13 -0400
Received: by pxi2 with SMTP id 2so1260274pxi.10
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=kFw7laSzDfLvluCSpA1hj0CW1Ok4vODF2Nu3vELWslY=;
        b=KxZqbxXXIfaRswU8TwBtq+b6pljZ8vQSFZhp/YAn+A84gLb2Pmrty7rFRN5uxWGCPl
         99kGX75RGR8397ZxvX+lTHw9BMIa3K8dT0trpgk6FqwRBW+4ZPZa4Pih0Yrxe7iymE2U
         6muumtP1/UhXpYqQ/yLfKgs8XdiGLquwgobB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pr/4VcJ79dkQp1YQwO1AdjsxYah5R7wW1Bres/loX6rPrpS1j7yHYpPvc1DaoWK2fh
         wrP3CZX4TKDY64xgxon1PL9+skFb5gX3K3QHVNB21oNJfGvzrfMH+XgM9UE0eZiRTTLL
         98ud2+u6u92fkNxYKoji2WJ2czxT3QNI8Kgnk=
Received: by 10.142.131.21 with SMTP id e21mr1666807wfd.320.1303631892329;
        Sun, 24 Apr 2011 00:58:12 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id 25sm6193290wfb.10.2011.04.24.00.58.09
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Apr 2011 00:58:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <BANLkTi=YsEr9hOz7-u_t3BJUiMt+34P+ZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171989>

On 24/04/11 05:04, Siddique Hameed wrote:
> I don't want to categorize this as bug until I hear expert panel's
> opinion. Spare me if its a known issue or if I am doing something
> silly :) I did enough research online and couldn't find a good answer.

Not exactly an expert but I'll try to help.

> Here it goes..
>
> Let's say if I have a folder called "ParentGITRepo" which is a local
> GIT repo. I have sub folders called "Child1Repo" and "Child2" with
> some files on it. For some reason, whether accidentally or
> deliberately, I make "Child1Repo" a GIT repo on its own. GIT
> recognizes ParentGITRepo&  Child1Repo as separate GIT repositories.
> But, if I clone "ParentGITRepo" into somewhere else, I am missing
> everything from Child1Repo.

That's expected behaviour as far as I'm concerned (based on your 
example). ParentGITRepo and Child1Repo are completely independent at 
this point. Cloning ParentGITRepo won't get you any untracked files that 
happen to be in the work-tree of the repository you're cloning.

> The worse thing is, even if I cleanup
> "Child1Repo" by removing it's .git folder, the parent GIT repo is
> ignoring any activity I do in that folder.

So your options at this point are to make Child1Repo a submodule or to 
re-write ParentGITRepo and Child1Repo into a new repository combining 
the history of both. Depending on your exact needs one option may be 
better than the other so do some more googling to find something that 
suits your case.

> I think, the right way to do this setup is probably using git sub
> modules or something. But given this scenario, what is the expected
> behaviour? Am i missing? It would really make more sense if you can go
> thro the following steps (test cases) outlined below.
>
>
> # Setting up ParentGITRepo&  Child1Repo and Child2
> $ cd ~
> $ mkdir ParentGITRepo
> $ cd ParentGITRepo/
> $ git init .
> $ mkdir Child1Repo
> $ mkdir Child2
> $ cd Child1Repo/
> $ git init .
> $ echo "Child1RepoFile">  Child1RepoFile.txt
> $ git add .
> $ git commit -a -m "Adding Child1Repo content"

At this point you could have just treated Child1Repo as a normal 
subdirectory. One thing some people struggle with is the fact that git 
doesn't track empty directories, as soon as there a files in those 
directories it'll work just fine.

> [master (root-commit) 01ccc52] Adding Child1Repo content
>   1 files changed, 1 insertions(+), 0 deletions(-)
>   create mode 100644 Child1RepoFile.txt
>
> $ cd ../Child2/
> $ echo "Child2 file content">  Child2File.txt
> $ cd ..
> $ echo "Parentfile">  ParentFile.txt
> $ git add .
> $ git commit -a -m "Adding Parent content"
> [master (root-commit) b31d0a5] Adding Parent content
>   3 files changed, 3 insertions(+), 0 deletions(-)
>   create mode 160000 Child1Repo
>   create mode 100644 Child2/Child2File.txt
>   create mode 100644 ParentFile.txt
>
> ---------------------------------------
>   # Now verify ParentGITRepo&  Child1Repo working independently
> $ cd ~/ParentGITRepo/
> $ git log
> commit b31d0a5aef19c6b119d89718f560905ad0f34aa7
> Author: Siddique Hameed<siddii+git@gmail.com>
> Date:   Fri Apr 22 11:25:15 2011 -0500
>
>     Adding Parent content
>
> $ cd ~/ParentGITRepo/Child1Repo/
> $ git log
> commit 01ccc52931f8b40f6d92b29769300a254d8dd411
> Author: Siddique Hameed<siddii+git@gmail.com>
> Date:   Fri Apr 22 11:22:00 2011 -0500
>
>     Adding Child1Repo content
>
> --------------------------------------------
>
> # Now try cloning ParentGITRepo&  verify the contents inside it
> $ cd ~
> $ git clone ParentGITRepo/ ParentGITRepoClone/
> Cloning into ParentGITRepoClone...
> done.
> $ cd ParentGITRepoClone/
> $ ls -a
> ./  ../  .git/  Child1Repo/  Child2/  ParentFile.txt
>
> $ cd Child1Repo/
> $ ls -a
> ./  ../
>
> $ git log
> commit b31d0a5aef19c6b119d89718f560905ad0f34aa7
> Author: Siddique Hameed<siddii+git@gmail.com>
> Date:   Fri Apr 22 11:25:15 2011 -0500
>
>     Adding Parent content
>
> --------------------------------------------
>
> As you can see there is nothing in Child1Repo after its was cloned. I
> also tried the reverse of this. Like, having a child folder as GIT
> repo and make a ParentFolder a repo on its own&  clone the parent
> folder and the cloned folder doesnt contain anything from child repo.
>
> Let me know if you have more questions.
>
> Thanks,
>
> Siddique
> --
