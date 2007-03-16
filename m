From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Directory in one branch, file in another = can't switch branches
Date: Fri, 16 Mar 2007 15:59:01 -0700
Message-ID: <45FB2135.10106@midwinter.com>
References: <45FB1762.7040505@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 23:59:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSLOP-0002tU-FE
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 23:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992438AbXCPW7H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 18:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992448AbXCPW7H
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 18:59:07 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54705 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992438AbXCPW7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 18:59:05 -0400
Received: (qmail 12489 invoked from network); 16 Mar 2007 22:59:03 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=unZTTTlQQzMXaywpuXekFgYs/mY8lsVmejBuewelHwFh68UbaOG6kKyPGYV5w5jj  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 16 Mar 2007 22:59:03 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <45FB1762.7040505@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42404>

Ah, I see someone else picked up on this from IRC already ("bug in 
read-tree -m on A -> A/A"). Sorry for the noise; please ignore this thread.

-Steve


Steven Grimm wrote:
> We've hit this problem with a git-svn-based repository where some 
> stuff got reorganized, but it happens in plain git too; if you have a 
> branch with a file called, say, "foo" and another branch with a file 
> called "foo/bar", you can't switch between branches even if there are 
> no uncommitted edits in either branch.
>
> To reproduce (I'm using version 1.5.0.1.74.g2470):
>
> % git init-db
> Initialized empty Git repository in .git/
> % echo "this is a test file" > testing
> % git add testing
> % git commit -a -m "initial commit on master"
> Created initial commit 1a9cb1bf3a5475f0bb05d1e7c59839ba0a388be7
> 1 files changed, 1 insertions(+), 0 deletions(-)
> create mode 100644 testing
> % git checkout -b with-dir
> Switched to a new branch "with-dir"
> % mv testing testing-
> % mkdir testing
> % mv testing- testing/datafile
> % git add testing/datafile
> % git commit -a -m "commit with subdir"      Created commit 
> cdcb2af2a8dae8a2c5c3c143cb00b4863291cc17
> 2 files changed, 1 insertions(+), 1 deletions(-)
> delete mode 100644 testing
> create mode 100644 testing/datafile
> % git checkout master
> fatal: Untracked working tree file 'testing' would be overwritten by 
> merge.
>
> You can work around it by renaming the directory, but git should 
> really blow away the directory if it doesn't contain any untracked / 
> modified files.
>
> -Steve
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
