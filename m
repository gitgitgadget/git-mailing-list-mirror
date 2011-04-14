From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Interdiff between amended commits
Date: Thu, 14 Apr 2011 10:09:06 +0200
Message-ID: <1jzpkig.1g2zjmtgv7a68M%lists@haller-berlin.de>
References: <4DA69D7F.5050304@drmicha.warpmail.net>
Cc: git@vger.kernel.org
To: git@drmicha.warpmail.net (Michael J Gruber)
X-From: git-owner@vger.kernel.org Thu Apr 14 10:09:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAHc7-00080g-PX
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 10:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019Ab1DNIJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 04:09:13 -0400
Received: from mail.ableton.net ([62.96.12.117]:51676 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab1DNIJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 04:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=bccFjSPPv6MRQ2G+ah+Ko9r9nHJSRTAugjOfUEH81mw=;
	b=idRN135TQ8nEL+GZpA3/oySCrlxi1JES4BC/k3VKRrM/zEnAMXFwtFa2tcMZjAB4wtKPylcJnY1E8uE3vthRFvxpGEVbEWyW88IvOvEVwgb7+hJ8iYQvbbvbXgkD/t7Btl0UwFWC+pEZrNyEBLTpXxquYLf8y/rHScQ/exZfZ88=;
Received: from [10.1.15.249]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1QAHbu-0005TU-8k; Thu, 14 Apr 2011 10:09:06 +0200
In-Reply-To: <4DA69D7F.5050304@drmicha.warpmail.net>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.7 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171508>

Michael J Gruber <git@drmicha.warpmail.net> wrote:

> > So one thing I came up with is this:
> > 
> >   git checkout commit1^
> >   git cherry-pick --no-commit commit2
> >   git diff --cached
> 
> That does something completely different. It compares the tree of
> commit1^ with the tree of (commit1^ with commit2's patch applied). I
> don't see how commit1's patch plays any role here.

Sorry, that was just a typo.  I meant

  git diff --cached commit1

as the last line, of course.

Alternatively, I could do it the other way round, by saying

  git checkout commit2^
  git cherry-pick --no-commit commit1
  git diff --cached -R commit2

That should produce the same result (except maybe for the line numbers
in the hunk headers), as long as the cherry-pick didn't have conflicts.

> Depending on what your actual use case, you may be happier with "git
> diff commit1 commit2"

No, that's not what I want (except when commit1 and commit2 have the
same parent).  This would also show the differences between the parents
of commit1 and commit2; I don't want to include those.

My actual use case is that I have a central repository that sends out
commit emails; when someone does an interactive rebase and amends a
commit in the middle of a branch, I want to match up corresponding
commits based on their subject line, and then send an email showing how
the diff for that commit changed.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
