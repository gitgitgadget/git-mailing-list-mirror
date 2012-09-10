From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 12:54:57 -0400
Message-ID: <20120910165457.GB14201@sigill.intra.peff.net>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
 <1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com>
 <vpqk3w1j15v.fsf@bauges.imag.fr>
 <CADgNja=z7EDTV8_2CU9Uc7w=Dmtp90GrPkDUFSPbucfyrEsBaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:55:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB7GS-0003ip-BY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab2IJQzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:55:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39777 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab2IJQzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:55:00 -0400
Received: (qmail 29827 invoked by uid 107); 10 Sep 2012 16:55:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 12:55:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 12:54:57 -0400
Content-Disposition: inline
In-Reply-To: <CADgNja=z7EDTV8_2CU9Uc7w=Dmtp90GrPkDUFSPbucfyrEsBaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205147>

On Mon, Sep 10, 2012 at 12:46:45PM -0400, Andrew Wong wrote:

> > Just "edit" may be a bit misleading, as we already have the "edit"
> > action inside the todolist. I'd call this --edit-list to avoid
> > ambiguity.
> 
> I thought that might be a bit confusing too. "--edit-list" doesn't
> seem informative about what "list" we're editing though. What about
> "--edit-todo"? Any suggestions are welcomed.

Does it ever make sense to edit and then _not_ immediately continue?
You can't affect the current commit anyway (it has already been pulled
from the todo list), so the next thing you'd want to do it actually act
on whatever you put into the todo list[1].

What if it was called --continue-with-edit or something, and then:

> > This lacks tests, IMHO, as there are many corner-cases (e.g. should we
> > be allowed to --edit-list while the worktree is in conflict?) that would
> > deserve to be at least discussed, and as much as possible automatically
> > tested.

We would not even allow the edit if we were not OK to continue.

-Peff

[1] It does preclude using "--edit" to make a note about a later commit
    while you are in the middle of resolving a conflict or something.
    You'd have to do it at the end. I don't know if anybody actually
    cares about that.
