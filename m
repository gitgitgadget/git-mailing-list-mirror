From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/7] push: introduce new push.default mode "simple"
Date: Mon, 23 Apr 2012 13:20:29 +0200
Message-ID: <vpqy5pmu22q.fsf@bauges.imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-5-git-send-email-Matthieu.Moy@imag.fr>
	<4F952FD9.90806@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 23 13:21:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMHKM-00049O-DV
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 13:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab2DWLVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 07:21:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33414 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab2DWLU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 07:20:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3NBEBlP026342
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 13:14:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SMHJm-0007uB-Ke; Mon, 23 Apr 2012 13:20:30 +0200
In-Reply-To: <4F952FD9.90806@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 23 Apr 2012 12:32:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Apr 2012 13:14:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3NBEBlP026342
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335784456.01392@dLsFe654h/IL4g8Aw27pOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196110>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I like your conservative approach to this decision.

Conservativeness is not the only argument. I originally thought we
should follow 'current' when no upstream is configured, but I changed my
mind noticing that the error message suggests "git push --set-upstream".

The question is, if the user has no upstream configured, whether we
should let him continue without configuring it, or whether it's better
to encourage him to set the upstream.

I can see senarios where people would want to push to current, and merge
from @{upstream} (e.g. push = publish, pull = get changes from another
developer). But I think most if not all senarios would benefit from
having the upstream configured (even if you never pull, the ability to
run "git log ^@{upstream}", or argumentless "git rebase -i" and the
hints in "git status" telling you how many unpushed revisions you have
are nice).

Now, I agree that "denying the push with an advice" is a bit too strong
when the goal is "encourraging to set upstream", so that's why I think
it's debatable.

> But what do people think about letting push succeed when no upstream
> is configured *provided that* there is already a branch on the remote
> server with the same name as the current branch?  I think this policy
> would cover the bulk of "safe" scenarios without adding
> dangerous/ambiguous ones.

No strong opinion. My arguments above argue in favor of rejecting this,
but I'd be fine with that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
