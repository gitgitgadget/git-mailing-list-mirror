From: Michal Hocko <mhocko@suse.cz>
Subject: Re: git describe --contains doesn't work properly for a commit
Date: Thu, 26 Feb 2015 15:23:14 +0100
Message-ID: <20150226142314.GC14878@dhcp22.suse.cz>
References: <20150226133534.GB14878@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 15:23:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQzLc-0003Dn-59
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 15:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbbBZOXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 09:23:17 -0500
Received: from cantor2.suse.de ([195.135.220.15]:47088 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932302AbbBZOXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 09:23:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 93BA4ADAE
	for <git@vger.kernel.org>; Thu, 26 Feb 2015 14:23:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20150226133534.GB14878@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264444>

On Thu 26-02-15 14:35:34, Michal Hocko wrote:
> Hi,
> I have just encountered an old kernel git commit:
> commit c854363e80b49dd04a4de18ebc379eb8c8806674
> Author: Dave Chinner <david@fromorbit.com>
> Date:   Sat Feb 6 12:39:36 2010 +1100
> 
>     xfs: Use delayed write for inodes rather than async V2
> [...]
 
OK, I've managed to recreate this in a simple repo with 3 commits:
$ git log --format="%H %cd"
ab0efec2b697f2f9f864bb0e2cd77308d1f04561 Thu Feb 26 15:18:36 2015 +0100
d63972e4e4e7eda0444e56739ad09bfbc476b9bd Wed Feb 26 15:18:30 2014 +0100
108a0d5972fd2e5f25b2f38cfd2fee73031ff9d3 Thu Feb 26 14:57:29 2015 +0100

The commit in the middle was ammended to have committer date in the
past.
$ git describe --contains d63972e4e4e7eda0444e56739ad09bfbc476b9bd
tag~1

but
$ git describe --contains 108a0d5972fd2e5f25b2f38cfd2fee73031ff9d3
fatal: cannot describe '108a0d5972fd2e5f25b2f38cfd2fee73031ff9d3'

I guess this is the same issue reported previously here:
http://git.661346.n2.nabble.com/git-describe-contains-fails-on-given-tree-td5448286.html

Can this be fixed somehow or it would lead to other kind of issues?
-- 
Michal Hocko
SUSE Labs
