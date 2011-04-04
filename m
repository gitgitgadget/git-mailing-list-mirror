From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Mon, 4 Apr 2011 22:27:02 +0530
Message-ID: <20110404165659.GA28587@kytes>
References: <20110403172054.GA10220@kytes>
 <201104040643.35583.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6n6X-0006ek-G1
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 18:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab1DDQ6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 12:58:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51120 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab1DDQ6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 12:58:10 -0400
Received: by iwn34 with SMTP id 34so5935111iwn.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lccdfYo1xoGNX56GpyTThk8GGFmJ2cP2umh/GDEESUE=;
        b=x26LAWrvrNMysm0Qq7mvRCARU2ahqdwhrHo5DgjkpgsjmCqMq/Yn+bvgUk9rFZOQOa
         qNgNVnNW3uh8MO1rbXupH/DpgRRgOyMST/tKnsImbj3RydMk8Wa+TH3H/EqjRSh5h3uK
         XHnSbvtKOzuovhwjswwJ799cpCN6c3UP2mGVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SLSPy25Y5aFkrpVyG7X79hOWj0DXY2F0/peQmhwDmHkg8i9KLQ0kX8UXT6tOcFy041
         SOyIRt7dGS6+yirrFeulCyA+nVHsju2nGnIK56EYHk5gsnY6tgYJ3JLLRgn23acxCSu+
         nKtFaF0pRKasNpK3H8/h/WTnUkaPETKTeeQUo=
Received: by 10.42.240.134 with SMTP id la6mr1710928icb.347.1301936289471;
        Mon, 04 Apr 2011 09:58:09 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id uk4sm3594883icb.21.2011.04.04.09.58.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 09:58:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104040643.35583.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170826>

Hi Christian,

Christian Couder writes:
> On Sunday 03 April 2011 19:20:56 Ramkumar Ramachandra wrote:
> > I'd like to re-apply this year as a student because I really want to
> > see (among other things), a sequencer in git.git.  Also, since I
> > worked on areas related to fast-import and remote helpers last year, I
> > thought I should work on something completely orthogonal this year.
> > 
> > I now have a draft of my proposal ready, and I'd really appreciate
> > feedback.  Also, could someone mentor me?
> Yeah! I would be happy to mentor you (or co-mentor you if someone else want to 
> be involved)!

Awesome! Thanks :)

> > == The Objective ==
> > 
> > To write git-sequencer, a new builtin command, and implement existing
> > commands on top of that.  This should give the commands more
> > functionality, improve their error handling, and make them faster.
> 
> You should first talk about extending git cherry-pick with --continue, --abort 
> and --skip, because it can be very valuable already if done properly with many 
> tests and if it's merged of course.
> 
> > The project can only be considered successful if all (or most) of the
> > code written gets merged into upstream.
> 
> Yeah, just say "most of the code". It is definitely good enough.

Okay, here's the new objective:

Extend 'git cherry-pick' with '--continue', '--abort', and '--skip'
features.  This will ultimately be used to write git-sequencer, a new
builtin command.  The sequencer will provide a uniform interface over
which existing commands like 'rebase', 'rebase -i' and 'am' can be
re-implented.  This should give the commands more functionality,
improve their error handling, and make them faster.  The project can
only be considered successful if most of the code written gets merged
into upstream.

> > 1.1. Factor out all calls to 'die' with 'return error' so so that we
> > can pause the entire process when a commit doesn't apply
> > automatically.
> > 
> > 1.2. Create and populate TODO and DONE files, similar to the one that
> > 'git-rebase--interactive.sh' creates.  For now, it should simply give
> > us information about why a 'cherry-pick' failed.  Use these files with
> > 'git-rebase--interactive.sh' to resume.
> 
> I am not sure it's a good thing to use 'git-rebase--interactive.sh' to resume 
> the cherry-pick. The parsing code already exists, is not very big, is in C and 
> has been reviewed and tested, so I think it's better to use.

Okay, noted.

