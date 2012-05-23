From: <dag@cray.com>
Subject: Re: Feature idea: git rebase --exec $CMD
Date: Wed, 23 May 2012 10:50:20 -0500
Message-ID: <nngliki3nib.fsf@transit.us.cray.com>
References: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
	<nngfwar3p9z.fsf@transit.us.cray.com> <vpqd35udhwq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Antonio Ospite <ospite@studenti.unina.it>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 23 17:50:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXDpa-0002lp-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 17:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933610Ab2EWPu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 11:50:29 -0400
Received: from exprod6og114.obsmtp.com ([64.18.1.33]:55918 "EHLO
	exprod6og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933596Ab2EWPu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 11:50:28 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob114.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT70HQM2fxYCwhGq4yTH2YTClBEhmaOka@postini.com; Wed, 23 May 2012 08:50:28 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.247.3; Wed, 23 May
 2012 10:50:23 -0500
In-Reply-To: <vpqd35udhwq.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed,
	23 May 2012 17:41:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198301>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I took that and turned it into a git-run-command subcommand.  It will
>> take an arbitrary command and run it on each revision specified by a
>> revlist.
>
> That's sensible too. The nice things with running commands in "git
> rebase" are:
>
> * It's likely to be the place where you want to run some tests. The
>   typical use-case is that you have a patch serie whose last revision
>   passes tests, and you want to check that intermediate commits also do.

Yep, I have done that many times using the above-mentioned script
(obviously not during rebase).

> * if the "exec" command fails, you're likely to be exactly in the right
>   place to fix it: fix the bug, run "git commit --amend", and "git
>   rebase --continue".

That's a good point.

> The nice thing with your approach (as I understand it) is that it
> doesn't require rewritting history, and may apply to all commits in
> non-linear history.

Exactly.  I think there is room for both.  The downside to
git-run-command (besides the name) is that it forcibly checks out
revisions in the current workarea so one has to be careful about
unstaged and/or uncommitted changes.  I could change the behavior to
checkout in some /tmp workarea or something.

                                -Dave
