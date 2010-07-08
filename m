From: Peter Krefting <peter@softwolves.pp.se>
Subject: Rebasing a merged branch
Date: Thu, 8 Jul 2010 12:52:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1007081247410.18908@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 13:52:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWpeR-0007KV-C5
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab0GHLwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:52:14 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:39254 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756006Ab0GHLwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 07:52:10 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o68Bq8T3022833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 8 Jul 2010 13:52:08 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o68Bq8NP022829;
	Thu, 8 Jul 2010 13:52:08 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 08 Jul 2010 13:52:08 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150566>

Hi!

If I slightly modify the example from the git-rebase manual page to look 
like this:

   o---o---o---o  master
          \
           o---o---o---o---o  topicA
            \     /
             A---B---C---D  topicB

(topicA has merged "B" into its history; its first-parent from the line of 
"o"s).

If I now do a "git rebase --onto master topicA topicB", I only get commit C 
and D, as it sees A and B as being part of both branches.

Is there a way to make git rebase pick up A, B, C and D (and only them)?

I.e., I would like "all commits on topicB which are not in topicA's 
--first-parent history".



I eventually came up with

   git rebase --onto master $(git rev-list topicA ^topicB | tail -1) topicB

but am thinking that it ought to be expressable in a simpler way?

-- 
\\// Peter - http://www.softwolves.pp.se/
