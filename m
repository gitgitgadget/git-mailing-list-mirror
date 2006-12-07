X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Remote 'master' not updated, but works somehow
Date: Thu, 07 Dec 2006 12:35:06 +0100
Message-ID: <4577FC6A.9050707@op5.se>
References: <4577FBAB.4070802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 11:36:13 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <4577FBAB.4070802@op5.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33571>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsHXo-0008Og-P5 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 12:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032074AbWLGLfL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 06:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032076AbWLGLfL
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 06:35:11 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:57173 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1032074AbWLGLfI (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 06:35:08 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 33B186BCBF; Thu,  7 Dec 2006 12:35:07 +0100 (CET)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

scratch this. I just noticed I had somehow managed to get the directory 
setup like this:

devel:softpub/mkpub.git       <-- a real repo
devel:softpub/mkpub.git/.git  <-- the repo that got pushed to

Andreas Ericsson wrote:
> Having for a long time been thoroughly annoyed by our strict umasks, I 
> decided to write a little program to deal with it, and naturally I put 
> it in a git repo. After the initial commit 
> (c0fa1db09bad112f7271378d907bf33d74c06f6b) I published it to my git 
> space on our development server and cloned it out again (to get the 
> nifty remotes things set up for free).
> 
> Then I noticed I had rushed it, as I usually do with hacks involving a 
> total of less than 200 lines of code, so I had to make a couple of more 
> commits to make it work.
> 
> After having pushed the fixes to the public site I went to have a look 
> at it in gitweb, at https://devel.op5.se/~exon/git/
> 
> I was quite surprised to find that 'master' was still pointing to the 
> root commit. After the usual culprits were excluded (permissions, bad 
> paths, whatnot), I decided to try to clone the repo again to a different 
> location.
> 
> Here's what happened:
> 
> devel!exon:~$ git clone softpub/mkpub.git/ mkpub
> remote: Generating pack...
> remote: Done counting 17 objects.
> remote: Deltifying 17 objects.
> remote:  100% (17/17) done
> Indexing 17 objects.
> remote: Total 17 (delta 3), reused 0 (delta 0)
>  100% (17/17) done
> Resolving 3 deltas.
> 
> devel!exon:~$ cat softpub/mkpub.git/refs/heads/master
> c0fa1db09bad112f7271378d907bf33d74c06f6b
> devel!exon:~$ cat mkpub/.git/refs/heads/master
> 5ba01a4709bcc8b482b207ba91d78ddb689a4091
> devel!exon:~$ cd mkpub/
> devel!exon:~/mkpub$ git push
> Everything up-to-date
> devel!exon:~/mkpub$ git rev-list master
> 5ba01a4709bcc8b482b207ba91d78ddb689a4091
> e6a80831737517aa7ef29628429a18935b71de1d
> 8926e1519f69d95685ab5252886e7b237e21108e
> c0bfedaf572ee550af7927acb89a1a2e01c1ef2c
> c0fa1db09bad112f7271378d907bf33d74c06f6b
> devel!exon:~/mkpub$ GIT_DIR=../softpub/mkpub.git/ git rev-list master
> c0fa1db09bad112f7271378d907bf33d74c06f6b
> 
> (yes, the repo only has 4 commits)
> 
> And that's where I am now. Note that *cloning* from the repo actually 
> works, although I can't for the life of me figure out why.
> 
> Any thoughts?
> 

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
