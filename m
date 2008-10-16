From: Junio Hamano <junio@twinsun.com>
Subject: Re: commiting while the current version is in conflict
Date: Thu, 16 Oct 2008 16:39:53 -0700
Message-ID: <7vy70of6t2.fsf@arte.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Richard Hartmann" <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 02:11:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqcw4-0001le-CQ
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 02:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbYJQAKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 20:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbYJQAKD
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 20:10:03 -0400
Received: from alcor.twinsun.com ([99.180.23.201]:41849 "EHLO
	alcor.twinsun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbYJQAKC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 20:10:02 -0400
X-Greylist: delayed 1768 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Oct 2008 20:10:02 EDT
Received: from sic.twinsun.com ([192.54.239.17])
	by alcor.twinsun.com (8.13.4/8.13.4) with ESMTP id m9GNe8rT007367;
	Thu, 16 Oct 2008 16:40:09 -0700 (PDT)
Received: from pete.twinsun.com (pete.twinsun.com [192.54.239.43])
	by sic.twinsun.com (8.11.7p3+Sun/8.11.7) with SMTP id m9GNe8I25873;
	Thu, 16 Oct 2008 16:40:08 -0700 (PDT)
Received: from arte.twinsun.com ([192.54.239.5])
 by pete.twinsun.com (SMSSMTP 4.1.0.19) with SMTP id M2008101616400814971
 ; Thu, 16 Oct 2008 16:40:08 -0700
Received: from junio by arte.twinsun.com with local (Exim 4.63)
	(envelope-from <junio@twinsun.com>)
	id 1KqcRs-00008I-62; Thu, 16 Oct 2008 16:40:08 -0700
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98438>

> Judging from the code in the pre-commit script, git does not
> keep conflict information in its metadata cache, but tries to guess
> conflicts from the file's contents/ This seems to be a strange
> thing to do, imo. What's the reason for this?

Because 

 (0) You are wrong to assume that git does not keep conflict
     information; we can tell if the index is "unmerged" to see
     if you still have unresolved conflicts;

 (1) When the index is unmerged, git-commit will stop even
     before getting to pre-commit hook, so there is no point
     for pre-commit hook to check if the index is unmerged;

 (2) pre-commit hook is a last ditch effort to help ignorant
     users who have already done "git add" without thinking and
     lost the "unmerged" state.  It has to look at and guess at
     the contents for that.
