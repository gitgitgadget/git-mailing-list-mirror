From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Mon, 26 Nov 2012 14:11:57 +0100
Message-ID: <CAMP44s2FcrjDhNzond=Rzmn5QOBnZbQC1d73ZmKNeyCRvJNvyA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
	<20121125051809.GA3670@thyrsus.com>
	<CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
	<20121125095429.GB22279@thyrsus.com>
	<CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
	<20121125175051.GD32394@thyrsus.com>
	<CAMP44s3QNG-sxcZsWmL3RYjXkzOwerj2774t7Abh04A7QR6TCA@mail.gmail.com>
	<20121125215635.GA6937@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Nov 26 14:12:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcyTu-0002M2-MM
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab2KZNL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:11:59 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37654 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab2KZNL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:11:58 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so10700122oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7H3VJzbqG59/GwvLlvV7Gq/dLjPmTcrBwQID1nji6kA=;
        b=BtDk3KlqOK392cmSgyM83JAljyLSKPsY8zX51qbDWN7E0G3CoZXoTQGa/t6wqLaEgb
         KcX6S30hXgzOLvibhYIhRfZYF2FbNyB7yVCveazpUY9qb5eCn/7KS+jJZWB8RHq433P7
         /DtVhYlqSMi74vz5prjJgN+B3nZE5uS8neUmWIq7aRSZUBqFsxlP67C0ChDNdlcF4oDx
         VktDwv6m+SK7i+V+/lVTZSQMGwVXkIvxD3XGqvyCnLAIClTB7zmGbqu9cIMi9sZxuM0I
         WfO8mT9IFwt/BgQ2CSs2wPnSGHsvDr93T+2V4su2jdrNH/ZyuEFZM3M8p839JmFCiieP
         RMkw==
Received: by 10.60.30.70 with SMTP id q6mr8916349oeh.103.1353935518142; Mon,
 26 Nov 2012 05:11:58 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 05:11:57 -0800 (PST)
In-Reply-To: <20121125215635.GA6937@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210440>

On Sun, Nov 25, 2012 at 10:56 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> And gitk is an integral part of git. But if you have different
>> numbers, what are they?
>
> I looked at the Makefile.  I saw that there are shell variables that collect
> C commands, shell command, Perl commands, and Python commands.  There are no
> collections of other commands.

I suppose you are talking about BUILT_INS, and SCRIPT_FOO, but tcl
scripts don't need no SCRIPT_FOO stuff, because they don't need to be
regenerated, in fact, I don't think the shell scripts need to be
regenerated, but that's not important, what is important is this:

all::
ifndef NO_TCLTK
	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
endif

Why are you ignoring that?

> That makes them the top languages in the universe we are concerned about

According to whom?

I find it very curious how you are arguing for a change in the status
quo to move more towards python, and the basis you are using for
choosing python, and not ruby, or other scripting language is
precisely the status quo. However, the only scripts using python are
these:

SCRIPT_PYTHON += git-remote-testgit.py
SCRIPT_PYTHON += git-p4.py

I already re-wrote git-remote-testgit in bash, and it's dubious
whether or not git-remote-testpy (the new name for this old test) will
fulfill any service. Than means 43% of the current python code is
gone.

And what happens if I rewrite git-p4 in ruby? Would you then argue
that ruby is the way to go because 1% of the *current* code-base uses
it?

Interestingly, according to Wikipedia git is written in: C, Bourne
Shell, Tcl, Perl. That seems to be the case.

> Please don't waste further time on quibbling.  We all know that gitk is
> an uncomfortable special case and that the project would be far better
> off, maintainability-wise, if it were successfully ported to one if these
> other languages.

As I said, gitk is integral to the git experience. Of course you are
free to disagree, but according to the last user survey 57% of the
responders used some kind of graphical tool (e.g. gitk, tig). How many
use gitk, and how many use something else, we don't really know, but
what we know is that gitk is distributed *by default*.

Nobody is arguing that gitk should not be distributed by default, just
like nobody is arguing that git-p4 shouldn't, but we *know* very few
people use git-p4 (1% according to the survey), and we can reasonably
assume that many more use gitk.

You cannot have your cake and eat it at the same time. If you use the
amount of code as a measure, then you have to agree that Tcl/Tk is a
way bigger language than python in the mainline git world. If not,
then by all means, show us the numbers. But you can't say "the
important languages are A, B, and D, C doesn't count because I don't
like it, and E doesn't count either because we should draw the line at
three", that seems awfully convenient to push your agenda.

And I don't agree that the project would be better off with something
else, if it was, somebody would have proposed an alternative by now,
but there aren't any. I have tried gitg, and giggle, and I have even
contributed to them, but they are just not as good and useful as plain
old gitk, I always keep coming back.

gitk:
 * is blazing fast to start
 * doesn't have a lot of dependencies: just tcl/tk
 * works on Windows without a major fuzz
 * is actively maintained
 * shows a proper graph (unlike gitg or giggle)

Now, show me an alternative that fulfills all these points. And I'm
pretty sure you won't find one, because if you did, it would have been
already proposed for mainline git... there isn't any. And if you did,
we would start with oh, but it's GTK+, or it's Qt, and how do you make
it work on Windows. No, gitk is just fine, and works great.

Tcl/Tk might not be your cup of tea, and indeed it's rather unmodern,
but that only tells you how an awful job the modern toolkits have done
with regards to portability and flexibility.

You were arguing for portability, well, Tcl/Tk works on all platforms,
here, have a look, there's no other tool that fulfills this:

http://www.mediawiki.org/wiki/Git/Graphical_User_Interfaces

> Trying to catch me out by triumphantly pointing at gitk is...juvenile.

Isn't that what you are doing by triumphantly pointing at git-p4?

Sorry, if you want to cut the line for the languages that git should
use right now at three, then python is out. Maybe in a couple of
years. Maybe. But I doubt it.

Cheers.

-- 
Felipe Contreras
