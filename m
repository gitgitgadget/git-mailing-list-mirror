From: Ian Stevens <iancstevens@gmail.com>
Subject: Can I recover lost commits in a SVN repository using a local tracking 
	git-svn branch?
Date: Mon, 26 Apr 2010 07:09:55 -0700 (PDT)
Message-ID: <904c3ddb-a565-4514-9f5e-83b3706b9fec@t36g2000yqt.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 16:20:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6PAN-0001ty-0w
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 16:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab0DZOT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 10:19:58 -0400
Received: from mail-yw0-f160.google.com ([209.85.211.160]:55367 "EHLO
	mail-yw0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab0DZOT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 10:19:57 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Apr 2010 10:19:57 EDT
Received: by ywh32 with SMTP id 32so10407330ywh.33
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 07:19:57 -0700 (PDT)
Received: by 10.151.32.2 with SMTP id k2mr782599ybj.88.1272290995902; Mon, 26 
	Apr 2010 07:09:55 -0700 (PDT)
Received: by t36g2000yqt.googlegroups.com with HTTP; Mon, 26 Apr 2010 07:09:55 
	-0700 (PDT)
X-IP: 174.137.225.177
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-us) 
	AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145819>

A SVN repo I use git-svn to track was recently corrupted and a backup
was recovered. However, a week's worth of commits were lost in the
recovery. Is it possible to recover those lost commits using git-svn
dcommit on my local git repo? Is it sufficient to run git-svn dcommit
with the SHA1 of the last recovered commit in SVN? eg.

    > svn info http://tracked-svn/trunk | sed -n "s/Revision: //p"
    252
    > git log --grep="git-svn-id:.*@252" --format=oneline | cut -f1 -
d" "
    55bb5c9cbb5fe11a90ec2e9e1e0c7c502908cf9a
    > git svn dcommit 55bb5c9cbb5fe11a90ec2e9e1e0c7c502908cf9a
    Or will the git-svn-id need to be stripped from the intended
commits?

I tried this using --dry-run but couldn't tell whether it would try to
submit all commits:

    > git svn dcommit --verbose --dry-run
55bb5c9cbb5fe11a90ec2e9e1e0c7c502908cf9a
    Committing to http://tracked-svn/trunk ...
    dcommitted on a detached HEAD because you gave a revision
argument.
    The rewritten commit is: 55bb5c9cbb5fe11a90ec2e9e1e0c7c502908cf9a

I also tried a naive git-svn dcommit but receive this error (r285 is
the old SVN HEAD which was lost):

    > git svn dcommit
    Committing to http://tracked-svn/trunk ...
    Invalid filesystem revision number: No such revision 285 at /opt/
local/libexec/git-core/git-svn line 4346

Thanks for your help,
Ian.
