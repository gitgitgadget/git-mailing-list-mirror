From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 09:02:31 -0700
Message-ID: <CA+55aFxyyqkS4XyE1as2TdeARce9g9BTK=jdY+XcomNtMdrArg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
	<CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
	<CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
	<CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
	<CALkWK0mQt7cE0zUECDF4ZC2-9Q+pEL=XGPdaOksyWzae2_W1CA@mail.gmail.com>
	<CA+55aFw+2wgUufJn7BcXACBQqywAGBAcZWS6N_UV8UA91G447Q@mail.gmail.com>
	<CALkWK0n0uKTsPv2d20ESVd5OV5yfK5V1HecGWePYU=UFw5Jkfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:09:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWJn-0002u6-Fm
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161936Ab3DEQCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 12:02:33 -0400
Received: from mail-vb0-f44.google.com ([209.85.212.44]:63685 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161724Ab3DEQCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 12:02:32 -0400
Received: by mail-vb0-f44.google.com with SMTP id e12so2255451vbg.17
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Uo4JqDOOClfC+FN1LyaQ6MKJ2di9xep+ARMYzx67KD4=;
        b=CcqJhrp+F+hD4UOFhMAYq+D2R6yhna6V71RygLy0cMfJPap8kkEmUaqKaz/j2Y7waM
         61OYwVemSQVAQHUslNigm0rm0pQcrObs/Z+6klo4tdOU4lYzJoBC5Dg1ZdbZ+JcTJm/D
         0j4U5GEH+p1dU84/UYHd0x6SmdH6czATkleItWwMFAeHgpkV0RBJrWu+eEDFG9aqdLnl
         p/pPLWLr3w+C+ui2hTGVV8elcJ5EeJ2xYQ7yOM1Fy+UowIdMNZALpfx2BEqWfrsNQCcG
         HWWjmrdKsBCZmjFGJSAyELwBHC+eSBZvtCgCsagH3c+PbtVDEdbskL573BZyeyiGyxAq
         OaiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Uo4JqDOOClfC+FN1LyaQ6MKJ2di9xep+ARMYzx67KD4=;
        b=Wm3iR5tQWpXu44CmUU/BQ7uaDsuJdKFVd8w9OPMGUGLXPqAkP7WB6kwQutHeZU13He
         bU+2mzdcOZC7AZ0fpa9oA45ScXL528AsnS+w+LsC3sqSTMOmsjo7IxdF7AGKj0Wra6lc
         hOttxyUNx+XWeo1gA5Hdwytqr41JUF6ErkcIQ=
X-Received: by 10.220.113.137 with SMTP id a9mr8625809vcq.11.1365177751626;
 Fri, 05 Apr 2013 09:02:31 -0700 (PDT)
Received: by 10.220.236.130 with HTTP; Fri, 5 Apr 2013 09:02:31 -0700 (PDT)
In-Reply-To: <CALkWK0n0uKTsPv2d20ESVd5OV5yfK5V1HecGWePYU=UFw5Jkfg@mail.gmail.com>
X-Google-Sender-Auth: QTK6aaTOWl3z7uK8f9T6HKWT3YU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220190>

On Thu, Apr 4, 2013 at 1:04 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Linus Torvalds wrote:
>> Or you could also just edit and carry a dirty .gitmodules around for
>> your personal use-case.
>
> I'm sorry, but a dirty worktree is unnecessarily painful to work with.

Bzzt. Wrong.

A dirty worktree is not only easy to work with (I do it all the time,
having random test-patches in my tree that I never even intend to
commit), it's a *requirement*.

One thing that git does really really well is merging. And one of the
reasons why git does merging well (apart from the obvious meta-issue:
it's what I care about) is that it not only has the stable information
in the object database, it also has the staging information in the
index, *and* it has dirty data in the working tree.

You absolutely need all three. Having an "edit" command to edit stable
data (or staging data) is broken. Trust me, I've been there, done
that, got the T-shirt and know it is wrong. The whole "stable objects"
+ "index" + "dirty worktree" is FUNDAMENTALLY the right way to work,
and it *has* to work that way for merges to work well.

The only things that we don't have "dirty data" for in the worktree is
creating commits and tags, but those aren't relevant for the merging
process anyway, in the sense that you never change them for merging,
you create them *after* merging (and this is fundamental, and not just
a git implementation issue).

So you absolutely need a dirty worktree. You need it for testing, and
you need it for merging. Having a model where you don't have a
in-progress entity that works as a temporary is absolutely and
entirely wrong.

               Linus
