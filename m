From: lists@haller-berlin.de (Stefan Haller)
Subject: pre-commit hook not run on conflict resolution during rebase
Date: Thu, 28 May 2015 21:38:02 +0200
Message-ID: <1m55i3m.1fum4zo1fpnhncM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 21:43:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy3hv-0004bt-K8
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 21:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbbE1TnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 15:43:07 -0400
Received: from server90.greatnet.de ([178.254.50.90]:54704 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbbE1TnF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 15:43:05 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2015 15:43:05 EDT
Received: from [192.168.42.152] (dslb-178-000-061-065.178.000.pools.vodafone-ip.de [178.0.61.65])
	by server90.greatnet.de (Postfix) with ESMTPA id 4121B60044
	for <git@vger.kernel.org>; Thu, 28 May 2015 21:38:02 +0200 (CEST)
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.10.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270186>

When a rebase stops because of a conflict, and I edit the file to
resolve the conflict and say "git rebase --continue", then the
pre-commit hook doesn't run at that point, which means that I can commit
bad stuff which the pre-commit hook would normally not allow in. We were
bitten by this a few times already. (In our case, the hook rejects code
that hasn't been run through clang-format. That's easy to forget when
resolving conflicts during a rebase.)

>From glancing through the githooks manpage, I couldn't see any other
hook that would help in this situation. Am I missing something?

I guess the next best solution would be to also have a pre-push hook
that performs the same checks again, just in case the bad code managed
to get past the pre-commit hook for some reason or other. This feels
very redundant, but I guess it would work well.

Any other suggestions?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
 
