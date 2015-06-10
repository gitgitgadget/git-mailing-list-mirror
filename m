From: Bob Bell <b_git@thebellsplace.com>
Subject: Using clean/smudge scripts from repository
Date: Tue, 9 Jun 2015 21:53:50 -0400
Message-ID: <20150610015349.GA5417@robin.thebellsplace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 04:17:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2VZl-0006IW-0K
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 04:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbbFJCRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 22:17:05 -0400
Received: from srv02.macroped.com ([66.85.181.99]:41846 "EHLO
	srv02.macroped.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbbFJCRC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 22:17:02 -0400
X-Greylist: delayed 1391 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2015 22:17:02 EDT
Received: from c-24-218-186-205.hsd1.nh.comcast.net ([24.218.186.205]:44392 helo=robin)
	by srv01.macroped.com with esmtpa (Exim 4.85)
	(envelope-from <b_robin_bbell_robin@thebellsplace.com>)
	id 1Z2VDC-0004A7-Uh
	for git@vger.kernel.org; Tue, 09 Jun 2015 21:53:51 -0400
Received: by robin (Postfix, from userid 1000)
	id 44F982000B7; Tue,  9 Jun 2015 21:53:50 -0400 (EDT)
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.23 (2014-03-12)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv01.macroped.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thebellsplace.com
X-Get-Message-Sender-Via: srv01.macroped.com: authenticated_id: admin@thebellsplace.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271252>

I'm setting up a clean/smudge filter for a repository.  In local testing 
it seemed to work well.  To allow for the clean/smudge scripts to be 
updated as the source changes, I put the clean/smudge scripts into the 
repository, and configured the filter in my ~/.gitconfig file to be 
simply "./filter --clean" and "./filter --smudge".

However, when cloning a fresh repository instance, that's breaking 
because a file with the filter set by .gitattributes is getting created 
BEFORE the filter script itself exists.

Playing around with things, I realized that alphabetically the filter 
script came after the filename being filtered.  So I renamed the filter 
to __filter, and that appears to have changed to order in which contents 
are created during "git clone".

Is this a proper solution, or did I just "luck out"?  Am I perhaps doing 
something foolish?

Thanks,
Bob
