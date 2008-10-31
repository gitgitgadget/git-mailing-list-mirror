From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] git-svn: change dashed git-commit-tree to git commit-tree
Date: Fri, 31 Oct 2008 00:10:25 -0400
Message-ID: <20081031041025.GB20322@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 05:11:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvlMQ-0005RV-Kf
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 05:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbYJaEKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 00:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbYJaEKd
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 00:10:33 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:14055 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYJaEKc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 00:10:32 -0400
Received: by rn-out-0910.google.com with SMTP id k40so843538rnd.17
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 21:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :sender;
        bh=rVHYfVxm1lvUpBGRIAZDqtu9pb2cJkoVc6m3rzZRv9I=;
        b=KGPmaQJc+QMczbgu29Mt4cgJspwDyECJDNXv/+eymBFAd/SkVTdu15DuIqYOJG+YZg
         FsHtcK+jyUh03X4yFK/9m0lhAb4CF6BDyqWqkgr7ClPWidG0fF+6MC+wpEubHqQkATxY
         ssK2sKFC9UmfEg6a8n/+RcMr8PGx86ieWk2VY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:sender;
        b=vncRUl1mni3MXr2+6Wq4J+/eWgvE5530dgVCEFDvit9LCT7x7j+1sB95MZRgy/VAbd
         vY2McbEljUfAHDuZag8Fw9Faizur9wvwjjdlDFNscrgt/u5njPBmh9sBHCp1rvbr8xDQ
         6UqwonlQx2rpEfJwWcEnUn/tw6rVPWSejY+z0=
Received: by 10.64.251.9 with SMTP id y9mr12440990qbh.27.1225426230858;
        Thu, 30 Oct 2008 21:10:30 -0700 (PDT)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id 12sm5284428qbw.2.2008.10.30.21.10.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Oct 2008 21:10:29 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99549>

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
Once again I'm using a copy of git-svn.perl directly, and this fails to exec.
I looked at it more closely and it fails because git binary calls setup_path,
which puts the libexec path into $PATH; of course, this doesn't happen when
git-svn is called directly.

 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2e68c68..56238da 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2202,7 +2202,7 @@ sub do_git_commit {
 	}
 	die "Tree is not a valid sha1: $tree\n" if $tree !~ /^$::sha1$/o;
 
-	my @exec = ('git-commit-tree', $tree);
+	my @exec = ('git', 'commit-tree', $tree);
 	foreach ($self->get_commit_parents($log_entry)) {
 		push @exec, '-p', $_;
 	}
-- 
1.6.0.3.515.g304f
