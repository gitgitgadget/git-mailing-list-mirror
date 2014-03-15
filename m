From: Tim Chase <git@tim.thechases.com>
Subject: Using "-" for "previous branch" failing with rebase
Date: Sat, 15 Mar 2014 15:29:24 -0500
Message-ID: <20140315152924.26c3294e@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 22:39:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOwJC-00083l-25
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617AbaCOVjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:39:54 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:38945 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756190AbaCOVjx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2014 17:39:53 -0400
X-Greylist: delayed 4248 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Mar 2014 17:39:53 EDT
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:35192 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <git@tim.thechases.com>)
	id 1WOvCa-0005P6-P2
	for git@vger.kernel.org; Sat, 15 Mar 2014 15:29:04 -0500
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: authenticated_id: tim@thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244168>

I recently learned that there are several places where git allows use
of "-" to refer to the previous branch, e.g.

  git checkout -b dev
  # hack, hack
  git checkout master
  git merge -
  git checkout -

However, it doesn't seem to understand "-" in the context of a rebase:

  git checkout branch_a
  # hack
  git commit -a
  git checkout branch_b
  # hack
  git commit -a
  git rebase -         # I'd expect to rebase onto branch_a

but I get

  fatal: Needed a single revision
  invalid upstream -

Issuing

  git rebase branch_a

does exactly what I'd expect (as "git checkout -" puts me on
"branch_a").

Is this just an interface inconsistency or is there a some technical
reason this doesn't work (or, has it been addressed/fixed, and just
not pulled into Debian Stable's 1.7.10.4 version of git)?

Thanks,

-tkc
