From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 16:12:35 +0100
Message-ID: <20130609151235.GA22905@serenity.lan>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 17:13:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlhIt-0007Ub-Fo
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 17:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab3FIPMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 11:12:54 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:54969 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3FIPMx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 11:12:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A1084CDA596;
	Sun,  9 Jun 2013 16:12:52 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50RrxNfToKID; Sun,  9 Jun 2013 16:12:51 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C85CFCDA595;
	Sun,  9 Jun 2013 16:12:41 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226964>

On Sun, Jun 09, 2013 at 08:26:32PM +0530, Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > The plan is simple; make libgit.a a proper library, starting by
> > clarifying what goes into libgit.a, and what doesn't. If there's any
> > hopes of ever having a public library, it's clear what code doesn't
> > belong in libgit.a; code that is meant for builtins, that code belongs
> > in builtins/lib.a, or similar.
> >
> > Give this a try:
> >
> > --- a/sequencer.c
> > +++ b/sequencer.c
> >
> > libgit.a(sequencer.o): In function `copy_notes':
> > /home/felipec/dev/git/sequencer.c:110: undefined reference to
> > `init_copy_notes_for_rewrite'
> > /home/felipec/dev/git/sequencer.c:114: undefined reference to
> > `finish_copy_notes_for_rewrite'
> 
> This is a good example: yes, I'm convinced that the code does need to
> be reorganized.  Please resend your {sequencer.c ->
> builtin/sequencer.c} patch with this example as the rationale, and
> let's work towards improving libgit.a.

Why should sequencer.c move into builtin/ to solve this?  Why not pull
init_copy_notes_for_rewrite and finish_copy_notes_for_rewrite up into
notes.c?
