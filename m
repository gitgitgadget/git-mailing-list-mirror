From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Git workflow: how to achieve?
Date: Fri, 24 Apr 2009 09:31:22 +0200
Message-ID: <20090424073122.GA9603@pengutronix.de>
References: <20090424045843.7674.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 09:33:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxFuA-0001Ue-DI
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 09:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbZDXHbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 03:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbZDXHbZ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 03:31:25 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36546 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZDXHbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 03:31:24 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LxFsa-0001nD-2w; Fri, 24 Apr 2009 09:31:24 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LxFsY-0002Yb-Io; Fri, 24 Apr 2009 09:31:22 +0200
Content-Disposition: inline
In-Reply-To: <20090424045843.7674.qmail@science.horizon.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117417>

On Fri, Apr 24, 2009 at 12:58:43AM -0400, George Spelvin wrote:
> Here's something I and my co-workers would like to achieve, but are n=
ot
> too sure how to arrange.
>=20
> I want to be committing to a feature branch, but always be compiling
> and testing a merge of that branch and several others.  (Kind of like
> linux-next.)  I want to be able to switch feature branches easily.
>=20
> For example, I may have a background project that I'm working on slow=
ly in
> between short-term fixes.  Or I want to be running the latest kernel.=
org
> kernel while my patches await approval.
>=20
> If it's just my own projects, I can just commit in random order and
> straighten things out later.  Although even that is problematic,
> as I may not remember what line of development a cleanup patch is a
> prerequisite for.  (This is something that darcs is apparently good a=
t.)
>=20
> But when I want to be testing something highly volatile like linux-ne=
xt,
> and ensuring that my work continues to merge with it cleanly, as well
> as helping others with their branches, it becomes a daily pain.
>=20
> The best attempt I have so far is to rebase a lot.  But that means th=
at
> I can't do any merging in my development branch lest the rebasing tur=
n
> into a mess.  And forcing everything to be linear makes changing bran=
ches
> a pain.  And I can't share half-finished versions with co-workers.
If you develop a topic, say gs/fix_bug_12345, optimally you should base
it on the commit introducing the bug.  Then you can have several
integrating branches, say

	next/gs/fix_bug_12345
	linus/gs/fix_bug_12345
	$company_stable/gs/fix_bug_12345

and in these branches you can regularly merge in the current state of
your gs/fix_bug_12345 branch.  You might want to take a look on topgit,
which can automate the propagation for you.

And/or you might want to look into the linux-tip scripts by Ingo
Molnar[1].
=20
> ((Another really simple feature I keep wanting is "git commit -b
> <newbranch>".  I should probably try to write a patch...))
Well currently this can be done in two commands:

	git checkout -b <newbranch>; git commit

AFAIK it even works if you already modified the index.

Best regards
Uwe

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git=
 tip:.tip

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
