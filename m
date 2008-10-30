From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 12:30:56 -0400
Message-ID: <20081030163056.GA8899@mit.edu>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030143918.GB14744@mit.edu> <20081030144321.GF24098@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 17:32:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvaRa-0002gH-Ih
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbYJ3QbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbYJ3QbA
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:31:00 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:39727 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752996AbYJ3QbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:31:00 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KvaQD-0000DY-Rw; Thu, 30 Oct 2008 12:30:57 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KvaQC-0005LK-TZ; Thu, 30 Oct 2008 12:30:56 -0400
Content-Disposition: inline
In-Reply-To: <20081030144321.GF24098@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99495>

On Thu, Oct 30, 2008 at 03:43:21PM +0100, Pierre Habouzit wrote:
> 
> git format-patch origin/next.. works already. I'm used to the asymetric
> git format-patch origin/next syntax, and I would be sorry if it
> disappeared though, and I see no really good reason to get rid of it.

The reason why it annoys me is because I often what to cherry-pick a
single patch to send to someone, and so while "git show 332d2e78"
shows me the patch, but if I want to use git-send-email for that
particular patch, "git format-patch 332d2e78" doesn't DTRT.  I have to
type "git format-patch 332d2e78^..332d2e78" instead.  I've learned to
live with it, but it's annoying each time I have to do it.

More generally, the fact that the CLI has different ways the same set
of arguments can be decoded can be quite confusing.  The most obvious
way this turns up is to consider which set of commits are
displayed/formatted via these three commands:

   git format-patch 332d2e78
   git show 332d2e78
   git log -p 332d2e78

The first formats all patches that follow commit 332d2e78 (not
including commit 332d2e78), the second shows just commit 332d2e78, and
the last prints all commits starting at 332d2e78 and before it.

For many workflows, the default way a single commit-id is interpreted
makes a lot of sense.  But for a newcomer, it's very confusing.  I'm
not saying that we should collapse everything down to a single way of
doing things, but git format-patch is an exception, and I don't think
anything else actually works that way; looking at the man page makes
it clear that it treats its argument as a revision range EXCEPT when
only a single commit is specified.

It can be justified, and maybe it's convenient enough that this is one
of those places where tutorials should just explicitly call this out
as one of those exceptions that make sense given common workflows.
But just as English can be heard to learn because "though", "through",
"plough", "cough", and "tough" don't rhyme even though they look like
they should (even though native speakers have no problem with it),
similarly this is one of those inconsistencies that makes git hard to
learn.  

(And I get annoyed when I want to run git format-patch on a single
patch not at the tip of the tree; but if it's just me, I can write a
"git format-single-patch" wrapper script to get around it.)

     	      	       		     	    	 - Ted
