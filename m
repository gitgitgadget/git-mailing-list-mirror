From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 17:02:25 +0100
Message-ID: <20130609160225.GB22905@serenity.lan>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
 <20130609151235.GA22905@serenity.lan>
 <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 18:02:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uli4r-0005aJ-Rk
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab3FIQCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:02:42 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:35716 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab3FIQCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:02:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7E1CFCDA5EE;
	Sun,  9 Jun 2013 17:02:40 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdcwGHg3ua5J; Sun,  9 Jun 2013 17:02:40 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 6B818CDA605;
	Sun,  9 Jun 2013 17:02:38 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4E480161E450;
	Sun,  9 Jun 2013 17:02:38 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AKX+sibVHCV; Sun,  9 Jun 2013 17:02:37 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 76411161E470;
	Sun,  9 Jun 2013 17:02:27 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226968>

On Sun, Jun 09, 2013 at 10:40:32AM -0500, Felipe Contreras wrote:
> On Sun, Jun 9, 2013 at 10:12 AM, John Keeping <john@keeping.me.uk> wrote:
> > On Sun, Jun 09, 2013 at 08:26:32PM +0530, Ramkumar Ramachandra wrote:
> >> Felipe Contreras wrote:
> >> > The plan is simple; make libgit.a a proper library, starting by
> >> > clarifying what goes into libgit.a, and what doesn't. If there's any
> >> > hopes of ever having a public library, it's clear what code doesn't
> >> > belong in libgit.a; code that is meant for builtins, that code belongs
> >> > in builtins/lib.a, or similar.
> >> >
> >> > Give this a try:
> >> >
> >> > --- a/sequencer.c
> >> > +++ b/sequencer.c
> >> >
> >> > libgit.a(sequencer.o): In function `copy_notes':
> >> > /home/felipec/dev/git/sequencer.c:110: undefined reference to
> >> > `init_copy_notes_for_rewrite'
> >> > /home/felipec/dev/git/sequencer.c:114: undefined reference to
> >> > `finish_copy_notes_for_rewrite'
> >>
> >> This is a good example: yes, I'm convinced that the code does need to
> >> be reorganized.  Please resend your {sequencer.c ->
> >> builtin/sequencer.c} patch with this example as the rationale, and
> >> let's work towards improving libgit.a.
> >
> > Why should sequencer.c move into builtin/ to solve this?  Why not pull
> > init_copy_notes_for_rewrite and finish_copy_notes_for_rewrite up into
> > notes.c?
> 
> Because finish_copy_notes_for_rewrite is only useful for builtin
> commands, so it belongs in builtin/. If there's any meaning to the
> ./*.o vs. builtin/*.o divide, it's for that. Otherwise we should just
> squash all objects into libgit.a and be done with it.

How is it only useful for builtin commands?  By that logic everything
belongs in builtin/ because it's all only used by builtin commands (I
realise that is what you're arguing towards).

But we make a distinction between things that are specific to one
command (especially argument parsing and user interaction) and more
generally useful features.  Copying notes around in the notes tree is
generally useful so why shouldn't it be in notes.c with the other note
manipulation functions?  The current API may not be completely suitable
but that doesn't mean that it cannot be extracted into notes.c.  In
fact, other than the commit message saying "Notes added by 'git notes
copy'" I don't see what's wrong with the current functions being
extracted as-is.
