From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD] Line spacing in git log for merge commits with --oneline
Date: Thu, 24 Feb 2011 10:41:44 +0100
Message-ID: <4D6627D8.2030208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 24 10:45:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsXl3-0001E1-DW
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 10:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115Ab1BXJpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 04:45:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51518 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756047Ab1BXJpC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 04:45:02 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8990C208D2
	for <git@vger.kernel.org>; Thu, 24 Feb 2011 04:45:01 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 24 Feb 2011 04:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=TnSVELS38GIEyk8ldxCEzjHI3Hs=; b=f2KHKaMGY+44nDNq8SmrGK9coDrsw0jgSsZjXsgkzrU0PwDpKLtVNftaTW+hUsZCwyvs2rRlKkiPRqC4rIZEpRy4Jq1eeAebbAofhcD9kuXpO8Qn6kUQeLWl6yVhCpFq+FJ+31elMg5AaRtX2qWFZQD3GrGWQ8qACWFxnSIIxPM=
X-Sasl-enc: k2YkxXp0GETAzzFGhyfNWfd5SvgafBvVWzk4uCP/Sfte 1298540701
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CB73E441BF2
	for <git@vger.kernel.org>; Thu, 24 Feb 2011 04:45:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167787>

Currently, displaying, say, origin/next@{1}..origin/next with
git log --graph --abbrev-commit --oneline
produces something like:

*   426d48d Merge branch 'lp/config-vername-check' into next
|\
| * 2169ddc Disallow empty section and variable names
| * b09c53a Sanity-check config variable names
*   58b03b1 Merge branch 'jc/grep--no-index-pathspec-fix' into next
|\
| * 9d8b831 grep --no-index: honor pathspecs correctly
*   b5c25fa Merge branch 'jh/push-default-upstream-configname' into next
|\
| * 53c4031 push.default: Rename 'tracking' to 'upstream'
...

What bothers me is that visually, the description at the merge points
sticks to the commits above (look at 58b03b1,b5c25fa), whereas logically
it belongs to the block below.

Now, I don't know what the best solution would be that doesn't bother
anyone else. (Also, I have no clue about the --graph code.) Maybe there
is one already that I don't know of? Also, I haven't looked at fork
points. I'm putting two fake solutions below.

Michael

Extra lines before each merge (needs more space):

*   426d48d Merge branch 'lp/config-vername-check' into next
|\
| * 2169ddc Disallow empty section and variable names
| * b09c53a Sanity-check config variable names
|
*   58b03b1 Merge branch 'jc/grep--no-index-pathspec-fix' into next
|\
| * 9d8b831 grep --no-index: honor pathspecs correctly
|
*   b5c25fa Merge branch 'jh/push-default-upstream-configname' into next
|\
| * 53c4031 push.default: Rename 'tracking' to 'upstream'
...

Denser display (may break with "%w(..)" and what not?):

*\  426d48d Merge branch 'lp/config-vername-check' into next
| * 2169ddc Disallow empty section and variable names
| * b09c53a Sanity-check config variable names
*\  58b03b1 Merge branch 'jc/grep--no-index-pathspec-fix' into next
| * 9d8b831 grep --no-index: honor pathspecs correctly
*\  b5c25fa Merge branch 'jh/push-default-upstream-configname' into next
| * 53c4031 push.default: Rename 'tracking' to 'upstream'
...

*\
| * is suboptimal, maybe there are better solutions, like

*
|`*

and/or marking a merge commit with '+'.
