From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Editing the root commit
Date: Tue, 19 Jun 2012 17:20:48 +0530
Message-ID: <CAH-tXsAZXfVshXi8GH+pW8rMbeFK1_LuSLNBp5=bjutN67K9bQ@mail.gmail.com>
References: <20120619091657.GA28005@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgwy9-0006aE-2O
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 13:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab2FSLvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 07:51:32 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62167 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab2FSLvb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 07:51:31 -0400
Received: by weyu7 with SMTP id u7so4345256wey.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GYd7cqgyw7VR8PfW+w71zVFwsxnGhUCyUUCeRQaBgZc=;
        b=A5MxAr8HcMp9e4pg7sGEgS8hlm/sliOGQ8RG+B9iP5Tm08W7tgAusyuKBb+VuQFa35
         FaVOu1asXRd0QVRNw42/osd92sJzT2un1B2xn94oGZkgqGchGnzMfJxw1eeEJuL/YLHp
         oVAl+gOyWS6h3hGc6D/8lEj4ZEaXYZL2UbWAyspyMhqrCEbxtoOIs+93hhIIwhg5WbX8
         0dw/w4Rex1rvsrEkzU/YbdKxV0H13kKttIr7BQdOtVLvI8cshEtX+3gKwxQw8ue462QR
         jCEe1CQAEutkGFfh6Up0/Tk+6N6guYdhd9pjDAiBYqdWN5n2W5lgc+KNMjaTemhDbmzN
         axtA==
Received: by 10.180.83.197 with SMTP id s5mr2847498wiy.9.1340106689197; Tue,
 19 Jun 2012 04:51:29 -0700 (PDT)
Received: by 10.227.37.22 with HTTP; Tue, 19 Jun 2012 04:50:48 -0700 (PDT)
In-Reply-To: <20120619091657.GA28005@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200198>

On Tue, Jun 19, 2012 at 2:46 PM, Chris Webb <chris@arachsys.com> wrote:
>
> I've recently been polishing up some private code for release, using =
git
> rebase --interactive to expand on some commit messages.
>
> In a couple of cases, I wanted to edit the root commit. (Adding a COP=
YING
> file, for example.) I've been successfully doing this with an explici=
t
>
> =C2=A0ROOT=3D$(git log --pretty=3Dformat:%H | tail -n 1)
> =C2=A0git checkout $ROOT
> =C2=A0git commit --amend --message=3D'Initial import modified' # for =
example
> =C2=A0git rebase --onto HEAD $ROOT master
>
> However, this brought two questions to mind.
>
> The first is whether there's a clever symbolic way to refer to the ro=
ot of
> the current branch, rather than tailing git log output? gitrevisions(=
7)
> doesn't obviously suggest one.
>
> The second question is whether it's possible to use git rebase
> --interactive
> to edit the root commit along with some subsequent ones in one fell s=
woop?
>
> My fingers half-remember doing something like
>
> =C2=A0git checkout --orphan rewritten
> =C2=A0git rm -rf
> =C2=A0git rebase --interactive --root --onto rewritten master
>
> a year or so ago, but this now fails (on git 1.7.10) with the somewha=
t
> surprising error
>
> =C2=A0$ git rebase --root --onto rewritten master
> =C2=A0fatal: Needed a single revision
> =C2=A0Does not point to a valid commit: master
>
> Am I misremembering the recipe here, or has the behaviour changed? It
> seems
> to fail identically with or without --interactive.

I was trying to do something very similar yesterday. I was cleaning up
a lot of commits with a rebase -i when I figured out that I cant do
that on the root commit.

The man on interactive rebase says,

        Start it with the last commit you want to retain as-is:
        git rebase -i <after-this-commit>

which means root cant be included. Finally I had to settle for some
solution like what you mentioned.

If possible Junio, can a feature be added to include root commit also
to git rebase -i somehow so that a rewrite including root is easier
and more straightforward ?

--
Jaseem Abid
http://jaseemabid.github.com
