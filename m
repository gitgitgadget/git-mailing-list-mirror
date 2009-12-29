From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Question about 'branch -d' safety
Date: Wed, 30 Dec 2009 06:54:42 +0900
Message-ID: <20091230065442.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:55:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPk2K-00026Z-V6
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbZL2VzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbZL2VzR
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:55:17 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60537 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbZL2VzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:55:16 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id DD748157541
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 15:55:15 -0600 (CST)
Received: from 9445.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id DTYX79U1SKIJ
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 15:55:15 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=RGYg7qTpxlYiaMLJ0OCByjpq304MAgCmXOhj+vw6ZUU4y+auzPDkJaeqo1ZQSvU2SV8d9yrcNZP6k2Q5Y0yZP8hzUAYUZH8qQdP5B8bagpU5t2sZDRLkf/fs9+SSMrfbcPa5SIZjvcbo86VtXi9kdQEn8Zn8+YBcY/JA9e8RiH0=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135837>

'git branch -d other' refuses to remove 'other' branch when it isn't merged to the current branch, and it is a safety feature.

But I often work in the following way in a project with a master branch and some topic branches:

	% git checkout -b topic origin/topic
	% work work work
	% git push origin topic
	% git checkout master
	% git branch -d topic

Because 'topic' is shared with other people who work on the project, and I don't work on any particular topic all the time, I want to keep my local branches small by removing unused branches. As you can guess, after checking out the master branch, the safety of "branch -d" is based on a wrong commit (namely, 'master', that is often behind 'topic') and deletion is refused.

I think the safety feature should check if the branch to be deleted is merged to the remote tracking branch it was forked from, instead of checking the current branch.

What do you think?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
