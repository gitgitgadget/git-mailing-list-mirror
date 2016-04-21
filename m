From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase -i without altering the committer date
Date: Thu, 21 Apr 2016 09:17:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604210914420.2826@virtualbox>
References: <etPan.5717e605.4004d424.12d1@sjackman03-imac.phage.bcgsc.ca> <87ega0eyvy.fsf@linux-m68k.org> <571863CE.6090002@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Shaun Jackman <sjackman@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 09:17:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at8re-0002q1-TB
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 09:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbcDUHRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 03:17:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:58877 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbcDUHRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 03:17:22 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ld4xA-1bbF6b1SDI-00iBVp; Thu, 21 Apr 2016 09:17:17
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <571863CE.6090002@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:V/D9sJ54iZhQEjBrSAj5RVdiPQzjNieXeJNI8+du8QDCLZJKcks
 hNUz5NDNeDR1zMFBaPqhLlc9tgQ6r/uP2u6DFx30+xa4/KGvZgaDXu98xLslQNaoZaXVWlf
 aHtvtHbcHHHBfWTQashjyiuYbUSdVGLzLpR30BT6L7IL8gQrdtWMkzfOif8RIK2077XnL2f
 /WZwCzv8hhF1vTg4GJoeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8md69wPKcFw=:AkxF6IA8RrJ+6aVOgMiSRa
 JLIg751ZUh1l2kGd8iEepHHTWuGZuSaaZszVp9iCZFc+eT/rrTNQGoQ98KkOaF7F7MnxBsuid
 AysM5aURJ6HhFlYs6f9VSvcO3pEy2t2pb6o+2mPj7xlS6MJHMV1xysBx1yvqBcSs6y/LYQ4os
 8EBvOh2gV49ghZe61GWfmzKR3PAuTopHn52kO9o28gysFvUAxr0SfT0YT/hrJtwY+kwCaFN8a
 YvSkXtUoUX+D6PWm49X4KDRI9t2SkKiuIUxq/6za6GonXSVsS+qf3pRjkPm71SUIlO1iofxap
 +jXulf7wGSc5q1i3KHV0dPKwEdjvopsIKTUrpOJfWy+z2T2/KiwTcWGdhXU8RgSFG3r0BZ0oD
 XkrQ23R/fHGY5xjsk5dUnmJaJBXsT8BWcrM8wiZ1mccWgiQUy2kiDlTypeZlFJsMFD45kJEiF
 ITVwyceomMi2ILydnoV9BvHnhPgGskf7HGuZryIpgIIHriN8xR6eDt6LJBbmNcqqbibH0q8eT
 jifIZ88nWzCRhNBzUpliv+EH/XyveeLOo/ww0CMupB649ZuexjExMG8cxN554gZ8zi6k/+sH8
 rQFxXscu7Q+LD7ObLyLd+teWQIMgT1RVjM24r4TlOf+6Mjy1yM6Ws+Gbrk9uJx5ZuGVTRyuWJ
 geHapm/26C0k32D06R3O4tYe7BovwFeeDdpkGTMvcrP6ir8FkM8h3TQSPhEuCmjEh9eEhF0d5
 fkeKbB4BSiZWyr6s2PtoKzqxzT5oHS7Qdz80ufHMxN8t7BmEPephn6l4rIQyVF+H8elQJCdv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292097>

Hi,

On Thu, 21 Apr 2016, Johannes Sixt wrote:

> Am 20.04.2016 um 23:47 schrieb Andreas Schwab:
> > Shaun Jackman <sjackman@gmail.com> writes:
> >
> > > I'd like to insert a commit between two commits without changing
> > > the committer date or author date of that commit or the subsequent
> > > commits.
> >
> > The easiest way to implement that is to add a graft to redirect the
> > parent of the second commit to the inserted commit, then use git
> > filter-branch to make the graft permanent.
> 
> This only inserts a new project state, but does not propagate the changes
> brought in by the new commit to the subsequent commits. This propagation of
> changes could also be done with filter-branch, but it may be difficult
> depending on circumstances.

I agree that rebase -i is the wrong wrench for this job. Either use
filter-branch or fast-export/edit/fast-import.

Or take a step back and ask yourself why you need to fool anybody about
the commit date... ;-D

Ciao,
Johannes
