From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 00/23] RFC: Introducing git-test, git-atomic, git-base and git-work
Date: Sun, 24 Apr 2011 03:16:33 +1000
Message-ID: <BANLkTinhjMtNc257NnOCZe6askr2i=4g6Q@mail.gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
	<20110423091300.GC9206@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 23 19:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDgRl-0002Pf-79
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 19:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab1DWRQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Apr 2011 13:16:36 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42842 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab1DWRQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2011 13:16:35 -0400
Received: by eyx24 with SMTP id 24so401856eyx.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7GnPT4RhquLBm9vN4wwJ+ACD5k12P+0EXpMgCkK/DgI=;
        b=Z4O7BVy9FlTgekCF77en7n0MhmPUOsbc66EY67Os6IOCrsouVfls3xcRNXDSJLnq7u
         ZpairrHbPm81qivX1p6jNNLkx+mrLt1VhRvLtvbUl97dx1oCgZmJ1vrQRl0/mlkamL5W
         yXTNjWe+xAD9SieQiRscAWMe2NSe3ngIYIZhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NteO+VQfj9eIM2TqmWpUBZTXUiw9yEAgC+gamA4Q6ZsNhKHDzRyKWmZQe6XULHHHXA
         L2dMcZBjxXo5ire6qejzQCwLi25GyoZ/P8j3CrUQyFF7Rzboz4rfxHp/bIGSwlQBUcAk
         5gAe4tBE2E/YaeKcipf4quH4fkf/iMZpHB0TM=
Received: by 10.14.122.205 with SMTP id t53mr851984eeh.106.1303578993923; Sat,
 23 Apr 2011 10:16:33 -0700 (PDT)
Received: by 10.14.45.3 with HTTP; Sat, 23 Apr 2011 10:16:33 -0700 (PDT)
In-Reply-To: <20110423091300.GC9206@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171985>

On Saturday, April 23, 2011, Peter Baumann <waste.manager@gmx.de> wrote=
:
> On Sat, Apr 23, 2011 at 05:22:29PM +1000, Jon Seymour
>  =C2=A0git checkout master
>  =C2=A0git merge debug topic1 topic2 topic3
>  =C2=A0... compile ... deploy ... test
>
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . - =C2=A0q - q -. =
=C2=A0 =C2=A0 =C2=A0 <- topic3
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 \
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . -s - s - s ---. \ =C2=A0 =C2=A0=
 <- topic2
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 \|
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0 =C2=A0t - t - t - - -\ =C2=A0 =C2=
=A0 <- topic1
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0 / =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 m =C2=A0 =C2=A0<- master
>  =C2=A0 =C2=A0 =C2=A0 / =C2=A0 / =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/ |
>  =C2=A0 o - o - o - o - o - o - o =C2=A0| =C2=A0 =C2=A0<- remotes/tru=
nk
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =C2=A0=
- d - - =C2=A0 =C2=A0 =C2=A0 <- debug
>
> Having fond a small error, I can't commit it directly on the merge m,=
 because
> It is actually a fix a topic branch. Running git checkout topicX befo=
re doing
> any change is also not an option, because I often forget to checkout =
the topic
> before commiting. And rebasing afterwards is also not that easy, beca=
use there
> is merge m in between. =C2=A0So this isn't what I actually use, but w=
ould be *iff*
> there where some sort of tool support to help me.
>
> What I end up doing is the following:
>
> - o - o =C2=A0 <- remotes/trunk
>  =C2=A0 =C2=A0 =C2=A0 \
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 d - d =C2=A0 <- debug
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t - t -t =C2=A0=
<- topic1
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s - s -s =C2=A0<- topic2
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q - q =C2=A0 <- topic=
3, master
>
>
> The topic branches are just there for illustration, I normally do not=
 track
> those explicitly with git branches, as master is rebase often on top =
of trunk,
> thanks to git-svn. Now if I do want to commit a topic branch to SVN, =
I rebase
> so that my history is now =C2=A0 trunk - topic1 - debug - topic2 - to=
pic3, master
> and then run git checkout topic1; git svn dcommit to make sure only t=
he commits
> in topic1 are commited.
>
> All in all, this workflow is not perfect, but at least it sort of wor=
ks.
>
> Now back to my initial question:
> Could your new "git work" command help me to adjust my workflow and e=
ase the pain?
>
> > Peter
>

Hi Peter,

Yes, git work is good for this use case.

You would tend to manage you master branch as in your first diagram abo=
ve.

Suppose you found a problem on topicX. So, you fix the issue inplace
on the top of your master that includes all 5 dependencies. Call this
commit m'.

You have decided that the fix really belongs on topic2. So what you do =
is:

git work update topic2 HEAD~1

This will move that commit onto the tip of topic2 (producing topic2'),
merge that into m (producing m''), and reset master to m''.

One thing to note is that you never share master. It will be a merge
hell. You only ever share topics when they become stable.

As the trunk gets updated you do:

git work merge remotes/trunk

It will merge remotes/trunk into the base of your unpublished work,
then rebase your unpublished work onto that merge.

git work is also excellent for keeping your debug branch available in
your working tree but isolated from your topics.

Things get little tricker when you have a commit that spans multiple
topics. However, there is a straight forward methodology for managing
such issues. There are also techniques for dealing with conflicts with
any dependency, especially remotes/trunk which I can explain in
another note if there is interest.

Jon.
