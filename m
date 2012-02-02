From: "Neal Groothuis" <ngroot@lo-cal.org>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 2 Feb 2012 10:09:36 -0500 (EST)
Message-ID: <8489.38.96.167.131.1328195376.squirrel@mail.lo-cal.org>
References: <jgdgcv$h8n$1@dough.gmane.org> <jgdn5j$v4g$1@dough.gmane.org>
    <87haz97c2k.fsf@thomas.inf.ethz.ch>
    <4F2A70DA.6020107@native-instruments.de>
    <CAFfmPPMc1V97OPHyrZp+p4YUek1c6fCncyj0s1YU9xjxQBCsDA@mail.gmail.com>
    <20120202120340.GA25190@burratino> <jgduqg$p9f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "norbert.nemec" <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Thu Feb 02 16:09:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsyI9-0005Av-3v
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 16:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab2BBPJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 10:09:36 -0500
Received: from dharma.lo-cal.org ([208.70.151.129]:50518 "EHLO
	dharma.lo-cal.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2BBPJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 10:09:36 -0500
Received: from mail.lo-cal.org (localhost [127.0.0.1])
	by dharma.lo-cal.org (Postfix) with ESMTP id 54BE32AEA83;
	Thu,  2 Feb 2012 09:09:36 -0600 (CST)
Received: from 38.96.167.131
        (SquirrelMail authenticated user ngroot)
        by mail.lo-cal.org with HTTP;
        Thu, 2 Feb 2012 10:09:36 -0500 (EST)
In-Reply-To: <jgduqg$p9f$1@dough.gmane.org>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189651>

>> See the thread [1] for a few relevant side-notes.
>  >
>  > [1] http://thread.gmane.org/gmane.comp.version-control.git/188904
>
> As I understand this thread, the user only requested all commits that
> "modify a file". Our merge-commit strictly speaking did not modify the
> file but simply kept one of the versions, completely swamping all
> modifications from one branch. Exactly the case that is still not
> covered by --full-history.

The thread was prompted by the difficulty I had in figuring out where a
co-worker had accidentally squashed changes in a branch that was being
merged in; I think that's the same issue that you have described.

Re: the merge: it kept one of the versions, but not the other; I would
consider that a change.  This is particularly problematic if you do a "git
log --full-history --simplify-merges".  The simplified history that is
presented will not show the merge, even though in the simplified history
the merge turns into a regular commit that differs from its parent.  It
seems that the history is being simplified to the point of being
inaccurate.

I believe that this is a result checking for TREESAME-ness before the
history simplification occurs, rather than after.  I would love to see
this behavior changed, or at the least, an option added to allow the user
to control it.
