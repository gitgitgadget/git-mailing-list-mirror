From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git svn with non-standard svn layout
Date: Sat, 24 Sep 2011 23:45:50 -0400
Message-ID: <CABURp0qcS4qNuKDjC=g2tak+1eQWyzgVj_8ac9u1mdm4uX0yMg@mail.gmail.com>
References: <CANPpUWyX+n7kMKZpCV=Oy=UmJb=9H=uZseYzU2-h1FLh2nzg8w@mail.gmail.com>
 <CANPpUWxnp3-ySO3oBEsWTQA=oWXEzKS1bddP9LjAsR1EyPxbVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Harris <chris.harris123@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 05:48:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7fi1-0008CD-VO
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 05:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab1IYDqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Sep 2011 23:46:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48850 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab1IYDqM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 23:46:12 -0400
Received: by wyg34 with SMTP id 34so5002825wyg.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 20:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=o0rAMTpr8fwoiai1OEuaxlZfE4JyamSFfUo00osfd80=;
        b=kL1AYgumLkoZ1whH+z1fvtlHlGf4VOH8LWj4zjQ2C5Khb49FdH6lOyEdRnBnI4yk0z
         vxoAyhL6yO8I58OXOqJpiIobmPvB4gXs/WLLpyg/1fF2Ho7KSDAcJ70bVI3eWnVo1x7p
         UeZfgJolVK0owdxMOdEJi9V3bQAem+02J2iDI=
Received: by 10.216.132.211 with SMTP id o61mr62884wei.87.1316922370651; Sat,
 24 Sep 2011 20:46:10 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Sat, 24 Sep 2011 20:45:50 -0700 (PDT)
In-Reply-To: <CANPpUWxnp3-ySO3oBEsWTQA=oWXEzKS1bddP9LjAsR1EyPxbVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182055>

On Sat, Sep 24, 2011 at 2:37 PM, Chris Harris <chris.harris123@gmail.co=
m> wrote:
> I am using =A0git version 1.7.6.4 built from the latest stable source=
 on
> github. =A0 Running Ubuntu with kernel 2.6.38-11-generic
>
> I can't seem to git git svn to see my branches correctly.
> Unfortunately my svn repository is not open source, so I can not post
> it here, but I will try to explain my issue.
> We use a non standard svn layout like the following
> branches
> =A0 =A0 =A0 =A0 V4.1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4.1.0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4.1.1
> dev
>
>
> dev is our trunk, and our branches have 2 levels.
> I first use git init, then=A0setup my config as follows
> [svn-remote "svn"]
> url =3D file:///home/chris/svnrepo
> fetch =3D dev:refs/remotes/trunk
> branches =3D branches/V4.1/{V4.1.1}:refs/remotes/branches/*
> For this example I am just trying to make a single branch work.
> After a fetch all revisions are ok. master correctly points to
> remotes/trunk,but gitk shows the following:
>
> o remotes/branches/V4.1.1
> |
> o some commit
> |
> |
> | =A0 =A0o master - remotes/trunk
> | =A0 =A0|
> | =A0 =A0o another commit
> | =A0 =A0/
> |
> etc
> ( sorry for the bad ascii art. )
> My issue is that trunk ( master ) appears to be a =A0branch from V4.1=
=2E1
> instead of =A0V4.1.1 being a branch from trunk ( master )

In git's estimation, =A0there is no difference between these two cases.
Visually you may think there is a difference, but graphically (in the
"network graph" sense of the word) they are exactly the same thing.

Consider this history:
o---o---A---B---C <=3D=3D trunk
=A0 =A0 =A0 =A0 =A0\
=A0 =A0 =A0 =A0 =A0 D---E---F =A0<=3D=3D V4.1.1

Compare it to this "other" history:
=A0 =A0 =A0 =A0 =A0 B---C <=3D=3D trunk
=A0 =A0 =A0 =A0 =A0/
o---o---A---D---E---F =A0<=3D=3D V4.1.1

You might say the first one looks "right" and the second one looks
"wrong". =A0But in fact, they are the same graph. =A0They both say that
B's parent is A and D's parent is A. =A0B and D share a common ancestor
at A.

Here's another view:
=A0 =A0 =A0 =A0 =A0 B---C <=3D=3D trunk
=A0 =A0 =A0 =A0 =A0/
o---o---A
=A0 =A0 =A0 =A0 =A0\
=A0 =A0 =A0 =A0 =A0 D---E---F =A0<=3D=3D V4.1.1

You may want to read this nice description of the DAG:
http://eagain.net/articles/git-for-computer-scientists/

> git log --graph shows the same structure.
> Any suggestions on how to configure this so git svn maps my
> non-standard layout correctly?

Try git log --graph --date-order to see a slightly different take on th=
ings.

Phil
