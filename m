From: Patrick Notz <patnotz@gmail.com>
Subject: Re: Clone a repo and checkout a specifc remote branch
Date: Sat, 7 Mar 2009 11:53:56 -0700
Message-ID: <1cd1989b0903071053l3f7aa35bu8e8e6b7e56cfc34f@mail.gmail.com>
References: <4d8e3fd30903070342q584315cjcd059dcfe558dcfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 19:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg1gG-0001mC-NV
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 19:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbZCGSx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 13:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbZCGSx7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 13:53:59 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:4171 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbZCGSx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 13:53:58 -0500
Received: by el-out-1112.google.com with SMTP id b25so587895elf.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5D3aZzAd5lHaFXU/joogCM1TsXvcChstDLSyySNQHSA=;
        b=x2SIo0zDKgziRvFGMMxUU/h0xCCwgs3pp2XEMbipoE9T0GVHIZ6qnc2ZIjZXuDSOhA
         xCV0/jk8TDZa8DKGFcjywN/pvyRfY5WWy7WhRStox41lzJCp1mVLrq15aMCI+WzDErwU
         Cbj4EqgehghWUkwrjt9rrdMM8S+w78KHi3IAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Cq1ign+6Q6XytdmPzelIV/P6Kd3pftAAByumXfJx4FH81F5LGwmKm7q8gg6Us4KYk3
         w7Y6j5R4sMeIj6SmgDoVB+tHjmEsQHsQ8jRCz82k5fuCbwQu+HZvJphd5j/jnarx3NRB
         86wv4qZoRKI5LdOuqVTxBSxjtxBI2lPyy0Fb8=
Received: by 10.220.81.19 with SMTP id v19mr1205428vck.100.1236452036296; Sat, 
	07 Mar 2009 10:53:56 -0800 (PST)
In-Reply-To: <4d8e3fd30903070342q584315cjcd059dcfe558dcfd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112561>

On Sat, Mar 7, 2009 at 4:42 AM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> Hi list,
> I've got a few questions from a friend that used git for the first
> time, I answered to all of them but the following.
>
> Scenario:
> He knows the URl of a git repository which contains a few branches. He
> is interested only to a single specific branch.
> He expected to manage to clone the specific remote branch with a
> single command, instead he had to learn the following procedure:
>
> $ git clone git://uri_of_the_repo localdir
> $ cd localdir
> $ git branch
> * master
> # OK, so now he cloned the whole repository and checked out the master branch
> $ git checkout mybranch origin/coolbranch
>
> Wouldn't be an improvement to let the user to specify which remote
> branch he want to be checked out after a clone?
> Something like:
> $ git clone git://uri_of_the_repo:coolbranch localdir
> to get a clone of the whole repository and to check out the
> origin/coolbranch remote branch?
>

Here's a link to a recent thread on this topic (that started with a
proposed patch)

http://thread.gmane.org/gmane.comp.version-control.git/111967

You can read the arguments there.  Johannes Schindelin noted that the
normal way to do this is like this:

<quote>
Besides, the common way to check out something different than the remote's
HEAD is like this:

$ git clone -n $URL
$ cd $DIR
$ git checkout -t origin/$BRANCH
</quote>


> I quickly discussed this scenario on the #git channel and a user
> suggested to use the following procedure:
> $ git init
> $ git fetch git://uri_of_the_repo coolbranch
> which was new to me, I tried it as follow:
> $ git fetch git://git.kernel.org/pub/scm/git/git.git man
> remote: Counting objects: 7319, done.←[K
> remote: Compressing objects: 100% (1536/1536), done.←[K
> remote: Total 7319 (delta 5640), reused 7290 (delta 5625)←[K
> Receiving objects: 100% (7319/7319), 1.40 MiB | 110 KiB/s, done.
> Resolving deltas: 100% (5640/5640), done.
> From git://git.kernel.org/pub/scm/git/git
>  * branch            man        -> FETCH_HEAD
>
> but now I don't understand how to checkout the branch :-/
>
> Ciao,
> --
> Paolo
> http://paolo.ciarrocchi.googlepages.com/
> http://mypage.vodafone.it/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
