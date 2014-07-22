From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/4] completion: add missing terminator in case statement
Date: Tue, 22 Jul 2014 19:22:07 +0100
Message-ID: <20140722182207.GC26927@serenity.lan>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
 <xmqqmwc2k4h4.fsf@gitster.dls.corp.google.com>
 <xmqqk376iidy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 21:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9fkN-0006Vx-8n
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 21:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500AbaGVT3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 15:29:06 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:57965 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238AbaGVT3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 15:29:05 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jul 2014 15:29:05 EDT
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 6A5FA198155;
	Tue, 22 Jul 2014 20:22:25 +0100 (BST)
X-Quarantine-ID: <6mEUUw+Z8+dX>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: 1.314
X-Spam-Level: *
X-Spam-Status: No, score=1.314 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_RHS_DOB=1.514] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6mEUUw+Z8+dX; Tue, 22 Jul 2014 20:22:20 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id EEC83198912;
	Tue, 22 Jul 2014 19:22:09 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqk376iidy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254032>

On Mon, Jul 21, 2014 at 01:09:13PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > John Keeping <john@keeping.me.uk> writes:
> >
> >> Signed-off-by: John Keeping <john@keeping.me.uk>
> >> ---
> >
> > As these ;; are separators not terminators, this is not strictly
> > necessary.  Squashing it into a change that adds more case arms to
> > this case statement is of course not just good but necessary,
> > though.
> 
> s/necessary/may be &/; if you add new arms before this one, you
> won't need it.  But if you add one after this, you would ;-).

Hmm... POSIX describes them as terminators :-)

	The compound-list for each list of patterns, with the possible
	exception of the last, shall be terminated with ";;".

Although, bash.info is inaccurate here (clearly Bash does implement the
POSIX behaviour otherwise the existing code wouldn't work):

	Each clause must be terminated with `;;', `;&', or `;;&'.  The
	WORD undergoes tilde expansion, parameter expansion, command
	substitution, arithmetic expansion, and quote removal before
	matching is attempted.  Each PATTERN undergoes tilde expansion,
	parameter expansion, command substitution, and arithmetic
	expansion.

	There may be an arbitrary number of `case' clauses, each terminated
	by a `;;', `;&', or `;;&'.  The first pattern that matches
	determines the command-list that is executed.


I'll drop this patch in the re-roll since it isn't necessary.

> >>  contrib/completion/git-completion.bash | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> >> index 7a6e1d7..d0b2895 100644
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -1627,6 +1627,7 @@ _git_push ()
> >>  	--repo)
> >>  		__gitcomp_nl "$(__git_remotes)"
> >>  		return
> >> +		;;
> >>  	esac
> >>  	case "$cur" in
> >>  	--repo=*)
