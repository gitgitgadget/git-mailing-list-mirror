From: Phillip Susi <psusi@cfl.rr.com>
Subject: Release 1.4.2 build failure
Date: Tue, 10 Oct 2006 16:22:21 -0400
Message-ID: <452C00FD.1020307@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 10 22:22:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXO76-0005Ky-Me
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 22:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWJJUWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 16:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWJJUWE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 16:22:04 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:39040 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030271AbWJJUWC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 16:22:02 -0400
Received: from [10.1.1.235] ([10.1.1.235]) by iradimed.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 10 Oct 2006 16:22:16 -0400
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: git@vger.kernel.org
X-OriginalArrivalTime: 10 Oct 2006 20:22:16.0094 (UTC) FILETIME=[C71EA3E0:01C6ECA9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14744.000
X-TM-AS-Result: No--2.910500-5.000000-2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28661>

I tried to build git release 1.4.2 and it failed with the following tests:

*** t3403-rebase-skip.sh ***
*   ok 1: setup
*   ok 2: rebase with git am -3 (default)
* FAIL 3: rebase --skip with am -3

                 git reset --hard HEAD &&
                 git rebase --skip

*   ok 4: checkout skip-merge
*   ok 5: rebase with --merge
*   ok 6: rebase --skip with --merge
* FAIL 7: merge and reference trees equal
         test -z "`git-diff-tree skip-merge skip-reference`"
* failed 2 among 7 test(s)


I enabled the --verbose and --debug test options in the test script 
makefile and then got this:


*   ok 2: rebase with git am -3 (default)
* expecting success:
         git reset --hard HEAD &&
         git rebase --skip

previous dotest directory .dotest still exists but mbox given.
* FAIL 3: rebase --skip with am -3

                 git reset --hard HEAD &&
                 git rebase --skip

* expecting success: git checkout -f skip-merge
*   ok 4: checkout skip-merge
* expecting failure: git rebase --merge master
Merging HEAD with aa79649ca1fa23815a1ad3e336d9f860599556a3
Merging:
7cb7464379042fecc2968751bd55656a97d28c77 goodbye
aa79649ca1fa23815a1ad3e336d9f860599556a3 we should skip this
found 1 common ancestor(s):
b0ab61719ccd2e08f34e326172362a485540934e hello
Auto-merging hello
CONFLICT (content): Merge conflict in hello


When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase
--abort".

*   ok 5: rebase with --merge
* expecting success:
         git reset --hard HEAD &&
         git rebase --skip

Merging HEAD with 46a6fc9814012b86849bc8fc8ae2d5cc1958c3cb
Merging:
7cb7464379042fecc2968751bd55656a97d28c77 goodbye
46a6fc9814012b86849bc8fc8ae2d5cc1958c3cb this should not be skipped
found 1 common ancestor(s):
aa79649ca1fa23815a1ad3e336d9f860599556a3 we should skip this

Committed: 0002 this should not be skipped
All done.
*   ok 6: rebase --skip with --merge
* expecting success: test -z "`git-diff-tree skip-merge skip-reference`"
* FAIL 7: merge and reference trees equal
         test -z "`git-diff-tree skip-merge skip-reference`"
/tmp/buildd/git-core-1.4.2/t/../gitk: line 3: exec: wish: not found
* failed 2 among 7 test(s)


Does anyone know what this means?  I am building on Ubuntu Dapper Drake.

Please CC replies.
