From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just
 a   branch
Date: Tue, 13 Oct 2009 08:39:56 +0200
Message-ID: <4AD420BC.5060506@viscovery.net>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vr5t8coex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 08:41:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxb4a-0002Fr-0B
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 08:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936AbZJMGki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 02:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758922AbZJMGki
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 02:40:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52569 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbZJMGkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 02:40:37 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mxb37-0004fZ-7c; Tue, 13 Oct 2009 08:39:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 011759614; Tue, 13 Oct 2009 08:39:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vr5t8coex.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130130>

Junio C Hamano schrieb:
> I even think that the support for an explicit branch name in the reset
> subcommand should eventually be deprecated, perhaps unless it matches what
> is stored in BISECT_START.

Goodness, NO!

> The documentation, does not even talk about what the optional <branch>
> argument is good for, even though it lists the optional <branch> in the
> synopsis section.

If I had know about this feature (yes, FEATURE), I would have used it like
this in the past:

  $ git branch tmp
  $ git bisect reset tmp
  $ git branch -d tmp

With the patch proposed by Anders this shortens to:

  $ git bisect reset HEAD

> Having said all that, four years and two months are looooooong time in git
> timescale, and I am discounting, without any evidence to judge either way,
> the possibility that people may have learned during that time to (ab)use
> this as a (very useful?) shortcut to finish the current bisection and
> switch to some entirely different branch.

In all the bisect runs that I have done in my live, the ONLY way I wanted
'bisect reset' to act was to NOT change the commit it currently was on.
The fact that it switched back to the commit or branch that the bisect was
started on, was always a major inconvenience.

So, I have no problem if you want to deprecate the branch parameter, if at
the same time bisect reset no longer switches to some other commit. ;)

> I offhand do not see a good rationale for such a shortcut to finish bisect
> and switch to another branch (IOW, I understand "it is shorter to type",
> but I do not see "it is often done and very useful"), but I am open to be
> enlightened by a workflow where such a shortcut is useful.

In my workflow, after I've found the bad commit, I always want bisect to
stay at the commit that it found. I don't want it to warp me somewhere
else; I want to make the decision where to go next myself.

-- Hannes
