From: Alexander Miseler <alexander@miseler.de>
Subject: Re: [BUG] Out of memory in Git.pm
Date: Thu, 3 Mar 2011 08:37:14 +0000 (UTC)
Message-ID: <loom.20110303T093108-235@post.gmane.org>
References: <4D6E3FB7.60600@tweerlei.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 09:50:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv4Em-0004hu-Cx
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 09:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab1CCIuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 03:50:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:48533 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756566Ab1CCIuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 03:50:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pv4EX-0004br-PA
	for git@vger.kernel.org; Thu, 03 Mar 2011 09:50:05 +0100
Received: from dslb-188-103-115-227.pools.arcor-ip.net ([188.103.115.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 09:50:05 +0100
Received: from alexander by dslb-188-103-115-227.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 09:50:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.103.115.227 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.13 (KHTML, like Gecko) Iron/9.0.600.0 Chrome/9.0.600.0 Safari/534.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168382>

Robert Wruck <wruck <at> tweerlei.de> writes:
> there seems to be a problem in Git.pm (git-1.7.4.1, sub cat_blob, line 
> 891) where the whole object is read into memory ($blob) before writing 


There already seems to be a fix for this in 
git://repo.or.cz/git/mingw/4msysgit.git but I couldn't find the commit in 
git://git.kernel.org/pub/scm/git/git.git:

Author:		Gregor Uhlenheuer (kongo2002@googlemail.com)
Author date:	13 days ago (Fri Feb 18 11:42:12 2011 +0100)
Committer:	Johannes Schindelin (johannes.schindelin@gmx.de)
Commit date:	13 days ago (Fri Feb 18 17:09:08 2011 +0100)
Commit hash:	e91fdbabfe29b6e37f1bc582316a82f7784a0275


Git.pm: Use stream-like writing in cat_blob()

This commit fixes the issue with the handling of large files causing an
'Out of memory' perl exception. Instead of reading and writing the whole
blob at once now the blob is written in small pieces.

The problem was raised and discussed in this mail to the msysGit mailing
list: http://thread.gmane.org/gmane.comp.version-control.msysgit/12080

Signed-off-by: Gregor Uhlenheuer <kongo2002@googlemail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Contained in branches: devel
Contained in no tag
