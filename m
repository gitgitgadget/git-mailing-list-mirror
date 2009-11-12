From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Locally manage user/branch setting files without pushing them 
	remotely
Date: Thu, 12 Nov 2009 11:13:06 +0100
Message-ID: <9accb4400911120213w35efcad3q8a24d99c37a5e8c5@mail.gmail.com>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
	 <20091111192449.GH27518@vidovic>
	 <9accb4400911120118t3257a1n6f2a05abb1008c8@mail.gmail.com>
	 <20091112092909.GA25398@vidovic>
	 <9accb4400911120129h54609846jac9eb3b6cb07b792@mail.gmail.com>
	 <20091112093146.GB25398@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Nov 12 11:13:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Wgd-0004KT-UO
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 11:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbZKLKNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 05:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbZKLKNH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 05:13:07 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:54046 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbZKLKNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 05:13:02 -0500
Received: by fxm21 with SMTP id 21so2026870fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 02:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=x/J6Yuq87Pk64iSJIxYM7DlEjsszpLPYEekRY9ximpY=;
        b=Bd8PeBXuFp1xNOIL5lhSCcIgoATXrnpt0x1HlULWayXLha0A6YiomFTZPSjxmXl2T/
         pJSfnU7Tp25cecjR+l2qW4Ddta8T8uwzLVIFgx1uxqNme0jax6Wdi/MsqK8MyFFZWIGx
         9WtF67Gth+vY841eFP5nIDQJqREwNFNoLjSiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Up/i+2SqySIRn7Rb31V/5nPsOMQoNJuybvEqsNTZPZKC5uSzIkL8S5NgaOIQop9SqW
         qaV3/YhgXxVNG5RNe57Lfv/qxvpLkjPV/4Ublo8nKWVbekEeQFgqMzqJ/EAvqYiMc+cl
         6ep1Gic7ZQMX9s9WiMKHutrOr/bIGLTfhP2Uw=
Received: by 10.204.34.196 with SMTP id m4mr2888298bkd.193.1258020786326; Thu, 
	12 Nov 2009 02:13:06 -0800 (PST)
In-Reply-To: <20091112093146.GB25398@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132761>

On Thu, Nov 12, 2009 at 10:31 AM, Nicolas Sebrecht <nicolas.s.dev@gmx.fr> wrote:
> I don't understand. You'll still have to manually these files regardless
> _how_ they are tracked.

the first time i clone the repo I had to compile them manually...
but then I would like to keep different setting in my different branches and
I would like to find a way to "load" the right conf file automatically
when I switch repo

> When I say, "out of the main development repository", I don't think "out
> of the directory of the repository" but "out of the tracking git system".

of course, which is almost the same

> I think you should look at 'git subtree' or 'git submodule' to track the
> setting files out of the _main_ repository and _inside_ the main
> development directory.

will they work with git-svn?
I'm not very familiar with them anyway.

>> we are customizing a third party product and I can't change the way it
>> is build up.
>>
>> I don't think that this situation is so uncommon anyway.
>
> Yeah, it doesn't help to be unable to do everything we want! But I'm
> pretty sure git can do something very convenient in your case.

you are right..
but since this is not so uncommon I think other people has found a way
to handle it.

May be using an external/local repository for those files.
but then I would like to have a way to link them automatically.

may be this can be achieved with some hook script..

What I have in mind is something like this:

1. creating a local repo "confrepo" on the same directory where I have
the real repo
2. .gitignore for all my local config file in the real repo
3. using the confrepo to store my local scripts and replicate in it
the same branch structure of my real repo

4. may be then I can create some hook script that when I do

$ git checkout experimental

a) it try to do the same on the confrepo (checkout experimental), if
the branch doesn't exist it does nothing else
b) copy everythink in the confrepo to my realrepo (overwriting if needed)


that way I could have something automatic. The only think I couldn't
have is, looking back in history, a way to know which config was in
place for an old commit.


could you tell me if this is even possible?


I'm going a little off-topic here proposing an idea for a new feature
What about adding a git feature to "link" different git repository?
Or providing a way to have 2 (or more) git repository in the same working area.

an ipotetical usage:

$ mkdir realrepo && cd realrepo
$ git (svn) clone http://whatever... .
--> master

$ git link createrepo ../confrepo confs
--> Initialized repo ../confrepo
--> Linked repo confs to ../confrepo
--> Created branch master in ../confrepo

$ touch localconf.properties
$ touch real-repo-file.c
$ git add real-repo.file.c
--> added real-repo-file.c to stage (as usual)
$ git link add localconf.properties
--> Added local.conf.properties to confs stage

$ git commit
--> standard commit
--> added localconf.properties to .gitignore (or .git/info/exclude)
--> commit on confs

$ git checkout -b experimental # creating new branch
--> checkout -b experimental on confs

$ # modify many things and the localconf.properties

$ git status
--> show standard output and on new section "linked files":
localconf.properties on confs has been modified

$ git add . && git commit
--> localconf.properties is committed in "confs" repository branch
"experimental"

$ git checkout master
--> checkout master on confs
--> copy all files of the confs repo to the current real repo working area

I think you got the idea.

the "linked" repo could also keep a tracked files like this:

.gitlink-source

which could keep the commit SHA of the real repo for each commit in
the confs repo

so that you had a way to get the right "confs" commit associated with
each commit on the real repo.


I don't know git enough to see how this could be hard or which
drawback could have.
