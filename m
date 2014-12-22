From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] completion: add --irreversible-delete for format-patch
Date: Mon, 22 Dec 2014 19:00:59 +0000
Message-ID: <20141222190059.GA19490@dcvr.yhbt.net>
References: <20141221115007.GA23500@dcvr.yhbt.net>
 <xmqq3887a5qd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 20:01:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y38E5-0004Vb-SS
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 20:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbaLVTBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 14:01:00 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56412 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbaLVTA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 14:00:59 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5261F8A1;
	Mon, 22 Dec 2014 19:00:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq3887a5qd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261667>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Normally I would use "-D", but send-email (which normally passes options
> > to format-patch) interprets the "-D" as a case-insensitive abbreviation
> > for "--dry-run", preventing format-patch from seeing "-D".
> 
> Is this nonstandard option that is designed to produce an
> inapplicable patch so widely used to warrant a completion?
> 
> I'd actually understand it if this were to complete "git show" and
> friends, but not for format-patch.  I'd actually think we might be
> better off forbidding its use for the format-patch command (but not
> for other commands in the "git log" family), not just at the
> completion level but at the command line argument parser level.
> 
> Hmph...

I was actually hoping Paul would resurrect his work on getting apply
to understand --irreversible-delete:

http://mid.gmane.org/1343939748-12256-1-git-send-email-paul.gortmaker@windriver.com
($gmane/202789)

I find this option useful to reduce mail traffic for others to review
changes which are already pushed to a public repo.

> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> >  Case-insensitivity strikes again! :<
> >  What a wacky default for Getopt::Long...  And it's probably too late
> >  for us to disable case-insensitivity in CLI parsing for send-email.
> >
> >  contrib/completion/git-completion.bash | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 2fece98..41d8ff8 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1257,6 +1257,7 @@ __git_format_patch_options="
> >  	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
> >  	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
> >  	--output-directory --reroll-count --to= --quiet --notes
> > +	--irreversible-delete
> >  "
> >  
> >  _git_format_patch ()
