From: "Nate." <e4r7hbug@gmail.com>
Subject: [Patch] git-svn: support dcommit --preserve-merges
Date: Thu, 29 May 2014 01:33:05 -0500
Message-ID: <CAFRjA7iSP3+97F7yfufGOQfdrF2hSXdP9hJVAn0vn1GtyiDFHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 08:33:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wptu7-0004l7-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 08:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbaE2Gd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 02:33:27 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:50669 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004AbaE2Gd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 02:33:26 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so20709280qgd.23
        for <git@vger.kernel.org>; Wed, 28 May 2014 23:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=+ycwPxixDRLa5pyZWdxj+VndcZtQFcJ19MI+/vujpxw=;
        b=Z5e+kY3PcrVXj9kSWcA3rzd9miWjPzpWGUzaVPuOVNiHyEregRhtvJaaXFztxmvF0o
         IkFLtux2MhsVAaTFJ8E2t4KXjUis0Wk30DTE7SJynUKAKjabu5AEFsAC6w50ADv98sth
         F5lwBBXCFtnMP9MULZUjBHeRpg4+ocBwsbGvx3NeBTGqXHdvlREIJcWO0/FSnrUqJai5
         NKMYrQMRlteeSeIxbKZ35OvguDeufZHHTAzRw5dPvpaosc4sRAXUpYn3R5Q3JkrNX5Em
         9FYCFFa2L0Et/NipV3DcdflB8QaHqoETjtiIPyfNvhuar1Gr5YnZtG1tYH/xsKQsJjaJ
         9Gxg==
X-Received: by 10.224.114.145 with SMTP id e17mr6531480qaq.53.1401345205766;
 Wed, 28 May 2014 23:33:25 -0700 (PDT)
Received: by 10.140.40.175 with HTTP; Wed, 28 May 2014 23:33:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250353>

Need to update git-svn.perl to match Documentation/git-svn.txt so
--preserve-merges|p can be used in dcommit. Similar to
https://github.com/git/git/commit/b64e1f58158d1d1a8eafabbbf002a1a3c1d72929#diff-f9a64e34cbe6c3ee4f62698008a33773R571

Nate.


Documentation/git-svn.txt
 626 -m::
 627 --merge::
 628 -s<strategy>::
 629 --strategy=<strategy>::
 630 -p::
 631 --preserve-merges::
 632         These are only used with the 'dcommit' and 'rebase' commands.


diff --git a/git-svn.perl b/git-svn.perl
index 0a32372..3f981f8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -197,6 +197,7 @@ my %cmd = (
                          'no-rebase' => \$_no_rebase,
                          'mergeinfo=s' => \$_merge_info,
                          'interactive|i' => \$_interactive,
+                         'preserve-merges|p' => \$_preserve_merges,
                        %cmt_opts, %fc_opts } ],
        branch => [ \&cmd_branch,
                    'Create a branch in the SVN repository',
