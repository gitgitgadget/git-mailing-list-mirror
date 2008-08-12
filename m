From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: [PATCH 0/3] filter-branch --subdirectory-filter improvements
Date: Tue, 12 Aug 2008 14:11:06 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200808121411.06452.J.Wielemaker@uva.nl>
References: <7vsktara5n.fsf@gitster.siamese.dyndns.org> <cover.1218529494.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 12 14:13:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSskh-0005kt-I7
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 14:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYHLMME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 08:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYHLMMC
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 08:12:02 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:10237 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbYHLMMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 08:12:01 -0400
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 14:11:59 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <cover.1218529494.git.trast@student.ethz.ch>
Content-Disposition: inline
X-OriginalArrivalTime: 12 Aug 2008 12:11:59.0735 (UTC) FILETIME=[9F327870:01C8FC74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92088>

On Tuesday 12 August 2008 10:45:56 am Thomas Rast wrote:
> Junio C Hamano wrote:
> > Anything parked in 'pu' is a fair game for replacement later, so please
> > send a replacement series and tell me to drop the previous ones from
> > 'pu'.
>
> So let's try this one.  The first two do not depend on
> --simplify-merges.

And I can confirm that (2) is a very important fix and (3) is a necessary
step to achieve what I believe --subdirectory-filter is meant for: extract
a directory from a big project and turn it into stand-alone project.  In
this case I want:

	% filter out dir X, creating X.git
	% git rm -r X
	% git submodule add <url> X

And someone with a totally unrelated project adds X.git to his project.
That requires the history of X to become totally independent from the
original project.

This works great with Thomas' patches.

	Cheers --- Jan

P.s.	Note that this is a common problem for people moving from some
	unnamed ancient SCM system, either transferring a repository or
	simply starting the wrong way due to historical brainwashing :-)

> 1/3 is new, and extends the --subdirectory-filter test to prove the
> existence of the bug in current filter-branch.  I hope it helps
> explain the issue.
>
> 2/3 is the same as before[*] modulo changing the test to expect
> success again.
>
> The third one does depend on --simplify-merges.
>
> 3/3 introduces --simplify-merges, which improves the history that
> results from --subdirectory-filter.  It has absolutely nothing to do
> with 2/3, except that it touches the same area of code.  (You could
> s/rev-list/rev-list --simplify-merges/ in master:git-filter-branch.sh,
> and get the improved history without the bugfix.)
>
> Sorry that I dispersed the patches and v2s randomly across the thread.
>
> - Thomas
>
> [*] http://kerneltrap.org/mailarchive/git/2008/8/8/2867244
> "[PATCH v2] filter-branch: fix ref rewriting with --subdirectory-filter"
>
>
> Thomas Rast (3):
>   filter-branch: Extend test to show rewriting bug
>   filter-branch: fix ref rewriting with --subdirectory-filter
>   filter-branch: use --simplify-merges
