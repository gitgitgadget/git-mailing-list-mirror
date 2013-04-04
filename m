From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 4 Apr 2013 12:41:06 -0600
Message-ID: <CAMP44s3zm+-220Xpqv_=JkJ=g2pS79hUNjacVZ=JejitcG=B8A@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
	<871uaqrwrp.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jed Brown <jed@59a2.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNp6Q-0000ns-LU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762168Ab3DDSlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:41:09 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48573 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761933Ab3DDSlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:41:08 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so3048753lbh.27
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4OBmV1Pux5EkMcDLX4TzcucbjU7aLDkayHk32ogWnuQ=;
        b=zdN36zA0uYoS1iSM6imArA3U0Bzg0v4gjnReIpIWrcV2drXOe5ejBJluwSfSCX75+z
         hjIKrUhRRD1hKX31S6+A51H44VVLfEfrUa9eesSN02D0GIgNIelwJzi042gp0FmRCB4a
         cRwK8FNvwjpH8xUoxHlCoUkJJlr2GmJcdZ8oZFD8ojW0Sst3IU0qdR9xY8Z0a5tzmKxE
         /6cjSnV805ptHCOVsuLVZfwCqehQKezf8foLohyJPlCzQQiok1O21cIx9cFlydiiRen7
         Jy74xhgXRKA4Ces+Fw1Es1cKRdzbQM/LPCk/unZOoq/nRamSW5B3zJaIscGLbVAZQPeL
         3K1Q==
X-Received: by 10.112.145.8 with SMTP id sq8mr4207489lbb.55.1365100866348;
 Thu, 04 Apr 2013 11:41:06 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 11:41:06 -0700 (PDT)
In-Reply-To: <871uaqrwrp.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220058>

On Thu, Apr 4, 2013 at 12:11 PM, Jed Brown <jed@59a2.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I still don't see any good reason why a user might prefer gitifyhg,
>> even more importantly, why gitifyhg developers don't contribute to
>> remote-hg.
>
> Felipe, I read your blog announcement [1] and got the impression that
> remote-hg was ready for daily use.  When I tried to use it, it promptly
> crashed in my first attempt to clone.  I opened up the script, fixed
> whatever caused the first stack trace and made it slighly further before
> it crashed again.  I couldn't tell what was expected to work, what was a
> known problem, and what was an unknown problem.  Many things clearly did
> not work and it had the look of a project that was not getting active
> use.  I felt that it was wildly oversold and that putting it into
> git.git was premature.

Where is the evidence? You say remote-hg doesn't work, I say it does,
the difference is that I have evidence to prove it.

There's no bug report, no mail, no log of any kind, no repository to
check, no nothing. What are developers supposed to do with this
comment? Nothing, it's not constructive.

> I tried gitifyhg later and it basically worked out of the box.  All
> known problems were marked by 'xfail' test cases.  At that time,
> remote-hg failed almost all the gitifyhg tests.

Because gitifyhg tests are testing gitifyhg, not proper behavior. For example:

def test_push_conflict_default(git_dir, hg_repo):
    git_repo = clone_repo(git_dir, hg_repo)
    sh.cd(hg_repo)
    make_hg_commit("b")
    sh.cd(git_repo)
    make_git_commit("c")
    assert sh.git.push(_ok_code=1).stderr.find("master -> master
(non-fast-forward)") > 0

remote-hg doesn't fail with the non-fast-forward error, in fact, it
doesn't fail at all, it pushes correctly, and that's reported as a
failure.

> I contributed a few
> things to gitifyhg, including the notes support (essential when talking
> via email with other people using Mercurial).  Since then, the last
> major project I'm involved with has switched to Git so I rarely need
> gitifyhg or remote-hg any more.

So what is the purpose of this anecdote? Are you going to provide
something of value, or is this just an attempt to root for the project
you have contributed to?

> FWIW, I also thought Dusty's original announcement oversold gitifyhg, but
> it was closer to the truth and upon cloning the repo, it was more clear
> what didn't work.

This is *one* data-point, you can't make such overreaching
generalizations from *one* data-point; you will often be wrong.

> The early history of gitifyhg is quite chaotic and I
> didn't realize at first how much code turned out to be borrowed from
> remote-hg.  I don't know whether you wrote all of remote-hg or borrowed
> significant parts from elsewhere.  To be honest, I don't really care,
> but it would be good to coalesce around one project that is well-tested
> and has documented behavior so that the poor folks stuck with Mercurial
> upstreams can have dependable behavior.

Indeed, and mails like this don't help one iota to achieve that. We
need data, arguments, and code, and you are not providing any.

Now, if you can go fetch the log of the error you had, that would be
great, otherwise I'll turn to something productive, like improving
remote-hg.

Cheers.

-- 
Felipe Contreras
