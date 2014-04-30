From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] wincred: add install target and avoid overwriting
 configured variables
Date: Wed, 30 Apr 2014 13:56:05 +0200
Message-ID: <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com>
 <20140430112724.GA22929@camelia.ucw.cz>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 30 13:56:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfT8A-0002xS-T3
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758171AbaD3L4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:56:51 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:47141 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbaD3L4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:56:50 -0400
Received: by mail-ig0-f179.google.com with SMTP id hl10so1666295igb.6
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2FaqzTWewS4TITLpap0vMFtXuBhX5LtRYg8ySuZS4x8=;
        b=QRRtdaW+LXyPYwLUTfql77oDx1FgIR6roIojQfUfeSM4RB8TBJ8a2B40xTP5cvGNQv
         qALARYD2zJaZw2xmhdN/kxqdtsv/kX4rXgm13JARtTyCzDzjD4oILVCDUnzNi8oBhOEu
         HiOFcjhgAHEfYgFVoI+KEpLY920hLJuobBy5DOBmup3nigNU3HG4N8//J0GIgjHsn327
         plYLYu+JHUDaN1NH1on3I9pDO0cmdku3dhJnp7gWNRvCKCWqUto6ppWjWd9g+o1eP+8h
         zHOc6UBCMPTmFT8FezTPwgeUYRADE1ajlmOytdldncWQCip+vTKNQ9dxNDvY4YLI82CP
         G/nQ==
X-Received: by 10.42.162.68 with SMTP id w4mr3282553icx.50.1398859006142; Wed,
 30 Apr 2014 04:56:46 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 30 Apr 2014 04:56:05 -0700 (PDT)
In-Reply-To: <20140430112724.GA22929@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247707>

On Wed, Apr 30, 2014 at 1:27 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> Hello,
>
>> On Wed, Apr 30, 2014 at 8:46 AM, Stepan Kasal <kasal@ucw.cz> wrote:
>> > Date: Wed, 24 Oct 2012 00:15:29 +0100
>> >
>> > Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> > Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> > ---
>> > Another one from msysGit project.
>> > Original subject by Pat; I would suggest:
>> >     wincred: improve Makefile
>
> On Wed, Apr 30, 2014 at 11:21:17AM +0200, Erik Faye-Lund wrote:
>> I'm a little bit unsure about this, because the makefile was basically
>> just copied from contrib/credential/osxkeychain/Makefile (which was
>> the first credential helper) and tweaked slightly.
>>
>> So, what makes wincred special compared to gnome-keyring, netrc and
>> osxkeychain wrt installation? Shouldn't all helpers get the same
>> treatment?
>
> I can only guess that the hardwired CC and CFLAGS values can cause
> problems.

I doubt that a patch that doesn't describe exactly what kind of issues
will get merged. And it certainly won't get my ack unless I understand
why.

> It is probably much sane on Windows to use the compiler that the user
> set up for the build.

But you can already do that, the same way as for the rest of git, by
overloading these in config.mak in the root of the git repo.

> I'm not sure if users of, say, OS X, have the same problems, so I
> would hesitate to apply these changes to all helpers.

Even if I bought that it's needed (which I'm currently skeptical to),
I think the "dunno about OSX" is a bit of a cop-out.

>> > From: Pat Thoyts <patthoyts@users.sourceforge.net>
>> >  contrib/credential/wincred/Makefile | 22 ++++++++++++++--------
>> >  1 file changed, 14 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
>> > index bad45ca..3ce6aba 100644
>> > --- a/contrib/credential/wincred/Makefile
>> > +++ b/contrib/credential/wincred/Makefile
>> > @@ -1,14 +1,20 @@
>> > -all: git-credential-wincred.exe
>> > -
>> > -CC = gcc
>> > -RM = rm -f
>> > -CFLAGS = -O2 -Wall
>> > -
>> >  -include ../../../config.mak.autogen
>> >  -include ../../../config.mak
>> >
>> > -git-credential-wincred.exe : git-credential-wincred.c
>> > +prefix ?= /usr/local
>> > +libexecdir ?= $(prefix)/libexec/git-core
>> > +
>> > +INSTALL ?= install
>> > +
>> > +GIT_CREDENTIAL_WINCRED := git-credential-wincred.exe
>>
>> Why this variable? IMO, it's just as "GIT_CREDENTIAL_WINCRED" easy to
>> miss-spell as "git-credential-wincred.exe", and it doesn't seem to be
>> possible to overload.
>
> If you mis-spell a variable name, nothing is build.  If you misspell
> a binary name, that binary may get compiled using a default rule;
> that is why I would generally prefer variables.

Following that logic, you should be submitting similar patches to the
main git Makefile as well. Somehow I doubt that'll happen.

> Moreover, if the cardinality of the set ever increases, the
> indirection may get helpful.

I don't think there's any reason to expect the number of binaries to
increase, so that's moot. And if I'm wrong, let's deal with that when
the time comes. It's not like this version is prepared for the
variable being a list either - neither should there IMO.

>> > +
>> > +all: $(GIT_CREDENTIAL_WINCRED)
>> > +
>>
>> Also, why move the all-target down from the top? Is it simply because
>> of the definition above?
>
> Again, I agree with Pat that it is nicer this way, but no big
> deal.

We don't usually do "this is subjectively better"-patches in Git.
Instead we try to follow the current style.
