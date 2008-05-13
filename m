From: SungHyun Nam <goweol@gmail.com>
Subject: Re: git pull/merge master on other branch
Date: Tue, 13 May 2008 11:22:55 +0900
Message-ID: <4828FB7F.3030907@gmail.com>
References: <g00nb3$dlm$1@ger.gmane.org> <200805090824.12772.johan@herland.net> <8C649BDA-41CA-4105-86C5-103B4A8BEEC1@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 04:23:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvkBK-0001Vz-9u
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 04:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbYEMCXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 22:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbYEMCXH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 22:23:07 -0400
Received: from main.gmane.org ([80.91.229.2]:46045 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756279AbYEMCXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 22:23:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JvkAQ-00038e-5p
	for git@vger.kernel.org; Tue, 13 May 2008 02:23:03 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 May 2008 02:23:02 +0000
Received: from goweol by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 May 2008 02:23:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <8C649BDA-41CA-4105-86C5-103B4A8BEEC1@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81981>

Kevin Ballard wrote, at 5/10/2008 2:16 AM:
 > On May 9, 2008, at 1:24 AM, Johan Herland wrote:
 >
 >> On Friday 09 May 2008, SungHyun Nam wrote:
 >>> Hello,
 >>>
 >>> If I am on a branch (reguarly rebased), I don't want to switch to
 >>> master branch, but merge origin into master.
 >>> If I switch to master and pull and switch to branch, I have to
 >>> rebuild almost of sources.
 >>>
 >>> How I can pull origin into master without switching to master
 >>> branch?
 >>
 >> You can't; merging requires use of the working tree (to resolve
 >> conflicts).
 >>
 >> However, what you can do is make a local clone of your project (cheap,
 >> because it just hardlinks files from the original repo), and 
checkout the
 >> master branch in the clone, perform the merge (after having set up the
 >> same
 >> origin and retrieved its contents), and then fetch (or push) the
 >> result back
 >> into the original repo (remember: "fetch" instead of "pull", since the
 >> latter will initiate a merge with your current branch).
 >
 >
 > If you know the pull will just be a fast-foward, then you can do
 > something like
 >
 >   git fetch origin && git update-ref master origin/master

It seems it worked, but I see a warning message "refname 'master'
is ambiguous." Can I fix this warning message?

[test] ~/tmp/t[52]$ git fetch origin
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From /d/user/namsh/tmp/repo/
    6e13bb5..8d1c620  master     -> origin/master
[test] ~/tmp/t[53]$ git update-ref master origin/master
[test] ~/tmp/t[69]$ git log master
warning: refname 'master' is ambiguous.
commit a358783b78facffb9a8f69d2189aa716495d95ba
..

[test] ~/tmp/t[54]$ git rebase master
warning: refname 'master' is ambiguous.
warning: refname 'master' is ambiguous.
First, rewinding head to replay your work on top of it...
Fast-forwarded test to master.

regards,
namsh
