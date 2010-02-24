From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] git checkout -b: unparent the new branch with -o
Date: Wed, 24 Feb 2010 19:14:24 -0300
Message-ID: <55bacdd31002241414p4428165asea22b71726afff68@mail.gmail.com>
References: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com> 
	<m3ocjfmt60.fsf@localhost.localdomain> <55bacdd31002241410h747ae221xd72dfcf269bdb84e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:20:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkPap-0000LA-S4
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 23:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265Ab0BXWU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 17:20:27 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53428 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190Ab0BXWU0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 17:20:26 -0500
X-Greylist: delayed 1010 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2010 17:20:26 EST
Received: by gyh20 with SMTP id 20so949803gyh.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j7aBiJibf55fFACvdIEuAiqpA1GBpHvk9lR0vaRmN4k=;
        b=PT8WhzyA2nXZYBvd9LFHz5pgP+iW9Jk0bRRSAvWe1pPN+i2y598JHq+EZor2Lqh3Ef
         Ar7ckVbOL4nXnkk6/qi8/C7WktvIyIBG2ZSRz2WJu5gwA5TWMIV1tv6cmFi5eCKLktMK
         YNW54yFYCaSW4KQY8JXKvuH7QCcLALdwKJ0o4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qeCP1hF86gyq+W30RArV7NVwraHnG1k+qU1kLHgcTKi9hDEGp7dMRuvME9DCSaxiUU
         a/3uIg7Rry+vj5zvZcMjsobuMJlnC0+Y36ihpZhBqJdN4x32UYneOeMZfNhbDAUby1Lt
         2SqZmktheBfRfbQgj7TmybA2nQshc3MP4vsP8=
Received: by 10.150.74.17 with SMTP id w17mr233503yba.313.1267049684070; Wed, 
	24 Feb 2010 14:14:44 -0800 (PST)
In-Reply-To: <55bacdd31002241410h747ae221xd72dfcf269bdb84e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140994>

Hi,

> > Subject: [PATCH] git checkout -b: unparent the new branch with -o
>
> I would say it is rather: "git checkout -b: allow creating unrelated =
branch",
> or something like that.

I don't see a point to change something specific to a general not yet
defined option.

>
> By the way, for the solution to be complete it should work not only f=
or
> "git checkout -b" shortcut, but also for "git branch".

That is not the idea.=C2=A0 The idea is to start coding a new orphan
branch.=C2=A0 Not to create an empty orphan branch for later.

Also it is not meant to clone a commit to a new orphan branch.=C2=A0 Ev=
en
though this could be done, using "git checkout TARGET; git checkout
-ob NEW_BRANCH; git add .; git commit -C/-c TARGET --reset-author".

It is meant to start a parallel development which will be connected to
existing ones.=C2=A0 Of course there will be other possible uses (I alw=
ays
trust in people inventiveness).

>
> >
> > Sometimes it is necessary to start up a new development branch of c=
ode
> > intended to be merged in the near future to existing branches but w=
hich
> > actually does not relate to them.
>
> I'm not sure if 'unrelated but _intended to merge_' is most common
> workflow utilizing unrelated branches... and whether git should
> promote such workflow, even if only describing it in the commit
> message.

This is dependent of point-of-view.=C2=A0 So thank you very much for sh=
aring yours.

Anyway all those unrelated branches uses you mentioned would be
satisfied by this new option.

>
> >
> > The new -o/--orphan is intended to solve this situation allowing th=
e
> > creation of a new branch unparented to any other.
>
> I think that for example '--root', or '--rootless', or '--unrelated'
> would be a better name than '--orphan'. =C2=A0Besides I don't think t=
hat
> such rarely used option should squat on rare resource of single-lette=
r
> option.

Parent is the term employed even by the commits itself to describe the
commit of origin so I don't think those suggestions are nice.=C2=A0 I d=
o
agree about the importance of single-letters because we only have 26
but in this case it would be only the fifth used.

> >
> > Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
> > ---
>
> [...]
>
> > --- a/Documentation/git-checkout.txt
> > +++ b/Documentation/git-checkout.txt
> > @@ -9,7 +9,7 @@ SYNOPSIS
> > =C2=A0--------
> > =C2=A0[verse]
> > =C2=A0'git checkout' [-q] [-f] [-m] [<branch>]
> > -'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
> > +'git checkout' [-q] [-f] [-m] [-b <new_branch> [-o]] [<start_point=
>]
>
> This is not stricly correct, as you can use either '-o' OR '<start_po=
int>',
> but not both (but you can use '-o' only together with '-b <new_branch=
>').

You are right on that because start_point would be useless.

>
>
>
> > +-o::
> > +--orphan::
> > + =C2=A0 =C2=A0 When creating a new branch, set it up as unparented=
 thus
> > + =C2=A0 =C2=A0 unrelated to the previous branch.
> > +
>
> Unparented? =C2=A0Perhaps "set it up so first commit on this branch w=
ould
> be root (parenless) commit". =C2=A0Hmmm... it is not easy to describe=
 it
> well...

Everything we try do define with human language is incomplete.=C2=A0 So=
 we
normally employ added layers of information to better describe things
as much as requested.

In our case we start with a single word represented by a letter or not
that try to give an idea.=C2=A0 If not enough, by --help or when people=
 use
it incorrectly they will get a small message describing the intended
use better.=C2=A0 Then by a 'man' a paragraph.=C2=A0 Further text is ad=
ded to
the 'man' if necessary. And then the help files, tutorials and other
people.

I think all off those steps were taken correctly in this case and that
what is written now is good enough.

Thank you very much for your comments.=C2=A0 I did appreciate it.

Best regards.
