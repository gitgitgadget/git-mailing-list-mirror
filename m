From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Can I remove stg sync --undo ?
Date: Fri, 4 Jul 2008 04:09:18 +0200
Message-ID: <20080704020918.GA30669@diana.vm.bytemark.co.uk>
References: <20080702072524.GA26805@diana.vm.bytemark.co.uk> <b0943d9e0807031502x5f7c4babtd65511d7966c69f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 04:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEalC-0004j3-4P
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 04:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbYGDCJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 22:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbYGDCJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 22:09:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4541 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbYGDCJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 22:09:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KEaje-00081g-00; Fri, 04 Jul 2008 03:09:18 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807031502x5f7c4babtd65511d7966c69f6@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87358>

On 2008-07-03 23:02:28 +0100, Catalin Marinas wrote:

> Sorry for the delay, I've been really busy recently.

No problem.

> 2008/7/2 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > I'm preparing a patch that removes all the old --undo flags, and
> > discovered that stg sync has an --undo flag backed by
> > stack.undo_refresh().
>
> The current --undo flag restores the state of the patch before a
> successful sync. If the sync fails with a conflict and it needs a
> refresh after resolving, I think it loses the previous state of the
> patch and just restores to whatever it was before the refresh.

[...]

> The sync performs three operations - push, merge and refresh (if the
> refresh is automatic after merge, it doesn't update the backup
> information since it was done by merge).
>
> If merge fails, the refresh is manual after solving the conflicts. I
> suspect this will be recorded as a separate step for undo

Yeah, the new undo stuff will currently handle sync just like e.g.
push and pop: write one log entry when the command's all done, plus
one extra just before the conflicting push if there is one. So you can
always undo the entire command; and in case of conflicts, you also
have the option of undoing just the conflicting push. Is this enough
for sync?

> (BTW, is resolved take into account for undo?).

Hmmm, what do you mean by "resolved"?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
