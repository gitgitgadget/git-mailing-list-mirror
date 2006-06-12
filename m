From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Sun, 11 Jun 2006 23:39:08 -0400
Message-ID: <9e4733910606112039p7aff60c7w7a074d0e35c7b0f@mail.gmail.com>
References: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
	 <Pine.LNX.4.64.0606112028010.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 05:39:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpdGk-0003vD-2B
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 05:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWFLDjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 23:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWFLDjK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 23:39:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:25406 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWFLDjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 23:39:09 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1540581nze
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 20:39:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cDHPTzyTMPLX+PHaFsnGEsU0JbSau7aPtfvcFs+h06ju4yK3z40A/AAU5nrduiUQI77u2jEWklgH8xNN9rb8cAELkXy4b7SeXJuJadFaDE5rkfLefu2NK3ArlJ7X4akwAp7AtcMu9Ea0wzHfT6Q5YECgske3XJ/mBkU6sVdptgY=
Received: by 10.37.12.54 with SMTP id p54mr8023350nzi;
        Sun, 11 Jun 2006 20:39:08 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Sun, 11 Jun 2006 20:39:08 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606112028010.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21684>

On 6/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sun, 11 Jun 2006, Jon Smirl wrote:
> >
> > I have Mozilla CVS in a SVN repository. I've been using git-svnimport
> > to import it. This time I am letting it run to completion; but the
> > import has been running for four days now and it is only up to 2004.
> > The import task is stable at 570MB and it is using about 50% of my
> > CPU. It is constantly spawning off git write-tree, read-tree,
> > hash-object, update-index. It is not doing excessive disk activity.
>
> This sounds like _exactly_ what happens if you don't repack occasionally.
> Expecially if you are using a filesystem without hashed filename lookup,
> but it's true to some degree even with that - the filesystem tends to end
> up spending tons of time in kernel space, trying to find a place to put
> new objects.
>
> I don't think git-svnimport has the repack logic in it, so that would be
> it.
>
> You can probably stop it with ^Z, do a "git repack -a -d", and then let it
> continue.

I have it stopped and I am running the repack.
There are 1.27M files in my .git directory

I ordered 2GB more RAM which should be here Tuesday.

> (The only reason for stopping it is actually to let "git repack" remove
> most of the object directories - many filesystems, including ext3, don't
> even speed up all that much if the directories are emptied after they've
> grown big, and it's much better if the object directories get totally
> removed and re-created)
>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
