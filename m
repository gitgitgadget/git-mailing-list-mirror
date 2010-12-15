From: Adam Monsen <haircut@gmail.com>
Subject: disallowing non-trivial merges on integration branches
Date: Wed, 15 Dec 2010 18:27:16 +0000 (UTC)
Message-ID: <loom.20101215T185931-347@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 15 19:27:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSw4l-0004LB-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 19:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab0LOS1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 13:27:38 -0500
Received: from lo.gmane.org ([80.91.229.12]:47962 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087Ab0LOS1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 13:27:37 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSw4a-0004ES-7O
	for git@vger.kernel.org; Wed, 15 Dec 2010 19:27:32 +0100
Received: from c-67-183-136-182.hsd1.wa.comcast.net ([67.183.136.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 19:27:32 +0100
Received: from haircut by c-67-183-136-182.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 19:27:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.183.136.182 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.55 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163788>

Does anyone have or want to help with a hook script to prevent trivial merges?

Here's some context:

I'm using the phrase "trivial merge" to refer to a merge without conflicts, 
like, when two distinct files are edited.

In the Mifos project, the "head" repo at sf.net--for all intents and purposes--
is the authoritative place to find Mifos source code. At my request, many of the 
devs pushing to "head" have started using rebase more often than merge when 
their local copy of a branch diverges from the corresponding remote[1] (for 
example, I commit to my "master", but must fetch then merge or rebase before 
pushing to origin/master). Liberal use of rebase has really cleaned up our 
version history graph... it's much easier to see what was pushed and when, and 
the progression of patches. Trivial merges just don't add anything helpful to 
the commit history graph, IMHO. Non-trivial merges are of course still allowed. 
Rebasing commits extant in the "head" repo at sf.net is disallowed.

I've been working on a hook script[2] to disallow trivial merges to further 
enforce our policy. Well, really I'm just working on the test suite[3], another 
guy (also named Adam, coincidentally) is working on the hook script.

A blocking bug with the hook script (might be a design flaw) is that it prevents 
non-trivial merges.

Wanna help fix it?

I don't understand the hook script... is it doing something that makes sense?

This was my first time writing a test harness in Bash script. Kinda fun, 
actually. Git certainly lends well to scripting, and it feels intentional. Good 
stuff.

References (links) from the above email:
1. http://article.gmane.org/gmane.comp.finance.mifos.devel/9597
2. http://stackoverflow.com/questions/4138285
3. https://gist.github.com/737842
