From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Failure in t5516, tests 15 and 16
Date: Fri, 22 Jun 2007 10:50:46 -0400
Message-ID: <4FAE3A62-A0D1-4C88-8413-88F1D75A2730@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 16:51:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1kTd-0001C5-WD
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 16:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758232AbXFVOuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 10:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756680AbXFVOuv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 10:50:51 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60184 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232AbXFVOuu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 10:50:50 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 42C5D1FFC033
	for <git@vger.kernel.org>; Fri, 22 Jun 2007 14:50:49 +0000 (UTC)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50701>

Tests 15 and 16 in script "t5516-fetch-push.sh" fails with "notice:  
HEAD points to an unborn branch (master)".  Is this just bad tests or  
an actual failure?  This is with current master  
(45fd8bd32dd68ce6b14a406d0abbd6f56490131c) on OS X.

Detailed test results follow.

~~ Brian

----- 8< -----

* expecting success:

         mk_test &&
         if git show-ref --verify -q refs/tags/frotz
         then
                 git tag -d frotz
         fi &&
         git branch -f frotz master &&
         git push testrepo frotz &&
         check_push_result $the_commit heads/frotz &&
         test "$( cd testrepo && git show-ref | wc -l )" = 1

Initialized empty Git repository in .git/
notice: HEAD points to an unborn branch (master)
notice: No default references
Deleted tag frotz.
updating 'refs/heads/frotz'
   from 0000000000000000000000000000000000000000
   to   9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f
Generating pack...
Done counting 5 objects.
Deltifying 5 objects...
  100% (5/5) done
Writing 5 objects...
  100% (5/5) done
Total 5 (delta 0), reused 0 (delta 0)
Unpacking 5 objects...
  100% (5/5) done
refs/heads/frotz: 0000000000000000000000000000000000000000 ->  
9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f
notice: HEAD points to an unborn branch (master)
* FAIL 15: push with colon-less refspec (3)


                 mk_test &&
                 if git show-ref --verify -q refs/tags/frotz
                 then
                         git tag -d frotz
                 fi &&
                 git branch -f frotz master &&
                 git push testrepo frotz &&
                 check_push_result $the_commit heads/frotz &&
                 test "$( cd testrepo && git show-ref | wc -l )" = 1


* expecting success:

         mk_test &&
         if git show-ref --verify -q refs/heads/frotz
         then
                 git branch -D frotz
         fi &&
         git tag -f frotz &&
         git push testrepo frotz &&
         check_push_result $the_commit tags/frotz &&
         test "$( cd testrepo && git show-ref | wc -l )" = 1


Initialized empty Git repository in .git/
notice: HEAD points to an unborn branch (master)
notice: No default references
Deleted branch frotz.
updating 'refs/tags/frotz'
   from 0000000000000000000000000000000000000000
   to   9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f
Generating pack...
Done counting 5 objects.
Deltifying 5 objects...
  100% (5/5) done
Writing 5 objects...
  100% (5/5) done
Total 5 (delta 0), reused 0 (delta 0)
Unpacking 5 objects...
  100% (5/5) done
refs/tags/frotz: 0000000000000000000000000000000000000000 ->  
9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f
notice: HEAD points to an unborn branch (master)
* FAIL 16: push with colon-less refspec (4)


                 mk_test &&
                 if git show-ref --verify -q refs/heads/frotz
                 then
                         git branch -D frotz
                 fi &&
                 git tag -f frotz &&
                 git push testrepo frotz &&
                 check_push_result $the_commit tags/frotz &&
                 test "$( cd testrepo && git show-ref | wc -l )" = 1



* failed 2 among 16 test(s)
