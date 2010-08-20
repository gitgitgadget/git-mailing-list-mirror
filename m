From: Stephen Bash <bash@genarts.com>
Subject: Tags, Grafts, and Clones, oh my!
Date: Thu, 19 Aug 2010 20:54:29 -0400 (EDT)
Message-ID: <15347445.117294.1282265669453.JavaMail.root@mail.hq.genarts.com>
References: <29380346.117285.1282264933599.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 02:54:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmFsY-00086Q-Pn
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 02:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab0HTAyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 20:54:38 -0400
Received: from hq.genarts.com ([173.9.65.1]:8627 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750898Ab0HTAyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 20:54:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id A17581E26344
	for <git@vger.kernel.org>; Thu, 19 Aug 2010 20:54:35 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XT895qtSEZ3G for <git@vger.kernel.org>;
	Thu, 19 Aug 2010 20:54:29 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8A8A11E262F3
	for <git@vger.kernel.org>; Thu, 19 Aug 2010 20:54:29 -0400 (EDT)
In-Reply-To: <29380346.117285.1282264933599.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153967>

Hi all-

I'm currently working on migrating my company's SVN repository to git.  Based on a conversation with Ram at the beginning of the summer, I'm using svn-fe plus a couple of my own scripts.  To create the git branches and tags from the svn-fe generated repo I clone a bunch of "mini-repos", which I subdirectory-filter, then git fetch the branches/tags from the mini-repos into a "fusion" repo where I graft everything back together, and finally one last filter-branch to permanently commit the grafts.

Unfortunately I'm running into a problem with cloning the resulting repository.  Any git tags that are not associated with a live branch are declared invalid:

   error: refs/tags/tagFoo does not point to a valid object!

I've now reproduced this issue in micro (much easier to work with than the 20k commits in the real repo), and it does go away if I git checkout -b branchFoo tagFoo before cloning the repository.  I've examined the source repository, and the tag appears valid to me, as does the commit it points to.  The first error I see is during the clone.

Does this situation make sense to anyone?  If it's a potential bug (rather than user error), I can submit my testcase.  I'm currently working with git 1.7.2.1 on MacOS 10.6.4.

Any ideas will be greatly appreciated!

Thanks,
Stephen
