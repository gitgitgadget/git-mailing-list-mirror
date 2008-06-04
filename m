From: Teemu Likonen <tlikonen@iki.fi>
Subject: log --graph --first-parent weirdness
Date: Wed, 4 Jun 2008 18:00:42 +0300
Message-ID: <20080604150042.GA3038@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 17:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3uUd-0005cK-NC
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 17:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYFDPAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 11:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbYFDPAq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 11:00:46 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:35271 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751911AbYFDPAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 11:00:45 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F004CE290; Wed, 4 Jun 2008 18:00:43 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K3uTi-0001cV-6h; Wed, 04 Jun 2008 18:00:42 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83787>

The output of "git log --graph --first-parent" seems weird. Maybe it's
because I don't understand everything but here's an example anyway:


$ git log --graph --pretty=oneline --abbrev-commit --decorate

M   2ba1dba... (refs/heads/master) Merge branch 'topic'
|\  
| * 432e062... (refs/heads/topic) Change from branch 'topic'
* | b762236... Change from branch 'master'
|/  
* d7fb80a... Initial commit


Normal --first-parent prints this:

$ git log --first-parent --pretty=oneline --abbrev-commit

2ba1dba... Merge branch 'topic'
b762236... Change from branch 'master'
d7fb80a... Initial commit


With --graph it goes:

$ git log --graph --first-parent --pretty=oneline --abbrev-commit

M   2ba1dba... Merge branch 'topic'
|\  
* | b762236... Change from branch 'master'
* | d7fb80a... Initial commit
 /


So, it prints the second parent line but it leads to nowhere. Try the
same with the git repository and you'll see a _lots_ of parallel branch
lines which seem to go nowhere.
