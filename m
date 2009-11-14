From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: Question about "git pull --rebase"
Date: Sun, 15 Nov 2009 00:29:17 +0100
Message-ID: <4AFF3D4D.7000308@gmail.com>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 00:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9S3j-0006P7-5d
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 00:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbZKNX3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 18:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbZKNX3W
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 18:29:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:19884 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbZKNX3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 18:29:21 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1415701eyd.19
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 15:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=+74wYfvkIKPt5Tmu9RQIyQai/NeUF9jotcz9fNH6vRs=;
        b=Hi9B9M9Niq1iEMhzkqDmE1CK84V367AHUm2hriTjcu8ZFjIPSOIQWVQB+3TyVsq+uL
         6Lx0/DFxzberRzqCkqyjOFidxFimVIDbN/3ShcwQSErtYrX/nks+m+0FYIXLdlfvPKN0
         FQwZjhGX3bozQ9yPLvnvTCDAGY+WcFFBY7e60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=P1xdYspPBXKrbAtwLjNxxb/my4d7k4kvVTRLydhGpJOZM6E3oqxwPQVD4JcfbQHyzM
         YbrAN9X7aesbH/paXNA9dl1XSp9l92DXmOxMapaGosBZmomXPBJCd9W87CWaHrnJynn6
         9GQnA5dgcXPNWKMwXOILqfm6FM1DLDw3xwN6E=
Received: by 10.213.24.2 with SMTP id t2mr952587ebb.23.1258241366560;
        Sat, 14 Nov 2009 15:29:26 -0800 (PST)
Received: from ?192.168.2.101? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 5sm2896246eyh.18.2009.11.14.15.29.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 15:29:26 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132895>

Francis Moreau schreef:
 > hello,
 >
 > Let's say I'm on a branch called 'foo'.
 >
 > I tried to rebase this branch by using 'git pull --rebase'.
 >
 > I first tried the following command:
 >
 >     $ git pull --rebase origin master:foo
 >     remote: Counting objects: 5, done.
 >     remote: Total 3 (delta 0), reused 0 (delta 0)
 >     Unpacking objects: 100% (3/3), done.
 >     From /dev/shm/git/A
 >     ! [rejected]        master     -> foo  (non fast forward)

When using a refspec, you usually mean to update a remote tracking 
branch, like refs/remotes/origin/master. Internally the refspec 
parameter is passed to git fetch, which fast-forwards your local 
tracking branch to match the remote branch.

With this command, you make git clear you want to fast-forward your 
branch refs/foo to match the remotes master branch, and then rebase your 
  current branch on that foo branch.

Foo probably is also your current branch. So what you probably want is 
to fetch the remotes master branch and rebase your current branch foo on 
it. You could do it this way:

 > Then I tried:
 >
 >     $ git pull --rebase origin master
 >
 > which worked.

This does not update any remote tracking branches, but it will rebase 
your foo branch on the remote master branch (which is what you want)
It could also be done with:

git pull --rebase origin master:origin/master

This will also update your remote tracking branch 
refs/remotes/origin/master to match the master branch on the remote 
repo. Your foo branch will then be rebased onto it.

 >
 > Reading the man git-pull I would assume the 2 commands are equivalent
 > but obviously they're not.
 >
 > So the question is: why ?

So, thats why :) They're not the same. Many words... Hope you 
understand... I hope I understood it well too..?

 >
 > Thanks
