From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Tue, 2 Oct 2012 23:56:14 +0200
Message-ID: <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:57:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJASA-0004fq-NC
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 23:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645Ab2JBV4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 17:56:15 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38228 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2JBV4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 17:56:15 -0400
Received: by vbbff1 with SMTP id ff1so7162349vbb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=o+biETLlBWIwlulAudCKQ7fPIGa6ej3O5BWS7CUkWsY=;
        b=OD+J4PvvQato7vW9AJAuC6YW6imO4EclNZ2hoHFV66aX16/HP1LPPsRqphFkvmQlMn
         fwUpjwjqg+QilUCsM/GoKrCTCOWB2gPF5tyxxQ4IE1R90wAZkCJHw38EWDjKwmsxSblt
         rT/6I8y2ZuEh8mq+5Brz5PTh8jJmG8uhy6T3iu+TlAiTdnLHKE3kmWKI+DrAsrogSM9n
         zrqi/oIAwFtB4VPtEDYl40js/59aVuqAVYijaw95vVk9l2b8Z/2ZIbMyDyR7D9Hc1UCm
         iY+zB4ZfvDRvR+1ZCM1iA3X/sxoxPheqrUPw6C6+wbq17WOlIYAQoSPxAKpXaEH7AnrM
         Djtw==
Received: by 10.58.94.44 with SMTP id cz12mr51898veb.34.1349214974115; Tue, 02
 Oct 2012 14:56:14 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 2 Oct 2012 14:56:14 -0700 (PDT)
In-Reply-To: <7vhaqc7in6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206848>

Hi Junio,

> It does create one; it just is the same one you already happen to have,
> when you record the same state on top of the same history as the
> same person at the same time.
>

No, it does not create one: as you can see from the trace of the execution
of my script, the sha of the commit is the same as that of the other,
which means
that in the .git/objects there is only one such commit object, and not two with
the same sha. The meaning of the word "create" is to bring into being something
that did not exist before. There is no "creation" if the object already exists.

>
> And how would it help what to insert a sleep for 1 second (or 1 year
> for that matter)?  As you said, it reads from the system clock, and
> there are millions of systems in the world that have Git installed.
> You may record the same state on top of the same history as the same
> person on two different machines 5 minutes in wallclock time in
> between doing so.  These two machines may end up creating the same
> commit because one of them had a clock skewed by 5 minutes.

I understood that the command does not create a new commit if all its data, i.e.
tree, committer, ... and date are the same, representing the date with 1 second
precision. Sleeping for 1 second guarantees that there is no commit in the repo
that has the same time as the time after the sleep, i.e. that the
command creates
a (new) commit.

>
> What problem are you really trying to solve?  You mentioned
> importing from the foreign SCM,

I quoted a piece of the man page of git commit, that states that
--allow-empty bypasses
the safety check that prevents to make a new commit. That piece
incidentally states
that it is "primarily" used by foreign SCM interface scripts. But of
course it can be used
in any script that needs to build a commit on top of another.

>
> You also did not seem to have read what I wrote, or deliberately
> ignored it (in which case I am wasting even more time writing this,
> so I'll stop).

I did not deliberately ignore what you wrote. I might have missed some
point though.

> This does not have anything to do with "--allow-empty"; removing
> "the option" would not help anything, either.

I am reporting a problem with --allow-empty, so why you say that this
does not have
anything to do with it?
Removing the option removes a behavior that is not predictable.
Often it is better to remove a feature that turns out to be
inconsistent than to leave it
in the software. Of course a much better avenue is to make it consistent.

> Run the following on a fast-enough machine.
>
 I did, and obtained most of the times "I was quick enough" and
sometimes "I was not quick enough", which is the same kind of behavior
of my script.

The problem I am trying to solve is to push to a remote server the
source files only,
while keeping in the local repo both sources and binaries. To do it, I
keep an orphan
branch, say "sources". When I make a commit on the master branch, I make also a
commit on the sources one after having un-staged (git rm --cached) the binaries.
The script that does this must cope also with the particular case in
which in the commit
on the master branch there are no sources. Basically the script does:

# this is the commit on the master branch
git init
echo "aaa" >f1
git add f1
git commit -m A

# this is the piece of the script that builds the sources branch
git checkout --orphan sources
# git rm --cached ...   remove binaries, if any"
git commit -m A --allow-empty
git rev-list --all --pretty=oneline

When there are binaries in the commit A, they are removed, and the
tree for the second
git commit is then different, and the commit is actually created.
When there are no binaries (as in the script above, in which the
removal is commented out),
the second git commit would not create any new commit, and I would not
have an orphan
branch. Thence the --allow-empty to force it to create a new commit.
Unfortunately, it creates a new commit only if the system clock
changes the seconds of
the system time between the two git commits.
If you insert a "sleep 1" before the second git commit, the commit is
really created.

I spent many hours to spot this time-dependent error ....

-Angelo
