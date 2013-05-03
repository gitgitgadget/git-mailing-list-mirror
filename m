From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: trouble on windows network share
Date: Fri, 3 May 2013 11:27:04 +0200
Message-ID: <87ppx8o1lj.fsf@linux-k42r.v.cablecom.net>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
	<1367529968647-7584800.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: deg <deg@degel.com>
X-From: git-owner@vger.kernel.org Fri May 03 11:27:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYCGo-0005r6-3P
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 11:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762192Ab3ECJ1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 05:27:09 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:8650 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730Ab3ECJ1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 05:27:08 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 May
 2013 11:27:02 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 3 May 2013 11:27:05 +0200
In-Reply-To: <1367529968647-7584800.post@n2.nabble.com> (deg@degel.com's
	message of "Thu, 2 May 2013 14:26:08 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223302>

deg <deg@degel.com> writes:

> I'm having this same problem.
>
> Here's one more clue that may help: The problem is dependent on the exact
> type of NAS drive.
> I moved from a Buffalo LS-X2.0, which worked fine, to a WD "My Book Live"
> (MBL), which has this problem.
>
> I don't know much more yet about why the MBL is failing, but am still poking
> around, and am happy to try tests for anyone who wants to debug this.

Can you reproduce the problem under Linux (with the NAS mounted using
CIFS), or just Windows?

If it works under Linux, you could record strace logs, e.g.

  echo foo >test.txt
  strace -f -o trace.1 git add test.txt
  strace -f -o trace.2 git commit -m test

etc.

This would massively help debugging.  Judging from the OP's log, the
filesystem is just broken and can't make up its mind about what files
exist, but in the strace log we could see exactly where it gives weird
answers (or that it doesn't, and thus get clues to any possible git
bugs).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
