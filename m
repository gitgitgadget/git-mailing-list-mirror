From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Looking for a way to set up Git correctly
Date: Thu, 11 Nov 2010 10:38:47 +0100
Message-ID: <AANLkTi=CTR-i2v-hi6dp_OAOf6Y7UO2giQq_Uq-tDs=M@mail.gmail.com>
References: <BD94CB4FDD0C4462804E316F814A3CCA@denny>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dennis <denny@dennymagicsite.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 10:38:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGTcM-0006SX-PN
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 10:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab0KKJit convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 04:38:49 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64479 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0KKJis convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 04:38:48 -0500
Received: by gxk23 with SMTP id 23so1028320gxk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 01:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=axStmWDRazIr3Phcqd0lZKiqF6i9lyzl0SbRtyJAeCc=;
        b=Aa0b0p4GEeDMI9Nzh2GDrsC1Vv5ztOhohptJHvwIzGSHEJ+eJpRlWchMj7ESL78alm
         30U3yhKOylv+OKLaZzGun/NO/IYKjj1ja+z1LwE9tDhrpWrn7Ig779ERuY7HmFUHU6z8
         eFG9+lbPjPkTqCV6lTSSlJpfKgC6gAl6ManKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RnB0rasNZQP+X+tMp0VD2ir9mtkKmnlQ5jFG5qLWq62pIs26OWA4dJ3FQGpm1EFpTv
         GucxlqtQQVSZfhFuqOGC5QhI6ziRqRWsPCInBY+qXYuL+WAGLfPQHzUoKZfffq3dLy27
         KmZCz3A9xaggfHxcZE6HebAMSunMttqxYQ+2A=
Received: by 10.90.185.14 with SMTP id i14mr1104432agf.178.1289468327299; Thu,
 11 Nov 2010 01:38:47 -0800 (PST)
Received: by 10.90.6.32 with HTTP; Thu, 11 Nov 2010 01:38:47 -0800 (PST)
In-Reply-To: <BD94CB4FDD0C4462804E316F814A3CCA@denny>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161220>

On Thu, Nov 11, 2010 at 04:25, Dennis <denny@dennymagicsite.com> wrote:
> I have started a web project (call it branch1), and have maintained i=
t
> without a version control system for quite some time.
> Then, I copied it to another folder (branch2) and while the project r=
emained
> essentially the same, I have changed a few of internal paths and some
> variable names inside the files.
> Then, a few months later on, I copied branch2 to a folder called bran=
ch3 and
> also modified some of the variable names and some of the internal str=
ucture
> of the files.
>
> Thus I ended up with 3 folders on my local HDD with pretty much the s=
ame
> file names and folder structure and everything, and most of the file
> content, except those small deltas that made those files different fo=
r each
> branch.
>
> I guess it's never too late, and now I want to put these 3 projects i=
nto a
> version control system, and I chose git.
>
> Now, this can be either really simple or really complicated. =C2=A0My=
 first
> question is: =C2=A0how do I set the repository up in the proper way w=
here I could
> work on all 3 projects separately, with additional possibility of wor=
king on
> branch1 only and later committing my changes to branch2 and branch3. =
=C2=A0(Since
> projects are virtually identical, a fix in one branch usually needs t=
o be
> propagated to other branches)
> First, I assume I will use a single repository for this. =C2=A0Then, =
do I simply
> set up 3 branches and start using them, or is there a way to set git =
up to
> capitalize on the projects being nearly identical?

Assuming I've got the relationships of your "branches" right:

$ cp -a branch1 branch && cd branch
$ git init
$ echo /huge-images/ >.gitignore
$ git add .gitignore; git add .; git commit; git branch branch1
$ git checkout -b branch2
$ cp -a ../branch2 .
$ git add .; git commit
$ git checkout -b branch3
$ cp -a ../branch3 .
$ git add .; git commit

> My second question is that each branch has a huge folder with image d=
ata. By
> huge I mean 1 to 4Gb, depending on the branch. =C2=A0Since images are=
 not
> directly relevant to the development work, is there a way to not incl=
ude
> those folders in git? =C2=A0To be honest though, I probably should in=
clude them,
> but I wanted to ask about this separately as git repository may be ge=
t
> large, since all 3 branches may grow to 9Gb or so.
>
> Thus I am looking for a git way to handle my situation. =C2=A0Is this=
 simple or
> is is hard?

If you add the images you will eventually run into problems (heavy
swapping, for one).
Git is not really setup to work with big binary files (a file must fit =
into
memory completely).
