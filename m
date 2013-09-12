From: John Gietzen <jgietzen@woot.com>
Subject: Converting repo from HG, `git filter-branch --prune-empty -- --all`
 is extremely slow and errors out.
Date: Thu, 12 Sep 2013 17:01:02 -0500
Message-ID: <D4C9DBA5F955904683C89B4A96DA7759EA78D60FDF@synapsemail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 13 00:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKF1t-000843-Si
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 00:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab3ILWGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 18:06:21 -0400
Received: from mail1.news.woot.com ([209.12.104.152]:6582 "EHLO
	corpmail.woot.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756002Ab3ILWGT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Sep 2013 18:06:19 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2013 18:06:19 EDT
Received: from synapsemail.synmicro.com ([192.168.1.249]) by synapsemail
 ([192.168.1.249]) with mapi; Thu, 12 Sep 2013 17:01:01 -0500
Thread-Topic: Converting repo from HG, `git filter-branch --prune-empty --
 --all` is extremely slow and errors out.
Thread-Index: Ac6wAQElNCPMCRBPShyis00RXVo5zg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234704>

Background:
Windows, git version 1.8.3.msysgit.0
bare repo, 54k commits after migration from HG
git filter-branch --prune-empty -- --all

I'm trying to clean up our repository after migrating it from HG.  I'm running the filter-branch command listed above in an effort to clean up all of garbage commits that HG required ("closing branch" commits and their ilk).

>From my past experience, "git filter-branch" is extremely quick when using simple filters, like env-filter, since it doesn't have to touch the working dir.  However, in our case each revision is taking 1-3 seconds; our entire repo will take 30 hours to clean up at this rate.  Normally, this wouldn't be a problem, except that we are getting "sh.exe couldn't start" errors after anywhere between the 5000th and 6000th rewritten commit.  Filter-branch doesn't have support for picking up where it left off, so we are entirely unable to clean up our repo. 

All that being said, I have 3 questions:
  1.  Is there anything I can do to speed up the filter-branch command? (Alternatively, is there a way I can profile git-filter-branch.sh on msysgit?)
  2.  Any idea why sh.exe would fail?
  3.  Is there a way I can resume the filter-branch command when/if it fails?  (Alternatively, is there a way I can do the filter-branch in pieces and efficiently rebase... or something?)

I have already had to modify git-filter-branch.sh myself (to support the immense number of refs we are rewriting), so I'm comfortable with that.

Any help you can offer would be appreciated.
 
Thanks in advance,
John Gietzen
