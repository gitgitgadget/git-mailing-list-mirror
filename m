From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Fri, 3 Mar 2006 15:24:13 +0100
Message-ID: <20060303142413.GB16456@diana.vm.bytemark.co.uk>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk> <44037A5C.6080409@gmail.com> <b0943d9e0602281445w7160d915y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Mar 03 15:24:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFBCk-0004h0-0O
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 15:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWCCOYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Mar 2006 09:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWCCOYO
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 09:24:14 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:48394 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751187AbWCCOYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 09:24:14 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FFBCX-0004N3-00
	for <git@vger.kernel.org>; Fri, 03 Mar 2006 14:24:13 +0000
To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b0943d9e0602281445w7160d915y@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17154>

On 2006-02-28 22:45:56 +0000, Catalin Marinas wrote:

> On 27/02/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
>
> > An idea (untested, I don't even know whether it's feasible) would
> > be to check which patches were merged by reverse-applying them
> > starting with the last. In this situation, all the merged patches
> > should just revert their changes. You only need to do a git-diff
> > between the bottom and the top of the patch and git-apply the
> > output (maybe without even modifying the tree). If this operation
> > succeeds, the patch was integrated and you don't even need to push
> > it.
>
> I attached another patch that should work properly. It also pushes
> empty patches on the stack if they were merged upstream (a 'stg
> clean' is required to remove them). This is useful for the push
> --undo command if you are not happy with the result.
>
> I'll try this patch for a bit more before pushing into the
> repository.

It appears to work for me. I still had to fix things up manually when
pulling the uncommit patch though, since you had made a minor change
in "uncommit.py":

  Pushing patch "uncommit"...Error: File "stgit/commands/uncommit.py" a=
dded in branches but different

Is there a way to make stgit not fall on its face when faced with this
situation? Surely it ought to be possible to create a merged file with
conflict markers? (I realize this is harder when there is no common
ancestor, but these files are 95% identical!)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
