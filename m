From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 08 Jun 2008 11:52:11 -0700
Message-ID: <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain>
 <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 20:53:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Q1b-0001DT-CR
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 20:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbYFHSw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 14:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYFHSw0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 14:52:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbYFHSwV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 14:52:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A844397B;
	Sun,  8 Jun 2008 14:52:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 291503979; Sun,  8 Jun 2008 14:52:14 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com> (Boyd Lynn
 Gerber's message of "Sun, 8 Jun 2008 10:04:21 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0603BF00-358C-11DD-8658-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84308>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> On Sun, 8 Jun 2008, Jakub Narebski wrote:
>> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>> 
>> > This patch adds support to compile git on 12 additional platforms.
>> > They are based on UNIX Systems Labs (USL)/Novell and SYS V
>> > based OS's, SCO OpenServer 5.0.X, SCO UnixWare 7.1.4, OpenServer 6.0.X and
>> > SCO pre OSR 5 OS's to build and run git.
>> > 
>> > Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com> 
>> > ---
>> [...]
>> > git-compat-util.h
>> > 
>> > __USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
>> > compiler and/or some SysV based OS's.
>> > 
>> > __M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
>> > of the SCO OS's.  It is used just like Apple and BSD, both of these
>> > shouldn't have _XOPEN_SOURCE defined.
>> 
>> Above info is neither in commit message, not in comment in some file.
>> It would be nice to have it in somewhere, and not only in mailing list
>> archives.
>
> This was from my own copy of the master archive.  It is my proposal.  I 
> thought you had to get an OK from this list before you do a push to the 
> main archive.  Am I missing something?  I am new to this list and the 
> proper methods for submitting patches.  I thought I was following the 
> guidelines from 
>
> http://repo.or.cz/w/git.git?a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD
>
> What am I missing?

It might appear that many people somehow hate your patch and ganging up on
it, and if so I apologize for them and I assure you that they do not mean
ill.

There seem to be some confusion either in the SubmittingPatches document
or the way some suggestions have been given in the recent postings by
people, so let's clear it up first.

There are four different kinds of information you would want to convey
when you send patches to the list.  This is just a convention around here,
but the tool is built to support that convention, so you can consider it
the suggested BCP in any git managed projects that employ e-mail based
workflow.

 * What the patch is about, a short and sweet summary.  This should be
   something that can be used to identify the change and it should be easy
   to tell what it is about when viewed in "git log --pretty=oneline" or
   in "git shortlog" output.  This goes to Subject: line.

 * Justification for the patch.  When anybody views with "git show" the
   change after it gets committed, "how" the patch changes can be seen,
   but what cannot be easily seen is "why", and the commit message is the
   place to describe it.  This takes various forms, depending on the
   nature of the patch:

   * For a fix, describe how the status-quo is broken, what the desired
     behaviour should be, and discuss and defend why you chose this
     specific approach to fix among other possible avenues.  E.g. "If you
     use this and that option together, the command does this, which is
     not correct.  It should do that instead.  For that, we introduce
     helper function X and Y use them in each codepaths.  We could instead
     use a single helper that does X or Y depending on an option but these
     two codepaths are likely to evolve into doing even more different
     things, and using separate functions would be cleaner."

   * For an enhancement, describe in what situation the new feature is
     useful, defend why that use case is worth supporting, state how
     awkward (or perhaps impossible) to do the same thing is with the
     current set of features, and discuss and defend why you chose this
     specific approach to fix the awkwardness among other possibilities.
     E.g. "This adds a new feature X that works like this.  When you have
     Y and want to arrive at Z, with the current set of commands you would
     need to do W, but...".

   The point is to help people, who later wonder why the change was made
   and on what basis the author thought the change was necessary and/or
   sufficient back then when the change was made, understand the context.

   This comes at the beginning of the e-mail message, and is concluded by
   S-o-b line(s).

 * Supporting material that makes it easy to understand the particular
   iteration of the patch in the context of review discussion, things like
   "Compared to the previous round, I changed this and that, thanks to
   comments from X and Y."  Because only the final iteration will get
   committed in the final history, it does not make sense to include such
   information in the commit message.  This comes after the commit log
   message, and a single three-dash line is used to separate this part
   from the commit log message.

 * The change itself, aka "patch".  This comes at the end of the message.

Let's look at the pieces you have after --- (the first one is the only one
that counts).

    Makefile

    Add changes for System V, UnixWare, SCO OS's

This is something poeple can find out and guess by looking at the patch
itself, and is unnecessary, not even as supporting material.

    __USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
    compiler and/or some SysV based OS's.

    __M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
    of the SCO OS's.  It is used just like Apple and BSD, both of these
    shouldn't have _XOPEN_SOURCE defined.

These are valuable clues to anybody who is unfamiliar with (and/or do not
have an easy access to) these systems.  When people later want to touch
git-compat-util.h around the place where !defined(__USLC__) is used, they
would run "git blame" (or perhaps "git log -S__USLC__") to find your
commit that modified this line, and by looking at the commit log message
why you added these symbols on the #if line.  It would help protect your
changes from begin broken by them if you help them understand why these
are there, and the above two paragraphs should definitely go to the commit
log message.  They are not mere supporting material for this review cycle
alone.

"..., both of these shouldn't have" however could even be more helpful if
it was stated like "On these platforms, defining _XOPEN_SOURCE hides
definitions of X, Y and Z that we use, which is not what we want.", for
people who would want to know what specific breakage the change addresses.

It would change "Ok, somebody with SCO systems says this patch fixes
things for him" to "I see, if _XOPEN_SOURCE over there makes *that*
function unavailable, then we definitely shouldn't have _XOPEN_SOURCE
defined at this point of the header file".  IOW, it makes "Ok, I trust the
guy's judgement, even though the details are fuzzy to me" into "Ok, I
agree with his judgement".
