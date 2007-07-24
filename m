From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: workflow question
Date: Tue, 24 Jul 2007 17:37:43 +0200
Message-ID: <81b0412b0707240837l16844dbct52ffa426d8b8547b@mail.gmail.com>
References: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Patrick Doyle" <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 17:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDMSL-0004CY-NF
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 17:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbXGXPhq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbXGXPhq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 11:37:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:9727 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbXGXPhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 11:37:45 -0400
Received: by ug-out-1314.google.com with SMTP id j3so174113ugf
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 08:37:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rq7YfK9Hhjab98m09tN0N0BSqyQdDuNkJMKIUzmGFynApqgSvt4EwetCEvbbNp1/we+/XwK/A42Wa8De2gwYCu9TvPkZpJ5poNGxanU6MYzV893yhPQFSZGmR5Yo1G/jPG/d40mi8iVr9o3gR+EWFDhKCovY4sN3GKSXMDOK6J8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rBd8R1gkRg9wUs5eMzs9TTUKuqjEo614RV5VZ4mlTYfBxA6BYi+ja3XZ9dR2jv9WQuh/4Iz928WtGjhXzTP7Fh6bijhyThjiY9e5HE6tmcGWFvD8dVUQhhxNb1r24FUgZjMjlB/1aVPxDlGw+rzkxon7QRoXhJNy3KKOsTHl1IM=
Received: by 10.78.193.5 with SMTP id q5mr1111384huf.1185291463953;
        Tue, 24 Jul 2007 08:37:43 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Tue, 24 Jul 2007 08:37:43 -0700 (PDT)
In-Reply-To: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53610>

On 7/24/07, Patrick Doyle <wpdster@gmail.com> wrote:
> 2) When I don't fork a branch,

this is a confusing sentence: "fork" does not happen as
an explicit operation (if at all). You just commit somewhere
and depending on how you look at the history you either
see or not see a "fork".

> ... and I don't commit until I've completed
> the particular feature I'm working on, I can get a fairly good idea of
> where I am and what I was doing last (which might be 5-7 days ago,
> given high priority interrupts on other projects, summer vacations,
> etc...) just by running a "git status".  I see that there are 7 new
> files, and 2 modified files.  I know that, when I fork my branch, I
> can use "git diff master" to see what's different between my branch
> and the master, but then I get the diff of all of the changes as well,
> which is too much information.  "git diff --name-only" and "git diff
> --summary" are closer, but I can't tell what's been added vs. what's
> been changed.  Any suggestions?

"git log -p ..master", or even simpler "gitk ..master"

> As an aside, is there an undocumented option to "git status" to
> produce a less verbose report of what's been changed and what's not
> checked in?  Perhaps a single line per file with a one or two letter
> indication of the status of the file followed by the name?  If not,
> would there be any violent objections to my submitting a patch to add
> such a feature?

my_status() {
  git diff --cached --name-status -r -M -C HEAD -- "$@" && \
  git diff --name-status -r -M -C -- "$@"
}

Use as: my_status [pathname-limiter].
Does not show untracked files, though.
