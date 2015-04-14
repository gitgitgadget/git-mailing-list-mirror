From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: Requesting `git stash --cached` or something similar
Date: Mon, 13 Apr 2015 22:05:02 -0400
Message-ID: <CANUGeEbRyG4A2UdTYOBgtjDtqi_A1WnbkOBjH_h2AcEZT741jQ@mail.gmail.com>
References: <37E34942-ACEB-48BC-ABFF-C7248DA6607E@mac.com> <20150414014435.GC8601@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Quinn Taylor <quinntaylor@mac.com>, git@vger.kernel.org
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 04:05:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhqEC-0001bK-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 04:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbbDNCFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 22:05:24 -0400
Received: from mail-vn0-f53.google.com ([209.85.216.53]:39021 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbbDNCFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 22:05:24 -0400
Received: by vnbg62 with SMTP id g62so26197565vnb.6
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 19:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r/5HRwCQl4dh4ziOr9aWjzPOdvCYq3ygpB5eR5zkghk=;
        b=Azp29dI48O3qdNmhbmXcVB+QpCiGZt/t6famuu80EjsiqBmY7esFiDoqDN0GrLwfMh
         l55a1B2fIvOd1r1fbIXSKQyj5p7OWLSshBgDB90NjCBJQwzbx68ODvAgtoGmd1U21j3f
         whQJe4L+JTrbmoXKD22On66VqLOdrPwW+ON1AZ3IfQ0Cqc23372QxnTLwA9NYGH3BYrU
         49HZKrJGKep8Q8RCq86gnvO0nNQrK+xLaX3PmBaBRh2VG6hsfdySwMa7SU/ro/E+oa6d
         SRHK8yo55hmBjGxOt+cMTsOrW5LxgNHt7EvfrJQmfREJUyM6Gfytz5EzeIpdDCVBbqlf
         VfPg==
X-Received: by 10.202.175.213 with SMTP id y204mr9640711oie.22.1428977123291;
 Mon, 13 Apr 2015 19:05:23 -0700 (PDT)
Received: by 10.202.220.4 with HTTP; Mon, 13 Apr 2015 19:05:02 -0700 (PDT)
In-Reply-To: <20150414014435.GC8601@tsaunders-iceball.corp.tor1.mozilla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267109>

Trevor:

On Mon, Apr 13, 2015 at 9:44 PM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
> I would expect the answers to be it sets the working directories state
> to the state in HEAD, and leaves untracked files alone.  If that's what
> you want you can do git commit -m <message>; git reset --hard; git reset
> --soft; git stash save to get the effect you want I believe. That said
> it seems like a kind of odd thing to want to do, what are you actually
> trying to do?

That looks like a bad solution. git reset --hard is going to throw
away any remaining changes to the working tree. The previous commit
would have committed the staged changes, albeit, you should connect
the commands with && instead of ; to account for errors. After a `git
reset --hard' there's no point in doing a `git reset --soft' because
hard does *everything*. --soft would try to reset the HEAD without
touching the index or working tree, but both have already been reset
with --hard.

The motivation is most likely stashing a few changes away so that you
can commit others that are ready to be committed while keeping others
around to continue working on them. This too is a good observation. It
could mean that the OP is inexperienced with a commit-often workflow.
You can use git -add -i or -p to commit the good stuff and keep the
bad stuff out to work on it more. The great thing about Git is that
the history is very malleable. You can also commit the bad and fix it
after, rebase the history to clean it up, and end up with perfect
history while still keeping your changes safely in history.

The OP should experiment with workflows because Git is already very
good at this. Stash isn't really needed. That said, I had forgotten
that --patch was added to stash some time ago so if that is what you
want then it already exists. It's not quite as easy as --cached, but
it still gives you some control. It's still not nearly as good as
using the full power of Git with a regular commit on a branch though.

Regards,

-- 
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bambams.ca/>
perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
