From: John Keeping <john@keeping.me.uk>
Subject: Re: Git 1.8.4.2: 'git-rev-parse --is-inside-git-dir' wrong output!
Date: Sat, 2 Nov 2013 20:20:41 +0000
Message-ID: <20131102202041.GF24023@serenity.lan>
References: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com>
 <20131102105816.GC24023@serenity.lan>
 <11593D3DCFCD4D24BB881B9E5FAB79C0@PhilipOakley>
 <20131102140656.GE24023@serenity.lan>
 <CE13C82CA4C24CA8B56380DA00A700A5@PhilipOakley>
 <CACbqpSspsUvw3QXnSmOXA2boenh3y4DjHO-813OTna7cpSXkZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Ville Walveranta <walveranta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 21:20:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vchgk-0007Kf-Hv
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 21:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab3KBUUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 16:20:50 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:57380 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab3KBUUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 16:20:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 61DEE6064EB;
	Sat,  2 Nov 2013 20:20:49 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cPFOwKLs2id6; Sat,  2 Nov 2013 20:20:49 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id D61426064D6;
	Sat,  2 Nov 2013 20:20:48 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id CD007161E4C8;
	Sat,  2 Nov 2013 20:20:48 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E99I7ve2Rbng; Sat,  2 Nov 2013 20:20:48 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 019D0161E484;
	Sat,  2 Nov 2013 20:20:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CACbqpSspsUvw3QXnSmOXA2boenh3y4DjHO-813OTna7cpSXkZQ@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237249>

On Sat, Nov 02, 2013 at 02:42:04PM -0500, Ville Walveranta wrote:
> Without the functionality such as that 1.7.9.5 still offered, it is
> now not possible to use "git-rev-parse --is-inside-work-tree" to
> detect whether the current location is controlled by a git repository
> without emitting the "fatal: Not a git
> repository (or any of the parent directories): .git" error message,
> when it is not. There is no functional "--quiet" switch, and the usual
> error/std redirection to /dev/null doesn't seem to work to squelch the
> output.

How doesn't redirection work?  The message is printed to stderr; the
snippet I posted below does indeed squelch the output.

> If "--is-inside-git-dir" and "--is-inside-work-tree" are indeed not
> supposed to emit "false" when outside of a git repository, perhaps
> there is another way I can use (in a bash script) to cleanly detect
> whether a specific path is part of a git repo or not?

Something like this, maybe?

    (cd "$dir" && git rev-parse --git-dir >/dev/null 2>&1)

> On Sat, Nov 2, 2013 at 12:03 PM, Philip Oakley <philipoakley@iee.org> wrote:
> > From: "John Keeping" <john@keeping.me.uk>
> > Sent: Saturday, November 02, 2013 2:06 PM
> >
> >> On Sat, Nov 02, 2013 at 01:47:02PM -0000, Philip Oakley wrote:
> >>>
> >>> From: "John Keeping" <john@keeping.me.uk>
> >>> Sent: Saturday, November 02, 2013 10:58 AM
> >>> > On Fri, Nov 01, 2013 at 06:19:51PM -0500, Ville Walveranta wrote:
> >>> >> "git-rev-parse --is-inside-git-dir" outputs "fatal: Not a git
> >>> >> repository (or any of the parent directories): .git", instead of
> >>> >> "false" when outside of a git directory.  "--is-inside-work-tree"
> >>> >> behaves the same way. Both commands work correctly (i.e. output
> >>> >> "true") when inside a git directory, or inside a work tree,
> >>> >> respectively.
> >>> >
> >>> > I think that's intentional - and it looks like the behaviour has
> >>> > not
> >>> > changed since these options were added.  With the current behaviour
> >>> > you
> >>> > get three possible outcomes from "git
> >>> > rev-parse --is-inside-work-tree":
> >>> >
> >>> >    if worktree=$(git rev-parse --is-inside-work-tree 2>/dev/null)
> >>> >    then
> >>> >        if test "$worktree" = true
> >>> >        then
> >>> >            echo 'inside work tree'
> >>> >        else
> >>> >            echo 'in repository, but not in work tree'
> >>> >        fi
> >>> >    else
> >>> >        echo 'not in repository'
> >>> >    fi
> >>> > --