> > 1.3. Port selective tests from the current 't3404' to make sure that
> > TODO and DONE are populated correctly; "stop on conflicting pick" is a
> > good candidate.
> > 
> > 1.4. Decouple the 'revert' functionality from the 'cherry-pick'
> > functionality in 'revert.c'.  Implement '--abort' for 'cherry-pick'
> > and port "abort" test from 't3404'.
> 
> I am not sure decoupling revert and cherry-pick functionnalities is really 
> needed, or I don't know what you mean exactly.

What I was thinking when I wrote that: we should have a 'revert.c'
independent of 'cherry-pick.c' after the sequencer is implemented (see
2).  By "decouple" I meant: move code around so we don't have to use
the enum { REVERT, CHERRY_PICK }.

> > 1.5. Implement parsing the TODO and DONE files into suitable data
> > structures.  Derive inspiration from the code written in 2008 to do
> > this.
> 
> Yeah, you can use this patch:
> 
> http://article.gmane.org/gmane.comp.version-control.git/162198

Yeah, this is exactly the patch I was referring to.  I just forgot to
include the link :p

> > 1.6. Implement '--continue' and '--skip', and write suitable tests.
> > Merge into upstream.
> 
> Great!
> 
> > 2. Factor out the 'cherry-pick' code from 'revert.c' into a new
> > 'builtin/sequencer.c', and expose a simple cherry-picking API in
> > 'sequencer.h'.
> 
> Yeah!
> 
> > 3. Implement a fresh 'cherry-pick.c' as a simple API call to the
> > sequencer, and make sure that all the existing tests pass.  After
> > this, cherry-pick will not be a builtin command anymore*.  Merge into
> > upstream.
> 
> Yeah, it is closely linked with the previous point. So maybe this can be 2.2 
> and the previous one can be 2.1. And this way we know that at the end of 1) 
> and at the end of 2) everything should be merged upstream.

Okay.

> > 4. Extend the sequncer to parse commands like 'execute', 'reword',
> > 'squash', and 'fixup' that are specific to interactive rebasing.
> > Carefully implement the functionality for each of these keywords in a
> > step-wise manner, making sure that it inter-operates with 'rebase -i'
> > seamlessly.
> 
> Great!
> 
> > 5. Port the entire testsuite from 'rebase -i', and rewrite
> > 'git-rebase.sh', 'git-rebase--interactive.sh' to call the sequncer.
> > The script should essentially build to a list of TODO instructions and
> > pass it to the 'git-sequencer' binary.  Merge into upstream.
> 
> Great! But as it is closely llinked with the previous point, maybe these 2 
> points should be 3.1 and 3.2.

Okay.

> > 6. [Optional] Lib'ify the sequncer: modify the sequencer API to
> > include rebase-related functionality.  Write 'rebase.c' as a bunch of
> > API calls to the sequencer.  Make sure that the existing tests pass.
> > Merge into upstream.
> > 
> > 7. [Optional] Re-implement 'git-am.sh' as a thin wrapper over the
> > sequncer: 'am.c'.  Bulk of this should be mbox parsing code.  Make sure
> > that all existing tests pass.  Merge into upstream.

I'll append Daniel's single-step-interrupt idea here, once I
understand how to implement it fully.

> > == Timeline ===
> > 
> > Deriving from last year's experience, I've decided not to present a
> > tight timeline.  Instead, I simply have an outline: Get the extended
> > cherry-pick functionality merged before mid-term evaluations, and the
> > rest before the final evaluations.
> 
> I agree, but still you could perhaps state something like this:
> 
> - before mid june:
> 	some patch series for everything in 1) should have been sent to the list
> - before midterm evaluation:
> 	everything in 1) should be merged upstream
> 	some patch series for everything in 2) and 3) (or 2.1 and 2.2 if you use 
> the numbering I suggest) should have been sent to the list
> - before the end of July:
> 	everything in 2) and 3) should be merged upstream
> 	some patch series for everything in 4) and 5) (or 3.1 and 3.2 if you use 
> the numbering I suggest) should have been sent to the list
> - before final evaluation:
> 	everything should be merged
> 
> I think it is better to have more details like the above because this way we 
> can realize early that there is not a lot of time after the midterm 
> evaluation.

Great suggestion! I'll include this in the next iteration of my
proposal.

Thanks for the detailed review and the suggestions.

-- Ram
