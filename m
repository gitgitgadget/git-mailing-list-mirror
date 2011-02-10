From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Debugging Git push failure
Date: Thu, 10 Feb 2011 13:06:09 -0600
Message-ID: <4D543721.5050103@gmail.com>
References: <AANLkTimcGtDKZ2YU0Z_pc-aRtp-etXFWZ9-drSzpS3KN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Adamson <jwa@urbancode.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 20:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnbsf-0008K7-Ul
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 20:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab1BJTIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 14:08:37 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61077 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab1BJTIg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 14:08:36 -0500
Received: by gwj20 with SMTP id 20so739396gwj.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=n4vZgbZJGvjIKyG7w16JsLK3sDhjXB1yzwcQ4BSDTZE=;
        b=SMO3hpQiGJydlyuj7jhlqSpttrvdGhr3IaiuY2jdbOoZpnTPAP7vcoqPB+xnGiENJJ
         iCkYyP/KVy39omQ7ZQXlDNAG08M1nEK9OBgpAP5abeMPXnukBBHMCnnuyHTJbNSLp9eS
         DwoSWduoFkeYb++V7fbiwuGsJ2usEkXGphuYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=eywgH0EMh3u6wQR3XaDHjKIKoyY/WYinJiCeuEktUAtYWLQoVrcz392yQSjI9uMZ73
         VyCz6VfmyMchxrWwrXjamDIdQ07zIY0NCQHV6aZpNw8XPkdC8brVi8nQE4PKtYVrxtgv
         326HXldr9/7FOdIMqZTvFaUIrOFCQpxTEqy/4=
Received: by 10.236.103.139 with SMTP id f11mr1526201yhg.42.1297364914863;
        Thu, 10 Feb 2011 11:08:34 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id f13sm195272yhf.33.2011.02.10.11.08.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 11:08:33 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTimcGtDKZ2YU0Z_pc-aRtp-etXFWZ9-drSzpS3KN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166493>

On 2/9/2011 12:57 PM, Jeff Adamson wrote:
> Several developers on my team are experiencing an occasional failure
> during push.  A subsequent push executed immediately afterward the
> failure will work fine.  We are a small team of developers (about 10)
> and only a couple users seem to experience this and then only
> intermittently (every few days).
> This is happening on a LAN environment with otherwise reliable
> connectivity.  We have some hook scripts for post-update and update
> configured within the repo.
>
> the server has git version 1.7.3.3 installed
> $ cat /etc/issue
> CentOS release 5.5 (Final)
> Kernel \r on an \m
> $ uname -a
> Linux core1.example.com 2.6.18-194.26.1.el5 #1 SMP Tue Nov 9 12:54:20
> EST 2010 x86_64 x86_64 x86_64 GNU/Linux
>
> Here is some output from one of the users during two sequential runs
> of `git push -v`.  This user is git version 1.7.3.1.msysgit.0 (though
> similar behavior has been seen by another user with version 1.7.0.4 on
> ubuntu 10.04 LTS)
>> git push -v
> Pushing to ssh://git.example.com/data/git/example/scratch/bdd/cssearch-mockup.git
> Counting objects: 9, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (5/5), done.
> Writing objects: 100% (5/5), 505 bytes, done.
> Total 5 (delta 4), reused 0 (delta 0)
> fatal: The remote end hung up unexpectedly
> fatal: The remote end hung up unexpectedly
>> git push -v
> Pushing to ssh://git.example.com/data/git/example/scratch/bdd/cssearch-mockup.git
> Counting objects: 9, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (5/5), done.
> Writing objects: 100% (5/5), 505 bytes, done.
> Total 5 (delta 4), reused 0 (delta 0)
> To ssh://git.example.com/data/git/example/scratch/bdd/cssearch-mockup.git
>    bffa1a7..8fd772d  master ->  master
>
>
> Anyone know what could be causing this and, just as important, how to
> debug it and issues like it in the future?
> Thanks for any help/insight which can be offered.
> --Jeff
I don't use ssh, but I use the git:// protocol and have also had push 
errors locally.  I run RHEL and when I get errors with git protocol I 
check /var/log/messages.  Find out where your log messages are going and 
check them.  You could also check permissions on the destination repo. 
Look at its object store recursively, ie. .git/objects/, and do "ls -la" 
to see the permissions.  People could be pushing stuff up with the wrong 
permissions and then someone else can't get to it.  Just some ideas...

v/r,
Neal
