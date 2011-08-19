From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Subject: Re: [PATCH RFC] gitk: Allow commit editing
Date: Fri, 19 Aug 2011 14:23:39 +0200
Message-ID: <87obzlwpx0.fsf@steelpick.2x.cz>
References: <1313610971-1741-1-git-send-email-sojka@os.inf.tu-dresden.de> <20110818223346.GA8481@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, paulus@samba.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 14:33:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuOGl-00077q-5O
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 14:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab1HSMdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 08:33:46 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:56760 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153Ab1HSMdq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 08:33:46 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Aug 2011 08:33:45 EDT
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 1AE9519F32DB;
	Fri, 19 Aug 2011 14:23:43 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id il-FbEG+auCK; Fri, 19 Aug 2011 14:23:42 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id AC4A719F30E0;
	Fri, 19 Aug 2011 14:23:41 +0200 (CEST)
Received: from steelpick.2x.cz (unknown [141.76.49.12])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 3D244FA003;
	Fri, 19 Aug 2011 14:23:40 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.76)
	(envelope-from <sojka@os.inf.tu-dresden.de>)
	id 1QuO6u-0006rE-0B; Fri, 19 Aug 2011 14:23:40 +0200
In-Reply-To: <20110818223346.GA8481@sigill.intra.peff.net>
User-Agent: Notmuch/0.6.1-91-g55c2c34 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179697>

On Thu, 18 Aug 2011, Jeff King wrote:
> On Wed, Aug 17, 2011 at 09:56:11PM +0200, Michal Sojka wrote:
> 
> > Hi, this is a proof of concept patch that allows editing of commits
> > from gitk. I often review patches before pushing in gitk and if I
> > would like to have an easy way of fixing typos in commit messages etc.
> > 
> > So the patch adds "Edit this commit" item to gitk's context menu and
> > the actual editing is done by non-interactively invoking interactive
> > rebase :-) and git gui.
> 
> Invoking rebase behind the scenes makes me very nervous. In particular:
> 
>   1. There is nothing to indicate to the user that they are rewriting a
>      string of commits, which is going to wreak havoc if any of the
>      commits have been published elsewhere (either pushed somewhere, or
>      even present in another local branch). I.e., rebasing generally
>      needs to be a conscious decision of the user.

I added a warning if the edited commit is contained in a remote branch.
Would you consider this sufficient?

>   2. Even if you accept the hazard of rewriting commits, you don't pass
>      "-p" to rebase. So it will linearize your history. I don't know how
>      robust "-p" is these days, and if it's up to the challenge of
>      people using it to rebase potentially large segments of complex
>      history.

I added "-p" to rebase. I do not know about the robustness of "-p" as
well, but is anything goes wrong during the rebase, git rebase --abort
hopefully reverts everything.

> So I think your idea is sane, and if you use it appropriately (by
> editing commits in recent-ish linear stretches of history) your patch
> works fine. But I really worry that it is going to be a problem for less
> clueful users to stumble across in the menu.

See the next version of the patch in a follow-up mail.

-Michal
