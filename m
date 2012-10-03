From: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
Subject: git reset respect remote repo (make git idiot proof)
Date: Wed, 03 Oct 2012 16:49:06 +0200
Message-ID: <k4hj91$4tt$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 16:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJQHr-0005x7-Az
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 16:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab2JCOui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 10:50:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:56930 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756039Ab2JCOuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 10:50:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TJQGd-0006mb-Pw
	for git@vger.kernel.org; Wed, 03 Oct 2012 16:49:43 +0200
Received: from 99.1-241-81.adsl-dyn.isp.belgacom.be ([81.241.1.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 16:49:43 +0200
Received: from ge0ffrey.spam by 99.1-241-81.adsl-dyn.isp.belgacom.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 16:49:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 99.1-241-81.adsl-dyn.isp.belgacom.be
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206903>

Suppose this case:

git clone .../blessedRepo.git
// do changes
git commit -m"bad1"
// do changes
git commit -m"bad2"
git reset --hard HEAD^4 // Why does it let me do this?

// I just "broke" my local repository, because if I continue

// do changes
git commit -m"good1"
git push origin master // fails because the history disrespects the 
remote repo's history

The following commands are ok to do (because I have 2 unpushed commits):
  git reset --hard^1
  git reset --hard^2
but these are not and should be prevented (unless forced):
  git reset --hard^3
  git reset --hard^4


Is there any way to make git idiot proof by enabling that the local repo 
should always respect the history of the remote repo (unless forced)?
Is there any way to make this a default for anyone who clones our 
blessed repo?
No one that clones our blessed repo wants to come into the situation 
above. And if they do, they can always force it.
