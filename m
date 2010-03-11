From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: On refreshing the index
Date: Thu, 11 Mar 2010 18:19:35 +0000 (UTC)
Message-ID: <loom.20100311T191149-453@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 19:20:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npmzw-0002WK-Ck
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 19:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934077Ab0CKSUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 13:20:05 -0500
Received: from lo.gmane.org ([80.91.229.12]:59268 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934005Ab0CKST6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 13:19:58 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NpmzA-00022K-Gp
	for git@vger.kernel.org; Thu, 11 Mar 2010 19:19:52 +0100
Received: from 137.204.16.59 ([137.204.16.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 19:19:52 +0100
Received: from sergio.callegari by 137.204.16.59 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 19:19:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.16.59 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100214 Ubuntu/9.10 (karmic) Firefox/3.5.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141989>

Hi,

I have recently received instructions on how to refresh the index...
However, it looks like I've run into a case where the refresh is not as
successful as expected...

Here it is

If I run git status, git runs filters on a couple of opendocument files for
which a filter is defined

GIT_TRACE=1 git status
trace: built-in: git 'status'
trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
# On branch M05
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       WIP/
#       program.txt
#       program.txt~
nothing added to commit but untracked files present (use "git add" to track)

 ... but there is actually nothing new...
 so I try to update the index

GIT_TRACE=1 git update-index --refresh
trace: built-in: git 'update-index' '--refresh'
trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'

Is now status any faster?

GIT_TRACE=1 git status
trace: built-in: git 'status'
trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
# On branch M05
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       WIP/
#       program.txt
#       program.txt~
nothing added to commit but untracked files present (use "git add" to track)

No, the filters are run all the same...
What about git diff?

GIT_TRACE=1 git diff
trace: built-in: git 'diff'
trace: run_command: 'less'
trace: exec: 'less'
trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'

... really there is no change ...
But git keeps running the filters on these two files (note that there are other
OO files in the repo, and with the others, the filters are not run).

This happened on 1.7.0.2 after switching branches.

Sergio
