From: Peter Petrakis <peter.petrakis@gmail.com>
Subject: adding additional remote refs to a remote repo
Date: Thu, 17 Dec 2009 12:43:19 -0500
Message-ID: <a422b4da0912170943q2613faeao208eaa674d1a0afa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 18:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLKNx-0007fA-7r
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 18:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934491AbZLQRn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 12:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934725AbZLQRnX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 12:43:23 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:33052 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934957AbZLQRnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 12:43:20 -0500
Received: by ywh12 with SMTP id 12so2515330ywh.21
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 09:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=qQzLnj1oNlfpmRmbRvZpay4kqQS+z1iwbvEZZ1dEkA8=;
        b=di0qG46FnDpm1EwqfSyNu0NElsONa8eZmaeywHTYXNW7UWTnOG1ntVQ+FfReXNfLFV
         Q2McU1iQZYKthJL4OhSu/o5bD5fER2/J4Kp3zSUDqPZprBbY0wCrxy4pReMCH4H5h2HO
         Eo0+tG4JrVy++vgZNC6NSsV04//DBGxLtwq74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=GkXSX2CGwH41v5qIDFxRQbo9EFJ2N1lqgDg3RS84tr5CYNqVYJDh59e7kagBDwAFDG
         QcWec//u3DrqrRMwF0iZJQWq76/KO3nc02ebdcIGOw4l3eRuZPYzNDptyLQ0xNiQ4N0m
         NPaTkxcL1ECfNK+ryL8rdgDs1EBS639LLhxzI=
Received: by 10.150.41.9 with SMTP id o9mr4301191ybo.310.1261071799187; Thu, 
	17 Dec 2009 09:43:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135378>

I'm setting up a remote repo to aggregate some development which spans
multiple git trees. So I have a bare repo setup using gitosis that I can happily
commit to. I've added the entries directly to the config on the server...

-sh-3.2$ ls
branches  config  description  git-daemon-export-ok  HEAD  hooks  info
 objects  refs
-sh-3.2$ cat config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
[remote "drbd-8.2"]
        url = git://git.drbd.org/drbd-8.2.git
        fetch = +refs/heads/*:refs/remotes/drbd-8.2/*


but when I clone the repo, the remote doesn't show up.  What am I doing wrong?
I can easily add the remotes in my local copy and work with the
product. The problem
is that we're tracking this upstream project and need to manage
multiple versions of
it to serve past releases. So in my case the branches will directly
track the upstream
development + any changes we need and then be merged into master.

For example in my local clone.

[remote "drbd-8.2"]
        url = git://git.drbd.org/drbd-8.2.git
        fetch = +refs/heads/*:refs/remotes/drbd-8.2/*
[branch "drbd-8.2.7-merge-branch"]
        remote = drbd-8.2
        merge = refs/heads/master

Now if I push this  drbd-8.2.7-merge-branch to the central repo, the
next guy won't
know for sure what this was tracking. I also don't want to have to
'add remote ...'
every time I clone a new copy. Thanks.

Peter
